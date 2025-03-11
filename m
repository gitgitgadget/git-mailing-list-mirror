Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EF6208A7
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704411; cv=none; b=ZyWQwyjwc57ajZwDQM27kj947kfCwQ9WVbI1mfBX1tB7oNXDtFZew/8rBN0viBpbtDMdEFvLrlm8thsnGYZS4oGdQC5+gwDoDmv9y/o7mB42VnPhp+9EQAWqGYtjUsEt9ny6jvuscqrsjvPhu4sw5UpzDSoid2OMjSQ2bSDDGRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704411; c=relaxed/simple;
	bh=HdGMJUDQlgF30cMuDFkfY0kvbkEyMJEI5TEKVy4T+bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enq5dlk1SvrAV6BHxPwpbIin3IuLfb6uTtkhIDe8rhZ6gNNcI/EwDjYJtBfdWh16d4xhMcgNgwPiqSKq0qLdbyZWCZe4AgePiNVaBl5P5hSfFBPd7zwM/teZcEQPqiENxPAFDtN6y8Mpf0KdI2ZoqHYNmpKeMPKfIQeQpHpkLDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1KN8jg1; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1KN8jg1"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff797f8f1bso7604283a91.3
        for <git@vger.kernel.org>; Tue, 11 Mar 2025 07:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741704409; x=1742309209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O1VhZNEvt7yJAv4R1Pw/JF4yI9MqNzw31JMvRLdCd4o=;
        b=F1KN8jg1Du5T12/lAkx1rH0CTbZw/9PitoMCtg2aDRs1n/t3mqT5NwEECuNNZXClAk
         S7wtyZdwg4RenrSWIwQ9RSme6CElqN3ZSSO35dp1A0UmHVwYfhWMlJKlRzax/VJRuyaa
         /POnHKJMMUgbbFlR2VuLkApVrQL8kv28lG58fj3xOBVJwKgQdgbGtBpnH3UVbFCKZFLJ
         6kzlopGJhyO1LtGPzEkacJn/I3ex+QgKWGO+yKNdS9aeZZB/5ovyBskDw8XYSvDeKyCc
         u9mDwadjXmcicuWF6a94sBAXyQvqhFP1rB4HUFIuboxzsyeJVW8iBk8Lto04YWlG827M
         lTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741704409; x=1742309209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1VhZNEvt7yJAv4R1Pw/JF4yI9MqNzw31JMvRLdCd4o=;
        b=T8Te5xxw+9a57dKZaJcyGsT/NKYgEMBIFG32cgkEQK8jR4AQcFUJrwBNJMpYsv7wd/
         0y6NFguT3S/DGmrCb5OygW6sfQNymfOYePtUx0ijBLz9MBV7J7Zemt6gjk5uj9QuiBV2
         2WbqnpsCwgULlSYm560wzJT2B8ZT3V0O9G2t/VAkxr/u6ruoEYev/g0Z41uUiWOifYlb
         efAaiFbmtedCGiQHcjyGFmplTbemt2MnaCfh8iMRNUykhv0gfgVnW2YzuD8OluUSiSQj
         cft8zDCNpM5ZBRS0Y9THU9vqZRu8WoA+Oytafpx0zkaTexseoVHQfqSDgsi91favgNfh
         1UYw==
X-Gm-Message-State: AOJu0YzP1FHUh7VrdGz23UWxzt55mQJrRncScPFUL3Zyd3LMQ6lWPv0S
	yqGhc5OSWCKuJjYa/AAOPt4pEwo36q+GJzAq62bGon49n+BUruEa8LKgdSDFkxc=
X-Gm-Gg: ASbGncunnlyhvZZJwaAaG+y7xK1o3t8S6MAxl/F1nxb3xDXAxwYO55Z+A0nQ51tt6Po
	sS6rcoXiOVZqGZoz6vRXPcZdhRPecEUMwOw01Q82L1SqsObws5Dgx4NBoD5I/RfFgbO/zd9uGHy
	xZpewyf0MUnKAmTC4Y9y9tBbceDuxMgFCEfWQl4nmxq5FW08FVmJzPeBk0yQ3JFmzbhgIxXtBp6
	dP24SoSLPgEEp38ZbSaSUegKsVgVJkZ/tihEAYLCE16IGr/zITtMRHR3G10jYOZnX4iphxANURu
	b96wucoovaLC9G+1ps1m60bW6jZVbPD40dvvJXWP
X-Google-Smtp-Source: AGHT+IGRriIQNlSgFtM1+ZAiG8a1vTthcLXOA+aqnO7SLsZiydXVrNZG6ZyT7COt36JktMKBoQBVhQ==
X-Received: by 2002:a17:90b:2792:b0:2f8:34df:5652 with SMTP id 98e67ed59e1d1-300ff100773mr4847321a91.21.1741704409053;
        Tue, 11 Mar 2025 07:46:49 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ff693e75bfsm10054657a91.33.2025.03.11.07.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 07:46:48 -0700 (PDT)
Date: Tue, 11 Mar 2025 22:46:58 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2025, #02; Thu, 6)
Message-ID: <Z9BM4r2CUG1kF_Yo@ArchLinux>
References: <xmqqzfhxfym4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzfhxfym4.fsf@gitster.g>

On Thu, Mar 06, 2025 at 04:55:31PM -0800, Junio C Hamano wrote:
> [Cooking]
> * ps/refname-avail-check-optim (2025-03-06) 16 commits
>  - refs: reuse iterators when determining refname availability
>  - refs/iterator: implement seeking for files iterators
>  - refs/iterator: implement seeking for packed-ref iterators
>  - refs/iterator: implement seeking for ref-cache iterators
>  - refs/iterator: implement seeking for reftable iterators
>  - refs/iterator: implement seeking for merged iterators
>  - refs/iterator: provide infrastructure to re-seek iterators
>  - refs/iterator: separate lifecycle from iteration
>  - refs: stop re-verifying common prefixes for availability
>  - refs/files: batch refname availability checks for initial transactions
>  - refs/files: batch refname availability checks for normal transactions
>  - refs/reftable: batch refname availability checks
>  - refs: introduce function to batch refname availability checks
>  - builtin/update-ref: skip ambiguity checks when parsing object IDs
>  - object-name: allow skipping ambiguity checks in `get_oid()` family
>  - object-name: introduce `repo_get_oid_with_flags()`
>  (this branch is used by kn/non-transactional-batch-updates.)
> 
>  The code paths to check whether a refname X is available (by seeing
>  if another ref X/Y exists, etc.) have been optimized.
> 
>  Needs review.
>  source: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>

I have reviewed some patches for the earlier version. This week, if I
have bandwidth, I would review the whole patches again for this version.

Thanks,
Jialuo
