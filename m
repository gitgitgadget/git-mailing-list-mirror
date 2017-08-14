Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E7DB208B8
	for <e@80x24.org>; Mon, 14 Aug 2017 08:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbdHNItT (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 04:49:19 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36795 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752510AbdHNItS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 04:49:18 -0400
Received: by mail-pg0-f48.google.com with SMTP id v77so43057653pgb.3
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 01:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=J4ljWt2h3ex8W41QXUfvtsX+LIiTQKIkeB3564a7Y3Y=;
        b=pGIdNFn9G4hHGkrRxNC0ZDCv3KSwoh/4W5nUacFM3SlzG9J28ViiMFE1Tc8O3He3Kt
         rVMOprX9gwGKhzlRkAIHL2T+vMO7g9zCLGzW5x/FKJCWC/cP46V/JImcp9lLWejBinMn
         /ka5ISShTQwx8g2VlMyLpy1yUygfB950ogA5UrEEbSW2fhJeNr/xIYfeu3jx6imaXc4v
         q/oG5zrpaqNWSyyNk2k+ZOR8GF6cGQwEOSpBS1klqG7o7HQFzD4rro1PnpZeHGYbEQOn
         JoH29LW9A0qR1saJsU9Ld5rmxp06JGLS3SYoRrbRL7P1wByVkNw5gEZF8zDYj88Bh818
         jVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=J4ljWt2h3ex8W41QXUfvtsX+LIiTQKIkeB3564a7Y3Y=;
        b=l4Y2fUMS1YNSak8exv5uEKJXV4FLQ+oJeTJHFg/NPPMomSTrZI3hJx9SzGKw0NnwjM
         KXpoRdDRW+MoJKZLPkcP0rEBldm3NCpcDCpwFhZmolrjP38ANQAI+p7WdDtrVFJOMeyW
         rtUp1C8rTHBAflK3UCZ4kHpt7Vw/XaNtMGYVZLUSTbKcQdITgdsVRmv513fynP/SwIUk
         t6IZYl3WbskSDiGJ5cnScqEpe04aQZgzQQwBoqPrrlL8/SE4G3IJJOO/9VwyZTkAE09+
         ApWSYCfrf0xFrjInT0N1Irdaf6Ufe1SYaZrHtXnkbsU0vU6T5962/IQgm3k1YKuUj2kj
         5UUQ==
X-Gm-Message-State: AHYfb5iunf2Zat2SJNCNEhezSTn+CN/AsgJKezJI2OwWH2qiO8uh7eBC
        3YgctPGguYnt8VB31jl/Dg==
X-Received: by 10.99.112.76 with SMTP id a12mr22715030pgn.334.1502700557465;
        Mon, 14 Aug 2017 01:49:17 -0700 (PDT)
Received: from ?IPv6:2405:204:7086:24:a9b7:4f7d:37ad:9d03? ([2405:204:7086:24:a9b7:4f7d:37ad:9d03])
        by smtp.gmail.com with ESMTPSA id d28sm13751313pfb.139.2017.08.14.01.49.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Aug 2017 01:49:16 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: Re: [PATCH v2 1/2 / RFC] builtin/branch: stop supporting the use of
 --set-upstream option
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <xmqq60dzp00l.fsf@gitster.mtv.corp.google.com>
 <20170808171136.31168-1-kaarticsivaraam91196@gmail.com>
 <CAN0heSqbAdYy-2c0CfO2OxijtvncGWe432bFmkpHZugKDrx-pw@mail.gmail.com>
Message-ID: <d6faa480-e898-0808-d276-ea516031f454@gmail.com>
Date:   Mon, 14 Aug 2017 14:20:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAN0heSqbAdYy-2c0CfO2OxijtvncGWe432bFmkpHZugKDrx-pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 09 August 2017 12:03 AM, Martin Ågren wrote:
> (Also, is this really a refactoring?) 

Not quite.

>>   --set-upstream::
>> -       If specified branch does not exist yet or if `--force` has been
>> -       given, acts exactly like `--track`. Otherwise sets up configuration
>> -       like `--track` would when creating the branch, except that where
>> -       branch points to is not changed.
>> +       This option is no longer supported and will be removed in the future.
>> +       Consider using --track or --set-upstream-to instead.
>> ++
>> +Note: This could possibly become an alias of --set-upstream-to in the future.
> Maybe the final note could be removed? Someone who is looking up
> --set-upstream because Git just "crashed" on them will only want to know
> what they should do instead. Our thoughts about the future are perhaps
> not that interesting.
I thought it's better to document it to avoid people from getting surprised
when the options *starts working* again.

> (I sort of wonder if this option needs to be
> documented at all, especially if this doesn't say anything more than
> the die() just did.)
Yeah, it needs improvement.

> Also, I'm wondering if it should be "has been removed" instead of "will
> be removed"? /Implementation-wise/, it has not been removed yet, but to
> the user, it has. So maybe just "This option has been removed. Consider
> using --track or --set-upstream-to instead." The same below.
I guess you're right. I thought "no longer supported" was equally
communicative.

