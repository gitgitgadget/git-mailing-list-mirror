Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595453;
	b=fvs0Ojf2c5LmHNMPE3ZLYXgDoDk6YaXIChU/Ff8lNEc3HAfXc68Fo54v4d3Q2e6pwh5/
	 byQhxy4MUGuiFVqGIcL6zsCA8herfdOWQOYZEjahkXZsjHhu1LmCHp6+qNLLHok8UioKh
	 NXMvEYCyVIXVV165CguElNpMZA2zLMdgfpMPcjqTcazcdhzDXfwRYSOfL+AKQ/DY7V1gm
	 O/S1MlYhViUgf1hJ/hpxwDSjt0zOYL5XpkaMxfNIHg1u9VWRFipbg7FCZz0dt1Jw43npB
	 87lLpZOjTRkvznBr3UfjggePINvYrRhoJGNCSBtQXzmI8C0r9yUsjYfsyqReuK26msQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=EmYCOxBd/8JatntUy0A1uG6cIed23gNMNTSKp77WnqM=;
	b=noAI4F3jwe2rn6k7R++L4j8/2bjHO4lFvauPhynB6wXJBonmA8EKjV4BIzcgYotdvTSY
	 xrsSCwxbgNOryfTN7bjQCeSgY2ZKoW82zEbaiuk7vz75z1wf09krOdixu6NO56kSHMBF/
	 5O+5MnAC9Ua7/Km0NOea2MOQMUP8iKFAa7CTyORm5C6GCksHijrSNOSYXsvs42Y7+vhbp
	 f3Be527h3aI1gGSKIlCNl3eRJHZ6nWDNVGzqOnvatgaUb5N4W+2eNbxbMCNq/pSNoV7Qn
	 sOSK5TBUPx7I7v99nvJ9A7hjit3iEwgJJXoXzJTucGOw82Gz26D4WPp+KPWo3H6wjSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=St1VcIs5;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4717606A31D
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 15:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4717606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=St1VcIs5
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1e2957d7eso8640745e9.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 08:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792595451; x=1793200251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EmYCOxBd/8JatntUy0A1uG6cIed23gNMNTSKp77WnqM=;
        b=St1VcIs5dyR56QgrtX60Lfdh3JrYx4f6bzayMRMPeVOE4qIjCX7tZP3q0aEcCIRB26
         9no/UOWoSP+0tsV6U6LEmgUt7Bff7WPqrddhMea0YeESgOpp8PVF2zQDpLEHI4bToPLB
         2hPjaAaIZvnu0d6RImAm4vb0tpQAxvffhEEEvHdR27D4TIrgxFuMMB0mvY/+9AnubY9w
         U0oD9exs5XSerN6O0ywlFnjg43z7CW3EiUz6q2ktn6YL9BaIR7ZGRsvrEDrsyiIbRdwh
         huR2+406+dA4DMiav7GUHeTTVm7a6E2nAM7DV520LIQikeKMooGnpd+LBMB1B+uIWU23
         fQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792595451; x=1793200251;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EmYCOxBd/8JatntUy0A1uG6cIed23gNMNTSKp77WnqM=;
        b=ECASgvWqhGDdLphRwXOLCOsCm1/SbdxOuYpPk3hpNqXdeDwDyUqxk/RgNfE4cNsOMa
         BqpoaraLRRNSC25uyESNlmb7tCucUP+2liDf75/+GIOmOsZnJ+jdlOA6ef/VpuvDbDdr
         W+ppG3hYe7bQh0JnNGVfdOHrrSLTdtn31vgd6ZQPEtiGOgkjJwdcTMgrJAL0Gnofm4+7
         AOCfqni2WhcF+VhcQVDUthCkNylKzyQUG28wlnODTECHiXQQy3Wkcj16FG5X/2MHjXMk
         nRTUfxPEAHx2yOVnmeRgX9UWCF6lezkKepDAxW/WTMWXAzg1TdeaNTghzUrp4P6sjjwz
         z5ZA==
X-Forwarded-Encrypted: i=1; AKwUvBxYUA4ry3y1cAUseCfO4g2MzuanNGAE5Wo9iKJPfaY6pKJyZ3lcsJkVkN/4fb77hBt+w6U=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzTnIxUG010oRrfwYdGyHwKXeZD2aJWt7kiG+1ttOqY/JAscDr
	TSdBH+CHQahbjpUeSak+Ablw4mP8w3pN3Pw0oFuoeWC1Wk+o4wpojUw1
X-Gm-Gg: AYBFou1WplTQFb9BL1J26i73MgWD2VAM/98bsHgrAUbZYMedjXatBbvkwAzvQvO0nr2
	mOs4hkdl7SziGVj1uukqVGthXWMU5G3Yj8Gz/t41S0VjSgqykeBRz1TUWztzc3SUoRgigNXMCBr
	fLoc5ycjJJ6Jiy7kCfVbM8094AhuwAoU48ktf8mOVtlW45C+LSYoBMuCpybdFjZcD/y6vpE1pCB
	S8R8en2Y5sMB/zEXtwQcsD0DTF5zGg93YPIYpvNLYVfyKUfxjig0BMl+3HVchaUl+JuR7mFGz2o
	6met3mbiyYBV4B9yGuuwXOqJGQTv+XXgKko5atE+n4Zh8K0dR1SIU773unbwhjqQur6wxXlU9p7
	bYRqrm8eDEQ30SH3/CvfXSFaHQ3NoQ9xBDa0xCrVSMnjHMhrU6MV2OJvRqzEq7YKLaKfFre60TQ
	kJDPaaro7PXc5iPWN7ezJndKXKySsSibqRrDkzJUUmVB5BGwHymetsjuNA+NoQ8+JqX/0tb1Nb7
	xnqJpLWMgsF7n8q3GSf/sto+AO46DgUfsNTqSg9/3z58Sc2yf7ePW1ef9L3XPUvqirbRFinVblb
	V9nCxkS81d3GsSd8RDuOPr0mf7JEwuEUJA==
X-Received: by 2002:a05:600d:82c1:b0:4a1:f91a:732e with SMTP id 5b1f17b1804b1-4a1fdb0606dmr54762105e9.12.1792595450768;
        Wed, 21 Oct 2026 08:10:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd25edasm49988125e9.3.2026.10.21.08.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 08:10:50 -0700 (PDT)
Message-ID: <de12af28-a64e-4472-8bd4-b65200772dbe@gmail.com>
Date: Wed, 21 Oct 2026 16:10:49 +0100
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
Subject: Re: [PATCH v3 2/2] commit: allow -c/-C for all kinds of --fixup
To: erik@cervined.in, git@vger.kernel.org
Cc: gitster@pobox.com
References: <cover.1779792311.git.erik@cervined.in>
 <cover.1790082176.git.erik@cervined.in>
 <39e408e14718f533edc6ed2de6ff41ed961c6e05.1790082176.git.erik@cervined.in>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <39e408e14718f533edc6ed2de6ff41ed961c6e05.1790082176.git.erik@cervined.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Erik

On 22/09/2026 14:04, erik@cervined.in wrote:
> From: Erik Cervin-Edin <erik@cervined.in>
> 
> The fixup code path in prepare_to_commit() only knows how to take a
> message body from -m or -F.  Now that the previous commit allows -m and
> -F for all --fixup variations, -c/-C are the odd ones out.
> 
> Teach the fixup path to look up the ref given to -c/-C and seed its
> message when preparing to amend the commit, mirroring what --fixup=amend
> does when no message source is given.  With this in place, -m/-F/-c/-C
> all behave consistently across the plain, amend, and reword --fixup
> forms.
> 
> The incompatibility check grouping -C, -c, and --fixup can go away
> entirely, as -C and -c are already rejected together by the check that
> groups them with -m and -F.

I'm less convinced about there being much use for combining "--fixup" 
with "-C" but I don't see any reason to prevent it.

> @@ -863,6 +863,11 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>   		} else if (logfile) {
>   			if (strbuf_read_file(&sb, logfile, 0) < 0)
>   				die_errno(_("could not read log file '%s'"), logfile);
> +		} else if (use_message) {

by the time we get here we've copied edit_message into use_message if 
"-c" was given so this covers "-C" and "-c".

> +			struct commit *c = lookup_commit_reference_by_name(use_message);
> +			if (!c)
> +				die(_("could not lookup commit '%s'"), use_message);
> +			prepare_amend_commit(c, &sb, &ctx);

> diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
> index 9b2ecb1356..de3221ea52 100755
> --- a/t/t7500-commit-template-squash-signoff.sh
> +++ b/t/t7500-commit-template-squash-signoff.sh
> @@ -492,6 +492,62 @@ test_expect_success 'commit --fixup works with -F' '
>   	EOF
>   '
>   
> +test_expect_success 'commit --fixup works with -C' '
> +	commit_for_rebase_autosquash_setup &&
> +	git commit --fixup HEAD~ -C HEAD &&

It would be nice to see

	GIT_EDITOR=false git commit --fixup HEAD~ -C HEAD

so that we check the editor is not invoked.

> +	test_commit_message HEAD <<-EOF
> +	fixup! $(git log -1 --format=%s HEAD~2)
> +
> +	$(get_commit_msg HEAD~)
> +	EOF
> +'
> +
> +test_expect_success 'commit --fixup=amend: works with -c' '
> +	commit_for_rebase_autosquash_setup &&
> +	test_set_editor : &&

Most of the tests in this file correctly use a subshell when setting the 
editor so that they do not affect subsequent tests. It would be nice to 
check that the editor actually ran.

	GIT_EDITOR="echo edited >>" git commit ---fixup=amend:HEAD -c HEAD~ &&

Thanks

Phillip

> +	git commit --fixup=amend:HEAD -c HEAD~ &&
> +	test_commit_message HEAD <<-EOF
> +	amend! intermediate commit
> +
> +	target message subject line
> +
> +	target message body line 1
> +	target message body line 2
> +	EOF
> +'
> +
> +test_expect_success 'commit --fixup=amend:HEAD with -C HEAD and without have the same message' '
> +	commit_for_rebase_autosquash_setup &&
> +	start=$(git rev-parse HEAD) &&
> +
> +	git commit --fixup=amend:HEAD -C HEAD &&
> +	git commit --fixup=amend:HEAD -C HEAD &&
> +	git log -1 --pretty=%B >with-c &&
> +
> +	git reset --hard "$start" &&
> +	test_set_editor : &&
> +	git commit --fixup=amend:HEAD &&
> +	git commit --fixup=amend:HEAD &&
> +	git log -1 --pretty=%B >without-c &&
> +
> +	test_cmp with-c without-c
> +'
> +
> +test_expect_success 'commit --fixup=amend: with -C copies full subject + body of squash commit' '
> +	commit_for_rebase_autosquash_setup &&
> +	git commit --squash HEAD~ -m "inner body" &&
> +	echo "extra" >>foo &&
> +	git add foo &&
> +	git commit --fixup=amend:HEAD -C HEAD &&
> +	test_commit_message HEAD <<-EOF
> +	amend! squash! $(git log -1 --format=%s HEAD~3)
> +
> +	squash! $(git log -1 --format=%s HEAD~3)
> +
> +	inner body
> +	EOF
> +'
> +
>   test_expect_success 'commit --fixup=reword: works with -F' '
>   	commit_for_rebase_autosquash_setup &&
>   	echo "message from file" >msgfile &&
> @@ -553,9 +609,7 @@ test_expect_success 'invalid message options when using --fixup' '
>   	echo changes >>foo &&
>   	echo "message" >log &&
>   	git add foo &&
> -	test_must_fail git commit --fixup HEAD~1 --squash HEAD~2 &&
> -	test_must_fail git commit --fixup HEAD~1 -C HEAD~2 &&
> -	test_must_fail git commit --fixup HEAD~1 -c HEAD~2
> +	test_must_fail git commit --fixup HEAD~1 --squash HEAD~2
>   '
>   
>   cat >expected-template <<EOF

