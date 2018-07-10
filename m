Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0FDC1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 18:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732986AbeGJSjw (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 14:39:52 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44076 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732424AbeGJSjv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 14:39:51 -0400
Received: by mail-qt0-f195.google.com with SMTP id b15-v6so19220025qtp.11
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 11:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=JuiGOWbBcGgeBKBxqb2/6DzdkHqQLfQ7xtafbkhXu0o=;
        b=TJmbeOcrlL2r4bvpzYBnVmMZYbOX2h/WUHJf9i8NEH2loE76Szn49A0ZEnQHrDTGy/
         4DInTsMMEIdLT82qpvNm91HbhZZ6nO4Wlsn3fl0EnrXOF05vm6F0/0G++omck7OjzfC6
         4fHThuPNmAdED3cZNre8+8KyTnQUVpA02SUtFj9rsNyCx/hhgu+4mt0dLsz8QaKvv5eI
         adOHQ9o+65PTnHVFbWnh2S0DyjpMeZ9SK3DmLFVfU5N6v3zv4005HBgYmCgRGNVYtnsv
         7TaOqt5oq53s3AbpqRSKMfy4l7hksrjQYe0y7wZdRCs7vUDp3N9/7l5Jte2KLO32lsrz
         05ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JuiGOWbBcGgeBKBxqb2/6DzdkHqQLfQ7xtafbkhXu0o=;
        b=lEeuUUeFajT6EilrSGGmtq81T7JIMmbEDF8PZd8IZugZezEvg7YZAn9Xee6fO3Odk6
         7JLHNZW7QeDe8a3xsde0QQowvJgtYyexWBQHuCQR+ZW6iTz/krKo+Ub55SgybvWpfDp7
         IsI6cPNSwuBnG+A1vHwyGIaPWQmWsx3F4j7Qlv3P5EFuXNFOM6ErXXJmCDqan5uBlp54
         iO0Q8F+/FWSgPIYtfMUTgC4XT5sZ8cHl9PRxPNCzvMmEpwWipuPs6Bg/L/NHPte6Bvje
         sTuXAikr28BK6eU5F5S3Q5+ymlaifiwbS9M657wx48dcbCEsUOsE9Oz+tyK98x4biTSZ
         ZCqw==
X-Gm-Message-State: APt69E2F6myGfPBjnewSoTB2cE4gJqJKNFjdxp/9QIxiTEcuM2CsUNud
        UPMQTni8xPDf/2CrJ5ZyXKylW68U
X-Google-Smtp-Source: AAOMgpeOJ67CTqRh3znAB+2ZH5e8ZoITXVaFI3ppeB2w2ziaNZRP/YiKhgxmpLWB8Gay/vPC2UfvVA==
X-Received: by 2002:aed:3e92:: with SMTP id n18-v6mr6234893qtf.236.1531246110053;
        Tue, 10 Jul 2018 11:08:30 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id p78-v6sm15368095qkl.38.2018.07.10.11.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 11:08:29 -0700 (PDT)
Subject: Re: [PATCH 07/17] commit: increase commit message buffer size
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
 <20180708233638.520172-8-sandals@crustytoothpaste.net>
 <4eb44f33-ac9c-7ce2-0e53-ec6fcb4560fd@gmail.com>
 <xmqqva9oe20y.fsf@gitster-ct.c.googlers.com>
 <20180709233952.GB535220@genre.crustytoothpaste.net>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <02c0682a-8cc9-be49-b646-00cbdb5783f3@gmail.com>
Date:   Tue, 10 Jul 2018 14:08:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180709233952.GB535220@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/9/2018 7:39 PM, brian m. carlson wrote:
> On Mon, Jul 09, 2018 at 10:45:33AM -0700, Junio C Hamano wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>>
>>> On 7/8/2018 7:36 PM, brian m. carlson wrote:
>>>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>>>> index a9a066dcfb..252f835bae 100644
>>>> --- a/refs/files-backend.c
>>>> +++ b/refs/files-backend.c
>>>> @@ -1587,7 +1587,7 @@ static int log_ref_write_fd(int fd, const struct object_id *old_oid,
>>>>    	char *logrec;
>>>>      	msglen = msg ? strlen(msg) : 0;
>>>> -	maxlen = strlen(committer) + msglen + 100;
>>>> +	maxlen = strlen(committer) + msglen + 200;
>>>>    	logrec = xmalloc(maxlen);
>>>>    	len = xsnprintf(logrec, maxlen, "%s %s %s\n",
>>>>    			oid_to_hex(old_oid),
>>>
>>> nit: 100 is not enough anymore, but wasn't a very descriptive
>>> value. 200 may be enough now, but I'm not sure why.
> 
> 200 is definitely enough.  Suppose we had a message consisting entirely
> of SHA-1 hashes (5, at 20 bytes a piece).  If our new hash is 32 bytes
> long, then it would require at most 160 bytes.
> 
> I only noticed this because the old code segfaulted.  My approach to
> using a 32-byte hash was to set it up, do some basic tests, find out
> what crashed, and fix it.  Most of this series is the basics necessary
> to get the most rudimentary functionality out of a 32-byte Git,
> excluding the index pieces, which are necessarily inelegant.
> 
> I didn't include them because there are other ways to implement the
> changes which are more elegant in some ways and less elegant in other
> ways, and I want to think more about it before I send them in.
> 
>> As Brandon alludes to downthread, we probably should use strbuf for
>> things like this these days, so a preliminary clean-up to do so is
>> probably a welcome change to sneak in and rebase this series on top
>> of.
> 
> Sure, I agree that would be a better change, and I'm happy to reroll
> with that.
> 

I've put together a patch to update log_ref_write_fd() to use strbuf and 
will submit it shortly.
