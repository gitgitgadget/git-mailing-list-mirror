Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E3251F404
	for <e@80x24.org>; Fri, 23 Mar 2018 22:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbeCWW26 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 18:28:58 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:53853 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbeCWW25 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 18:28:57 -0400
Received: by mail-wm0-f45.google.com with SMTP id e194so6091861wmd.3
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 15:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=p1NeuQdeWmlC3ncB42SWeIdUkgxdiUqkcN/3DG4zD80=;
        b=DE0osUGe8RKKnAl87B/+cPsOm6N2t1tYpGUfQUgRxHa2c9ORgQNMcYBZHp9PiYCf4h
         L9GA4ll/1U38YOFQgd1JOFECaU22qEd0vSghGTBW+BkNwiTtBeK5ea7XDopJ8Qk/zFek
         nBDVOvePi2VZB9uk1j5DpOGFjx+WuT639N2lRYBLLbAs5c31Doaaarl5BMBYE9aS3g4c
         Hks8VEBpiCDkNF0e6lR1IVQ6jJpm0WWxY//kVnKRLjNg9J+UW5HciBbVuFSeMGGHARhI
         t57HC19XvQulTU6IMIovkxv5tWd1aelPYmemRY855fymz9xPviGy/EX57tfy+O80ysg5
         jk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=p1NeuQdeWmlC3ncB42SWeIdUkgxdiUqkcN/3DG4zD80=;
        b=IVon2B5UE6Sb7NsaUn1Kr6rnf54b+0my9Eqw48mdICHHyqz9USy4Uahio52MSui3tG
         mcuBxVHIhpdMR5KO1+1xv+g3Oboa3KwCwbD5bGLj3OTrHQDCPgfCrRlfHvrw+/eszgJT
         3UxK9+Q+AkpJxpFQkduZDfCf6xjFl8QF/ewigWbqtIM95gptxwHDeZNhNHkgOLvF2HnC
         TVAvdxE92sUp4bl1nQ52XDuHV2/mnoxkZI0AjDBPVOfI8cKn2immMxUkkzRpK7fLHEnf
         xMCBtCxplsUS/TKe8Y8SArB6MN5B9V3Nk/DD1Tsget1MlyD/WQAI6RkYyr/tDUvmiNnM
         j4TQ==
X-Gm-Message-State: AElRT7H8nKP/76GoqqyqUA0ZEJZaucJuFrlq5hKHDspevncKvzrxK/p3
        /R2229Ngb6ihBEY93ne86IZ4VJeP
X-Google-Smtp-Source: AG47ELvcSqh2ltKZD1vCaXy/IpkCEVohSSnjQCKvKmXEGR3ynmMJDCI7NJ8oitaeX7E5Ale722KE+Q==
X-Received: by 10.80.208.221 with SMTP id g29mr32200808edf.295.1521844136430;
        Fri, 23 Mar 2018 15:28:56 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id q6sm6257411edh.48.2018.03.23.15.28.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 15:28:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Loganaden Velvindron <logan@hackers.mu>, git@vger.kernel.org,
        Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH v2] Allow use of TLS 1.3
References: <20180323193435.GA21971@voidlinux> <xmqqy3iih2xi.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <xmqqy3iih2xi.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 23 Mar 2018 23:28:54 +0100
Message-ID: <87h8p6xw7t.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 23 2018, Junio C. Hamano wrote:

>> @@ -62,6 +62,9 @@ static struct {
>>  	{ "tlsv1.1", CURL_SSLVERSION_TLSv1_1 },
>>  	{ "tlsv1.2", CURL_SSLVERSION_TLSv1_2 },
>>  #endif
>> +#ifdef CURL_SSLVERSION_TLSv1_3
>> +	{ "tlsv1.3", CURL_SSLVERSION_TLSv1_3 }
>> +#endif
>>  };
>
> It seems to me that
>
>     https://github.com/curl/curl/blob/master/include/curl/curl.h#L1956
>
> tells me that this #ifdef would not work.  Did you test it with the
> "test not version but feature" change you made at the last minute?
>
> I know it is not your fault but is Ævar's, but you're responsible
> for double-checking what you are told on the internet ;-)

Yeah I should add some "I haven't actually tried this, but what do you
think about this?" disclaimer.

But it's not a good sign that we have a v2 with an ifdef that'll never
be true, indicating that it wasn't tested against TLSv1.3. Is there some
way we could check for this in our test suite?
