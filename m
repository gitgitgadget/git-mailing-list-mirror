Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED5F01F462
	for <e@80x24.org>; Fri, 26 Jul 2019 21:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfGZV5m (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 17:57:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44634 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfGZV5m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 17:57:42 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so54394861edr.11
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 14:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=NTYJKscPB3X/vL0QqREtl0eqvjGTnob6nJ2rko8pSV4=;
        b=uOiqLIxU1cnnq2O9Sgnyb/9JyFz/B+gRkcicFY1DmYeAst6cLGZb/fy8JoQLjs9AWj
         Lx2tz1qmxYiUYPeP+VreOKIZnl9EQ/TNhp8Mu77mxKc+l2D/iOYH1Y5o6+gRuRK7V2b2
         364Nn3cp4LtpKcIowxRF2KTduUnxKCfQ6AeEoy2h9VWvL9lMD3b7J3slVDwda568rzfC
         6qeUiZLrmjB9wus3JjOQOUPcu8QyTgF0CQclcp9q3D5K6UgQBSvmeLvpa/o9Hyu3drCr
         /on6WoBI56NMsA7D/9Rkyi+ELASXRQ+8fCN4rJeFXxU9FaF+MBkxRPPzhGXVNhCctQB0
         mUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=NTYJKscPB3X/vL0QqREtl0eqvjGTnob6nJ2rko8pSV4=;
        b=lp8jIRPc482xNO2o9ZWatVCUPw6WSJ6KSelMvweiWbN4aV/HrzAbm52XAObxAlDTpQ
         pQePWzEhbYYnA6QpfvJfS6/Za+/9tCzL2tDK5SEIxnSmFvzxmhjPrl1ssV2wUCETVg2y
         9+2d9cOYwWRfAA7vWDvESgOwjfD7Dm/uy9W8PWK7Qr4rrDugoCiDZCsWUCSOpRSGxPlR
         c0guF9EG/igMVrnAIR3h8FYsDNyOGEC2+JrEMyUa0bISpcEufX9Daj78ce5pCOx/Z5Nm
         BiragggDpi7WdPrcJNFGU5tbFJq2xxstTjaFR72icnMm+w3LM81Sbl6REx/gUtoXhhRf
         6bvA==
X-Gm-Message-State: APjAAAVaAt5oTxwd/YV6qXx/7oqAajabqqQqYPQtnr/1aroj4DIDMxS3
        YP3YlLQhMaQHITtucanTIlY=
X-Google-Smtp-Source: APXvYqy+hUeKmmq64PrnvgcnxcRS5XGL3jZwayDcmdxR6/nXXHVYPdQRk/q8imjEGx4buLA9Xw9z8A==
X-Received: by 2002:a17:906:6986:: with SMTP id i6mr73862814ejr.89.1564178260419;
        Fri, 26 Jul 2019 14:57:40 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id t2sm14571142eda.95.2019.07.26.14.57.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 14:57:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 8/8] grep: optimistically use PCRE2_MATCH_INVALID_UTF
References: <20190724151415.3698-1-avarab@gmail.com> <20190726150818.6373-9-avarab@gmail.com> <xmqqd0hwmrng.fsf@gitster-ct.c.googlers.com> <87a7d0799h.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <87a7d0799h.fsf@evledraar.gmail.com>
Date:   Fri, 26 Jul 2019 23:57:39 +0200
Message-ID: <877e84792k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 26 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Jul 26 2019, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> diff --git a/Makefile b/Makefile
>>> index bd246f2989..dd38d5e527 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -726,6 +726,7 @@ TEST_BUILTINS_OBJS +=3D test-oidmap.o
>>>  TEST_BUILTINS_OBJS +=3D test-online-cpus.o
>>>  TEST_BUILTINS_OBJS +=3D test-parse-options.o
>>>  TEST_BUILTINS_OBJS +=3D test-path-utils.o
>>> +TEST_BUILTINS_OBJS +=3D test-pcre2-config.o
>>
>> This won't even build with any released pcre version; shouldn't we
>> make it at least conditionally compiled code?  Specifically...
>>
>>>  TEST_BUILTINS_OBJS +=3D test-pkt-line.o
>>>  TEST_BUILTINS_OBJS +=3D test-prio-queue.o
>>>  TEST_BUILTINS_OBJS +=3D test-reach.o
>>> diff --git a/grep.c b/grep.c
>>> index c7c06ae08d..8b8b9efe12 100644
>>> --- a/grep.c
>>> +++ b/grep.c
>>> @@ -474,7 +474,7 @@ static void compile_pcre2_pattern(struct grep_pat *=
p, const struct grep_opt *opt
>>>  	}
>>>  	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->patte=
rn) &&
>>>  	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
>>> -		options |=3D PCRE2_UTF;
>>> +		options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
>>>
>>>  	p->pcre2_pattern =3D pcre2_compile((PCRE2_SPTR)p->pattern,
>>>  					 p->patternlen, options, &error, &erroffset,
>>> diff --git a/grep.h b/grep.h
>>> index c0c71eb4a9..506f05b97b 100644
>>> --- a/grep.h
>>> +++ b/grep.h
>>> @@ -21,6 +21,9 @@ typedef int pcre_extra;
>>>  #ifdef USE_LIBPCRE2
>>>  #define PCRE2_CODE_UNIT_WIDTH 8
>>>  #include <pcre2.h>
>>> +#ifndef PCRE2_MATCH_INVALID_UTF
>>> +#define PCRE2_MATCH_INVALID_UTF 0
>>> +#endif
>>
>> ... unlike this piece of code ...
>>
>>>  #else
>>>  typedef int pcre2_code;
>>>  typedef int pcre2_match_data;
>>> diff --git a/t/helper/test-pcre2-config.c b/t/helper/test-pcre2-config.c
>>> new file mode 100644
>>> index 0000000000..5258fdddba
>>> --- /dev/null
>>> +++ b/t/helper/test-pcre2-config.c
>>> @@ -0,0 +1,12 @@
>>> +#include "test-tool.h"
>>> +#include "cache.h"
>>> +#include "grep.h"
>>> +
>>> +int cmd__pcre2_config(int argc, const char **argv)
>>> +{
>>> +	if (argc =3D=3D 2 && !strcmp(argv[1], "has-PCRE2_MATCH_INVALID_UTF"))=
 {
>>> +		int value =3D PCRE2_MATCH_INVALID_UTF;
>>
>> ... this part does not have any fallback definition.
>
> It works because we include grep.h, which'll define
> PCRE2_MATCH_INVALID_UTF=3D0 if pcre2.h doesn't give it to us. I've tested
> this on PCRE versions with/without PCRE2_MATCH_INVALID_UTF and it works
> & runs/skips the appropriate tests.

Ah, I spoke too soon, of course that's all guarded by "are we using PCRE
v2 in general?". I'll fix it...
