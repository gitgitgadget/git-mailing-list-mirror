Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C94DC433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 08:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A428613C8
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 08:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244418AbhI2ID2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 04:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244491AbhI2IDW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 04:03:22 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E45AC06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 01:01:40 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id k17so1259995pff.8
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 01:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KV9qcK9iDNb7H6ZiJpHR04YDHpcRdCL5MZsXCFbRUjs=;
        b=puAEI2vmr+ofNY47+axH87O3GeyGNm+w7aAw7bLFFmTSx9D5tFDlGGqHLXRPypuU7U
         wJOMZRgU4q3L589LQV/mD2S8MIjXUjEnK9GzNGJKsmqIaP/MNV+vuZTeDvXvSWYyFdFJ
         dW6SxuqGMIuDztIb4vD/klepYrtP15F1XGQpN3ucq2n0osjOm6LPpIXo3rtObJjbFj+O
         BszIl0PHQcmVxxsaUWVxF7Xonh3LjMvwktmY4BZuJAIDhFOAJEYtHOJHrtXnjOhAI6ZR
         8CqicLMXW2Yixe8tZTybN8nibj6X2udxPQWGkVuq32nuAp4xt/SdD/La22FvXP5IXy2K
         CXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KV9qcK9iDNb7H6ZiJpHR04YDHpcRdCL5MZsXCFbRUjs=;
        b=qOexfmGBWATg1ZEbmDlH3I8j0+CMdtdFcAET8vFDa1NGRmUF/b6lkPHW1SqfYwdZU4
         Ly3qERpYjuJcHuRKM9PVcm2WTsJHA6xlSOZAa29U9cH89yncAhOcM4jrW2JQ8Wj1YOIM
         ZjnHru8AP1a4lOgWaD1zrw8TQ2KA9LJnXX0HrhsdCOOUQRdky2y4EWNldCJMkF/Nul7u
         nSaB8Ay0pBOBHpIVWcboXLkTNcwBxYVnYlO3FV/jejuk7OUHPo8TqwjgHvxtI6DVodk9
         zJ45CCbf06a/meofDcjHiSr6fIIVajhvTjX2v8mKaSFRkwVNQWIk6ijtNziv8HU6pgmn
         2t/Q==
X-Gm-Message-State: AOAM530nfpqb6x0IC3eKWbX4ARb8jh41aFrTW9IjtY6CMntpknXdPaFY
        7tXlyNsjv/xtEgOajoFLVHrabJCCAlTASQ==
X-Google-Smtp-Source: ABdhPJzpyYwu3q7oINVchBuXiDhpa3y9zVR3AR2qReSSvHx/ybb+hV+ZnVRosG9Chy9huGf8jH1lrg==
X-Received: by 2002:a63:7542:: with SMTP id f2mr8302555pgn.64.1632902499539;
        Wed, 29 Sep 2021 01:01:39 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-24.three.co.id. [180.214.232.24])
        by smtp.gmail.com with ESMTPSA id h6sm1073803pji.6.2021.09.29.01.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 01:01:39 -0700 (PDT)
Subject: Re: [PATCH] blame: document --color-* options
To:     "Dr. Matthias St. Pierre" <Matthias.St.Pierre@ncp-e.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>
References: <d918fe0de6b04d8d848050d4aedbe060@ncp-e.com>
 <20210925121817.1089897-1-bagasdotme@gmail.com> <xmqq5yulregh.fsf@gitster.g>
 <fe78329d-07a7-bdf3-2bda-13def35f3de3@gmail.com>
 <4078bebf2da14e5f8fc80a5ac7918151@ncp-e.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <7d2fba09-4898-9b8d-d2c9-89438c8fb2e6@gmail.com>
Date:   Wed, 29 Sep 2021 15:01:35 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <4078bebf2da14e5f8fc80a5ac7918151@ncp-e.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/09/21 19.38, Dr. Matthias St. Pierre wrote:
> -color.blame.repeatedLines::
> -Use the customized color for the part of git-blame output that
> -is repeated meta information per line (such as commit id,
> -author name, date and timezone). Defaults to cyan.
> +color.blame.repeated
> +Use this color to colorize line annotations, if they belong to the same commit
> +as the preceding line (`git blame --color-lines`). Defaults to cyan.

Why did you change the config name? I think you make mistake here: the 
config name should stay as `color.blame.repeatedLines`.

-- 
An old man doll... just what I always wanted! - Clara
