Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 084FA20401
	for <e@80x24.org>; Tue, 27 Jun 2017 17:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752579AbdF0R74 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 13:59:56 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33225 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751716AbdF0R7y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 13:59:54 -0400
Received: by mail-wm0-f47.google.com with SMTP id z75so7346368wmc.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 10:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=5nomhSm1PCj1CZeQ1ywiv+3guS/idkhwEleMv/Ydeuc=;
        b=lgqwagv8mobHJbUzeVGfiPt0Wy0t0ansmMdrK1WxKWPDAHa/cIEOLEGfztK4h7/byU
         Fzlq8veay9yXVoBY6+9kM4t2JMZJzvmfUlo8RBe8UlxwbgSSdbuosiUSIuM7wH5aFIFs
         7xvNNMj75nfV6tPEE9T/GHvIDwmqYT0xrDtsJbKDh37LBGf8eyNeDfPZ6E4wkV+2ZYlp
         /fQSSYv0dOS1LyeaUIB/l2pDAABTqtwDuq9DZQCEnXlF1G301+GDU9jQZWPrPMhhau9V
         O7SrXuufkrQjqq99g5gJvGr9G+agAd5cBozzeD2WNBbFo6ADNX+DS7/1AkRFimVeO0nH
         T8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=5nomhSm1PCj1CZeQ1ywiv+3guS/idkhwEleMv/Ydeuc=;
        b=YOe/T8nEpLAifc5aa9I6uBFIZMDJAnJLfveDvtYi66xlheOmtAaPjJA56d5m4xrWai
         2mu87mvDzflHaW2XmW0XClsP3R6lraOpeEQwSdrCfWWM/1hNzU78rtFHFGOZ3Zrfbdb7
         XMk4gtiVgbeBG+/CP6kHBzjA1nE4H96TicUejVYiPbDPwwq1z3PoLAQujVl/4Iz6M535
         ghjzzMGTqNMFCWfYY85nf0U8qUGTI/CjEeDoBIakOX0utRt0qMZY9GaoTyOuqBcXieul
         cZXrk26VrcWqOVQ7TVE7bdCTuy6y+oBmQBhcTkXkFLnQBEOW1tmZUoaeOKgi2Q/Vb6N8
         zMzw==
X-Gm-Message-State: AKS2vOyD0I/GOGvC+eHzmheFOQPzoDwrywx6qHVPjw8zXoWgtcVad3yO
        Ni02JhFTMU79Ig==
X-Received: by 10.80.135.175 with SMTP id a44mr4861748eda.90.1498586393223;
        Tue, 27 Jun 2017 10:59:53 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id 4sm1859747eds.48.2017.06.27.10.59.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2017 10:59:51 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dPumE-0005jo-VU; Tue, 27 Jun 2017 19:59:50 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc:     Michael Kebe <michael.kebe@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>
Subject: Re: Compile Error v2.13.2 on Solaris SPARC
References: <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com> <87fuem7aw2.fsf@gmail.com> <CAKKM46vr2Y_Zs+EJX-nxw7XH0nbpmTyubR1jibYoiieNCDns4Q@mail.gmail.com> <CAKKM46sBVyTMGNwU6E9s7gq8wiBfAxrKzBFVgU=zfwj+YdAjcQ@mail.gmail.com> <20170627162808.p7sj3jpwum7n3hq2@oracle.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20170627162808.p7sj3jpwum7n3hq2@oracle.com>
Date:   Tue, 27 Jun 2017 19:59:50 +0200
Message-ID: <871sq5l3ah.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 27 2017, Liam R. Howlett jotted:

> How about:
>
> ---- 8< ----
> diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
> index facea1bb5..ed8c63f2d 100644
> --- a/sha1dc/sha1.c
> +++ b/sha1dc/sha1.c
> @@ -38,9 +38,18 @@
>
>  #if (defined(_BYTE_ORDER) || defined(__BYTE_ORDER) || defined(__BYTE_ORDER__))
>
> +#define EMPTY_VAL(x) x ## 1
> +#define EMPTY(x) EMPTY_VAL(x)
> +
> +#if (defined(_BIG_ENDIAN) && (EMPTY(_BIG_ENDIAN) == 1))
> +#undef _BIG_ENDIAN
> +#define _BIG_ENDIAN 4321
> +#endif
> +
>  #if ((defined(_BYTE_ORDER) && (_BYTE_ORDER == _BIG_ENDIAN)) || \
>       (defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || \
> -     (defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __BIG_ENDIAN__)) )
> +     (defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __BIG_ENDIAN__)) || \
> +     (defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == _BIG_ENDIAN)) )
>  #define SHA1DC_BIGENDIAN
>  #endif

Might be workable, but have you seen my
20170627121718.12078-2-avarab@gmail.com ([PATCH 1/3] sha1dc: update from
my PR #36). It should avoid this problem entirely.

> * Michael Kebe <michael.kebe@gmail.com> [170627 02:28]:
>> On the Solaris system here __BYTE_ORDER__ set to 4321 and _BIG_ENDIAN
>> is defined, but has no value.
>>
>> The problem is the not short circuiting macro...
>>
>> -------------------------8<------------------------------
>> #undef _FOO1
>> #undef _FOO2
>> #undef _FOO2
>>
>> #undef _BAR1
>> #undef _BAR2
>> #undef _BAR3
>>
>> #define _FOO3 42
>>
>> //comment out this line or give it a value to make the preprocesser happy
>> #define _BAR1
>>
>> #if (defined(_FOO1) || defined(_FOO2) || defined(_FOO3))
>>
>> // not short circuiting... preprocesser tries to evaluate (_FOO1 &&
>> _BAR1) but _BAR1 has no value...
>> #if ((defined(_FOO1) && (_FOO1 == _BAR1)) || \
>>           (defined(_FOO2) && (_FOO2 == _BAR2)) || \
>>           (defined(_FOO3) && (_FOO3 == BAR3)) )
>> #define SHA1DC_BIGENDIAN
>> #endif
>>
>> #endif
>> -------------------------8<------------------------------
>> https://gist.github.com/michaelkebe/c963c7478b7b55ad197f0665986870d4
>>
>> What do you think?
>>
>> 2017-06-27 7:41 GMT+02:00 Michael Kebe <michael.kebe@gmail.com>:
>> > 2017-06-26 22:27 GMT+02:00 Ævar Arnfjörð Bjarmason <avarab@gmail.com>:
>> >> Could you (or anyone else for that matter) please test it with:
>> >>
>> >>     git clone --branch bigend-detect-solaris-again https://github.com/avar/sha1collisiondetection.git &&
>> >>     cd sha1collisiondetection &&
>> >>     make test
>> >
>> > Still no luck.
>> >
>> > ~/sha1collisiondetection (bigend-detect-solaris-again *)$ CC=gcc gmake test
>> > mkdir -p dep_lib && gcc -O2 -Wall -Werror -Wextra -pedantic -std=c90
>> > -Ilib  -M -MF dep_lib/sha1.d lib/sha1.c
>> > lib/sha1.c:63:58: error: operator '==' has no right operand
>> >  #if ((defined(_BYTE_ORDER) && (_BYTE_ORDER == _BIG_ENDIAN)) || \
>> >                                                           ^
>> >
>> > Running Solaris on sparc:
>> > $ uname -a
>> > SunOS er202 5.11 11.3 sun4v sparc sun4v
>> >
>> >
>> > The isa_defs.h is available here:
>> > https://gist.github.com/michaelkebe/472720cd684b5b2a504b8eeb24049870
>> >
>> >
>> > Greetings
>> > Michael
