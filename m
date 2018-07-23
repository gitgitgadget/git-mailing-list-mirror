Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DE041F597
	for <e@80x24.org>; Mon, 23 Jul 2018 18:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388043AbeGWTya (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 15:54:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33897 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387982AbeGWTya (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 15:54:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id c13-v6so1729947wrt.1
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=B1cuO2AQEPM+736CWxqRqI5VfbbuqEuSKK07YCr4gdY=;
        b=DMhYT/AC+v1eQBZuPpvt1OZfP0znb2f6kSpw/QEOIktq1eJrP+bYErYUomlfq5WbhJ
         n1RicFskzQlZxe3/H4R5sjt0w2nXdxHii+NIBFX8zmfHCwjH7xERwqvORi1JpUfEG3Np
         /c3x4XBQhsYNW/8FLp7ps1WODRigoMS+9EyOB4WYaodplRLGhvqzePm5poHxR9gJlB4Y
         aMKaNPNx2kf8iJ/6cCJb5CeJ4yO1Mq7rfrWXnXE2yKY7L9OoaHCOLf+0De5c60fZ18dy
         Hj50VKo4t1AyZOM6LcNTlD1QDWwfEc9ofINZZQJ++8GcemU55mKoZ8CL8NbjldOQy+tI
         t2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=B1cuO2AQEPM+736CWxqRqI5VfbbuqEuSKK07YCr4gdY=;
        b=j5Dmn6GDxa+6nUOtS6BMcJE0TmS6ZY2TQRD/gu4gYWh8Uphz0cDvm3tLNeC1IY7IfH
         aMkjxjEXhoiQ2XEuk/P8+hZE8X9WEvgTkopVB7FlJHiTDraPQvZuc+rAjg6Xo/MJfSR8
         3DDlyHensO2aqPttdysFC8L6f6dGNKKKZB/crtKM9xX3Q3Ro/XbA10qSdvgmS+Jm8G2y
         NDMFBR1Jpy36/SbtINGzS/py5whybX5QB/flxpSx6T0t6woPwSEeiC8S1zyj8B9iykXc
         X15sklgEA8k+guxSAQQXbljTOQ71Qdsg5jB3S+VMI8JWQO0Ksd8QdWFBjQcBBhjZlhgr
         AKYg==
X-Gm-Message-State: AOUpUlGtXqpish9HI+3KWubr3afHLhBF/SyyaURE2vCqPMh1gbzpEjL9
        8CPvDgR3h8GCza7p0GgHZSRvOlMn
X-Google-Smtp-Source: AAOMgpe7bUEOvp37OxPhaFYj0Ww3WX+BQcotzCwLEzoHvfmzlCopa8pom+fzoFv8OnztVlajhS/dcA==
X-Received: by 2002:adf:8f4a:: with SMTP id p68-v6mr9143219wrb.22.1532371915958;
        Mon, 23 Jul 2018 11:51:55 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h14-v6sm7079516wro.15.2018.07.23.11.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 11:51:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
Subject: Re: [PATCH] Makefile: add a DEVOPTS flag to get pedantic compilation
References: <20180721185933.32377-1-dev+git@drbeat.li>
        <87wotobclv.fsf@evledraar.gmail.com>
Date:   Mon, 23 Jul 2018 11:51:54 -0700
In-Reply-To: <87wotobclv.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 21 Jul 2018 21:41:32 +0200")
Message-ID: <xmqqzhyh6b05.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> +CFLAGS += -pedantic
>> +# don't warn for each N_ use
>> +CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=0
>> +endif
>
> ...and set this to "no" not "0" since we document that that's the way to
> toggle it off in the Makefile, i.e. let's be consistent.

The Make variable USE_PARENS_AROUND_GETTEXT_N is described as taking
"yes" or "no".

    # Define USE_PARENS_AROUND_GETTEXT_N to "yes" if your compiler happily
    # compiles the following initialization:
    #
    #   static const char s[] = ("FOO");
    #
    # and define it to "no" if you need to remove the parentheses () around the
    # constant.  The default is "auto", which means to use parentheses if your
    # compiler is detected to support it.

But the knob on the CFLAGS set by these variables take 1 or 0

    ifeq (yes,$(USE_PARENS_AROUND_GETTEXT_N))
            BASIC_CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=1
    else
    ifeq (no,$(USE_PARENS_AROUND_GETTEXT_N))
            BASIC_CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=0
    endif
    endif

And the code that uses the CFLAGS knob 

    /* Mark msgid for translation but do not translate it. */
    #if !USE_PARENS_AROUND_GETTEXT_N
    #define N_(msgid) msgid
    #else
    ...
    #define N_(msgid) (msgid)
    #endif

pays attention to the truth/false in usual C preprocessor sense.
Your "no" happens to serve as 0 just like "yes" would.

So I think you suggestion is a bad one that makes a misleading
result.

[Footnote]

*1* The following shows all "not X" except for "not one".

#include <stdio.h>

#define ZERO 0
#define ONE 1
#define YES yes
#define NO no
#undef UNDEF

const char *msgs[] = {
#if !ZERO
	"not zero",
#endif
#if !ONE
	"not one",
#endif
#if !YES
	"not yes",
#endif
#if !NO
	"not no",
#endif
#if !UNDEF
	"not undef",
#endif
	NULL
};

int main(int ac, char **av)
{
	const char **cp = msgs;

	while (*cp) {
		printf("%s\n", *cp);
		cp++;
	}
	return 0;
}




