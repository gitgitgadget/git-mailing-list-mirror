Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17B5B1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 19:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbeKQFiw (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 00:38:52 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46061 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbeKQFiw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 00:38:52 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so17266483edb.12
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 11:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Fc0aFaw3Nb3eM1Wxw273nBhcTHjeWqGYkHEjTvh5nGE=;
        b=XLHws+oOIIojqwZmiTnnuQuYP50NpJncDdaQM257Hu4aWDu2VcWlRtrpQuOpsGGowk
         xgGqOOWqEnJVSKzMIqBTyh6BfFusOxDADD5oZxTMRTD+2Q0Kn00kopT/ukjPRly+u41l
         CChElcD9Oa1JLkMS2v0CgKutjPcKT5eyq9meVzG3+ta9uHCQeGuINFlD9q8q2OG8wvD/
         2VBdLu5g6H0PBELm4JSok1zUBdSwuojJy682k62Hqx+A/iWIrW+07gTAtnBLgPGMhZGk
         vtI7vLPdY8pRLfCNHVahTgK61+x6WF5/6gKefYnivMPF6MI84d4JdBl5QPuk9g/Sk7a2
         sIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Fc0aFaw3Nb3eM1Wxw273nBhcTHjeWqGYkHEjTvh5nGE=;
        b=sW8NN8BNQkAiPzNujA/v2qx0GvShcYa0u+uzDCRS0uacKRJC2ff9i0Mo6voXBmiBv8
         ziaMzQ/GQrc1n/cn/m3V/BMFG69j4dP9+Gj+7ffbV0L0Uvc1cP5ih69SHTPGQK5vMxxY
         ZJCx7tarFpnXhrQ7ALTZaU2y+LL4KQan23iSiHMbrJma8385fVvlqN1VqfHdx2Fetun9
         1blX3+6GkNIFGUSBVCURGazkXRaKLa6hXYRVWI3zfkekatNuOh2u6yEgllsnQewN3G1t
         HsFkaXVjF5c9xQMgLTOPOyk5sRisv1aDDlZlGkvEOsUtFiXuvp2Ulml9eoDsqWr6gCvM
         YfLQ==
X-Gm-Message-State: AGRZ1gLj0lu9tOAAKfCy7sBFObTA4N1Z3WP5Q3wFRmsYJ7DiYE68cx16
        Q1Vq+NrHJQmdMaYIVnpgS90VS67f
X-Google-Smtp-Source: AJdET5f/91AfdA2O232fZUpoKVNLw/m00g0aFUHLKoq7wBFCYAZSQHGaDmc3OtPss+No1xVzaCYioA==
X-Received: by 2002:a17:906:59d6:: with SMTP id m22-v6mr9526654ejs.20.1542396310208;
        Fri, 16 Nov 2018 11:25:10 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id b19-v6sm3295697ejp.77.2018.11.16.11.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 11:25:09 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] read-cache: write all indexes with the same permissions
References: <20181116173105.21784-1-chriscool@tuxfamily.org> <20181116182934.GN30222@szeder.dev>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181116182934.GN30222@szeder.dev>
Date:   Fri, 16 Nov 2018 20:25:08 +0100
Message-ID: <87h8gg25bf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 16 2018, SZEDER Gábor wrote:

> On Fri, Nov 16, 2018 at 06:31:05PM +0100, Christian Couder wrote:
>> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
>> index 2ac47aa0e4..fa1d3d468b 100755
>> --- a/t/t1700-split-index.sh
>> +++ b/t/t1700-split-index.sh
>> @@ -381,6 +381,26 @@ test_expect_success 'check splitIndex.sharedIndexExpire set to "never" and "now"
>>  	test $(ls .git/sharedindex.* | wc -l) -le 2
>>  '
>>
>> +test_expect_success POSIXPERM 'same mode for index & split index' '
>> +	git init same-mode &&
>> +	(
>> +		cd same-mode &&
>> +		test_commit A &&
>> +		test_modebits .git/index >index_mode &&
>> +		test_must_fail git config core.sharedRepository &&
>> +		git -c core.splitIndex=true status &&
>> +		shared=$(ls .git/sharedindex.*) &&
>
> I think the command substitution and 'ls' are unnecessary, and
>
>   shared=.git/sharedindex.*
>
> would work as well.

Looks like it. FWIW I just copy/pasted what an adjacent test was doing
for consistency, which was added in one of Christian's earlier changes
to this behavior.

But yeah, if the test can be made simpler in a portable way it would
make sense to make this a two-parter test cleanup & bug fix series.

>> +		case "$shared" in
>> +		*" "*)
>> +			# we have more than one???
>> +			false ;;
>> +		*)
>> +			test_modebits "$shared" >split_index_mode &&
>> +			test_cmp index_mode split_index_mode ;;
>> +		esac
>> +	)
>> +'
>> +
>>  while read -r mode modebits
>>  do
>>  	test_expect_success POSIXPERM "split index respects core.sharedrepository $mode" '
>> --
>> 2.19.1.1053.g063ed687ac
>>
