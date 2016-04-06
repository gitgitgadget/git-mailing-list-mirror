From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Triangular workflows and some anecdotes from the trenches
Date: Wed, 6 Apr 2016 20:30:29 +1200
Message-ID: <CAFOYHZDx1cqwUnR9E=RQKboSfF4gWDjERvEWQA_YePZq64QarQ@mail.gmail.com>
References: <CAFOYHZARoEXkT6kVy7+wMSqUxSVVHHMV5KfhU6FON3tB6XEuMg@mail.gmail.com>
	<xmqq37qz1ypa.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 10:30:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anirH-0000V3-LP
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 10:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760655AbcDFIad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 04:30:33 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38001 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754500AbcDFIab (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 04:30:31 -0400
Received: by mail-ig0-f173.google.com with SMTP id ui10so35925682igc.1
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 01:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ncHnIAs5i1PWgBIcZlgGywZpIV95XKyXzMqONJdLe98=;
        b=fy/c+0DPd0jU2t+oTpGxVqlaN2O865NmjgMid4wnXVO9Gl3IK1uB14boVywaw8cb4R
         SpKC4BqXxTtL8HRgPPaaEkoV+K4RfIlb1rLBXPvDiuluhs7tRdKRTG6QUDNEVwx+4GO+
         n09dg6wRKX558NZAUZ1hpXnN0+Vgdjuj3hCAXLTORi5eIspKD65VZecMgyfx8toqDobf
         F7QchKN6QLpKmN4QMdYHaLGrG6nl2zRYZ0KkTMVUYUuFXD4JCLGlhK/qfTnnotO0lqH5
         qRRk5Nfjce6xTPYg6aIKtLIXshQ2Oa2LAqWk7B77vwpt9YdOpskM6q2EsJI+Rasu0kSR
         nAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ncHnIAs5i1PWgBIcZlgGywZpIV95XKyXzMqONJdLe98=;
        b=agVF+WYneqRUpCKbhsL4Sc6xpMDfSOyKrWxjcUjfSxGw/8Iw2lpWnbo4kQCtWnG+1B
         Hon+7H6Y6gv9x30isR9ycdZoqr2WO+Yi+DVmcf8+y6skj1bH+Pk1WknrsUsIDu43nR8k
         KQnVnboKSsrNC9R4hhvngsoEoVsmiEJVAsgYKF3ymM+8IUaRpv2ap+4WP4qAW2tVM8ij
         cKczKTsFLdFocp3rN1exyIR/RTY6HNobc2tcXDUZa8s2LEvD0Tq2ryx0VDOrBeKTwSZO
         V4t8i03L1ir9pIsk1dX00MWty73kX9eqWz+AymcvXxmi2FKAXThXc3zGv/YPigJz+KFY
         uxfQ==
X-Gm-Message-State: AD7BkJKe7dxuM2Bnn7xqKQUijvRKpCHi9tiHmVpyqnFu0sz/8r2Q9/H/4uI/vxOYSimoJLCaDv8LAHazA2usaQ==
X-Received: by 10.50.64.179 with SMTP id p19mr19767372igs.25.1459931429963;
 Wed, 06 Apr 2016 01:30:29 -0700 (PDT)
Received: by 10.79.110.87 with HTTP; Wed, 6 Apr 2016 01:30:29 -0700 (PDT)
In-Reply-To: <xmqq37qz1ypa.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290834>

On Wed, Apr 6, 2016 at 10:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Chris Packham <judge.packham@gmail.com> writes:
>
>> We ran into something at $dayjob the other day. The actual problem was
>> a developer ended up amending a commit that had already been pushed.
>> It happens occasionally and is usually recoverable with a simple
>> rebase and is generally a learning experience. In this particular case
>> however things were a bit more complicated.
>
> Developer ending up amending is not an issue per-se, unless the
> result is pushed back to the public.

Correct and that was when the developer in question realised he had a problem.

> However, it would be nicer if "git commit --amend", "git rebase",
> "git branch -f", and "git checkout -B" notices the situation and
> warns about what would happen.
>
>>   git config alias.amend '!git merge-base --is-ancestor HEAD
>> @{upstream} || git commit --amend'
>>
>> I'm just wondering if something more official can be added to git
>> commit --amend (and probably git rebase).
>
> A bigger problem may be how you make sure everybody sets up
> @{upstream} correctly.  You may fork your own copy of a branch from
> the target branch, start working on it, further fork other branches
> on your work to experiment different approaches, with the intention
> to later use the best one to update your first fork.
>
> At which point, the @{upstream} of the secondary branches are your
> own first branch, not the public one--which is not a problem per-se,
> because your first branch (whose @{upstream} is the remote one) is
> not yet public and you should be allowed to freely update it to
> polish it by rewriting.  But then after you push out your first
> branch as an interim snapshot to the public, you no longer want to
> rewrite the commits reachable from it.  So (to put it mildly) it
> would be quite complex to get all the corner cases right, and the
> definition of "right" would probably depend on the exact workflow.
>

I think you could still argue that if @{upstream} exists. Warn about
(or disallow) re-writing anything anything that is reachable from it.
There is still the possibility of if someone else rewinding
@{upstream} on you and I think the scenario you've highlighted is just
a case of doing it to yourself.

If you do want do want to re-write history you can still do so either
by not setting @{upstream} or setting core.IKnowWhatImDoing = 1.
