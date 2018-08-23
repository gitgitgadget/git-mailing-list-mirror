Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0B1A1F954
	for <e@80x24.org>; Thu, 23 Aug 2018 15:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeHWTMd (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 15:12:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50700 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbeHWTMd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 15:12:33 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so5704651wmc.0
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 08:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=2Wk2Nj5mCAlp4ZWSsIsmUC87pluui6VgkRX8AXpS7C4=;
        b=gD57uunkZ5Xh5CCZzeowSLbQEJudeDBDhEhL04I7LwlJOQFy5PYgMCL/JIT9KMDUTc
         YlN9r7w8g1S0hZvXZVMYmU0yjzPrV/MFB2VypqEXCTW3KTcUKQFP9ALdCi8/4TmmkeZd
         lHMkoMtHK53PF6FfZ1v90PuB4Bfxvlxl+Rq5OqtZSSjmBIVt5JGdhAkoMLLBHgB048+h
         YU8aN98zucC0WCR/HPXkqhPK16cknBF3WSBI7Ro9WrKGCmP3JYPIY8W6JpSXIuqoBOQ9
         dZ7yYHnpJeKpgpPJ8r8q5wOkB3Egw2c+WipRH7Pn+BAf44Jx3EutH+vB2RTDUYWb0Q/V
         DHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=2Wk2Nj5mCAlp4ZWSsIsmUC87pluui6VgkRX8AXpS7C4=;
        b=odSLgJ6xht8WPk4OIkWKYY/AtiXlI9RzhIW2bB4FiO8OLBQLTxZkRIIvTPmS62nmrA
         ARUsHRvauV1f2wzqmhdfEwxPDMtitXLQWIaAPwSJPwWFGA85wOHJeCvmZSzbfwMKuzds
         IKMljp3ptDU24N6xo9opgrZF7SIO7n0JBZ9neviPn0D7MS46H+xcP1RlfOoMGv1OXgNN
         Yn1QxmGxnAVJtY3/Rd7Yps7iwgeCgV/t91m2kiASRt5QVOPBMmfYlhkm6jWQifLEeL+Z
         U6rwL1ibG5ac33ybNTthoQnKlssCudWGSJRKgkT9XW05oGVg49woaaeDHi8eYad2N2BM
         w6Yw==
X-Gm-Message-State: APzg51DmwJWH/wHMUisz37Rg6jw0wMp6QzRh9WATSpSjs1aaf6YjHsxL
        qOIbxrufZ+JMTmQ1GQzx9yw=
X-Google-Smtp-Source: ANB0Vdb0/GsOa2VYHGdjfj/q7GIap6vyKEZq2FcEmp6QE3UhvnnNQeza5EqjTxxRolasDZ+1h3Q1WA==
X-Received: by 2002:a1c:b157:: with SMTP id a84-v6mr5272378wmf.18.1535038939368;
        Thu, 23 Aug 2018 08:42:19 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o3-v6sm5255176wrn.58.2018.08.23.08.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 08:42:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Benoit Lecocq <benoit@openbsd.org>, kn@openbsd.org
Subject: Re: [PATCH] tests: fix and add lint for non-portable head -c N
References: <20180823091427.1756-1-avarab@gmail.com>
Date:   Thu, 23 Aug 2018 08:42:18 -0700
In-Reply-To: <20180823091427.1756-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 23 Aug 2018 09:14:27 +0000")
Message-ID: <xmqqmutdjdid.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Junio: Even though this isn't a 2.19.0-rc0 regression I think it makes
> sense for 2.19.0. The fix is trivial, and it'll unbreak (at least some
> of) the tests on stock git on OpenBSD.

I would have been a bit more sympathetic if this were recent
regression (say, 2.18 or so), even if it is not new in this cycle,
and the patch applied to the target track cleanly (say, maint or
maint-2.17), but seeing that some of these are quite old, dating
back to 2009, I am not sure I am enthused.

The changes certainly look trivial.  Let's apply.

Thanks.

>
> OpenBSD guys: If you CC the git mailing list when you find you need to
> apply patches like these, we're happy to fix this more pro-actively. I
> just happened to be testing the upcoming 2.19.0 on OpenBSD and spotted
> this.
>
>  t/check-non-portable-shell.pl | 1 +
>  t/t5310-pack-bitmaps.sh       | 2 +-
>  t/test-lib.sh                 | 4 ++--
>  3 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
> index d5823f71d8..94a7e6165e 100755
> --- a/t/check-non-portable-shell.pl
> +++ b/t/check-non-portable-shell.pl
> @@ -35,6 +35,7 @@ sub err {
>  		chomp;
>  	}
>  
> +	/\bhead\s+-c\b/ and err 'head -c is not portable (use test_copy_bytes BYTES <file >out)';
>  	/\bsed\s+-i/ and err 'sed -i is not portable';
>  	/\becho\s+-[neE]/ and err 'echo with option is not portable (use printf)';
>  	/^\s*declare\s+/ and err 'arrays/declare not portable';
> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index 557bd0d0c0..7bff7923f2 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -335,7 +335,7 @@ test_expect_success 'truncated bitmap fails gracefully' '
>  	git rev-list --use-bitmap-index --count --all >expect &&
>  	bitmap=$(ls .git/objects/pack/*.bitmap) &&
>  	test_when_finished "rm -f $bitmap" &&
> -	head -c 512 <$bitmap >$bitmap.tmp &&
> +	test_copy_bytes 512 <$bitmap >$bitmap.tmp &&
>  	mv -f $bitmap.tmp $bitmap &&
>  	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
>  	test_cmp expect actual &&
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 8bb0f4348e..44288cbb59 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -867,7 +867,7 @@ then
>  		# handle only executables, unless they are shell libraries that
>  		# need to be in the exec-path.
>  		test -x "$1" ||
> -		test "# " = "$(head -c 2 <"$1")" ||
> +		test "# " = "$(test_copy_bytes 2 <"$1")" ||
>  		return;
>  
>  		base=$(basename "$1")
> @@ -882,7 +882,7 @@ then
>  		# do not override scripts
>  		if test -x "$symlink_target" &&
>  		    test ! -d "$symlink_target" &&
> -		    test "#!" != "$(head -c 2 < "$symlink_target")"
> +		    test "#!" != "$(test_copy_bytes 2 <"$symlink_target")"
>  		then
>  			symlink_target=../valgrind.sh
>  		fi
