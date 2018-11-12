Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 659A51F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 22:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeKMInD (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 03:43:03 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34465 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeKMInD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 03:43:03 -0500
Received: by mail-ed1-f68.google.com with SMTP id w19-v6so8794194eds.1
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 14:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gi+ZA+v0zeU/45kFFoWnCUww6MuZZrLMoAzCngDlGk0=;
        b=qqXCgbtv3/Oj7atJUekvgTvuqdiJ2WgPrGka5eeVMvxIqE4uKYwFhb1PRbPMkPINl8
         2sNAOdMEgZ7MN5K5kAfxLPXHNQqNHSy6RUDEHDnw7b8knKd1TEJ75oO4YdYQBaZWuPWF
         9L1e0ZtkLLlw37KdFRIyLoMbreLROIYv+SnyEPf8f7ayUZ5FPPu09n0pcd66DfW0qD/7
         2IlTxcKoWdoY9NodDyNRvlbpVKlF7/35iT1L0ukXDE0kFYr3pO400WdVgb2xWCAki9Lv
         1eEHHF0EzScJuxUW+oWuis0gPnbooPqxqHAIvYaZ/Tg5UNJwxiqppbIpZM1AO78iFgTb
         Nxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gi+ZA+v0zeU/45kFFoWnCUww6MuZZrLMoAzCngDlGk0=;
        b=NDofttUqJdjuQ1yoQXd3mPv1r/EOG5TAIXLTNFx3fnaEFG+aCNqNJdHAm6T7B0OIvH
         w+RK8/Q6nr8Yz/Y92ALN0BW5HYYF5FuD8aTHZbFDaQVe2lTnwRTdy0KmyZOK8aP6Zmmw
         z3me+CCpiwJoiO8dC929KoP/qsDcwZCyoGFbqJh8xkdnfxIZw6tbn47WXRNK/vHPmcu/
         UhOx08K0zEbjTkc3vxLihWJbWfjO5D1hMsoeviaUgIhZC0lDIhC9uz6wFxIm6EkuO+Mv
         bKPv+a4Ooh55wp9l8WWfp3yblu0nXoOxqG1OA/r35GsdrT503AppxRV4TanTFe+JN4FI
         JlJw==
X-Gm-Message-State: AGRZ1gJxyB25FD7iLSIf39Lw4M8Uqh/dTdE2q5hNS7r8SepzdLgQZ6XN
        wH5VxTitQFRaBN6Vrh9LzFyvCSGD1CGZ0fS40W9kzA==
X-Google-Smtp-Source: AJdET5eLwpQiDt0Kapj1gD3Gnlm/Au79BXkkiNMEDfTCEYpEz4Eazw9IQS4NWBkw1Vrw1U5WmMBl5Z+6VBo1sF+dpq4=
X-Received: by 2002:a17:906:f04:: with SMTP id z4-v6mr10722069eji.106.1542062868169;
 Mon, 12 Nov 2018 14:47:48 -0800 (PST)
MIME-Version: 1.0
References: <1630a93f8270ca090459be8cc7213221cc6250cf.1542060094.git.steadmon@google.com>
In-Reply-To: <1630a93f8270ca090459be8cc7213221cc6250cf.1542060094.git.steadmon@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 12 Nov 2018 14:47:37 -0800
Message-ID: <CAGZ79kb68+vxHmwbttvXgaxvPdqAh3vJjZ9+U+BjY7ZeZzOxUA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: use CXXFLAGS for linking fuzzers
To:     Josh Steadmon <steadmon@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 2:03 PM <steadmon@google.com> wrote:
>
> OSS-Fuzz requires C++-specific flags to link fuzzers. Passing these in
> CFLAGS causes lots of build warnings. Using separate CXXFLAGS avoids
> this.
>

That makes sense in this context, ....

>  CFLAGS = -g -O2 -Wall
> +CXXFLAGS ?= $(CFLAGS)

... but out of context, just by reading the relevant part of the Makefile,
a user might mistakenly assume we do some C++ trickery for standard
compilation of Git. (Is that bad or do we just not care?)

I wonder if setting the CXXFLAGS near or in the fuzz target
would be better.

>  LDFLAGS =
>  ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
>  ALL_LDFLAGS = $(LDFLAGS)
> @@ -3098,14 +3099,14 @@ cover_db_html: cover_db
>  # An example command to build against libFuzzer from LLVM 4.0.0:
>  #
>  # make CC=clang CXX=clang++ \
> -#      CFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
> +#      CXXFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
>  #      LIB_FUZZING_ENGINE=/usr/lib/llvm-4.0/lib/libFuzzer.a \
>  #      fuzz-all
>  #
>  .PHONY: fuzz-all

Maybe here?

>
>  $(FUZZ_PROGRAMS): all
> -       $(QUIET_LINK)$(CXX) $(CFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS) \
> +       $(QUIET_LINK)$(CXX) $(CXXFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS) \
>                 $(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_ENGINE) -o $@

Thanks,
Stefan
