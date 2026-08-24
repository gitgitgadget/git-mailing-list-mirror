Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E03374A1E
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787565805; cv=none; b=GmArJ8DblSNZs5rF79rDH5KcWrnytEB1UNq2YkLDL3EUzuBxRrYQSaqlfwvSwqfvKWg1TDDqVvf0/m0yBrDIM3rC8DCDRZhz/aPkps3KCjXP55WVYkS+weCkxJpgHpufQ4EGM3cScbTjaDlqY9TrZmUdqw1WNAgiwGF0x5GzU3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787565805; c=relaxed/simple;
	bh=Xb2s11Yiz46UK3UvnU9ZewfxJcV22vaFwCr0G42mi2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZaCqwd5BgLs/AyzGx3MMmSzRO4g1aqiN2iOtADSzEtZmCTStBSJzGiUePK0zkj/EwqwYZstdDB5g1ufaPXnXfNJoNoO74S40S/HijuEjWxI7FMWBdhZ/SytcUlJwIAOP/OOvmedaa7Y1F2CHBECP1xHtrqLvEt4NjbIHvVZczw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+6iOnls; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+6iOnls"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-495590dde14so27180545e9.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2026 03:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787565802; x=1788170602; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5lefmcLehnU2yzWp1tDVd3wBrfiY3FmEENV5EPWTeeQ=;
        b=d+6iOnls+vYSmevDjCWZgBmY6A5ft8TdCdsj9rLMXC+LoZdDdB4hmr1S2BswmutuDp
         4g0kcrMb8hW+97adNWkDRd3y3HEChu2BdWrm23SDM/Pr9l29RAgMVadt49EQ0skFmvcV
         7y9aSNBqJC0+Bt4KmMrScuJgaeY31/uMK4pHrMQBas76lpDU+mIXx7XZxbwai9Qq1xxD
         HqdQ2eq3tN0+nsYgKw5DsddRlLNREdTfHoam3l7tkFuNXhzAzg0zHJuUiXH3NHAiGwj/
         jcjpPNOja8qR4t2z4sXSeC1Sdbs55HcpBgQPW+wVE/3jkW/IXHHzPfqf7nIWhqutx+ah
         pGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787565802; x=1788170602;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5lefmcLehnU2yzWp1tDVd3wBrfiY3FmEENV5EPWTeeQ=;
        b=iXK4A/OPdRo+aGurnUCN/QJjF8jI3Sl49+uMHOcVzTEI/SVHBPRORBn0lcURF2OfNf
         MBSjj+NIKaV1z2tpf5Bpx9iH56qn2IGWaJVaF1Gpv/1DyNdK9SPezTZ2rtmm3+S4h0NZ
         vXzM0BO+Ygr0MiS74URk3lY+ZSVRgR7DGSbWm2aoJWUcjmmeXOmlGC+Nk4jzr130Xh11
         oFTQEyb1313CfRqm2HkTbuCuom5LUdz+GLqc4wTuEk9GxT33FKEwz+vg1DqnsIJikZUS
         K5Vg7vui8/yJ86l4Q90G5tBzBQRsaqJRcr3INOYx/qVzlV+gMsk+cPdptWf+6M1CHVHt
         LivA==
X-Forwarded-Encrypted: i=1; AHgh+Rp+luH5ymSjtCafzP0rGXEGPCGWJmpdC32HCdrchzIXqYGi2IZKoYHRH3HneF7nLGergkg=@vger.kernel.org
X-Gm-Message-State: AFuF++lrGCXdgrktdsCNOi52rS8r2bDgo218zVjn2M6clrHXQv9ICQKD
	lGawHw2ntDphlx3UKqDBCCaRoxtB/BXszfw1ucO14FVGvb8h6ZLXY4OU
X-Gm-Gg: AR+sD10J9C2cUGW98q9c0R/EhXL0dv8ZSRjHV5sk1QDw0nO4Lj4sJhCEbobua6S6xoq
	tu1FAdFhC8us88Ust0qlbBJmyP99uKv//FClIPfbua79zBdOpNV5oejW0Q75X/YTYn9jX2wNo1c
	C430tZk/zXmWXrSuQt8p59q7dRu9a0KSTQQ4RqZhXpR9nDk9u54ptxTEXgIioF+ivSgnj9bKUlY
	A5AELnYt72neLGb98N3ybQB9RqVG03I6fnPfR+V2ZfEye7WhRNSywBD00DNTmZr+OZ8FrAQfb/l
	ZMTOXNZDpPXjzRqEBH3bWf/d4ks0ZyZLgbTYVyVrUZCq5RTiyVsGpdUfbR/zJ4WFHEGdGalNBzp
	9SpRhgRDlZ2WJKfivkVXsnGhCUoIX1tIdO92sOzWtIt8VVvKm3FtTLJqW8Qjs160Qgpbv/Hp1aS
	rBWJhx8CkZdJwo3NFEpd6mux6MAuZbTyAYy6+XgXhmdw1oMJP30PPifO7AqXdFS14C78vQW2A5h
	AScohLd7w0aOM1nGZ/HAOlJXW89x1WuaRISrtGqM2s=
X-Received: by 2002:a05:600c:c494:b0:499:a5c8:c6f3 with SMTP id 5b1f17b1804b1-499b82f4d3bmr274721875e9.3.1787565801328;
        Mon, 24 Aug 2026 03:03:21 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499c3566e1dsm77693315e9.7.2026.08.24.03.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 03:03:20 -0700 (PDT)
Message-ID: <a786e6c0-1c17-4121-8623-b4541478a88f@gmail.com>
Date: Mon, 24 Aug 2026 11:03:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] sequencer: release the ODB before spawning git commit
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2198.git.1786388689444.gitgitgadget@gmail.com>
 <pull.2198.v2.git.1786528498689.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2198.v2.git.1786528498689.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes

On 12/08/2026 10:54, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> As of 4557f1add261 (rebase--helper: add a builtin helper for interactive
> rebases, 2017-02-09), continuing an interactive rebase uses the builtin
> sequencer, which spawns `git commit`.
> 
> The child may trigger auto-maintenance, which may need to replace files
> for which the sequencer still holds resources. See
> https://github.com/git-for-windows/git/issues/6315: on Windows, this
> produces unlink retry prompts that cannot succeed while the sequencer
> waits for the child.
> 
> Resources such as file handles or memory mappings must be released
> before spawning a command that may run auto-maintenance, as established
> by 28d04e1ec197 (run-command: offer to close the object store before
> running, 2021-09-09): release the ODB file handles and memory mappings,
> so that auto-gc can repack (potentially deleting existing packfiles in
> the process); If the sequencer needs to access the ODB afterwards, it
> will gracefully (re-)open the ODB.
> 
> Release the sequencer's ODB before spawning `git commit`. The regression
> test uses the legacy-delete trick introduced by 69ed0e35a754 (mingw:
> optionally use legacy (non-POSIX) delete semantics, 2026-05-07) to
> trigger the failure on modern Windows.

This looks fine as an immediate fix for the bug but I wonder if we 
should pass "-c gc.auto=false" when we fork "git commit" from the 
sequencer. We call run_auto_maintenance() at the end of the rebase and 
its not clear to me that repacking during the rebase is helpful. Another 
thought I had was whether we should automatically close the object 
database when forking another git command. I'm not sure how easy that is 
to implement but it would prevent future regressions and I assuming 
re-opening the object store is cheap compared to forking another git 
command.

Thanks

Phillip


> Assisted-by: GPT-5.6 Sol
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>      sequencer: release the ODB before spawning git commit
>      
>      This fixes https://github.com/git-for-windows/git/issues/6315
>      
>      Changes since v1:
>      
>       * Clarify in the commit message what the strategy introduced in
>         28d04e1ec197 (run-command: offer to close the object store before
>         running, 2021-09-09) is all about.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2198%2Fgit-for-windows%2Frebase-release-odb-before-commit-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2198/git-for-windows/rebase-release-odb-before-commit-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/2198
> 
> Range-diff vs v1:
> 
>   1:  904d65e8cb ! 1:  039fd29039 sequencer: release the ODB before spawning git commit
>       @@ Commit message
>            Resources such as file handles or memory mappings must be released
>            before spawning a command that may run auto-maintenance, as established
>            by 28d04e1ec197 (run-command: offer to close the object store before
>       -    running, 2021-09-09).
>       +    running, 2021-09-09): release the ODB file handles and memory mappings,
>       +    so that auto-gc can repack (potentially deleting existing packfiles in
>       +    the process); If the sequencer needs to access the ODB afterwards, it
>       +    will gracefully (re-)open the ODB.
>        
>            Release the sequencer's ODB before spawning `git commit`. The regression
>            test uses the legacy-delete trick introduced by 69ed0e35a754 (mingw:
> 
> 
>   sequencer.c                   |  1 +
>   t/t3404-rebase-interactive.sh | 18 ++++++++++++++++++
>   2 files changed, 19 insertions(+)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 57855b0066..83952d96e3 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1127,6 +1127,7 @@ static int run_git_commit(const char *defmsg,
>   	struct child_process cmd = CHILD_PROCESS_INIT;
>   
>   	cmd.git_cmd = 1;
> +	cmd.odb_to_close = the_repository->objects;
>   
>   	if (is_rebase_i(opts) &&
>   	    ((opts->committer_date_is_author_date && !opts->ignore_date) ||
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 58b3bb0c27..8f81c80fd4 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -65,6 +65,24 @@ test_expect_success 'setup' '
>   	test_commit P fileP
>   '
>   
> +test_expect_success MINGW 'rebase releases object database before committing' '
> +	test_when_finished "rm -f .git/hooks/post-commit repacked packs" &&
> +	git switch -C repack-rewrite primary &&
> +	git repack -ad &&
> +	write_script .git/hooks/post-commit <<-\EOF &&
> +	git repack -ad &&
> +	>repacked
> +	EOF
> +	(
> +		set_fake_editor &&
> +		FAKE_LINES="reword 1" GIT_TEST_LEGACY_DELETE=1 \
> +			git -c core.commitGraph=false rebase -i HEAD^
> +	) &&
> +	test_path_is_file repacked &&
> +	ls .git/objects/pack/*.pack >packs &&
> +	test_line_count = 1 packs
> +'
> +
>   # "exec" commands are run with the user shell by default, but this may
>   # be non-POSIX. For example, if SHELL=zsh then ">file" doesn't work
>   # to create a file. Unsetting SHELL avoids such non-portable behavior
> 
> base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc

