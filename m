Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F26BC43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26EC1206EC
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qw5EpU4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfLJU6W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:58:22 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:38947 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLJU6W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 15:58:22 -0500
Received: by mail-ot1-f50.google.com with SMTP id 77so16811325oty.6
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 12:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gPMdzbgT5KMkKory5nEVZCiG0PO3RdEvZ3kzLZGzQiI=;
        b=qw5EpU4tcRzoxwwoXZGeNptdaexSHjn9ka/fDeAOa88zVByezUzyEJICmLU1sxj4Wu
         03d6lJdz4f+/yHcxBtbR6xNERKz6Jp7CGkTBc9+PWD0pyblGNSL1rKkiECru3WIJOUqt
         cBPjowZx0dg9cydnuWSMMryp7Sq+LAZGvNjhi/YdfHSPSAi+7+BhDKOfuXA12NzMCJW/
         T/Z3tnqEsyC1w1zHqEqD7qvMwoxCSI/qjZQTc2Dj67i1htoD62wnusUBpmxEeajtTBag
         MWZW/V+qaO2XaA5x6pSwwUVg45q/8ZtC7bkWyktToqYV0EyPbDoU4vhxTKbWdj2MV3yy
         dQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gPMdzbgT5KMkKory5nEVZCiG0PO3RdEvZ3kzLZGzQiI=;
        b=C7KZ8y5pBXM9qpu+3pmdhZLkhSAh+VIqXLFIM9wdsbQBH4SQxXC+Pyz6TW6BuKuzr/
         QUOjfKXZC1gwIAqKvtsVoLrTUuxdoArNDG/whV6eeVcx3FGShuteWIf9W3/Nyt7iaS2J
         kd8G9RvGiwANIa17w5Od8pXmvX5o6RCEEFLm+a0czLld5V12fToT4Pe3Hwvy9XzD8G9l
         onzuJkFuAHFqf928eLYVT7scSdMqsrsQjr0HutF+YT5onw/CsrlZBzjGqHAu1jEqfc5k
         mCDXy4N8fzcn1es+jr8Ob5u72kuwftzOBSUwDNQe3KWSrkR/rq1Eu9zadRGFxXUZOSPJ
         8gLg==
X-Gm-Message-State: APjAAAVSFxOXHKH9VrP/6RvWEPlIb6WXa1qjDGHiPis6V+mVOIsJ+wKO
        HwjqDoDU6RJG46IvAkg5TzQ=
X-Google-Smtp-Source: APXvYqxyqw7llffmNEpk9LQrMpknHDkStjmThOpPjpBU67rC0R/SGlkYqZjb6sorbMGI69HizxUD3g==
X-Received: by 2002:a9d:6a98:: with SMTP id l24mr27676246otq.160.1576011501258;
        Tue, 10 Dec 2019 12:58:21 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id s9sm1788879oic.15.2019.12.10.12.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 12:58:20 -0800 (PST)
Subject: Re: Could /Documentation/technical/commit-graph.txt be relicensed
 under a permissive license?
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, KOLANICH <kolan_n@mail.ru>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
References: <E2770343-BB39-458C-835E-04F0753783C3@mail.ru>
 <xmqqimmoq6vw.fsf@gitster-ct.c.googlers.com>
 <70575b23-6adb-a29b-8df8-f9099f86eb0e@gmail.com>
 <20191210205056.GA14079@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2ed3e8f1-082d-4eb3-f1f1-e1d184003ced@gmail.com>
Date:   Tue, 10 Dec 2019 15:58:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20191210205056.GA14079@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10/2019 3:50 PM, Jeff King wrote:
> On Tue, Dec 10, 2019 at 03:38:35PM -0500, Derrick Stolee wrote:
> 
>> On 12/10/2019 3:10 PM, Junio C Hamano wrote:
>>> KOLANICH <kolan_n@mail.ru> writes:
>>
>> I don't appear to have the original message? Perhaps it was
>> directly addressed to Junio?
> 
> It made it to me via the list, too.

Hm... I have had messages from the list be delayed somehow by Gmail.

>>> GPL copyright protects the expression of the document, but the
>>> copyright protects only the expression, and does not protect the
>>> underlying format itself and the idea behind it.  So I do not see a
>>> need to relicense the documentation text at all.
>>
>> (Insert "I am not a lawyer" warning.)
>>
>> I think this is the correct interpretation. One can interact with
>> binary files as you want. In fact, there are likely privately
>> licensed products that interact with Git's pack-files even though
>> their format documentation is under GPL.
>>
>> What _could_ be problematic is repeating the documentation directly
>> in another permissive-licensed repository.
> 
> That's my understanding as well. That said, I would not be opposed to
> some kind of statement in the documentation making our view explicit.

A similar statement could apply to the following files:

Documentation/technical/bitmap-format.txt
Documentation/technical/commit-graph-format.txt
Documentation/technical/http-protocol.txt
Documentation/technical/index-format.txt
Documentation/technical/long-running-process-protocol.txt
Documentation/technical/pack-format.txt
Documentation/technical/pack-protocol.txt
Documentation/technical/protocol-capabilities.txt
Documentation/technical/protocol-common.txt
Documentation/technical/protocol-v2.txt

and perhaps others, including future additions.

Would it be better to have a new file in
Documentation/technical/ that describes this view?

-Stolee
