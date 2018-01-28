Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D9721F404
	for <e@80x24.org>; Sun, 28 Jan 2018 19:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeA1T5H (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 14:57:07 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35772 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752289AbeA1T5H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jan 2018 14:57:07 -0500
Received: by mail-qk0-f193.google.com with SMTP id d80so3124148qkg.2
        for <git@vger.kernel.org>; Sun, 28 Jan 2018 11:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=OflO1WBUUY4Gdkjzf6eHQP8kkh7t3Moiu4gA9/Y5e0Q=;
        b=PlfBUL+pgjapOBwq2I+lMZ0QDtn3+pIQ1NuuDwJw87M5I9Dy4mV8G1ptiOTG6uDFua
         ZeIuznaqoOkmSyMYsl1b+DqV8g2T968ftqQqCZifzVHvUL4kunGggdRVn2/KgZglRmsq
         KvpSYV1TO+6YCQYmiULLYvj7xA7H1dASnIk+tNuRsQAWWyhmiJG9BVj67Kt1YYRXtO4e
         97GbbdzPfvHfy1MS4Xhhvf8W87C/g9/cIzHKqlpIe8k9JSbEba4Qoc6867nEQYC1Qmbd
         yBssahJD8/053xKBL7dFyMEBhx4LPiWQZjihWzhf+Ixdq357hMAPb7VxbbPzlsqiDjJj
         /mPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=OflO1WBUUY4Gdkjzf6eHQP8kkh7t3Moiu4gA9/Y5e0Q=;
        b=UxNrYzPSu2DwmSpYY0rANXfhf6wMURyynJusJtwjr90hKGM32HVcQYfXsXZrDy/f3R
         xyvwHd83no8rdubTO83TprbWzYFFkq3Shlq4aoGByojcuD2JTLfEekp0rJwM52bY2prq
         z50nlDyrxBHfamnH1XrO6TiiYC7k0T8B51pJAVQlVaWiquqU9ebxyVyHNSKadu5WMcoy
         k7ltBDfUPkVFhSz0Dg9MmDp+bWx3TCq2Hza68YOgyhyWRPXoAsNWEFa+VSttXxr1+yze
         xRaHRuBs1wcR2IQOqeelLK2OeUHIUHesQVzX0sV8YxigpK0HwJ6R6etELyy3dBmFPwfI
         ryMQ==
X-Gm-Message-State: AKwxyteh7IzHuFIG69cuqHzwtFUIl4x96bzs4D+Lxlnq5UwwrbjeE7Sy
        4nQqBoIJ4oRtq8sfnX6/Cn22Wbiog6f1jTl9WvU=
X-Google-Smtp-Source: AH8x227tKhDWa8+s+MefwXZMr7r347FNpze2QIxaXWsCSdil+bkVJicU/Y//I/YaZUChvnm5bun88vORjJhjY0lmfvk=
X-Received: by 10.55.40.137 with SMTP id o9mr29863538qko.189.1517169426250;
 Sun, 28 Jan 2018 11:57:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Sun, 28 Jan 2018 11:57:05 -0800 (PST)
In-Reply-To: <20180128111843.2690-2-chriscool@tuxfamily.org>
References: <20180128111843.2690-1-chriscool@tuxfamily.org> <20180128111843.2690-2-chriscool@tuxfamily.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 28 Jan 2018 14:57:05 -0500
X-Google-Sender-Auth: NTdZiTblvjeOk86mlpj9C8HYutY
Message-ID: <CAPig+cR77RTTw3uJAwK3XmmvzE7umv3_7M=NkaDEb=uXyNL4FA@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf/aggregate: add --reponame option
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 28, 2018 at 6:18 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> This makes it easier to use the aggregate script
> on the command line when one wants to get the
> "environment" fields set in the codespeed output.
>
> Previously setting GIT_REPO_NAME was needed
> for this purpose.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
> @@ -209,15 +218,17 @@ sub print_codespeed_results {
> -       my $environment;
> -       if (exists $ENV{GIT_PERF_REPO_NAME} and $ENV{GIT_PERF_REPO_NAME} ne "") {
> -               $environment = $ENV{GIT_PERF_REPO_NAME};
> -       } elsif (exists $ENV{GIT_TEST_INSTALLED} and $ENV{GIT_TEST_INSTALLED} ne "") {
> -               $environment = $ENV{GIT_TEST_INSTALLED};
> -               $environment =~ s|/bin-wrappers$||;
> -       } else {
> -               $environment = `uname -r`;
> -               chomp $environment;
> +       my $environment = $reponame;
> +       if (! $environment) {
> +               if (exists $ENV{GIT_PERF_REPO_NAME} and $ENV{GIT_PERF_REPO_NAME} ne "") {
> +                       $environment = $ENV{GIT_PERF_REPO_NAME};
> +               } elsif (exists $ENV{GIT_TEST_INSTALLED} and $ENV{GIT_TEST_INSTALLED} ne "") {
> +                       $environment = $ENV{GIT_TEST_INSTALLED};
> +                       $environment =~ s|/bin-wrappers$||;
> +               } else {
> +                       $environment = `uname -r`;
> +                       chomp $environment;
> +               }
>         }

Not a big deal, but the extra indentation (and noisy diff) could be
avoided like this:

    my $environment;
    if ($reponame) {
        $environment = $reponame;
    } else if (exists ...) {
        ...as before....
    }
