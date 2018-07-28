Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF4701F597
	for <e@80x24.org>; Sat, 28 Jul 2018 13:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbeG1PVx (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 11:21:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40146 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbeG1PVx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 11:21:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15-v6so7867686wrs.7
        for <git@vger.kernel.org>; Sat, 28 Jul 2018 06:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=K2ziJaR2B2kPO7XgY5dsWvB3UMqOmO55F/EjsxtTzFU=;
        b=EE88Y/UztZoGXhhwHOxGwgV1x8E0WqPyfiL5cydKx9JY6AJFKuC93/GG6vFeg9qaoT
         QEt+jasmVZWkGD7qc+7EGUO66P/WU6yKIp5sfETtaMNC73m7FgfsdrLW86TV0WW0FSCd
         HmvrZkdJIby0c4flqAilTP8MTjLJVgd2fZnurJ6iwReHUXgiSYfTZ/VwU9c+xgecIN7p
         51iFfgere9CCIMk4wGTct4F4GO/+OrermoERtnKC6RsRYyZlWyDb+x+M+jI/VDftt6Lm
         u5uLr+3oMYYtxHnaD2ySQO7hyMoCb/Z8cEH7omj+4dpPZ7NIRUuNxEJcNTxHnK199Nbp
         ZZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=K2ziJaR2B2kPO7XgY5dsWvB3UMqOmO55F/EjsxtTzFU=;
        b=B5ccoj4KGurSJFiUTgSCqCwEXR6qbgfpkyrJo5+fw+Wl+R2/WxzA1VczPPoEcCtOVc
         xCKex8NRRiHLGxyJQ7/t2g12SSjA7dP20DcEthxM/41Qr80Wve0zUyexLKz4FNLyviwC
         mHIZssaY+SL4e82hCLzgWwUlqqj69Ho6H6aNIM6LvwEIYGZJgiUuSSVcnt4fMgatwEsw
         iwyFMa0dRszWzkSKQ7ooUc9MksP5HD871Q62uKJzQREMo0ZYyqIGsGf40EqauKy2aj8H
         Zd/mHv/1+4BQejHustrvCJLneUu31FYx4dtvfkOl51b4K4Wzq1RWHu85qcI3Oo5FfMjY
         OhQA==
X-Gm-Message-State: AOUpUlFl6g28x3o2mHO93GCpAhytulMDPXkDoPtzyDKVpoe7lEUY/KMo
        4KC3jUORIoHOJCi4Lnv8DuA=
X-Google-Smtp-Source: AAOMgpd7x0QgQEiQ5PJ5cGjI0NS0L4VCHh5BPtpV4I2ln3/eEiBSUm0x0vN/OJETsWuyoDAFBhN1Zw==
X-Received: by 2002:adf:a49a:: with SMTP id g26-v6mr9531100wrb.91.1532786115172;
        Sat, 28 Jul 2018 06:55:15 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id x124-v6sm7864195wmg.38.2018.07.28.06.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Jul 2018 06:55:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 10/10] fsck: test and document unknown fsck.<msg-id> values
References: <20180525192811.25680-1-avarab@gmail.com> <20180727143720.14948-11-avarab@gmail.com> <xmqqbmasl5hq.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqbmasl5hq.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 28 Jul 2018 15:55:13 +0200
Message-ID: <8736w3v51a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 27 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> When fsck.<msg-id> is set to an unknown value it'll cause "fsck" to
>> die, but the same is not rue of the "fetch" and "receive"
>> variants. Document this and test for it.
>
> Interesting.  Before documenting and adding a test to cast the
> current behaviour in stone, do we need to see if the discrepancy is
> desired and designed one, or something we may want to fix?

We could change it. This is just something I ran into and figured it
should be tested / documented, and didn't feel any need to change it
myself.

The current behavior is probably more of an organically grown
accident. Maybe we should make all of these warn.

Trying to post-hoc rationalize these, it probably makes sense for
receive.* not to die, since you don't want pushes to fail if you're
tweaking this on a server and typo it, same with fetch (although less
so), whereas "fsck" tends to be more of an offline validation command.

So Yeah, I can change this, or not. What do you/others think?

>
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>  Documentation/config.txt        |  4 ++++
>>  t/t5504-fetch-receive-strict.sh | 14 ++++++++++++++
>>  2 files changed, 18 insertions(+)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 57c463c6e2..4cead6119a 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -1637,6 +1637,10 @@ In general, it is better to enumerate existing objects with problems
>>  with `fsck.skipList`, instead of listing the kind of breakages these
>>  problematic objects share to be ignored, as doing the latter will
>>  allow new instances of the same breakages go unnoticed.
>> ++
>> +Setting an unknown `fsck.<msg-id>` value will cause fsck to die, but
>> +doing the same for `receive.fsck.<msg-id>` and `fetch.fsck.<msg-id>`
>> +will only cause git to warn.
>>
>>  fsck.skipList::
>>  	The path to a sorted list of object names (i.e. one SHA-1 per
>> diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
>> index 7f06b537d3..62f3569891 100755
>> --- a/t/t5504-fetch-receive-strict.sh
>> +++ b/t/t5504-fetch-receive-strict.sh
>> @@ -198,6 +198,10 @@ test_expect_success 'fetch with fetch.fsck.skipList' '
>>  	git --git-dir=dst/.git fetch "file://$(pwd)" $refspec
>>  '
>>
>> +test_expect_success 'fsck.<unknownmsg-id> dies' '
>> +	test_must_fail git -c fsck.whatEver=ignore fsck 2>err &&
>> +	test_i18ngrep "Unhandled message id: whatever" err
>> +'
>>
>>  test_expect_success 'push with receive.fsck.missingEmail=warn' '
>>  	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
>> @@ -211,10 +215,15 @@ test_expect_success 'push with receive.fsck.missingEmail=warn' '
>>  	git --git-dir=dst/.git config fsck.missingEmail warn &&
>>  	test_must_fail git push --porcelain dst bogus &&
>>
>> +	# receive.fsck.<unknownmsg-id> warns
>> +	git --git-dir=dst/.git config \
>> +		receive.fsck.whatEver error &&
>> +
>>  	git --git-dir=dst/.git config \
>>  		receive.fsck.missingEmail warn &&
>>  	git push --porcelain dst bogus >act 2>&1 &&
>>  	grep "missingEmail" act &&
>> +	test_i18ngrep "Skipping unknown msg id.*whatever" act &&
>>  	git --git-dir=dst/.git branch -D bogus &&
>>  	git --git-dir=dst/.git config --add \
>>  		receive.fsck.missingEmail ignore &&
>> @@ -235,10 +244,15 @@ test_expect_success 'fetch with fetch.fsck.missingEmail=warn' '
>>  	git --git-dir=dst/.git config fsck.missingEmail warn &&
>>  	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" $refspec &&
>>
>> +	# receive.fsck.<unknownmsg-id> warns
>> +	git --git-dir=dst/.git config \
>> +		fetch.fsck.whatEver error &&
>> +
>>  	git --git-dir=dst/.git config \
>>  		fetch.fsck.missingEmail warn &&
>>  	git --git-dir=dst/.git fetch "file://$(pwd)" $refspec >act 2>&1 &&
>>  	grep "missingEmail" act &&
>> +	test_i18ngrep "Skipping unknown msg id.*whatever" act &&
>>  	rm -rf dst &&
>>  	git init dst &&
>>  	git --git-dir=dst/.git config fetch.fsckobjects true &&
