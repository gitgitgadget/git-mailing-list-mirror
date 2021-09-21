Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDA0C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 382B560F6B
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhIUKbx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 06:31:53 -0400
Received: from mout.web.de ([212.227.15.3]:43819 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231901AbhIUKbu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 06:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1632220202;
        bh=LIfXJVPCyuoeyp8/jIOjEMCd23qM5Og+r18Lm/xnSfw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bAoHO0SCs2zSJreYRAs4s8cioXmh01nGUEy6+7beKBppOuqrtb9jdg/Usy45ur48Q
         8V1CXWVsEhHyr+XbqvZi69vwAqoZyHtQ2hUN8JeCo1ys0eO8RkRN/cMowQ3Di8Gpfq
         kuUhpf5p9sxbodaujp8KwQFByAsOKnyIPKjI1PiU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MMY1D-1mCTMb16sZ-00JVJx; Tue, 21 Sep 2021 12:30:02 +0200
Subject: Re: cb/pedantic-build-for-developers, POSIX-but-not-C99 and
 -Wno-pedantic-ms-format
To:     Carlo Arenas <carenas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Wong <e@80x24.org>
References: <xmqq1r5iaj9j.fsf@gitster.g> <87lf3q9u6b.fsf@evledraar.gmail.com>
 <CAPUEspiBP+4Ac4O5ZRTK0N+8PhHeewksrhL=x8TcswrvnS1JOw@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b0eba1c6-5468-df31-db6f-701bcd24adff@web.de>
Date:   Tue, 21 Sep 2021 12:30:00 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPUEspiBP+4Ac4O5ZRTK0N+8PhHeewksrhL=x8TcswrvnS1JOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Rcbt9x5oy5VfVgtZichSy923JPV4cALPq8PkYfHq5Hclis49XsV
 1FSbS6nsxI2NizR3zyKaTlqylXEQBC2D5qWMPVf2zNiGLQWYMNzcXyjdHQWo2p37nT5BCiZ
 P+CItQEPIOHqvLkBjX679TPbUcE7yu2HGobHhbfQkISX7okBdMjAu1VS8h+lbhWVVd6JwtD
 zHuvPgjeug+z0y0TAUeFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NWBAjoTRfKw=:a8jYEXTpumtQgo4Eaw4AKP
 klpMhn/2l3sjzDr8EYylYfHxr+g0Zx4xNoUc6eksbp62vc9meTrbdd9XZRnQ/VlDwPN18p5Jv
 zmYqN3eX85eb0TkpNLUx5zlIGA5lQ6gnnrjjryoFrgniWRhZcI+zeNqrtLewYQ5sQLhehq8/r
 c/sYFnK+95IKYT05D0xNgjtCGk4X0ji3lWHadGS5JKqg+y/PBLDzsdMxY/1leuwL9KlKagjce
 M6lu2iSbN5E7/OZKtkzJ4mcs5w/0RJM8D/2sON6LNdzMxRZw8U4pH5hDt2fcTkhny1D5R3mxx
 23vJoldMeqHlDPhu14TkIeYvk8+Dqsmxb1ID7i/xdJYTwqnb2ZTJJlbnXV0TgOr11vLqhWRJ8
 0/zsLgxgclFw6CC4AE6I2c/OLjGLQ+9OfJM5ZxoxcD0fUPNGJBICyEVIWDzPxbmiS6D/6bDNK
 gdGu577mk5b4OfuWPgmOBqMehKolyPcJ+fL343DQ5TIXpHyPpdux5L3Yidqg2IcZLlglY6jrT
 LegtYHKif2rywTqMxGzjdN8bFDuCj10pW8RlU7OUWUT8WwxFfeClgzXARr70Qba9cqpODwTFo
 yUezacnry0PD7uyES6Oq/iY4lT7bb67oAhyngDV3nakh2QN+NgyA1uOka08VwwSFZ2S5WucAW
 cOl1BhpG4Bd10gvOzgBb24D8uClwspwQPW0t6pGppwNqFkHkljU9WZSNIujjHsZQrSySVfhG6
 TWTGcRy8ByVFYHy4pwmbbedhdkzq0ymDi6LfTxQXFO6uAubj8hXs4BpTsaqyvMhGB5rKQxn11
 9UCxGofCd25OKKAL3usP2ununvwsqF3QiTGhd6r0n9pyrn3fOpO3JVStrvIqF9aZoIOCRxFdq
 zphx5XB7MgB79g7QJdbZkE5yX14yxH56JV08pEY9j8HTMfyqz1IyOFHgvm1Ei9qTxJqqtqAmM
 KJikgB/Ha4ON07jmlwBLnvER9uYBWHdOEVjm7Px5RSM/NzomCHk/zT2HXFniV1eOozyHao4R2
 VrbkY11OUOZlw5nW56BBvsr676jtxY0roVa8r6kdq6fcaZkDpqDdnmN04+BMi7Khxg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.09.21 um 12:10 schrieb Carlo Arenas:
>>     -       strbuf_addf(&fmt, "%%s%%s%%s-%%0%1$lud.%%0%1$lud-%%s-%%s-%%=
s",
>>     -                   (unsigned long)tmp.len);
>>     +       strbuf_addf(&fmt, "%%s%%s%%s-%%0%lud.%%0%lud-%%s-%%s-%%s",
>>     +                   (unsigned long)tmp.len, (unsigned long)tmp.len)=
;
>
> The C standard version seems simpler to me, so I would say this was a
> good outcome overall.

I get hypnotized by all those percent signs. %-O

>> I may be wrong, but I believe that construct is widely portable, we
>> don't use it in the main source, but in the po/ files (so anything that
>> uses git + gettext tests for this already):
>>
>>     git grep -P '%\d+\$' -- po

I wasn't aware of that extension.  Seems useful for translations, when
reordering elements is required or convenient to match the sentence
structure of a different language.

The lack of warnings about the use of that extension in po/ means
translated formats are not checked by the compiler at all, right?
According to the gettext documentation [2] msgfmt takes care of that
when building the translation files, though.

>
> It is not part of ANY C standard, so it will just print gibberish in
> systems that don't carry this extension.
>
> FWIW is not supported in Windows, which probably explains why they
> don't carry the po files.

Right, Microsoft doesn't mention it in its printf format documentation
[1].  The gettext documentation [3] claims that such platforms get
replacement functions automatically via libintl.h.

Ren=C3=A9


[1] https://docs.microsoft.com/en-us/cpp/c-runtime-library/format-specific=
ation-syntax-printf-and-wprintf-functions?view=3Dmsvc-160
[2] https://www.gnu.org/software/gettext/manual/gettext.html#c_002dformat-=
Flag
[3| https://www.gnu.org/software/gettext/manual/gettext.html#c_002dformat
