Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD2BD1F5FB
	for <e@80x24.org>; Tue, 28 Feb 2017 01:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbdB1BBr (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 20:01:47 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:34817 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751583AbdB1BBp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 20:01:45 -0500
Received: by mail-lf0-f50.google.com with SMTP id z127so40448914lfa.2
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 17:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PIXuaKh5gwG0oz+1WfkHutv6fZr0hB/LLtJYHc+2dqY=;
        b=ikoWmTcA7c1MxGcd1r4funIrJ1ic3cWFCemUJvz2f98TmPm8Ixh3W/H5yrekqAxXE9
         5UfuLUrzeR3npIx1Kr4Lgy3TqfHEkDRVwDHO2mMsu9caPVRlFlYFEtBLXlsEUVFdlqA4
         urqJ93EkBcSBhh/I1kp+brhaiJ5v+9APqR8Oo46TXPyLfmJySSKz7/FXzMx+0hJBHN1s
         gPRuG/amVbl8QSvssCVVo5nSTnyjvJxBjRRtnLfnuenuKgMHLDilIV0La2HEMEZM+Qwa
         iRr8xxJAFc0mu1MwQf74wawmBmzxdljOb+2vzfuqCVF31ZOC9DOKv7G1kZbPYrw3Kq3q
         8iCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PIXuaKh5gwG0oz+1WfkHutv6fZr0hB/LLtJYHc+2dqY=;
        b=dzQGTA1g0GXf4/GTZ1/yFW+kJ1veIHiyE+6a2ZleVx/iYOV/G8ulQWf++76EwVdg0j
         7LrIVr78/iPP8rNMT8WlhVdSjxh4SmpKa6ZQ3T+MHwuSmjkayqwoc+fik1xdOnypPAn6
         0ELgHKKn9w00tcrz5J/qSqtfJR1l516N9kOmmT7E1IKhB7dSMLgHF+AoN7ue3jcf7J6F
         CbrhyJDiqSAneKAf2oR0strvKG+SGWYWJyhLdopmcHaJHOSPc5Uy38mHaOZQc0PxrjkQ
         8lVVQjFPdPd3zaJ62sShN5CbOmKnV8MpJiGem6JKQEOeHdNOBxHydzXKEFkm9hL5P+ar
         BAvg==
X-Gm-Message-State: AMke39mTVxWoWxXBNtsozO5tD+iSJqALY7Vwf6hDgycJ294vcUrrrpgavlmfXjWcitfKu3RAf+tD5VDDVRE44A==
X-Received: by 10.46.20.89 with SMTP id 25mr4988901lju.10.1488236758358; Mon,
 27 Feb 2017 15:05:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Mon, 27 Feb 2017 15:05:37 -0800 (PST)
In-Reply-To: <xmqq60jvnu9y.fsf@gitster.mtv.corp.google.com>
References: <20170227045257.yazqlrqlnggosi5t@macbook.local>
 <CAOLa=ZSyQg9uoZWADOMYc90U-5AR9Lfii9mjLre0m0FQCSqfxg@mail.gmail.com>
 <20170227074915.xljfe5jox756rlyv@sigill.intra.peff.net> <20170227080158.de2xarctzscfdsp2@sigill.intra.peff.net>
 <20170227090233.uk7dfruggytgmuw2@sigill.intra.peff.net> <xmqq60jvnu9y.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 27 Feb 2017 15:05:37 -0800
Message-ID: <CA+P7+xpVt6NtSajqMX8OQ_SKdC9tfHH40JgK=9DgBxo9nMaWLA@mail.gmail.com>
Subject: Re: [BUG] branch renamed to 'HEAD'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 2:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> I guess something like the patch below works, but I wonder if there is a
>> less-horrible way to accomplish the same thing.
>
> I suspect that a less-horrible would be a lot more intrusive.  It
> would go like "interpret-branch-name only gives local branch name,
> and when it does not show it, the callers that know they do not
> necessarily need local branch name would call other at-mark things".
> As you pointed out with the @{upstream} that potentially point at a
> local branch, it will quickly get more involved, I would think, and
> I tend to think that this patch of yours is probably the least evil
> one among possible solutions.
>
> Perhaps with s/not_in_refs_heads/not_a_branch_name/ (or swapping
> polarity, "is_a_branch_name"), the resulting code may not be too
> hard to read?
>
> Thanks.

What about changing interpret-branch-name gains a flag to return a
fully qualified ref rather than returning just the name? That seems
like it would be more reasonable behavior.

Thanks,
Jake
