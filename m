Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD49516157
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792218; cv=none; b=gpqWuTBPvemRPMTI4tVldfRuq1iRTNXhq4eM3rKgjfv0wAkHVxcyh/hwvwQT3HwPM/K1M0mNCBujtwxYtQXodi6l2R+378e3b8wa0ot7t+JtT/ha15IUitRSINb7cL5Xpqw7Mhbp6OPWioCFKC+H4VHIJlTam5BX8mJjc/diEEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792218; c=relaxed/simple;
	bh=R4pqPAJGACrYO9QVsH9x4Hwtvsdja/L7KkD+Q2qqZgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=utxmdhiYUmVUqeRi5M1uhIGDD2dOh1t1KU5FwF3TyigqbyfDG76BPXWsHvxXl6jSevnHQbJ1PxPm9KeJ1UdvOwxurUdlpJwW+tD5r2poriUmp/1mLYo8u2iLduc949TJTyKXdXXnyOBMDndRvPuEDdc9P/BviDC8OVHOUdAim44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgjD05Zd; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgjD05Zd"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab201ebso5511393d50.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 11:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790792216; x=1791397016; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ukuw0CPFAKtJfNvPz+XmiW32ozIRQyaIj8sDWKVi0k=;
        b=dgjD05Zd9Z1a6x4sLs+WR8DGt8KX/Be2adXsscZd1Uozh0GMfI8dGAHPG6QoMiAAwO
         NuTaUh4lQTaM3nXWkhUXlynG1Hl/HxkY681TIYy2yeB8vWoWwszsT+UWq+iq6unh+TW5
         52UruGIF223kDdVekJQgSRN+3wYYsJOo4yc77AWhM6kMJLzcNyNML9q3SBEvG7pxkJWV
         2EjvLRIwu0UpvS1puVl95mD+QjL9QpC4bC/aFoSSnaTwq+fbtN47EKoIGhXGSgBBUgnb
         mUrlHop+n090TbkKzJoW+hPqDRdeywgUNK5T6rDoZJXbBr1Ayk+XLBb95C8OOTNOJuyx
         3u4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790792216; x=1791397016;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ukuw0CPFAKtJfNvPz+XmiW32ozIRQyaIj8sDWKVi0k=;
        b=Qx2TQGrFe3p31rfNlfCH7Bu3nlKmggqBh4ZnZEpqVFRaNup5B1Y7hzdqdd5qutNU0S
         prwkP4lTx6+jya5I9Kpeqzmzn7Pb4q2Q/XXsAeeRrdYYP6WirQN+38Pr/ehzrEqqBcjq
         sJbYZ9liLRLS4jlN1OvWcsdOUyRO3EFU5aBhEOqk9gGgj3xYrPl6uompSpTlaJmaeVPu
         w/TxFjhxDauRuhmR51FSdG8oP8EEoL1ZvlUjWuAq2OcUpT2HqflffwCygFXBTYzsnjDR
         a5ZZSUwsFcPNOTkW4jTPFSPgk6Nld85J5dsJSO38qA1lxQYqeA/Lq+cjuWiQ+RxdeG6D
         iSOQ==
X-Forwarded-Encrypted: i=1; AKwUvBwTbbN/kzFreAn2nErMdFoIa+2TQN9dx6Dd7R7CT4jqj4tsA8jrfUm5FBMi81JchAQg7/w=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWQQR77Yxl77Umm7cUZ8fqTDa/wkssvYpUCr/OzZ32AMPnPY/W
	h38mbO0pXOBLMXaNX6UL/1U3CyNu4OPQ+VKrXd9mHyS2r2sh8rzXzPK3
X-Gm-Gg: AYBFou3zl3sLKbF4dfzKqVHWole6uRo9NRT/m9m+PbkJg0RgdxKedTt4Gp/SKP845Zv
	L3OJ2EqyrNAUcFilZSO0B2emC+EwEIAm16YB1eDZ7dPMW//KnTfvJ32W7cBJhby3CRKonByPsqE
	d7B32NTxcIvHBahEk4G3YcsSxHFEowgeHoPHs6+gr39Zk4fG4qIATmEkOKc5xMrAX34oIUA4EQZ
	0tzU62C7x7pTyZ/LqtuHe31ap+PdbGtk4a2TkfCNF90+J8X2ClRnyFpO9r4sYkr4n7ICvcJ3akn
	BPy9HdGrWPdn5Rl3Z4LVLNhEkCuQEc0FKWODknviCRP76chHc8Z3Qvs7jGXsLFXkiVD25I67f8H
	aG4U7WxT7wTWnGSKIADUA6Bh0wtdnR8Yf0Yy8aZPzjLQcLVeAAyT5RFl35ZQq/zc+p13ZJC2Ijc
	1Exh1zBEhpKn7OsCjjrqNOB67rtvMnJjumJSaJMPyH4dKsMoCCu6azvyOo5J+VPC0xFu7noT+Ij
	pHIGt9YkBMol/RBZInXMD3bvr3Biq9qOdKV1qxUE2XEzSX+c0oXWBcwfzNbAHztYa7GV+IE5vmt
	iXk5Yc00zYTRKbeZw6c0LZhdVNfu4MCmQT06j6DTCT075Q9CLxus91COYrSYxNEBu/HrRTMIHoB
	0t6x0ciW8oaODnhUGxMmVEhlwFevLBhfoK0A=
X-Received: by 2002:a05:690e:4804:b0:672:d16b:a500 with SMTP id 956f58d0204a3-676834673edmr598308d50.71.1790792216108;
        Wed, 30 Sep 2026 11:16:56 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917a89f6881sm5420096d6.24.2026.09.30.11.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 11:16:55 -0700 (PDT)
Message-ID: <a78a38ca-b08a-4194-b17c-b8802e4d43a7@gmail.com>
Date: Wed, 30 Sep 2026 14:16:53 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] pack-objects: ensure tree/tag closure with
 '--stdin-packs=follow'
To: Taylor Blau <ttaylorr@openai.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
 Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
References: <cover.1790731662.git.me@ttaylorr.com>
 <6348667e2e3fe63aeb139888e877dd8447570253.1790731662.git.me@ttaylorr.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <6348667e2e3fe63aeb139888e877dd8447570253.1790731662.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/29/2026 9:28 PM, Taylor Blau wrote:

> Add trees and tags from included and '!' packs (and loose ones with
> '--unpacked') as roots in '--stdin-packs=follow' mode. This rescues
> their descendants even when no input commit reaches them. Walk these
> roots after the existing traversal, preserving the `SEEN` bit to avoid
> redundant traversals. Ensure that the walk takes place *after* the
> existing traversal so that we don't lose the path prefix used for trees
> and blobs wherever possible.

> @@ -3807,6 +3807,7 @@ static int stdin_packs_hints_nr;
>  struct stdin_packs_context {
>  	struct rev_info *revs;
>  	enum stdin_packs_mode mode;
> +	struct oid_array extra_roots;

I believe this should be an oidset to avoid adding duplicate objects
that appear multiple times. The order of these extra roots doesn't
matter (such as in a --topo-order walk). We only care about the
binary "reachable or not?" question.

Thanks,
-Stolee

