Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8982E211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 14:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbeLDOR1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 09:17:27 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:37718 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeLDOR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 09:17:27 -0500
Received: by mail-qt1-f172.google.com with SMTP id z16so18155237qtq.4
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 06:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=tu+rs8CaXWPeUFR/3BKvtwyImHkmkR3PxI6Hxayg4qU=;
        b=k2ptIU+3EiFJ/rtmmT5cHZ96I3Y3LLPVwRpAj/9h6u7qA5f4YIxjZuNg+cI+DiLGsf
         1bxRKIkf98kBGOeoPR0YnpjV87uIL8CjTF0GJGK+gRjthWOhEQRcy2GgcdCcHPDA83IG
         O1KyFL/F5PAPqs27Nhhz8J0wLmrJ/IemB3BN8r1XttknNffl7Jw89Hq+0T3T9NVm3Si/
         A2/H8eSSGzl49fkvitkOREHswn8c9WDdpWAY6+i3iRY+Od9YP6+q/tIIEMcoCPiiu6bW
         iA60rBdP2FgA6sS2D+/uPxE81Qf2FQNn7vNiXTx/incnaSwBLZz/U5fTf3kv4ybhT0EB
         NVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tu+rs8CaXWPeUFR/3BKvtwyImHkmkR3PxI6Hxayg4qU=;
        b=Jsln1cPhWRdsY64YoUyd5Ar5VqFOUYRX6emLLX4L0EFECONJEyqiIMqNKSaaDYlLGg
         KoIrCT5x6wj68luM5FoVk8A2MC+RMlljA1CNBo6bWIiQuybkoQSvgzk9PqbA/04nv7Kp
         2yvRcyMEIO8S+Dqn7DmV/Ag8TLOTlhARNt+fK5kly83HuKlPnnubMdKAamhE5bvWSRtC
         +EgQWQd84cbRNpDL+QQP9v3qCjPIuioTFb5kv/8yT49B83KsMfzS/ZxMs+180VH8+/G6
         kcAmQk3WUfJxdIo7OofbtrDbfcB9uQScm4F9UA+775nu2nhJXoiJbmE2O0MGUypMJCoR
         JdGA==
X-Gm-Message-State: AA+aEWbHWeGhibzK55fhpRoYGfxwXyNc4K0t8Bef8q6qEAuTZD66XnQ7
        j+/Gxl7duc9qFZiIUEoOTTs=
X-Google-Smtp-Source: AFSGD/XJiru/0xHfRF9IdyZuKkdiBbGnj/889Ph7x2OX94oQ3PkhY3ufAX9xVM0hdMqwaj4OhaJoKg==
X-Received: by 2002:ac8:7644:: with SMTP id i4mr19846487qtr.293.1543933045030;
        Tue, 04 Dec 2018 06:17:25 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:e4aa:d284:87ba:6dee? ([2001:4898:8010:0:cde0:d284:87ba:6dee])
        by smtp.gmail.com with ESMTPSA id n71sm11817145qkh.59.2018.12.04.06.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 06:17:23 -0800 (PST)
Subject: Re: How de-duplicate similar repositories with alternates
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>,
        Git for human beings <git-users@googlegroups.com>
Cc:     Christian Couder <christian.couder@gmail.com>
References: <87zhtsx73l.fsf@evledraar.gmail.com>
 <87sgzdv2gz.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c8a2b2c7-e8f1-3da2-cb39-5f7bd22d1818@gmail.com>
Date:   Tue, 4 Dec 2018 09:17:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <87sgzdv2gz.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/4/2018 8:35 AM, Ævar Arnfjörð Bjarmason wrote:
>   The leftover space
> spent is the commit-grah (not de-duped like objects are), and...

The commit-graph could be shared, as the commits in each enlistment can 
be parsed from local with GENERATION_NUMBER_INFINITY, giving us similar 
speedups.

The issue is: who updates the file? As the commit-graph gets behind, 
performance will degrade. But it seems like you'd need similar 
maintenance on the alternate object store, anyway.

Thanks,
-Stolee
