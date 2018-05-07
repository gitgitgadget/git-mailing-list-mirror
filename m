Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35CEB1F42E
	for <e@80x24.org>; Mon,  7 May 2018 12:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeEGL76 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 07:59:58 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38299 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeEGL75 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 07:59:57 -0400
Received: by mail-wm0-f43.google.com with SMTP id m198-v6so14121582wmg.3
        for <git@vger.kernel.org>; Mon, 07 May 2018 04:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=hTwz8E3ixzcBWTqKUj6nq05zlAnpsNhdARF9CZ74VqE=;
        b=pEZEncsr+4KbNz2lDxQuEOzPHWBtQMtwSVLtlZdWgZcJ3NleVr8pJWa4tt9ZrbaCMs
         A7HbquqBvQmfDT2c/erNWLecPvcv7K7J8f8/KUy4pOJXB8sKKszv1O8qa+DWH5q7u22E
         HFOAKB0bWmyzrLMUA6TUXudaH1Y+QirDFwBQ+Gw0AqoPBnZ47P2X4dDVnow87w7eb+uM
         WFBBDQJz508bkdN3RuTiSiLPEO6hlXZsJno1+Q9DiRIgYDge2UKynXEJLE73s+NZh251
         E0vDYDa9qgnibEHupoSryctGtqNXoCeTZaHstE/bgqCZZqHE65C2w+FLucL8nZYGfRpZ
         isHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=hTwz8E3ixzcBWTqKUj6nq05zlAnpsNhdARF9CZ74VqE=;
        b=WtPyW0lkrstAa+WyMo3xCm5zIB7FDouxIpLbVnVagNi2opWXyf1Ku1TqqGDp0z/WRA
         Ss08B6lYdiOw1/e12mq/THZoYMa7qBbC72237X7NO6ZtNFacnv+fJ7ILkZNORN3PwZKy
         UhKTeme/lAoMserkftgRge86Yst81hV3pnM6x3kLm4hMEvtAN38deLeNrSJw9aC7iUHj
         hTHgQoRaC4Ag6Q/ejV9Aw5aN0ReAHl1Pvpmspjxv7jMjc5K1KQJmWeQeuo7Uup8cWDvT
         FKNz0SMHFwORHsFgZHpaGTBcEvvcWGNPn4CxV6hvSFAqW82v62sg3CXa+vdYOqUHth0Z
         NtdA==
X-Gm-Message-State: ALKqPwcVaTRo8x0qxAxH9zXZPqCfRdddOCf6edsYRj4W6aNino0J3TV8
        zwpKorq0qD3DRoU2NV8QGCkMTg==
X-Google-Smtp-Source: AB8JxZqDNJkuIPEpQzFD9aNMCJ+jl1RFaaz6glwlthtJ1B5/H7KjMUB7Th4kZCcg2JheqzfdBLGshw==
X-Received: by 10.28.109.144 with SMTP id b16mr603868wmi.138.1525694395970;
        Mon, 07 May 2018 04:59:55 -0700 (PDT)
Received: from localhost.localdomain (x590c55ee.dyn.telefonica.de. [89.12.85.238])
        by smtp.gmail.com with ESMTPSA id 47-v6sm20945963wrw.40.2018.05.07.04.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 May 2018 04:59:55 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: introduce test_unset_prereq, for debugging
Date:   Mon,  7 May 2018 13:59:50 +0200
Message-Id: <20180507115950.3887-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.583.gcecc8b8e24
In-Reply-To: <b94af009c1bc9c9b96d977b1c5775ff73669138f.1524954814.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> While working on the --convert-graft-file test, I missed that I was
> relying on the GPG prereq, by using output of test cases that were only
> run under that prereq.

That GPG vs --convert-graft-file thing really does have a bit of a
fallout, doesn't it?  I'm at five patches and possibly counting...

> For debugging, it was really convenient to force that prereq to be
> unmet, but there was no easy way to do that.

Well, in case of the GPG prereq there is an easy way: you could have
just commented out that

  . "$TEST_DIRECTORY/lib-gpg.sh"

line near the beginning of the test script.  Just a single '#'
character, it can't get much easier than that :)

But yeah, this doesn't work with every prereq...

> So I came up with a way,
> and this patch reflects the cleaned-up version of that way.
> 
> For convenience, the following two methods are now supported ways to
> pretend that a prereq is not met:
> 
> 	test_set_prereq !GPG
> 
> and
> 
> 	test_unset_prereq GPG

I'm not sure this is the right way to do this.

I wanted to run the whole test suite with all GPG tests skipped the
other day.  With this 'test_unset_prereq' I would have to modify all
test scripts containing tests depending on the GPG prereq and add
'test_unset_prereq GPG', right?  I rather modified 't/lib-gpg.sh',
i.e. only a single file, instead of modifying the 13 test scripts that
match the 'test_expect_[a-z]*[ ,]GPG[ ,]' regexp.

I think we would be better served by an environment variable similar
to $GIT_SKIP_TESTS, e.g. $GIT_SKIP_PREREQS, to list all the prereqs
that should be skipped even if they were met.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/git/releases/tag/test-unset-prereq-v1
> Fetch-It-Via: git fetch https://github.com/dscho/git test-unset-prereq-v1
>  t/test-lib-functions.sh | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Anyway, please add a bit of documentation with docstrings and/or in
't/README'.

> 
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 7d620bf2a9a..76cd6630f29 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -278,8 +278,20 @@ write_script () {
>  # The single parameter is the prerequisite tag (a simple word, in all
>  # capital letters by convention).
>  
> +test_unset_prereq () {
> +	! test_have_prereq "$1" ||
> +	satisfied_prereq="${satisfied_prereq% $1 *} ${satisfied_prereq#* $1 }"
> +}
> +
>  test_set_prereq () {
> -	satisfied_prereq="$satisfied_prereq$1 "
> +	case "$1" in
> +	!*)
> +		test_unset_prereq "${1#!}"
> +		;;
> +	*)
> +		satisfied_prereq="$satisfied_prereq$1 "
> +		;;
> +	esac
>  }
>  satisfied_prereq=" "
>  lazily_testable_prereq= lazily_tested_prereq=
> 
> base-commit: 1f1cddd558b54bb0ce19c8ace353fd07b758510d
> -- 
> 2.17.0.windows.1.36.gdf4ca5fb72a
> 
