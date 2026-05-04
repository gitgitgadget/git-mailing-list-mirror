Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8483D7D8C
	for <git@vger.kernel.org>; Mon,  4 May 2026 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777900608; cv=none; b=TdJTNR0wWymr7gPky9fPkd5iNZa9XmKTaacRMFvXcXI09/3bFkV+p6FazXpN5dXlX1EjYBPkCq9wWATRRNNl0CzCnAQatCdj6sJ0Lco0eSfbqgdg+A9cGYGmHZO1Xl1/fgOMH10+rgWMStCgY7A7WU9+e0rngm7SrmYyDwB2u3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777900608; c=relaxed/simple;
	bh=VfGDT88vh7FpLHqtrZjMS73ti0sP538Uv2wVfhlmkn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ltT9A7YKg4pjpnRE0AvzITGblcFnslEOkS1tilyfeWBY2Vx1iozSS//fdYn6k1OjG+YFLk1Ma2Wg6+s8IajP786QWh8d/vgXwQKsyDBEHIeFIxQVPi54lgWqX4FwfFOkVhKtEzhlcIYkzYFV5r60jWvSJRJ0YMLGDaXKxm20u28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uq9J68/2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uq9J68/2"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44c4cc7c1cfso1238064f8f.0
        for <git@vger.kernel.org>; Mon, 04 May 2026 06:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777900605; x=1778505405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r/leXWsOykrTOLiUJ/Ssxvbwg3C/tiWleiwRqZRgptk=;
        b=Uq9J68/2i3sW+OGTksxaPFJOYKDo8ICPws6KZBU5u87HC+PkpN1v6anK6I2hoejOJg
         oxhgW4aCPs0NFRTpuKS8fs7oSs1GPFM3FaxV6Y6j10CkzZUFYmB6D4P1e23CzepKm5BE
         SejGoAEadb91+xqnIHCQ/ChLx+BDvVAn3LQb/6/IxW4m4pHKH43jYW+DzlmBSj+NWJA1
         Ix44lXOCdvAuntyiSCfcLez13o6DQ/944+1ThHb1E1Dulo2wNCNu8nEUxmb9ZBYG7Kxd
         cqqrIlTkB18da0SwNcIBCrIYs+BmgbM4aTpJ0mr0+cpgMOmEXTm3V8JCmRCuq5h4q+ps
         ngWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777900605; x=1778505405;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/leXWsOykrTOLiUJ/Ssxvbwg3C/tiWleiwRqZRgptk=;
        b=FWe/KSBVEcEzAsJ4QhpLTscR7tooao+HqZq4iP2YQhhoMt2sQxrkFp/gtKnDBaVDnw
         RDdnrpLSIg3N4gt9wakj4HlUTDZMd3fbZELdWKReEoh/czPwU7p9vk0UC0Mwo86VSodI
         eNrR+x/yqMYRREJx+AK5WTBdjP0BUUnydh8n/m+DJpyoridUK+NKZhzfIyMVRybWifkP
         jMcf6WLejByNo2BHXfab1VineHa5Wu96BAQ9qsFh9EvymfR/3EQABaOCRkf1SBQRikSQ
         MQbNQZwt/DPLtnwwkRlKWcWFDwVAkD6MkHX2j85caiCz0UZNlZTK9SOXLTCIl56njkrG
         rZPA==
X-Forwarded-Encrypted: i=1; AFNElJ+SL9uhrsbzWpbJaaxLFjtuAe/FfiqKzzNXAq4K4B8myuDA+Fn1JIC9RY834kOqa62rLew=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkP+j4gFbF5o5wYrWEgmIe5f7+AT7FSq6TfH+GDsKVpj34HNdz
	8wMDsVEvY21P3RpJJoyPxkhtGyCh463hbYy6bWO1AuF4JOZBVoL8Wchx
X-Gm-Gg: AeBDieuOoVbl6Ik0v6fydD7ExPy+I4cU+0wUr/Z29/0iGkWjrS8/BhcTc4A9YvIvL8i
	hbltjRjeWcZuitvR0JfsOcuEe9fjI2BCJYBvmYq0rBPOr9rQkPkp8BCzJtCvj3peNyUNwl71OFQ
	r00FMgUjeyA0CzP8YY7gjTzxMFeDGyXIMwQi+Cqoj2wI4TIIhr9C6sWwhH5nTkjrNo9Y73FEbpx
	QomhlfcyPDFoXeGRZSHFcyDzQssT3sBcQw2/0s8WNaOra5yyBC54tVsKTOD/2bmSt+R7OuAxDaM
	2hBJrsu2Kvj2Is7oHs4KxXT3N7kjK+7Lxd+tNzf3KZ9w95sv6bLrLIgcUtfpuqvkrLLS6xM1sH3
	SI7SEZGYimYTRoH2TORrpFfeY6IyXlJSeD7xG8jsg9l0hn/xgLLuERZ+FGndCHOlI6VLbo6aq3D
	MZj6xWNQc5o3B5H18cpV+j3s/DpsL5FL4KzmgqTrlsZiNa1hVxFsDDp/oCAtq2J2OUM0sAeoHKG
	aEZNq3yFKsoJxWhilNT8A==
X-Received: by 2002:a05:6000:420c:b0:43d:7bc9:9b2c with SMTP id ffacd0b85a97d-44bb406ce60mr16547973f8f.17.1777900605304;
        Mon, 04 May 2026 06:16:45 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1706:1a01:60e5:d619:d6a8:b2a? ([2a0a:ef40:1706:1a01:60e5:d619:d6a8:b2a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8ef50be1sm27430335f8f.9.2026.05.04.06.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 06:16:44 -0700 (PDT)
Message-ID: <ef949395-53b4-4799-a031-fcedfacc8824@gmail.com>
Date: Mon, 4 May 2026 14:16:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (May 2026, #01)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqmryhtar8.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqmryhtar8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/05/2026 04:47, Junio C Hamano wrote:
> 
> * rs/grep-column-only-match-fix (2026-04-24) 1 commit
>   - grep: fix --column --only-match for 2nd and later matches
> 
>   "git grep" update.
> 
>   Will merge to 'next'?
 >   source: <9bd69678-f04b-41d2-ad74-a386820d34c8@web.de>

I've just read this patch and it looked good. It is surprising no one 
has complained about the strange column numbers before

> * hn/git-checkout-m-with-stash (2026-04-28) 5 commits
>   - checkout -m: autostash when switching branches
>   - checkout: rollback lock on early returns in merge_working_tree
>   - sequencer: teach autostash apply to take optional conflict marker labels
>   - sequencer: allow create_autostash to run silently
>   - stash: add --label-ours, --label-theirs, --label-base for apply
> 
>   "git checkout -m another-branch" was invented to deal with local
>   changes to paths that are different between the current and the new
>   branch, but it gave only one chance to resolve conflicts.  The command
>   was taught to create a stash to save the local changes.
> 
>   Will merge to 'next'?
 >   source: <pull.2234.v16.git.git.1777401552.gitgitgadget@gmail.com>

I'm happy with the latest re-roll - this looks ready to me

> * pw/xdiff-shrink-memory-consumption (2026-04-02) 4 commits
>   . xdiff: reduce the size of array
>   . xprepare: simplify error handling
>   . xdiff: cleanup xdl_clean_mmatch()
>   . xdiff: reduce size of action arrays
> 
>   Shrink wasted memory in Myers diff that does not account for common
>   prefix and suffix removal.
> 
>   Needs to be rebased on updated en/xdiff-cleanup-3.

Will do

> * en/xdiff-cleanup-3 (2026-04-29) 6 commits
>   - xdiff/xdl_cleanup_records: make execution of action easier to follow
>   - xdiff/xdl_cleanup_records: make setting action easier to follow
>   - xdiff/xdl_cleanup_records: make limits more clear
>   - xdiff/xdl_cleanup_records: use unambiguous types
>   - xdiff: use unambiguous types in xdl_bogo_sqrt()
>   - xdiff/xdl_cleanup_records: delete local recs pointer
> 
>   Preparation of the xdiff/ codebase to work with Rust.
> 
>   Will merge to 'next'?

Yes, I think this is ready as well

Thanks

Phillip

