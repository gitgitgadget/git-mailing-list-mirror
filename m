Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_MIXED_ES shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1261120A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 16:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbeLMQIu (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 11:08:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52514 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbeLMQIt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 11:08:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so2919964wml.2
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 08:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=hkC/DFFZK7hPEba6ycW/fKd2D/JRBoo7kUmdIbF9zQE=;
        b=BhDe9ww8SBM/Nh+jaWPXfP4yXwORvefpIq10psYXAWJqJKP0uLkf6kphb6AwAUAozh
         6jmqa7y2Rzi9KYEiAQ2w8Qx8mEiqcUmJ7YegHiziFl9LbMxws5GPq9pf5MC9Y1HgXPaM
         l3ttFtdurcq1gHdKX6kRpdZ0mbg3bAJNJ9D8LlDeWbOAg21voHkKFN9CwHiE1v9MAyJ+
         qwzsQwF6+4mDGBREL8O/JGAKSGJdRvUyNt/XeQqcKGIpOP4wpkWisGc2pn5jB/jPBdXG
         yhjAcJ+Kst8jjfcPHXbLdSXYbtQfBSrVpbDMYUW/YyP0BUCvcdCYtxwbx2AZ5Wp8Hlyf
         0omw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=hkC/DFFZK7hPEba6ycW/fKd2D/JRBoo7kUmdIbF9zQE=;
        b=MhEEXu9mG54mSLTlo4L4bs9ScOxRE0R6B88CrEslJIcDlXAYF8zZ0x+8OL7yIaQ80l
         YN9WmS8HCj95pazLSST2SndUVbPqdW4vz4XRzzdOV2zurPPHtwqR/ishpfGssxPhabaO
         WPn/1+3jdgpLfx7O2ZVa8Jn4yPLvHyIvO21AuxofY1Q3YLX3pHj8eEGQ8ouSeq3rislc
         rGYOpGxc1WUvlt4c8L10PEPHN1E8qs0ps0mptUzYIrSCgIehRhIPWLOr5stLBGtLRByG
         MWEWqsffHVnvN9VpP4q/Ld7i0i2Xm+q5mtBXQTGanE8dI99PhFUiuuou3T3PsoKnba/O
         iyWA==
X-Gm-Message-State: AA+aEWYfhDRjlQhUExT5vZ7CUH7wp3fg4FWbgc+rvX3F2b0DGxSiXzoI
        SEVA7I1Hs6cRKSd9swyJvicvTSPtXLw=
X-Google-Smtp-Source: AFSGD/Wykw8bDF5QlYjfbQudWlf/6/Y1X1i6wsQbZP8vGEK1vjdj+0/slqUBqyOWK7rRVF97U6E8Ow==
X-Received: by 2002:a1c:c543:: with SMTP id v64mr10197794wmf.123.1544717326918;
        Thu, 13 Dec 2018 08:08:46 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id e142sm5119128wmf.46.2018.12.13.08.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 08:08:45 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 8/8] tests: mark tests broken under GIT_TEST_PROTOCOL_VERSION=2
References: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com> <20181213155817.27666-9-avarab@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181213155817.27666-9-avarab@gmail.com>
Date:   Thu, 13 Dec 2018 17:08:43 +0100
Message-ID: <87pnu51kac.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 13 2018, Ævar Arnfjörð Bjarmason wrote:

Now that we have this maybe we should discuss why these tests show
different things:

> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 086f2c40f6..8b1217ea26 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -628,7 +628,10 @@ test_expect_success 'fetch-pack cannot fetch a raw sha1 that is not advertised a
>  	test_commit -C server 6 &&
>
>  	git init client &&
> -	test_must_fail git -C client fetch-pack ../server \
> +
> +	# Other protocol versions (e.g. 2) allow fetching an unadvertised
> +	# object, so run this test with the default protocol version (0).
> +	test_must_fail env GIT_TEST_PROTOCOL_VERSION= git -C client fetch-pack ../server \
>  		$(git -C server rev-parse refs/heads/master^) 2>err &&

What? So the equivalent of uploadpack.allowAnySHA1InWant=true is on for
v2 all the time?

>  	test_i18ngrep "Server does not allow request for unadvertised object" err
>  '
> @@ -788,7 +791,7 @@ test_expect_success 'shallow clone exclude tag two' '
>  '
>
>  test_expect_success 'fetch exclude tag one' '
> -	git -C shallow12 fetch --shallow-exclude one origin &&
> +	GIT_TEST_PROTOCOL_VERSION= git -C shallow12 fetch --shallow-exclude one origin &&
>  	git -C shallow12 log --pretty=tformat:%s origin/master >actual &&
>  	test_write_lines three two >expected &&
>  	test_cmp expected actual
> @@ -806,7 +809,7 @@ test_expect_success 'fetching deepen' '
>  	git -C deepen log --pretty=tformat:%s master >actual &&
>  	echo three >expected &&
>  	test_cmp expected actual &&
> -	git -C deepen fetch --deepen=1 &&
> +	GIT_TEST_PROTOCOL_VERSION= git -C deepen fetch --deepen=1 &&
>  	git -C deepen log --pretty=tformat:%s origin/master >actual &&
>  	cat >expected <<-\EOF &&
>  	four
> diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
> index 4ca48f0276..0e90a90294 100755
> --- a/t/t5503-tagfollow.sh
> +++ b/t/t5503-tagfollow.sh
> @@ -56,7 +56,7 @@ test_expect_success 'fetch A (new commit : 1 connection)' '
>  	rm -f $U &&
>  	(
>  		cd cloned &&
> -		GIT_TRACE_PACKET=$UPATH git fetch &&
> +		GIT_TRACE_PACKET=$UPATH GIT_TEST_PROTOCOL_VERSION= git fetch &&
>  		test $A = $(git rev-parse --verify origin/master)
>  	) &&
>  	get_needs $U >actual &&
> @@ -86,7 +86,7 @@ test_expect_success 'fetch C, T (new branch, tag : 1 connection)' '
>  	rm -f $U &&
>  	(
>  		cd cloned &&
> -		GIT_TRACE_PACKET=$UPATH git fetch &&
> +		GIT_TRACE_PACKET=$UPATH GIT_TEST_PROTOCOL_VERSION= git fetch &&
>  		test $C = $(git rev-parse --verify origin/cat) &&
>  		test $T = $(git rev-parse --verify tag1) &&
>  		test $A = $(git rev-parse --verify tag1^0)
> @@ -122,7 +122,7 @@ test_expect_success 'fetch B, S (commit and tag : 1 connection)' '
>  	rm -f $U &&
>  	(
>  		cd cloned &&
> -		GIT_TRACE_PACKET=$UPATH git fetch &&
> +		GIT_TRACE_PACKET=$UPATH GIT_TEST_PROTOCOL_VERSION= git fetch &&
>  		test $B = $(git rev-parse --verify origin/master) &&
>  		test $B = $(git rev-parse --verify tag2^0) &&
>  		test $S = $(git rev-parse --verify tag2)
> @@ -146,7 +146,7 @@ test_expect_success 'new clone fetch master and tags' '
>  		cd clone2 &&
>  		git init &&
>  		git remote add origin .. &&
> -		GIT_TRACE_PACKET=$UPATH git fetch &&
> +		GIT_TRACE_PACKET=$UPATH GIT_TEST_PROTOCOL_VERSION= git fetch &&
>  		test $B = $(git rev-parse --verify origin/master) &&
>  		test $S = $(git rev-parse --verify tag2) &&
>  		test $B = $(git rev-parse --verify tag2^0) &&
> diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
> index ca69636fd5..7b480587c9 100755
> --- a/t/t5512-ls-remote.sh
> +++ b/t/t5512-ls-remote.sh
> @@ -223,7 +223,7 @@ test_expect_success 'ls-remote --symref' '
>  	$(git rev-parse refs/tags/mark1.10)	refs/tags/mark1.10
>  	$(git rev-parse refs/tags/mark1.2)	refs/tags/mark1.2
>  	EOF
> -	git ls-remote --symref >actual &&
> +	GIT_TEST_PROTOCOL_VERSION= git ls-remote --symref >actual &&
>  	test_cmp expect actual
>  '
>
> @@ -243,7 +243,7 @@ test_expect_failure 'ls-remote with filtered symref (--heads)' '
>  	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/foo
>  	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
>  	EOF
> -	git ls-remote --symref --heads . >actual &&
> +	GIT_TEST_PROTOCOL_VERSION= git ls-remote --symref --heads . >actual &&
>  	test_cmp expect actual
>  '
>
> @@ -252,9 +252,9 @@ test_expect_success 'ls-remote --symref omits filtered-out matches' '
>  	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/foo
>  	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
>  	EOF
> -	git ls-remote --symref --heads . >actual &&
> +	GIT_TEST_PROTOCOL_VERSION=  git ls-remote --symref --heads . >actual &&
>  	test_cmp expect actual &&
> -	git ls-remote --symref . "refs/heads/*" >actual &&
> +	GIT_TEST_PROTOCOL_VERSION= git ls-remote --symref . "refs/heads/*" >actual &&
>  	test_cmp expect actual
>  '
>
> diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
> index 36b0dbc01c..f095555c3e 100755
> --- a/t/t5515-fetch-merge-logic.sh
> +++ b/t/t5515-fetch-merge-logic.sh

This one should really be looked at by someone more familiar with
v2. Looks scary that we have different merge results with it.

> @@ -147,7 +147,7 @@ do
>  			do
>  				git update-ref -d "$refname" "$val"
>  			done
> -			git fetch "$@" >/dev/null
> +			GIT_TEST_PROTOCOL_VERSION= git fetch "$@" >/dev/null
>  			cat .git/FETCH_HEAD
>  		} >"$actual_f" &&
>  		git show-ref >"$actual_r" &&
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 08cdee0b95..1d1b717cd5 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1129,7 +1129,7 @@ do
>  	'
>  done
>
> -test_expect_success 'fetch exact SHA1' '
> +test_expect_success 'fetch exact SHA1 in protocol v0' '
>  	mk_test testrepo heads/master hidden/one &&
>  	git push testrepo master:refs/hidden/one &&
>  	(
> @@ -1148,7 +1148,8 @@ test_expect_success 'fetch exact SHA1' '
>  		test_must_fail git cat-file -t $the_commit &&
>
>  		# fetching the hidden object should fail by default
> -		test_must_fail git fetch -v ../testrepo $the_commit:refs/heads/copy 2>err &&
> +		test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
> +			git fetch -v ../testrepo $the_commit:refs/heads/copy 2>err &&
>  		test_i18ngrep "Server does not allow request for unadvertised object" err &&
>  		test_must_fail git rev-parse --verify refs/heads/copy &&
>
> @@ -1205,7 +1206,8 @@ do
>  		mk_empty shallow &&
>  		(
>  			cd shallow &&
> -			test_must_fail git fetch --depth=1 ../testrepo/.git $SHA1 &&
> +			test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
> +				git fetch --depth=1 ../testrepo/.git $SHA1 &&
>  			git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
>  			git fetch --depth=1 ../testrepo/.git $SHA1 &&
>  			git cat-file commit $SHA1
> @@ -1233,15 +1235,18 @@ do
>  		mk_empty shallow &&
>  		(
>  			cd shallow &&
> -			test_must_fail ok=sigpipe git fetch ../testrepo/.git $SHA1_3 &&
> -			test_must_fail ok=sigpipe git fetch ../testrepo/.git $SHA1_1 &&
> +			test_must_fail ok=sigpipe env GIT_TEST_PROTOCOL_VERSION= \
> +				git fetch ../testrepo/.git $SHA1_3 &&
> +			test_must_fail ok=sigpipe env GIT_TEST_PROTOCOL_VERSION= \
> +				git fetch ../testrepo/.git $SHA1_1 &&
>  			git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
>  			git fetch ../testrepo/.git $SHA1_1 &&
>  			git cat-file commit $SHA1_1 &&
>  			test_must_fail git cat-file commit $SHA1_2 &&
>  			git fetch ../testrepo/.git $SHA1_2 &&
>  			git cat-file commit $SHA1_2 &&
> -			test_must_fail ok=sigpipe git fetch ../testrepo/.git $SHA1_3
> +			test_must_fail ok=sigpipe env GIT_TEST_PROTOCOL_VERSION= \
> +				git fetch ../testrepo/.git $SHA1_3
>  		)
>  	'

Ditto all this stuff.

> [...]
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index e87164aa8f..a555e38845 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -943,7 +943,8 @@ test_expect_success 'submodule update clone shallow submodule outside of depth'
>  		cd super3 &&
>  		sed -e "s#url = ../#url = file://$pwd/#" <.gitmodules >.gitmodules.tmp &&
>  		mv -f .gitmodules.tmp .gitmodules &&
> -		test_must_fail git submodule update --init --depth=1 2>actual &&
> +		test_must_fail env GIT_TEST_PROTOCOL_VERSION= \
> +			git submodule update --init --depth=1 2>actual &&
>  		test_i18ngrep "Direct fetching of that commit failed." actual &&
>  		git -C ../submodule config uploadpack.allowReachableSHA1InWant true &&
>  		git submodule update --init --depth=1 >actual &&

And this one and various other shallow things look odd, are shallow
fetches different under v2?
