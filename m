Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E0691F4DD
	for <e@80x24.org>; Fri, 25 Aug 2017 11:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754790AbdHYLyr (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 07:54:47 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:6191 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754625AbdHYLyq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 07:54:46 -0400
Received: from [192.168.2.201] ([92.22.15.39])
        by smtp.talktalk.net with SMTP
        id lDCFdNFZLAp17lDCGdYsJE; Fri, 25 Aug 2017 12:54:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1503662084; bh=xjsKnX9SBZe+ztkhUkKQQyLOIeGcidIYGkJaGTxU3x4=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=oiPUT2tngnMfsVdgslARsY1oa46XbqLKr74w13B86D6mA/2TlcIarDj8WrSVzoC1J
         NPWPFytPQcf3Snh8Ppe/9w5qNiZfGQrPS3n+iRXaGDLyn/un5loo31AEvclB/lQVvu
         17p5QEb+eW4MGZuwj3O62yLgvBrSZPbH+Z33y4fA=
X-Originating-IP: [92.22.15.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=3EVUng5azuUHeJ78rNzxRg==:117
 a=3EVUng5azuUHeJ78rNzxRg==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=uVjv0A-H453jQOsI5awA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 0/5] Add option to autostage changes when continuing a
 rebase
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170726102720.15274-1-phillip.wood@talktalk.net>
 <xmqqa83rrrdu.fsf@gitster.mtv.corp.google.com>
 <xmqqa83qq2uf.fsf@gitster.mtv.corp.google.com>
 <xmqq60eeq24l.fsf@gitster.mtv.corp.google.com>
 <8cdda835-0b4f-6ffb-31bf-6192999818be@talktalk.net>
 <6a71f802-b20c-f6bc-7bb5-8d81db3353d8@talktalk.net>
 <xmqqpocloqcp.fsf@gitster.mtv.corp.google.com>
 <a3b7af29-8b3a-5253-21da-957920212a6e@talktalk.net>
 <xmqqinhg5ysf.fsf@gitster.mtv.corp.google.com>
 <d1eaed1c-5e62-0a93-f65d-06be43812617@talktalk.net>
 <xmqqefs34mz4.fsf@gitster.mtv.corp.google.com>
 <5dcd588d-b6ce-713d-dc28-25853d5bb4b3@talktalk.net>
 <xmqqtw0wx6b1.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <81909475-5801-c32b-efb5-a2a90c959a21@talktalk.net>
Date:   Fri, 25 Aug 2017 12:54:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqtw0wx6b1.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBoHMN+hsZCggi2/Z89x0QIHxOujqWyeYLkh4LKM3wUTQoTNRRg+r27ot371Gx12nLpyYMxYP0Wext0MGYkQN/gWGpkVxjPCiKypI7SZOp8hXL+KBy1B
 b+sDVn7S+8Q+uuB1lfBYKUQ+tc/cvPysuzjwlR29F4MMInlvrx3GWrviRqThi3LuyCbZ4vSAAcLM6dzzyLXmC6GmlbI2rrU4NsxaZDuOnJiQ3Uaixz4XhQKS
 sMjZ3Npx5+e1/6VVvKNpouXr9IykgdOx2bfoPK7heQg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/08/17 17:46, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> It could be expensive to check that the local modifications will not
>> interfere with the rebase - wouldn't it have to look at all the files
>> touched by each commit before starting? What do cherry-pick and am do
>> here when picking several commits?
> 
> Yes, so?
> 
> "I do not think of a way to implement it cheaply, so we forbid
> anybody from finding a clever optimization to implement it cheaply
> by adding a feature that will not work well with it when it
> happens?"
> 
Ouch, I think that is a rather unfair characterization of what I said
and certainly does not reflect what I was trying to say. I was asking
since cherry-pick and am can pick/apply multiple commits/patches and
apparently allow the user to start with a dirty tree what do they do
about checking that the applied commits/patches do not interfere with
any local changes. As for "adding a feature that will not work well with
it when it happens?" I suggested a possible solution in the message.

Anyway you're not convinced this feature is a good idea and no one else
has commented so I'll drop it.

Phil
