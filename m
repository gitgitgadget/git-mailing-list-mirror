Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3A78821
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 19:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717702983; cv=none; b=aos8OQgim04x0Qxv63J7ts2lyBU6YrVzWPDq4yrc8OlG4GqtwJcC8nZW5x40KAT9NckszGiNTKf3DeBARAtIpHaD2E3FfA6rrB8fLpIjejUC/DV2y5qtBiL21og0n92JcGL6nM9DCdAo2xkB/GgvfB/jt33Aa/2FplfxHPaQPG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717702983; c=relaxed/simple;
	bh=5qWMyIAWfD/XyeojIG1+T0Fr+0AXd2BXD6tlPl12MnM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j633BMHsyWcSp2kAFwukl7VwEq2cosBQFROw4Ctmj6toF///BLLTDV8salqohKxVNam+sgioJ0tI68ifWIX4vnmr2RdI3dIqR+cJVcFYmmV1+r5xBrpcXXJxxPlvFX5SgkogXjJq/c5FiGupA6t5bWPM/X8CexQwXH3wwqThyy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BO3WxyGn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BO3WxyGn"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f480624d10so13207055ad.1
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 12:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717702981; x=1718307781; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q2aTorAgrZao2UyGpQNKzVCSp2hSQmv7nIdvq0OTWa8=;
        b=BO3WxyGnZxzuW5GCxrmS1iRsVo56HquLwDocCO5lEY2VsAvU/vq0uFA7x6AIehlgdR
         dJeX5gAauLW90bJlPly35RQ8Bn9AnCG26OOPJOFRSaka98m3YEp6ho3lLUxwqXq3Kvlo
         /n5rSu8TDRMa1nWaTzg0LMyIh864jFy4nadKYSg5UV4sVjKUH9r9183aQkaF9hDs391f
         4j1/T1bpe51Xvht6bs5tjUFmm2RD4cnbSs1KGMTl+0VDmGwHLGSKfEc0LFZSVxReHdg1
         1p3HSL5a6rhWrDcyLOwDosDPD1rZ05cbfs/JqV3tfe7ZJKgazb4YLFvqQ+KQSQN1YsKX
         AzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717702981; x=1718307781;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q2aTorAgrZao2UyGpQNKzVCSp2hSQmv7nIdvq0OTWa8=;
        b=baAxHKdKE2Xe99Io7omb02+LaX7wDmaMQ6WAja/dafqxIJdwYo7HwNwYdoL4UhUbo0
         mDGmMm6Z6+PQbMrzTlFnHCqjC5qW7HwdshxDN+9/Qeu08NoKOazLy70GmiyoBY5rPses
         dUNgehUBDy/smNQHnjG/a5QoFPz2ZjZb8UYDjc4BVqpEdQxidW84TDomtOXmm66Hk3Xs
         JGbc3CcNreyBdkWCanSwGRImW2zFYbRfnPsDwnoyd7QLSu7hU9g9LLEUOJPS159CxyRU
         rVNWXN8DRzIuRqLf4+gCo5eQjE6ONZvpqww+kjhVSN2XYwtrg7ZytARtn2R6ZaZ5pGY2
         TRwA==
X-Gm-Message-State: AOJu0YzliRM2QP1GXmBuSlDMNtutS8mRVsbY/SLYMJYgjJ6xSkzhl9Jl
	ouLnoTWTBsk0JVcRNtMgexVlYjotoCp1YCmxVcTaOq1BkybEXmNw
X-Google-Smtp-Source: AGHT+IEgWDr0IZ2sZONmhyEeAJTtFH2oKu9oixNRfS3kpaXzDc/rlhtwP3Ivy/sjFl673SnzfpoUDA==
X-Received: by 2002:a17:903:41cf:b0:1f3:590:71d9 with SMTP id d9443c01a7336-1f6d02d217dmr7512165ad.2.1717702980675;
        Thu, 06 Jun 2024 12:43:00 -0700 (PDT)
Received: from localhost (201.204.125.34.bc.googleusercontent.com. [34.125.204.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd771d36sm19083585ad.113.2024.06.06.12.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 12:43:00 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/2] pack-bitmap.c: ensure pseudo-merge offset reads are
 bounded
In-Reply-To: <0a16399d14afd527f4db63f2a4a3b0a3cbf112f1.1717699237.git.me@ttaylorr.com>
	(Taylor Blau's message of "Thu, 6 Jun 2024 14:41:00 -0400")
References: <a71ec05e5dc0c8c40e1cce14a7c5fe946437a24d.1717699237.git.me@ttaylorr.com>
	<0a16399d14afd527f4db63f2a4a3b0a3cbf112f1.1717699237.git.me@ttaylorr.com>
Date: Thu, 06 Jun 2024 12:42:59 -0700
Message-ID: <xmqqfrtpluws.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> After reading the pseudo-merge extension's metadata table, we allocate
> an array to store information about each pseudo-merge, including its
> byte offset within the .bitmap file itself.
>
> This is done like so:
>
>     pseudo_merge_ofs = index_end - 24 -
>             (index->pseudo_merges.nr * sizeof(uint64_t));
>     for (i = 0; i < index->pseudo_merges.nr; i++) {
>             index->pseudo_merges.v[i].at = get_be64(pseudo_merge_ofs);
>             pseudo_merge_ofs += sizeof(uint64_t);
>     }
>
> But if the pseudo-merge table is corrupt, we'll keep calling get_be64()
> past the end of the pseudo-merge extension, potentially reading off the
> end of the mmap'd region.
>
> Prevent this by ensuring that we have at least `table_size - 24` many
> bytes available to read (subtracting 24 as the length of the metadata
> component).
>
> This is sufficient to prevent us from reading off the end of the
> pseudo-merge extension, and ensures that all of the get_be64() calls
> below are in bounds.

Can table_size at this point be smaller than 24, which will allow
(table_size - 24) to be a huge number that st_mult() will
comfortably fit?

> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  pack-bitmap.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 70230e2647..ad2635c025 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -238,6 +238,9 @@ static int load_bitmap_header(struct bitmap_index *index)
>  				index->pseudo_merges.commits_nr = get_be32(index_end - 20);
>  				index->pseudo_merges.nr = get_be32(index_end - 24);
>  
> +				if (st_mult(index->pseudo_merges.nr, sizeof(uint64_t)) > table_size - 24)
> +					return error(_("corrupted bitmap index file, pseudo-merge table too short"));
> +
>  				CALLOC_ARRAY(index->pseudo_merges.v,
>  					     index->pseudo_merges.nr);
