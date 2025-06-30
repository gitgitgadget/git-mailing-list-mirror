Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5806D19F130
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 18:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751309269; cv=none; b=DT8IvdGNpNgCKtC2sZgZ0y/MTsLLgwXX2l/yDUs9ljDwxE3cAzOuVQdp6fpjSMhKyPEp6SmQTVbFPWVQLICkcH1Zi9DU2zZwqOOUEjSRDxHkLlm/9rZa+Tls2NPPPhj4bTfJUYfo9ba4p0L/vHxYofblOvCMsCQ9YoajQsaZdlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751309269; c=relaxed/simple;
	bh=IMgBdvmZI40Abg3ff7DqFtKa74ReuW0RD+vJC90NrQs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kON4r1vJs1UkZ1NG94FDijhNmtYgP0aWcSyOMXpkk6mLT5sKyxNrYdTIOTwSxlNJPnd+UQ5sKWMG+lmXZ533fInGY07iALclIRkGZ+Nmaw7IE+Y6Q6GmfR5XfR857kogedN3riDepewJsUOy4riqj+wEVCsZ6jqyvxnh/hZudOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnmYQW2K; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnmYQW2K"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235ef62066eso57889495ad.3
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 11:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751309268; x=1751914068; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NWDochB/wdko9TC+nNi4l/p0lqmfqr+n3i7RIOxrIaA=;
        b=TnmYQW2K+eOmN0J7DGop2OK8Drhgxc4J8QL3KJkRfE0/yZY9HlurOm6TH+lbwOYu7y
         Yd6c1sANOTnvQKKy0kcgTpOh0AAKOKs/DYKnDJP3YgxAwZmf8toxLBiN3vzgvR8wQi6a
         c+2wdS2Gz9Dbi1x225mmQDNlkTx70U3T9akiDkwdu/8SLDTC0MxLjNjUB4qS0RL8tDcE
         VMCmfiegLc1K5ntB81SjCyuiR8xXJjzV589cRX5gf2jRbdJrNR11yEnXslEVBVgIpxpH
         TmwexmjosZrsvYaVWTOxL4acZxpYHSISmi4bIE860GJginorcSm41cTx36aNK0oooWbz
         TaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751309268; x=1751914068;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NWDochB/wdko9TC+nNi4l/p0lqmfqr+n3i7RIOxrIaA=;
        b=omGlviNE1RzSjnEP/yPdMSKmrub3BnYM358VPSJnrLlko1HdAndtJKWpfsxFH+JMjh
         455o9A5l/kcu/UCJ9pq5lW87lDus0Hwe1eHCn8DCdUYQUH4lZxuFx+cLCy+DPeZO1tDF
         tWLkplqBVG96MnnzHtJEoel8I/gRrfqZ0qMmwnKLDquD+qCB2gSz6cUFjyMj+oJOAWy+
         Dn2PajckPD3/+A6tKe5vXpwCi55ZVDifGWePO1lMBP29VA3V4SkkJV2C4ksgpCa/qY4C
         qtGOf6pDnsp3wNj7EDXuXNCoOepFrJj+UaaoE9E0DsqYXeau7Tj5pMJOeEczYc1KIX/3
         cbKw==
X-Gm-Message-State: AOJu0YxL3j/iywTuyR3V7gwDaulaKaGH4r3Xuz8Tbdh90bfvxroY0Kdq
	rMD/4BeaKRDlAnZpFJ1IOIbj9l6ruzLxoHGCPx0ero2gSm479L8oJjvP
X-Gm-Gg: ASbGnctBdLlTJHXyhe/vAdaXDTamPvAaDjbWVckTZ3BqnIpe350V4C5Hb/y7pTOR8fa
	ghNHSI+rDOwQLJxW4znbATOZbMt6BrJVV3oSt3QYXzSi6OD76+Jyv2MrUZ5BhZfgJDHUdpVXNKL
	46NdX69acx/l96O6FXf4W9qJVXdBuYrp02WQ4V91rewrTb0hfsYezDlO9ecRcxgmmbHgVe+Chgu
	vWy5Cg29dLCoEvYBMuRIVLZ8ffe/NLS9foIifeT0ot0M0Vr8WeTL7ImZLXhYt0kCMipzEXhvHb8
	CKNLAp/liyLIVpuWEM3INZsjCBOrQmcoyO0Q1zXS4e+adtRbG68BJvLECV6/7Wc1XIyVqUgZmBn
	Nh1NN46hm0LSuBM2NSlMsW0tuKJA=
X-Google-Smtp-Source: AGHT+IGRUqSotnzEYcE9QHx7PtIWubRbpgx/fcjMc4ljQ5bpN4lzsalSs3/RKFCC0PPIgdG7wsNYPw==
X-Received: by 2002:a17:902:db02:b0:236:937e:633a with SMTP id d9443c01a7336-23ac19c79c7mr230609215ad.0.1751309267522;
        Mon, 30 Jun 2025 11:47:47 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb2e77f1sm86863385ad.17.2025.06.30.11.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:47:47 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: "Raymond E. Pasco" <ray@ameretat.dev>
Cc: git@vger.kernel.org,  Ryan Hodges <rhodges@cisco.com>,  Johannes
 Altmanninger <aclopte@gmail.com>
Subject: Re: [PATCH 2/5] apply: read in the index in --intent-to-add mode
In-Reply-To: <20250628225819.1294068-4-ray@ameretat.dev> (Raymond E. Pasco's
	message of "Sat, 28 Jun 2025 18:52:04 -0400")
References: <20250628225819.1294068-2-ray@ameretat.dev>
	<20250628225819.1294068-4-ray@ameretat.dev>
Date: Mon, 30 Jun 2025 11:47:46 -0700
Message-ID: <xmqqbjq512y5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Raymond E. Pasco" <ray@ameretat.dev> writes:

> There are three main modes of operation for apply: applying only to the
> worktree, applying to the worktree and index (--index), and applying
> only to the index (--cached).
>
> The --intent-to-add flag modifies the first of these modes, applying
> only to the worktree, in a way which touches the index, because
> intents to add are special index entries. However, it has not ever
> worked correctly in any but the most trivial (empty repository)
> cases, because the index was never read in (in apply, this is done
> in read_apply_cache()) before writing to it.

As the inventor of "add -N", I think what "apply -N" does may be
wrong (only judging from the above description; it's been a while
since I really read the code in apply.c).  It does not make any
sense to write a new index that has only the ITA entries.

> If we merely gate read_apply_cache() behind update_index, then it will
> not be read when state->apply is false, even if it must be checked.
> Therefore, we instead read the index if it will be either checked or
> updated, because reading the index is a prerequisite to either.

Makes sense.

> Reported-by: Ryan Hodges <rhodges@cisco.com>
> Original-patch-by: Johannes Altmanninger <aclopte@gmail.com>
> Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
> ---
>  apply.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/apply.c b/apply.c
> index e7856ae6b3..1757d34618 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -4837,7 +4837,7 @@ static int apply_patch(struct apply_state *state,
>  					       LOCK_DIE_ON_ERROR);
>  	}
>  
> -	if (state->check_index && read_apply_cache(state) < 0) {
> +	if ((state->check_index || state->update_index) && read_apply_cache(state) < 0) {
>  		error(_("unable to read index file"));
>  		res = -128;
>  		goto end;

