Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793441787;
	b=2V1sgKiwI0UTmVkvLGsirYYfY/+UgljE6vOtRFDIW1BJCysv4724pDyHJnz8xMTu0u64
	 amT07vAXwmeHZHzy1j2u/fmUlNcrtVXoUB8TwO1faNfZh2TE0mQIAgDy4katk/AuHNgGw
	 +TAh/kLRrY1lZDX0eeqRhtV//hH6rGjsTU7w7bU3hAEaaR1Q1oHKqLRdlod7roZDKMMZw
	 1LoLgnDKj9em08RouvoCY70UVNApmc5KjppYYSjWb39b/0FkA676HmvD9JGm76xgfOgkl
	 aOxQzFYZ421yJcslh0+9SpHryvtpEjoewYat+iZzUMl0+REvPG/+oQs8EvvFB/gn0og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793441787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JcmlRfqZnnY4xhXu8k/e/N8MqeuUJXimHCz+qgOi7Ug=;
	b=neZBNnFaEUkbGdDLxFxM7PPb8OaJ+zvlllFGgbT7ccxcwpRTDmyyu3Ux+4+KUly8UCSu
	 wAFTFNCe3Fe+f3egrVJS3zvi0gmhbLfkg/DSq/z3lr6HlIXv24nekvwYbP/qSed/ChBaB
	 5lFvEgdZTia7MMy3uuRDBedt44O44mI/JLPPRyO4REckRWvxGnB9Ltp05vz5VmxCHMX3U
	 LnkvhwsHGvAkrv4z86lJjI7StLuMBRoz7w2Pmxmt0yqZfgH3+AZ+xnWVpZSDwmN7+kJYC
	 +hWRs9n+8Md4T7TUNS5u6vcPW9Fp4CXNYD14IslzoNKOPGN8f8I9UyCBLcU/V78JzUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EtbLy+Cy;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2592606A31D
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 10:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2592606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EtbLy+Cy
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so13934785e9.1
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 03:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793441785; x=1794046585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JcmlRfqZnnY4xhXu8k/e/N8MqeuUJXimHCz+qgOi7Ug=;
        b=EtbLy+CyL0nMPVJgSgWvva8XswnI1tn6TBtiTSMNrAPh1eNiuxu4jNwhRkPRgOBWvC
         zmNqM22AbQ77ed1R1F6Fz6//ih/nADZE1v1afKEFqxPw5QBZv4/8eifnorggsREOQ4eq
         Y1U2oi3uJKGlaVQrOTB0V+XZ/LBxhFpcglYfb3PzsavpWmeZfRXsgR68Py89nB13/kjR
         ZotZnKQbvIicTEGx7C3xmlcD6MaAVMKdt/Z7LF5z72oVu7GaeSC0ySXF8qaYJVvJFsAG
         ypBcTK19f+3KMG+yES/K12Pfveny/vHZC+A6pEjUVzpsDRjPlGifUW2KybG04sBJ7Hv+
         FKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793441785; x=1794046585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JcmlRfqZnnY4xhXu8k/e/N8MqeuUJXimHCz+qgOi7Ug=;
        b=G8AO7yiVBlvCkeuiCdXkwSXzhatuBcchNdgT7o5oceRhKgBe/zzlRnBLS5uoWI7fZs
         CvxhvX7D8hpgq+ZgdqD50aWtVVr74CP7OYWItjafbnhY9uBAXP8LYhPkEHQ56MrnF6RL
         JOJWBdNM26UaE/NZHefIMi7wXDKf3mEqdgm2UL9OHT2/ziUWfClMVTzXKDRfIF2AqP0Z
         /YNYalQ4QCcKs/bCEFklDNB9cq7XLaEp5l+uZYwKiVr69xdjGcKze0xMGiTJ5FQKNND7
         ZKJtRdBbC8b4mcbFMJek6IyQJMJ0neNrebicthXKWXZ8X1I9HJIyZCBXsyyduQfLhXje
         /crQ==
X-Gm-Message-State: AFq9FYJppW8Kcxvzcwx4ri2B2fgpVs2I4P8LzijaRA0DwuawjEhXgQ9J
	S1s3manHVp3uCcZez9ilIjhrUhPqHwIoNcErlKm1pwcfhftS2hD7X20m+82DPFpg
X-Gm-Gg: AYBFou0kSj3RIhfw0f5dr2x7pbUo4rVMrFEDpPghVdILDffB3Y/Ty7x9uBiHPi0+8Ht
	GP/8b84qL7Mp1spILL3yxi+Yc3lUIqX6ZuQeicJhR98QV+9ZejdKiMHXQfVqCckNl1bF6hq8swA
	gcm7L1v7HWaUpl4RVLfNh5vKV4YnYkm22HAAKnzVIgvF47S3vtW4o35jUFrjvyztAxkHgGMXwlw
	XRfLjTS9l22TqcMz40NlTFitdtChrKbUtThE+SlrcczBjWtvA0gBPuQLB1EItTzGMRMHk3tXkn+
	VAJ9f8l4gAuWBZGKpPTGG8+FnVBe8u8Yn4nipgESr89RBOjcrZNlcEuZY87dsATBb6baYr72p4H
	oZt0qd+sgI3vKdpTD5G4nFWm4h27CG1x+MzDOwgGiXgzTssU9/6GTNu2GHpFIv40Yj9Zs0btV7b
	/P/i4VFTOJ2SlWZCAZogfwxP1W3o0VfH+akwuzZaX7tDKTrvY/VKkVZZamvwrlZa4WOuHzVOFYj
	SqsalK2+V4y6+GohyeEtgO6OIUZK4mNuduM4zaBHdOB1JwQcdm6qUMk//7bsJdvFIbl92ONZyYh
	IO0Z0L0mPXvd0c1w/pG6x2MuOXFccOOa2xEJT+n6E3C+0BQPxleCj+lh2mjI5S0=
X-Received: by 2002:a05:600c:8b55:b0:4a1:f736:79f3 with SMTP id 5b1f17b1804b1-4ac17ffb30fmr107422945e9.5.1793441784866;
        Sat, 31 Oct 2026 03:16:24 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa8213ead6sm195434335e9.14.2026.10.31.03.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 03:16:24 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2 4/4] convert: use size_t for text statistics and ident counts
Date: Sat, 31 Oct 2026 11:16:19 +0100
Message-ID: <20261031101619.172770-2-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <auSDKKHJONZjx2LX@pks.im>
References: <20261021101640.329990-1-gitter.spiros@gmail.com> <cover.1793352943.git.gitter.spiros@gmail.com> <84e9e38a3e63a2b135847471a13ea36d37bd64d4.1793352943.git.gitter.spiros@gmail.com> <auSDKKHJONZjx2LX@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 30, 2026 at 12:44:40PM +0100, Patrick Steinhardt wrote:
> > gather_stats() counts NULs, CRs, LFs, CRLFs and (non)printable
> > characters in "unsigned" fields of struct text_stat, and
> > count_ident() counts "$Id$" markers in an "int". Now that the buffer
> > sizes they work on are size_t, a large enough buffer overflows them.
>
> This sounds a bit too deterministic: it doesn't necessarily overflow
> them, but the possibility exists in theory.

Indeed, it's a theoretical possibility rather than something that
automatically happens. In v3 I've adjusted it to say "large inputs can
overflow these counters".

>
> > Unlike the previous patches, this is not specific to LLP64: "unsigned"
> > [...]
> > as needed.
>
> These paragraphs very much read like AI to me. I would appreciate a
> human touch, also to demonstrate that a human was involved between us
> and the AI that tries to understand what was done.

You're completely right. I used AI tooling to help draft that commit
message, and it definitely shows. Fair cop.

To clarify my involvement: I review the code, check the cases, run the
tests, and take full responsibility for what gets submitted. But the
wording here missed the mark. For v3 I rewrote the message myself,
keeping it much shorter, focusing on a single example (lone LFs), and
dropping the heavy-handed explanations.

>
> > Use size_t for all of them, and compute the size hint in
> > ident_to_worktree() with st_add() and st_mult(), so that it dies
> > instead of wrapping around.
>
> That's awfully specific.

Agreed, it spells out the implementation details which are already
obvious from the diff. In v3 I've simplified it to just state that the
size hint is checked for overflow.

>
> The patch itself looks good to me, thanks.

Thanks for the careful review! v3 will follow shortly in the same
thread.

Elia
