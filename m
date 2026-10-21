Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792616701;
	b=iM03L714WU3iBkZ/NVGAQFMYAx1+lafqeJzYdy1UVseyKc1tlcNe4Xn7MemxB4RBAKX8
	 a8vpAL/+48N8DaSOPBbw+MSuJR6Rr6MwpF+X4/W9qAt2+P/FU8uR2KxI1EtOLG2kmh/Hj
	 VyYTBWSoYqyvd7lyeGUcJMUhBdQnIxAlcCJYlMrd9OyLDYAeynMgYbQUpiFZKV7d8SKNJ
	 bZbsbktqpe47ak1dpBqS8wjPa/tbaCERN1ABdndP4A8GmcXQApC5cmewC9te0/VYsSJXj
	 nKL0oP00ItzcuM69O+zimRSA55OUVHRisYMs7rOtmDyigEvWf4PWbUqDCHQ61cm2EvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616701;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=alZoh2vctiK5x0m9fQEfJfzCU0h3IC/kYycmyNgR44U=;
	b=2d/p89YjKcey1HrS38Xiz/0IPo/9FHIyV4KdA95Jv8QmjNnS3Rzz+N7vJLBi3pW9dxo2
	 Ax3sPWwOktlhvuSqSIgVTXXSc0FDLnTeamGjgKd/K0I44BQISZ9vbPb4CB9f5AxF5cFUX
	 VJpTHCgz3p1PiAsfIq725XTkSZVOiK8Y/j6j/VTkqlrT28Xpa8Mj4uBk76ITS6vpXhv8G
	 18Zilz4rdl/2WKU4z3OMXdJI+YA+MQSEKt6t96+pyGbXpTdOSkG+9wZ+QW/BGFAwvggpQ
	 a52+fEhVy1ihpV9bnEtrGuRArfagR2guzQ8hKqBpZOXxx30HUj9dc8TX9QxTBAiL+Qg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GegkdUHz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B43606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 21:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52B43606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GegkdUHz
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6fe4372c5f3so706040eaf.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 14:05:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792616700; cv=none;
        d=google.com; s=arc-20260327;
        b=ABLI40oFn5J++zKkN4Tn9t2svxYOuQ8IUrwyFIpAWeOjJonzY8A0335DLNyceBCxW+
         8Z4FO9TqxOsJEiZFPkk7Ja0IC51hamSqwISdbqtV2H5vpzDp8eux43e6KuNX9963KN7W
         2kRKCfo7gNF8mMPxkrxHKF7KOTZPHRwR7vYu9Gh3lLbhmD6jpFjPGiwaoD4ONcg0i2l9
         VAN5dY2vlc8DtQuIUclj5IvezJpLRHy5ZbUNV9/fo1IjfOGlL2zRVkd6gd56fgcrccJ/
         X1d6Vgvr6PvHfs+H1olTD5L7ygArahpVW6rZ1H2B1ML1bCTEMvC4ZkObKArhNN/LeRjx
         0MOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=alZoh2vctiK5x0m9fQEfJfzCU0h3IC/kYycmyNgR44U=;
        fh=XZcCFkMiShx28GqCLAJL+SNMEyltE17v/JD2B0r8B6s=;
        b=U2na5Tf+cQxZiGZIpK9g7LIOXOw2qzxWyX0qZdJWtw5Tf/5qTZU41ywPFCwt6h11Nr
         1yNIAA1nGIdHvx0yWzsVqxPZZwn/pDfVKJ0vhQ/OvxobSuORvaP828KSqLAvOJVM39YA
         19ZYg/lF7wbToJCVi9oyu31ji8t1e+Gcix1iEUpePDCtsx7BDJwS9ZOMT1RLIPv6COWQ
         B1Z0iFr9kFrx9BUehR2UB9C2OxRVh47Z7f/igPl5Vde8bW2iUYs1qEPcw9WiIRnRb1sp
         pxYPstxcXnLtybFEpu3ZDn3EaDueuKD5Fyh1GEoWWKcMIylB4qseZYnWxKqwFxWc3aHN
         TujQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792616700; x=1793221500; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=alZoh2vctiK5x0m9fQEfJfzCU0h3IC/kYycmyNgR44U=;
        b=GegkdUHz7mpKOmECpswR6q88hPVoRzsZ2PFpE1oqC5M5xb0kJrWkUWcmwxfyhax2YH
         LkcE6nsxDhPcpIZN9I05D88KK8W07C/npcucNovTXLG0LVYogLIiw4pXqlbrlTUT8Jcs
         5HIbrAI9/wgj2wUMIPRDhweZ2sVD8wdrncMt1cwG1LMf2yO8GqmmYyASidWEznCtyQzy
         ado081YliyYtscjJNb0/+1l4m+rvl1Nm6T++lvok6wZ04iu1W4n3LpxDIuE8YjfpnUSU
         UWCAz0VdnL3FuiZPakwZufz/qYyYQ90h2Pb9Rq6gM86y4MLcBQzEOvPZGla7rc0OQx4X
         fIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792616700; x=1793221500;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=alZoh2vctiK5x0m9fQEfJfzCU0h3IC/kYycmyNgR44U=;
        b=nfLMsphSb/dUXkxk+NiRMpcJjUqLJwerouH9mhrYqFQNwAiT1iPf0Bla6MAg3br1ff
         UKG6My/FBwjLlkexvTjlBVIMWwzHP2Ol6FL5tKjxzuWg7kq81x/3tsxDE3WziAnvQeAr
         mirWWV6evMkgjDeYHS8lE9vLnalaIYZd7sZJbDH354JGt/4NnBVFDpDz9IrRkjWhrnLh
         aKuok0qXpRNHcRxm63S7Hjx2641oqan7KBDULo94bZPiUhLWG8BmDHxYvu2WoCGLjrqg
         rCYBer88ijvAl82Mu0TDs5aiLOmf7eDS6ikdXJEkM6RBYpV6bUKOfnVsdE1oMMdbuntF
         MwaA==
X-Gm-Message-State: AFq9FYLTu2efNIETWXctF9SZj//c/za4+WD7ULFdnx2qxYbP4CxE8Clq
	ptQPQlMftLen7SQVXIEL3Yg7vabUlHucGBeAF/flOgwOFeyN2sjimNOcp7JrjyjAPpweglnCzSh
	KnbPGOnXrTujUBN3HOE+y0YagCUXRuAg=
X-Gm-Gg: AYBFou0KIaNZ5y3LqWfd8scW59xeFvOId2gV5FWxKaB3P23uiY2yDCLIE11dUrByw8F
	eDtR81D0Numt61/oS5+ZJ5FRsVKnKVVy0jiGokLrU5PAftnfTTMwcdJuUxYS8gN/vaht5Z9rBDU
	YTaxFJffodht2jkUtxOBTUBms0FfZ5TxgjiYkYfsVRc+dwVseviaxHtUh644kdDDjrAvIk97MFX
	Dfw4Rkf+iTHsMoU+Jsx37QYoCnkTz9cIWVYnVFVA1aR3SrzAZDt8GGKEyc6hqBYhHvL71BQ70Gx
	eKNbhQirxDexP9VAbmZpA88co23v9VSYHoMAR1E50vKFH8dhHj4ZbRXOSEM2FJY1AM0ToIxe/kj
	OvyiuKOBzIYDdr3RvtvdywSD1rnrqj2mag+Zm6KdxH/gzdPzs2xeXYnJr4ZRyrEnB3laCFJQFDo
	jcoWCGD1/mXj3yhPGk/fRKEZegDSJINIsgfPc8YA76h6wyrokqZIqyykMNzwokEzwtCGy5h95CC
	J8Z
X-Received: by 2002:a05:6820:2d06:b0:6c2:396e:b991 with SMTP id
 006d021491bc7-7094109ae4amr1995708eaf.61.1792616700224; Wed, 21 Oct 2026
 14:05:00 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021022156.119947-1-tangajoris@gmail.com> <xmqqv76vnd5h.fsf@gitster.g>
In-Reply-To: <xmqqv76vnd5h.fsf@gitster.g>
From: Tanga Joris <tangajoris@gmail.com>
Date: Thu, 22 Oct 2026 00:04:23 +0300
X-Gm-Features: AclHuK8f6mJvoKsWJpS29I9yaZW31AMOLLUalOnGHvsF3ULi2rDqmdriOUL6mHo
Message-ID: <CAKrRMNqXi12KS=JehLm9rLQpuZbwFULmZb5tHtZQ-HKTTp=OSw@mail.gmail.com>
Subject: Re: [Outreachy PATCH] checkout: use Q_() for the "... and %d more" message
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Oct 2026 at 21:04, Junio C Hamano <gitster@pobox.com> wrote:
> Is the last sentence worth saying?  I am having a hard time
> imagining who it helps.
>
> Translators of a language that phrases "2 more" and "3 more" the
> same way now have to translate this placeholder twice.  At that
> cost, however, we help translators of languages that need to phrase
> "2 more", "3 more", and "5 more" differently.
>
> That is something we may want to say instead.

This makes sense, and thanks for the review and suggestion. I'll use your
explanation of the trade-off in place of that sentence in v2. v2 will
also convert
"only one reference expected, %d given." in the same file, following
Tuomas's suggestion in another thread [1].

[1] https://lore.kernel.org/git/20261021110616.Wxkhc%25taahol@utu.fi/

Thanks,
Tanga
