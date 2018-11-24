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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7056E1F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 11:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbeKXWeS (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 17:34:18 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39952 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeKXWeS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 17:34:18 -0500
Received: by mail-ed1-f68.google.com with SMTP id d3so12125052edx.7
        for <git@vger.kernel.org>; Sat, 24 Nov 2018 03:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=uksMSyLYCoHgGYWA7soZeDmlVATJPAxVLYmsYkEMON8=;
        b=Z3zsw4WA+ZrDDpxLxZ+fHs4dIJWJoTOWAxgC9kswRjQSAQeWyRVSeMAXpiZHwGUN4/
         tPR5g4ZwX7JdwgTWQKt6FmzNGf4j1sRJrQITXOabxIiOjuf0uu6tPKaEiRij3kQHHrCm
         eC/jTO/yTMfiJsH/QpnFi/pzdgRiHgwjFU77pJPi65qV7xb+L/uqsPIgmcdUv4Ae117u
         LUUgtAEfMdaezVRXxLtCD556J1STbRCIaAhx4VVCECY5+KBRptiQ9h4TLQ6eUijplzYZ
         kEW4TvfgevzsotyD8oAQEeZTq4QmfhnULUxKPFE5LqPaCcJqLQqezE8RrKrVjfG+s2+w
         HWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=uksMSyLYCoHgGYWA7soZeDmlVATJPAxVLYmsYkEMON8=;
        b=Aacvor7A2z58HWtR07d69+r+U+jUlznA5I3mcX5nJDrBhATN6DhGrBt4ICsanB9X/2
         lkvdY4sYS3IKwbd/X4uaZuzBvrZJqZakeEUKdIukzwXVxnBxg5dNHQb23HVhM/EVVMix
         2gsF4TswGCPtzSyNLzSjJPcJuMx7OFEnfD+CdATR3fIYnu1umQd9LLS0VP7Xo+vlc5fC
         qvRENfL/MGNcHwF5TJfwmyK8CQvwXY/j1L/JJupvULr+vpnxMsI1ep2rwp1vLu2B0ufm
         EoU7Cv5yMvWXmpEFMbTUDR3tV2mdP7cj62gXknNs+cS4QYxr7MhaCUgBVzZLo9F8OFJN
         2yyA==
X-Gm-Message-State: AA+aEWZRLWrE2MyuEQqHu/32SgjDT/IElw4peWw/BH3KBVZuQUfL/xDK
        E3cbwAvNfLku5axRdoj47EHMSMCp
X-Google-Smtp-Source: AFSGD/XpHZBBt1NGWL/1uSey6+GY+CngWVgkQ7PcKwtoE1QRwYGbkbLnY7oo6PJ6OhmaUwaOHr4pSQ==
X-Received: by 2002:a50:fa0c:: with SMTP id b12mr15743189edq.138.1543059960895;
        Sat, 24 Nov 2018 03:46:00 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id q4sm12051030eda.50.2018.11.24.03.45.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Nov 2018 03:45:59 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] format-patch: add a more exhaustive --range-diff test
References: <CAPig+cSzyT5N5=YeX+VgRq1t0VbWqXLHSB=g=V=O-nLdCWrE9g@mail.gmail.com> <20181122211248.24546-2-avarab@gmail.com> <xmqqo9af2jte.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqo9af2jte.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 24 Nov 2018 12:45:58 +0100
Message-ID: <87bm6e1yx5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 24 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Change the narrow test added in 31e2617a5f ("format-patch: add
>> --range-diff option to embed diff in cover letter", 2018-07-22) to
>> test the full output. This test would have spotted a regression in the
>> output if it wasn't beating around the bush and tested the full
>> output, let's do that.
>
> This looks wrong, given that we are declaring that showing the
> broken --stat in the output is wrong.  It makes us to expect a
> known-wrong output from the command.
>
> If the theme of the topic were "what we are giving by default is a
> sensible output when --stat is asked for, but it is rather too noisy
> and our default should be quieter---let's tone it down", then this
> patch in 1/2 and then a behaviour-change patch with updated
> expectation would make sense, but I do not think that is what you
> are aiming for with this series.
>
> Perhaps squash this into the real "fix" to show what the desired
> output should look like with the same patch?

I see you did that in 'pu'. I don't mind, looks good to me.

FWIW I split this up for ease of review, i.e. showing what the output
was before and what effect the code change had, but maybe that was
overdoing it and it's simpler just to have this all in one go.

>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>  t/t3206-range-diff.sh | 27 ++++++++++++++++++++++-----
>>  1 file changed, 22 insertions(+), 5 deletions(-)
>>
>> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
>> index e497c1358f..0235c038be 100755
>> --- a/t/t3206-range-diff.sh
>> +++ b/t/t3206-range-diff.sh
>> @@ -249,11 +249,28 @@ for prev in topic master..topic
>>  do
>>  	test_expect_success "format-patch --range-diff=$prev" '
>>  		git format-patch --stdout --cover-letter --range-diff=$prev \
>> -			master..unmodified >actual &&
>> -		grep "= 1: .* s/5/A" actual &&
>> -		grep "= 2: .* s/4/A" actual &&
>> -		grep "= 3: .* s/11/B" actual &&
>> -		grep "= 4: .* s/12/B" actual
>> +			master..unmodified >actual.raw &&
>> +		sed -e "s|^:||" -e "s|:$||" >expect <<-\EOF &&
>> +		:1:  4de457d = 1:  35b9b25 s/5/A/
>> +		:     a => b | 0
>> +		:     1 file changed, 0 insertions(+), 0 deletions(-)
>> +		:    :
>> +		:2:  fccce22 = 2:  de345ab s/4/A/
>> +		:     a => b | 0
>> +		:     1 file changed, 0 insertions(+), 0 deletions(-)
>> +		:    :
>> +		:3:  147e64e = 3:  9af6654 s/11/B/
>> +		:     a => b | 0
>> +		:     1 file changed, 0 insertions(+), 0 deletions(-)
>> +		:    :
>> +		:4:  a63e992 = 4:  2901f77 s/12/B/
>> +		:     a => b | 0
>> +		:     1 file changed, 0 insertions(+), 0 deletions(-)
>> +		:    :
>> +		:-- :
>> +		EOF
>> +		sed -ne "/^1:/,/^--/p" <actual.raw >actual &&
>> +		test_cmp expect actual
>>  	'
>>  done
