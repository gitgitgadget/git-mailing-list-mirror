Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AD24F88A
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="vkVQKfjW"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-680c4475b8bso24962356d6.2
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 14:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704925590; x=1705530390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2EsvjE7WLXqa4gm7MTRY9NKm4Mlrs+y61MnW/EgEItQ=;
        b=vkVQKfjWK8fI3fX42LIbw290p17h5m5lyrtmH17MVdzypZKgzKJiVNy7l+BgNqfFLE
         kySL+WoLL1h3ybBE8O6FEp00jnbeQvONz9+oxiwv5gnCdot1S55GsCTFGybJNgCFnuy0
         OlRpMDbrXytNcwMcpWEjmRQryATHWkwx/R+HMlpo87BZKHw2fckTj6bcqBazSTPUjuFd
         Zz9OsKt3gRjQaRg+JsI1OgLQYvhACkJSevYBOLU8RCaeBERXJZgs0P64g0Zj1EexvvR0
         N+mYDwEjoLab4Ws8NS7bao+S4hoUWD3kGc5K0xalTrhVW2lu9hOrSQshmq+4IPhYqdcB
         gGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704925590; x=1705530390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EsvjE7WLXqa4gm7MTRY9NKm4Mlrs+y61MnW/EgEItQ=;
        b=pOvwO/e2Qp9NSHcQ9arEwOeaDCjOAbgS6gXsFMrRiCnfI6DoWoWClQCWHYLeIdkRYl
         /vdS5wLgeWp7U3MTflusDSbyZobYlkwKf1Q7io99vvwZ8XXaElOEwDX/dOHYt+uEezum
         CuLwgCO+ehnxwcHYMNLBl0gzKaRl/1gnnlJTT+X9jOiHEpWi4QcAJsu+wZ8mSdZup1xW
         MzOJaagPyXVxsjlMYm6gENgqBPns3IqtQB6OA9uTBKvUx/4kj7fslAZIijz7nnB3x4bU
         MDB2QOt5fvwc3tLUShDup1W5MvMtU7RcKo1YCOT2UlxfaAQvSySHNjfRWSwUpn0sOCK/
         O2Kg==
X-Gm-Message-State: AOJu0Yyl1tQ8Q+qk79PUcenyEEsq0s7UTKLa9recQEF+Ly3s8ySr/uDE
	sVb702cAm/XLUQLLG8eru731ml23L1dyfw==
X-Google-Smtp-Source: AGHT+IGiaIbu+wjzCJ6tn6MxaZR2cocZIo8qEtxpjOlOOSlnb5CUycXaKbSsojkzy7/FHOxHMV/t8Q==
X-Received: by 2002:a05:6214:234f:b0:681:105:58b6 with SMTP id hu15-20020a056214234f00b00681010558b6mr177705qvb.127.1704925590203;
        Wed, 10 Jan 2024 14:26:30 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l11-20020a0ce84b000000b00680c50735c6sm2006651qvo.88.2024.01.10.14.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 14:26:30 -0800 (PST)
Date: Wed, 10 Jan 2024 17:26:29 -0500
From: Taylor Blau <me@ttaylorr.com>
To: rsbecker@nexbridge.com
Cc: 'Junio C Hamano' <gitster@pobox.com>,
	'Dragan Simic' <dsimic@manjaro.org>, git@vger.kernel.org
Subject: Re: [DISCUSS] Introducing Rust into the Git project
Message-ID: <ZZ8ZlX6bf+hjmhN+@nand.local>
References: <ZZ77NQkSuiRxRDwt@nand.local>
 <b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org>
 <xmqqjzog96uh.fsf@gitster.g>
 <006b01da4412$96c6c500$c4544f00$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <006b01da4412$96c6c500$c4544f00$@nexbridge.com>

Hi Randall,

On Wed, Jan 10, 2024 at 05:15:53PM -0500, rsbecker@nexbridge.com wrote:
> Just a brief concern: Rust is not broadly portable. Adding another
> dependency to git will remove many existing platforms from future releases.
> Please consider this carefully before going down this path.

I was hoping to hear from you as one of the few (only?) folks who
participate on the list and represent HPE NonStop users.

I'm curious which if any of the compiler frontends that I listed in my
earlier email would work for you.

Thanks,
Taylor
