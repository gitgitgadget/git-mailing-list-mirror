Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B0B01F981
	for <e@80x24.org>; Fri, 17 Aug 2018 19:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeHQWcD (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 18:32:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45093 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeHQWcD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 18:32:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id 20-v6so1985037wrb.12
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 12:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yi7jl3bB55fY26RxJY+BoCPzPM1jxZHvQF5+b7yDmqA=;
        b=d9ZIA4p+UW8lHFxd8KxgFKDIsuXwwjcwiE55zhMDF0wsBJQQ8Gips6etMN3/2H6oyN
         FQ5BsCEeCg5efj5ypj9NBVCgY/5vdaX9YaHsO0yn+sUf72+DxK+rxPviIboaxsXMi6ao
         hHJTwQeJWB6MfNCpl9TjBeBJmuoYKGUfWRVPwRQxgwXmLXCUt7lkysMkqKrdRyceNG1G
         n4uU2tWQaumlBd7akF1ibGSzUSUCWJQkyfyKeSZ7V7oEvGQRhslMsfLl1EbpAgyKxcZr
         PGp2OPBT7m67bAqakh0KfsJXsBuMi1RoV9vzjqjpxOzohrBrD/2/oUc5DkFMj3REdgp8
         uSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yi7jl3bB55fY26RxJY+BoCPzPM1jxZHvQF5+b7yDmqA=;
        b=pogZoqKShG3ppvT5w7eZOLZadu35VSuzMt5733IrTKshp5lKN/M3oG0y3saeZA9GaN
         0csX+17w0CtJQ34OAoKlxL7352kKDiQYcSic14LGtBKH3Mhw1wKYzaQKtbDXel07eWPf
         uGW0rWbbfiEkiYusk+8K5q3a04GAog1S/xG6rIZjfRic9BMFR8BFCXCbf85dDUI03rRf
         w148wwu4HaIllZcoOICRsK3BEZpiFoY66ywntUxOX3l4JVfE4hor1DrLdOTg2kuiR/gH
         gHptR4EgjCDFmHkm8e2tevSJ9EZqn9YDzhurNyP4oHPOSt2NvtZpNG+DeWYhs6wRtDLW
         FmTg==
X-Gm-Message-State: AOUpUlFBMNA0fU0SBp9lieCea68gL8RBlhfxVaKCAagRw/z4DCnS3smt
        A1QkuzirBrqi7cvILtA4lAYIV1CH+da3wQ==
X-Google-Smtp-Source: AA+uWPzaKpNp6UR2KCqNhyTalJIQW1bJjMW5pmpnImRPjSv4mA463aanzPPm+XMhnIaCUeJpzY5blQ==
X-Received: by 2002:a5d:4210:: with SMTP id n16-v6mr22968805wrq.55.1534534045177;
        Fri, 17 Aug 2018 12:27:25 -0700 (PDT)
Received: from [10.26.10.6] ([185.230.127.242])
        by smtp.gmail.com with ESMTPSA id w14-v6sm8680356wme.6.2018.08.17.12.27.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 12:27:24 -0700 (PDT)
Subject: Re: [PATCH] t5310-pack-bitmaps: fix bogus 'pack-objects to file can
 use bitmap' test
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Kirill Smelkov <kirr@nexedi.com>, Jeff King <peff@peff.net>
References: <20180814114721.25577-1-szeder.dev@gmail.com>
 <4d6ffc81-a1e8-a60f-d53f-2ec159160fcd@gmail.com>
 <xmqqr2iyc526.fsf@gitster-ct.c.googlers.com>
 <CAM0VKjkT7fBJRie_3f4B13BHT9hp9MxRhuX5r1sogh2x7KQzbg@mail.gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <eeb04c94-50c1-13ee-880b-ea380031a685@gmail.com>
Date:   Fri, 17 Aug 2018 21:27:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAM0VKjkT7fBJRie_3f4B13BHT9hp9MxRhuX5r1sogh2x7KQzbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/08/18 19:39, SZEDER Gábor wrote:
> 
> See, we have quite a few tests that extract repetitive common tasks
> into helper functions, which sometimes includes preparing the expected
> results and running 'test_cmp', e.g. something like this
> (oversimplified) example:
> 
>   check_cmd () {
>         git cmd $1 >actual &&
>         echo "$2" >expect &&
>         test_cmp expect actual
>   }
> 
>   check_cmd --foo    FOO
>   check_cmd --no-foo ""

I've only had time to look into this from t0001 up to t0008-ignores.sh, where
test_check_ignore does this. If these helper functions need to allow comparing
empty files -- how about adding special variation of cmp functions for cases
like this: test_cmp_allow_empty and test_i18ncmp_allow_empty?

I think it would be a good trade-off to allow these helper functions to skip
checking emptiness of arguments for test_cmp. Such patch will require only
s/test_cmp/&_allow_empty/ for these helper functions and it will help catch
cases as bogus test in t5310.

I'll try something like the following on the weekend:

	test_cmp() {
		if test "$1" != - && ! test -s "$1"
		then
			echo >&4 "error: trying to compare empty file '$1'"
			return 1
		fi
		if test "$2" != - && ! test -s "$2"
		then
			echo >&4 "error: trying to compare empty file '$2'"
			return 1
		fi
		test_cmp_allow_empty "$@"
	}
	
	test_cmp_allow_empty() {
		$GIT_TEST_CMP "$@"
	}

(I'm not sure about redirections in test lib functions. The two if's would
probably be in a separate function to be re-used by test_i18ncmp.)
