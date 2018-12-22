Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 315CA1F405
	for <e@80x24.org>; Sat, 22 Dec 2018 18:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389974AbeLVSLX (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Dec 2018 13:11:23 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38038 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731181AbeLVSLX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Dec 2018 13:11:23 -0500
Received: by mail-io1-f65.google.com with SMTP id l14so6274138ioj.5
        for <git@vger.kernel.org>; Sat, 22 Dec 2018 10:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LyGqsAyP5Z1PHVGuBFya9yHiCdz86qq2+0fjLgKbNRo=;
        b=n8S9WA1bsJ157e8OJamItE8StewQFiW3jyE7K9UwJvzv/yXbDGJu8tiu09GsB509Dk
         kmh+Vl4SaFfOIGGSwgCAJ4GCZLohTPcJMiYwlHPnL6Eur8cyvGaSJo6YpcI3DZr3E1R2
         0yPmCntkNq5hzx5Ab13SvHlrfh249OPffaDva5KZ8XCTBHr2UMbqMACbzSqHwVUW6vB1
         FGUNOgf5ujnOXDivR22DsoxFxTE9nkw9yCJ2MgIa6Sn6pSfNPFCxhXK4hXCt/Vd1Y4Fk
         ytqdm4chSDfv6+qKE7l8P/ma04+axan01HHF4TTHwc/qmxCoJsQQ5i8HqhGeoek/4kBA
         d13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LyGqsAyP5Z1PHVGuBFya9yHiCdz86qq2+0fjLgKbNRo=;
        b=DEmO8LzlfBKFTRZULKtTgnJlBhH2jcHqWntkzKbyAra1IJCHIgC/xCUfMw8iVLP4KN
         2ZCGqsZEq0j5XzKXGSarh4Fmn5SyYjYr9ciqltZt3gNembbj8iWDfVuHL8BwzNXDTpYR
         oEZ2tYc0qC3Ov1Fz3kzpP5TFMXadevx+hEj1GJQui5sj7EFxxBsxnLwJ3aCBV+RrxZKI
         6pg4YVty9UXDhVn0S6jkBd1witgAw+L+en8Pyjb5GS9kJthH7Qr0FL7K8lB0YFbxAVwb
         r/BqOjHSfdxbAchQLJd3250KUlUXpA/gzw8WGasgANrY4oSTTr96Cz8R1qSIL7dmcZQA
         o44w==
X-Gm-Message-State: AJcUukfHzSkC1Hbmqrq72EvBbrYeflwcsRaKJRGoesIRFT/P0v8GLFVq
        KCO5yhBS+xPrHp4ghXvVpkjiXNFe/EYT4AkfB5I=
X-Google-Smtp-Source: ALg8bN42aQnwYanAFC+dcTfJcGodbAUOEfEu7FT3wxe5o6n7bIdzHNngn+/PMt87/68CTCeAOGxEUJoNnN1DY5f71pc=
X-Received: by 2002:a6b:c3ca:: with SMTP id t193mr4508403iof.269.1545502281414;
 Sat, 22 Dec 2018 10:11:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.104.git.gitgitgadget@gmail.com> <4fb5de504e9b48a35075cb87f4158149055f1a13.1545391939.git.gitgitgadget@gmail.com>
In-Reply-To: <4fb5de504e9b48a35075cb87f4158149055f1a13.1545391939.git.gitgitgadget@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 22 Dec 2018 10:11:07 -0800
Message-ID: <CAPUEspjJSHfNtu8CyLjfRJ3JSzvP2WYcQ8f7Dp5L9vRaXvf0=g@mail.gmail.com>
Subject: Re: [PATCH 1/1] abspath_part_inside_repo: respect core.fileMode
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 21, 2018 at 8:34 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> +test_expect_success MINGW 'path is case-insensitive' '

CASE_INSENSITIVE_FS might be a better prereq

Carlo
