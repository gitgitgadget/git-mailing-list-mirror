Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D8EA1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 16:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbeIQV7r (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 17:59:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37566 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbeIQV7q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 17:59:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id 2-v6so7924153pgo.4
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 09:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W5nNwXOvJDtFLPG2iimaJZphScRf/aIqTyvWrJizU8g=;
        b=ovAuB9EsUgVb3fAq2DBnxYPiQd4oyPhlLtnIAHnXbNbkay4kmFJ1uKGIcpoAC6V6/v
         qc8cIxm/u+rz4ELUrEqZvXha85Wg7dDkmOKd342nTAmj8WR+ONqC2xUaQtq5k0V1byac
         pDYbZVV4cFbK1XwZitQPWOVifywW55UYCUPKymayrxhKOSEfRijPrwQLFgvDghFeP8lf
         oMc9YNArCtoGmwBp9r8jGcYEEICGvaEDvl+NSaOzZMhn7jN6CUoPWIQyMAiM6rVkjrre
         ZlqtP0P0anzk88xeIjPsuw/wBIl2FwHhoO9OVQuelj3UgEg0iPi58FbGfCqLikoaY/v5
         T4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W5nNwXOvJDtFLPG2iimaJZphScRf/aIqTyvWrJizU8g=;
        b=CUHplk7g3w+XxI5FftyTBBwl+/RXKBSjNS2rXrsw3Bze6ApTphfPgDt5uHgdQmWE0u
         +hAMPdN0QoHk1xIzfI5ajuMCoLstltEwnrfLs87kqTGytKHj0e9UmKRtZdVeAewRMyCF
         9MmQc6GwPulzXR6IRQTClYFaYFcC8rj9YnpnEW4LLAXnRrZkAsrUoQs1jM1bsi5i2OPH
         qD1qZH3NbFUFdDHa/PuvH7yAoPbCNfLCe1lVEnuNG+lz8yh4U7LgHgzB8tHQpER12c9l
         fuh2kcFFdtDg2BGuf13BxHGydf/1XBDFQYxgy6sc0wugv5X8j8zjIPJnNFMHxBRKktZz
         VJFA==
X-Gm-Message-State: APzg51BA7LyXauPwJOCh3VuFyn4vaPetvWPTVKQRTUnUG/Pj540zenBn
        PKTMCfbb0cfd2+oeKTFnGhPtSnXS
X-Google-Smtp-Source: ANB0VdaXwT4rsJk1J5QI6yyw3jcl0lZh1oyDXiy5FpASl4NMSzQpkt4AKDMpD8j+T0PHVcf2/BnyAg==
X-Received: by 2002:a63:fb57:: with SMTP id w23-v6mr24108662pgj.441.1537201899760;
        Mon, 17 Sep 2018 09:31:39 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id j22-v6sm19915475pfh.45.2018.09.17.09.31.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 09:31:39 -0700 (PDT)
Date:   Mon, 17 Sep 2018 09:31:37 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        gitster@pobox.com, bmwill@google.com
Subject: Re: [PATCH v1 1/2] t/*: fix pipe placement and remove \'s
Message-ID: <20180917163137.GB89942@aiede.svl.corp.google.com>
References: <cover.1536969438.git.matvore@google.com>
 <a4c833da81d83ea0e605c936d90ea9c7f5667d93.1536969438.git.matvore@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4c833da81d83ea0e605c936d90ea9c7f5667d93.1536969438.git.matvore@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore wrote:

> Subject: t/*: fix pipe placement and remove \'s
>
> Where ever there was code in the tests like this:
>
> 	foo \
> 		| bar

Language nits:
- s/Where ever/Wherever/
- Git's commit messages use the present tense to describe the existing
  previous state of the codebase, as though reporting a bug.

Maybe something like

	tests: standardize pipe placement

	Instead of using a line-continuation and pipe on the second
	line, take advantage of the shell's implicit line continuation
	after a pipe character.  So for example, instead of

		some long line \
			| next line

	use

		some long line |
		next line

At this point, it would be useful to say something about rationale ---
for example,

	This better matches the coding style documented in
	Documentation/CodingGuidelines and used in shell scripts
	elsewhere in Git.

Except: is this documented in Documentation/CodingGuidelines?  Or,
better, is there a linter that we can run in the test-lint target of
t/Makefile to ensure we keep sticking to this style?

[...]
> --- a/t/lib-gpg.sh
> +++ b/t/lib-gpg.sh
> @@ -57,8 +57,8 @@ then
>  		echo | gpgsm --homedir "${GNUPGHOME}" 2>/dev/null \
>  			--passphrase-fd 0 --pinentry-mode loopback \
>  			--import "$TEST_DIRECTORY"/lib-gpg/gpgsm_cert.p12 &&
> -		gpgsm --homedir "${GNUPGHOME}" 2>/dev/null -K \
> -			| grep fingerprint: | cut -d" " -f4 | tr -d '\n' > \
> +		gpgsm --homedir "${GNUPGHOME}" 2>/dev/null -K |
> +		grep fingerprint: | cut -d" " -f4 | tr -d '\n' > \
>  			${GNUPGHOME}/trustlist.txt &&

I think this would be more readable with one item from the pipeline
per line:

		gpgsm --homedir ... |
		grep ... |
		cut ... |
		tr ... >... &&

[...]
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -218,8 +218,8 @@ test_expect_success "--batch-check for a non-existent hash" '
>      test "0000000000000000000000000000000000000042 missing
>  0000000000000000000000000000000000000084 missing" = \
>      "$( ( echo 0000000000000000000000000000000000000042;
> -         echo_without_newline 0000000000000000000000000000000000000084; ) \
> -       | git cat-file --batch-check)"
> +         echo_without_newline 0000000000000000000000000000000000000084; ) |
> +       git cat-file --batch-check)"

This test is problematic in a lot of ways.  Most importantly, it ignores
the exist status from git cat-file.

So it should say something like:

	cat >expect <<-\EOF &&
		foobar42 missing
		foobar84 missing
	EOF
	printf "foobar42\nfoobar84" |
	git cat-file --batch-check >actual &&
	test_cmp expect actual

If we want to restrict to the pipeline style fixes, we could do

	test "..." = "$(
		{	# Couldn't resist changing the ( to {!
			echo ... &&	# Couldn't resist changing the ; to &&!
			echo_without_newline ...
		} |
		git cat-file --batch-check
	)"

but unless there's a linter that we're helping support, it's probably
better to skip this file and use a dedicated patch to modernize its
style more generally.

[...]
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -1770,8 +1770,9 @@ test_expect_success '--show-origin stdin with file include' '
>  	cat >expect <<-EOF &&
>  		file:$INCLUDE_DIR/stdin.include	include
>  	EOF
> -	echo "[include]path=\"$INCLUDE_DIR\"/stdin.include" \
> -		| git config --show-origin --includes --file - user.stdin >output &&
> +	echo "[include]path=\"$INCLUDE_DIR\"/stdin.include" |
> +	git config --show-origin --includes --file - user.stdin >output &&

Okay.

[...]
> --- a/t/t5317-pack-objects-filter-objects.sh
> +++ b/t/t5317-pack-objects-filter-objects.sh
> @@ -20,17 +20,20 @@ test_expect_success 'setup r1' '
>  '
>  
>  test_expect_success 'verify blob count in normal packfile' '
> -	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 \
> -		| awk -f print_2.awk \
> -		| sort >expected &&
> +	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 |
> +	awk -f print_2.awk |
> +	sort >expected &&

This loses the exit status from git, so we should make it write to a
temporary file instead (as a separate patch).

[...]
> -	git -C r1 verify-pack -v ../all.pack \
> -		| grep blob \
> -		| awk -f print_1.awk \
> -		| sort >observed &&
> +
> +	git -C r1 verify-pack -v ../all.pack |

Likewise (and likewise for the rest in this file).

[...]
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -50,8 +50,9 @@ pull_to_client () {
>  			case "$heads" in *B*)
>  			    git update-ref refs/heads/B "$BTIP";;
>  			esac &&
> -			git symbolic-ref HEAD refs/heads/$(echo $heads \
> -				| sed -e "s/^\(.\).*$/\1/") &&
> +
> +			git symbolic-ref HEAD refs/heads/$(echo $heads |
> +			sed -e "s/^\(.\).*$/\1/") &&

It would be better to use a temporary variable.  If we're just
changing line wrapping, then this would be

			git symbolic-ref HAD refs/heads/$(
				echo $heads |
				sed ...
			) &&

[...]
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -34,10 +34,12 @@ test_expect_success 'setup bare clone for server' '
>  # confirm partial clone was registered in the local config.
>  test_expect_success 'do partial clone 1' '
>  	git clone --no-checkout --filter=blob:none "file://$(pwd)/srv.bare" pc1 &&
> -	git -C pc1 rev-list HEAD --quiet --objects --missing=print \
> -		| awk -f print_1.awk \
> -		| sed "s/?//" \
> -		| sort >observed.oids &&
> +
> +	git -C pc1 rev-list HEAD --quiet --objects --missing=print |

Also needs to write to a temporary to avoid losing the exist status
(and likewise for the rest of this file).

[...]
> --- a/t/t6112-rev-list-filters-objects.sh
> +++ b/t/t6112-rev-list-filters-objects.sh
> @@ -20,24 +20,28 @@ test_expect_success 'setup r1' '
>  '
>  
>  test_expect_success 'verify blob:none omits all 5 blobs' '
> -	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 \
> -		| awk -f print_2.awk \
> -		| sort >expected &&
> -	git -C r1 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:none \
> -		| awk -f print_1.awk \
> -		| sed "s/~//" \
> -		| sort >observed &&
> +	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 |
> +	awk -f print_2.awk |
> +	sort >expected &&

Likewise.

[...]
> --- a/t/t9101-git-svn-props.sh
> +++ b/t/t9101-git-svn-props.sh
> @@ -193,8 +193,8 @@ test_expect_success 'test propget' "
>  	git svn propget svn:ignore . | cmp - prop.expect &&
>  	cd deeply &&
>  	git svn propget svn:ignore . | cmp - ../prop.expect &&
> -	git svn propget svn:entry:committed-rev nested/directory/.keep \
> -	  | cmp - ../prop2.expect &&
> +	git svn propget svn:entry:committed-rev nested/directory/.keep |
> +	cmp - ../prop2.expect &&

Likewise.

Thanks and hope that helps,
Jonathan
