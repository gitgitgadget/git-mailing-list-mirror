Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793830855;
	b=L4P0evRcDTe8rqAQEVad5EeY5iyaRQJroVeyljqatCIzhMmhOBiHWZkAv8cXGpb4nQy3
	 D7V+OPLUoz61a1BQnGrw29CBWQzbr0p9xPy+MDivpxtEwqMaIySjZqKYMN5zggPjn1XzX
	 F0Bqa4K/RVECHQTH3zUgvLrUk5xkHpv1YNM9jeDjSepoe/yFNHhnbKW5Cg7ODOAO0jG/B
	 T5b9TuPGKup7UTCVF4wjWgMvTmsEPthGU5ia5j6I7XtgOzkqj8tjbp+4ulVqp8OG2VVeT
	 YPjaM18gJfV6OiZ+VNY+ONYrpsCT6EIxd/ob4s+EmspAVTchMSNUYED3CoQZfwQrGbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830855;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=bUzTMZA+jOl+ojFkT16CFKEqhbxZLPuO8eVizD6g0A0=;
	b=oEIwWxvyzIPdSk7zlpBoltf8QemxcG6RA2q8lneHHB2xeDzQ/zyvAUTZUGlSxOM6KKxk
	 jvjr5wOTwYWHlLE3zJy3cnuH33pncVaC0CSojK9DlBn5ktVwHp5HbQBxwj1feoGHQyapB
	 /VvSzgcDrHmlxxJ8hRjcvs3q+q9Pyb27hw/ZK2Xmyz9JcpmBYal4KUuXjPtm85jP30jcQ
	 i+npi3VuMY2SpuMwsYLQsVr28ZoesH6QcaP30b3PZZZAU09LfMG1a8F++m88N79pEziuk
	 Hmr65L4A76mFzsBn4pRs98n60eeVHmlGdym0Fm6doAs/D8i94VOoQJcCERdJqhJ3Ohw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=Ssbw9osG;
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AAC606CA2C
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 22:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93AAC606CA2C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=Ssbw9osG
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-847ac7ccd85so758879a34.3
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 14:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793830853; x=1794435653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bUzTMZA+jOl+ojFkT16CFKEqhbxZLPuO8eVizD6g0A0=;
        b=Ssbw9osGoucc0AncgI3DFjT6tGJh4bEVvLyt+JJevnXqDDTv48nc3mFxNhX2Swekkw
         l1sNxzXcpjLIvykre4mb1GbrzHAXd0g1nyGvwRjiuB9WfPoMO8k0tIVyU+NWem9Gjhbo
         r8pvAezk3btjLwEgiPQNktu8AiPjUX7T86778=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793830853; x=1794435653;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bUzTMZA+jOl+ojFkT16CFKEqhbxZLPuO8eVizD6g0A0=;
        b=nNMcWa8f+oncFLD2JxCGFtycFk1FqFxPVFtL+yrRkmflX5Lcbme/FK2d98N1UWEMj/
         3iF7r0lZGD0FN2wWT106U4RQVVVBa+O3vmMu7WX6swn/EqPq94OpmcJrvd4sPrCguPJi
         YiUoLIach0ynw9g0+Jd+Au3Ityife04f9J53UqjuId5kWSi+t+hB3eluCjihCBU4NCKW
         PEWy21Ou6Fxk3XOFMttGiwu0Sd68znL7dJYMKsF/Xrp9WSs43OtYtWY5AIt9/UY78t5s
         Umh1OnWR6C/Y5DcpvbV+L3nIIq34soIv+V3A4X/WJkou6d13E32b7KullJrdd4RPwIpr
         815w==
X-Gm-Message-State: APuU4Z9PXNL2ezPMfNh0vex7yiZOZyTb3i4D1navDmZ43jA7j6rC3wyP
	sPWWxeeereGeJiQ0T2Cj3nnSkpRRick3UpH52gJ4CWxINeduTQ9igCwpHOzgDV/SCnY=
X-Gm-Gg: AYBFou39vJ32pJVo5yNUx5ze3HqYw8LpvzWchiayh6BmL1TCyGymOASkMeOtPheA+BK
	XqtTVMfZjGR4iZpe0n/NwuDtfBFSIc8VSxgqZJArwVJyFy+NGF7vCO1rUJvI652sYuGs6WviQzv
	q6obYCwomi3pU1yLMqywmF2qgatLci+PVqfgpPMAr4dZ5/1aYuw8R1KG44DxttcmFlrqC9uZTBj
	ZNW8M5qPuKsTkFLLr19g8kWSFZghIA0ZRhsjxBxj71KouhR/RrwYbdIMsyPaaxpzulHAgiuFsLg
	phJwpZ460Pi0IOfO1MWT0k6wCFSpfpa2gSmU1vwqlWxUzWU3AjR5uQkx+VqSSamAUo7EFi7n3Hc
	djugalLyDmcoG4E4xTy47ncjZ92x5/0jIdDyyKAlszGQDv+kX8agsy3+QKnOrJvsHTIo8bqLGY5
	OEq1K+ulaEiiDEUWaXcRVEfaYmZBHX75IWL+F99xJXgmnbPW/OnR7wDA5OSvo9nma/mAMay+klV
	3HAJykqJWjUwundmCnTJT1MsP/AgKvcxyKxh1+Zlarj0zR2b5gd1dW0lj0+++jLOTUjGEgw9BjI
	rBoSffMqlqr4b4fzQS5YV9Lq+Z9DQD5AbmG5GjuNdMSWJtm6sr1/L3PwWTZm1PEBO6bgfCgSxTH
	3dhyk0RvvofPIDYSz12HmO28bdrqQF69poXAAo3wueB6S295kRRZo5FzqTsiZu+Vn
X-Received: by 2002:a05:6808:6f88:b0:4c1:e6f4:f2c5 with SMTP id 5614622812f47-5640dbd626emr11485536b6e.2.1793830853399;
        Wed, 04 Nov 2026 14:20:53 -0800 (PST)
Received: from com-79390 (vpn-centralus-03.tradc-corp.com. [13.86.106.165])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567ab6a5270sm2580871b6e.0.2026.11.04.14.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:20:52 -0800 (PST)
Date: Wed, 4 Nov 2026 16:20:50 -0600
From: Taylor Blau <ttaylorr@openai.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] path-walk: allow revisiting paths from tagged trees
Message-ID: <auuvwlhhRpA0T2ml@com-79390>
References: <pull.2296.git.1793819268371.gitgitgadget@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2296.git.1793819268371.gitgitgadget@gmail.com>

On Wed, Nov 04, 2026 at 07:07:48PM +0000, Derrick Stolee via GitGitGadget wrote:
>  path-walk.c       |  5 ++++-
>  t/t7700-repack.sh | 23 +++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletion(-)

Nice find and fix! Thanks for looking at it, this patch LGTM.

Thanks,
Taylor
