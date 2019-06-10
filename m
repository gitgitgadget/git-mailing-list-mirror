Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1FD41F462
	for <e@80x24.org>; Mon, 10 Jun 2019 17:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388642AbfFJR6D (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 13:58:03 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33176 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388592AbfFJR6C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 13:58:02 -0400
Received: by mail-vs1-f67.google.com with SMTP id m8so6024399vsj.0
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 10:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hH3rJH29foLuGGOSQgluWNVEvPHI4wGdVRCbR0qhKIs=;
        b=HzUIAEfDLZhah26CNCDTEA/uTO5nxFczAAUDs9+uq/q6tYlt65d39XDeILpPsICEfq
         kP0fUuJzRoNXYolnUQ7eXzgC9hhyQkO/u83zPXGVSINfbVyGmGrugMPMQ9tq546XJ8zS
         OFAS/O+h3rCA/SIJcxfjl3L4bkOJM8ns9Y06dGivpwl6ofkCb7JApU3xYRrq8kuTndDD
         fqPYb45XJmzNCz0UToeXRkH423+621lg3F0FUR1PKeyv2/DmuGf0ncIbVNCCip1/ayZP
         nXvk15sJZ786aOupVyZE/TJ68JdoDfomt/0m55j0RMSihas3lNvzrTZdpx6DHnWBl56X
         QKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hH3rJH29foLuGGOSQgluWNVEvPHI4wGdVRCbR0qhKIs=;
        b=oDm30LMdQ000Rs4dai+9PKywW9Dl+4WZROhw+NBQ48uvyiP9RuBZFiQa5FyF8VZsGS
         X4RT0ARv9g/75xuyRpC2XIvwTESNDKAGQObSJOX+Vuv9uV5uOjn/L3VxJVgMcQqxLJ9W
         NP1L4wCsS/qBdf+5gSCmnp8C6a9mHoRCF9CrJASUC5Uanz/xpYKZhSktS3Rz02j/esI4
         EVaS97GCo9MM/etFZgSRy25TuglMouJXKKTBBSIe+3bla6wroewy0h5EQsYUEbD8Pqte
         YabutZAnkfS4y9HDTsF53xdn32KGXaoYHpa1Ay0KzElUdBLONXOaWq3iX2r5Jg+zWLlg
         1K8A==
X-Gm-Message-State: APjAAAUowiWoFXTSmrkZEOScpZIqnQkwx4gYvngCJzYUQt56IpRLP7LO
        axwG6Q1U/01jjVYdYuAJoV10Ql/P
X-Google-Smtp-Source: APXvYqxAA98lpumFgn/clCL/QuTCaOGYt7oIkYxMFohrnLTzgKuSLKTRhtTqJGLjGnC9CK0/7HRY+g==
X-Received: by 2002:a67:dc01:: with SMTP id x1mr25248816vsj.153.1560189481831;
        Mon, 10 Jun 2019 10:58:01 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:a8d5:9520:fdfe:9e75? ([2001:4898:a800:1012:5a09:9520:fdfe:9e75])
        by smtp.gmail.com with ESMTPSA id h191sm1736493vkd.23.2019.06.10.10.58.00
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 10:58:01 -0700 (PDT)
Subject: Re: [PATCH v6 00/11] Create 'expire' and 'repack' verbs for
 git-multi-pack-index
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, dstolee@microsoft.com
References: <20190424151428.170316-1-dstolee@microsoft.com>
 <20190514184754.3196-1-dstolee@microsoft.com>
 <5fadd5ee-0993-ad94-2cda-f8dfe3795336@gmail.com>
 <xmqqy329mjns.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <39b0c277-0ab4-971e-bf10-3f232f0df8e4@gmail.com>
Date:   Mon, 10 Jun 2019 13:57:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <xmqqy329mjns.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/10/2019 1:31 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> On 5/14/2019 2:47 PM, Derrick Stolee wrote:
>>> Updates in V6:
>>>
>>> I rebased onto ds/midx-too-many-packs. Thanks, Junio for taking that
>>> change first. There were several subtle things that needed to change to
>>> put this change on top:
>>> ...
>> However, this series was dropped from the cooking emails, and never
>> included this v6. Now that the release is complete, could this be
>> reconsidered?
> 
> "reconsider" is a bit strong word, as (at least as far as I recall)
> it was never "rejected" as an unwanted topic, but was merely
> postponed to give way to other topics in flight.  Thanks for keeping
> an eye on it and finding the right moment to raising it again.
> 
> I could go back to the list archive and dig it up, but because it
> has been a while since it was posted, it may not be a bad idea to
> send it for a review, after making sure it cleanly applies to
> 'master', to make it one of the early topics to go 'next' during
> this cycle, I would think.

Sure, I'll create a brand new thread and point to this thread for
history.

Thanks,
-Stolee
