From: Robert Buck <buck.robert.j@gmail.com>
Subject: Re: [RFC/PATCH v3 4/5] Rename "crlf" attribute as "eolconv"
Date: Thu, 13 May 2010 05:58:45 -0400
Message-ID: <AANLkTimCraGNet9lCuJGmFNR5JcDRQBTz1yME6GQFo4B@mail.gmail.com>
References: <cover.1273700831.git.eyvind.bernhardsen@gmail.com>
	 <6dd7bef7811283b03b8b9dac93c9a264d007bcb0.1273700831.git.eyvind.bernhardsen@gmail.com>
	 <alpine.LFD.2.00.1005121824260.3711@i5.linux-foundation.org>
	 <AANLkTilQjSKNYq8NEabcsZc5WWF86kWMWxnTy-mShVgS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Jay Soffian <jaysoffian@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu May 13 11:59:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCVC0-0004eH-0Z
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 11:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758412Ab0EMJ6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 05:58:48 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42676 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758410Ab0EMJ6r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 05:58:47 -0400
Received: by wyb32 with SMTP id 32so738028wyb.19
        for <git@vger.kernel.org>; Thu, 13 May 2010 02:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=44xM+j8YGnK+HpIMX9ROVqMPLTUXDWnV3EWKyszmmVw=;
        b=Y25I4XeLxQvfqTVXoVGfIqWqxqx4ORt1mtOaRsF3dynKS9NlLW0smt7YViHqpl684Z
         B33iN9zkzSsS0XPLehhNj4Vv+xY89d9A04I5TZRdojlI4Qrum3x1rzIxCFRWEQv7vXwW
         n0TPljU3n0mxcYOf9ahZz9sbML85M4zw5ZR6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=gRnqrApkCVAALDMiuiCZKMi4GIFrpV614DaQFnakkeSahuhqV+7r/ZUczsm7pDdZXW
         eHpeNjALdTjRfMxX2hY0GRlTUTDu9W6TOu7ty7sRHssC6qum8ivuTBnLugTlVsprCq23
         LdCZ55k+2xp7IvOf6s7Uuddttv9XomRvsazJo=
Received: by 10.227.155.82 with SMTP id r18mr7818483wbw.193.1273744725638; 
	Thu, 13 May 2010 02:58:45 -0700 (PDT)
Received: by 10.216.7.207 with HTTP; Thu, 13 May 2010 02:58:45 -0700 (PDT)
In-Reply-To: <AANLkTilQjSKNYq8NEabcsZc5WWF86kWMWxnTy-mShVgS@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146986>

Quick question here, while people would be in the convert.c functions
when making the above changes. This question is related to detecting
whether a file is text, but the question could be spun off to a
different thread if you so wish...

Have you considered skipping the UTF8 BOM and provided that the
remaining content is considered text allow auto conversions? The check
is simple, and would cover at least 50% of latin-derived languages.
Since you have the buffer at hand, and are in the same file
(convert.c), simply check for an initial EF BB BF. This would fix some
text files created on Windows (someone had mentioned Notepad I
believe). Out of the box experience for eol and text detection for
Windows users would be improved.

Bob
