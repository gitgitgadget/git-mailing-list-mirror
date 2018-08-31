Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EA6A1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 22:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeIACLy (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 22:11:54 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33031 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbeIACLx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 22:11:53 -0400
Received: by mail-ed1-f67.google.com with SMTP id d8-v6so2002129edv.0
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 15:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=k17ZRHyUjcDHkmuZVvfwRf/htTxS8P7jJGX+SD2eGeI=;
        b=ApPO9GCavHXDUw38QABfZrNoi5P09FovknoyRMvaz1AafTzx5fqdr2ox24HC6rBV6h
         INs49U96XiFQKghChM93BEVZE/GF/AjcOeiXjCa1a4/Soct5wSnjkKeM+ib5Dd/BQW3S
         Mq2oR1euUj93ZE/hZl6TlIfL3UDG9BtBqJui7/LLkBiat/jtm4VI/QwldgyXGNB3OG9/
         KpJPtHcTviloFX2Oa2tgB/ONODBGz34mBq/SyJmbBd921CcXFF+SGrRGRtG0Y+5y6TjN
         jQf0A6g34a+Nrlx+sBze3qc8/Fe6Ml4KHwRDHVS49S2lQOEaKcSAUMTE8AP9zmHIEFTl
         5WUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=k17ZRHyUjcDHkmuZVvfwRf/htTxS8P7jJGX+SD2eGeI=;
        b=N8XvAhwCwRt12xF4Mi3EWOGBxEYH4YRxjb3P7EnnA1JaTMt5VQzPM4/ZoncFlpqKJM
         y0o0Yl4gDwMTCg86STjrfGYfn6k2/Z4I8MLbbQpiPtJSOTOKP2B+VkWotuaf7BZSS7rk
         a892t8syzqQGh156o7jfDP1p7dc+g11bv1uT4+X4OsRHNs1i5qvEt+6mqbyXYaD+SOGW
         XEvHZ2MdbJDcDpTuWpmZXjK8Q5WN4g/hs8Y5jlkNBPIRfgt2apOJ5Pn1+KiVQyA3IzVd
         mYiaH3YcLAQ32pnNTmmVjSn9Uqds33S5e/wRAomXriTdl07pffdmauPdqLh7FKBiDObf
         84eg==
X-Gm-Message-State: APzg51D50ovBn4ahCxjM878TG51qzbNmS+q4D3UIIdZG8iTCSGKq5YSL
        ECdKnoYrA6sfy/sfJii5vXQ=
X-Google-Smtp-Source: ANB0VdalNf96f0QA+VYSKiUci1YPrul+j3Z4v6OvPE39EAbisvBOnKthYSZseXxJQXOxB5qvNYLXCg==
X-Received: by 2002:a50:9135:: with SMTP id e50-v6mr19831528eda.312.1535752944543;
        Fri, 31 Aug 2018 15:02:24 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id i3-v6sm5727570eda.84.2018.08.31.15.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 15:02:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v5 2/9] push tests: make use of unused $1 in test description
References: <20180830201244.25759-1-avarab@gmail.com> <20180831201004.12087-3-avarab@gmail.com> <xmqqftyu1byv.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqftyu1byv.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 01 Sep 2018 00:02:22 +0200
Message-ID: <871saechzl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 31 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Fix up a logic error in 380efb65df ("push tests: assert re-pushing
>> annotated tags", 2018-07-31), where the $tag_type_description variable
>> was assigned to but never used, unlike in the subsequently added
>> companion test for fetches in 2d216a7ef6 ("fetch tests: add a test for
>> clobbering tag behavior", 2018-04-29).
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>  t/t5516-fetch-push.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
>> index 539c25aada..62d5059f92 100755
>> --- a/t/t5516-fetch-push.sh
>> +++ b/t/t5516-fetch-push.sh
>> @@ -969,7 +969,7 @@ test_force_push_tag () {
>>  	tag_type_description=$1
>>  	tag_args=$2
>>
>> -	test_expect_success 'force pushing required to update lightweight tag' "
>> +	test_expect_success 'force pushing required to update $tag_type_description' "
>
> Of course, $1 needs to be inside "dq-pair" for $tag_type_description
> to be substituted ;-)  So I'll tweak it while queuing.

D'oh! I knew I'd miss something. Hopefully this was the only thing.

> All the other ones in this series looked sensible to me.  Will
> replace.

Thanks!
