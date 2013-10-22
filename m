From: Mandeep Sandhu <mandeepsandhu.chd@gmail.com>
Subject: Re: Moving commits from one branch to another (improving my git fu!)
Date: Tue, 22 Oct 2013 11:45:06 +0530
Message-ID: <CAC+QLdQixg1+hGy2fiiS--R1vs3A6h5eD-y-FqPFZLHZ7cK0Qg@mail.gmail.com>
References: <CAC+QLdSjTjftgUBy-1cHbATZnX-UO3PavUaLwErhCaxBa-hPmQ@mail.gmail.com>
	<CAGyf7-EDtNPhAGm21YmPSZfWmdjhKejhmoWNG3Au5LaorOodCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Users <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Tue Oct 22 08:15:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYVFO-0001kf-9N
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 08:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232Ab3JVGPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 02:15:09 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:55686 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154Ab3JVGPH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 02:15:07 -0400
Received: by mail-pa0-f51.google.com with SMTP id ld10so5670021pab.38
        for <git@vger.kernel.org>; Mon, 21 Oct 2013 23:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bQYwv2bF9mhrN55O8eLlYEo6pwU4fiBtyf5mxpiDwps=;
        b=cZNeKRTYG7pYPgrlCuA/09IJTZAb+fBklDtre2QTcmDPkXTdkBo1tVDP7F7BcgTlva
         EC6M4MRqZQBtWbtIJqBqbBmW4jz7KFc4jLaLY1BMjmtIZWBrDyfINKmPw4nVGzgv9atU
         bc2mOKQ3d8KCQp2Hs/DVneRJD1vXq9WhpXrbD8syOMeqsxwMyMSOBDy2tzyCzh46ml0J
         EO5wwRfO/nNmcT5kw6hRIM9EcIKSufnFBBE2t/zEaiEzSzKQMchn3IJeAEY9f5Jnr/d9
         jPcc8J2QCKQAGJ42KtGH2U6T5benegfqjRl/yrl8h0QVoh46dfdOrQxmDJ8tUVfxcb2r
         yaNg==
X-Received: by 10.66.163.164 with SMTP id yj4mr21975463pab.91.1382422506735;
 Mon, 21 Oct 2013 23:15:06 -0700 (PDT)
Received: by 10.66.165.233 with HTTP; Mon, 21 Oct 2013 23:15:06 -0700 (PDT)
In-Reply-To: <CAGyf7-EDtNPhAGm21YmPSZfWmdjhKejhmoWNG3Au5LaorOodCw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236459>

On Tue, Oct 22, 2013 at 11:30 AM, Bryan Turner <bturner@atlassian.com> wrote:
> A quick glance at your command line and the man page for git rebase
> suggests the problem was you didn't actually use --onto. I believe the
> correct command would be:
>
> git rebase --onto dev stable topicA

Yes, thats the cmd I gave. (missed typing onto in the mail though)
>
>
> That should start by determining which commits are one topicA but not
> stable and then checkout dev and apply those new commits.

Thats what I expected too. There are only 2 commits that were made in
topicA. So I was expecting it to pick those 2 and apply them on the
dev branch. But instead it's applying a LOT of commits on dev.
Remember that 'dev' is very different from 'stable'.

As suggested, maybe cherry-pciking is what I need to do.

Thanks,
-mandeep


>
>
> Hope this helps,
> Bryan Turner
>
> On 22 October 2013 16:38, Mandeep Sandhu <mandeepsandhu.chd@gmail.com> wrote:
>> Hi All,
>>
>> I'm in a bit of a pickle! :) So I've come to ask for help from the guru's here.
>>
>> My story is not unique but somehow the various suggested solutions
>> don't seem to work in my case.
>>
>> * I was working on a feature which was supposed to be done off our
>> 'dev' branch. But instead I forgot and branched out my topic branch
>> from master (or as we call it 'stable').
>> * I did 2 commits and finished off my work. Only later realizing that
>> it had to be done off 'dev'.
>> * Now I want to move my 2 commits (which are the top 2 commits on my
>> topic branch) to a new branch which is branched off 'dev'.
>>
>> $ git branch
>> * topicA
>> * stable
>> * dev
>>
>> topicA was based on stable. But now I want to base it dev.
>>
>> So I did what was most suggested, i.e use 'git rebase --onto'.
>>
>> Here's what I did when I was in topicA:
>>
>> $ git rebase dev stable topicA
>> (this was suggested in the manpage as well).
>>
>> This started off a massive rebase operation, because the 'dev' branch
>> is vastly diverged from stable, and a lot of conflicts started
>> appearing.
>>
>> I'm not sure if I'm doing it right here, so can anyone suggest whether
>> this is right or do I need to do it differently?
>>
>> PS: Please CC me (mandeepsandhu.chd@gmail.com) in your reply as I'm
>> not currently subscribed to the list.
>>
>> Thanks for your time.
>>
>> Regards,
>> -mandeep
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
