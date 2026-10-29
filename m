Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793270095;
	b=TaYHsEppIIroLjSbCvvvT3/MXIhA8E/ux5EXgPub9t6NbsaL0Qqe0Droas2AvnvUX00j
	 EfBRkPKtutvlf7dY8N9GHAuCx+M8tszhYJtMykyDWDTAi5yIakNztsQAlAVZY2/cWFjUc
	 NyOv+Vd90Lv6q7mYumSkUSdkAimAPMFYkPxjBISSRjeM/eFsKEXLWeRlmY3HJhfVLH6iX
	 nOTiMN4H4Tl9hcZw4Fq/TTAnH86JSXI1gns3gprjT7NmNDUxq5c//lGc4k1+1/r8gFcE9
	 DewIT5aYw+t2TjbMVKIGdoWYmaLc4T9yY/P0SKhqk8MALwzYKkt7/lCYu2xcqI8hCVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=KJZOkjNUwvpERdfPsGrZDOLrcn5eSwKw9TYEmt9CZ68=;
	b=dd5kj64GMTaPILJRLRqRYwTXOqCIyN8ZPk5i/OF6z+KRz8YIoXAa7V0kVkM3eExzB5uc
	 1SgBBoLMZhJb6XSY66ONPzBHLKxUMjOWjEk0RP1Mg7+Hu6diIKadXp4x5xyij34ySIEgo
	 DsIT/ndDPv+R1VbqV5l4FdPIXst/MGkAhTusPQYEm7rh7O/28ptEE0yclCy/97H2gYixL
	 t4q7RWH0tOpVSIBHSnAoeaRsRu/tRnuK0Upjf9QTGzCc1yHJQHccDE710l3G/MbZwWF/d
	 LSHGyUP+znAi7g3HOrHXhpoTgrL0GtfaJGOQyBjzA/xtBn3kndGSdYLKadmr3+YQxWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DI+xQduu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F9C606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 10:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9F9C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DI+xQduu
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so2907391a12.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 03:34:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793270093; cv=none;
        d=google.com; s=arc-20260327;
        b=KSuh8egwF3SxHmxoMNJLPGJKTFfvbR96r2xJsfiYo6qE+1ScXB+9s9Ffo+Gnf8yY5V
         13pki8XpTgk/kGKqoUV9wLMQNLNTibKh8NyWlunMzXRuXdUvXhJbTv/Br76svEyeYHXr
         sBX5b4KDIi2dQ+tKtrxI2GltXmE8cUqMoZHnit2o1N4C5sF1j4/BBMXNFhRN/TpaS0ub
         yxhIeHEivFinL2ltXQz9pV8rRZ9dPd2Rj2YfOkKGZftTp7nAjZzT/TYz12yZNtiGqpcv
         g0tXay6dFNhnUWl8/q0Mc/J+ITLxO0rvvD9Dzn9eZv13p8sCxPuTLPGj04Y08yf325pA
         3J8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KJZOkjNUwvpERdfPsGrZDOLrcn5eSwKw9TYEmt9CZ68=;
        fh=NGtHuNbiRbePF53t+AkTjktyFJVbPFCotgZDrhs4zHc=;
        b=DJ1E2cjnbxQR+IXqifCKBEyEXhofIlNV+O8SzBdqKg9gEJwtQTW1sHSn+cB1k1dtT+
         I/FUNi+yrQwT0dOrbyGhPlpfXh4i2VU3PgdesEsjQnRXv70XmpD2zI8rgdlUR01LS5Fq
         E6YeqPnIVtzS8059v+6yKsenP5D6kH8B5J5gvBZbMrVJ4jUUI4eM2YXazFIwE6J2DYGL
         E5amQTsu+XNUyV7mays1qHOAY6nFeVfm8hVLKS6xGrdmS3pMhHSJqDCsxCqwHotR6VJu
         L8jg/HZWmAkedCXZ3H2qBhaszh5snJOCajYX8lcrJVNidqsbQovXDXOpp1FYwQLRVTU/
         iwAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793270093; x=1793874893; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KJZOkjNUwvpERdfPsGrZDOLrcn5eSwKw9TYEmt9CZ68=;
        b=DI+xQduu/6IktMaPCXlOB1VJv5l6HSDd1GvcjXsEAGW0M4TsTs5dSpCj4/Lyux4Yxg
         yrrsC8/dF0U/7utqr7SXon/Ohm+rslR6VvMPrQXYudaqHPZuCewqeiB6/uWM6iDq3tve
         a+7iuJ0zSn/G7/F4Jsp/tvinde09g1GGpRBqJtVwsb50fExt2UZZufP0EcjcStjXn/A/
         gmWFRBhuoHdNorLrRCqvIrgBB3Yd6QexcVCIjnTgUhHK/JW+PHKQcdTzj5+WAznDid4i
         0qlMlxcsMiBy4qTcMC/Zhz0ateIy4pOn9OSYdYVOTEGd/Jw0cKrXQCUqTfGveEOhON6X
         ABRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270093; x=1793874893;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KJZOkjNUwvpERdfPsGrZDOLrcn5eSwKw9TYEmt9CZ68=;
        b=oHuLTFYk30E94+OCqWx01fM6+XCS32kGX6dcH7+mINsE2iZ9VW/PwTZTaPIVFXRFxq
         XnQtLazBZBqO8qLsqftXLDNMSpTI6VbuPdWLDuWvuWZyFdPqemYqtT65b9pNyAn3TnGU
         4/FdKDmmYLvIeVceEEpavd0wlOT1e8eE8ONWndpS+HozwdFcUMbSeq7c9/VPg31RYrPY
         f8F29WVcXrcBRXacgIfyEVi88pGNKzHrHGXN1eak1+IgNzF+SG2x/S6N69a6C1E1S+rn
         60Y/inLOkcRuS6f/rCiPxmSlae5D8469hWssbblzHELxnkF4WJIy5nNVJcYAKEeH23qK
         lehg==
X-Forwarded-Encrypted: i=1; AKwUvBxFfkNZf3tLDvWBvbs1iuVU/vh0Ov7qYQBS3Z/o8Q3yRmQq8TlHN1l0czUswmNn7KbO1mg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhufFZ3a3iWr+tuPLghF7WcJum6rCtS4ZwWJZYrEVIwQmYHJsH
	H9rNZ2GRRrh/oZTmFoAZmI1ngofwL7Rmsb5qIx3f/Veql7DYUpelbia3RnZGVBfSeMEDAhOInIE
	xhDizsqZiwwLcY5ODkvc9vkYDsoMnc/E=
X-Gm-Gg: AYBFou20T7raOztNmalSKOx6BEZTBjdNdDya20MFY2PQBERt10kfRSsslWtkBgXI9AK
	jLZ1VxC9dbA+f0UoiFEyHdQyK7d31Ksm7L2Lz/C39Nd7RbdQaX/U1UzYJOSxExnzyfK5ej4l4pY
	5AtXFLbB6UAJHAQF+3SItOlfXiRFJK4o23RDCUePYsnZcR2HC8FXU30B/mMBy4IxQm5JFa+pkA5
	DnvvgTS6ytMBTkBFVUKxSg5MV4Ay51GdgDrTiNjbRbD0fJxylVsMQ2uErPQnqln84BqnDjG6h7d
	kiyDZ0g/xWYvUrmdOMzKnHhVM4xaqutencL3+SWQt7958phWTmVW/KwMm3ImOh6MZgl/E6kkGOr
	znigOYUFg78Xo0GQHbaQAeyJvvpVExLWgkvHY6HQMcyvUVwW5QHWqHTi2+RgS3F1Nc1BlvQ==
X-Received: by 2002:a17:907:9490:b0:c3e:f39b:2298 with SMTP id
 a640c23a62f3a-c49bdf271bamr447231166b.16.1793270093161; Thu, 29 Oct 2026
 03:34:53 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2466.git.git.1793105039624.gitgitgadget@gmail.com> <CALnO6CBxMrv01NMqEPCLbGbCPXX9T2Jgjax-L5s2z9s-eUpNDQ@mail.gmail.com>
In-Reply-To: <CALnO6CBxMrv01NMqEPCLbGbCPXX9T2Jgjax-L5s2z9s-eUpNDQ@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 29 Oct 2026 12:34:14 +0200
X-Gm-Features: AclHuK8k5UWtLgF7Ld9-REbJ5wK5cb2sR-zonDMM2VoaYyPZSWEa09_duaUJjEM
Message-ID: <CAHwyqnX3+nwL4d7-eE_jkWjQJdLwZ0zeC+eqW_7Mmt0ncbSfMQ@mail.gmail.com>
Subject: Re: [PATCH] remote: resolve "simple" @{push} when pushing to another remote
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> So, I would say this is probably fine as-is?

Thanks!


Harald
