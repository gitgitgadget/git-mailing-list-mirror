Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 272531F597
	for <e@80x24.org>; Fri, 27 Jul 2018 21:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389790AbeG0XHF (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 19:07:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41761 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389703AbeG0XHE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 19:07:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so6380863wrr.8
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 14:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8uDiyqWkYyd6oTJxx5tthrgGQEA2X9hU1LM1LDOkcr0=;
        b=cny7YNJtSXllnrQOWZot6isStw0FmV0GIHUUoOWg1kvZY+QLxBGuh/AV/dYA7F3auM
         VNnwe65bBo3za45QwYwcwgaxKgKs0UUw58dP2NUCnm4KMsz/gKWE80vwmPbSw5CtGvcv
         unSXvff9nF580IoS8gYgeCWZeSGUZjzqRsrm+yGZGIGj+ihf7gjbr6NFVtKLBXx1BER0
         Z9m7mXDDZ2rkoRGXXxegzMxCSVpecSNGKLvhOtu0tPnmWui2jnoqhaQnx7eDuRtQ+43s
         j7FyPAvlTsWt/7R5s55wGbB8aKqLNfKYyjfm4Q9nk6GF2bGef+z6dP+45J8JDk64Rq3+
         xpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=8uDiyqWkYyd6oTJxx5tthrgGQEA2X9hU1LM1LDOkcr0=;
        b=JriXH/RmZj2T5MH0uem0wrK9fwuXrWtpDZaGW/XxaVSPpy6f3bftUKX04pf//ElB8U
         nN4WBT0sOFu3U9IqcpRJMGMBaXHAgyqNo8XAwRVAgH8azmQfsrK/kSXaZskThBoDRo9u
         jBZWg9MtEKJCzDIIuVwVAUsq0Rbq52SkwNnHAOGz6D0w6AjyivE6DAvS/XfR+LaCI69K
         KkC0VnI+LkC1vz/L87yHhB/l3TJHyA6IyVAc1Qts88XznCn/fXRNBYpfSBARLuArXYUa
         ghbJZ65yu8kWcUJ5T0U7r2d3txI8aKg5eB+0uL8udHfEImuD/6k1YOcHZq11O/ThINAB
         RVQw==
X-Gm-Message-State: AOUpUlHJ7Imaiiv31YobQbit7U/BL27aS7CERXWFCg87fbs+NMS/u7Tf
        ALv59HM6++p/ToDC79Sr6os=
X-Google-Smtp-Source: AAOMgpcLc+QuWyiQ8jm7nxGzT7JMtJ83DFnCKc0DbeYEF2vTIK1gDeC/PRNYRPxEJn6xALq9scEhUg==
X-Received: by 2002:adf:f28c:: with SMTP id k12-v6mr6076411wro.263.1532727795007;
        Fri, 27 Jul 2018 14:43:15 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q3-v6sm4642822wmf.21.2018.07.27.14.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 14:43:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 10/10] fsck: test and document unknown fsck.<msg-id> values
References: <20180525192811.25680-1-avarab@gmail.com>
        <20180727143720.14948-11-avarab@gmail.com>
Date:   Fri, 27 Jul 2018 14:43:13 -0700
In-Reply-To: <20180727143720.14948-11-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 27 Jul 2018 14:37:20 +0000")
Message-ID: <xmqqbmasl5hq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> When fsck.<msg-id> is set to an unknown value it'll cause "fsck" to
> die, but the same is not rue of the "fetch" and "receive"
> variants. Document this and test for it.

Interesting.  Before documenting and adding a test to cast the
current behaviour in stone, do we need to see if the discrepancy is
desired and designed one, or something we may want to fix?



>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Documentation/config.txt        |  4 ++++
>  t/t5504-fetch-receive-strict.sh | 14 ++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 57c463c6e2..4cead6119a 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1637,6 +1637,10 @@ In general, it is better to enumerate existing objects with problems
>  with `fsck.skipList`, instead of listing the kind of breakages these
>  problematic objects share to be ignored, as doing the latter will
>  allow new instances of the same breakages go unnoticed.
> ++
> +Setting an unknown `fsck.<msg-id>` value will cause fsck to die, but
> +doing the same for `receive.fsck.<msg-id>` and `fetch.fsck.<msg-id>`
> +will only cause git to warn.
>  
>  fsck.skipList::
>  	The path to a sorted list of object names (i.e. one SHA-1 per
> diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
> index 7f06b537d3..62f3569891 100755
> --- a/t/t5504-fetch-receive-strict.sh
> +++ b/t/t5504-fetch-receive-strict.sh
> @@ -198,6 +198,10 @@ test_expect_success 'fetch with fetch.fsck.skipList' '
>  	git --git-dir=dst/.git fetch "file://$(pwd)" $refspec
>  '
>  
> +test_expect_success 'fsck.<unknownmsg-id> dies' '
> +	test_must_fail git -c fsck.whatEver=ignore fsck 2>err &&
> +	test_i18ngrep "Unhandled message id: whatever" err
> +'
>  
>  test_expect_success 'push with receive.fsck.missingEmail=warn' '
>  	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
> @@ -211,10 +215,15 @@ test_expect_success 'push with receive.fsck.missingEmail=warn' '
>  	git --git-dir=dst/.git config fsck.missingEmail warn &&
>  	test_must_fail git push --porcelain dst bogus &&
>  
> +	# receive.fsck.<unknownmsg-id> warns
> +	git --git-dir=dst/.git config \
> +		receive.fsck.whatEver error &&
> +
>  	git --git-dir=dst/.git config \
>  		receive.fsck.missingEmail warn &&
>  	git push --porcelain dst bogus >act 2>&1 &&
>  	grep "missingEmail" act &&
> +	test_i18ngrep "Skipping unknown msg id.*whatever" act &&
>  	git --git-dir=dst/.git branch -D bogus &&
>  	git --git-dir=dst/.git config --add \
>  		receive.fsck.missingEmail ignore &&
> @@ -235,10 +244,15 @@ test_expect_success 'fetch with fetch.fsck.missingEmail=warn' '
>  	git --git-dir=dst/.git config fsck.missingEmail warn &&
>  	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" $refspec &&
>  
> +	# receive.fsck.<unknownmsg-id> warns
> +	git --git-dir=dst/.git config \
> +		fetch.fsck.whatEver error &&
> +
>  	git --git-dir=dst/.git config \
>  		fetch.fsck.missingEmail warn &&
>  	git --git-dir=dst/.git fetch "file://$(pwd)" $refspec >act 2>&1 &&
>  	grep "missingEmail" act &&
> +	test_i18ngrep "Skipping unknown msg id.*whatever" act &&
>  	rm -rf dst &&
>  	git init dst &&
>  	git --git-dir=dst/.git config fetch.fsckobjects true &&
