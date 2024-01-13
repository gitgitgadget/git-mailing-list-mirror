Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF181370
	for <git@vger.kernel.org>; Sat, 13 Jan 2024 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKSUiuI5"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e490c2115so37026995e9.0
        for <git@vger.kernel.org>; Sat, 13 Jan 2024 13:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705180036; x=1705784836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SDhHyPYTAs83X3NFrqoOGPV2QRBdSOb7uQfi6olftFY=;
        b=QKSUiuI58nkS9d/EujQRzTjOYBv6ufX9LiegIM20TWU6i61nUnjjxuahT8WGFya3wG
         kOA95p/1We7Ktt6PUQ/LEnEFCmPp/ZcSXNiWbpsuVODghrBniIyLkHY/QTkTTPQIrl2y
         ew1Ja1s+vM38XhExJ1fRB7rdIq5jIK+pbYgBTInsRP66SsqLcJ46bPZnqAdi7/3l0pru
         2qRxjakdUwXwrqNOsz8QpwqnShj5VDNpUKEb/BdNlcOTYAXywEIo5DyWLQZpqKAQ6lxR
         RaMS9FXk34LcrFW+io6ucC4PybGfV0zpjj3/wJsFu4lmDlWcARk/xtEkNhYyTb9qC58d
         Ch5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705180036; x=1705784836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDhHyPYTAs83X3NFrqoOGPV2QRBdSOb7uQfi6olftFY=;
        b=Gp0Fhs3EtAdt8/pR3qwh5CN9VfNqAVetEuzOZARh7CLb5RRG2xpGTtgb8EqQfDMPQs
         1g6S5myZp2eG0PVzZMhZ+EKwuBfXMZpaY2CEsC0Az71gOCfml+e2vlZzO3eOHrgEtqVv
         mgwhVG7PXVYHDbmVc40Cmp5KcDazXTIGAVPijqRztgJ52LqrB6PO6SVOqOBITsHSYk2p
         /G5fKPjXeLBmd4HxznZe4vcxHEeU6Y8cqd/7swFKLyyY83s6SCzmNogINUC1FKbHcK1H
         P70+jkxSPf66dwQlFOJlSUE72ZnfVQsiEvfWanas93vo2V8PlfdECBLwet49he+n1PSW
         rDEQ==
X-Gm-Message-State: AOJu0YxS9F496fTTQii3RJVcmWzDclYXonIpYozTQiRN4X+EynXd7j79
	KHmk4yEfVyLpl/BYKCxBsH8=
X-Google-Smtp-Source: AGHT+IEVvwk/Ec6NSjCorAkKh5w2FPJgcVIWZo0TnsfP/vx4D6ZEhx2v25lB3pJplH34osH6IZs7PQ==
X-Received: by 2002:a05:600c:4fce:b0:40e:43ba:cf3f with SMTP id o14-20020a05600c4fce00b0040e43bacf3fmr2178022wmq.1.1705180035494;
        Sat, 13 Jan 2024 13:07:15 -0800 (PST)
Received: from localhost (84-236-78-166.pool.digikabel.hu. [84.236.78.166])
        by smtp.gmail.com with ESMTPSA id o14-20020adfe80e000000b0033674734a58sm7590255wrm.79.2024.01.13.13.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 13:07:15 -0800 (PST)
Date: Sat, 13 Jan 2024 22:07:14 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Stan Hu <stanhu@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 1/2] completion: refactor existence checks for
 pseudorefs
Message-ID: <20240113210714.GC3000857@szeder.dev>
References: <cover.1703022850.git.stanhu@gmail.com>
 <29c928649aba7dfce4dab1b5d923bc23b7af2d32.1703022850.git.stanhu@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <29c928649aba7dfce4dab1b5d923bc23b7af2d32.1703022850.git.stanhu@gmail.com>

On Tue, Dec 19, 2023 at 02:14:17PM -0800, Stan Hu wrote:
> In preparation for the reftable backend, this commit introduces a
> '__git_pseudoref_exists' function that continues to use 'test -f' to
> determine whether a given pseudoref exists in the local filesystem.
> 
> Signed-off-by: Stan Hu <stanhu@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 13a39ebd2e..8edd002eed 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -122,6 +122,15 @@ __git ()
>  		${__git_dir:+--git-dir="$__git_dir"} "$@" 2>/dev/null
>  }
>  
> +# Runs git in $__git_repo_path to determine whether a pseudoref exists.
> +# 1: The pseudo-ref to search
> +__git_pseudoref_exists ()
> +{
> +	local ref=$1
> +
> +	[ -f "$__git_repo_path/$ref" ]

This new helper function relies on $__git_repo_path being set, but it
doesn't ensure that it's actually set by calling __git_find_repo_path.
Instead, it relies on its callers calling __git_find_repo_path,
although after this patch none of those callers directly access
$__git_repo_path anymore.

It would be better to call __git_find_repo_path in this helper to make
it more self-contained, and then the now unnecessary
__git_find_repo_path calls from the three callers can be removed.

Yeah, I know it's late, because this patch is already in master, but
this would be a good preparation step for eventual dedicated tests of
__git_pseudoref_exists that came up in:

  https://public-inbox.org/git/20240113191749.GB3000857@szeder.dev/

> +}
> +
>  # Removes backslash escaping, single quotes and double quotes from a word,
>  # stores the result in the variable $dequoted_word.
>  # 1: The word to dequote.
> @@ -1625,7 +1634,7 @@ __git_cherry_pick_inprogress_options=$__git_sequencer_inprogress_options
>  _git_cherry_pick ()
>  {
>  	__git_find_repo_path
> -	if [ -f "$__git_repo_path"/CHERRY_PICK_HEAD ]; then
> +	if __git_pseudoref_exists CHERRY_PICK_HEAD; then
>  		__gitcomp "$__git_cherry_pick_inprogress_options"
>  		return
>  	fi
> @@ -2067,7 +2076,7 @@ _git_log ()
>  	__git_find_repo_path
>  
>  	local merge=""
> -	if [ -f "$__git_repo_path/MERGE_HEAD" ]; then
> +	if __git_pseudoref_exists MERGE_HEAD; then
>  		merge="--merge"
>  	fi
>  	case "$prev,$cur" in
> @@ -2934,6 +2943,7 @@ _git_reset ()
>  
>  _git_restore ()
>  {
> +	__git_find_repo_path
>  	case "$prev" in
>  	-s)
>  		__git_complete_refs
> @@ -2952,7 +2962,7 @@ _git_restore ()
>  		__gitcomp_builtin restore
>  		;;
>  	*)
> -		if __git rev-parse --verify --quiet HEAD >/dev/null; then
> +		if __git_pseudoref_exists HEAD; then
>  			__git_complete_index_file "--modified"
>  		fi
>  	esac
> @@ -2963,7 +2973,7 @@ __git_revert_inprogress_options=$__git_sequencer_inprogress_options
>  _git_revert ()
>  {
>  	__git_find_repo_path
> -	if [ -f "$__git_repo_path"/REVERT_HEAD ]; then
> +	if __git_pseudoref_exists REVERT_HEAD; then
>  		__gitcomp "$__git_revert_inprogress_options"
>  		return
>  	fi
> @@ -3592,7 +3602,7 @@ __gitk_main ()
>  	__git_find_repo_path
>  
>  	local merge=""
> -	if [ -f "$__git_repo_path/MERGE_HEAD" ]; then
> +	if __git_pseudoref_exists MERGE_HEAD; then
>  		merge="--merge"
>  	fi
>  	case "$cur" in
> -- 
> 2.42.0
> 
> 
