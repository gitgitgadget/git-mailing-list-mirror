Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309154;
	b=1mYWnh2QGZ8JXOeNy4JkMvN2O36lhmADvJSC5xNpiChy8B4GjwY5T1OfDpdCNR22/2wm
	 33BPNGVgNQy5LZEzTXIyTsNpgpfpdsC9sB6Hibo3+kPY16cOtl1vjZMBwlSTk5nIx9c9+
	 nR1Dsneu0DRAYhN7FWbbI5iPzlupW+mI6hwOMymHEV5Tkoez98VyEStpYce3zkfoBrFqi
	 HB4lTbrHcn9jIw9yOdYGDQs/vsY/PcdUmbeOxqNs26TZ8qahjo4PX0cPsGAr8O2yZDYDM
	 7FxxVQik/B+x5ni2LvkGIakmd4QSYtJ7ysCvlhMBPhni4JV8wJ6tA8DZTmJzG5p9LoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dJwxYmk4PfKWkIHi+hEhy6Lziy6fndbCxU5ULwMlteI=;
	b=skY90IneqezgJTFtfbN8R8hf3/MpCz32EldBjfwBt9L/g0BPHm8e+94/riQH4SviKaYB
	 jBtyw4BvUCDQY8mpayYfPe+Xz8LU6MpLCb0miXsKO3wjMz5HfFG5pVitXkBPI7csxTpq5
	 Y1KWmsXBxWRGU94w+buSXheVn1rQrRF0x3OXLW0/tJzkkZxHsYRDzpyoKZ3DpeSU9kokO
	 0DnxSGcJCRTMgc7pIJ0nGJpxU/Ob2OPJvDsPdf/TkHvCmk+bIRXFXoort3iQ7hOgaZrBs
	 EuKk9ngIOpzL0Dx7U25M9Trk98i9j8fkGGzMsNQD3AZr1nub0yJOGGrbStjC2BZrj8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x+ZA039N;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592AC606A31C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 592AC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x+ZA039N
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so15320925e9.2
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794309153; x=1794913953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dJwxYmk4PfKWkIHi+hEhy6Lziy6fndbCxU5ULwMlteI=;
        b=x+ZA039NR9yI205x28AOpM0EVhATwlPniQEpa/O66AD/V5WRNch83p1whiQ1svKdHe
         7ZbuZV2er1lWDTn7RepA+i9fOehbACPowXwSGTWycZfdsmRr/d0ON/KruqNbxHIuJxVf
         eYed1gULsRWovcyb2zALHpVSZ8PNQI54JcTqHwcbfCXkfC524NioqEwU8YjStdaJBkXc
         FK4g3EkxRx+/dUybWee/ycn15xGaSkNaOO7t/EGgdcDd4FkU/WLhxCX2jjc5RZnmpc6J
         DW94q3bDE3FlSrFLG14bUGdcSUJrETIuQxz/HdSXo4ZHno+3h2qdYauUp2BSw9e3NwWU
         EOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309153; x=1794913953;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dJwxYmk4PfKWkIHi+hEhy6Lziy6fndbCxU5ULwMlteI=;
        b=eV3xY9neJuZmmVTTV49GSrYT1QEtgoAYpDp3FXD7PAXMTbK8CuPL8osHwXQ6qD1REc
         Tmjyo1hhai//O6vZPw6oYohTgTNvY4UAEMlD8f9Z6rIvEzdwoL/Dh7qniLcz4u74TJU5
         FhvB5h+q7Sfhp+PXWmWm9KCUAmXLOwWaYKRQuU3grTy3WtkJf5Z9WjHwN63aoEL9oQ6N
         sT3oW0ijf0tvbUNCG+KfM+KL4ozR70leKOZtouBAWn+F2Easq8GIa/0lj0HswIIstA+h
         yXzal3hJb2W5qeyP+fL8tk7MZmkNpUY6iIuF+WxR3JnxbCvNbuVGGUS2vtkUuBLe2lu7
         0odQ==
X-Forwarded-Encrypted: i=1; AL+hErFzfbmaIZ9fTxLyh7M/uIA7UmPF4Df7NiEssNcERUH6KRNWhUfQLngSndaDtOx6/NjnVOg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9UHkv1RHIJUYEVJaT172ClyqEwQpCKEinVTyPaFfvHS/RjuIVf
	Gg0Eb8PKikZOYM8ZzjOFdFWUgv9IXJrSkUnf020XPI52jKnHMmkkG4ou
X-Gm-Gg: AYBFou3itn+SKPc7W1g+3eXGuxzsEcSctN6+swzzEu0WV2pzWGU/LORUEEbFYXDWIWb
	UMjUCuXX8yTVf9LOAy6Rfu6BlOv/cSi4O5OTFyZ1A6yoJixck1nFBYhYR1D9r3J1j0Pk6VFT3l5
	aQea2KTXftJUN0EkO+gKj3ZPrt24YNIaSvy+qZioE0cwjdvOui/WZJ7d1DvkpjxAYcUZlxMyz0U
	6nCLnMQ12XtfSeYDMg64kYMTyFnMJBWVieZfqB00kv9XJdc1sJ/fUJulMs1aK3n47ZgezN4vs7O
	eaJW9A9Pnq9SrWHXt+cHyajYsoF2IphXQYuEu9hwTuFXhVOCCMNBZjh9q7NJI7G4MLhTw/CyeSh
	2dlEkjnAOiFC/dLKxSTfUisXb4vEhLU0v140yiguR7ULkPL0frztvsKAcaP/WH2g6IoI/Yrfr1O
	RSfXpr92ZosPYsRCSy4fjRhqM02ca6NgTRQbdQhYXHo4H+4wjnwQYQPVgdd22+lC9kwjRTVTAiY
	2HScrBf1CqbPvwH10Edhy05rH4KP6z5a8y4ss/CWrKoz8Pqmghsnd0jQbMghrNzTxsmBMRwGCE7
	l4qtHU1702Ki6fgdk3pxSblC+y7qVKG15CE80lD7rpFn5AhqKeqFwLq40Mg+wWIaMEehbjMCgfq
	ILY3m9os=
X-Received: by 2002:a05:600c:3e11:b0:4b3:9540:47a6 with SMTP id 5b1f17b1804b1-4ba0234f7a2mr34067485e9.28.1794309152596;
        Tue, 10 Nov 2026 03:12:32 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835c37bdfsm4635213f8f.22.2026.11.10.03.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 03:12:32 -0800 (PST)
Message-ID: <12def237-2d01-404f-b7aa-b4f19e033cdc@gmail.com>
Date: Tue, 10 Nov 2026 11:12:31 +0000
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
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 08/15] merge: handle NULL value for
 branch.<name>.mergeOptions
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
 <e10f1fc0ba4084584e11834ea98b8d8d8e353244.1794040968.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <e10f1fc0ba4084584e11834ea98b8d8d8e353244.1794040968.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thomas

On 07/11/2026 08:42, Thomas Bachem via GitGitGadget wrote:
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 5b4eb23a83..fbabda97f8 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -668,6 +668,8 @@ static int git_merge_config(const char *k, const char *v,
>   	    skip_prefix(k, "branch.", &str) &&
>   	    skip_prefix(str, branch, &str) &&
>   	    !strcmp(str, ".mergeoptions")) {
> +		if (!v)
> +			return config_error_nonbool(k);
>   		free(branch_mergeoptions);
>   		branch_mergeoptions = xstrdup(v);
>   		return 0;

We treat an empty value differently to a missing value, I'm not sure if 
that makes sense or not.

Thanks

Phillip

> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index 64fe21717d..d4963f1fee 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -552,6 +552,12 @@ test_expect_success 'merge c1 with c2 (squash in config)' '
>   	test_cmp squash.1-5 .git/SQUASH_MSG
>   '
>   
> +test_expect_success 'merge rejects branch.main.mergeOptions without a value' '
> +	git reset --hard c1 &&
> +	test_must_fail git -c branch.main.mergeOptions merge c2 2>err &&
> +	test_grep "missing value for .branch.main.mergeoptions." err
> +'
> +
>   test_debug 'git log --graph --decorate --oneline --all'
>   
>   test_expect_success 'override config option -n with --summary' '

