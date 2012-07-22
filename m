From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: pushing branches
Date: Sat, 21 Jul 2012 23:54:21 -0300
Message-ID: <CACnwZYcP7Ke-zyMLT8JBGt_BHS22G4cN6GYe+yauxXF6cVLZ1g@mail.gmail.com>
References: <CACnwZYdqP_ptj0++dj5NkCoKWKHiLEj+c0t7zrmNidkHsyzMgw@mail.gmail.com>
	<7vhat2toz8.fsf@alter.siamese.dyndns.org>
	<CACnwZYchBpSsvfY_-cu33dmPateNPgYaPr822Ri=Xn6=V0OOnA@mail.gmail.com>
	<CAJsNXTkH6wRgH9g4BCZVxKz9ntf0P_Y81kc+bAhcchkQM3+3Bw@mail.gmail.com>
	<CACnwZYe03VzR0=m6oCo8X6y=iiLkZXi+xQpvW9goya0roU+PFQ@mail.gmail.com>
	<CAJsNXT=-Ap0zJqK2F_3uJ7secmq7uvnSc218x+NoYdO5pLJAMg@mail.gmail.com>
	<CACnwZYdUzk74znPs4F+xz3haA3QhA9-DbR3mWWEVMfnztp-oCA@mail.gmail.com>
	<7v7gtwucx7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: PJ Weisberg <pj@irregularexpressions.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 04:54:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsmJR-0000i2-2z
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 04:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029Ab2GVCyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 22:54:23 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57318 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901Ab2GVCyW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 22:54:22 -0400
Received: by obbuo13 with SMTP id uo13so7292109obb.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 19:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4iS6XKNGL5JmWVJ48BB043eN2oRZfCeGmz1BZnsG+h4=;
        b=P3uDwSCCjLgxTdP/99lxWw48zXeMn4hmNqwzQNv3qjEExmACD90MQyQVM45X8alfzZ
         OEBMDiUlTTjHCqsD1H8GbdqoVNx2EhimPoOOFMf4vU7OXp8HNQ67IyEESJjVatFgwRh+
         PY/PlbNKqj+5HBfevJ7r67B5+9rvGXUUiJTYIchmYMM3KFRWM9zjuStY+abirJqdEozM
         2wWWuekseih2qogmo3L9N6ZM9AfTxOnyrCVADziT6UDLx/q9p3jj9QmxTFctBjtgJWXi
         wCvXwXL7tdlS1WNQgJgN+slIbdtXrFg1ZcngLP2veaRPn18jnA9BmMfaQ4o5waBx6P1P
         vRIw==
Received: by 10.182.50.68 with SMTP id a4mr8112513obo.59.1342925661564; Sat,
 21 Jul 2012 19:54:21 -0700 (PDT)
Received: by 10.182.212.67 with HTTP; Sat, 21 Jul 2012 19:54:21 -0700 (PDT)
In-Reply-To: <7v7gtwucx7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201842>

On Sat, Jul 21, 2012 at 4:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Yes.
>
>> Hence does not make sense to ask git to do "push origin master" while
>> inside feature-work branch.
>
> No.  As long as you know your master is ready and suitable to be
> published when you ask "push", the command perfectly makes sense; it
> does not matter on what branch you are on.
>
> You may say
>
>         $ git checkout master
>         ... work work work ...
>         $ make test
>         ... ahh, perfection! ...
>         $ git checkout -b feature
>         ... let's build a bit more ..
>         ... while I am having fun, let's not forget to push the
>         ... part that is already solid out
>         $ git push origin master
>
> and that is perfectly fine without "git checkout master" before
> pushing (and "git checkout feature" after to come back to what you
> were doing).
In my case it wouldn't because I do not modify my master branch, I
just fetch upstream, merge upstream/master into my local master branch
and switch to feature-work, then git push origin master will always
give me "Everything up-to-date" I suppose (that is what always happen
in my case/workflow).

And just learned, the answer to my question is, while in feature-work
branch, 'git push origin feature-work'. Which does what I wanted.
