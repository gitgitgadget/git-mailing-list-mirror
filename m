Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 264522018D
	for <e@80x24.org>; Tue,  9 May 2017 22:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750847AbdEIWis (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 18:38:48 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35089 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdEIWir (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 18:38:47 -0400
Received: by mail-pf0-f180.google.com with SMTP id v14so6598930pfd.2
        for <git@vger.kernel.org>; Tue, 09 May 2017 15:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Z1mu2Ebxd0hlqR5ib7VO/szt/KPjkl9T5pt/NFNqDN8=;
        b=Y6xYSDPmJrGPKBmAXK9sVCUQEGb3dLXUUVX5JilUmWAI2ejcrqt1Zhqw2IhXhQt290
         YR1vLhzj20Mq4I4upCFTpxpWjfB9Gxi65K0z5hIp0ZFiqaQhVmknK/uOA+hoFQLfOr95
         xgd0gZlqsRNZThOVzTSAh/y8x07BGmdWk66meyNmi/rPjT2G/zuK7rZSvp6VC3frYynq
         T4ZWUJaqdOmTL5iPBgYFjjxV+JgYunlwA08yjgsmt5EHD3a9B5dSAvllVEavdIZUmzxi
         +20NyTVhxG1/r5smX2j026JmcTzg+43WdX99kpjK0hvZHCksy6GUAH8XCmvFuEkdOUGn
         mI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Z1mu2Ebxd0hlqR5ib7VO/szt/KPjkl9T5pt/NFNqDN8=;
        b=B9vnqxsOwkChv2gGZ/fKMLAmFV3n9V75wRGJNHqc/MQDwxH5RzD8pK43vndpiNI9mL
         bSW9AO9nugYfYRfzQ2wncuF0QsIv4xOfkkx2wZ4qqT5H4mO5hi7J3plwcK2lfW9GEdRU
         fk0FVaxfENZqkok3nT0GlYig6OvpZr8H+EugzLBQ9dvb7L2nwNB9oKFZkyRmgiTQavBX
         +tfSqcQF4pwqlqq09v+H+VJOfPItPeRzEs9FMEdrG7kLCvPm7HKi9RPKlNsLwIany7I2
         5+kuZbP6pdFigZ6HeRkQusWLucHYuaF2XKLNO42csie6WHVtxTY2odgaiXTsZxz/jvp6
         ramA==
X-Gm-Message-State: AODbwcDGGgufmAgKawm9fFjVV9XB7lO/mw63GNoXqr+ohTYP3PKn6aUg
        ERIOhaIeIILvcw==
X-Received: by 10.98.202.149 with SMTP id y21mr2519698pfk.225.1494369526565;
        Tue, 09 May 2017 15:38:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9133:cf19:b689:27d6])
        by smtp.gmail.com with ESMTPSA id l198sm1641093pga.50.2017.05.09.15.38.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 May 2017 15:38:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] fixup! use perl instead of sed
References: <xmqqfuge4sak.fsf@gitster.mtv.corp.google.com>
        <20170509164515.31942-1-jonathantanmy@google.com>
        <CACBZZX5DF6sTTYSUpYnvas925N-XsoUGrM-bYbAN_67g8-w2GQ@mail.gmail.com>
Date:   Wed, 10 May 2017 07:38:45 +0900
In-Reply-To: <CACBZZX5DF6sTTYSUpYnvas925N-XsoUGrM-bYbAN_67g8-w2GQ@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 9 May
 2017 19:00:14
        +0200")
Message-ID: <xmqqd1bh1wqy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Tue, May 9, 2017 at 6:45 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> ...
>>         # Tweak the push output to make the push option outside the cert
>>         # different, then replay it on a fresh dst, checking that ff is not
>>         # deleted.
>> -       sed -i "s/\\([^ ]\\)bar/\\1baz/" push &&
>> +       perl -pe "s/([^ ])bar/\\1baz/" push >push.tweak &&
>>         prepare_dst &&
>>         git -C dst config receive.certnonceseed sekrit &&
>>         git -C dst config receive.advertisepushoptions 1 &&
>> -       git receive-pack dst <push >out &&
>> +       git receive-pack dst <push.tweak >out &&
>
> The test should have a PERL prerequisite now, that's missing.

For a single-liner like this, our stance has always been that t/
scripts can assume _some_ version of Perl interpreter available for
use, cf. t/README where it lists prerequisites and explains them:

     - PERL

       Git wasn't compiled with NO_PERL=YesPlease.

       Even without the PERL prerequisite, tests can assume there is a
       usable perl interpreter at $PERL_PATH, though it need not be
       particularly modern.

So unless "receive-pack" that is being tested here requires Perl at
runtime, we do not want PERL prerequisite for this test.

> Also using \1 will likely be deprecated in future versions of perl at
> some point:
>
>     $ echo hifoo | perl -wpe "s/([^ ])bar/\\1baz/"
>     \1 better written as $1 at -e line 1.
>     hifoo

Very good advice from a Perl expert; thanks.
