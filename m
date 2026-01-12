Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9052701CF
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 19:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768245044; cv=none; b=uElf+ky8pTJXEWplqcXaemJ9tAzFzwUfMrAPT8evFp2fdZ1t1xX14v2JlLjx63KlxKvEDIvtEVVjDXm2amSMFE1UPwXMtquQo9FlsGsuz5XawZI670tnM/Twn8R5EYB+Qa3eCwfCbWwkYpeeC91uR+zMnXnYZ8XFkPUj0838TQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768245044; c=relaxed/simple;
	bh=EzK7cyEz1pSiWAu/wDNqZExsKvjnls6kkx6Nje0O6YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQhlsRLUG/DBKMXfUjee1q/I3NpznLPuEQgZN6JRw1Bj1bIm+qvw67kUlIGF/poVaiWgTqseG7IeQ56eyVQrjpqYY2ohnz/488AP64b/a+TqRwnxI33ZsR/AbZo58pYdETGPkvV9cwQtv683vzN7fRuU9eWRBnfrC0QQtE1StWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bi1s/GVW; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bi1s/GVW"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso3857540a12.3
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 11:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768245043; x=1768849843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Fa40VAJ8multkrmfTTSeiNQcd02zQvi3wR/toeggE0=;
        b=Bi1s/GVWNGKzw3Um8H9bJIfTXXKWhFjb11rX7eTnrXDEU8upHK0nic3MSXhkNyP+X1
         vC5MDvNDL7JKwYak49RlM0hXgnt+pxv7QBZhCIoQZaeq8Uove57lDKORStJWiQLHkrIN
         5MHcu7Xgjmeg5Wen2oIheubO2u/aV51NVma0bM72Q/6sgkkfLHmDsNSNvHNON/HyB8rr
         vGl7aNVYEJ1waRvekBGjXV6SXsmY/MdNZbkWz1J1pP/d2OOWhJa5shvhFJWD/zqIYyDS
         Z3JbcyokZdT7+UmLHEIfx4CftdAI1Z0I/lLsIc1Tshyh1rmsspowjo4zzWtmU8QgwFZE
         xEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768245043; x=1768849843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Fa40VAJ8multkrmfTTSeiNQcd02zQvi3wR/toeggE0=;
        b=mjpsmDqtqaLWWSa2b21WdZwAT7ayFj4q3j/yUnhuhRYD6OFhWCDeBiLOaELcbB1apB
         u6BIdUZMGkE6kC8K17A1IgFFG4xp+cq7wjA0f0uL76JJzw4hcx4lNr6sCukPkviOlvCC
         85tHpJH0tFL9wOEIWNhJYvOZcSu/D7/O1znkkUIkpMthfJwdeuDf7arvhCqkC61hRUOB
         qZmiyYJxLna5I4XnREU8dwDJf+mqGXP2jnR9YifO6PpKkkZOhmlRpfzzmjksAbA+VL0a
         ATsd7mfJdlfdQ+7i4yVZFW2p5qbVzqua3pruuNUIl2vAiwT2Pe1n0pI9yCBpur7cCYmP
         8grg==
X-Gm-Message-State: AOJu0YzmmNhBm4shecf/yN7WhfCiEtEfWVNgkz+AI9qqaunjzxbEdwvA
	womGJfvPlPJP9p7VDOiievM7XN6iwLlNpDO7SeDn0XGAUZ/628LE7zAM
X-Gm-Gg: AY/fxX4V0LKzJNMoky9YZyGUmNpfvCjlz1Ld7PzPl+amSp7rPziMUIt9pMC50Q1ECcf
	ztocoTAmm+wij+jpnyNZBOTaYj8rp6C/MVHmkvxA2GnUWyQ+QjjgLyeDS6CHwnaCw7RfqX+UNS2
	FmovBvSpEykdHkMEGXmmDHuzk99yiK/lj6iIysb8FwQepO7M3+E3u+uVsL+hAMq0ZU/6rLSBosY
	a1CzOPM+u3ouEKvE9WrzWiYylk3dpJD5Edn7aTNvp6nE2xz6n5tyvDA0k5XuhEzK+FKypICT/EY
	jmZCzw+1A9A9MmGfPVP/9WPpfzTwt6wnOZE5Ok8lboOQGJIfh21NEAm//CaBlJUwbRJjfZwfCuq
	xNiBxp8BD8Y8OaY2xNTfxmM6z2OkrbgodSy4eyQNi/6qtJL8tQ8pdpeLUlSPp8aVsCzXsVaRd3O
	Q/UCCpYZwyTIY11kXjWMrGH5dDQjcjVS2nMR/vgUg21PA4Aw==
X-Google-Smtp-Source: AGHT+IFOYJfvX8iOs85mOHyN7qzyO0uNbADFjEtfSvdsnnPKWwnrj/wMxUHbUt1Cqj7BQaAgODp8Yg==
X-Received: by 2002:a05:6a20:2450:b0:366:14ac:e1e0 with SMTP id adf61e73a8af0-3898f9e9074mr17248854637.70.1768245042949;
        Mon, 12 Jan 2026 11:10:42 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:8811:38e1:dd74:7b39:2154:bc0f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc8d2952dsm5404239a12.17.2026.01.12.11.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 11:10:42 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	pushkarkumarsingh1970@gmail.com
Subject: Re: [PATCH] doc: MyFirstContribution: fix missing dependencies and clarify build steps
Date: Tue, 13 Jan 2026 00:40:08 +0530
Message-ID: <20260112191029.376820-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xmqqbjiymzpq.fsf@gitster.g>
References: <xmqqbjiymzpq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

> >> I personally find that stopping at asciidoc and let the user deal
> >> with their platform convention to get asciidoc working, like the
> >> current documentation does, draws the line better than the above
> >> updated text.
> > ...
> > Please let me know what would be the appropriate approach with this.
> 
> Again, I personally find that stopping at asciidoc and letting the
> user deal with their platform convention to get asciidoc working,
> like the current documentation does, draws the line better.
> 
> If we are not mentioning to check INSTALL elsewhere in the
> instruction, we probably should, and the place where we mention what
> software you need to install (like compilers, make, etc.) would be
> more appropriate, than a note about building documentation.
> 
> Thanks.

Since INSTALL is already referenced near the beginning of the document,
I will drop the additional mention there and keep the instructions as before
in the building documentation part.

I’ll update the patch accordingly and send a v2.

Thanks for the review and guidance.

Best,
Shreyansh
