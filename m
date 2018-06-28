Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC4101F516
	for <e@80x24.org>; Thu, 28 Jun 2018 22:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964796AbeF1Wvu (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 18:51:50 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33274 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932209AbeF1Wvt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 18:51:49 -0400
Received: by mail-wr0-f194.google.com with SMTP id k7-v6so3515825wrq.0
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 15:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JNu6WkIphgPeeiFs/jfHgS33+Dg4kODZlnHUpPoCLUE=;
        b=GVZHXyhU2dGb9rYNEDXcNU2bY2BSOX1WUWfInolbAdQHsoe6lN3nqHcYRccQn8+QxE
         VxNSPKo21RFTjzegadKfurUfk22/FFgTsLf/Mrn3/Lrv952JBSsbNmGO+AWqiJHtwth8
         lG3XCM6E/X1Lrty/SLgk3prhs66ngkM9oHrY2lvHMRk+Bo60PlBvefc8ogIo+QGWZ+u3
         yGvF/pYem5vUQlImV7CQkFDbZfZLFEwXMm874gf0kgWcjObbTfFhr0EpbG7X8SF/i6CC
         shAMuiHiQLGL3Zd8tpdQE9VY7dJ1PBbL7bau+Y9LA7Lu2+uQnJSPwIyfu8BCWWHVwEpU
         CFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JNu6WkIphgPeeiFs/jfHgS33+Dg4kODZlnHUpPoCLUE=;
        b=en8Sa0by0b5S1alAdOvxD+5idR8R69OY2H4kUKaUVzn3Al7OqCcWxY9fskJzFLI00b
         ulbC4UAn5qmI+jFTDvMpZCtQTuy99nDUkdZNiKsTtt1U4dYJCb7P/HZywd86ozIJ8V2s
         V2gBD91qwPG8hQiBiutA1+AKCiuUKu/A2KhU/GwGGFl5FR+WQ47uHWK76QY102YrsFdz
         rECIMwHnwgI+7pClJ9T41i4EeZFimjwQ6LBxVaW/XZPNZoiFqdLd+YPLD1tYM3AHQCV9
         LlSnEoag5VECKSE34jzgyJ0BP1LtXEdyb5liaar2P5VgqAJHSENN91bqorndhxYu46MQ
         Oo4w==
X-Gm-Message-State: APt69E2w9hXsMo4AbQkedze9Gxkfs3ktkRJieN5VxDlog7May3tmvele
        dJUD362oku2SLx+Mi+5HGvE=
X-Google-Smtp-Source: AAOMgpc3Fsdxi8OQSZREzlUNYc8sOAKJysqEoRH0fzXLMr8T+XOFhX6gbsOSI1SRn0tn4a3A+xKt3g==
X-Received: by 2002:adf:93a6:: with SMTP id 35-v6mr9765410wrp.18.1530226308543;
        Thu, 28 Jun 2018 15:51:48 -0700 (PDT)
Received: from [192.168.0.137] (5-13-221-130.residential.rdsnet.ro. [5.13.221.130])
        by smtp.gmail.com with ESMTPSA id a2-v6sm460wmb.6.2018.06.28.15.51.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 15:51:47 -0700 (PDT)
Subject: Re: [PATCH v6 2/4] stash: convert drop and clear to builtin
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, gitster@pobox.com
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
 <5373f422a82da2357828b8cc4a2b84fb2bedd780.1529943789.git.ungureanupaulsebastian@gmail.com>
 <nycvar.QRO.7.76.6.1806270015060.21419@tvgsbejvaqbjf.bet>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <16aa7eed-19af-9793-508e-a13caef020a2@gmail.com>
Date:   Fri, 29 Jun 2018 01:51:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1806270015060.21419@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 27.06.2018 01:17, Johannes Schindelin wrote:
> I thought you had introduced `get_oidf()` specifically so you could avoid
> the `rev-parse` call... `get_oidf(&dummy_oid, "%s@{0}", ref_stash)` should
> do this, right?

We discussed this over the IRC channel, but since not everybody might 
follow the chat, I would like to put it also here.

The main reason why `get_oidf()` was introduced is to make 
`assert_stash_like()` less tedious. I am sure that this is not the only 
place where this function could be useful.

Over the last weeks, I have been working in parallel on adding a new 
flag (`GET_OID_GENTLY`) for `get_oid_with_context()`. By using this 
flag, the `rev-parse` call could be replaced with an internal API call. 
I hope that I will be able to send this patch soon enough.

Best regards,
Paul
