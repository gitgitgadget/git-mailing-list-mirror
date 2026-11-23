Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795444366;
	b=HXo7AbuCMjDf30zhyjhEtnBuJe+hq+a2OgGW2mMg0QS23aCYqw2uAyOzp1Z2SAUTm3gD
	 2uinjgl0csSH4LwgyTVf5Y0vJYw8AJDizhs/5gS5BgbdiVhepT5yobBkFvg2sYd8zkT1p
	 44ZTWfSzG1gh1LzV7eLpojJ+r+iXlZ/UAb5OdxmkEDBCcSeJZig/aRMk8e2gxsbUKiUTm
	 jNH/B0K03jAIK4enpc9h+pfpR2g4gvn65BQFeud5AL97HJGx1diDJwabWsgUsVzeOJAs7
	 A/vOONocSW970LPEKztIcv0xNxGMv6eVa8S/v4kOoJzwENGgMM4ORbSCRnEYC+2Wrrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795444366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ntHfGL+MKGCwJPNG+oFmBqKgw5RmOiZG4fck/Uf1wbw=;
	b=2ceBJ4FPDDtkNo28CiXnHRmfhwGXmjLR+RTIfpvmu5yC6lO/fY//O4ZBmAagB34T3MWv
	 8kh7rwPN2JK6//W7ML0SzvE8+k36uEdkBiBFZvt8+LUpLOl35iV6ky3Hethc3iLRIlccA
	 O9VOgN342rkjGq0AL/PGlQuRI6HpxVbym/uKLbUFqFvw2yUi1KtoFNjh0HB71HjZd4Ohh
	 iYSA/pGeEjWPmnC1aMx8f50si5F8cLo3xscCp4qMFe7eQhVnFSuMBtihpctsyjkmhKzIS
	 JXSO5SbstXGkPB8YK3o5RZjiszYS1FywdyDkvOUxYL4s6Yfk3Hlh8148wHkQoAcRjpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NzTiFJjy;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC42606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 14:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BC42606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NzTiFJjy
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c4cdc606b47so569875866b.0
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 06:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795444364; x=1796049164; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ntHfGL+MKGCwJPNG+oFmBqKgw5RmOiZG4fck/Uf1wbw=;
        b=NzTiFJjygnptZfDY5jyeUfeOB1L5Ps+32NsReljKf19vGEevFnpy3uuYPsboLQxxa/
         JZjeIZ8AVpyB++sxf1k28yKrGm46w5a81gRnWbbriFv3quCCn7SSmQZ9LVKl2hXsuK17
         n8AvfWTuDowdfq4gfG6T5WihT3mlTK2ATzTltljG7dzKgwvHkH0rmJdEbQA+W8OmgKQo
         EUlLCVxJAvNL6O0EKEyDkoyemFrPFfr8EECBci3SCmjSkyGcLMuFCDUk3iqRWTAtxQ39
         5nEeqPOJ/vr1l8zvJd2DDYSVPk50GrfdgCH2qmdHcZv5LI4s1FPZlkKLWX2rkBS2syZl
         IZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795444364; x=1796049164;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ntHfGL+MKGCwJPNG+oFmBqKgw5RmOiZG4fck/Uf1wbw=;
        b=0FlhDcA/tHfxJryTmDaLzHRRH6BTFabxzSZzzQLVPI4icUtE3TZFDtjH+WR0LXrlh9
         6s2FPoZWRp5HGko9aqnXrdhuBdz0vQwKe9SLKQ6AXjp5cQaBcNfbWYOIFcDV+lp4Qkc4
         OWgB5sSsE1d1VX8LYg8jm+4pGB3zD624vTkt+x/yuZyYSNKvhv8Zt6WF+DR7N/dq2ubq
         52PwpySMqVHdGx8Nhi2N0PlbR+W6QMaqMz8w/VXbwX6ya4Mg4yDf9KSdvgCfABbyXx3n
         XU6OcVywoz+lQByPFYnTzi34i7Lft8jQB1t8hjeCCAtsJYzGSqoE3nFK7BbrIlFLzTr9
         CgAQ==
X-Forwarded-Encrypted: i=1; AL+hErFWWZDW3wT+ilaYqI9OwZSbjomz51gZExaBmqJfJvBNVjqWp120SEPGyY/pTrs1Ut4ZPrQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NlOuyoJAk15GIsqOBww2nq57O4e8M9kQkQSwJ5gZLxaFOyC/Y
	je2JKgecvRfSwcjf/YicjumDSQ77w6u+lD9gQaN2+Bu4xN2fn6kyn1Dp
X-Gm-Gg: AZFdTZciOSXZE9dU40CMOeKiMVqgGrb76GI8UY3tkJGnxbULNcY5NSOcb1Bz/kMdMsK
	m8PcZifqhIunqX4boPg9Nt0PCDnuUOzZp8FB7DZtf/s6FSKjYhHyAzHcqpjCABDfNFumUI5WYNX
	uHnJQz2EWDtqRaSfzrEbfxsyKErcli9mEU1JdFogqMjJE86mBUJKCbPPQCMTVwy8oRCa0i9ovlQ
	q6+tyJ5cKH3tx2osgW0DFAXC6aB5TNfM0tmUH3iLCcsBeAxdo5JR9wBagUoA803gzU6MSAgwJut
	oAUufclmu26a1/+wWhyOYykdZQ4kzSAhRkakMO36mYhZbic4g/eHGY+cWFxdDxPZa+R218khNJw
	MA9RQayNU0ZYVZRVNxhziulV7MQ8VIduSnDtjM30B+Pz2CLEZDO6AgVQRbe+B3fpTjDyfA2LOh6
	Nfr5ew9LO9jEQww5jPlLC6bF9/aeYb2+6dzn4AYN/JM2wxkQO8raM7FGfAUSRrB30pTWarwk/Kj
	epfLmopTfkZgKY/ooiOXHDbRWP06hpyCwl4KC+hJIxJxYvYTx1W0iGBxhaTi90iv2iJ7r41e36D
	wOwUnr5Wpm3R9yYGLCgvu6es/ln11b30nCY+D3rNAJtS61Aae4vAPWBzw+M9/Nd4WIYhfIpxJlr
	iGJB/Wradtl1RyiieXpsyMyLY84wE
X-Received: by 2002:a17:907:3e15:b0:c51:249f:7331 with SMTP id a640c23a62f3a-c513a3aacc8mr990461766b.1.1795444363685;
        Mon, 23 Nov 2026 06:32:43 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe01a0sm421909966b.68.2026.11.23.06.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 06:32:43 -0800 (PST)
Message-ID: <27abe897-cba1-4561-816a-875c064ab8c0@gmail.com>
Date: Mon, 23 Nov 2026 14:32:38 +0000
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
Subject: Re: [PATCH] sequencer: reset saved HEAD OID when picking onto an
 unborn branch
To: Wonseok Oh via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Wonseok Oh <wonseok_oh@korea.ac.kr>, Wonseok Oh <marinelay7@gmail.com>
References: <pull.2317.git.1795242633923.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2317.git.1795242633923.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Wonseok

Thanks for working on this. I think that as an immediate fix for the use 
of an uninitialized variable the patch looks good, but I'm not sure the 
behavior of cherry-pick and revert onto an unborn branch makes much sense.

On 21/11/2026 06:30, Wonseok Oh via GitGitGadget wrote:
> From: Wonseok Oh <marinelay7@gmail.com>
> 
> When picking multiple commits, "git cherry-pick" stores the current HEAD
> in .git/sequencer/head for "--abort" to return to. If the branch is
> unborn, repo_get_oid() fails and leaves the object ID uninitialized,
> but sequencer_pick_revisions() saves it anyway instead of clearing it
> to the null OID that sequencer_rollback() checks for to report
> "cannot abort from a branch yet to be born".

I had a hard time parsing the second half of that sentence. 
sequencer_rollback() expects us to have saved the null OID when HEAD 
points to an unborn branch, but instead we save some random junk because 
we haven't initialized the 'head' variable. The use of an uninitialized 
variable comes from 0f974e2124 (cherry-pick: allow to pick to unborn 
branches, 2016-06-06). Before that commit we refused to cherry-pick onto 
an unborn branch and so did not use 'head' unless it was initialized.

It is rather strange that when sequencer_rollback() rejects an unborn 
branch it refuses to remove the sequencer state so that it is impossible 
to abort a multi-pick cherry-pick started on an unborn branch. It is 
also strange that we will try and revert a single commit onto an unborn 
branch but not multiple commits. 7acaaac275 (revert: allow single-pick 
in the middle of cherry-pick sequence, 2011-12-10) inserted a separate 
code path for single picks before the check for an unborn branch, so 
prior that commit we refused to cherry-pick and revert onto an unborn 
branch regardless of the number of commits. Going further back in 
history, the check for an unborn branch was introduced by 04d3d3cfc4 
(revert: Save data for continuing after conflict resolution, 
2011-08-04). The commit message does not mention a reason for 
introducing that check and therefore changing the behavior but I assume 
it was to avoid having to support aborting to an unborn branch.

It would be nice to either remove the check for an unborn branch when 
reverting multiple commits, or move the check so that it covers single 
picks as well. It would also be good to allow the user to abort when 
cherry-picking onto a unborn branch. Those changes don't need to be part 
of this series though, they can always come later.

I see that rollback_is_safe() expects to see a null OID when picking 
onto an unborn branch, but update_abort_safety_file() writes an empty 
file in that case. We should be consistent about the way we represent an 
unborn branch in the state files. Arguably an empty file is a better way 
of representing an unborn branch because there is no OID.

Thanks

Phillip

> As a result, "--abort" errors out with "Could not parse object" in my
> master build, while in Debian's 2.47.3 build the uninitialized memory
> happened to hold the last picked commit's OID and moved the new branch
> there.
> 
> Clear the object ID to the null OID when HEAD cannot be resolved, and
> add a test.
> 
> Signed-off-by: Wonseok Oh <marinelay7@gmail.com>
> ---
>      sequencer: reset saved HEAD OID when picking onto an unborn branch
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2317%2Fmarinelay%2Fcherry-pick-unborn-abort-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2317/marinelay/cherry-pick-unborn-abort-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2317
> 
>   sequencer.c                     |  9 ++++++---
>   t/t3510-cherry-pick-sequence.sh | 10 ++++++++++
>   2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 4a1c0e70b8..20bfe00ba3 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5788,9 +5788,12 @@ int sequencer_pick_revisions(struct repository *r,
>   		goto out;
>   	}
>   
> -	if (repo_get_oid(r, "HEAD", &oid) && (opts->action == REPLAY_REVERT)) {
> -		res = error(_("can't revert as initial commit"));
> -		goto out;
> +	if (repo_get_oid(r, "HEAD", &oid)) {
> +		if (opts->action == REPLAY_REVERT) {
> +			res = error(_("can't revert as initial commit"));
> +			goto out;
> +		}
> +		oidclr(&oid, r->hash_algo);
>   	}
>   
>   	if (save_head(oid_to_hex(&oid))) {
> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
> index 9400ddfc45..75004bba0c 100755
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -269,6 +269,16 @@ test_expect_success 'allow skipping commit but not abort for a new history' '
>   	test_cmp expect advice
>   '
>   
> +test_expect_success 'cannot abort a cherry-pick sequence on a new history' '
> +	pristine_detach initial &&
> +	git checkout --orphan new_disconnected_seq &&
> +	git reset --hard &&
> +	test_must_fail git cherry-pick base..anotherpick &&
> +	test_must_fail git cherry-pick --abort 2>advice &&
> +	test_grep "cannot abort from a branch yet to be born" advice &&
> +	test_must_fail git rev-parse --verify HEAD
> +'
> +
>   test_expect_success 'allow skipping stopped cherry-pick because of untracked file modifications' '
>   	test_when_finished "rm unrelated" &&
>   	pristine_detach initial &&
> 
> base-commit: e1ec09b23c8e0deb21a0b95ac5996422277395d4

