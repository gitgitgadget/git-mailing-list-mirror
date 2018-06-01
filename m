Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AF881F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 19:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeFATnW (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 15:43:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38443 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbeFATnV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 15:43:21 -0400
Received: by mail-wm0-f66.google.com with SMTP id m129-v6so4382447wmb.3
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 12:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=85avf/3kCvldjCrAp5EhM9jexzEihWG2ae/uRvqlyys=;
        b=AhJ3gAr+AG9c0dDLXVQGqg4CObb+jPBRABt4dfLACIs0mHmL96ieNpw/NlX/iGUghj
         KKAbzz770RIxBH1wC3WEzJ4Dn6gugs4MRbOeV3idQMMk5rN8iMpG83QDCd+QvB5ZQjr8
         SgytODvIv/9HkdP01u6leJ67YEir5CpRw6FwjTDgi/qBT8BzzgHxllbgjCP+0BlS+8NJ
         emLbCUVyiFZnApBvsu02oqrmoOaTqpcxAQgTPnROdtu5WkIMNCWnF1gIj2eIOdcDLZ+t
         WW3icTXyCNLCHkprTBU6tHYv/PglfDstfgwNfRqS6eCsgoX6sjSvS3kO3RYb+NoQ6E8E
         sypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=85avf/3kCvldjCrAp5EhM9jexzEihWG2ae/uRvqlyys=;
        b=lhTCvSJI69BPVwGoVXIpO3v9hfQ9elRYMSymEAQHDxqlvvzcumenijOFa2tv+L+KGv
         fC5WfbSfZmucduEHaaqjxwaVh7FNTn7yymIQ03XQ8xRV+uCkUUjKNEy996+ec1Ka7oWe
         JKoJxK6I9EGaSqoG/71rurjr+BRnWXfHrWM/Cbtg7K7CYSyPNgJLe6hTWH+YfcLMssUc
         UrwNp2m1f82S/DwxzEStiM0HS6RALYZyU5sJbkT3DFTib9GKhjlDpXtLiIDTrjoU6BKb
         yT1OT1i8KrOZnwoBz1DVwJ2CRQL4q1RyyUVm8tHj5D8P695nMLO2OjcWAIn8xF9XFZzk
         PZlQ==
X-Gm-Message-State: APt69E25VgNS1C/1s+V1op62KHPxDj/YBJ+J4niQaFNCGe7Ks+SEfHI/
        VfAswJgxzTRROqkLlyIzAPo=
X-Google-Smtp-Source: ADUXVKJWoCs/riCKSWnqpamoLLhg0YXuFLZxfcrpSef+sh4Vt4qitI8TSK/3M9eC66oX3ulZgQioGA==
X-Received: by 2002:a50:b723:: with SMTP id g32-v6mr2137887ede.139.1527882200174;
        Fri, 01 Jun 2018 12:43:20 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id u8-v6sm23767142edj.2.2018.06.01.12.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Jun 2018 12:43:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/9] checkout tests: index should be clean after dwim checkout
References: <20180531195252.29173-1-avarab@gmail.com> <87a7sg9sjz.fsf@evledraar.gmail.com> <20180531195252.29173-2-avarab@gmail.com> <xmqqwovj882f.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqwovj882f.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 01 Jun 2018 21:43:18 +0200
Message-ID: <87y3fy8f8p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 01 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Assert that whenever there's a DWIM checkout that the index should be
>> clean afterwards, in addition to the correct branch being checked-out.
>> ...
>> So let's amend the tests (mostly added in) 399e4a1c56 ("t2024: Add
>> tests verifying current DWIM behavior of 'git checkout <branch>'",
>> 2013-04-21) to always assert that "status" is clean after we run
>> "checkout", that's being done with "-uno" because there's going to be
>> some untracked files related to the test itself which we don't care
>> about.
>
> It might not be absolutely necessary to state, but it would be
> helpful to say that you are assuming to start a checkout (DWIM or
> otherwise) from a clean state; without the assumption, the readers
> need to think for a few breaths why "the index should be clean" is
> true.
>
> The intention and the implementation of the change both mostly look
> good to me from a quick read.

Makes sense, will fix.

>>  test_expect_success 'setup' '
>>  	test_commit my_master &&
>>  	git init repo_a &&
>> @@ -55,6 +61,7 @@ test_expect_success 'checkout of non-existing branch fails' '
>>  	test_might_fail git branch -D xyzzy &&
>>
>>  	test_must_fail git checkout xyzzy &&
>> +	status_uno_is_clean &&
>>  	test_must_fail git rev-parse --verify refs/heads/xyzzy &&
>>  	test_branch master
>>  '
>> @@ -64,8 +71,10 @@ test_expect_success 'checkout of branch from multiple remotes fails #1' '
>>  	test_might_fail git branch -D foo &&
>>
>>  	test_must_fail git checkout foo &&
>> +	status_uno_is_clean &&
>>  	test_must_fail git rev-parse --verify refs/heads/foo &&
>> -	test_branch master
>> +	test_branch master &&
>> +	status_uno_is_clean
>
> Hmm, what's the point of this second one?
>
>>  '

Slipped in, will remove. Thanks.
