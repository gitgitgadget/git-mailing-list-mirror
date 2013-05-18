From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Random thoughts on "upstream"
Date: Sat, 18 May 2013 17:33:30 -0500
Message-ID: <CAMP44s1Rv1zobP99z6dNKhSXgBgvWa+1-BZL-Pi1HWo3vrK6vw@mail.gmail.com>
References: <7vobca6c7r.fsf@alter.siamese.dyndns.org>
	<CAMP44s2t3+yBQMj9uSd_=3w0CgeJsHeAQM051j7Xt+SqVthvzQ@mail.gmail.com>
	<7vobca3465.fsf@alter.siamese.dyndns.org>
	<7vzjvu1jes.fsf@alter.siamese.dyndns.org>
	<CALkWK0=rHFQ14G8baYpY7gYo+Qb+5a0qOKZGBTrp6BamKC2vRg@mail.gmail.com>
	<7vk3mx1rox.fsf@alter.siamese.dyndns.org>
	<CALkWK0mLtc8dmMPOcLMez1agF1+ZMUDAUwtwmiKSxOCfyiW0Bw@mail.gmail.com>
	<7vk3mxze8v.fsf@alter.siamese.dyndns.org>
	<CALkWK0kYKZGhthdrb6-7RD_c2A7E9rscAZU3=JHM-4rYre6w=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 00:33:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdphC-0006Zf-5y
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 00:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358Ab3ERWdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 18:33:32 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:57483 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318Ab3ERWdc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 18:33:32 -0400
Received: by mail-lb0-f176.google.com with SMTP id x10so5436425lbi.21
        for <git@vger.kernel.org>; Sat, 18 May 2013 15:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=kYvf2ZdexUGYAeeemPU8LnWajyTBJOyzk88utMb0cr8=;
        b=iRDFcQFKO78aAau5yPB3lIdMAqK3qqpi+aHvUCBfiPWXA0EOX+aE26SHR3TWkfYWl0
         2W4Q8jPLmhod+gaOXJuqo7EaKpSfpmjGkkZPq9/voSKlLIWvJ3uZDldodR/i4EKKhtof
         O8ZBphqPgQGqBmeNewcA7vruYyyltIMTTI0KHryJjVyEqvKw8L+sQUmv597WxQz1QUBs
         nIyFWn6IN62ZlFW03YX6p+tLh7E6A9OEBuGG+A56iHcjpxrHHSc3zU1FG8waCJV9ZAeb
         MSoA8cM1g7NttdRhgM+xKBdrkqK/nOjHC5NcJT28hs6myKmoodLWrnES2alMq50e2Rs7
         +bvQ==
X-Received: by 10.112.163.71 with SMTP id yg7mr15524436lbb.8.1368916410258;
 Sat, 18 May 2013 15:33:30 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sat, 18 May 2013 15:33:30 -0700 (PDT)
In-Reply-To: <CALkWK0kYKZGhthdrb6-7RD_c2A7E9rscAZU3=JHM-4rYre6w=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224811>

On Sat, May 18, 2013 at 1:27 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Junio C Hamano wrote:
>> Having said that I am not sure where your "not overly fond of" comes
>> from, as I do not see a problem with branch.<name>.push.  The only
>> problem I may have with the approach would arise _only_ if we make
>> it the sole way to allow people push to different names, forcing
>> people who want to push N branches to configure it N times.  Other
>> than that, I think it is an acceptable solution to give per-branch
>> control.
>
> It doesn't strike me as being elegant at all.
>
> [branch "hot-branch"]
>     remote = ram
>     push = refs/heads/for-junio/hot-branch

s/remote/pushremote/

> 1.  I git branch -M for-each-ref and push.  Screwed.

Can't parse that.

> 2.  Let's say you give me the thumbs up to write hot-branch to origin.
>  Excitedly, I change the remote to origin.  Now I already have push
> semantics for origin (you obviously want me to write to rr/, so I can
> cooperate with others):
>
> [remote "origin"]
>     push = refs/heads/*:refs/heads/rr/*
>
> Unfortunately, it doesn't kick in unless I change branch.<name>.push.

If course it doesn't that's what you told git to do. Of course, you
could simply do:

% git branch --set-downstream-to origin/rr/for-junio/hot-branch

Or if you are going to push multiple branches and set a 'remote.<name>.push':

% git branch --unset-downstream

> I guess what I'm saying is: refspec semantics are inherent properties
> of the remote, not of the local branch.  Since there is no
> intermediate refs/remotes/* sitting between the remote and local
> branches, this is _not_ like branch.<name>.merge at all.  That is why
> I'm tiling towards remote.<name>.push: we're not giving up any
> functionality anyway; there's nothing we can't do without
> branch.<name>.push.

Yes there is, I thought you already acknowledged that:

% git branch --set-downstream-to github/fc/master
% git rebase -i @{downstream}

-- 
Felipe Contreras
