Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19C1F20A40
	for <e@80x24.org>; Sun, 26 Nov 2017 22:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbdKZWS5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 17:18:57 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:42879 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751934AbdKZWS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 17:18:56 -0500
Received: by mail-qk0-f195.google.com with SMTP id a194so30197366qkc.9
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 14:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=7XCSaZSCwQCeWfaAerOulSFPOqjo8kHoiZbFqrSR+eY=;
        b=WnfNdnxj8MCo4DfOHjFP7kACDWmHDbvnqr0cZlZM1ZSOp12nPcpjn5PQ4c0cND/sF9
         aqaHi7DIgXMThgsDlbYQ0tIUOISGPSHj7dehJByDun0fFlFu7MLIYQA0Ciq4tebHhH4U
         1M3DV33gtpW0+oUFrzTlCCGg2xwAUk+Z9dlz4aKIdJYW/z66Xa0r+bvBuwWbqQgt3Sa4
         hbNbfbOmtOEQKoXN+7tCVWNzcXYZ4VWWFGxZ9iVuCwuhzYL2R42e8uix2JVN2LBCcfl4
         82Bax8+RmZVugO8SnN++GKux08Q1I3HZC+87lh4fnFONSc39NsOwACFnFXSj4/t6/v3r
         LUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=7XCSaZSCwQCeWfaAerOulSFPOqjo8kHoiZbFqrSR+eY=;
        b=d6lMFVLU0vMlq6f5J50F55rlbm1v4NLA5R4kjaQJy1xVBiHyRXgfn3uy8udEvznytQ
         Ly8rzDXIjbj3ZVvRlW5YtLg0VwrCearTLpuvwjzyXFiDwV+KZnvf6mV1dJwKEm5aR8Zi
         PslfrE35gyC3/ag+HpE0Q+/ZsJbWZX3FvpVPAua1yPa7MvVr6GbWxRhPRzF9GTKpD5Za
         9AnRRmY/1ux9GrHlvAXsBzZ4z/vrcDqhsI8dJaltwkEda9LJvSc3iwupoF66xvtEPmTW
         NwMLUnjyJd2vreh3JQThoTFRTOZYc1/xSX9VPIJVpoXTMHjGhRxAsLILZoketrHKAuaU
         zzLg==
X-Gm-Message-State: AJaThX64A2cW4/ANuy1ADTU5VUADJIK24o2V7TP6Dp4eTCbgmVyOIRKN
        LF4C/tHTvm58wq4CtYj30yRtFol5upbv47KrwdI=
X-Google-Smtp-Source: AGs4zMaLjTpasfgJSgkJpRNFouOvxL0HAFZdlUqJT2ELuDOB+HRebHR+viscHLh50+0Og25/PMF5kmTC1Bn5G+Je1G8=
X-Received: by 10.55.58.14 with SMTP id h14mr50654695qka.132.1511734735988;
 Sun, 26 Nov 2017 14:18:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Sun, 26 Nov 2017 14:18:55 -0800 (PST)
In-Reply-To: <20171126193813.12531-3-max@max630.net>
References: <20171126193813.12531-1-max@max630.net> <20171126193813.12531-3-max@max630.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 26 Nov 2017 17:18:55 -0500
X-Google-Sender-Auth: TGRmQ1juf3nRbFwSLnj6JHRzoZA
Message-ID: <CAPig+cROFS+3Yon2CFr-aPUGzDY4WVbU8kHbBx68O3M8k5eeug@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] t5560-http-backend-noserver.sh: add CONTENT_LENGTH cases
To:     Max Kirillov <max@max630.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 26, 2017 at 2:38 PM, Max Kirillov <max@max630.net> wrote:
> Add tests for cases:
>
> * CONTENT_LENGTH is set, script's stdin has more data.
>   (Failure would make it read GIT_HTTP_MAX_REQUEST_BUFFER bytes from /dev/zero
>   and fail. It does not seem to cause any performance issues with the default
>   value of GIT_HTTP_MAX_REQUEST_BUFFER.)
> * CONTENT_LENGTH is specified to a value which does not fix into ssize_t.
>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
> diff --git a/t/helper/test-print-values.c b/t/helper/test-print-values.c
> @@ -0,0 +1,10 @@
> +int cmd_main(int argc, const char **argv)
> +{
> +       if (argc == 2 && strcmp(argv[1], "(size_t)(-20)") == 0)
> +               printf("%zu", (ssize_t)(-20));
> +
> +       return 0;

Perhaps this should return 0 only if it gets the expected argument
"(size_t)(-20)", and return an error otherwise.

> +}
> diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-noserver.sh
> @@ -71,4 +71,34 @@ test_expect_success 'http-backend blocks bad PATH_INFO' '
> +test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
> +       NOT_FIT_IN_SSIZE=`"$GIT_BUILD_DIR/t/helper/test-print-values" "(size_t)(-20)"` &&

Rather than introducing a new 'test' program, would it be possible to
get by with just using 'printf' from the shell?

    % printf "%zu\n" -20
    18446744073709551596

> +       env \
> +               CONTENT_TYPE=application/x-git-upload-pack-request \
> +               QUERY_STRING=/repo.git/git-upload-pack \
> +               PATH_TRANSLATED="$PWD"/.git/git-upload-pack \
> +               GIT_HTTP_EXPORT_ALL=TRUE \
> +               REQUEST_METHOD=POST \
> +               CONTENT_LENGTH="$NOT_FIT_IN_SSIZE" \
> +               git http-backend </dev/zero >/dev/null 2>err &&
> +       grep -q "fatal:.*CONTENT_LENGTH" err
> +'
