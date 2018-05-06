Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01E692023D
	for <e@80x24.org>; Sun,  6 May 2018 01:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbeEFBOT (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 21:14:19 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46825 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbeEFBOS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 21:14:18 -0400
Received: by mail-wr0-f196.google.com with SMTP id o2-v6so21590993wrj.13
        for <git@vger.kernel.org>; Sat, 05 May 2018 18:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3WSQp6OaRemYT5f80zIjcTC57VoMb38V0lOA9TxFJhw=;
        b=TtVuZagXILcx52qzEU4L3Xz1wJJ1MSZ6nuNyggGGbf/Tj5DOzMIcDJrxEphU9jxdlL
         I/PQhW4RK2yASnnmcuMJR91vPJj6iuIyBDK6e+pFlBzEFyAqv4nYfAT53pBS/3DbozDv
         sTZS/1L9VEK3uKZ5yKefB8S6592WCbm+sL4JOJHIfE1sLpFdnyGYWcDuKs02kcz9PPGt
         YcKtOGUecehX8I6H6bpZqaDqFlz28dVX/1PUonRgaJiYaCyhI4yAxRsVBb9U38phDsA/
         9+9koTwuNZluHEMUA/7ozN+Fg/LUkSFJbHrtPCJvehxT4FOUN7crVVGGazIuxUJfOs2w
         KqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3WSQp6OaRemYT5f80zIjcTC57VoMb38V0lOA9TxFJhw=;
        b=N+83yGZaQKdBqJv0N2vWumUaPtOh/lM2BFkGkeuxXLAgUiHlruYRk61ZgGk/KcswIa
         vAvaC0Cim6IL3UaxNf+M48CGdDhumBOw/DXgsMmyhyYuSMnraGaf9tSQL07WZG2Ltn+A
         k15csWsXsKNE50nN7lPoMZISgIZSa8yQxQJWglzwPs0DJYq/+RHN/LBkqr5vqsFk4biR
         dFBOwQP5Ga2LsAWKcqudPMsANX/bYW3slWfqfZ82FQXgV8VYnt6lji3OiAy4IHdSz4A3
         RqNy05KG3w1gpu9DEl0ZvJhyolpyD6PzMJGRaNpzpSMYnjxwSF0+aCEiopPmZ+mV0pqs
         ZaQg==
X-Gm-Message-State: ALQs6tDjSYvLM/w99cXRx6QV+LPGYJJFs/HBmpyVwDIJl88VLWhYn/ZG
        1aWSWer9R3kAKN/JqCyXVJc=
X-Google-Smtp-Source: AB8JxZp9VcK0NXs5+FF6WcArVbYK3muHUzWxkM/8mAZbq1ecN8CHXGF2kTrTWayAyMsep64beWRYKQ==
X-Received: by 2002:adf:adf0:: with SMTP id w103-v6mr26955907wrc.101.1525569256929;
        Sat, 05 May 2018 18:14:16 -0700 (PDT)
Received: from [192.168.5.102] ([87.116.179.29])
        by smtp.gmail.com with ESMTPSA id b18-v6sm30391087wrb.55.2018.05.05.18.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 May 2018 18:14:16 -0700 (PDT)
Subject: Re: [PATCH v2 05/18] branch-diff: also show the diff between patches
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de>
 <12d9c7977fdf9cc73c810d2ca31d86a4971cf7f4.1525448066.git.johannes.schindelin@gmx.de>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <217c9c08-696f-5e96-d42f-d428ad1fe0a0@gmail.com>
Date:   Sun, 6 May 2018 03:14:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <12d9c7977fdf9cc73c810d2ca31d86a4971cf7f4.1525448066.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 04/05/2018 17:34, Johannes Schindelin wrote:
> Just like tbdiff, we now show the diff between matching patches. This is
> a "diff of two diffs", so it can be a bit daunting to read for the
> beginner.
> 
> And just like tbdiff, we now also accept the `--no-patches` option
> (which is actually equivalent to the diff option `-s`).

A quick nit - would `--no-patch` (singular form) option name be more 
aligned with diff `-s` option it resembles?

Thanks, Buga
