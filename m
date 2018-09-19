Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BE311F453
	for <e@80x24.org>; Wed, 19 Sep 2018 14:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731704AbeISUC6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 16:02:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37459 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbeISUC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 16:02:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so6020577wrr.4
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 07:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YLTTsZoUmup7Zt6Ep2ziqx98RxRoSGXrLFguAApAQ6U=;
        b=gDSdl+drv64I6ZRyTVTNdgXirgat1A4a3FmNmB2IrcNY+TL38t3/eEB2lib0kbK9S0
         EaQYTjkNIhCswirdvuLCgpNl3WQVc7b/HBtV77AUPwUK5000MzskMEMcGyxS1V5gUENL
         /RnzapsO3xqfCqFA1rx3JRFmSjVKHU38D/jYPQamajnNHJiuCmEIbbmAeYwIUdIHT1P4
         B4sNXl8PWuv+vT+m4fiG3KRSMoRyo9La+uxNRW9N1shi9tc6M1rHPTQ5T/9ZuVgPxLHX
         ljxvxtY69DzBLgBQ5/typSZ/TMte1FRGRZS7XI6F5F4UJ93FYM5CRmijiKLMolUkvrOA
         Bzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YLTTsZoUmup7Zt6Ep2ziqx98RxRoSGXrLFguAApAQ6U=;
        b=sckig+0BMLQc/l0eI2S5F1aTYYFpfMIe9dAlRW22oDxl6r5GckRHFpMno5pGKLfFGw
         gHWYpkt27rfrj6w6LYVznoAcUef5PlH+F5b94VYQHLQk9X+GDGp6m2auhzcTVSjQOR2w
         9DdEuSs+CutiDv5ATtjVCf8uj9RpymjZouKsXazGgn8XYkzDqzX+qHm2d86wh/VI/RJ/
         O0PsVjjcV7df+aLNqjvGe656zrq20HBa6OoDT7lwN+HIoj5R2l0W8+UTohWYmtpI9yyk
         FPZEIM1PM9NkfHSXurwuZcGMkVa0hVclkLHg6fRLyJyM4JyW8BOTYTvQsdDWAHSvzVej
         bBZw==
X-Gm-Message-State: APzg51DrY+DLXViZX0zSSPhbhwrnmimB2qApDFxfTprJ80ePzyolOjG5
        xOuATS38/exfeZ/nLnViNT4=
X-Google-Smtp-Source: ANB0VdbwiCPN+8zEzkUafOAjfAZ6quWacNLMTwZqyZd9XdfOpdVUMs1xtTyzKQx74XzDwgn+453riw==
X-Received: by 2002:a5d:5383:: with SMTP id d3-v6mr29687687wrv.191.1537367087619;
        Wed, 19 Sep 2018 07:24:47 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 144-v6sm6401141wma.45.2018.09.19.07.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 07:24:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     sunshine@sunshineco.com, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrn@google.com>
Subject: Re: [PATCH v2 1/6] CodingGuidelines: add shell piping guidelines
References: <cover.1536969438.git.matvore@google.com>
        <cover.1537223021.git.matvore@google.com>
        <c625bfe2205d51b3158ef71e4bf472708642c146.1537223021.git.matvore@google.com>
        <CAPig+cSzddcS+8mx=GMbJ5BP+=fPtza+7UdA5ugN+83NuOHyiw@mail.gmail.com>
        <CAMfpvhKejvbgzwtTv93iqLG8fMxqZW_MRTAU0q9bDArqJU2zUg@mail.gmail.com>
Date:   Wed, 19 Sep 2018 07:24:46 -0700
In-Reply-To: <CAMfpvhKejvbgzwtTv93iqLG8fMxqZW_MRTAU0q9bDArqJU2zUg@mail.gmail.com>
        (Matthew DeVore's message of "Tue, 18 Sep 2018 19:11:34 -0700")
Message-ID: <xmqqo9ct4lap.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> Yes, it's probably better to add a point about that. Here is the new
> documentation after applying your suggestions:
>
>  - If a piped sequence which spans multiple lines, put each statement
>    on a separate line and put pipes on the end of each line, rather
>    than the start. This means you don't need to use \ to join lines,
>    since | implies a join already.
>
>         (incorrect)
>         grep blob verify_pack_result \
>         | awk -f print_1.awk \
>         | sort >actual &&
>         ...
>
>         (correct)
>         grep blob verify_pack_result |
>         awk -f print_1.awk |
>         sort >actual &&
>         ...

The formatting advice to place '|' at the end applies equally to
'&&' and '||' because these three syntactic elements share exactly
the same trait: the shell knows you haven't finished speaking when
it sees them at the end of the line and keeps listening, and humans
would know that too, so there is no need for explicitly continuing
the line with backslash.

Organizationally speaking, I wonder if the above about formatting
would better appear separate from the latter two points that are
about semantics.

>  - In a pipe, any exit codes returned by processes besides the last
>    are ignored. This means that if git crashes at the beginning or
>    middle of a pipe, it may go undetected. Prefer writing the output
>    of that command to a temporary file with '>' rather than pipe it.
>
>  - The $(git ...) construct also discards git's exit code, so if the
>    goal is to test that particular command, redirect its output to a
>    temporary file rather than wrap it with $( ).
