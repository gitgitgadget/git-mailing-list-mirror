From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] t5540-http-push.sh: avoid non-portable grep -P
Date: Thu, 26 Feb 2009 17:19:12 -0500
Message-ID: <76718490902261419r314f6ea4r5eb02e9b5b0c40d0@mail.gmail.com>
References: <1235677745-939-1-git-send-email-jaysoffian@gmail.com>
	 <7vwsbdq6u4.fsf@gitster.siamese.dyndns.org>
	 <76718490902261243gaebdd8an2bd75bf625556f7b@mail.gmail.com>
	 <7vmyc8rhry.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 23:20:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcoax-0006Wv-Hp
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 23:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573AbZBZWTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 17:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753464AbZBZWTP
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 17:19:15 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:5593 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645AbZBZWTO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 17:19:14 -0500
Received: by rv-out-0506.google.com with SMTP id g37so735207rvb.1
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 14:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=y4pmWKKqzY0RwQCSd7gN1UEXbYBuB9+KKChbaJuV+tU=;
        b=Ishg+OfSIOedOYiO70zPVJH0kL45vzCeZMUUDmvrYtlGn6WPzZ6195CA4IEtXacrmQ
         LO7Di+venb69zqCCsPp79MXwO4yMdT0JlqHSctOJ9eon6TBI+BbPcLImtUghNszkTJm1
         Hg9QQSQMvSdlxOWtHaBscjnd5NqBKjj1hpnIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ppoiZKna/MIby2IWwXC1ucbi2VHduIFpxiqhe7NH3CIqiuw1m5t/gT5swjDf93diEo
         sBwqopxvO4wHN8Kw0mXCNbU7g1YNi3jFZbi63yfFSIL43mtAT6UFyi0vu3i4SssjgYtO
         Wvz/PAmWzzD77qD18BUUE7G6Zj37kZidyfAF0=
Received: by 10.140.174.11 with SMTP id w11mr848514rve.83.1235686752813; Thu, 
	26 Feb 2009 14:19:12 -0800 (PST)
In-Reply-To: <7vmyc8rhry.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111604>

On Thu, Feb 26, 2009 at 4:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> So perhaps define a variable:
>
> good="\"\(PUT\|MOVE\) .*/objects/$x2/${x38}_$x40 HTTP/[.0-9]*" 20[0-9]\""
>
> and grep for it?

Hmpfh. According to my re_format man page:

Obsolete (``basic'') regular expressions differ in several respects.
`|' is an ordinary character and there is no equivalent for its
functionality.

j.
