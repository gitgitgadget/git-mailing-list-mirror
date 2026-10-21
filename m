Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596046;
	b=K1jlmu++Z/R/eyiKJW5JcICQQNfKDQsjjxinolGVLxxCSxhji/2rjiavAbjHrAQqYSmP
	 X/DZnuX4r8fBkHQKUtrQoC3BNEjuO4VGRV19AZMp6OYkK+BZGUbb9+vVIv8Ovc9u6XmH5
	 370mXmfuQt1wMFIV4fPK8ov1mo1kxd1VcYx47IcZV4v/vsUoOYZZDSdo+Xn5qCSxi/7So
	 t9KP2Rar+iG1q8HJ6jDJTtgOUywaEAcnV3kjmX9L4XXzKzoyLVynPtIt0SxVmeSgjyZDD
	 yhWZ1lhn1XC4bNmHGwRkYl56I5IkSAIwOPnzwmzGhfLJ7Yr6odkM3ksX1ouz0Cn41Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=QgcWO6RVZtOBLwr9SFHBf/xBjNn4Y8uBfpLoN+O1EZI=;
	b=0cebYVJJ4EOY6eDVpUUBRcs4bU/3eB7HKfURiEIuUo/eczpEMmTAsqdn/iP2EcXvxZls
	 DZkUknR50WNGPHf3cuRuxipSDpsR8vYcBPgpIizPDp7NkBs7BPaRBMmaDW8zkwTFCCiHz
	 oUU4ctBAT86la/9ku3JQhRyrcXXomhYfFwq4NXOVVi8QgQqVkCrw9wrlyll0P/8GfVsnn
	 G6H25+9UDAvATPs402ZeS1xxn4QsnZyuU4kXqV+eagusggkSs4YvzauikDu1GE1azjBz3
	 ASVo3sK2UoanEHNsojGH/VLHs/Pu4sVuXdaFytAVCFChateZkzlRIrjPcYFVeuK6Wig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GJoVgaxN;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B32606A333
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 15:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02B32606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GJoVgaxN
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48afbd2c386so652871f8f.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 08:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792596044; x=1793200844; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QgcWO6RVZtOBLwr9SFHBf/xBjNn4Y8uBfpLoN+O1EZI=;
        b=GJoVgaxNTPnomQuvnPZzvd1eF8fjLzpiCOGgTjsI/Xh5nkMyy5eZbfmLCarwGg6FZt
         mhQaAZvraPY/Tw/L7RkC64iIrmXee60zIbBnzWeMptz6Hz2GOjnDj+uiLUJ5fKiizr3q
         6jx6/z7EtC/BcvIq8cw3Uhtp1oTgIKK2zrKFsTR/Jn9XVcjP1UkJePC1JG6rz1PVQPOe
         9fO17OBSZ47prC2fPjvyhIYsB+864tndjNwZ1RxF+xmdjXML82d/ZM7hJrDmpITdWtww
         1ZDmfrR+UNUHok2pMnon1HB6lSE9tBtWSXjCL6uaCHG1rnGio3EHsw8ecR3Jx6pi9rgf
         vTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792596044; x=1793200844;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QgcWO6RVZtOBLwr9SFHBf/xBjNn4Y8uBfpLoN+O1EZI=;
        b=OGtu/MbuRkSMiS67MuCzPEp8RLw5uFaVyE3P+9XLgLDQlccT5qAro+9UZmaEvjwIPv
         8Bx9qKAoXnrRXNw46wOF4yXQRMmJLoyoCgAEJapEO8sjh12Iqka1rHn5UbbeuUGi6YxF
         wKSpeh8bujTqJZit1Y8kvMxsHJguPRCbr86VQYwClNXITwfOqmvpwXRSnzMcW/6A2Eu9
         LlHUp8rBn8jIHr+/asCcABn2/97BVm/g8BYBHLw9a13iR0STqntMaacx4QIfh5NcSsrD
         fJsrjW7VZ+RlUSpKmQ6nsCAOamfBG4lJytnBym9QCWT2HS+y4LRvPdx37KYQJG3/7it3
         xrzA==
X-Forwarded-Encrypted: i=1; AKwUvBzer1jE6XnYi0C2Y6UfXMb20dFacf2lvaydyFN+mV3GCKNz6Ulljd85cXxSbuGZ3kVdkEw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZdoT72XNOmyFRULVelDrjEAu7XvM7rSH+2bB730lSCDhoy9q+
	R2/IkyITxxZomgbipAPC4suNP+YzYOIk8VwGob4AqGjWwRU5vk9hZedH
X-Gm-Gg: AYBFou2BvkxK+MF56mkAwLdVWZqMyWdUKdwvATtTNci48RgjakSoOx9B9LfcBr4WhYK
	dJOSl6s6K4N3PGcQK+92agHbCU4z0NJuFVDob88Uq6XEeSFVhiClACQb+miKdWUn2go+j1J+fct
	AGgP7dGkX1wd9oYXJqIMFwCMIrIKboZAKYr637wXQG/KgfBCYZ1VVTvIwmSxWquRA09Hqwu5HrT
	hjax4HXHlyYJ0KSk9SK08VuWdSEeBYO8x+zWep5lW8eA5F7xh/nWxDTSmeqUWCbaK3ZjxcEEfoa
	HJJoEDlg3/mtYqLq/7HXBAaDmvi4KdhaDiW7zUFHwFYI23WNbFjW/4o5zfolDwc9vUk1rVTRld8
	ce/u74YcZOrBsAAe/UdTdDXTxNPeL8AWmhjP4gTgU2umP2Awi8P0ekwAigaGQ6k19yoarEgr7IX
	wrOb9SdGYpAOxCeXMC1K94FjuJaIrfsBHe6urQkAEIbCJ81gPrKZB1G/vCTth/011OO564TvuPz
	oRZm+Wcn0vjvifFytbPP2FHL+4B/ed61g/Zzv4xg74y4T2MJ5188RCxZ1cC/GuLLmH3v0G8F/Uk
	V1uszOSGEqJjuoS6EimoCpFOCu5YAWarJA==
X-Received: by 2002:a05:600c:630e:b0:4a1:9078:911 with SMTP id 5b1f17b1804b1-4a1fdd5d9bbmr49956575e9.31.1792596044007;
        Wed, 21 Oct 2026 08:20:44 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a20230ca3esm24441385e9.15.2026.10.21.08.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 08:20:43 -0700 (PDT)
Message-ID: <7179f371-a709-476f-8e94-807d7b62ce6e@gmail.com>
Date: Wed, 21 Oct 2026 16:20:42 +0100
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
Subject: Re: [PATCH] sequencer: refuse to revert shallow boundary commits by
 default
To: Nakul V S via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Nakul V S <vsnakul@gmail.com>
References: <pull.2273.git.1792577381142.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2273.git.1792577381142.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Nakul

On 21/10/2026 11:09, Nakul V S via GitGitGadget wrote:
> From: Nakul V S <vsnakul@gmail.com>
> 
> When a repository is cloned with --depth=1, Git records the boundary
> commit in .git/shallow and rewrites its parent links via the graft
> mechanism, making it appear as a root commit. Reverting such a commit
> will therefore delete all tracked files, which is almost always
> unintended by the user.
> 
> Add a check in do_pick_commit() that detects when the target commit is
> a shallow boundary (nr_parent < 0 in the commit graft) and refuses the
> operation by default. A new --allow-shallow-boundary flag is provided
> for the rare cases where the user genuinely intends this behavior.

Thanks for working on this, it is a useful and timely improvement as 
there was some discussion about improving the behavior of git with 
regard to shallow boundaries at the recent git merge conference. I 
wonder if it would be better to refuse to cherry-pick and rebase a 
shallow boundary commit as well. Do you know of a sensible use for 
reverting a shallow boundary or is the new option added out of caution 
in case someone wants it?

> diff --git a/builtin/revert.c b/builtin/revert.c
> index 52100a20cb..f27397fdec 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -24,7 +24,7 @@
>    */
>   
>   static const char * const revert_usage[] = {
> -	N_("git revert [--[no-]edit] [-n] [-m <parent-number>] [-s] [-S[<keyid>]] <commit>..."),
> +	N_("git revert [--[no-]edit] [-n] [-m <parent-number>] [-s] [-S[<keyid>]] [--allow-shallow-boundary] <commit>..."),

For such a rarely used option I don't think we need to add it to the 
synopsis (we already omit some other options like --rerere-autoupdate)

> diff --git a/sequencer.c b/sequencer.c
> index efbfd1315b..6de59bf6aa 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2366,6 +2367,19 @@ static enum pick_result do_pick_commit(struct repository *r,
>   	}
>   	discard_index(r->index);
>   
> +	if (is_repository_shallow(r)) {
> +		struct commit_graft *graft = lookup_commit_graft(r, &commit->object.oid);
> +		if (graft && graft->nr_parent < 0 && !opts->allow_shallow_boundary) {

It would be good to extract this into a helper function so that we don't 
have to copy the code to detect a shallow boundary each time we need to 
detect one.

Thanks

Phillip

> +			return error(_("%s: commit %s is a shallow boundary commit.\n"
> +				       "Reverting it will remove all tracked files because its\n"
> +				       "true parent history is not present in this clone.\n"
> +				       "Use --allow-shallow-boundary to override, or\n"
> +				       "'git fetch --unshallow' to restore full history first."),
> +				     command_to_string(command),
> +				     oid_to_hex(&commit->object.oid));
> +		}
> +	}
> +
>   	if (!commit->parents)
>   		parent = NULL;
>   	else if (commit->parents->next) {
> diff --git a/sequencer.h b/sequencer.h
> index a5d12a1070..f334bc5357 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -57,6 +57,7 @@ struct replay_opts {
>   	int committer_date_is_author_date;
>   	int ignore_date;
>   	int commit_use_reference;
> +	int allow_shallow_boundary;
>   
>   	struct strvec trailer_args;
>   
> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
> index 939e7a16a6..508464004f 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh
> @@ -256,4 +256,29 @@ test_expect_success 'cherry-pick is unaware of --reference (for now)' '
>   	test_grep "^usage: git cherry-pick" actual
>   '
>   
> +# Tests for shallow boundary safeguard
> +
> +test_expect_success 'setup shallow boundary tests' '
> +	git init src &&
> +	test_commit -C src A &&
> +	test_commit -C src B &&
> +	git clone --no-local --depth=1 src shallow-repo
> +'
> +
> +test_expect_success 'revert of shallow boundary commit is refused by default' '
> +	test_must_fail git -C shallow-repo revert --no-edit HEAD 2>err &&
> +	test_grep "shallow boundary commit" err
> +'
> +
> +test_expect_success 'revert of shallow boundary succeeds with --allow-shallow-boundary' '
> +	git -C shallow-repo revert --no-edit --allow-shallow-boundary HEAD
> +'
> +
> +test_expect_success 'revert in non-shallow repo is unaffected' '
> +	git init non-shallow &&
> +	test_commit -C non-shallow A &&
> +	test_commit -C non-shallow B &&
> +	git -C non-shallow revert --no-edit HEAD
> +'
> +
>   test_done
> 
> base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926

