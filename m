Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90FC81F597
	for <e@80x24.org>; Tue, 31 Jul 2018 17:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731943AbeGaT32 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 15:29:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40788 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728750AbeGaT32 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 15:29:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15-v6so17530631wrs.7
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 10:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=YiFzUg2KksVIpuyJ83BvQnmgqHL5b/lh1R7/5BGuDdY=;
        b=sr+0k9bi7mdXoNBtqb+S70bXjIIlaqEsDUQHJHI+wddDryXTnz6T+0LVpV3CfQddV+
         6B+fClUgvMuSa/ZHifY9u0NLLFOGENKqjRsCgl5+qSERwEHWznpxT5K72HNpPM/0uQls
         dov9x75PGZHeWk3AavEW/2we2dG1sxHo7IxwCEaC53ZyUtfbopXs7ZSxIyx5Yi0xbJYh
         jTSrQ/u0TC5LYEmqMgf4xj1Yb66aYOPrZkTVZBW3lPsQPshRul0ec+Xn74AST7ulibfm
         mX54YB7Xl8kBrubeDMHFmOGD9LmfN722WQsMgiy2aTQ1f8rLIB75aREGDZRtzS6j/GZl
         N6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=YiFzUg2KksVIpuyJ83BvQnmgqHL5b/lh1R7/5BGuDdY=;
        b=Nf008BHpnGPdrViTJbuSGu74XPWYcwDyqZ5MvvQXCHbbhwBqT9dVNSpJ9RUxN1voFb
         6ym2ZlS4e/LDEz5+8n/tlIQW7hW4vdwws6dlbTrwdpkx4MVBV8azNZXG7yNqU7mDXT4F
         lGH7PrwbF6fJ8d8bo+khnzAl1BmkiwsThRntjLo7gdwOIPfc5/W/5TLNPyF4ntVJ6Wfl
         H1kfN7E69o0DPiR5A4r1miUzPP80KJAEhKh6mqCOkPEtLeTsu/86UEWCdEPOUKIjWOHW
         l7DB1KduGvLtGKhAT1s3wvBipMIGYvdBt6GrlUqiGRVQOvipzjmMlMP7BSbYSlgOKKpU
         lIiQ==
X-Gm-Message-State: AOUpUlGqEG8DTtjufd2eYy+0tr4d7Ajft7duis0KBX+c/oofV4HByKry
        uvF2SM371lbgoBdycy9lfSU=
X-Google-Smtp-Source: AAOMgpepjMYzwLwA5eMKGFk2IMr/Y5vUPB6uQe3OQrFMOS1YeYNNZWFCEUtMR4KcAHaeo86yAOaK+w==
X-Received: by 2002:adf:8385:: with SMTP id 5-v6mr21851200wre.13.1533059282866;
        Tue, 31 Jul 2018 10:48:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 71-v6sm4837772wmq.17.2018.07.31.10.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 10:48:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v2 08/10] fetch tests: add a test clobbering tag behavior
References: <20180429202100.32353-1-avarab@gmail.com>
        <20180731130718.25222-9-avarab@gmail.com>
Date:   Tue, 31 Jul 2018 10:48:01 -0700
In-Reply-To: <20180731130718.25222-9-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 31 Jul 2018 13:07:16 +0000")
Message-ID: <xmqq4lgfcn5a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> The test suite only incidentally (and unintentionally) tested for the
> current behavior of eager tag clobbering on "fetch". This follow-up to
> the previous "push tests: assert re-pushing annotated tags" change
> tests for it explicitly.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t5516-fetch-push.sh | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 1331a8de08..8912312be7 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1011,6 +1011,30 @@ test_force_push_tag () {
>  test_force_push_tag "lightweight tag" "-f"
>  test_force_push_tag "annotated tag" "-f -a -m'msg'"
>  
> +test_force_fetch_tag () {
> +	tag_type_description=$1
> +	tag_args=$2
> +
> +	test_expect_success "fetch will clobber an existing $tag_type_description" "
> +		mk_test testrepo heads/master &&
> +		mk_child testrepo child1 &&
> +		mk_child testrepo child2 &&
> +		(
> +			cd testrepo &&
> +			git tag Tag &&
> +			git -C ../child1 fetch origin tag Tag &&
> +			>file1 &&
> +			git add file1 &&
> +			git commit -m 'file1' &&
> +			git tag $tag_args Tag &&
> +			git -C ../child1 fetch origin tag Tag
> +		)
> +	"
> +}
> +
> +test_force_fetch_tag "lightweight tag" "-f"
> +test_force_fetch_tag "annotated tag" "-f -a -m'msg'"

I do not think that the single quotes around msg on the second one
does what you want them to.  In "git tag $tag_args Tag" there is no
eval.  You have the same for the push side, which can be seen in the
precontext of this hunk.

I somehow thought that you switched to using testTag for some
reason in an earlier step.  Shouldn't we be calling this Tag
also testTag?


> +
>  test_expect_success 'push --porcelain' '
>  	mk_empty testrepo &&
>  	echo >.git/foo  "To testrepo" &&
