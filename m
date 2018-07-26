Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E09E1F597
	for <e@80x24.org>; Thu, 26 Jul 2018 04:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbeGZF3O (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 01:29:14 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33653 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbeGZF3O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 01:29:14 -0400
Received: by mail-wm0-f66.google.com with SMTP id r24-v6so1056575wmh.0
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 21:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6cyWyaeYYGyVxEDBz6/QFZQfS3R5D/tjHKyAK74AX/E=;
        b=ukuIE8yf1dCs+2DfWVgcP5/ERd/ZZEziiXYxjir7Z2/iAbZPpbuTUcFWkfo/J298or
         SEepu9Z/FPryrL4Vh32AQW16tC/VR/GzGrfpcbg31zuV1xy3pKCcEoobPNm/VU8oaD3n
         I2F8LuaXcoAlNzZI/QZ6OyT8++hWHhKuniTZkbj3k+CLWyHl1b+G2IFLd5p1qtbPSvme
         6e0iHW1E7zVxd0erNGwxoWbzq2Dee9WIK85czYwSOqhDepl+7bVIOr1NgifCnS/bFtMv
         5dEHrFxwE2BHBJG6lBXG0LNqmJXOp7mok9CcmVhPua2lznPDbwHWYD/OJP/zM/s11GkU
         NL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6cyWyaeYYGyVxEDBz6/QFZQfS3R5D/tjHKyAK74AX/E=;
        b=tmtEXcOEBsF81IYCSqATwOEfgu8JQd7AuOtN6fZ4JeWqiut3F/DKJh4pAOOGxkf5hd
         JRDZc/zIhLBVaA5x3tDeUu29ChiHBWzpJely3yDC0gXT40S6hsmAbSTogqtnD404BqOc
         z22IgMUyK/gddw9benvWZ9LJnsTESW9EMcZoODSE+BGec7WvHX0EFWPb9yA32A+9O8+f
         ez9U8g/7v+yIpMqdP86dF4Aq93pyFegvFW3ukUyZaWXK295nfXjStxhw51sYAkbwNqhv
         NvsPqNkJAKmAbhdHkEoTv5mGffFH5bVNV7SAIT7pzU0LHtILizoifbW4qAdQjxo8TWg4
         kKjQ==
X-Gm-Message-State: AOUpUlH1YDtfAOgfDfnS+xdd5QqOJNRd2oyWX3W2YMtvIcBeplNnKmAb
        PhhqOUK46aKbnduPLfCSIBs=
X-Google-Smtp-Source: AAOMgpdwVNCm869h9hY3wZIt6TjZA8wr9G+xX/2eZbHlWGuko5cTQuJjG1UmQTvlGXAG6OqyE4kIIg==
X-Received: by 2002:a1c:7908:: with SMTP id l8-v6mr360550wme.80.1532578461340;
        Wed, 25 Jul 2018 21:14:21 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i4-v6sm480349wmf.4.2018.07.25.21.14.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 21:14:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2018, #03; Wed, 25)
References: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kbO1KOfDgjT5duEd49MZ=EaYLtTDeg2efVO5kkO9QFx7g@mail.gmail.com>
        <xmqq4lgmubi8.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 25 Jul 2018 21:14:19 -0700
In-Reply-To: <xmqq4lgmubi8.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 25 Jul 2018 16:43:59 -0700")
Message-ID: <xmqqr2jqskf8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>>> * js/range-diff (2018-07-25) 21 commits
>
> The non-coloring part, like patch matching and driving diff over a
> pair of "git show" output, looked reasonably solid when I read it
> (even though I admit I did not audit for leaks).
>
> The only thing I think we would be better off without is the
> coloring of whitespace errors (at least in the current shape).  I
> cannot shake the feeling that temporarily setting core.whitespace to
> nothing (i.e. we do not detect any whitespace errors and hence we do
> not show any) while running diff-of-diff may be a workaround that is
> less damaging to the code base than piling band-aid on the codepath
> that is shared with plain diff (not diff-of-diff).

Having said all that, after re-reading the patches, I think the
series is more or less solid already, so I am hoping that the next
issue of "What's cooking" report can mark it as "Will merge to
'next'".  Although I am not sure if an update for replacing "oops"
will have enough time to come in before that happens, I do not think
anything in this series is so seriously broken that would result in
embarrassing history littered with incremental fix-up.

