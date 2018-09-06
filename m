Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 542C01F404
	for <e@80x24.org>; Thu,  6 Sep 2018 21:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbeIGCBi (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 22:01:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51320 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbeIGCBi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 22:01:38 -0400
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so12758221wma.1
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 14:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=nTRP4EUhSR8f+xmITpcZZL/7B6CI/ISK/bL1gBaWosM=;
        b=H6qqhqgAuH2pzJskdilEHjOMxFOEhuX7Nzrz70GYUowmXnK+9l+6Hizml0mkD9d04x
         wYUVO9nQhTJE23GREhGheOGKVBW/h4rZ+yNtRR3z/xDoSblEGoeByLoYsiK8j5vRBSBQ
         sL5KSV7UDgqy7nJndHH784kHF9qPFZbvjqvElkxMqXMp4lLfr8I08rKwkaIkNl6gjaRB
         9JcTuuK9kGHObi2ZoPICNHEvaA0ed3jyPzluUW/wguifHhWlAWpy05h8zX0TsCRSOBpZ
         QX2XXQX9MIY7jWjkouB6FT6JKEd41v2c9pM1w02t2B8nQg5lyfo9uq8+NNJ/Vi1RVaem
         68qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=nTRP4EUhSR8f+xmITpcZZL/7B6CI/ISK/bL1gBaWosM=;
        b=umotiIvAPO4sTS9yUv0zhuFg/JtVl3mbwnUEIEQWu9O7uCmAMDUCYhJ49CQ/YMkPkI
         Zl6Bg1TSNT0sly6OmZmlYCR3KSOeSI7b4q/hyd4aiYLr+MPMVx+awvGmcm/xvNM+JRcc
         CANHugM9ueSb4eCIkt4PhOkOSn7wr82miPbRVs9K1R4Yy6f/8X0cX43CfkbqIxPQKBaN
         gF2itWcjnSDQv8l9FUJz9iOgmPjU0qi5jqQXWpk0bLfvK/rG0ISPm7f2fhwUYh0Q0Eb4
         TMVM6eHoOK7RMFVxrdc7ujfHV15fbwLtqLkJrNWnpXdgLeeUhAmuiDG6y9ehHlI9hmMi
         0Mlw==
X-Gm-Message-State: APzg51B7nPzIHQj/dOe8BSOWFkS+QtAZOo8i7hUuAIU/9VQi0uBa4agD
        MEhKb1sVn/bnw6HziRx++4s=
X-Google-Smtp-Source: ANB0VdZ4ctWIfyOZ0i6wPpAmV5Dn/yMnohFUBIStbAOSp0iSW19LRWfQcpvf7oIrFHGKgjOrkobAXA==
X-Received: by 2002:a1c:ae8d:: with SMTP id x135-v6mr3455943wme.20.1536269054405;
        Thu, 06 Sep 2018 14:24:14 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v21-v6sm3841837wrd.4.2018.09.06.14.24.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 14:24:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/5] t1700-split-index: drop unnecessary 'grep'
References: <20180906024810.8074-1-szeder.dev@gmail.com>
        <20180906024810.8074-2-szeder.dev@gmail.com>
Date:   Thu, 06 Sep 2018 14:24:13 -0700
In-Reply-To: <20180906024810.8074-2-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Thu, 6 Sep 2018 04:48:06 +0200")
Message-ID: <xmqq5zziz5du.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> The test 'disable split index' in 't1700-split-index.sh' runs the
> following pipeline:
>
>   cmd | grep <pattern> | sed s///
>
> Drop that 'grep' from the pipeline, and let 'sed' take over its
> duties.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---

Obviously good ;-)  Thanks.


>  t/t1700-split-index.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> index b3b4d83eaf..be22398a85 100755
> --- a/t/t1700-split-index.sh
> +++ b/t/t1700-split-index.sh
> @@ -57,7 +57,7 @@ test_expect_success 'disable split index' '
>  	EOF
>  	test_cmp ls-files.expect ls-files.actual &&
>  
> -	BASE=$(test-tool dump-split-index .git/index | grep "^own" | sed "s/own/base/") &&
> +	BASE=$(test-tool dump-split-index .git/index | sed -n "s/^own/base/p") &&
>  	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
>  	cat >expect <<-EOF &&
>  	not a split index
