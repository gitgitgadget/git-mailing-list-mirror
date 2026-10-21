Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595467;
	b=dKryPxuoEa/89l/WmwR6vibP66x8Sty8Lxy8MxXnEvil9VnbMCaJE8uS25tgXiysKD25
	 S6RMduBHC8jY6UZlKG1vblrgn1Otq1GwBQ1rHlTIRsN9RJyVtgZJ8hJlOEaDMWMgIaoY8
	 vEN+pla0LaFktHAPagpELJNgULNUqXIIliRPmklkhTLfSeRSq1b3THbgKXiF6M3ej0azX
	 qd0c54SuRVK7vGEkQDwpx1Pvod5G78hAx8FrGxbDCKji79HsMZtShqW5vP3Kx/ChmU3VZ
	 OiYtdVlq7+MTQldZNe4F7pwLsIAjUlYswu5ll1laXNJMB3Rl6ZKVMHGamRB7A0J6NQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=39rg1zFPRJI7abGjex8qPqR0YYdQMYxibhCJHxrGRFc=;
	b=WPokaeZp4ctBLddyBGuDXOZM40r+Mx3E34RLtporTpX8sgAZwYMzV6hleHyd4dKtyJvk
	 gqgGvgTKuBVvjkj8+JpFzF/ZULHrajpgw73Ww1xii5xaojM3vNJg02GlSCGC6LhYtur/Q
	 vRUplEBV+GaEqTY8x+8fD9gTAaK5yHhdNClBfycHxqFOUhWYUqEfo6gqnbQ0ro4spNog6
	 4h1BfIF99WIaBfPs0jUQG2/Eu5t6MEqcYxq/ucPPr4FWB0grFTG6HDI0QZhRKSkqKaPn9
	 QnbbP3xLK6swTegaR4hI3dT1UWU0WKyi6f1M/O2I2O4Ea1oBYCAB6sCWW02HN8dK7Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BDmz55lZ;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5744606A325
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 15:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5744606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BDmz55lZ
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso671489f8f.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 08:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792595465; x=1793200265; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=39rg1zFPRJI7abGjex8qPqR0YYdQMYxibhCJHxrGRFc=;
        b=BDmz55lZl9p9NYCQeINZFxN02QYDfYblj465Ljk0+qr8SDmbZeBTtIDFhPq38kUNhE
         ZzCR8Q4aympQRX4AvQEgbeyQtiYXUoNJ1+nfWm/2ok8tR9/EPtRCC2nM7WBtLSn8oD1k
         uKkYpu983b4G8UVzFQmx1VY+0GT9fbxIMd0OsMFVdZnCXZMzMr87wWNBE3p1Xm56oRbT
         LVTyGmkelg9luzioPDhP8kSF5fcdw86aOwOxM281wF/xqLcTzNkjTuigDrYLDGqxMiJL
         1gjMVDbcxASwOS9v3TzJV4GRnldPe8sNFR0Zgi6ypDjWHMuJEjZ5xse3K5Hk0IF7bfBe
         2RoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792595465; x=1793200265;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=39rg1zFPRJI7abGjex8qPqR0YYdQMYxibhCJHxrGRFc=;
        b=lGJqiVH6xoIAY/wQo2lzWyMfEnS0bx2C0sQcI2oP4fMGpmSG1VFJTuRDL2/5z8eJQg
         A7xoNiB/uHRzArD4lysdaE4dNBJ4qpBK1lV5Pl1IkM+8x1Q0npHtqEUYRguPavAW7oCe
         wA/+WpV3ZKG+UKr7CIhG4byw9V9vpmHxPbrW7okgUPo4C2evCT75bE1iXDy5Fp9sKo6X
         yfFWEdkdUDsjs4OQ6wg+erTiK3Zqhxkv3yvAGUYTiFRBB9IMUZI5LpIv8oCmrBleFo2j
         2813QOdKasWs/9/T3oC3dyTcnzPbDfpbmPq5IE7m7NarBtNjOF6KcZy3xvL71Y33hwwU
         tqWw==
X-Forwarded-Encrypted: i=1; AKwUvBwXdjpdo5/oHnq3r3hpRUOptavonKWbeDV6HksmtlQGLigG23WYBkV/DTb8ZuPaVwd8oNc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJgyb5ezWyDR9DwgOG6oOS7IqbOl/tQi/5USTYD3jQWLOOcswZR
	XbHE7P4W2ndLoIDJkpP86Q7Gr37NceSBK8sgdZYnO13Wkr7vQ4CFXfeP
X-Gm-Gg: AYBFou0nia4FbApYpFvdR/h0br54dohGKEJVT/UzfHvIqBvkGpasWuL5Wka5N5IRKXL
	3HeR4uEin9Ks35EV5uoSylB4F9WDiX5WMySdE3ovtNBVJevRJHoqpybAWnflQuZ+9jqqacR4Obw
	9nUrh0vXZS3N1MPS6rlR1OnHMVfpJhthAcrCGve5Jfl2uqb/98GZpYlX2vi6z94Y/92SwIcS966
	KC1ZfInRj096sKSPkPgxwcCcb8tmfzTkH9ATR9R7+/TIFH/IDOx2K43mie/nPVufBI9DOAcilqG
	F9CspOpPrpCzHiFT69I3AW0WgAnw4tKlBRtU8czjTnbYJndW2Bgc1zOmCxgiDMw74R2zJj6E5s8
	0TeIhaaD+1+i2H5w3wf2q09eNOoUyMV62Zpf5fUIjeNMhbiow42zqMJ1JivDTwU96IsUVFNg8L7
	/Y6Mk0g3h/Z491xJC4QL6FFGLmJxGWbas1xak+Xl1DQu28e973PboJEFmhvny9m4/C22zlznLnY
	ZlJhWwoHnD8E5v4yq4iE9uASTNqdA/rINWuVbkkIToT7+nitlho+j+4OLiBnqWyzOtev4r63tNA
	9BaQ2m3aYNqaai7PH2cw4sC+kLoJEDgZnQ==
X-Received: by 2002:a05:600d:82c1:b0:4a1:cdab:f5c4 with SMTP id 5b1f17b1804b1-4a1fdd24674mr49786795e9.5.1792595464690;
        Wed, 21 Oct 2026 08:11:04 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fb698cebsm122402145e9.1.2026.10.21.08.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 08:11:04 -0700 (PDT)
Message-ID: <3354eeb4-3b9d-474e-bf9f-8efd2ca3a512@gmail.com>
Date: Wed, 21 Oct 2026 16:11:03 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/2] commit: allow -m/-F for all kinds of --fixup
To: erik@cervined.in, git@vger.kernel.org
Cc: gitster@pobox.com
References: <cover.1779792311.git.erik@cervined.in>
 <cover.1790082176.git.erik@cervined.in>
 <4581f97cb737c701081614be0e222ee4c860ce1c.1790082176.git.erik@cervined.in>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <4581f97cb737c701081614be0e222ee4c860ce1c.1790082176.git.erik@cervined.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Erik

On 22/09/2026 14:04, erik@cervined.in wrote:

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 205fbd57e3..ffb8644653 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -816,18 +816,18 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>   	if (have_option_m && !fixup_message) {
>   		strbuf_addbuf(&sb, &message);
>   		hook_arg1 = "message";
> -	} else if (logfile && !strcmp(logfile, "-")) {
> +	} else if (logfile && !fixup_message && !strcmp(logfile, "-")) {
>   		if (isatty(0))
>   			fprintf(stderr, _("(reading log message from standard input)\n"));
>   		if (strbuf_read(&sb, 0, 0) < 0)
>   			die_errno(_("could not read log from standard input"));
>   		hook_arg1 = "message";
It is a bit unfortunate that we have to guard these with 
"!fixup_message" and duplicate the inside the "else if (fixup_message)" 
lower down, but I don't see an easy way of avoiding it. I guess we could 
factor it out into a helper function but I'm not sure if it is worth the 
effort.

> @@ -849,20 +849,21 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>   		hook_arg1 = "message";
>   
>   		/*
> -		 * Only `-m` commit message option is checked here, as
> -		 * it supports `--fixup` to append the commit message.
> -		 *
> -		 * The other commit message options `-c`/`-C`/`-F` are
> -		 * incompatible with all the forms of `--fixup` and
> -		 * have already errored out while parsing the `git commit`
> -		 * options.
> +		 * Only `-m` and `-F` are handled here. `-c`/`-C` are
> +		 * incompatible with --fixup and have already errored out
> +		 * during option parsing.
>   		 */
> -		if (have_option_m && !strcmp(fixup_prefix, "fixup"))
> +		if (have_option_m) {
>   			strbuf_addbuf(&sb, &message);
> -
> -		if (!strcmp(fixup_prefix, "amend")) {
> -			if (have_option_m)
> -				die(_("options '%s' and '%s:%s' cannot be used together"), "-m", "--fixup", fixup_message);
> +		} else if (logfile && !strcmp(logfile, "-")) {
> +			if (isatty(0))
> +				fprintf(stderr, _("(reading log message from standard input)\n"));
> +			if (strbuf_read(&sb, 0, 0) < 0)
> +				die_errno(_("could not read log from standard input"));
> +		} else if (logfile) {
> +			if (strbuf_read_file(&sb, logfile, 0) < 0)
> +				die_errno(_("could not read log file '%s'"), logfile);

This all looks good - we add the appropriate "fixup!" style subject line 
and then add the message from the commandline or file.

The test changes below look good too.

Thanks

Phillip


> +		} else if (!strcmp(fixup_prefix, "amend")) {
>   			prepare_amend_commit(commit, &sb, &ctx);
>   		}
>   	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
> @@ -1365,9 +1366,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
>   	}
>   	if (fixup_message && squash_message)
>   		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
> -	die_for_incompatible_opt4(!!use_message, "-C",
> +	die_for_incompatible_opt3(!!use_message, "-C",
>   				  !!edit_message, "-c",
> -				  !!logfile, "-F",
>   				  !!fixup_message, "--fixup");
>   	die_for_incompatible_opt4(have_option_m, "-m",
>   				  !!edit_message, "-c",
> diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
> index 5e782ad8d7..9b2ecb1356 100755
> --- a/t/t7500-commit-template-squash-signoff.sh
> +++ b/t/t7500-commit-template-squash-signoff.sh
> @@ -384,18 +384,24 @@ test_expect_success '--fixup=reword: ignores staged changes' '
>   	test_cmp foo actual
>   '
>   
> -test_expect_success '--fixup=reword: error out with -m option' '
> +test_expect_success 'commit --fixup=reword: works with -m' '
>   	commit_for_rebase_autosquash_setup &&
> -	echo "fatal: options '\''-m'\'' and '\''--fixup:reword'\'' cannot be used together" >expect &&
> -	test_must_fail git commit --fixup=reword:HEAD~ -m "reword commit message" 2>actual &&
> -	test_cmp expect actual
> +	git commit --fixup=reword:HEAD~ -m "reword commit message" &&
> +	test_commit_message HEAD <<-EOF
> +	amend! $(git log -1 --format=%s HEAD~2)
> +
> +	reword commit message
> +	EOF
>   '
>   
> -test_expect_success '--fixup=amend: error out with -m option' '
> +test_expect_success 'commit --fixup=amend: works with -m' '
>   	commit_for_rebase_autosquash_setup &&
> -	echo "fatal: options '\''-m'\'' and '\''--fixup:amend'\'' cannot be used together" >expect &&
> -	test_must_fail git commit --fixup=amend:HEAD~ -m "amend commit message" 2>actual &&
> -	test_cmp expect actual
> +	git commit --fixup=amend:HEAD~ -m "amend commit message" &&
> +	test_commit_message HEAD <<-EOF
> +	amend! $(git log -1 --format=%s HEAD~2)
> +
> +	amend commit message
> +	EOF
>   '
>   
>   test_expect_success 'consecutive amend! commits remove amend! line from commit msg body' '
> @@ -432,6 +438,13 @@ test_expect_success 'deny to create amend! commit if its commit msg body is empt
>   	test_cmp expected actual
>   '
>   
> +test_expect_success 'deny to create amend! commit if -m is empty' '
> +	commit_for_rebase_autosquash_setup &&
> +	echo "Aborting commit due to empty commit message body." >expect &&
> +	test_must_fail git commit --fixup=amend:HEAD~ -m "" 2>actual &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success 'amend! commit allows empty commit msg body with --allow-empty-message' '
>   	commit_for_rebase_autosquash_setup &&
>   	cat >expected <<-EOF &&
> @@ -468,10 +481,26 @@ test_expect_success '--fixup=reword: give error with pathsec' '
>   	test_cmp expect actual
>   '
>   
> -test_expect_success '--fixup=reword: -F give error message' '
> -	echo "fatal: options '\''-F'\'' and '\''--fixup'\'' cannot be used together" >expect &&
> -	test_must_fail git commit --fixup=reword:HEAD~ -F msg  2>actual &&
> -	test_cmp expect actual
> +test_expect_success 'commit --fixup works with -F' '
> +	commit_for_rebase_autosquash_setup &&
> +	echo "message" >msgfile &&
> +	git commit --fixup HEAD~ -F msgfile &&
> +	test_commit_message HEAD <<-EOF
> +	fixup! $(git log -1 --format=%s HEAD~2)
> +
> +	message
> +	EOF
> +'
> +
> +test_expect_success 'commit --fixup=reword: works with -F' '
> +	commit_for_rebase_autosquash_setup &&
> +	echo "message from file" >msgfile &&
> +	git commit --fixup=reword:HEAD~ -F msgfile &&
> +	test_commit_message HEAD <<-EOF
> +	amend! $(git log -1 --format=%s HEAD~2)
> +
> +	$(cat msgfile)
> +	EOF
>   '
>   
>   test_expect_success 'commit --squash works with -F' '
> @@ -526,8 +555,7 @@ test_expect_success 'invalid message options when using --fixup' '
>   	git add foo &&
>   	test_must_fail git commit --fixup HEAD~1 --squash HEAD~2 &&
>   	test_must_fail git commit --fixup HEAD~1 -C HEAD~2 &&
> -	test_must_fail git commit --fixup HEAD~1 -c HEAD~2 &&
> -	test_must_fail git commit --fixup HEAD~1 -F log
> +	test_must_fail git commit --fixup HEAD~1 -c HEAD~2
>   '
>   
>   cat >expected-template <<EOF

