Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19BC71F462
	for <e@80x24.org>; Tue, 30 Jul 2019 21:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387579AbfG3VTM (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 17:19:12 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:35336 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387496AbfG3VTL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 17:19:11 -0400
Received: by mail-wm1-f46.google.com with SMTP id l2so57865696wmg.0
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 14:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GC7KZx5EamiOU/8N/QzJONN2Ugjez9hWvN3kPb9zSSw=;
        b=SF9vSqPKfYGkUo34MFifWblOy5ZB5ST2mKoU7z0DA/jGSU6zDsN7dTOHPIYSJDLpkA
         AqtXysggUokLpGg2JxjeW0kwg5/49b2UEZ0Tn+uivpBqCizv5ZYk9J2xH72/C+1Skox0
         /SFE7ekvMlnMhELwiCVI5y/Qi/7dg0Js5BnAubZimr4qgy3Pj/TTorQyn05WTRB0jN23
         2Ehm2ryyrhxSD3mRSu2Uo7ELAvhy0Yq6iJ909Pg6E1ce8q3/qO3XHa9pip0x18Lqt8OR
         j8UlNcNiWR0MerCX1WMq9H6JODKqehc47KJQRr3scxZspONA591lfJNWNno6OEll2EJX
         MIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GC7KZx5EamiOU/8N/QzJONN2Ugjez9hWvN3kPb9zSSw=;
        b=OgSZGqBwVB2NfFhoVVnPp88D2km7kGUXqFb/4BrqwChVrjBHiypanwLuU99jiW+47w
         A6krSTBYFErDdV2RZLxhWBWUWASZw4gnWzjfa85I5gveSsT9Luf5mgxBzMejKGeHTOJd
         kxzLAFIcbCzDn1Djb+hmeHUQyfGrtcPe+l4aMOZm8PFWf7LlB/eCC6+Sh82R4uVBn+d0
         yIKSfcMvfczgIM4w1KkUStVFbShxdMwBmFncr4VcXPdRyEjXd3bpMMsXLgxMINJbXKIx
         +opBnF0G9AqvnZCcwp9jf639fsb27hLEIhj/Mxyko5LWNr9WNXWwFcniIRhQ9/I6VR+D
         bydw==
X-Gm-Message-State: APjAAAUJfhWYs3y0OJGc+4T/Z4c/dLpd6rA5Afk84L2JpZB3qU0+k/tz
        9j3ErBsHVUXs95m+2vRmxG7hKvH0tQUKlsFwq2bSkErhyZ/Opc1q65ruwKhEQb4sRbPh/0Py0Zh
        dNJBWuGSS80tUG+Ih0fGZsDsOAo3fQexEGfE7Dtsa4Dno1r8ipICJOn29/6+Sbs8ewd/TQEWe74
        Xio38rIRyQ7g==
X-Google-Smtp-Source: APXvYqwljYWtmKIICGBcBGSKa8TtSLdca6ewBlAEB0BCZXRXrirtEvEVqXvEGATzIaUauHj+fdHpGQ==
X-Received: by 2002:a7b:c104:: with SMTP id w4mr110925580wmi.42.1564521549450;
        Tue, 30 Jul 2019 14:19:09 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p63sm17532858wmp.45.2019.07.30.14.19.08
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 14:19:08 -0700 (PDT)
Subject: Re: [PATCHv3] send-email: Ask if a patch should be sent twice
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>
References: <20190730203327.30958-1-dima@arista.com>
 <20190730211012.GS20404@szeder.dev>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <e12b1d56-717e-2b1e-8475-9353a855e343@arista.com>
Date:   Tue, 30 Jul 2019 22:19:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190730211012.GS20404@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/30/19 10:10 PM, SZEDER Gábor wrote:
> On Tue, Jul 30, 2019 at 09:33:27PM +0100, Dmitry Safonov wrote:
>> @@ -589,6 +591,19 @@ test_expect_success $PREREQ 'In-Reply-To with --chain-reply-to' '
>>  	test_cmp expect actual
>>  '
>>  
>> +test_expect_success $PREREQ 'ask confirmation for double-send' '
>> +	clean_fake_sendmail &&
>> +	echo y | \
>> +		GIT_SEND_EMAIL_NOTTY=1 \
>> +		git send-email --from=author@example.com \
>> +			--to=nobody@example.com \
>> +			--smtp-server="$(pwd)/fake.sendmail" \
>> +			--validate \
>> +			$patches $patches $patches \
>> +			>stdout &&
>> +	! test_i18ngrep "Patches specified several times: " stdout
> 
> You should write this as 'test_i18ngrep ! <...>'.  When running the
> test with GIT_TEST_GETTEXT_POISON=true, then 'test_i18ngrep' is
> basically a noop and always returns with success, the leading ! would
> turn that into a failure, which then would fail the test.
> 
> Sorry for not being specific enough.

No worries, thanks for the review anyway, quite educative - I haven't
worked much on i18-related things in other projects, so sorry for not
getting it straight away.
Will resend shortly..

Thanks,
          Dmtiry
