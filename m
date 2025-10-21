Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AA232F75A
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053321; cv=none; b=ALia/Ga890Ugwbk28sfohuYYk4Uv0OETkuUHvymHY8HkqpW8R8AhzO7EftOFnscuf49ay/rZLfKdlU+kIb7ivwtj5Kir7Iu1CCrZj3zRM9vJPa5QmxmKujHsnron7PxG8PQIIAHc7hYz+wsDyXikqE/IoeEVRaiSPHPEmOu0BDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053321; c=relaxed/simple;
	bh=UGdLFKN6ZgWFsVI8UdI/nBj9vHPIcUARwzx5d3oAbhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q6l97tSwh3ZmFoglDTrXLV1pN386foUlw6YSNRtZJmuNhY5D4lq4FfYWALKrGfLGT3B8cfwmZ6yl/22/3BG0ocZHTCX7UJRaLHyEcidc/DeXUFf2rrS66OIGRIh/Dvz6JHYQgGWv0HFwgc3MdvN77hXzCZPrxPhVGn680OQqzrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZV9jqMXg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZV9jqMXg"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso41699805e9.0
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 06:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761053317; x=1761658117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=58htuMbomCUUyu6zZHc905shaLwq6Fyj8x2ALPzg0Hs=;
        b=ZV9jqMXgDwWCNAYHSeobvbzhs9F9550P6X3WIw13xYOEQf7vcGoe2Yd5jnPtPDZUdF
         BhFTPBFAriAl9p6L0gYfZFHwuxqaYriyoEEydZMJDOP/IPB47XmfW+VJr/VbtG22DQ6R
         GpmCwOLUfHbJjOCrpX+YnweAmvOLe9oDwT9ToQdVjzjtdLOrcnTemZrzcnuCuvWheXCO
         NOj+etFl8DoNTiOQ33KtyxXglrQxjfEAXqrsjUdXp2k/n7SopkOPnbfz/B6ppRghCwa+
         2/g+AQ8iPQOAb9eiVIPTAHQbNgLfqWdkd6dCqEQh+87VPUxrSq7HQnQ8fVCnlgHTKlqr
         1SDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761053317; x=1761658117;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=58htuMbomCUUyu6zZHc905shaLwq6Fyj8x2ALPzg0Hs=;
        b=d0/1j/+8EJ/RyM651rw4btuDMjJ+jRGz1xv9oRNZUgLBh5XUpBTdjF7ktYstNImfR/
         +cWAFV7A9592y0HEreAN1f+mUJ1K9x51BsDWNnJl3yYPMzk3eRWjm0YrBlx+H12daen7
         jbwjKZvb3Nn8rCgQfHmr8ijJehbkkoOqy19PuIVVs4gpA9JPDGtkYP/eMxjNNFF2qIFA
         0Zgzv8GK2lhhSZYm21X+/rni28KhtAsrwnKnjg72SAaoki9L0jTYfWUqYh6+ZoVH2rL8
         UzX9JAtu2fvLdQ+WvTw8D+n2gtpNaAfS0sotsk5yhRMMxtpWa1RL3SB4Sm3ts3iYaCOn
         76wA==
X-Forwarded-Encrypted: i=1; AJvYcCXT9J8phgdxz86aOHd4yZG8OQMSclRth9+Cfmvcw7aED7o6Z8PYqk7/05CRRVPQmbY9ev8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZinHtfoFEjrXEzHvn9oGGU2tDF3zEzmhkzN6BW0VtuQYLhnpN
	sVGnt1y19Hdb1RWuTk8PmGf+ylXQ7ZWZe77o4p4N1mDtmGPVhm6NitaI
X-Gm-Gg: ASbGncsFgRjK//ATZNzDG3s7TjJNbt5ld8ypEzYIBQ/IGlz6j+vrXttaLzvZZGnrpBH
	GlliBXCQWrPRSir2wmLmXrXAkkM0WazpqPIgbRDDhS9w1BiFMGv+NI5zFjt+HQwEF01U969HDmu
	+0zFfKRyBR4RMbeBDycEA7rF+Zr8gVZqzwCRapgdsWKiaDvUcq1Rgi4yuegDapDwnZpVPnozCMy
	9/cP+3BmVuU4a3Ijofbv54joVTRcuF16r6Jq8B0j3TVmhG72iAvs4e4nCdig3DmNtirlajGCT1/
	ueVDTeib7FU9vEZodbdRb3sCsdbCepG5egsNn9x6IVEHVQWj7wR64lU3wISxK/Zs5C3QKP3pWR8
	rZJcfr2LE4Wc+wUB+kYYV4cfNShmg/pqSREEqS3gheZ93mRzmI8Dbq8yLZTdaEFN+Qhb6IWV48K
	Lxcumdbrpk0aXjyhUvG2gDA7jWpr2BFuiPwjhXfwQVmeIAQdiKxKTw9ubHEECPW9OygVuLjMw7W
	Q==
X-Google-Smtp-Source: AGHT+IHMor6LQwpsWFUVFwxrLy8+al1Nxz8dk4Xfe4OKztACbR3JgfJX9GGPlr7ayhMPZn/weBOcFQ==
X-Received: by 2002:a05:600c:444d:b0:45b:80ff:58f7 with SMTP id 5b1f17b1804b1-4711791fbd2mr122207265e9.36.1761053317220;
        Tue, 21 Oct 2025 06:28:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496cf4cf7sm16222515e9.8.2025.10.21.06.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 06:28:36 -0700 (PDT)
Message-ID: <93ec3dbf-ad98-4038-84e9-9ca12b7481a0@gmail.com>
Date: Tue, 21 Oct 2025 14:28:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/9] Xdiff cleanup part2
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ezekiel

On 15/10/2025 22:18, Ezekiel Newren via GitGitGadget wrote:
> Maintainer note: This patch series builds on top of en/xdiff-cleanup and
> am/xdiff-hash-tweak (both of which are now in master).
> 
> The primary goal of this patch series is to convert every field's type in
> xrecord_t and xdfile_t to be unambiguous, in preparation to make it more
> Rust FFI friendly. Additionally the ha field in xrecord_t is split into
> line_hash and minimal_perfect hash.

Given that this series changes the types of all the "long" struct 
members to "size_t" I was surprised to see that it adds so many "(long)" 
casts. At the end of this series there are 38 lines in xdiff/ that 
contain "(long)" compared to just 4 in master. I had expected that as 
we'd converted all the members to "size_t" there would be no need to 
keep using "long" in the code. As rust is going to be optional for quite 
a while I think we should clean up the C code to avoid casting between 
"long" and "size_t"

Thanks

Phillip

> The order of some of the fields has changed as called out by the commit
> messages.
> 
> Before:
> 
> typedef struct s_xrecord {
> 	char const *ptr;
> 	long size;
> 	unsigned long ha;
> } xrecord_t;
> 
> typedef struct s_xdfile {
> 	xrecord_t *recs;
> 	long nrec;
> 	long dstart, dend;
> 	bool *changed;
> 	long *rindex;
> 	long nreff;
> } xdfile_t;
> 
> 
> After part 2
> 
> typedef struct s_xrecord {
> 	uint8_t const *ptr;
> 	size_t size;
> 	uint64_t line_hash;
> 	size_t minimal_perfect_hash;
> } xrecord_t;
> 
> typedef struct s_xdfile {
> 	xrecord_t *recs;
> 	size_t nrec;
> 	bool *changed;
> 	size_t *reference_index;
> 	size_t nreff;
> 	ssize_t dstart, dend;
> } xdfile_t;
> 
> 
> Ezekiel Newren (9):
>    xdiff: use ssize_t for dstart/dend, make them last in xdfile_t
>    xdiff: make xrecord_t.ptr a uint8_t instead of char
>    xdiff: use size_t for xrecord_t.size
>    xdiff: use unambiguous types in xdl_hash_record()
>    xdiff: split xrecord_t.ha into line_hash and minimal_perfect_hash
>    xdiff: make xdfile_t.nrec a size_t instead of long
>    xdiff: make xdfile_t.nreff a size_t instead of long
>    xdiff: change rindex from long to size_t in xdfile_t
>    xdiff: rename rindex -> reference_index
> 
>   xdiff-interface.c  |  2 +-
>   xdiff/xdiffi.c     | 29 +++++++++++------------
>   xdiff/xemit.c      | 28 +++++++++++-----------
>   xdiff/xhistogram.c |  4 ++--
>   xdiff/xmerge.c     | 30 ++++++++++++------------
>   xdiff/xpatience.c  | 14 +++++------
>   xdiff/xprepare.c   | 58 +++++++++++++++++++++++-----------------------
>   xdiff/xtypes.h     | 15 ++++++------
>   xdiff/xutils.c     | 32 ++++++++++++-------------
>   xdiff/xutils.h     |  6 ++---
>   10 files changed, 109 insertions(+), 109 deletions(-)
> 
> 
> base-commit: 143f58ef7535f8f8a80d810768a18bdf3807de26
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2070%2Fezekielnewren%2Fxdiff_cleanup_part2-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2070/ezekielnewren/xdiff_cleanup_part2-v1
> Pull-Request: https://github.com/git/git/pull/2070

