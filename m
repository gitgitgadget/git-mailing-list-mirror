Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA841C27
	for <git@vger.kernel.org>; Mon,  1 Sep 2025 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734857; cv=none; b=ZskFGHZv4ce3H7NIfOe1ZI8Z6olp1ZaWVSmrrnCT9amE9Yyz2F2J/968VU/KcJSWCqO77zQ5LvEO9uj+QCjdbkhzuczQ+1nKPFa6tmEP7YK+D0FSQ6bGJ8FgKYtynv83eUCCm/WpBBUsykyVP1yZ2E/4l9GFZvM4KMoYrMt6yxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734857; c=relaxed/simple;
	bh=OgNI+NSINR+IULuosJ93xtUxzFcR2zGZlh2XuFy4vKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjhhD/p2VLLV55L1aPZztv6ogDKTGCeeY9hjHnWAI+gjykmj1GK4glKaDSne2uClASb1KO215WFGOiMoCvaKg4AmEE+J8AvJABL6fb3QzqAB9Drg/JQulAsYrHXLpIPL7cqGrkANVVMvThO4m7zCLMy6xnWZgBtGf8jR9/OWQoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UL8WJ7sK; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UL8WJ7sK"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3d1bf79d758so1818934f8f.1
        for <git@vger.kernel.org>; Mon, 01 Sep 2025 06:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756734854; x=1757339654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WT4SGhMuxc4rs7/MBPkKk/+VNMYmgOeej4VhfLj9qQU=;
        b=UL8WJ7sKS1Pes7noTTRXEoPgCPxkWQvgTk9QEZvsgXW0Znq+9KLXTAWaMJPDddX6YF
         RPHqkzpSeRneZr1rbi+hU3Q5f6FyjEMitcN9uLS+XWoqwpjMprRhEAn8ibjuCWTXiydi
         n2Hrpsdj1sjoR5bfHILK3Qx3k8IDUy1gf/yqIktXm5RvbbJSKUsvzfY1q7EmXllmbCRU
         XTuk/kq1LIE/InPD28+09dT09XCTgpq3LmjKj4quqGdLoFiH5wE21AO2Eps9NkZnoU/b
         RLZLPT1toD1KloYQ4WgkCZA0akGzQRMi7UmqRrHiXOtdVSaKHrbtp86TClLQTR+2OvPK
         9EGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756734854; x=1757339654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WT4SGhMuxc4rs7/MBPkKk/+VNMYmgOeej4VhfLj9qQU=;
        b=K6T3V2WgchtcDB3G7rOSREi+IALwK5UaGOZcLcZANluvwTPqJDKbgCz5NET+ipv4M4
         Q5ERCxJUSCR+39nYn/2OSDB2qTS3nuc97G/bNenTnuLgVGa9AOvEGZQQbMoCO4XV3wZS
         RFDsnfBvk7Z/iDum1P5TXcMAiFkrwRwuqf3zMw9Cu29DVmO7/eUp1lOFfIYKjEKAZp09
         GWn+u80mwCz3JJcT7O3KbK3S0Mz17qBVjWT5so9f7bcxqv0/OiL93Y2zIdUkrbQd/Bit
         EazBOPpZx5x1bZEuOxb5xMgwgCrGMZvVHmPH24StVyv2I/HHT49G2XbQb3b6jyIku8iB
         ojmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6Umtqd6fZ+p1yJSTwy5cMkbePVCJMu3zcXGMXjlypo6eMsnzoZEVvift201cHICr0YvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz55DAumdglk0velhQfpjYEu2SJ7rrBgJuVY4rJE5hbdX0nBdbT
	rDXqZGBmkIFJPLbzFN3+O0z4+WuYVKD/b7nmbZPh7WMdVfjIxzmAW+0P
X-Gm-Gg: ASbGncuISoA1Gr1vHuCUAa6uExiO4DZUfTT+JkLNNHjmAH58LjE7UBoNtH+pRR/XN4u
	TVNJ1bgQE12FdRsCNhoM4iSo87Gi7AjrV7hJdepqbmnIXr2/maFlEZN3tP6E52/auwUW/BDITpO
	4Rkwd0tQRrbnHl41u1eW6tw7k32pjMpz4h+e86bcSSxy+jnKFa+d/aqKZ2Xo8uvW1niS5V1WAq1
	NckxPIfQK2WLbwWhPwvb01DUuoPjthCnFXOTv0ANaMczflDpc/5t3IIVmpBRTnaF0wXRVhbSCAO
	J/MIUyjc8rofwNQ3ogOiFuFioYRpUlxzs1kkQe18cS9b4rs0vQbEJfIf9zq/iaNXcbf+NZUnx/p
	BMTS1g/5l5ZQbGiy+5DJKCaA78oIV4yyX2acg2fs5Z2eniq/7vroyPwECQjjQZ1QCp9HnHJP0Sr
	f8Cg==
X-Google-Smtp-Source: AGHT+IFc0CNqJ6qOFPjYd6x67c1HXFgamPsK4+KLl2AjjyKWE11joCTgut50ZwNBB3r+tDRlOT03Zw==
X-Received: by 2002:a05:6000:2501:b0:3cc:b206:bca2 with SMTP id ffacd0b85a97d-3d1dfcfb99dmr6673385f8f.33.1756734853921;
        Mon, 01 Sep 2025 06:54:13 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fb9db4sm15550028f8f.47.2025.09.01.06.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 06:54:13 -0700 (PDT)
Message-ID: <00e76b7e-ce4f-44d9-acd9-466c6b14f41b@gmail.com>
Date: Mon, 1 Sep 2025 14:54:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] contrib/subtree: fix split with squashed subtrees
To: Colin Stagner <ask+git@howdoi.land>, git@vger.kernel.org
Cc: Zach FettersMoore <zach.fetters@apollographql.com>,
 Christian Couder <chriscool@tuxfamily.org>,
 Patrik Weiskircher <patrik@pspdfkit.com>
References: <20250824191048.1938340-1-ask+git@howdoi.land>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250824191048.1938340-1-ask+git@howdoi.land>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Colin

On 24/08/2025 20:10, Colin Stagner wrote:
> 98ba49ccc2 (subtree: fix split processing with multiple subtrees
> present, 2023-12-01) increases the performance of
> 
>      git subtree split --prefix=subA
> 
> by ignoring subtree merges which are outside of `subA/`. It also
> introduces a regression. Subtree merges that should be retained
> are incorrectly ignored if they:
> 
> 1. are nested under `subA/`; and
> 2. are merged with `--squash`.
> 
> For example, a subtree merged like:
> 
>      git subtree merge --squash --prefix=subA/subB "$rev"
>      #                 ^^^^^^^^          ^^^^
> 
> is erroneously ignored during a split of `subA`. This causes
> missing tree files and different commit hashes starting in
> git v2.44.0-rc0.
> 
> The method:
> 
>      should_ignore_subtree_split_commit REV
> 
> should test only if REV is a subtree commit, but the combination of
> 
>      git log -1 --grep=...
> 
> actually searches all *parent* commits until a `--grep` match is
> discovered. Limit these checks to the current REV only.

Thanks for the clear explanation of the problem and the proposed solution.

> Tests now cover nested subtrees.

Great
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 3fddba797c..139049351d 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -788,17 +788,17 @@ ensure_valid_ref_format () {
>   # Usage: check if a commit from another subtree should be
>   # ignored from processing for splits
>   should_ignore_subtree_split_commit () {
>   	assert test $# = 1
>   	local rev="$1"
> -	if test -n "$(git log -1 --grep="git-subtree-dir:" $rev)"
> +	if test -n "$(git log -1 --grep="git-subtree-dir:" "$rev^!")"

This makes sense as we only want to grep the current commit. We could 
drop the "-1" as we're only considering a single commit.

>   	then
> -		if test -z "$(git log -1 --grep="git-subtree-mainline:" $rev)" &&
> -			test -z "$(git log -1 --grep="git-subtree-dir: $arg_prefix$" $rev)"
> +		if test -z "$(git log -1 --grep="git-subtree-mainline:" "$rev^!")" &&
> +			test -z "$(git log -1 --grep="git-subtree-dir: $arg_prefix$" "$rev^!")"

I'm less sure about this change. Is the second test checking making sure 
we don't prune this commit if it has an ancestor that is a subtree merge 
for the subtree we're interested in? It would be very helpful if Zach 
could comment on what was intended here.

If it turns out that all three tests only want to consider a single 
commit then it would be be more efficient to run a single git command 
and check the output with something like

	git show -s 
--format='%(trailers:key=git-subtree-dir,key=git-subtree-mainline' $rev 
| while read trailer
		do
			# check trailers here using case "$trailer"
		done

Thanks

Phillip

>   		then
>   			return 0
>   		fi
>   	fi
>   	return 1
>   }
>   
>   # Usage: process_split_commit REV PARENTS
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> index 3edbb33af4..1ddc213621 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -68,6 +68,34 @@ test_create_pre2_32_repo () {
>   	git -C "$1-clone" replace HEAD^2 $new_commit
>   }
>   
> +# test_create_subtree_add REPO ORPHAN PREFIX FILENAME ...
> +#
> +# Create a simple subtree on a new branch named ORPHAN in REPO.
> +# The subtree is then merged into the current branch of REPO,
> +# under PREFIX. The generated subtree has has one commit
> +# with subject and tag FILENAME with a single file "FILENAME.t"
> +#
> +# When this method returns:
> +# - the current branch of REPO will have file PREFIX/FILENAME.t
> +# - REPO will have a branch named ORPHAN with subtree history
> +#
> +# additional arguments are forwarded to "subtree add"
> +test_create_subtree_add () {
> +	(
> +		cd "$1" &&
> +		orphan="$2" &&
> +		prefix="$3" &&
> +		filename="$4" &&
> +		shift 4 &&
> +		last="$(git branch --show-current)" &&
> +		git checkout --orphan "$orphan" &&
> +		git rm -rf . &&
> +		test_commit "$filename" &&
> +		git checkout "$last" &&
> +		git subtree add --prefix="$prefix" "$@" "$orphan"
> +	)
> +}
> +
>   test_expect_success 'shows short help text for -h' '
>   	test_expect_code 129 git subtree -h >out 2>err &&
>   	test_must_be_empty err &&
> @@ -426,6 +454,48 @@ test_expect_success 'split with multiple subtrees' '
>   		--squash --rejoin -d -m "Sub B Split 1" 2>&1 | grep -w "\[1\]")" = ""
>   '
>   
> +# When subtree split-ing a directory that has other subtree
> +# *merges* underneath it, the split must include those subtrees.
> +# This test creates a nested subtree, `subA/subB`, and tests
> +# that the tree is correct after a subtree split of `subA/`.
> +# The test covers:
> +# - An initial `subtree add`; and
> +# - A follow-up `subtree merge`
> +# both with and without `--squashed`.
> +for is_squashed in '' 'y';
> +do
> +	test_expect_success "split keeps nested ${is_squashed:+--squash }subtrees that are part of the split" '
> +		subtree_test_create_repo "$test_count" &&
> +		(
> +			cd "$test_count" &&
> +			mkdir subA &&
> +			test_commit subA/file1 &&
> +			git branch -m main &&
> +			test_create_subtree_add \
> +				. mksubtree subA/subB file2 ${is_squashed:+--squash} &&
> +			test -e subA/file1.t &&
> +			test -e subA/subB/file2.t &&
> +			git subtree split --prefix=subA --branch=bsplit &&
> +			git checkout bsplit &&
> +			test -e file1.t &&
> +			test -e subB/file2.t &&
> +			git checkout mksubtree &&
> +			git branch -D bsplit &&
> +			test_commit file3 &&
> +			git checkout main &&
> +			git subtree merge \
> +				${is_squashed:+--squash} \
> +				--prefix=subA/subB mksubtree &&
> +			test -e subA/subB/file3.t &&
> +			git subtree split --prefix=subA --branch=bsplit &&
> +			git checkout bsplit &&
> +			test -e file1.t &&
> +			test -e subB/file2.t &&
> +			test -e subB/file3.t
> +		)
> +	'
> +done
> +
>   test_expect_success 'split sub dir/ with --rejoin from scratch' '
>   	subtree_test_create_repo "$test_count" &&
>   	test_create_commit "$test_count" main1 &&
> 
> base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0

