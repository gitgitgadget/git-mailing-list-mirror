Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794736711;
	b=RBwPm6LeTTHowQsUJ72Ef+vnaXCABBkXKeTSJDfYFMJ2uK7SJn/kzMwaC1WZ+b0/UvvP
	 lcBz3IBkLp5d2fBWShT5dQWs7KGGUzOHJtVRTtjTogmFgbWYA2vlotzlPCtpI4F1apUIj
	 qVTU5N3WDPAX4PPKzmx9nqfe+8AEAb9wit5Q4pVRC3TQyiP2HT7I5tEWIKBReK7sgh3iO
	 x0HtsSwBP/G5uu8bc8G3ggJ2Jfvn+m+qjn7rDNPdZy9xXw/5KYWj2Qty81hIo1U+tuzlB
	 65/yp0TBshpkiVH9ALgBoNAQkTI5wHYn7zegN237sH9ZOu4RJDSwGBcqADYye6AYaPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794736711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=98Q1dM4Klm1eSbtJug57EYv5a2W/cYY+OFDG1LyO0f0=;
	b=Y6vvdvSMn6sj4r6FEQuiXxVoF1tiP2clCdKkRsL3LNucqobBIatiBL9N2uX3XALz+VBQ
	 ygjlDshsIkAMcYme1lbrOWIR4Luk+/ru1PUNnz9tHTY7Ly5AtK4fYMicm7eOEGjrl3FY2
	 12Xpbuq8B2g+dJJyXLrxAm75P2YkkaXP9e19LRhrDOlKmqOq5REfcQ4Zphi4TiBA4zNYS
	 363AvtIEWSE4WPbiDJavw7m0qcwYuDraoV66O00HWM3LLisGaXrcq+llmP3d9zXM56Jbu
	 naEt/UiHshXRLmc0/utbPA1RroEeE2bl1YShg16YQfU1OoCrkeJTo+q00y2mVCitUUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qNWdQmfo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EC3606A31A
	for <git@vger.kernel.org>; Sun, 15 Nov 2026 09:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99EC3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qNWdQmfo
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b4c2da74c0so2959577b3.1
        for <git@vger.kernel.org>; Sun, 15 Nov 2026 01:58:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794736709; cv=none;
        d=google.com; s=arc-20260327;
        b=H4Dks0PqWv75Sf0ROGfO7iYoaNkofE1EWXPff85J1129CNpWZbqCInq3ZGdZncfPB6
         rNApiB9nFrEVMvdnZlT6R3XUbjNLMABSZA9dQyYxS5+9UWL1ABOLLF4tCtLwWKBG9hj0
         vHrX75qWmuiCVSs9w/oBo6EwWnhgH5Swr4S54suOQFIDeTKcXmhjVul1HBFL4x0NPJeQ
         kzLafz0zxDw8V6ARVs+6n0mFbMj4spVJgWEMI4+47TzP2myB/4uRIpZ/iL8T2TlKxHWJ
         XKBzPDqQFA0fdJuWhMveR1cHqr9xECMBeaE9VfCjRpcnc8BGAQdiW+GEGQieMQTNI4u9
         jJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=98Q1dM4Klm1eSbtJug57EYv5a2W/cYY+OFDG1LyO0f0=;
        fh=7QBgNa8+WZXNYeI7qrTp8WO+duC+GtsTe+dnvwJN9+Q=;
        b=fMtzyrQDvvemstpntDmA4m3aqhiMDCkWHMxHtjLqCPCXO5x/l06bJxAPK/1bYcENKf
         GHytaLeQ52Xrty189apSmqBK52PvhYDXFtwsSG5ZhGkAIj2WYWrZjcen0Yk2pg5ubzOA
         lS51rhiSNBbIFbEqUM2VEc0ABNb4Jz9zK3Yg2PxarkhSnfEvbt3fQTgFF484aXSXUpde
         xpstuv3VbAyAZkp8lAkC4Yw82I+JAG2M9YqEUGoHc1FDX98XZW2oDSYk66wVpsjs++hd
         8gJPvjyWKxaAxTlwnlLOQnrTfUi7pieCpIAd7fiinwt1KonpHo2yr5c33LvCxpZJ0Y82
         moSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794736709; x=1795341509; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=98Q1dM4Klm1eSbtJug57EYv5a2W/cYY+OFDG1LyO0f0=;
        b=qNWdQmfooCt4n44f3AN5ucm4RVXYl0EZF2N5aDiOBWXpVXfmsw2iGe+dFe0D+8D7LP
         bJOZGA1rvQoBjSViXbe591cRusXSjIEsXPLSYIdejl7teidOlXPQu7UoSeU/Q2w5Xplb
         jbCHhkkMyar/BfMeluZLLOxbpyd89+DBbsfcVeVObmx8xTCUfEZzqLB9faaUMOuCT1WX
         ISU8hympDWO3g/SNCwSa3AQ9twBUqAyp6scTSHSVkFQ4DopbJJxIrg/3nwLuU8KCJgJv
         N2EvLiqps9G0zjTWMuXleeh3i+gDHoV0608/pahYXRbBuoxRSBSH4gbTLBIv50VNbo1p
         pCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794736709; x=1795341509;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=98Q1dM4Klm1eSbtJug57EYv5a2W/cYY+OFDG1LyO0f0=;
        b=nS0iI7uwUvaA7FuVAMSUVb+9RJI+tOz3Eg6b68yz5brAYiTSt8P16Uae591PwfZaf+
         +EGyMG5vq3M4WTt7V+J9CdHtxjPoyQMjxn5oMuUonRhyrR7yNJpc4mrd2JTzwS3W0CdB
         LrmMVIRco5QI+otKs8u04JTowPGf5p3EOuT6l/6FyIG1QyGFSJVoln/N9eyri6HbQ4ep
         uY+xZjyokCzhOIdyjoNpAh5ELjguCGG94gMMeG/0/OnAWAQ5BdtbtgTTnnnOeCs5KIGf
         ZcMPBOombBuiZS+oOHgXA3fcmyaHBEKAjf94Ddu5zm2SRm1cCe8AQma6HpXP/DiDG9/G
         2q8A==
X-Gm-Message-State: APuU4Z8Ggi4tS6twpednBZrYVD73q1m1uUY3vNVh61jxex4AT2YdXgwx
	BOsM9dSjGFJIYkVDEYd2hw/mIakiqOmByMbTIDPbu5MBPPiWG2pBj7ItFS4ofzJ2W5wFs7v7vCx
	a3HZ2Y3hZpgeoa9xzvscc4/0iYGEmeWw=
X-Gm-Gg: AYBFou28vByLKiGjAmKhr/soK0sgbHOK5p+sfePGkU8p9m6aFRx/ZZde0hCcttKs2fZ
	Qp3NpWMgvpQmB4idoW62u/MS7lUgT9MkQMRz8s8Ifqk8QEDYsHUyunxNM+IbbjPXanGlY+c+331
	awq6zl4DSe2/XWBSxP8jJiqEcJ9noZYK97JWCmlDgcdGe3KWTuXm9UXwV3d+oHWTBna3hXuJ7BG
	DHyCeQf1N6HaBAEPDqQqrnie95w6lLaIMLdiqvJt5T8jkYm6epKvtYmtqwdT+acUbVNv7LuK5ky
	Y08Em9wyWMF4u3pqmpvn1VY6ZB4WlnpYWw5pxupA0x3NzfgUVtx+JIG39x93egj4cO36qLR8WJn
	fP2yVyHjvsV8dC0/BmqpszwwPClyxhlIKnCyLThcWSbWSE2C+z6pKZgMZ7R4MU+7wXVLJqTuWYq
	k3XHpeF3T7QUuZ1KUHqi/xVqUacQTFbGcM2Y8mTNyTKI8yPog1e3E=
X-Received: by 2002:a05:690c:c4f1:b0:8b4:d44a:c4ca with SMTP id
 00721157ae682-8b4d45a0d54mr2805807b3.24.1794736709468; Sun, 15 Nov 2026
 01:58:29 -0800 (PST)
Received: from 1087654160852 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 15 Nov 2026 01:58:29 -0800
Received: from 1087654160852 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 15 Nov 2026 04:58:08 -0500
From: Yusuke Hayashi <yusuke8h@gmail.com>
In-Reply-To: <ava2WJkDag6-uthA@pks.im>
References: <20261113-http-backend-drop-strbuf-presizing-v1-1-7d66aae03b22@gmail.com>
 <ava2WJkDag6-uthA@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sun, 15 Nov 2026 01:58:29 -0800
X-Gm-Features: AclHuK_n29GegGRCptw7Vjqb2R-XeW5RENmSRiPELzgqPGL9IFzX58ADbxDhdAs
Message-ID: <CAB59oQ_K=AdVk+xXVPkodP_tPfGWuLO0fqvBwJAz2tvBAxrb7g@mail.gmail.com>
Subject: Re: [PATCH] http-backend: drop strbuf pre-sizing from get_info_packs()
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 13, 2026 at 08:03:52AM +0100, Patrick Steinhardt wrote:
> So this explains that the behaviour is buggy, but that may lead the
> reader to wonder why we don't just fix the bug. And sure, we know to
> grow the buffer automatically, but the hint is intended as a performance
> improvement so that we know to allocate the buffer properly right from
> the start.
>
> Note that I'm not saying that this change doesn't make sense. But I
> think the argument that "others do it" is rather weak. The more
> important question to answer is why it's fine to skip it in this
> particular function.

Fair point -- pointing out the SHA-256 under-count and unchecked
multiplication without explaining why we don't just fix the formula
leaves the main question unanswered, and citing a9ce8526dc doesn't
answer it for get_info_packs() either.

In this case, get_info_packs() is a one-shot CGI handler for dumb HTTP
GET /objects/info/packs requests that formats a single response and
exits. A typical repository only produces a few kilobytes of output, and
even with thousands of packs strbuf's geometric growth only needs a
couple dozen reallocations, which is negligible compared to CGI startup,
scanning objects/pack to populate the pack list, and writing the HTTP
response. Meanwhile, computing the hint up front requires an extra pass
over the pack list.

I'll send a v2 with an updated commit message that explains this
directly instead.

Thanks for the review!
