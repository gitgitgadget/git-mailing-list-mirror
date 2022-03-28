Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB51C433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 11:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240461AbiC1LIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 07:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240465AbiC1LIt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 07:08:49 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC38155232
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 04:07:07 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id h11so18636532ljb.2
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 04:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hMXVoQK6fgErqv5frF0HZecyAVlbAInXnQmV8ae1/CI=;
        b=QzxQnp+mlGRv5m2FcEz4wVgL75gAiZ5baqAeSfaJWFbPUqPGDiu/NYLdNaM44ZLvFL
         gfzlI7d7awnxfTmIXR4MooQSKJrCLnVlZG2BXa1oiufIx5ya3KxdBIHgjrygS9lBsVtl
         CphJ/3QAbxMDbTKwSpqNz2tQQUxmd1m/702+mZJkthy9WZ5p790+7QV6RtrCSzk9h4fB
         42HRzdfqw75fHAIAazlzI6EW0gQBF4zbfm8K77XvBBJBg9i9uHD6oecihrQ3+zrNb2wr
         FReNF4/Vk0udeufeE8J87aUNq/7a53MBgJqRB76GW9Jv7lZzau1aHmVZYT0TeUwjA0FE
         Nijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hMXVoQK6fgErqv5frF0HZecyAVlbAInXnQmV8ae1/CI=;
        b=rIgpB7bXglnRDnPt7z9fKUIrdejaAnQiCDIzSTsWG08coRKlBAbF1RPb1yLObK80hN
         RKRP/lBq/Vnjxr+CvEd4NJ5CAg8tGLNVcHhrZ5yuhUmzffOGldZh8Up4+2aluSf7TKn9
         vtqmtJ7gei1xBp+FQl1vt/wSGJbw1FXLbYTipSnslvBCPz0AuJ5vZrQON1mYxR8Bm2ZD
         qFG43RIYYmdt6YlXmkoK40UhHiQrT8RNuDSsk1odmaO3Zi+tRnZy/g824W/Wb9tgIK/3
         gyXadgRXBPAx2F031FWf/BBhnG31bhTxb0ArBIIR9ZMlncVKfaeVU8VYh+dY0uOUjOcH
         0Yyg==
X-Gm-Message-State: AOAM530BEzsi00szPsTkV1k+VQc/AJUX3pAd9jtuscBTZ9WPEWSNPwG2
        I2lj3N3/4nvpgEFEaWi8ZZWjGJVkMfRvXWS22lZr2WANATo=
X-Google-Smtp-Source: ABdhPJwNCza+77q6sirXhsaDA5SLBRmJzw2x6MT+8Y+a863J1M4uOUKWvv4pMUOhJIrnsN8uhaIxECzOmRWUUMdMJK4=
X-Received: by 2002:a2e:99c2:0:b0:24a:c194:ba38 with SMTP id
 l2-20020a2e99c2000000b0024ac194ba38mr11176289ljj.59.1648465625996; Mon, 28
 Mar 2022 04:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
 <pull.1093.v6.git.1646952204.gitgitgadget@gmail.com> <6adc8dc13852c219763a9830f848fbc8663f2fa9.1646952205.git.gitgitgadget@gmail.com>
In-Reply-To: <6adc8dc13852c219763a9830f848fbc8663f2fa9.1646952205.git.gitgitgadget@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 28 Mar 2022 19:06:54 +0800
Message-ID: <CANYiYbFjRMV-_opvFn78mq7tgtZFMrfPyDjDa+kyaZZfk_LmWQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] core.fsync: add configuration parsing
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, rsbecker@nexbridge.com,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        nksingh85@gmail.com, ps@pks.im,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 12, 2022 at 6:25 AM Neeraj Singh via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> @@ -1613,6 +1687,8 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
>         }
>
>         if (!strcmp(var, "core.fsyncobjectfiles")) {
> +               if (fsync_object_files < 0)
> +                       warning(_("core.fsyncobjectfiles is deprecated; use core.fsync instead"));

s/core.fsyncobjectfiles/core.fsyncObjectFiles/  to use bumpyCaps for
config variable in documentation.
