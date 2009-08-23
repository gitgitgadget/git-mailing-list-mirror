From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: [PATCH 2/2 (v3)] reset: make the output more user-friendly.
Date: Sun, 23 Aug 2009 12:45:18 +0100
Message-ID: <3f4fd2640908230445m427175f6v209d695e7e31b303@mail.gmail.com>
References: <vpqljlipcs6.fsf@bauges.imag.fr>
	 <1250845079-30614-1-git-send-email-Matthieu.Moy@imag.fr>
	 <1250845079-30614-2-git-send-email-Matthieu.Moy@imag.fr>
	 <7v3a7k767j.fsf@alter.siamese.dyndns.org>
	 <vpq8whc8euu.fsf@bauges.imag.fr>
	 <7vmy5r1cpo.fsf@alter.siamese.dyndns.org>
	 <vpqiqgevmju.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Aug 23 13:45:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfBVo-0004q5-D9
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 13:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933504AbZHWLpT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Aug 2009 07:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933502AbZHWLpS
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 07:45:18 -0400
Received: from mail-vw0-f172.google.com ([209.85.212.172]:57882 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933499AbZHWLpR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Aug 2009 07:45:17 -0400
Received: by vws2 with SMTP id 2so1411841vws.4
        for <git@vger.kernel.org>; Sun, 23 Aug 2009 04:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=u1kYNt+Y8EQi5Wb4dB1zgz75BkI6gkwzmNvil3aIBYY=;
        b=Te8IE+0ydPNVGXWG6SmA0Z7DYPyckETnYx+vgst0x+PIFYD2G0A+FQ09OjWCtJnDOh
         ycifFpEK3HAJkLjxk+pQFdl+yBCoTpX2GtVu8mQTnbCGZ0Oslj6tGdN0oXj+YXspySUK
         ZQ8LTjeGXYZw8A3y4NFVX7d6/hB5hWb+Z7d7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=r1ZxuQ/k2faVnV508+N/P/aCncKPWahsBHWIOU5wKpeu0LZDFnb+D8YDfH+t/GLbIi
         oiQv3KTfdWDdvUJYO/n1Ca7q22QQJ2A4wRCXSpzotsxH10O97y/4U8mALjAesb9lM4nU
         gKIez3k4aEOZdr2ijplfD9oUAH4kkMprZN13k=
Received: by 10.220.78.31 with SMTP id i31mr2880924vck.107.1251027918955; Sun, 
	23 Aug 2009 04:45:18 -0700 (PDT)
In-Reply-To: <vpqiqgevmju.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126857>

2009/8/23 Matthieu Moy <Matthieu.Moy@imag.fr>:
> For example, the output of 'git status' is very nice to newbies:
>
> =A0# On branch master
> =A0# Changed but not updated:
> =A0# =A0 (use "git add <file>..." to update what will be committed)

Shouldn't this be something like: (use "git add <file>..." to add new
and modified files to be committed) -- I am saying this as "update"
can also refer to removing files, or discarding changes.

> =A0# =A0 (use "git checkout -- <file>..." to discard changes in worki=
ng directory)
> =A0#
> =A0# =A0 =A0 =A0 modified: =A0 git.c
> =A0#
> =A0no changes added to commit (use "git add" and/or "git commit -a")
>
> But out of these 8 lines, only two contain real informations, and the
> (use "git bla") are just noise to expert users.

Yes and no. Using git for quite a while now, the day-to-day operations
are second nature, but other slightly obscure commands (how exactly do
I remove a staged file?) are useful to have.

> I've been thinking of a configuration option, like "core.expertuser"
> or "ui.expertuser" that would let users disable these informative
> messages on demand. I'm not sure how good the idea is.

The "core.expertuser" option does not really say what this is doing
(should the expertuser option list the sha1's for the commits, trees
and objects it is adding?).

I would call it something like "core.interactive-help",
"core.inplace-help" or "core.inline-help", as that is what the (use
=2E..) lines are.

- Reece
