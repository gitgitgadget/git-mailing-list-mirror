Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F9D01F516
	for <e@80x24.org>; Mon,  2 Jul 2018 17:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752258AbeGBRSG (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 13:18:06 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39053 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeGBRSF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 13:18:05 -0400
Received: by mail-pl0-f67.google.com with SMTP id s24-v6so8248262plq.6
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 10:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/0taH5BW2bh+1nEFNjEur4ar/VM2ioHY9eiJQvRG9LA=;
        b=Z/noR84XDSezAkcJ9aDN+OshSzbE6ivCvZB3q8YUfotXqyMSY7YGcbJf9W7QRaDIU/
         w8uNkWyfH9n33i3x69PKdCw0pFVWZ7tBCnPy2R2JCBoC9fuhUNoHb/z2aJmfB/VCBKcL
         FcDVkfJK7hlmKyTzutAzH1/HiKeCPNqaHMBcUUsu8Ji06FIuIw03ZwA6T8w1mmgs/E3O
         Djk3+ysaA8xs3Sp3jINnNk+Upy4IIAlVLmCa+21dpRhLZHaAOkN6cudVEVAyHNU5eguZ
         9VKenCurF8XKr+KjYmMVYpiCg9y6NPsEpoPocGZs2zZWUJF9UY7Ib6MmGO9TxtZ9F9Go
         AUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/0taH5BW2bh+1nEFNjEur4ar/VM2ioHY9eiJQvRG9LA=;
        b=fxK+w1n9ThiCtipj7bBWzc3swpFhm30Bz01FldPJkGjlCvfNxsBwhJbzfFTAVBf3+L
         BhjHMHN/1+hkdJrgAPHiCXBg58zyKAouVgkacFYazQP5W0zipaBW360Q9zXEdpjWsC3W
         UsapnIVVmPGlcuulsirNMy4OCRXfqmrMY76zud3y93i/9YzJaKtY13ZlBirV0ye47Yl6
         s5yJLkvf8CDaTx3zp8915+WncRRdF2yhzlnVhdPhU50TINNaqkzppg8/d+V48OYqzIzo
         9N+o0ffXUjaMRWE8hbJtrLTEjArlOmQlpI00pfU3c+OA7kaHh8cAcc4kZkitsV72SDK1
         f8Tg==
X-Gm-Message-State: APt69E1So2DUrM/Puwpl5IAJQSoQkvP9H+l4VC+/o9wP5Hw1OgDbFfV0
        OgTheOlTBMvDXqfL2pi+5Ai6zw==
X-Google-Smtp-Source: AAOMgpfWNEUbSjtIPq3UuTDPnhw8TmQYIMw33gRmWfDzggc26cz14f8I9X7rQEmJXUQkufqll/jCCg==
X-Received: by 2002:a17:902:b785:: with SMTP id e5-v6mr19062914pls.339.1530551884291;
        Mon, 02 Jul 2018 10:18:04 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id m5-v6sm11971378pfm.27.2018.07.02.10.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 10:18:02 -0700 (PDT)
Date:   Mon, 2 Jul 2018 10:18:01 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        jonathantanmy@google.com, simon@ruderich.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 6/9] diff.c: add a blocks mode for moved code detection
Message-ID: <20180702171801.GB246956@google.com>
References: <20180622015725.219575-1-sbeller@google.com>
 <20180629001958.85143-1-sbeller@google.com>
 <20180629001958.85143-7-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180629001958.85143-7-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/28, Stefan Beller wrote:
> The new "blocks" mode provides a middle ground between plain and zebra.
> It is as intuitive (few colors) as plain, but still has the requirement
> for a minimum of lines/characters to count a block as moved.
> 
> Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>  (https://public-inbox.org/git/87o9j0uljo.fsf@evledraar.gmail.com/)
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/diff-options.txt |  8 ++++--
>  diff.c                         |  6 +++--
>  diff.h                         |  5 ++--
>  t/t4015-diff-whitespace.sh     | 49 ++++++++++++++++++++++++++++++++--
>  4 files changed, 60 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index e3a44f03cdc..ba56169de31 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -276,10 +276,14 @@ plain::
>  	that are added somewhere else in the diff. This mode picks up any
>  	moved line, but it is not very useful in a review to determine
>  	if a block of code was moved without permutation.
> -zebra::
> +blocks::
>  	Blocks of moved text of at least 20 alphanumeric characters
>  	are detected greedily. The detected blocks are
> -	painted using either the 'color.diff.{old,new}Moved' color or
> +	painted using either the 'color.diff.{old,new}Moved' color.
> +	Adjacent blocks cannot be told apart.
> +zebra::
> +	Blocks of moved text are detected as in 'blocks' mode. The blocks
> +	are painted using either the 'color.diff.{old,new}Moved' color or
>  	'color.diff.{old,new}MovedAlternative'. The change between
>  	the two colors indicates that a new block was detected.
>  dimmed_zebra::
> diff --git a/diff.c b/diff.c
> index d1bae900cdc..95c51c0b7df 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -271,6 +271,8 @@ static int parse_color_moved(const char *arg)
>  		return COLOR_MOVED_NO;
>  	else if (!strcmp(arg, "plain"))
>  		return COLOR_MOVED_PLAIN;
> +	else if (!strcmp(arg, "blocks"))
> +		return COLOR_MOVED_BLOCKS;
>  	else if (!strcmp(arg, "zebra"))
>  		return COLOR_MOVED_ZEBRA;
>  	else if (!strcmp(arg, "default"))
> @@ -278,7 +280,7 @@ static int parse_color_moved(const char *arg)
>  	else if (!strcmp(arg, "dimmed_zebra"))
>  		return COLOR_MOVED_ZEBRA_DIM;
>  	else
> -		return error(_("color moved setting must be one of 'no', 'default', 'zebra', 'dimmed_zebra', 'plain'"));
> +		return error(_("color moved setting must be one of 'no', 'default', 'blocks', 'zebra', 'dimmed_zebra', 'plain'"));
>  }
>  
>  int git_diff_ui_config(const char *var, const char *value, void *cb)
> @@ -903,7 +905,7 @@ static void mark_color_as_moved(struct diff_options *o,
>  
>  		block_length++;
>  
> -		if (flipped_block)
> +		if (flipped_block && o->color_moved != COLOR_MOVED_BLOCKS)
>  			l->flags |= DIFF_SYMBOL_MOVED_LINE_ALT;
>  	}
>  	adjust_last_block(o, n, block_length);
> diff --git a/diff.h b/diff.h
> index d29560f822c..7bd4f182c33 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -208,8 +208,9 @@ struct diff_options {
>  	enum {
>  		COLOR_MOVED_NO = 0,
>  		COLOR_MOVED_PLAIN = 1,
> -		COLOR_MOVED_ZEBRA = 2,
> -		COLOR_MOVED_ZEBRA_DIM = 3,
> +		COLOR_MOVED_BLOCKS = 2,
> +		COLOR_MOVED_ZEBRA = 3,
> +		COLOR_MOVED_ZEBRA_DIM = 4,
>  	} color_moved;
>  	#define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
>  	#define COLOR_MOVED_MIN_ALNUM_COUNT 20
> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index ddbc3901385..e54529f026d 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -1223,7 +1223,7 @@ test_expect_success 'plain moved code, inside file' '
>  	test_cmp expected actual
>  '
>  
> -test_expect_success 'detect permutations inside moved code -- dimmed_zebra' '
> +test_expect_success 'detect blocks of moved code' '
>  	git reset --hard &&
>  	cat <<-\EOF >lines.txt &&
>  		long line 1
> @@ -1271,6 +1271,50 @@ test_expect_success 'detect permutations inside moved code -- dimmed_zebra' '
>  	test_config color.diff.newMovedDimmed "normal cyan" &&
>  	test_config color.diff.oldMovedAlternativeDimmed "normal blue" &&
>  	test_config color.diff.newMovedAlternativeDimmed "normal yellow" &&
> +	git diff HEAD --no-renames --color-moved=blocks --color >actual.raw &&
> +	grep -v "index" actual.raw | test_decode_color >actual &&
> +	cat <<-\EOF >expected &&
> +	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
> +	<BOLD>--- a/lines.txt<RESET>
> +	<BOLD>+++ b/lines.txt<RESET>
> +	<CYAN>@@ -1,16 +1,16 @@<RESET>
> +	<MAGENTA>-long line 1<RESET>
> +	<MAGENTA>-long line 2<RESET>
> +	<MAGENTA>-long line 3<RESET>
> +	 line 4<RESET>
> +	 line 5<RESET>
> +	 line 6<RESET>
> +	 line 7<RESET>
> +	 line 8<RESET>
> +	 line 9<RESET>
> +	<CYAN>+<RESET><CYAN>long line 1<RESET>
> +	<CYAN>+<RESET><CYAN>long line 2<RESET>
> +	<CYAN>+<RESET><CYAN>long line 3<RESET>
> +	<CYAN>+<RESET><CYAN>long line 14<RESET>
> +	<CYAN>+<RESET><CYAN>long line 15<RESET>
> +	<CYAN>+<RESET><CYAN>long line 16<RESET>
> +	 line 10<RESET>
> +	 line 11<RESET>
> +	 line 12<RESET>
> +	 line 13<RESET>
> +	<MAGENTA>-long line 14<RESET>
> +	<MAGENTA>-long line 15<RESET>
> +	<MAGENTA>-long line 16<RESET>
> +	EOF
> +	test_cmp expected actual
> +

Theres an empty line here.  Not worth fixing if its the only issue
though.

-- 
Brandon Williams
