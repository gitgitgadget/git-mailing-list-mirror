Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CD52D7BF
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758696249; cv=none; b=Ms2qHoH3sJGL69d0siGBrptN6CwJG+fbOFA2pTa/hEZv0FaXXmr/KmSpj9bkYoQCeRzL/I3HLHeDEw5tZ1TeIqICF4ZpgiNgVhJI/Ik6dSp4vDxiwPKb3FdGRPHb77FFDnoSRFo3wTSEkWRlIn18TQF7ei1SPQkdNju31mG6hPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758696249; c=relaxed/simple;
	bh=9bQa8Sf3j53UWOHxSumqjVnEV4G8xC/6Xm1T1Yzpvp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIoQ7HXlXZHjcCuDPrkZofLGcU4K9gCoSB0azkuZ8HtBUWVZrQbEF57N+se4cwZ7ojmKZ3tEy5uPUkeoltc1oaQfxb0zS7zhzhxmOiv04MoMDHXf+/2Xh/ZVUwxl8FXDgAjQVJOyGUZCB46PKqTuF3yvcE6c+ISg2HJ3SE8AvtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZwGn6wE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZwGn6wE"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e2e363118so2051225e9.0
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 23:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758696246; x=1759301046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+IzCaSMvEQ7R0qUhuGnUsHvS0Z6Q0GxFcD5Kfy0eRAY=;
        b=aZwGn6wEsTvLyXHq3GGixS9CSUHUF35P2HXspaaay881/W+AlseXKg8Lyh5NEq0q1S
         U27GtBVXAhqt1/WveKw/g6vj+iX1h97/eKmaPCocXr8QQ/3dBbLXPSUZnRG7ADq977ql
         /T970legCAkAQSP0ip8A4NO9Mf0cn6xmXBu1x6LGMHXAVoH5vuutP/+6OJ1NBUXn8CMx
         1X94MxaEQu4RxHSoZvOW5kuiW3suQHDcY3uiboQq2M0Jks3DgHnw1yrjzS1TR8IJuH5w
         5DHWbPJG23OaEScjVAP/PQSp/Yze8PFulmfrnKuIK/d6CCavwlNp/dwC3lnYxpLvJhw0
         QtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758696246; x=1759301046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IzCaSMvEQ7R0qUhuGnUsHvS0Z6Q0GxFcD5Kfy0eRAY=;
        b=SzpnrttMExq7DyXNMS3kIKhMak2t+71vu4axFzLcNTGBzxgb6yx55mbMBJgtzcVnmh
         FOb0pE0ZJ1/BLpVyJrrFPrpy9vlYBdAimKndwNuhxWsFLiAh/uGFf6GTk6Dz0C/qaFxS
         DtgiQ09HIN9VuyyrLkXQzPJhBOHhcy/Msdv1jlj+VM4hosDBwu6Yau+PYe9ZTq9vXQNK
         SXO6/KEift+nVhz5kiSuD5QiPIGTn4t6z6ZktHbjHG6RNt9J9Ky3yxXt79qfbXxCJgqN
         AthvB0oxMKFcrILA7j+exVWazPnJGjpIAA9Du25gorFADqbHT/kw8KVSDeetS4+ZDsu2
         5ljg==
X-Gm-Message-State: AOJu0Yw4eQMEDxkANOmoF6YSqgnm3JvPLRN4VVIBSp9n24DWbMuEWRAO
	CxLw5SREW2/5qxCqPJB14g57VJ5v8tBSbOhseeRvlC9Wxp9WtgjsbMyPBn6ILg==
X-Gm-Gg: ASbGncu/l3B9abICz4w4ebrEWLjxeKdHVKiqbyINf4o+OTWAiQEr5zpmpN2fbLR3p5S
	BXZ8PixGns2MyuLyGoQmVQJ+csD+H9mN7FDrIZjLlZKnjAJKlggVohbngYvy4puWR9TmjjdmcWa
	dW9sRkLjkMQD+mRwfOc6e6mXmiwx+LMDfZ4ICxaoM4vC6E8QCc7JZL8JBoylFuKXl9ayAfcKLSj
	1h7eQvuiaQ4TS8Qkarr6P1nfmCC05fnOyWu9G6GgThYLbv7UN07zd9r6QRE+p3NHixM3diEyHeE
	5ws/fm5iEOseXMKCRqaCLMejumPztsVFcH3ACe0DGxjgvngFp+CU95EqDhfCtrSmCeJKTlitT4q
	Jd+NCJ1EUy1EassE6cXYlmu4VLPwXPLk7Nh60w0fbx3YFZVZinTRNa1s=
X-Google-Smtp-Source: AGHT+IHyPaBBwOM0+zTlX8+UfqmFlE8ssK8tHoX4hjjGXKsNNlIOygBPoux3k8pmuxFE2aSrK/crTg==
X-Received: by 2002:a05:600c:1548:b0:45f:28c9:4261 with SMTP id 5b1f17b1804b1-46e1dab6393mr46217835e9.20.1758696246170;
        Tue, 23 Sep 2025 23:44:06 -0700 (PDT)
Received: from localhost (84-236-109-231.pool.digikabel.hu. [84.236.109.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a998314sm20769735e9.3.2025.09.23.23.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 23:44:05 -0700 (PDT)
Date: Wed, 24 Sep 2025 08:44:02 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2025, #09; Mon, 22)
Message-ID: <aNOTMtVC0ArCSTRS@szeder.dev>
References: <xmqqldm6qehe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqldm6qehe.fsf@gitster.g>

> * jt/odb-transaction (2025-09-16) 7 commits
>  - odb: add transaction interface
>  - object-file: update naming from bulk-checkin
>  - object-file: relocate ODB transaction code
>  - bulk-checkin: drop flush_odb_transaction()
>  - builtin/update-index: end ODB transaction when --verbose is specified
>  - bulk-checkin: remove ODB transaction nesting
>  - Merge branch 'jt/de-global-bulk-checkin' into jt/odb-transaction
> 
>  Continue the work to build on the bulk-checkin infrastructure to
>  create many objects at once in a transaction and abstract it into
>  the generic object layer.
> 
>  Will merge to 'next'.
>  source: <20250916182938.2193476-1-jltobler@gmail.com>

The merge of this topic into 'jch' modifies 'object-file.c' by
replacing a call to reprepare_packed_git() with odb_reprepare(), but
at that point the latter function doesn't exists yet, as it will only
be introduced in 'ps/packfile-store', which is merged later.

Interestingly, when I tried to recreate the same merge I got a
conflict only in 'odb.h', but not in 'object-file.c'.


> * ps/packfile-store (2025-09-15) 16 commits
>  - packfile: refactor `get_packed_git_mru()` to work on packfile store
>  - packfile: refactor `get_all_packs()` to work on packfile store
>  - packfile: refactor `get_packed_git()` to work on packfile store
>  - packfile: move `get_multi_pack_index()` into "midx.c"
>  - packfile: introduce function to load and add packfiles
>  - packfile: refactor `install_packed_git()` to work on packfile store
>  - packfile: split up responsibilities of `reprepare_packed_git()`
>  - packfile: refactor `prepare_packed_git()` to work on packfile store
>  - packfile: reorder functions to avoid function declaration
>  - odb: move kept cache into `struct packfile_store`
>  - odb: move MRU list of packfiles into `struct packfile_store`
>  - odb: move packfile map into `struct packfile_store`
>  - odb: move initialization bit into `struct packfile_store`
>  - odb: move list of packfiles into `struct packfile_store`
>  - packfile: introduce a new `struct packfile_store`
>  - Merge branch 'ps/object-store-midx-dedup-info' into ps/packfile-store
> 
>  Code clean-up around the in-core list of all the pack files and
>  object database(s).
> 
>  Expecting a reroll.
>  cf. <aMe_Zu1osrfDnSYL@pks.im>
>  source: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
