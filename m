Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC4F37F32B
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 05:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785735871; cv=none; b=dJ+IvCs8sBX2Q5mdn+HdJbHdhRqROF+MwLrN/iJUo1VRfKR5bN/ZqSXB7mWlWtxGmT/W6zU6rpcrv5diYa/kCAC5CvmfXEJ63CS7ZPH7Ad+VNj7OqGAaNP7z5aJrqMdJV8bJh4b8rtdHH4PU06ucWcomsBkoMXBtxMOTwuXqIx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785735871; c=relaxed/simple;
	bh=ZRmXortnNW5cr8izVjT5KRDmW8kwIjExaBMSII1CflU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpp/4l1DmeGdu3i+yKZK/t506xyvSS8m6vRf8ZsxV5HeTww9D0bu9J7xtXmtw/Jywih/D+iSDlQBD3YRW5Jb/W8+bJGOFwfEPU4HsQHkPwyT9ibkX1f+RIr2pYVpAK0F1vSX4UdnxFfX19Y3CVQ9p7uk2aCKDaNztGLc6skEcuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jp36JCzN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jp36JCzN"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a0ddef4e35so1056118a12.2
        for <git@vger.kernel.org>; Sun, 02 Aug 2026 22:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785735868; x=1786340668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0WGWzPT9cAtB4OqaTolm0qmZyESXG1RtjXTZELV6s5g=;
        b=Jp36JCzNyLgQ1qujpWC0RpL1mBZdM2v6uoOa8JiXzvtHzszuP86ZpesSbc+NkN0Egk
         P7wglkl7waM7SXGcM2UvIamoOy4ZQRrlMqNUrdGLMmb6dUYCEbDwYCH6dnSIon7jsMBD
         HpJdjnzTiUY185TBqhLmTMoKH3CLwP1ufWDsUtt5bjSh6FTeuyRYzgNuIp70bzGX/3L/
         24G/L3ZMjMD6Et/xdbIOXgp93eK8+OA+jri37mGohRP6ZEaF0vO4dw8nKlBQn+yKI07W
         nqF1Owgfes6Rar2kACVMJX1w1Ye0P6Qad5W07Zhecfgc3zMFqIrm/zr9T14FYqldUf86
         Nfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785735868; x=1786340668;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0WGWzPT9cAtB4OqaTolm0qmZyESXG1RtjXTZELV6s5g=;
        b=iJ2E8s4YncvwfgblPbhYjGiiDwbgVO0ejnEz7ZcWnmZkxWhffJ+8Hqlo1dGAoxKBfs
         QGxIo4VTeEiLjXNHL/hB531vYtmKftoGGn9e8fSnb6VCkAEvon3pzgmTWimGF1FfJuBv
         6eyLU3RSv7lpGf9REFvCECI4V76hywokf4a4BHRDgVJLpCsFhtCIzWOptdiWqlIiSnPb
         Or5klOq95Fy/aODTIfFPyEZ1CCCT8bZp16ba+iDYQL/vXbVTWxMmimNFMXcyt0qw5HtK
         UEBna7FLgi+51qgY1IDZT0wM2M3UPewfnKIj8nvNyewRi2GWqTuT+gP9XtBtj5UfaTmh
         hmZA==
X-Gm-Message-State: AOJu0Yw1QUNRps78lm8eNe0SdVcp0dQkn/sWbi9iKhYE3aLkuSyNgbCt
	80RIR5T8RFfs2LqHoXhILMsDVKirmdv05UATMczpWs3gSWsToEzddSf8Q09qOw==
X-Gm-Gg: AR+sD13btTanp0ky8RiYhvuzECOmCJTtzrsFIDu8/KxBgnX20VYPUeMQNsfqQ3cwRlf
	zJCCTycpSYfoiWDL5Z+I6wQjGat2UaN/HIYBzct8/cS8/0TrEC67y2Y9uGm0BpVg8O2nzO0I296
	wRFg9sT4CZLLXJnvs0cJ7CoCVTK5eZE+vKQbvmhsw/IEGA30P6KlXBRhBMeoK9lNTR97ScC0kwm
	VUsN6Y+ceG273A8fRnsnD6Kv6xlnurgtPlt5atyPxxY2rZJM2mq5D+WjqOJWMqZFemYCSX9l7KE
	tGxuUa1MxlNaDMRL4krkumjqtnuu0mejb1BGD3eO20F+7dnXZzI/S55z7D9xtFgGBTE5O59avqE
	ZKUIeShWMRSZPFlyB9BltvbEdxT+s++pfTuWS+m0W0+hEaph+sJhfTxzJB3dofYUf/kAoTXA0f/
	5LCvxMcnW6cAhdOONvfCMOGZX3+o0SjITtKotAvZQMxcyHphEkk271T95Y+mDTa64SjJvRIjMME
	JtwXYL65vS3rSpap8x+L7E3cUFXu8ww03sEdeSRWqOfLoBeMCy+dhub++BC
X-Received: by 2002:a05:6402:4024:b0:698:6084:db7f with SMTP id 4fb4d7f45d1cf-6a0a7c8840dmr7065713a12.10.1785735868070;
        Sun, 02 Aug 2026 22:44:28 -0700 (PDT)
Received: from localhost (20014C4D24D55E00353E454A10226075.dsl.pool.telekom.hu. [2001:4c4d:24d5:5e00:353e:454a:1022:6075])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c660f6fsm4881186a12.25.2026.08.02.22.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 22:44:27 -0700 (PDT)
Date: Mon, 3 Aug 2026 07:44:25 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>,
	Britton Leo Kerin <britton.kerin@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] completion: complete tracked paths for 'git diff'
Message-ID: <anAqfqcEueSKmAH+@szeder.dev>
References: <xmqqcxw010me.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcxw010me.fsf@gitster.g>

On Sun, Aug 02, 2026 at 05:58:01PM -0700, Junio C Hamano wrote:
> When completing arguments for 'git diff', _git_diff() delegates to
> __git_complete_revlist_file(), which only completes revision
> references.  This is good [*], as mixing both revs and paths in a
> single list to have the user pick is simply too confusing.
> 
> If no reference matches, or if '--' is given, however, _git_diff()
> leaves COMPREPLY empty. Bash then falls back to default filename
> completion in $PWD. This fails when 'git -C <path>' is used because
> $PWD is not the target repository.
> 
> Update _git_diff() to use __git_complete_index_file() when '--' is
> present, or when revision reference completion yields no matching
> candidates, so that tracked paths are offered as candidates.

Makes sense.

> [Footnote]
> 
>  * In https://lore.kernel.org/git/al%2Fw2qgBfhe9qMg6@szeder.dev/
>    SZEDER made the same argument for "git send-email 0<TAB>".
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * This is one of my pet peeves that I have raised a few times on
>    the list but nobody reacted.  So I did a "monkey see, monkey do"
>    patch without deeply understanding what is going on in the code
>    paths.  When preparing the CC: list, I pulled a few folks, some
>    very recognizable, some not recognizable immediately by me, out
>    of "git shortlog --since=3.years" on this file.

Will have to finally polish and submit a completion patch from my
vaults to get myself back on this list ;)

>    The contribution
>    by any of them looked more expertly done by whatever I did here.

I think your changes are fine.

However, there is 'git diff --no-index' which happily accepts
untracked files as well, but with this patch the user can complete
only those untracked files that don't match the current word on the
command line (because then __git_complete_index_file() won't list
anything, and we'll fall back to Bash filename completion like
before).

I think we should check whether the '--no-index' option is present on
the command line, and simply not call __git_complete_index_file() if
it is, to let Bash list all paths; i.e. each of those calls should be
protected by an additional 'if test -z "$(__git_find_on_cmdline
"--no-index")' condition, perhaps.

>    The use case is that I have a checkout of the 'todo' branch in an
>    untracked subdirectory 'Meta' in my primary source tree.  I would
>    do
> 
>     $ git -C Meta status wh<TAB>
> 
>    and it completes to whats-cooking.txt just fine, 'add' also adds
>    it, but 'diff' dies not work, not because I have refs that 'wh'
>    completes, but because bash completion is unaware that I want
>    paths completed in the other directory.
> 
>  contrib/completion/git-completion.bash |  8 +++++-
>  t/t9902-completion.sh                  | 40 ++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index e875787710..8f5773292b 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1947,7 +1947,10 @@ __git_diff_difftool_options="--cached --staged
>  
>  _git_diff ()
>  {
> -	__git_has_doubledash && return
> +	if __git_has_doubledash; then
> +		__git_complete_index_file
> +		return
> +	fi
>  
>  	case "$cur" in
>  	--diff-algorithm=*)
> @@ -1976,6 +1979,9 @@ _git_diff ()
>  		;;
>  	esac
>  	__git_complete_revlist_file
> +	if [ ${#COMPREPLY[@]} -eq 0 ]; then
> +		__git_complete_index_file
> +	fi
>  }
>  
>  __git_mergetools_common="diffuse diffmerge ecmerge emerge kdiff3 meld opendiff
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 55dc9eabfc..eecd53f097 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -2663,6 +2663,7 @@ test_expect_success 'setup for integration tests' '
>  	echo content >file1 &&
>  	echo more >file2 &&
>  	git add file1 file2 &&
> +	echo untracked >file3 &&
>  	git commit -m one &&
>  	git branch mybranch &&
>  	git tag mytag
> @@ -2712,6 +2713,45 @@ test_expect_success 'git -C <path> checkout uses the right repo' '
>  	EOF
>  '
>  
> +test_expect_success 'git diff completes tracked paths when no refs match' '
> +	# file1 and file2 are tracked but file3 is not
> +	test_completion "git diff f" <<-\EOF
> +	file1
> +	file2
> +	EOF
> +'
> +
> +test_expect_success 'git diff -- completes tracked paths' '
> +	# file1 and file2 are tracked but file3 is not
> +	test_completion "git diff -- f" <<-\EOF
> +	file1
> +	file2
> +	EOF
> +'
> +
> +test_expect_success 'git -C <path> diff completes tracked paths in specified repo' '
> +	test_when_finished "rm -rf repo-for-diff" &&
> +	git init repo-for-diff &&
> +	echo content >repo-for-diff/otherfile &&
> +	git -C repo-for-diff add otherfile &&
> +	echo untracked >repo-for-diff/oops &&
> +	git -C repo-for-diff commit -m otherfile &&
> +	test_completion "git -C repo-for-diff diff o" <<-\EOF
> +	otherfile
> +	EOF
> +'
> +
> +test_expect_success 'git -C <path> diff -- completes pathspecs in specified repo' '
> +	test_when_finished "rm -rf repo-for-diff" &&
> +	git init repo-for-diff &&
> +	echo content >repo-for-diff/otherfile &&
> +	git -C repo-for-diff add otherfile &&
> +	git -C repo-for-diff commit -m otherfile &&
> +	test_completion "git -C repo-for-diff diff -- o" <<-\EOF
> +	otherfile
> +	EOF
> +'
> +
>  test_expect_success 'show completes all refs' '
>  	test_completion "git show m" <<-\EOF
>  	main Z
> -- 
> 2.55.0-607-g47e9082d35
> 
