Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4159208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 20:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753593AbdHOUG4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 16:06:56 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:34294 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752983AbdHOUGu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 16:06:50 -0400
Received: by mail-yw0-f182.google.com with SMTP id s143so11122781ywg.1
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 13:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MUOtfII6+jSHcBfBJbJvtkMYJ/8Cf0B3WdDA4kbg51o=;
        b=OlOBGuoizIWjNUTwybeY36fXem8uANU2Lk8Q6AhbPjQMq40ZtbYuZCwB5w3YUXwR1Y
         OzdmdKIV4cO+qIR29JNdUtI1giMeT8hgW2+RvuCvZD9Tf84Iq9ycefKV/hGf8EPQH4eb
         nGJ7HndB5Q9BCK4KSbADTXOIxYR6KuRHLjJe9lAxckuXayUS396Utba0DXV1FkqT8rKF
         pR8JiP0cV+08bTPC+sd4thnwlY3xuXks0azODqauESxTmV1zeYoCa0qbwdr59PGq8ahE
         Q7v3sU0pWPrVwoQp52YuKa7jBYRQkLTZSbcbigyQ4ASMCWA9hP4IHGqcaGZDWgEa8m2x
         dIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MUOtfII6+jSHcBfBJbJvtkMYJ/8Cf0B3WdDA4kbg51o=;
        b=moIKrShhzEftRp8YAg2oo8QgkVLXdS3UWDXAy0yJxJgmts0FVrTeBhvSEk97q3dEp3
         ImvRS2G2AxDefM2w95R+W0XryBZfO4S7E3QEV3WXiC/o78Z8l2xbGSqo6S/2y8z1LhW9
         znrYJpDjiVA/vMbkwv3AsEekxDiQzLm1dwsACsY21gEHrKoQ4AitAUw99/AJ65B2/A58
         CO5gXObDBksDp+kpIE9f0+PS+Ncr5gh1HrgnV+6ObmVTY+/+PReDgpYtIlo8cb54K52F
         8Tvs86JNfdDQ2N6bJMRQqHXWnEBdQPsBA74QpbMLLwripBqscTDwFfge9dyN5YK1wNkQ
         JpuQ==
X-Gm-Message-State: AHYfb5gj2FpsDtoAu8tXC7EPB2d5Rj8kGug/PdYmzO9lUNeP3LlxhDpp
        +kQeAdOjitBicQC/f4HSdu5UUnYfHW4HRBYe/A==
X-Received: by 10.37.208.81 with SMTP id h78mr23366211ybg.151.1502827609967;
 Tue, 15 Aug 2017 13:06:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Tue, 15 Aug 2017 13:06:49 -0700 (PDT)
In-Reply-To: <xmqqy3qkppxt.fsf@gitster.mtv.corp.google.com>
References: <cover.1502491372.git.jonathantanmy@google.com>
 <cover.1502754962.git.jonathantanmy@google.com> <41a7ff674072559415f98b81ffde798d94aed2fc.1502754962.git.jonathantanmy@google.com>
 <xmqqy3qkppxt.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Aug 2017 13:06:49 -0700
Message-ID: <CAGZ79kahg7q2CSg7OiaLNvHKzCUgTtq2-n=Km0N+eGRuNZ=yJw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] diff: define block by number of non-space chars
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 12:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> The existing behavior of diff --color-moved=zebra does not define the
>> minimum size of a block at all, instead relying on a heuristic applied
>> later to filter out sets of adjacent moved lines that are shorter than 3
>> lines long. This can be confusing, because a block could thus be colored
>> as moved at the source but not at the destination (or vice versa),
>> depending on its neighbors.
>>
>> Instead, teach diff that the minimum size of a block is 10
>> non-whitespace characters. This allows diff to still exclude
>> uninteresting lines appearing on their own (such as those solely
>> consisting of one or a few closing braces), as was the intention of the
>> adjacent-moved-line heuristic.
>
> I recall that there is a logic backed by a similar rationale in
> blame.c::blame_entry_score() but over there we count alnum, not
> !isspace, to judge if a block has been split into too small a piece
> to be significant.  I do not know which one is better, but if there
> is no strong reason, perhaps we want to unify the two, so that we
> can improve both heuristics at the same time?

In an ideal world we would use entropy of the diffed characters as
that is a best approximation on how much "interesting" things are
going on in that particular diff.

Computing the entropy is cumbersome, but maybe ok for this
purpose (we're most likely IO bound anyway, specifically when
including the human understanding as the last part of IO).

Reasons that may influence the choice
* Non latin/ASCII characters should also work.
* Do we care about the whitespace esoteric
  programming language?

The function blame_entry_score is documented to approach
this exact problem that we are trying to solve here, so I agree
we should have a common heuristic.

Stefan
