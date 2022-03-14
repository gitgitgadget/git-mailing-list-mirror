Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F44C433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 08:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbiCNIGc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 04:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239252AbiCNIFC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 04:05:02 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DCE3586E
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 01:03:06 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id dr20so31709275ejc.6
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 01:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=8OxhdZnh918Z9TNFcLqNDU1LICKnnh18iy76PhlNWUc=;
        b=ZJZztS9UrLoz89bsLMAduhj4OUze9KnVtq858bk2c+7BqOrkKXZT+dyi0qbL2SD1X0
         OdKK6TqT4Y+TfCtIN5dzX59xjUS5gM64Sm4JR9dn01aSYFyMWcq2dQu0c8DVTQllppxm
         /AKAEO9P8+BuE2tdLpJ6O8rAFNeYdchgMYTloQaRhO0+a6UAaytVHYAIgPVOCeCK17Lw
         m7Z98537mmKATovygy9hvih3pjG7ezc/MaLslRmlOJcgP3tZnHP55817guyZch9xwYO/
         A6dSBi2+EcFjoqOSPmzH2V8volDIyKkPVsy0+ifo+KIy4ezI4/UGG3uH1E7k6wlq1k0c
         lrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=8OxhdZnh918Z9TNFcLqNDU1LICKnnh18iy76PhlNWUc=;
        b=CpbS/Cbc9p+GL7083pi48zrKF/L1ghPHp3JDZp5zB12Ip+ohXutLx91TxOpiQ+4kHS
         LrRAXWA/zT9epwYX5FTtclvhuL5oyEMZroeCcZGmB2hPI4I6cGu2Yf9E/YPGTJS7raG3
         8fOm6gPfPyKgToxr7LRKHDVgXgJgljwEiOJd2zA8aKrZldR3sZlIvVHNmu+34TOPNbsl
         NGlZO878aaGBIvPihblo8GxvWaj9/spy4oMfPYqBX3Kaaa8c9rRXeoa4OYkHyRhln6Zh
         V/CSfdawmI/Ps4mXda6hQ4C8pi3dUZ1WQIbYiQTwfJrYNVbdsgSOZYVLuYHFLSQWLK8/
         3IIw==
X-Gm-Message-State: AOAM531lRtE3VXElyYRMcsWQgcim4Nks8Gc6CQFzDICRUUNqTrdl7TTJ
        osedeHicF/8PTWtzsMgm6CB5gLKp00Y=
X-Google-Smtp-Source: ABdhPJyC+yc/T0m2fQxxrvhae7ov8TtarQQGNBeJcq2iCGlDv/NifgbvValNAP0ynlHYgyQxAid9Lw==
X-Received: by 2002:a17:906:434e:b0:6d0:ed9c:68bc with SMTP id z14-20020a170906434e00b006d0ed9c68bcmr16820558ejm.70.1647244985068;
        Mon, 14 Mar 2022 01:03:05 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m13-20020a056402510d00b00416ca731b5fsm5485920edd.9.2022.03.14.01.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 01:03:04 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nTffT-000J1u-VV;
        Mon, 14 Mar 2022 09:03:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 07/16] t/perf/p7519: cleanup coding style
Date:   Mon, 14 Mar 2022 09:01:48 +0100
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
 <3482fb79a517d4703b5aa888a8c3d4890d034cf7.1647033303.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <3482fb79a517d4703b5aa888a8c3d4890d034cf7.1647033303.git.gitgitgadget@gmail.com>
Message-ID: <220314.867d8xezbc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 11 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>

> Fix code style of added "if then".

*nod*

> Add body of builtin test to a test_expect_success.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  t/perf/p7519-fsmonitor.sh | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
> index 5f97edf6a11..7a7981b0e61 100755
> --- a/t/perf/p7519-fsmonitor.sh
> +++ b/t/perf/p7519-fsmonitor.sh
> @@ -141,7 +141,7 @@ test_expect_success "one time repo setup" '
>  	fi
>  '
>  
> -setup_for_fsmonitor () {
> +setup_for_fsmonitor_hook () {
>  	# set INTEGRATION_SCRIPT depending on the environment
>  	if test -n "$INTEGRATION_PATH"
>  	then
> @@ -182,8 +182,7 @@ test_perf_w_drop_caches () {
>  }
>  
>  test_fsmonitor_suite () {
> -	if test -n "$USE_FSMONITOR_DAEMON"
> -	then
> +	if test -n "$USE_FSMONITOR_DAEMON"; then
>  		DESC="builtin fsmonitor--daemon"

This "; then" etc. still uses the non-standard style (and this was added
in aa072da617e (t/perf/p7519: add fsmonitor--daemon test cases,
2022-03-01).
