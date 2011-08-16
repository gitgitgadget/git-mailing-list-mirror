From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git diff is slow (--patience is fast)
Date: Tue, 16 Aug 2011 11:01:26 +0800
Message-ID: <CALUzUxopva0p28+OtVwy1gpfuzc9xVet7fGP4gne42n4W_8kcA@mail.gmail.com>
References: <loom.20110809T093124-847@post.gmane.org>
	<CALUzUxpOR-YZh-GKzivyKVpff9ue-t3qEoNK4wGsZZjX_a1=-A@mail.gmail.com>
	<loom.20110809T133735-979@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Tue Aug 16 05:01:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qt9uH-0006yS-RB
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 05:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423Ab1HPDB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 23:01:28 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48927 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028Ab1HPDB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 23:01:28 -0400
Received: by fxh19 with SMTP id 19so3946704fxh.19
        for <git@vger.kernel.org>; Mon, 15 Aug 2011 20:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cocZRpuaP2zq8PIXK1gDmliP20wvw6NkdBPLuWKWIlU=;
        b=B1Mu9J+vQRW7LWh8cpWwtlU4VgctnomOt+S1ePh1rCm/njdgv2keDA1zKrALcCbI+Z
         uvOp+1nRorZ65fZ34H7ybA8lixtsx2EnOaa8NngduV8yHUI0NaoTWHsaM7J3XzzsXEXx
         JGnAOXm0wR5bIKbkPdw1/64cD/xK3uuM8THFs=
Received: by 10.223.1.135 with SMTP id 7mr6450551faf.46.1313463686999; Mon, 15
 Aug 2011 20:01:26 -0700 (PDT)
Received: by 10.223.95.198 with HTTP; Mon, 15 Aug 2011 20:01:26 -0700 (PDT)
In-Reply-To: <loom.20110809T133735-979@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179400>

On Tue, Aug 9, 2011 at 7:39 PM, Marat Radchenko <marat@slonopotamus.org> wrote:
> Good idea.
>
> New steps to reproduce:
> ~ $ git clone git://slonopotamus.org/git-diff
> Cloning into git-diff...

Thanks.

I traced this to a O(n*m) spot in
xdiff/xprepare.c::xdl_classify_record(). Patch coming up.

-- 
Cheers,
Ray Chuan
