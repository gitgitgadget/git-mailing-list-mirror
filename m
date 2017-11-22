Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9101420954
	for <e@80x24.org>; Wed, 22 Nov 2017 19:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbdKVTYx (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 14:24:53 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:40095 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbdKVTYu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 14:24:50 -0500
Received: by mail-qt0-f175.google.com with SMTP id u42so25153951qte.7
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 11:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x4tPBbgtlVuTJcJTU5ATEj5989su7SNHvk5ugIK4X1s=;
        b=dkkTqlXpqr5dZ62es1lg4WQgOA1Ws1mS78LCPoFa9GZMsP3Wn/QKw1COkyZ6PmAG9K
         0h8VcAfJzeOLNGjfJL6BjTQ8xbGU8q2eaby3ki09z4jS4WOV9z6S3kcN62775kG7Tz3w
         KKK+JINU8YD/J+IeVDiCkau1vBkIqRde+hWtrBhjffnIHL0WjuqCEsXp5ly7IYwmXtiw
         Yi4ghrIxxL7KuormI3A3jAmaXVFKm85n0NqxT1Zx+RUSa/3n+91EIBYaoRh3+GlV37WS
         7p1b4rHeHikseWzEAxHTvxH7/CB0kGEkLFyociulNt3zfS2SKoZr6PaNw1HlkO8r8xkZ
         XfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x4tPBbgtlVuTJcJTU5ATEj5989su7SNHvk5ugIK4X1s=;
        b=Rg/DuwkhY9p71N9n+VcMv1wk8JXPuQjVoIYUqZDBP10Lruy1jgEsPXHlxFVZ4YFaJX
         u2cmlOuYHVNcKXDlYutXmFi6+GwlaJG7ygApb0DWWedpeTrExWtB/OJYZ6xlPzze6/+S
         rJ5PI9taQm/dha7tTKvisGxpoQRelJN2v+TeW6q4Lw/KEiFK6KeQUhICOC5lAmdTV8ak
         Gy2YUSIWE+pMirBe0PdHyt0bVDda85N08gVItCz/ge5xDJeJ08tvMbNvVQfyeawnkjDT
         Ljiex1x/5sqIMYEN+7epdIzUyKJqOThQjvdT2F4SHV4QnwhV6kL1k1+2RW6YOriIZV8T
         7p8w==
X-Gm-Message-State: AJaThX6cmT6KUKLFu2KW9YIeO1S5mZ0xm/arrXfTeCrz5dimh4kfLRc2
        1MZz0J5Kwqf61Ka28M/cI3TctpJbx6tnHk7428SQFA==
X-Google-Smtp-Source: AGs4zManYCMUJQNms7dqv3fre4Cx0Z9WhNPsmxuEQ7VcxXh07S6wPjcSpZVPwZk/VYr9trLY0IGqurHWapknPQp0JRY=
X-Received: by 10.200.36.105 with SMTP id d38mr32750302qtd.180.1511378689342;
 Wed, 22 Nov 2017 11:24:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Wed, 22 Nov 2017 11:24:48 -0800 (PST)
In-Reply-To: <CABPp-BFm7ZcYbie-n-ASmb6MDyJXW3G8YdtHRAzpVNgOvwK5MA@mail.gmail.com>
References: <20171121080059.32304-1-newren@gmail.com> <CAGZ79kbVzDEv=rj7X6EhWZyAFd+fq+nwG8c+raqu9tXv_z9f4A@mail.gmail.com>
 <CABPp-BFm7ZcYbie-n-ASmb6MDyJXW3G8YdtHRAzpVNgOvwK5MA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 22 Nov 2017 11:24:48 -0800
Message-ID: <CAGZ79kbustk48yP7jC6UmjidQUuWfhQWcqX_CUz=WnM0X3H8aw@mail.gmail.com>
Subject: Re: [PATCH v3 00/33] Add directory rename detection to git
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 5:12 PM, Elijah Newren <newren@gmail.com> wrote:
> On Tue, Nov 21, 2017 at 4:42 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Tue, Nov 21, 2017 at 12:00 AM, Elijah Newren <newren@gmail.com> wrote:
>>> This patchset introduces directory rename detection to merge-recursive; I'm
>>> resubmitting just a few hours after my PATCHv2 because I didn't know about
>>> the DEVELOPER=1 flag previously, and my code had a number of
>>> warnings/errors.  I would have just submitted fixup/squash patches, but
>>> when I checked, there sadly they cause merge conflicts when rebasing
>>>
>>> See https://public-inbox.org/git/20171110190550.27059-1-newren@gmail.com/
>>> for the first series, design considerations, etc, and
>>> https://public-inbox.org/git/20171120220209.15111-1-newren@gmail.com/ for
>>> v2.
>>
>> Thanks, I'll take a look!
>>
>> Protip: To make it easy for reviewers add an interdiff[1] between the different
>> versions of the patch series, this can be done via tbdiff[2] for example,
>> or in case you still have the old branch around or Junio has it queued already,
>> you can do a diff against that branch.
>
> Thanks!
>
> Interesting; tbdiff looks cool.  Junio hasn't queued this series yet,
> but it's easy enough to reconstruct the old one.  It does weigh in
> pretty heavy, and I'm slighly worried about gmail mangling all the
> lines, but I'm going to give it a shot anyway.  If it's too mangled,
> I'll try to repost using git-send-email.  It does weigh in at over
> 1600 lines, so it's not small.

In my first round of review I only looked over the tests to see if I'd
find the behavior intuitive, I spared the implementation, as Junio seemed
to have reviewed a couple patches of the v1 implementation.

Now I also looked over the implementation and quite like it, though
I'd be happy if others would also have a look.

All but one comment were minor style nits, which are no big deal;
the other remark that I was musing about was whether we want to use
strbufs in the new code instead of e.g. sprintfs to extend strings.
And I'd think we would want to use them unless there are compelling
reasons not to.

Thanks,
Stefan
