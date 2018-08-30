Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 232191F404
	for <e@80x24.org>; Thu, 30 Aug 2018 21:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeHaB0X (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 21:26:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51863 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbeHaB0X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 21:26:23 -0400
Received: by mail-wm0-f67.google.com with SMTP id y2-v6so3308494wma.1
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 14:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=gAREAyXNv7TGxbMbFj2Mt+sgwDSxxwtAp81FuJWJ7WU=;
        b=nqnZ1p3zny8DgxOJMAFBeRRDVC6h9uhK1iq8U/xhwgyLZyMTS3Qa7Y52ATjYLshJMU
         qydWifp01IhD+Yb+PsGKPfWdzzmPSU+X2A7tcgaTf5np24PTzfHFtuP+T6YLLkORSkhe
         Q9kI9b0+9AIhOSHx/fDVb6NzDhipCHCNjEf85MyLDns7YrQOnhqJOHhTIWaO2gcUYFLg
         JbGCwas7Sl6kiKiLwTM0n/DOIxwlcRwsOtxjBDUaMAR5FUT9WuABkPp2Lu0gO4wfXYks
         P+6c9oa83qx01W8Du/VCyYpzOhuZWBvILR95bpcuJlLVFemhmb1p7+Zh1R7ZiLTV/UmK
         38QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=gAREAyXNv7TGxbMbFj2Mt+sgwDSxxwtAp81FuJWJ7WU=;
        b=jLvYIExuPIJamgrylghA1/zJmOmIBS6ICfwziukHEzwpWAcy6uRpCsafB1H0A2UWoD
         rABWurHXvROcZkf7GN40QtLkLCKI8VvxCKaZoNN5RZf7NndVFp1yfklEffNnGMLdRqZa
         WsI8iudPKO35mFwRU30no1mTOsaMY7hFcrKZFQsJCTVS8NJfVqQVs1vbWIpppT4shfr6
         CNqj36AA2PqRj7bjIw3woxTFAoq+yk2CUHgwJBy1UZfm0XuuguNttexQoN6+ASC8xueg
         uDa93qN7yALxeu4RUp3y36mraSwJ31iYxE7d7cFnUH6xXK8w0YN4jFdoy7Zha+TzitN5
         rqtA==
X-Gm-Message-State: APzg51AnwrE6d485IoN+z7/cvBsAJagTfwF+H3ig4Uo+u1dJoWJIUc3D
        rSYmJu3nngf5cEy7HfNpLBo=
X-Google-Smtp-Source: ANB0VdZQO4W9TM4+Cal+xdxuxW4wjgCBL6dFIyYlMBz/7/R31ED4J3nlI1gQV0Ppo6Fy8p/tfsZIcw==
X-Received: by 2002:a1c:3314:: with SMTP id z20-v6mr2801201wmz.95.1535664134467;
        Thu, 30 Aug 2018 14:22:14 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j133-v6sm4728091wmd.12.2018.08.30.14.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 14:22:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Kristian =?utf-8?Q?H?= =?utf-8?Q?=C3=B8gsberg?= 
        <krh@redhat.com>
Subject: Re: [PATCH v4 3/6] fetch tests: add a test for clobbering tag behavior
References: <20180813192249.27585-1-avarab@gmail.com>
        <20180830201244.25759-4-avarab@gmail.com>
Date:   Thu, 30 Aug 2018 14:22:13 -0700
In-Reply-To: <20180830201244.25759-4-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 30 Aug 2018 20:12:41 +0000")
Message-ID: <xmqqa7p34kje.fsf@gitster-ct.c.googlers.com>
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
> current behavior of eager tag clobbering on "fetch". This is a
> followup to 380efb65df ("push tests: assert re-pushing annotated
> tags", 2018-07-31) which tests for it explicitly.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---

Good addition, and correctly uses $tag_type_description unlike the
one that is left unfixed in 2/6 for the push side.

>  t/t5516-fetch-push.sh | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 69f7c9bfe6..3cde72ae47 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1011,6 +1011,30 @@ test_force_push_tag () {
>  test_force_push_tag "lightweight tag" "-f"
>  test_force_push_tag "annotated tag" "-f -a -mtag.message"
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
> +			git tag testTag &&
> +			git -C ../child1 fetch origin tag testTag &&
> +			>file1 &&
> +			git add file1 &&
> +			git commit -m 'file1' &&
> +			git tag $tag_args testTag &&
> +			git -C ../child1 fetch origin tag testTag
> +		)
> +	"
> +}
> +
> +test_force_fetch_tag "lightweight tag" "-f"
> +test_force_fetch_tag "annotated tag" "-f -a -mtag.message"
> +
>  test_expect_success 'push --porcelain' '
>  	mk_empty testrepo &&
>  	echo >.git/foo  "To testrepo" &&
