Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B09171F453
	for <e@80x24.org>; Thu, 18 Oct 2018 13:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbeJRVCU (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 17:02:20 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:36893 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbeJRVCU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 17:02:20 -0400
Received: by mail-ua1-f67.google.com with SMTP id y5so6103507uap.4
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 06:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5/3WZVwb76x1Vc49acUyqR4j64je7gG/vfYejBMAHDA=;
        b=h8Rb4w3J5QrtZZUrZcYdQ9O8iXyPoDeF+M8kHlRDQ+rHLHXdXLYSvKrok/04dH6Yrp
         CATwyqZ5UkYGOPkt0t1bjLmMLFasg8LkfFV1g4nFlKptfTtkQe88ZdW/1ZLz9lkLq3z+
         iaShw7VglfaugrCajiiDcHUyBPMbQMKk5IpMf8ApPXBeHgjLr0wY67n4qzWbevXU4YbT
         gdAeFgU7Oi/xFTdYHHoKi7XEIq2ZP7GH3buhNxGJe3sC4MGE/FfkLp7i4WPjYUiUh3le
         SejNpRpk/nRRX8Hrb5BTC6n9asr1fJK5yCt506Q5tu0L6x3UsgLvSGoRPPHgpyU9Hxtg
         WraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5/3WZVwb76x1Vc49acUyqR4j64je7gG/vfYejBMAHDA=;
        b=gaBph301z7Ovo4MlZoK9j7sXAOZdJUWDy8dKag+MKKMHv7HR2G8dPzmctS15T14sth
         HMxE/WUk1Y+O4yan1Kq6/HUN3wMcnyDJeP3kCVR5aMTRoLXQCca7FPNvVADQHq7ksY7t
         804S2htT/eNK5lQvXeHTylBxqe8HcpmhSoT7i2cByLiqLtVf+5eySdLnh/IxO0ZyKuDi
         mmfhAaUVrBXqkmKM9ugZvmdxIMAFOF6L1eqU2zm/3YOmb9AZYa4pC1Xs/UfBB1xB70el
         hJ0AQARgEDg1X3jdJroXjHuYvrrQuzNGNzhkVHweg5nYnxgdoslUVsMShRs7eYa7YK2W
         phPg==
X-Gm-Message-State: ABuFfoj9p6v6hhdGqYkXt3RSDTauUg1KP94UFhYntb1i+YXDcYwsA2lh
        1Zo/aV6L/0fWDUUwkZZ1SFwzPHol
X-Google-Smtp-Source: ACcGV61j0ZFe5gRAtVT38L/mfQVBnpmZqdXc5mDpAYbyoMB/ySASaJJ3E4cjg/gIU35nHKpMnBjIzQ==
X-Received: by 2002:ab0:1531:: with SMTP id o46mr4659651uae.29.1539867683680;
        Thu, 18 Oct 2018 06:01:23 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c079:83d:1a9:9f46? ([2001:4898:8010:0:a9af:83d:1a9:9f46])
        by smtp.gmail.com with ESMTPSA id a35sm3141025uaa.1.2018.10.18.06.01.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 06:01:23 -0700 (PDT)
Subject: Re: [PATCH 0/3] Use commit-graph by default
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.50.git.gitgitgadget@gmail.com>
 <xmqqlg6vvrur.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <daf46aa4-1eb5-86c2-c7c2-9198ed6473ce@gmail.com>
Date:   Thu, 18 Oct 2018 09:01:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:63.0) Gecko/20100101
 Thunderbird/63.0
MIME-Version: 1.0
In-Reply-To: <xmqqlg6vvrur.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/17/2018 11:47 PM, Junio C Hamano wrote:
> If I recall correctly, one more task that was discussed but hasn't
> been addressed well is how the generation and incremental update of
> it should integrate with the normal repository maintenance workflow
> (perhaps "gc --auto").  If we are going to turn it on by default, it
> would be good to see if we can avoid multiple independent walks done
> over the same history graph by repack, prune and now commit-graph,
> before such a change happens.
I don't remember a discussion on this, but it is an interesting point. 
I'll give it some thought to see if we can combine these walks.

Thanks,
-Stolee
