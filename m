Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BD6C201A4
	for <e@80x24.org>; Fri, 12 May 2017 04:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756838AbdELE7Z (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 00:59:25 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34918 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755071AbdELE7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 00:59:24 -0400
Received: by mail-pg0-f66.google.com with SMTP id i63so6136482pgd.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 21:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=9ZXxiY3G5aeZBp+ohh9NKMnTwkL35GZSeKBqN/Knm/M=;
        b=RameoM2VsEOqUzm4gRV1qoXRYBEggjQzNkmCEOpbpYFlulgipH7L7kkAwFhRzVJUHt
         CUJp4lXtBBdWjtzGOnuyoxORatgEF//luqfA1AFUBrnD6CzbVmPaYp4t/F2JQxCBAbJU
         ezm3CpCB9IVYTky69h0ZkJzBolgNB3IVhPSEvZ2+yKD9H58wdw6qgSodAZ5dkiLYL1vS
         eA/U0kou1wJhm1rTEeUQnN43qn99h+wnyrD2E1kj22BzjVPNCYnd5V7S1t+Zev/6HdHS
         uO5FVDB0dTc8Dls2MzRBiQFQKayUC+g8kPnzuko0LGMB6kKCiJvuz2DzaCtsRZY5hNPp
         3Iqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=9ZXxiY3G5aeZBp+ohh9NKMnTwkL35GZSeKBqN/Knm/M=;
        b=XaBa3//QZiKt1gsmN1kIfIuC9qXAazWNHLR4RSiWIJqttUH9Qhy5OUBBB1FEoyBb9P
         43iMn9TdoYEZBPU/LVTjAUEwwUlKpgP8CAtfQehQ5mGpRJlf0ptQJ8Z8Bk1AvBve6U+Q
         rusDg+w5jnx9Ycrn2D4CO86U+8iXxp4ib+1aKjdTo8VFFDA3M02lpV9323ES27kJFgDn
         GZ/Wq0l266Kowd1YYvimOLfr+RKcJP2Uqc5L72wM4NUXl0M8Zee4q5CpImFXUJEmD+fL
         fIgs/VGOzgmP08e4LMX0RrTsC1aBHMhTUYZBz94NsmQCAxBAflO1eYE4fNKUf0zUY7zo
         UZtA==
X-Gm-Message-State: AODbwcD+jVV7Lo3w5uoNUWeF3zdgNHh+eZRMmoMWD7rrbK5I4sAEE1My
        SZswfYzAZItB+WBSvv0=
X-Received: by 10.98.149.154 with SMTP id c26mr2455324pfk.37.1494565163469;
        Thu, 11 May 2017 21:59:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:954c:c08b:c855:8b7f])
        by smtp.gmail.com with ESMTPSA id c12sm2821268pfl.79.2017.05.11.21.59.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 21:59:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 09/29] grep: amend submodule recursion test for regex engine testing
References: <20170511091829.5634-1-avarab@gmail.com>
        <20170511091829.5634-10-avarab@gmail.com>
Date:   Fri, 12 May 2017 13:59:21 +0900
In-Reply-To: <20170511091829.5634-10-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 11 May 2017 09:18:09 +0000")
Message-ID: <xmqqpofe7jrq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Amend the submodule recursion test to prepare it for subsequent tests
> of whether it passes along the grep.patternType to the submodule
> greps.
>
> This is the result of searching & replacing:
>
>     foobar -> (1|2)d(3|4)
>     foo    -> (1|2)
>     bar    -> (3|4)
> ...
>  test_expect_success 'grep and multiple patterns' '
>  	cat >expect <<-\EOF &&
> -	b/b:bar
> +	b/b:(3|4)
>  	EOF
>  
> -	git grep -e "bar" --and --not -e "foo" --recurse-submodules >actual &&
> +	git grep -e "(3|4)" --and --not -e "(1|2)d" --recurse-submodules >actual &&


This breaks the promise "foo maps to (1|2)"; I do not think you need
to add 'd' in order to make the test to succeed, so I am not sure
what is going on here.

