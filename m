Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CCD221DB3
	for <git@vger.kernel.org>; Fri,  8 May 2026 22:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280055; cv=none; b=XclvsywEPf6NQaF1co41zXHaaRfBwiy8POj6Bbz1KIzqGhZIPNnvx7VJ28k/82H7052QhphfOQGOYXXESkPVqvOW3RSC+5b/yDVUAJFCz9Oh4UmHJA0OrSJFZ4vPFPbqjZ5ZIspV3ItCvT9eiitpf19yJHtrkUrayD7w0vDuOIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280055; c=relaxed/simple;
	bh=BoBAZuN3M9jfhGZVkn07+n88DhKoQ6EAKw7T9LJmdgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZL8Xh/WFqigCuYb//o9+3fHivLNB0gOUD1C9e2Lo/GqFDuQ0P3I4c37rytu+ZyTd9Twt9djhZgyjz0R+Suo7Ufye4H9hhtosDXnjgqsnwC7MTpml/biYcp7cN7C84JWDkJCcuILqDPqGa4oEaAHW9SK1k/DresSJORfI/w7igIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2F1zkWU; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2F1zkWU"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a88de2b52eso3444182e87.2
        for <git@vger.kernel.org>; Fri, 08 May 2026 15:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778280053; x=1778884853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mxBn+C1YWVJ/tbbC74t9L4SJX3lWbRNNUMg2RGe7cM=;
        b=K2F1zkWUMr1p5vmaFKV56Yckfzmerz5smSkTcc58GiB+n/RQg1XLP6evdwtTo2G+2l
         0hXLOMdpeG72QWRM7cHnEV9FSAqrDzvToahKWQrUmhsA0Q3biQOVjGzovAn+bwsX0fp7
         tAUhDJl3tY9erZJpqrdZa3AxwqdjZgr1+qEOCKogeeCdYOqsN3oUHnU4B2CHGrnL8jce
         FHuSK2DS02uERuEUOGR5JzwVXEBf4BJELTNoK6ZnT4Ia9Iza4bsThbDYTXIfVECNUqtg
         yDeDZcHx4EhjubsqsZM7E+7VXbexAdRX8YLDJIn0BoD35oZ2EtE09HvVw3+ulcUuxQqc
         JS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778280053; x=1778884853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8mxBn+C1YWVJ/tbbC74t9L4SJX3lWbRNNUMg2RGe7cM=;
        b=C+JiTdZQ08kCz4t/4b3qpqH/LfyOefzLC4NfjdPXjR+aF8MAZBuE0v4kLAvd3RheJ5
         nRdnA2BNfIkyfAQcp1p4EMKgPxv/bpdPcTJ2Gy2lD4GVSXGB+wvMHqvxX39fPqNG6D1b
         1i7NYQb6hFrnF9KvILhSiiQf5HY3SrLh9qmuM2zK5ES/7K+V8jd7CD0hxibxdQh8tT8X
         q2y3TOFBAWkYBGvyCkULohRXy+gz85CAwlMLvd1n7whsxDzNoANUjGSej/+b+WRYocxf
         f5cVxHXw2xEiwcEjDrYM+p7+tDbgX8D5KXWMWlaRsr852ZPmYrQ7dzFw+5rCpOUaY+iL
         NtQg==
X-Forwarded-Encrypted: i=1; AFNElJ+3nqcV/Fp32BAVB/ZduoscyxbUgAqSSmXVQbmCzhI8ieNXFqY/m55iusX7gqBm9e+qRnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHqa+zNnPMZqWGDixD4Ede+oaF/ff01V4kA9EUmGlVZ32/khRG
	0JWo4qMic36cUJPGEZlHpCYeHmUZYYK0eWzhxLSMZ+sAZGvWfFMjyqej
X-Gm-Gg: Acq92OFGj2eBDcm547k9DmbGYJSdJDkwgRuGYQgCDdPQrvzx87MCXjFUnd2R+n2lSe8
	nFdVSoHJsgd38plavV1ogZIw5uD0ggYb5LROpbsWQn8MTBkMhy3EPEN/h5DqtpiKRNKXTHXabms
	vRD2jMx3O1IT+981GhVoSCoZGK5FtAuhrZaojeVnqlEz261G4AqKVCI6Ri0k7+LZjby8/AoBn87
	oa4JwRqBd4GwsrAAzPlv9vVs1b6pMEGaQYOdvHe/W6gZ+PBnOc15vt7PanUTgkZruVMw8ik3++M
	paTe4pHq757LQ1/MW1WJl+Ba+zSb0LvsKgogVD6grWRhfftqxLzCAuCssiNy5nMTxY5Us8HOchb
	qZRkTTSKzUWpOfGY88B5oaeQdilETqJsT5hJWgue6qPfkO125WAmiO8ACjNVFcDp45G2K8X8Axu
	zy4cEMpaDMl7fqSDqD6ZfSQoaSrgVCKhFc0Y6Pc47+pMPFSVAbbD07IKTiI8DAJYF52YC1y8DtC
	ICzDwnB3zFYdSq2Vezzo/YA+CQy/8noOljyNQ==
X-Received: by 2002:a05:6512:2245:b0:5a8:923a:5369 with SMTP id 2adb3069b0e04-5a8923a5ed6mr3962431e87.16.1778280052432;
        Fri, 08 May 2026 15:40:52 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a955e14csm848320e87.43.2026.05.08.15.40.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 08 May 2026 15:40:51 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: phillip.wood123@gmail.com
Cc: ben.knoble@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	marcnarc@gmail.com,
	ramsay@ramsayjones.plus.com
Subject: [PATCH] checkout: add --fetch to fetch remote before resolving start-point
Date: Sat,  9 May 2026 00:40:50 +0200
Message-ID: <20260508224050.97883-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0.6.g690242d89b
In-Reply-To: <f23eb128-958f-475f-911b-eac4f6daddff@gmail.com>
References: <f23eb128-958f-475f-911b-eac4f6daddff@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> * "--track=inherit,direct" is nonsense and should be rejected
> 
> * currently "--track" has "last one wins" behavior so
>   "--track=inherit --track=direct" behaves like "--track=direct". We
>   should probably keep that so that "--track=fetch --track=direct"
>   behaves like "--track=direct", not "--track=fetch,direct"
> 
> * if "git fetch" fails and the remote tracking ref already exists then
>   we should print a warning and carry on rather than dying which is more
>   convenient if the user or remote server are offline.
> 
> * "git checkout --track=fetch origin/branch" should respect
>   remote.origin.fetch so that we fetch the ref that we're going to
>   checkout. I wonder if we can share this logic with the code that
>   sets the upstream branch.
> 
> * "git checkout --track=fetch origin" should only fetch the remote
>   ref that we're going to checkout, not all the refs from origin. i.e.
>   it should read origin/HEAD to work out what to fetch.

Good points!


Harald
