Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E76833F39C
	for <git@vger.kernel.org>; Wed, 20 May 2026 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294125; cv=none; b=RjpRxYq6zVOWoE8vVCli2+Ata8SeY5/QbL8jBUGAVphpqeD7vGV+RnAixW0xtTmLzJiMS1biShWE22nb2cSSybNTCWF1qQEvhSk6Sl8Z4E5dJ+kPHx4uXg8VpbrmAn3EG/RevrjSPbfvxUtVys6aM1sxpN251uoJwOLRc5r2CiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294125; c=relaxed/simple;
	bh=tf/lS9K3wkUlURSXGJFISANn4Ef6keEEUmVFT7CKvSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NzxUcfOvXtJmITqJCMEUVThDwzfxfkMBIIGO7/qEwICACcj9vn+FZW4jh/Thz7zngsLAojGtC6rdcaQInyS0DtY6S5EQewcw8xb2bo4g5HTwHS42ZVtwbnSMjjXab6C+0uJghsRD5LZqaz0wGzUVoX9xUggqhSPvpFVyC85+Ynk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYg7qohF; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYg7qohF"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5102582e23eso40913871cf.1
        for <git@vger.kernel.org>; Wed, 20 May 2026 09:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779294123; x=1779898923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bu5tSazerJBpAHgHqgSAfDBcu4TL+tONtBMcKI/27WU=;
        b=DYg7qohFyXH4J5pQIxhKoA0SZQNOfkoCwMX6Jzvudo4uIVE/dxJD/FS+ldHAtyuoH0
         lL+XXFzQpYXYn2/xQrTuHHleYo0FEMpPzrmblOaQmYykjAd+lLJ0iS8z3vQGeX/t6VgE
         FnSyh3mhk0afLMloQHAUOSe5iqITwcdlvqzri+hCpleomFiUx2yOdBTK+KCcLPzU0qLt
         WrDdFbufJ7hOwy6S52TnJeJ92G0EnWM+3poVc3mO62ecjrBDzeiYBfTRYO74EwDcmCyC
         BN7QQPRGcRtaP15afaLPfMbb0RJtdV4903knl58BsDygoyaUjKSCHFp9IexF/SQ/MgaY
         7ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779294123; x=1779898923;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bu5tSazerJBpAHgHqgSAfDBcu4TL+tONtBMcKI/27WU=;
        b=X4BZU9IWXXUBFdH3UymaKP4CQEEh5LeW+bxKJv5V+Ntmd/JRZOLK6zEgakRlGmFb/0
         D+cNL9bxY9hu037CscXsprO84yVGkbIbNkWCq+OAh9FI+1y3psRTpIULPRwJx5mXzddi
         16Z63F3YklHgrMoYvygt15YVkFq1P7DmX7pRaQjI4Lq5KIel9CILeewW6px5zMHmvdv7
         7UQwspPjtylp1VldzO7AnG3RJIG9f3qKvTgRksaVmosoL98JX7YCNLLiCuJN7Dzh0pcF
         qYLqMU6psiDkyNXNnlqQ5liTleBz9QNBXseuMBEXFqa+784f+7bzMDhjcXdxacisJnDx
         fArQ==
X-Gm-Message-State: AOJu0YzR84H6SlJCu9S8/gUpi0otOBghAEGirJpRcuvrY+lPRZXFacnv
	B4wLRHlbxUhA7QpZTj92QTEWJvvmfJHug6cG+sKRmBN+I8tUpL0pOldZ
X-Gm-Gg: Acq92OEwbAF443NPkL4M+LYJsMQxE/2hUDUqy0ayXyRLcV0mIn/mKN7GeRyuEmm9hIy
	/WIVv7Y1Zt2lCufV5JOhJCPv4Abl6L1Hhmh4/qmO+yUe7pQsw6liltLMiyPge/raIrsMzMX8IOr
	7OIRBZo5iyR3+XWtXoRBP2jcCVpBQErZ/XpVVilhHM/FwlVAoUQ9zB52x2HfySytBfQnMcrNE8n
	1HdkDPGa6Ty6h2mlyP9KHSJf9Mi16sMoI4HHvhsKKluwqwyd/bwbmql0uXP39+ByPaRgBcdCX08
	EC6TVnDtTSS+vqCZ2JfsyIMeZRXOSRWAtdVt1l0LLQaNrRLUcJqHH0TeDU4tEiFpOBAHy2qihIB
	wjCcruGuHXI4lGvlwmh1zp8oCBGLx6mFQKw0VEPbfMUHtJ5G8ExSR/CbGe7aEqo3C0NYQwXqRc9
	/M78z/l4RoILlSWgS3puZ1sqyYDULxiX7uD+H9n3Dq4YVGDLFjfWDIfuUZ62QmGUeRAKK3uieTQ
	s96F2pH
X-Received: by 2002:a05:622a:1e13:b0:50f:c8f9:d5d9 with SMTP id d75a77b69052e-5165a1e7bdbmr325735181cf.39.1779294123166;
        Wed, 20 May 2026 09:22:03 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51645687d30sm208088461cf.4.2026.05.20.09.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 09:22:02 -0700 (PDT)
Message-ID: <478ff417-d5d0-458f-b5cd-472373eed7b2@gmail.com>
Date: Wed, 20 May 2026 12:22:02 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] commit: fall back to full read when maybe_tree is NULL
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Rasmus Villemoes <ravi@prevas.dk>,
 Daniel Mach <daniel.mach@suse.com>
References: <20260519050513.GA1635924@coredump.intra.peff.net>
 <xmqqcxys7xi4.fsf@gitster.g>
 <20260519061534.GA1709881@coredump.intra.peff.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260519061534.GA1709881@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/19/2026 2:15 AM, Jeff King wrote:
> On Tue, May 19, 2026 at 02:56:51PM +0900, Junio C Hamano wrote:

>> Looks quite straight-forward.  Don't you need to pay attention to
>> r->hash_algo and call parse_oid_hex_algop() instead?
>>
>> Or are we pretty much sure that "r" is always "the_repository" here,
>> in which case parse_oid_hex() that uses "the_hash_algo" would be
>> sufficient?
> 
> No, I didn't even think about it, since the use of the_hash_algo is
> hidden behind the function. We definitely should use the hash algo from
> "r", since we have access to it. I'm not even sure if you can have repos
> of two different hashes loaded in the same process at this point, but
> certainly it is the correct long-term direction.
> 
> Here's a re-roll with the one-line fixup:
> 
>     diff --git a/commit.c b/commit.c
>     index cfc87ad185..499a9602ad 100644
>     --- a/commit.c
>     +++ b/commit.c
>     @@ -448,7 +448,7 @@ static void load_tree_from_commit_contents(struct repository *r, struct commit *
>      
>      	if (type == OBJ_COMMIT &&
>      	    skip_prefix(buf, "tree ", &p) &&
>     -	    !parse_oid_hex(p, &tree_oid, &p) &&
>     +	    !parse_oid_hex_algop(p, &tree_oid, &p, r->hash_algo) &&
>      	    *p == '\n')
>      		set_commit_tree(commit, lookup_tree(r, &tree_oid));
>      

I figured that this was already tested via the test variable that
runs the test with SHA256, but the multi-repo case is an interesting
one that I'm sure would catch us at some point in the future.

I'm happy with the re-roll here.

Thanks,
-Stolee


