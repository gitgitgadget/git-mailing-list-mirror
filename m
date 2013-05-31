From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <kernel-hacker@bennee.com>
Subject: Re: Poor performance of git describe in big repos
Date: Fri, 31 May 2013 10:57:08 +0100
Message-ID: <CAJ-05NN8cARpPTnsCfHt3kY6gTnhZ=Vq55EzqxWBV_3ju-oczQ@mail.gmail.com>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
	<CALkWK0ndKMZRuWgdg6djqPUGxbDAqZPcv2q0qPrv_2b=1NEM5g@mail.gmail.com>
	<CAJ-05NNAeLUfyk8+NU8PmjKqfTcZ1NT_NPAk3M1QROtzsQKJ8g@mail.gmail.com>
	<87ehcoeb3t.fsf@linux-k42r.v.cablecom.net>
	<CAJ-05NOjVhb+3Cab7uQE8K3VE0Q2GhqR3FE=WzJZvSn8Djt6tw@mail.gmail.com>
	<87ip20bfq4.fsf@linux-k42r.v.cablecom.net>
	<20130530193046.GG17475@serenity.lan>
	<CAJ-05NOEuxOVy7LFp_XRa_08G-Mj0x7q+RiR=u71-iyfOXpHow@mail.gmail.com>
	<87obbr5zg3.fsf@linux-k42r.v.cablecom.net>
	<CAJ-05NOdg5TvjzEMrXaPgogU5z5W6kywZhD-82eTUmvE9Hp=Lw@mail.gmail.com>
	<87y5av4jvj.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 31 11:57:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiM5D-0006ch-Mj
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 11:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938Ab3EaJ5M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 May 2013 05:57:12 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:54118 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489Ab3EaJ5J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 May 2013 05:57:09 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo10so2640175obc.17
        for <git@vger.kernel.org>; Fri, 31 May 2013 02:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=5OxX+BgtV42a6FRG7n00cqrLXsvBjweiyRcBgVxAP4U=;
        b=mYCpq74Fw9u/A+V0+G6w1tOrWp2Fd6NagBZ7/Sr62PFLz3qhHZXgE0uX7i3AXPaQBR
         ocRewQUNBTpIw5LTiulMB1J2VvgE4sGVuRHnBQscM+x2gfKNOWVEJsXKhOrKc/cEs+fx
         2bggxxh6CHLr2BkNDiyRChDkA4B0BC3Y+2xCiBh00omD5o3vagMI4I9guQ2/8JMj5+wG
         KQdFs+QsRnbgk59Q87q6HrT+7El4HEx8oORiN7qdWeGzw+x0yJzjGhXkRqu6vANF+PAr
         6EEMtLZNrpD5qZ52a7rAvkwVynZGW73M6DuhEN+8W8bHIsfUwrUkh/DKQG+yaEmh3Dp2
         ypHQ==
X-Received: by 10.182.38.201 with SMTP id i9mr5526927obk.55.1369994228685;
 Fri, 31 May 2013 02:57:08 -0700 (PDT)
Received: by 10.76.98.137 with HTTP; Fri, 31 May 2013 02:57:08 -0700 (PDT)
In-Reply-To: <87y5av4jvj.fsf@linux-k42r.v.cablecom.net>
X-Google-Sender-Auth: t32yz4VL_ME-JUE-Ka1mwVFsQtU
X-Gm-Message-State: ALoCoQl2sxrdBSBqswv1TvCyF2ALXYETfeZ0MMVzR/y4zOIxxNpMhn+2lGLbYr7OiFuZlZYnRnL5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226086>

On 31 May 2013 09:46, Thomas Rast <trast@inf.ethz.ch> wrote:
> Alex Benn=C3=A9e <kernel-hacker@bennee.com> writes:
>
>> I think you are right. I was brave (well I assumed the tags would co=
me
>> back from the upstream repo) and ran:
>>
>> git for-each-ref | grep "refs/tags" | grep "commit" | cut -d '/' -f =
3
>> | xargs git tag -d
>
> So that deleted all unannotated tags pointing at commits, and then it
> was fast.  Curious.
>
>> However I have some big commits it seems:
>>
>> 09:37 ajb@sloy/x86_64 [work.git] >(git for-each-ref | grep ' commit'=
 |
>> cut -d\  -f1 | xargs -n1 git cat-file commit) | wc -c
>> 1147231984
>
> How many unique entries are there in that list, i.e., what does
>
>   git for-each-ref | grep ' commit' | cut -d\  -f1 | sort -u | wc -l

09:49 ajb@sloy/x86_64 [work.git] >git for-each-ref | grep ' commit' |
cut -d\  -f1 | sort -u | wc -l
1508

> say?  Perhaps you can also find the biggest commit, e.g. like so:
>
>   git for-each-ref | grep ' commit' | cut -d\  -f1 |
>   while read sha; do git cat-file commit $sha | wc -c; done |
>   sort -n

Yeah there is a range from a few hundred bytes to a large number of 3M
commits. I guess I need to identify which commits they are and remove
the tags or convert them to annotated reference tags.

> However, if that turns out to be the culprit, it's not fixable
> currently[1].  Having commits with insanely long messages is just, we=
ll,
> insane.
>
>

> [1]  unless we do a major rework of the loading infrastructure, so th=
at
> we can teach it to load only the beginning of a commit as long as we =
are
> only interested in parents and such

I'll do a bit of scripting to dig into the nature of these
uber-commits and try and work out how they cam about. I suspect they
are simply start of branch states in our broken and disparate history.

I'll get back to you once I've dug a little deeper.

>
> --
> Thomas Rast
> trast@{inf,student}.ethz.ch



--=20
Alex, homepage: http://www.bennee.com/~alex/
