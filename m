Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 367991F404
	for <e@80x24.org>; Thu, 13 Sep 2018 12:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeIMRab (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 13:30:31 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:40551 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbeIMRab (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 13:30:31 -0400
Received: by mail-qt0-f174.google.com with SMTP id h4-v6so5085653qtj.7
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 05:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PxkNpPokPnBksYPnNnIxGYdpSc0tzxe5y6AorcxXCVo=;
        b=FZ3rW4xzTw2hwYzo8YCWsmRdJuZSs34ZzbXL6EcosQBICQzqMeHbi0dQhJTCPwNYhc
         FWFbMFilElBcuL1yJWlBUIg2Yxili8NyNtvoQDJAjnQSEpC6MyGfm5sHv/ZIp9JB2GKj
         2ywEwEMxQE2ol1wNmFV7eIFimXCiJfQMd15PyJ/XZ/l/8JlcXXkeZPI8fxSCzTbUhNbQ
         DV13I63FMTl/skIhYkHtWMENEp4WXegi9X3hORBo3R8H0R1n7tvMeio7vCnx5SBpAtwV
         H3sdEjt7sCw/luyXv6FQGiocbStnB4XAQKZYn5vbMv29nlkzhn22uTlKg39OIIghFssR
         9koQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PxkNpPokPnBksYPnNnIxGYdpSc0tzxe5y6AorcxXCVo=;
        b=cU5cQ7LzxNFIPO4FzM2q+/TKtFDtjqehpvhs8bhHqT1r/O5EYmDkMPRZAJCBJqdQzY
         MBtOWIkD0oeb0jjYBAeA8yIPH5Fb581ShOfDzX0eYLoPdvIsZ7784fTG3dzsieysTD6V
         hTlvJz/sQoJLZgVMe5cPxxruaUuKV9x0JaYIYnkjmhPYVKLLSBtjWodOvz3HGQNZpIId
         clepCcC7NYC9I3gN5bt5BdaBRcxLZQflI3BZjRYCepnW7K2l8DfZjK6/legMwMHNOWGp
         qfvOBgcCoO5rB5X7u8UHwpXchBR2zVlhiwBJN+YANtbYJHyQn7QzTnvZg0j9FI0Bi5rs
         o9cQ==
X-Gm-Message-State: APzg51CvuNYQxorLkTLmWiGBL7Xlgudxm0Ukuk03iwCtzU9AZ2hPbJB6
        LR383yHE0zzm3yWoIntmTJI=
X-Google-Smtp-Source: ANB0VdYlUI+YwQWmcl34+prHwEU5dKM6ppXmaeBLm83bXmJxlOez5ekA8Jkj+Sle8wcnl2IhwQUnKA==
X-Received: by 2002:ac8:26e2:: with SMTP id 31-v6mr5065237qtp.179.1536841276675;
        Thu, 13 Sep 2018 05:21:16 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4d62:f7e6:b4da:73ac? ([2001:4898:8010:0:3698:f7e6:b4da:73ac])
        by smtp.gmail.com with ESMTPSA id s35-v6sm2600695qtj.79.2018.09.13.05.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 05:21:15 -0700 (PDT)
Subject: Re: [PATCH 1/1] contrib: add coverage-diff script
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.40.git.gitgitgadget@gmail.com>
 <e4124471e5494b737d99eceed25fb03e787d0b96.1536770746.git.gitgitgadget@gmail.com>
 <xmqqa7omjred.fsf@gitster-ct.c.googlers.com>
 <xmqq5zzajpi1.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1e712541-3101-049a-acd2-b6d7c98bd1e2@gmail.com>
Date:   Thu, 13 Sep 2018 08:21:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqq5zzajpi1.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/12/2018 6:54 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>>   contrib/coverage-diff.sh | 70 ++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 70 insertions(+)
>>>   create mode 100755 contrib/coverage-diff.sh
>> I fully appreciate the motivation.  But it is a bit sad that this
>> begins with "#!/bin/bash" but it seems that the script is full of
>> bash-isms.  I haven't gone through the script to see if these are
>> inevitable or gratuitous yet, but I'd assume it made it easier for
>> you to write it to step outside the pure POSIX shell?

I completely forgot to avoid bash, as I wrote this first as an experiment.

>> ...
>>> +	elif [[ $REPLY =~ \+\+\+\ (b/)?([^[:blank:]$esc]+).* ]]; then
>>> +	    path=${BASH_REMATCH[2]}
>> OK, it probably is easier to write in bash than using expr if you
>> want to do regexp.
> Just to clarify. I am saying that it is OK to give up writing in
> pure POSIX and relying on bash-isms after seeing these lines.

I'll try rewriting it using POSIX shell and see how hard it is.

Thanks,

-Stolee

