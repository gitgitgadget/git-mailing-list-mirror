Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47C1E1F463
	for <e@80x24.org>; Mon,  9 Sep 2019 18:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfIISv2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 14:51:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44234 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfIISv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 14:51:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id k6so3116551wrn.11
        for <git@vger.kernel.org>; Mon, 09 Sep 2019 11:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0pbU6Dg4N/25GH6M8Xa7txAUQlI1Tz1NBr+TzhkM6tE=;
        b=OIUjzegY97ISzvQbzynzDjs7tJwfIJ89c6lxNb1uUTxyUcaK11PkuHZb82TwzG51E9
         ew0ntbzbyH4ubgp2VJXIz9MPvVp7CfPCIiR/WiSaRF4T9hiIAdfuUZu2KjvwVAV2VTy5
         j8N6OaSpUgxNKFZp4k+k3BXXlQxSMnFhlctOb+y03g/BGBg1b/jJlXYoaHmJXlmzFvOi
         UULVPmIK20j+aIILQ0MghB3MDdTQjtxyLXzjhn7+hgR1kT1jZwbCl2VV2uex4qtgcqA6
         s2ybZvKOKbhWnrk/z3v2Ft+01Ohn4pnrHRWdV5UoYHLKlQofao1xuazXSqsS7yh3gp4J
         P2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0pbU6Dg4N/25GH6M8Xa7txAUQlI1Tz1NBr+TzhkM6tE=;
        b=MlPEdUS4+OYLHBytPkJWeZj6mNN5vcuarIwhZSySr1YqNJUiGHomP0hWpsZ9wZNsGU
         TzCFuBMtKBI0nK8AsDkDrg4lCyPvU9YFJAIetYrCEqKEEEd5jt4JUQYkW1M4nu3svVN6
         KIMOjx86p6BaV5HWB0i3AegckEYO3Z63daZgmJza2+CLglxq3KaNOnJ9exEKsa4J8pYO
         j/z9rFDBtDeU+wpK86twDxBwlTRykkxnIPmEfXxzbws6cwir4V2dOM9tIHhTWnsiMNof
         8DH/zGzafJYLvtwKg6HzfvNOCWGtT1VND63XNvAsbqoJr0l3KPQ775ropU68qDUshKRD
         nFTQ==
X-Gm-Message-State: APjAAAVODLOW43hoSYgKcFNZqPZ9GpdkQmU8BoA0KtEylY2FHqfHsVal
        8p7v4l4LVP1Wrrwc04M7ASc=
X-Google-Smtp-Source: APXvYqxIalPaoKYiF2nLfy96fdk++linlcojJZEIOf6BmPm9lyVYmegCqhre0nCJXeA6mRNWcYsUiA==
X-Received: by 2002:a5d:4f8c:: with SMTP id d12mr872410wru.150.1568055086702;
        Mon, 09 Sep 2019 11:51:26 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-0-86.as13285.net. [92.22.0.86])
        by smtp.gmail.com with ESMTPSA id p85sm810059wme.23.2019.09.09.11.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2019 11:51:23 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/6] rebase -i: support more options
To:     Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        martin.agren@gmail.com, newren@gmail.com, t.gummerer@gmail.com
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190907115034.14933-1-rohit.ashiwal265@gmail.com>
 <xmqq8sqxl557.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <d16a2c76-32c0-1080-a2de-00803ff84962@gmail.com>
Date:   Mon, 9 Sep 2019 19:51:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq8sqxl557.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/09/2019 19:02, Junio C Hamano wrote:
> Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:
> 
>> Following the suggestion of Phillip I've rebased my patch on master (745f681289)
>> and cherry-picking b0a3186140.
> 
> Sorry, but that's horrible.  The latter does not even cleanly apply
> on the former.

Yes I had assumed that the cherry pick would become the first patch of 
this series and be dropped from pw/rebase-i-show-HEAD-to-reword. I 
should have been more explicit about that.

> Let me see if I can find time to whip this into a reasonable shape.

As pw/rebase-i-show-HEAD-to-reword is slated for next perhaps these 
could build on that. The first patch needs am -3 to apply to that branch 
but the result looks ok and the rest apply as is.

Best Wishes

Phillip

> Thanks.
> 
