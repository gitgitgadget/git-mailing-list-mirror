Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E144C6FD19
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 22:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjCHWTM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 17:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjCHWTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 17:19:09 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9C7943B3
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 14:19:07 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id d36so20080325lfv.8
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 14:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678313946;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iTx8g955kb3b25tmmwM26k0LiyVirh+TRtncVRT8AT8=;
        b=NNiF4CFbckj4T9X4OHmicrIzsBgSnym060vyyALYN7sKMh5SCcoPn1qF+pMgOvBGMB
         wP2Ao+7g952gxp6djWB3znHnn7Ci3Wb2KvmTYLUW6Qcukb5hcVeDbsa7W1GX52cyOvbA
         Wkfjf4sTyZgp3lClsCSIl1OSbb1Lq7C9dBnHMAUxIybL2Vc88rOpeYG2B8DjAvgazGYC
         gxbdoY/m7a5WS8efxYl3tiFmb0Fh7jVHwjyS/utsef8hNYNqOseIceLjuSOBzBsqeP1H
         UnIQaEDF8jKdx0/0idO8sDGPwZ43ANsB2S8FuBVoOCpKBJR6x2YFs2F/kFMyCzEH77hC
         XlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678313946;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iTx8g955kb3b25tmmwM26k0LiyVirh+TRtncVRT8AT8=;
        b=UWqN2EWkHsL/wNoKzV+LMeai12h1U6bx6AhKEWqJJtjDAvquuydYFi+esZRclK+DaU
         MDioj5qxdm4PYCnQKFLzg7wZCj4NnXW3Mctlg231Z/GIGSX0Ngzxui7EGOIZjuAnjUht
         n1y3qKfNpM8pa/DfQ2B/GTdV1Bj8Y0/3iZSMVOG1QgYYYwx1y5ocg3YppTKzZ9L3KWL3
         oGbztoPYmPWpQsOD9uNof+Rl4R/0ySf41NKhIbHJtEgoKWNcp4dxOPXcGLg/X5WCO/wh
         /nS0B9Vsw7Lw8UMFry/VfVNBfDXIvBYy48oNpX32iMXsNbDwy3cqYS43EVY7OzOME0oz
         aoZA==
X-Gm-Message-State: AO0yUKUJIMe4ifaXRTj1KopIcgu/1IRPzv1Fqa1YnIIqcvjNH+fJvkxA
        PsGNUPcDKQ3lCt5skDpZqd5UsgbCvUs=
X-Google-Smtp-Source: AK7set/2cthDqOkCVmyxvNm+RIM8q2IWLZzqh5+fqe1XyUov+3itieqaKSSO1s5Ey+YTHOnAH27wdg==
X-Received: by 2002:ac2:44a3:0:b0:4a4:68b8:f4bd with SMTP id c3-20020ac244a3000000b004a468b8f4bdmr5749299lfm.3.1678313945563;
        Wed, 08 Mar 2023 14:19:05 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q20-20020ac24a74000000b004b5831b69dcsm2466147lfp.140.2023.03.08.14.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 14:19:04 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: so/diff-merges-more (was Re: What's cooking in git.git (Feb
 2023, #01; Thu, 2))
References: <xmqqr0v7o0pp.fsf@gitster.g> <871qn5pyez.fsf@osv.gnss.ru>
        <kl6lr0v2i0gn.fsf@chooglen-macbookpro.roam.corp.google.com>
        <87wn4tej2f.fsf@osv.gnss.ru>
        <kl6lh6v43s4g.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqr0u7ku3j.fsf@gitster.g> <87wn3zqefx.fsf@osv.gnss.ru>
        <kl6lzg8pcygl.fsf@chooglen-macbookpro.roam.corp.google.com>
        <878rg8j2vg.fsf@osv.gnss.ru> <xmqqzg8ozbuh.fsf@gitster.g>
Date:   Thu, 09 Mar 2023 01:19:03 +0300
Message-ID: <87jzzqzy20.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> We are walking in rounds here. Let me try to find at least some common
>> ground. Could we try to agree on *one* of these 2 mutually exclusive
>> statements, please:
>>
>> 1. Current -m behavior is useful
>>
>> 2. Current -m behavior is useless
>>
>> To me it looks like Junio thinks 1 is the case, and you, Glen, think
>> it's 2 that is the case, ...
>
> I agree you two are going around in circles and it may be time to
> agree to disagree and move on.

I'm willing not only to disagree, but even to agree on any of these 2
options, but I can't (dis)agree on both, as they are mutually exclusive.
Yeah, it could be seen as my personal problem, but, well...

> I am not Glen but I do not think anybody is arguing "-m" that does not
> do anything by itself is useful.

I'm sorry, I still can't quite understand your position.

Do you think exact current behavior of "-m" is useful, or is it useless?

> By definition, without help with "-p", it is a no-op, so by itself, it
> cannot be useful.

No, it's not a no-op as I see it, it's just that its effect is hidden
till "-p" is specified as well, and that's the exact "current behavior"
that I'm asking about. Is it useful, or not?

Please let me remind you that at previous rounds there was the commit
that reverted my earlier "Let -m imply -p" patch, and that revert
insists lone "-m" is useful, and you accepted it, and pointed me to the
explanation there, telling me that there is pretty solid use-case for a
lone "-m".

I agreed with you at that time, and then followed with current patch
series created exactly based on that earlier agreement, that now somehow
turns back to disagreement, leaving me sad and confused.

Provided current -m behavior is indeed useful, in these series:

1. Current -m behavior is now supported by --diff-merges (as presumably
   being useful.)

2. Implying -p by -m is made an option (not to break those presumably
   valid uses.)

And now these series are to be rejected on the ground that current "-m"
behavior is useless? Then let's revert the revert?

>
> The reason why I am not enthused by your series is because changing
> behaviour of "-m" can be harmful, because "-m -p" is not the first
> choice people would make when they choose to view what a merge
> commit did.

That's your view on merge commits, but there is another view out there,
where "-m -p" is exactly the first choice, provided "-m" is configured
to give diff with respect to the first parent only. I want to have the
same convenience of saying just "log -m" as you already have with "log
-c". What's wrong about it?

I realize there is a large group here that looks at merge commits
differently, and I respect their choice to show other kinds of
information that could be derived from merges. What I can't understand
is why another view is assumed to be a second-class citizen, sorry.

Please also note that I made behavior change an option, exactly not to
harm those who doesn't need it, even though it's not clear how those who
don't use -m are to be affected anyway.

>
> Back when "-m" was invented (yes, "-p" came first before "-m"), people
> were fairly content with "git log -p" that shows only individual
> changes. After all, merges were to integrate what these individual
> changes on each side of the merged history did. And you need to be
> aware that "-c" and "--cc" did not exist, let alone "--remerge-diff",
> even as a concept.

Yep, I'm aware of all that history now, as I went over it back and forth
a few times already, trying to figure out what't the actual ground
behind desire to *keep* "-m" different from the rest of similar options,
but still found none.

[...]

> So, given that background, "-m" that came as a modifier for what
>happens (only) when "-p" was in use, is perfectly understandable. In
>hindsight, it may appear to you that it should imply "-p", and that it
>is an oversight that it does not imply it.

My point is that the story with -c, or --cc is roughly the same, and
that you yourself fixed --cc once upon a time to imply -p, so it's
especially confusing for me that you are now in opposition to similar
change to "-m".

>
> But it is more like how "git log --histogram" does not produce patch
> output.  The mental model that allows it is that "--histogram" is to
> affect the way how "-p" computes the diff---a purist in you may
> argue that it should also imply "-p", but in reality, nobody
> complained that "--histogram" does not imply "-p", probably because
> nobody sane would say "--histogram" when they do not mean to show
> diff out of "git log" anyway.

Do you then think that making -c/--cc imply "-p" was a mistake in the
first place, and you try to hold me back from doing the same mistake?

> As somebody who saw how various options were invented while they
> were added to the system, I view "-m" as an option to decide what
> "-p" does when encountered a merge commit, and do not find it any
> more odd that it is a no-op without "-p" or it does not imply "-p"
> than "--histogram" vs "-p".

It's fine to view "-m" this way, but how do you view "-c" then? If
differently, then why?

In other words, in the above sentence, among "--histogram -m -c", you
effectively group "(--histogram -m) -c" by leaving -c out of
consideration, whereas more natural grouping is rather "--histogram (-m
-c)", that'd leave --histogram out of consideration.

Overall, my point is that, provided we do care about consistency of Git
UI, it's -m and -c that are to be treated the same, and it's much less
relevant if any of them matches treatment of --histogram.

Thanks,
-- Sergey Organov
