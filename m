Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF2AA1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 17:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390956AbeIUXah (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 19:30:37 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:36030 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390713AbeIUXah (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 19:30:37 -0400
Received: by mail-qt1-f181.google.com with SMTP id t5-v6so2509811qtn.3
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 10:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rNJceQMxrvTO0wiNRURY0oIOVnkjVxx9nQqPJFexZt4=;
        b=iAgjq+KyOMpVDmZv/Gf4EAwAIdvllQsYXptH6Tc8qDL0EytWoIbhQakhMOJuZW901J
         Y0LCzys7IIsohLqKD280VUhdy/u9mRI1pIcYXOW5iWNrXe5RG2q4P4XeTlXg6FrBMKyJ
         Zo2H3HaPWFwccXf+C6CxtWfrFLedRUCfG7Y6zKAJAUNoPWhdlFBfyv1B/ZGpR/o7sJqJ
         F1WRRlECIrbtyFhmVeCmKKBuM0j/ahF/1Cl/9F0p/Solde7xKu651EkeKqbbT0Uvguid
         EYAaYRLL9byWWI7dWCD6ckhmzDK+ScEQ6YtAss4fsOxMKRp9bfsl/ADBVJcBFOl2NFmC
         ldQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rNJceQMxrvTO0wiNRURY0oIOVnkjVxx9nQqPJFexZt4=;
        b=pPCLOSumo20Eb81E5//kj/6UpA+B7zM0jQqvnpLRXkbyXPDfwR0UDH3eGjMeXAPD6f
         c8Sq7xVQR/68kD32MaE43hCbdTN1RdS14j0U/Mq/t5Bhwus5gvcffVY/+AJSaE7QPiKT
         BQajWQOugTuRMgP2hNryh8TLkeBniHY9s4JpZp4jwL/53XQgAWP1UQ//qnjHtvJDc/5t
         D96/jBgIYU2jrQP5YCUTXxtUUlgwSGywRbS9gye/0NimiEkn/2GNfgRFwvmNG175BunP
         QYmi1An5SsyF8+5z60oG7r2hwnBQUceYAdg7/QPZrBIFTobxz8PfkDtHZemGT0ryS8KI
         HDVQ==
X-Gm-Message-State: ABuFfohSOqeLrCFeG+X6+ZqUWl0PoDZG/mCJBDAVEj3k3Wf3LrHIebJv
        wBhX0qU/wVYN5PnLxPWJJSk8QsGe
X-Google-Smtp-Source: ACcGV62QCR8qA6Tdw3xhXfMeVTizSNaSErctqHa2AubOfaz21OYZMdejf5setC/x+XZHFS/5AuRXGQ==
X-Received: by 2002:a05:6214:1087:: with SMTP id o7mr1286952qvr.228.1537551641119;
        Fri, 21 Sep 2018 10:40:41 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f452:f7ab:45dd:bf7c? ([2001:4898:8010:0:dd88:f7ab:45dd:bf7c])
        by smtp.gmail.com with ESMTPSA id a10-v6sm18115622qkj.60.2018.09.21.10.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 10:40:40 -0700 (PDT)
Subject: Re: [PATCH] fetch-object.h: add missing declaration (hdr-check)
To:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
References: <12cd9928-d04d-d208-a1b4-ceecbdf79432@ramsayjones.plus.com>
 <xmqq1s9myg67.fsf@gitster-ct.c.googlers.com>
 <f6663e27-cfe6-c927-746c-dfbeed5bb3a2@ramsayjones.plus.com>
 <xmqq7ejewzl9.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f3fcdef1-e051-0132-5cde-839188374ad7@gmail.com>
Date:   Fri, 21 Sep 2018 13:40:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqq7ejewzl9.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/21/2018 1:05 PM, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>
>> BTW, I notice that patch #9 (commit-reach.h: add missing declarations
>>   (hdr-check)) didn't make it onto 'pu' - was there something else I
>> needed to do? (I am still in two minds about sending an RFC patch
>> on-top of patch #9).
> I refrained from queuing it as I did not sense a clear resolution of
> the discussion.
>
> I found it a sign that you may want to update the log message to
> explain "instead of adding a few forward decls, include the whole
> commit.h because..." that you had to explain why the patch did what
> it did to Derrick in a follow-up message.

Also my fault for not saying "That's a good reason, thanks for 
explaining!" (I'll add that to the necessary thread.)

-Stolee

