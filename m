Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0AFD1F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 19:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbcJKT7Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 15:59:24 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33299 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752299AbcJKT7X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 15:59:23 -0400
Received: by mail-lf0-f49.google.com with SMTP id x79so57333176lff.0
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 12:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=IHguRNTnMGoXv9HZZMJyGaTWK/fjZWR8YQcLpGdNDKE=;
        b=GBQba48EeBBgBNJiW/YCOilZGBr26sueSfLXqRJaiE1SqhWm0bp0saskHttuV6/u5Y
         7r9T1LCXimxRF/xlMNvfuM/P0A+fMFF7wEAiQEgSWkmX2zQgs1W3raHZFPKBF9DqRWMU
         daEyGTnwwNMq4MN3el7jEAIw57Ov4opFd+gcqw//B+VO1hgGivioY+ynVyUgmFPIs4BG
         6/EHOcHXexzcWVgqqOA/MVyxc0JsfKEYvArt6lL9axejpngkHuPkLoWrD38NV9zxw51d
         P+RR0g1KeV+VwVPy53Xyi6+J3Lm530tgu77GTXk3jqAttXp2WZbkh2gYLK7IMQmikRSM
         jNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=IHguRNTnMGoXv9HZZMJyGaTWK/fjZWR8YQcLpGdNDKE=;
        b=CcbLo5nT6Vk9ssynPv2UyCWlpJd0BT1WoTQJ6SbdVhbkcKG/OqKCzIKFNlBXRSLNje
         MfyhzQLy1c+KzkN7LPe3NoZvhwlGrcGIYgmhzmnOU3WlNjmU7GC3b3iPnlHpeQSQAIAs
         fYy4ZCCf0Kb2RZAhusOo9vg8Wy1fM06JGJYMCA6ufmueb/Hq52RnJRwvoBTLpOamdCmU
         RMILavpQ8Dax860OyZy/m7eBNskmsGIMdGzyFfSXL6fy6ix0I5n+Km2N/ymJtF9weCHm
         73MVP5r77ETA4HMyo7n7Nrkg8LQXw2TkC7iTb+UQTyLop2ohYjol3EupuMwQcHqts6i3
         NEsg==
X-Gm-Message-State: AA6/9Rl/rLMvSlsPEh3XPcjlx00J1eyrvUXkq+nHUd88faqgj2g2pcN6bHbNya6ROMwH/A==
X-Received: by 10.25.168.212 with SMTP id r203mr2080439lfe.85.1476215961894;
        Tue, 11 Oct 2016 12:59:21 -0700 (PDT)
Received: from [192.168.1.71] (78-60-211-195.static.zebra.lt. [78.60.211.195])
        by smtp.gmail.com with ESMTPSA id e70sm1459400lji.30.2016.10.11.12.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Oct 2016 12:59:20 -0700 (PDT)
Subject: Re: [PATCH] contrib: add credential helper for libsecret
To:     Junio C Hamano <gitster@pobox.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
References: <20161009123417.147239-1-grawity@gmail.com>
 <1476198080.3876.8.camel@kaarsemaker.net>
 <xmqqoa2q8ypl.fsf@gitster.mtv.corp.google.com>
 <c87e4dd4-7253-d7c2-010b-6d8c7f587093@gmail.com>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Mantas_Mikul=c4=97nas?= <grawity@gmail.com>
Message-ID: <61eb8570-52bc-0059-9c81-ad1d66da12ac@gmail.com>
Date:   Tue, 11 Oct 2016 22:59:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <c87e4dd4-7253-d7c2-010b-6d8c7f587093@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2016-10-11 22:48, Mantas Mikulėnas wrote:
> On 2016-10-11 22:36, Junio C Hamano wrote:
>> Thanks for a review.  I'll wait until one of (1) a squashable patch
>> to address the "we do not want unconditional overwrite" issue, (2) a
>> reroll from Mantas to do the same, or (3) a counter-argument from
>> somebody to explain why unconditional overwrite is a good idea here
>> (but not in the original) appears.
> 
> I overlooked that. I can write a patch, but it shouldn't make any
> difference in practice – if c->username *was* set, then it would also
> get added to the search attribute list, therefore the search couldn't
> possibly return any results with a different username anyway.

On a second thought, it doesn't actually make sense _not_ to override
the username. Let's say the search query *somehow* returned a different
account than requested. With the original (gnome-keyring helper's)
behavior, the final output would have the old account's username, but
the new account's password – which has very little chance of working.

-- 
Mantas Mikulėnas <grawity@gmail.com>
