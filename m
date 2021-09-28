Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A67C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 05:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7078B611C3
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 05:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbhI1Fo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 01:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbhI1Foz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 01:44:55 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B22FC061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 22:43:17 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y8so17955203pfa.7
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 22:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2d8bnc++iDJyvokbZB4lfS/ByvKRyDhUYNkk/2GWgbc=;
        b=BPMzFgl0mwbouEnpmY8ZFRhVHKkG69Gecmb5aPvu88TyBHdnGUL8KMN9q5yAiUDEG4
         ani0MoZo7iqcNiUOMsm3e4XMBlXXXq+216xYANfGxJzOIIyfZMpBdkNxO/ZSm0fFdaWh
         TwyrPHa3Gt1RKrSN2e3hPKNGfkZQaIcH7193CpGr3bAGVXze3BZnDqbXpQJOKvJqPYh7
         II6n0DU5AbUAGPX42OBH8GLeFuQP987foNptDAhl1NEZ9gjN0+VyfUafwQzZkIwl/slq
         FUtNYUASnjv33TRWRNiiT2MdFs0xHLbH8fxSyMAhCbufWIyIzT9gcehKtVrrgl4Q6kgQ
         REgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2d8bnc++iDJyvokbZB4lfS/ByvKRyDhUYNkk/2GWgbc=;
        b=CTTC19ncmIORkzf69I6rCNY8nZLf53hV6fPi0HNJEQ/PlM3cBtRDcSSIx4kfovqFIo
         9yLTXEJIAKihQrLYkdY17t+05kE2m5xYc46slNtRMS/0LbzmzuAvgVcLGQftHdNND2ke
         txOK58oyAtGpS1LlliX8nv7TJVyIwtAZLuFms6t4xFXyX662/thEwNML06XfWHqng/2K
         cXGk2PMdrJJrJeNI2fz3bQhv39Ru5wL0zvMPFLbn8z2SQdZLXSDpyRuqxXPhKL+GtmT3
         107yosN8z1GGjWrMRVAUavlTKyf567/irsihZdR8FVQL4MqaiT87ItlU7f0N+7T1iOOn
         ylkw==
X-Gm-Message-State: AOAM533iUfzvT3HIoq/qCcYPcI/HlBNobr3s6DS11aT8RX6g6iiZiJcr
        +sl6XAGpkfdPYd7LefDoeUc=
X-Google-Smtp-Source: ABdhPJxMvUGuh01Ww4MMRTsWGHvUADRwHjiTvH+vTNdeAuZ41a2l4piDOxpf86KVO5BVkd5MmGfuKg==
X-Received: by 2002:a63:34c9:: with SMTP id b192mr3025602pga.466.1632807796560;
        Mon, 27 Sep 2021 22:43:16 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-85.three.co.id. [180.214.232.85])
        by smtp.gmail.com with ESMTPSA id 23sm21434006pfw.97.2021.09.27.22.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 22:43:16 -0700 (PDT)
Subject: Re: [PATCH] blame: document --color-* options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Dr. Matthias St. Pierre" <Matthias.St.Pierre@ncp-e.com>,
        git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>
References: <d918fe0de6b04d8d848050d4aedbe060@ncp-e.com>
 <20210925121817.1089897-1-bagasdotme@gmail.com> <xmqq5yulregh.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <fe78329d-07a7-bdf3-2bda-13def35f3de3@gmail.com>
Date:   Tue, 28 Sep 2021 12:43:13 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq5yulregh.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/09/21 02.44, Junio C Hamano wrote:
> Nowhere in "git blame --help" output we mention anything about
> "metadata", so the readers of this new description will be left
> puzzled what the word means in the context of this command.
> 
> We would need to pick words or phrases that readers can link easily
> with the description of "THE PORCELAIN FORMAT" section.

In git-blame(1), we only describe output format for "THE PORCELAIN 
FORMAT" as well as "INCREMENTAL OUTPUT", but not default format.

On the other hand, --color-* options only works on default format, not 
the others.

-- 
An old man doll... just what I always wanted! - Clara
