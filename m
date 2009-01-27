From: Sverre Rabbelier <alturin@gmail.com>
Subject: Re: git-am annoyance
Date: Tue, 27 Jan 2009 23:37:45 +0100
Message-ID: <bd6139dc0901271437l19f1201ch867f1a7c2045e54b@mail.gmail.com>
References: <bd6139dc0901271407i4406d5e6u6db1df9e5a7bdc4f@mail.gmail.com>
	 <7vr62o1iww.fsf@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 23:39:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRwas-00044t-5a
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 23:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755010AbZA0Wht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 17:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754634AbZA0Whs
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 17:37:48 -0500
Received: from rn-out-0910.google.com ([64.233.170.189]:56241 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbZA0Whr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 17:37:47 -0500
Received: by rn-out-0910.google.com with SMTP id k40so2337050rnd.17
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 14:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2O7o6gQX2mI1XCKll+4oMzn34bXi82PBrM/LZzVL7zA=;
        b=nUEU9Voxvx5ZUeugf2cei1k8o/yHJOciSkJs7sbSy3iAsbp0kGkM+TEspzyXZ7d2Y+
         Pfcw85ERK0WwzStmNoTPNTbiOHwZAv0xibwzerKd7Qniujp/Y8p4ROS2/SdSufojnwRJ
         hKfwgaevVezHwmT617Uk/LQhdP4+UczIf/FCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=byJsI6bBNCCe8EXhOCfh0wVtdcK85uVYgJfnMdPOxaBeTEFtC+XFWm4uhICyM1KFlM
         eAgXQrh4LvoPKv6vPmTJNTrplHPzOtTK49XZDDPuTm6Y3ab7TYITkJOSH+z6vGCwOD2a
         GHjSMalEXBTkgymWeHIoIZChJnoxVGlYmN6xI=
Received: by 10.151.48.20 with SMTP id a20mr1280044ybk.4.1233095865519; Tue, 
	27 Jan 2009 14:37:45 -0800 (PST)
In-Reply-To: <7vr62o1iww.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107408>

On Tue, Jan 27, 2009 at 23:30, Junio C Hamano <gitster@pobox.com> wrote:
> It wants to read from the stdin as "git am < mbox" is a valid usage.

Ah, ofcourse, that makes sense :).

> A patch to detect that the input was killed with ^C and clean things up
> would be welcome.  Also we may be able to detect "-t 0", too.

What is '-t 0'? How would one detect this in bash?

>> $ # ok, now what do I do?
>
> Here is one thing you could do.
>
>    $ PS1=': $(__git_ps1 "%s"); '
>    : master|AM/REBASE;
>    : master|AM/REBASE; git am --abort

Ugh, I couldn't even get that thing to work :P.

> But you are right.  We should be able to detect this.

That would be nice indeed.

> I think it was just people who often use "am" are so used to correctly the
> command that the state where no state files are created didn't happen
> often and never reported the breakage.

Ok, am glad I reported it then, now it's a known issue at least.

-- 
Cheers,

Sverre Rabbelier
