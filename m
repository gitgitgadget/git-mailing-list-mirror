Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236848;
	b=C7MTQ6cnpaGFRQp/dxH3S6AWhYTznJNh9aYamTyJYH9W/k2ZVqYqNfmCtWwWmN3Jm5JA
	 v8XPkDyuPwbMo8OZ6+yIWdCFOoj4/fp+DGnpIAuyuPSclt5X5Yt8l8SoatuZ+otkWOckb
	 eoAQ/XQhXB+XG1Grqc9t9yQUoeI+KJk4+USaX0+P2ULXHjZHOqx+r4Yn9WRQeHi27fahM
	 Xn4NWuo2U2Spic88ZnaMEYsDOwlvsqDEyGSFii1i+OL4Mf7GFaFLDHq79bnQgsB69Q/hr
	 peLdlrDMITi3WEOmyou4j/dHhPyuWadAgWom/qvg1B7StiVoMTRwTr9RhZpQl21xYPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=EfJK+bCSoJwysn/3HJllqzGMJsA1XKVv3i4y4QFvN/w=;
	b=SkoHLzmDhYya1v7raoJO5lnP/fBr2cQdWQszZhze+cLAN3qW077ImPiHv4rCa5QJySIG
	 vXRCPLatMtsFJG8CRIgCvXKnYMgcLlGtH6Vf924Qwjxdx7Q2dNEtX3x39mk9AnEUrgXui
	 V7qQ1q6cZIKt/aqAg3VzV5v+Z0/+Snw2v6yFNp4ZOK1Xt4SF1hwhJZZf9aMQo3CILof1e
	 qF3vTwDoGyRWfT0zrUYGuOsLPI+toVkqdqHOykuxUjO7N7awbf12/iyz06dbno8uM7sSe
	 lUxA7bRI0M4JJGsOWGms0BBy/5Ytb07GlEQKOyRTt05nLsatnJza0ISANWxSFU8IkEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sl8EPurx;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9C2606A334
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 15:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E9C2606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sl8EPurx
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-492690dd5daso669584f8f.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 07:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794236847; x=1794841647; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EfJK+bCSoJwysn/3HJllqzGMJsA1XKVv3i4y4QFvN/w=;
        b=Sl8EPurxSBGgR6ooCMl4IlkvIC+nKUEd1MGlQkHZvo4p9SWdGEUyiiQPjDouZBWHHe
         XN3TILr/p+GX3h9vovFaoBXCrmJSm+s0tolnmWQVRlqPgQ57SJWwHpwzSkxYvG26xbxT
         hUgCqnVdr47EcMBxb1jHsxZpaedc08Kjb3UAQaOBZkAiG2JPv0G+Le5tyx4KaVZbpGSZ
         qaUTWjsW9y4N7pUTIe5SAcwxHg+HbzfQwI1QEvdb1g4i+uKfemaDe+eTVlWpYMpBcLk1
         61/qmoy0lxIffHswRfr1AfBawuu/TWrHMMVXbcv9qR94w2baT/ClFVADkdpfPDO3LLE3
         4PWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794236847; x=1794841647;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EfJK+bCSoJwysn/3HJllqzGMJsA1XKVv3i4y4QFvN/w=;
        b=mtZFKuF3ru6uS6u1cD5D+bQv5HKeYO1x+cAfgVNeWPA6sE4WCENLAgRXoEb6638Bt5
         G0TDT3v0iQuty2gXxokqsmb09Wb7R9abQ1ltXN2IfFaheBDKgse370YD6jBfGRs6WayI
         9SPmwNDEhLmbXZ+tw4b+lrGtIyRWV1v7UE4++KNkAaktYWCsKyu5D8WFCKSVu+wJp6O/
         +k8Tqk0GcrmdrY36m21wiwduv2pgHMp4zNW5KMDp9OfePvcDYdcGc/hCBkGuEYc8fZq5
         9qcCoWiPcjkhjdc0mhkb2zWPStH2Ud2QQ6FJ2h4nJ8OLnIrA1Nn/mQDaCBLj9gf0YIpP
         wxLA==
X-Forwarded-Encrypted: i=1; AL+hErEGqM9EI1jONt5QoWG2cuoeHldVuEPuvPArKRlhynUVGDhlU5zKuTLaegkoSrL87PYGpEM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8zhpA1AGPoGk1WApHicTu+FyZXi8md4FVkhpMNKIW+lrtKDZpC
	lXBJOYcaQ1yyjnYp1J84/UpJDT6z75TIVrhLFSlg9kSKIz29gKy7GSMS
X-Gm-Gg: AYBFou2q9O/msaEALdK1W52IE+gbbNjyNFU459DRWm+t71+/7mlWuK3Kviqaa5eOgTd
	l82DLqa+43Bvdh+5lupgDWn8ptX05pCkgJkRtvNzK6W6i/PyOm+elbb8NAnknKkMI/jw5wYizXA
	W5wFdOLmILjBWgmQxnLp+aQlboLvLPhBMlyDlwROqJhjqw6BPc8+MGvr2s0UzX/8v9L+rf0Uk4u
	SvYQYhjAWPZBLf7gXj+RSZ2s3X6oM0FLIygh8O7O83KIguuaY2gR6nnWvasyvIls0zxJPfBGKsx
	Cw3l1hFL0y02I9v12vWCy+Srf8dfvjiVbxnKOyD3YbGq8RjZ9+CZ0Mme2rVgO8TV3KUZXNPvON7
	0XflPYxKfjNSLif1W1IxAb8SCtQexEpmndcP12oM4vG8mqFfWOc8L4qo73tb+BBmYBMgHnVkGSh
	P5+NW7OX4USsN0+AmiVz4lBRMaM+snMHGEz5PZHFy68QAIZNmuwYbw4q+/fR+peNALmUYfzRdy1
	g7njdq6Th/E6A5BJG+kLdZAHucPHvyreAmekziKqb6zacTSRnUOVwTvRTpE46BDNakVdMGvcjxt
	hLiVfi7ejOC9CJdmt4KpxtOtziZa6AEJk89kU4VoctbXRzE+BegyteXt1MpPXCfFEGeBHPPcuNX
	oSrhfRWY=
X-Received: by 2002:a05:6000:1842:b0:490:50c1:f352 with SMTP id ffacd0b85a97d-4958b90ec17mr8089887f8f.39.1794236846501;
        Mon, 09 Nov 2026 07:07:26 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597e00d75sm10277650f8f.58.2026.11.09.07.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 07:07:25 -0800 (PST)
Message-ID: <226aff79-b0b8-41b1-92ce-78554f6b2f8b@gmail.com>
Date: Mon, 9 Nov 2026 15:07:19 +0000
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
Subject: Re: [PATCH 01/15] rebase -i: handle NULL value for
 rebase.missingCommitsCheck
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Jeff King <peff@peff.net>,
 Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, Colin Hinton <colinlewishinton@gmail.com>,
 Matt Hunter <m@lfurio.us>, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Miklos Vajna <vmiklos@collabora.com>, Junio C Hamano <gitster@pobox.com>,
 Thomas Bachem <mail@thomasbachem.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
 <a9a3f4b705f98f0957bc9645395f4c68875b2896.1794040967.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <a9a3f4b705f98f0957bc9645395f4c68875b2896.1794040967.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thomas

On 07/11/2026 08:42, Thomas Bachem via GitGitGadget wrote:
> From: Thomas Bachem <mail@thomasbachem.com>
> 
> A rebase.missingCommitsCheck without a value, as in
> 
>    [rebase]
>    missingCommitsCheck
> 
> or "git -c rebase.missingCommitsCheck", makes "git rebase -i"
> segfault as it writes the todo list: get_missing_commit_check_level()
> passes the NULL value to strcasecmp().
> 
> The setting takes "ignore", "warn" or "error", not a bool. Read it
> with repo_config_get_string_tmp(), which rejects a missing value with
> config_error_nonbool(), as ba176db511 (config: handle NULL value when
> parsing non-bools, 2023-12-07) did for other settings.

If the user sets an invalid value for this config option then we print a 
warning and default to "ignore". It would seem reasonable to me to do 
the same for a missing value rather than erroring out.

Thanks for fixing these segfaults

Phillip

> 
> Assisted-by: Claude Fable 5.1
> Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
> ---
>   rebase-interactive.c          | 2 +-
>   t/t3404-rebase-interactive.sh | 7 +++++++
>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/rebase-interactive.c b/rebase-interactive.c
> index 809f76a87b..4eb628ee8f 100644
> --- a/rebase-interactive.c
> +++ b/rebase-interactive.c
> @@ -30,7 +30,7 @@ static enum missing_commit_check_level get_missing_commit_check_level(void)
>   {
>   	const char *value;
>   
> -	if (repo_config_get_value(the_repository, "rebase.missingcommitscheck", &value) ||
> +	if (repo_config_get_string_tmp(the_repository, "rebase.missingcommitscheck", &value) ||
>   			!strcasecmp("ignore", value))
>   		return MISSING_COMMIT_CHECK_IGNORE;
>   	if (!strcasecmp("warn", value))
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index ff11abb2f2..813ad2a83d 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1562,6 +1562,13 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
>   	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
>   '
>   
> +test_expect_success 'rebase -i rejects rebase.missingCommitsCheck without a value' '
> +	rebase_setup_and_clean missing-commit &&
> +	test_when_finished "test_might_fail git rebase --abort" &&
> +	test_must_fail git -c rebase.missingCommitsCheck rebase -i --root 2>err &&
> +	test_grep "missing value for .rebase.missingcommitscheck." err
> +'
> +
>   test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = ignore' '
>   	test_config rebase.missingCommitsCheck ignore &&
>   	rebase_setup_and_clean missing-commit &&

