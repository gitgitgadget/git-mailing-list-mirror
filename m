Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFCEC77B7C
	for <git@archiver.kernel.org>; Mon,  1 May 2023 19:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjEATwG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 15:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjEATwF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 15:52:05 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE751FCE
        for <git@vger.kernel.org>; Mon,  1 May 2023 12:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1682970717; i=l.s.r@web.de;
        bh=5irOUbJR/2rygQXNH9vqocIfIej1AJwDDbirHPcemmg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=vZNV1WrtM7mIGZqyOmpsZh32OD3DkZUJbJik5zSUv0rB2uLtwCrq7vMm3pD8sBPWv
         xLJrvX6f60Z1WuYva6emK+HiRelMh+ATm3IL2Rvg0FUl3jnQEEiZQO71M2IP71FOCk
         SvYxcq9g6HIqcjX0R8SOI3rFpB/giGNj32Fe0grRTigpini9mmMbK5Fwn3D9jDH8fB
         XCGiypKrgTU7tSOEsuUu14zt32x1omx2JPOUd4Z4qYCUEw2CnlivNHtj8VgzMnCNJM
         sj4rylCqG99JTx9IxGqf2PjO0RCJyJbl1pY/pM3+leJ8pE3u4FG/OFw41U85GYvYvR
         DiA7DWCD7oWmw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.24.218]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mq1CC-1qXsSt2iCg-00n63P; Mon, 01
 May 2023 21:51:57 +0200
Message-ID: <1dbbd7ce-2b3f-6f88-f902-1d4ffe62e259@web.de>
Date:   Mon, 1 May 2023 21:51:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] test-ctype: check EOF
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <cbc7feb9-7e15-77e2-b3e9-1fa194b4d4fb@web.de>
 <xmqqedo0849m.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqedo0849m.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GuG8M3y60cq7T1ujphDv8y7TAIvN2w2EcGC9ijeRs6aAHQG8YgA
 3bX+jH1GVROePuPabXHwr6x6Zftg70+VI5hLdMpokUuZu8nIzcKzv5v92D7CWNIBnfEVExp
 Vi98EJlsFwDp0S8vCS0DHge+EhyEp6e7dK/Fl95laFY3TI9rPEM9upW7BbtSBrUD+S7dK2U
 m2doRd1G7d5n8pTZQetVQ==
UI-OutboundReport: notjunk:1;M01:P0:SuHc1QzNNwY=;VFlfSrhltxA/6z3UcKHpYCq7woL
 qNes+oycwtYfdBNvLiCkDWugTIGgkWocJP0dxtBtEL4QEgZg8phX4NugJaajfyThdRx0tYnYo
 Hwvv/DXF1rcz98POFYwDyLLwH7NJZmezlqThMOeG9oIRXIbrsWu3A68AIF9P4feLZB2NRfM55
 NpveV1vU9OZuoUXzCmD16IXmZuO+mT3+nZuO+Kpfna3BYA1w4ny6Jiyvg7Yb7qp/FGMDmhSdL
 o8nyRsonmYIMCsBcqzi0AoQw4a2S3lapDA5oQRssbzLHmZ/6bMuddDkdRRIuMhiE+AVLlmdE+
 Vrxag+MQDt7YYUJs8GTlGtmVi8zjxyUKooGc2LzAZpMqN/NJ+F1xM9Ok4tlRVYyS2D7vNlK5c
 XMg8PrF17IyAekmW9oQF2rDWJfLY/dkK+ocD0wiF0XAqlk+iIbbhj+/1T7hO+tD/rRPy9cEem
 eo6Oj6BcpNjOnO9rNapX15CAq32x35L00px2epo1gXW+kLAuaLDrXkzZNFahnesT7Jerfr505
 TZoVZXps59SIXrYsg7FA8pR2tH9ikuWpNDifXN7K7MjtjjHvVGU/AGJ/t9Ov7ZSqeH+QKLhSb
 wjztJcKXnrrUKOQIzjhylbo01WrKj1+5wrleLG2CRlSjvZ+E3WbcJ1greZywBKiVgdYgiRsm/
 kEkL38m4AA7Yax3VONgOkTRNcHN6kw/V71DLMseK/FtsuYrZ8R77kEVxeVj0kQZGYwX/NGMLe
 Y/6qnqbprUv646x+WIEBJImqHdimnFnM/9oOCQnZGtQPKqHh2N/8dbm1Tvll+ZxVHKR2qmm4v
 0OLWlJvqrhAJRnK+aAmYt6drnRrZJG2J+4rm7cXxEPWYrounAEUssOOVM7sMceSPCzTdoUfdY
 Xn9qk5+mxpNI8VouHvHVyb6uUd0+YAsxpS+BF8svqhswHJittznczfN4k3n8Qq/4NpR3o1ha3
 13DCpQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.05.23 um 17:23 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> The character classifiers are supposed to handle EOF, a negative intege=
r
>> value.  It isn't part of any character class.  Extend the ctype tests t=
o
>> cover it.
>
> The goal makes sense.
>
>> -static void report_error(const char *class, int ch)
>> +static void test(int ch, const char *class, int expect, int actual)
>>  {
>> +	if (actual =3D=3D expect)
>> +		return;
>>  	printf("%s classifies char %d (0x%02x) wrongly\n", class, ch, ch);
>>  	rc =3D 1;
>>  }
>> @@ -24,9 +26,9 @@ static int is_in(const char *s, int ch)
>>  #define TEST_CLASS(t,s) {			\
>>  	int i;					\
>>  	for (i =3D 0; i < 256; i++) {		\
>> -		if (is_in(s, i) !=3D t(i))	\
>> -			report_error(#t, i);	\
>> +		test(i, #t, is_in(s, i), t(i));	\
>>  	}					\
>> +	test(EOF, #t, 0, t(EOF));		\
>>  }
>>
>>  #define DIGIT "0123456789"
>> --
>> 2.40.1
>
> I am a bit torn on the conversion from report_error() to test(), as
> the only "test"-y thing the updated function does is to compare two
> of its parameters.  It still is mostly about reporting an error when
> something goes wrong.  In other words, the added change could have
> been just
>
> 	if (t(EOF) !=3D 0)
> 		report_error(#t, EOF);
>
> after the loop, I think.

True -- the objective can be met without changing the function, and
whatever the goal for the "while at it" refactoring was can be
discussed in separate patch, if necessary.

> The only thing that I am not entirely happy with the end result is
> the name of the function, and not how the caller and the callee
> divides their work, so it is so miniscule a thing that it won't be
> worth our collective time to bikeshed it further.
>
> Let's take it as-is.  Thanks.

Hmm, okay.  Here's v2 anyway; feel free to ignore it.  At least I
found this reminder to stay focused and KISS helpful.

=2D-- >8 ---
Subject: [PATCH v2] test-ctype: check EOF

The character classifiers are supposed to allow passing EOF to them, a
negative value.  It isn't part of any character class.  Extend the tests
to cover that.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/helper/test-ctype.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/helper/test-ctype.c b/t/helper/test-ctype.c
index 71a1a5c9b0..e5659df40b 100644
=2D-- a/t/helper/test-ctype.c
+++ b/t/helper/test-ctype.c
@@ -27,6 +27,8 @@ static int is_in(const char *s, int ch)
 		if (is_in(s, i) !=3D t(i))	\
 			report_error(#t, i);	\
 	}					\
+	if (t(EOF))				\
+		report_error(#t, EOF);		\
 }

 #define DIGIT "0123456789"
=2D-
2.40.1
