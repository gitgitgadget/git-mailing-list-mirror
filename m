Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12FA21F404
	for <e@80x24.org>; Fri, 31 Aug 2018 07:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeHaLYU (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 07:24:20 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36572 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeHaLYT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 07:24:19 -0400
Received: by mail-ed1-f66.google.com with SMTP id f4-v6so8328216edq.3
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 00:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Jr3SxZJh+NKLDCnJ8XFEM4UjofzjiOPYlKLiZs3QhR8=;
        b=SX8tncZWTbUl25SfngcIexnLpW0tc41n9my9x5lskr9nIEGlYBCCXihxYgLLkb4PTJ
         mLGRIazq6xY2Ow1ucl9mfVIRMuQao18UyhYXz7UQCXDdXxZ8UdEFuwICIodz+2C1kCne
         f8QdvHZucJgo4UvXFq89EozbGDl4xKq4Jx8UMNCxWdRc43DPhY6RVNQBJZS6RUr/fb1m
         usuSFpD1ScxYDwN8zPezDzPSrcgEtc6gzIXTst7pFQcA5svm3znn168S8mb+FpJx6dbt
         X13QVWMwaWXpnUCzxfdTi468PdiVJjOzOhDD8w1r+kNi04DFFUvtcwRcR5Zqp2boB8dE
         0WKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Jr3SxZJh+NKLDCnJ8XFEM4UjofzjiOPYlKLiZs3QhR8=;
        b=tL1lHZV54g4gqgKsy6j/evxAV3YibHW2/EdNN85OpWm+WD/Y5c73+0Z7B2fDC2zo04
         cuNB+k2hCkhkJRCCcFjnkznkfUz+qpAwgiuYDrrAdueB4XXoyHqcpgVCOOMyOTImrLgW
         L2DrMonsQd5+j/9l3o4XxpTLfA3SUfv2k/xb/2YE7UbdxJCeaMeXTjW6snz/iitrRCf2
         /wAiIXoDageFHmGOcxR9eUIr6TeufOJ//09xuKeHZIgs0jiAt6BRLFNfIXJ4zgUDOPqD
         EJ95/ppVptLdXAKs7h2pCuHNyd0yDhD3zHkBz/q+PS04spgbLs/C+n8WryRWjsb6gyxO
         OmDw==
X-Gm-Message-State: APzg51AYxeBzvSZbTjlHMNI0cCWb7txaz9Zn5LpuzIixdQCA/H8DgfUx
        FZIooaXqfa5m/n2k2yjt9V9s3kZiYpg=
X-Google-Smtp-Source: ANB0Vdar4wn13LzYG01ad0ulG3ebgs+Gfqnj69xihpS70T/ZELDcSYZq1YSmFZkc5l9YcoI7XtTuSA==
X-Received: by 2002:a50:ed1a:: with SMTP id j26-v6mr16294355eds.29.1535699894859;
        Fri, 31 Aug 2018 00:18:14 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id g19-v6sm3571713edh.22.2018.08.31.00.18.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 00:18:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] Add test for commit --dry-run --short.
References: <20180831053921.8083-1-ischis2@cox.net> <20180831053921.8083-3-ischis2@cox.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180831053921.8083-3-ischis2@cox.net>
Date:   Fri, 31 Aug 2018 09:18:13 +0200
Message-ID: <87bm9jc8cq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 31 2018, Stephen P. Smith wrote:

> Add test for commit with --dry-run --short for a new file of zero
> length.
>
> The test demonstrated that the setting of the commitable flag was
> broken as was found durning an earlier patch review.
>
> Signed-off-by: Stephen P. Smith <ischis2@cox.net>
> ---
>  t/t7501-commit.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
> index 810d4cea7..fc69da816 100755
> --- a/t/t7501-commit.sh
> +++ b/t/t7501-commit.sh
> @@ -682,4 +682,14 @@ test_expect_success '--dry-run with conflicts fixed from a merge' '
>  	git commit -m "conflicts fixed from merge."
>  '
>
> +test_expect_success '--dry-run --short with conflicts fixed from a merge' '
> +	# setup two branches with conflicting information
> +	# in the same file, resolve the conflict,
> +	# call commit with --dry-run --short
> +	rm -f test-file &&
> +	touch testfile &&
> +	git add test-file &&
> +	git commit --dry-run --short
> +'
> +
>  test_done

Ditto my comment on 1/3 on this. I.e. this changes the failing tests in
this series from 2 to 3.
