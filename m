Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62F3A2027C
	for <e@80x24.org>; Wed, 31 May 2017 00:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751093AbdEaAKN (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 20:10:13 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35163 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbdEaAKM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 20:10:12 -0400
Received: by mail-qk0-f193.google.com with SMTP id v195so81337qka.2
        for <git@vger.kernel.org>; Tue, 30 May 2017 17:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KVdpDd3DVVr7F/BAEfs0mFrLo/efOeB890aQtf2CAzc=;
        b=cN1lkh/uXwxmQAULNly/uWGYjMIskt/ywm2CosgUcKx5+goPBAHGZeG3RQVI0Tsbjx
         rjHV9Z/2jPrNSktKVxCAGhVqo+PgRL5hPfb68qQw69GlM47HrfUU0I+NdOHzvk+60qCT
         44O3pjLJsaygLy8WwpmCggsu2XWq+1FuUtnYFWxKM0/kX+dLNjH/GaQC/U5ER0NpEIrp
         8HpkMohLjTjUN3XS8ZxstUAHTkaD4VEzXKMmPWus5OupwjIJ+0qYrQNUlPjoICdq1wZQ
         gnpOsa4xugSSD6VuzzLErKtJ5u91UCf/w6MnW2WQ2b821bogExO+AxvlxK1IgJKS5RkS
         tAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KVdpDd3DVVr7F/BAEfs0mFrLo/efOeB890aQtf2CAzc=;
        b=bThS8XObwooSCOc5PnY0fOWG3Jz4ZSxpTCdl9m6I4QJRBW5YebK+hhPsMj6N7W2OQt
         +6uYG34lAaHT/4wH3NbjKXpvwDkE2UpRLW8ttUXsY+P0bEFX1NwRTa4nMVMjXmzC1jUS
         +djqqQK5M8Y4b0JEkk2srPq3huAf4XP1X7HrBM0BqP53ykSH4ZbRCRRRF500sWiBbPL+
         snXjJsB5/zCNFcA5r1ub007lAGC5G+yNqwjJE4mjRLNHFDr/nqdEz2yb1qV8CGUzq0q8
         7v4Zbyy6kd9tQiYIEqdmSKIes5WydgYpTow4t9u6T4PdCDCu47Bp2b1TaBhNFV+kZgOr
         r9Rg==
X-Gm-Message-State: AODbwcAVUZAbBtcfica46JUPlP3W5wLnvZ2MRjQYeAxu6kK2R1n6a8p4
        o6N96aBTEAtC2/BVFJM=
X-Received: by 10.55.174.130 with SMTP id x124mr24911168qke.113.1496189411598;
        Tue, 30 May 2017 17:10:11 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id t66sm9218058qkt.42.2017.05.30.17.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 May 2017 17:10:11 -0700 (PDT)
Subject: Re: [PATCH v3 4/6] fsmonitor: add test cases for fsmonitor extension
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>
References: <20170525183612.3128-1-benpeart@microsoft.com>
 <20170525183612.3128-5-benpeart@microsoft.com>
 <CAP8UFD0OEUogQYL5Eo1kBy_1B=dBcdEJyc4B_qAUOU=2XnrxxA@mail.gmail.com>
 <bfab707a-7f3a-ca7d-1f67-66dcb6ab2ea6@gmail.com>
 <xmqqa85uas42.fsf@gitster.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <35520cf4-6a73-29cb-e058-a0e7e29bfdce@gmail.com>
Date:   Tue, 30 May 2017 20:10:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqa85uas42.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/30/2017 6:37 PM, Junio C Hamano wrote:
> Ben Peart <peartben@gmail.com> writes:
> 
>> I did a quick search through the existing test scripts and the
>> majority do not link commands together with && when they are in a sub
>> function like this.  I find not having them linked together is easier
>> to write, maintain and is more readable.
> 
> I had an impression that it is true only when the series of commands
> are not about Git.  When testing git commands, we should expect any
> of them to be broken (by somebody else ;-) and prepare to notice it.
> 

Fixed
