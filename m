Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34ECC433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 14:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbhLHOga (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 09:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbhLHOga (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 09:36:30 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42354C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 06:32:58 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id 8so2330078qtx.5
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 06:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5420bfGWF4J4/uCzD6KrawFH9LF5alm1k+IavpzKjZ4=;
        b=Ll8y+z/CEWYdhb62NLh2K9ZMXvSQrDnOf0D/xiPl/WL5vsghnm682kIFuCfWqn/iYw
         rIi4nlnJUD9onEYSrTfG0ctuWipHeL31qJtQizea5PJKeSthqzowAjo1awBChiNZRnwk
         qMgBMgQFg0R6NV1katFTzo5HIjiHjF5lRfcjQ9SJ6mlBOP3bKRkUbWXk91rX6F0Q4/8l
         VeMF2hy/zxR1V6BY95QCttkfygFfHu2T0dKV8frUWoxocEasqdLv2GE6sJkDzTzLtqlV
         BwraqAJ9OippHfwjTxbfRiYDHy8uwYZyGm6TMnStcJ4zWJUlF5O6DBYFqm6Ajz/PEbMX
         NZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5420bfGWF4J4/uCzD6KrawFH9LF5alm1k+IavpzKjZ4=;
        b=VGpMXEcgfKqDHky1a5QJc/wVvWEfv+7DZOfOCZ4QHQ1F0K6emvA5WRHihwiJS7JxOD
         cMpWUhV5nrGOXDVvg1VHSXTI3BRYEuTGuAOVgvaDzVOynWuHk3VTQ4zlFYhoMeEqMAHu
         3PXrXaqDZHyHceEdmfJnHddT8OYKLKIEEJoPCb7c0Kaxp394sc5mLHv1Mcp0qTR+6AJb
         pNLbVKsm14jARmsSHu61ujfhmGE71I5b66SqtV69J1NGI4/n9+TcfndjVjzTewmaf8EV
         qcIhxifVaybjwxo53PnTZ55zYmlHM7NaXc5ePfxft9Q4+UvuOkfdCCuoiwvSXDviamtl
         YJVA==
X-Gm-Message-State: AOAM5312ywDS01DJWaKujlJ6KOkWen/GT6a8GzyE3KnyvQNsmmoKC1/6
        uItY7MUjLTPWO5u8kSCKRcQ=
X-Google-Smtp-Source: ABdhPJyAuj7p1l4aiCPJvWp8RfgVM2xKV0E6b+z3HaVPIrDF72qz2XUOFnSpaMKL7RN3eYeNS8Fd9Q==
X-Received: by 2002:a05:622a:1789:: with SMTP id s9mr8467679qtk.604.1638973977374;
        Wed, 08 Dec 2021 06:32:57 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:5056:be20:f10c:bfd5? ([2600:1700:e72:80a0:5056:be20:f10c:bfd5])
        by smtp.gmail.com with ESMTPSA id k1sm1434470qkh.53.2021.12.08.06.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 06:32:56 -0800 (PST)
Message-ID: <e47990d1-4efd-e0ae-5696-bec9a854ea1d@gmail.com>
Date:   Wed, 8 Dec 2021 09:32:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 08/10] reftable: order unittests by complexity
Content-Language: en-US
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
 <458adf0fa9b90dae831da7aa8cdb67fa9a064ab5.1638899124.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <458adf0fa9b90dae831da7aa8cdb67fa9a064ab5.1638899124.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/7/2021 12:45 PM, Han-Wen Nienhuys via GitGitGadget wrote:
> From: Han-Wen Nienhuys <hanwen@google.com>
...
>  int cmd__reftable(int argc, const char **argv)
>  {
> +	// test from simple to complex.

Use /* ... */ style comments, even for a single line.

Thanks,
-Stolee
