Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793703106;
	b=ntILrM7t58KLwTf7U8wYMrNh+ieErjpV8j9RcOI1RznMWTvwRmzMHmjfptDIT8HDfoKH
	 FSqH4iTdgxDrrZqnB/irY9ZHzt2Q9aOe95PViEezaYHpybpd28J4ghmwM8XoGMc2P6okR
	 4GjP9a6y2HdI0qbxEBUWaJssdYz7PO+PiuOajdwFJfubZqkqCE3EUo7YYToC7kP4wTJeh
	 0+c/DFJtUeb5PeO9UZ9fFn1mNILni55olTPVrthepXSydUuUTBGDnN9JUv2BMfm/nystb
	 D6ZkilS8UAWgfbpChfxH69tRBDBDJzLx8D09TJmxSjZDSez5GPYh/RfXHmjFCEkdZaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=D/1ZqhcC7JeZ+4fcHSpbDIsLFyuSysefblyQ8ysO7ZE=;
	b=jkm/NUgRgUeRKeUQGPyEXjXedi2EcrGpkTbRzsnpGhDabz2/ok0660euL+fw6uGJDOL6
	 Y2qgHYbezSHUeIDNlbamSmal1SIJUasF3NK1LyVJa/ZTGRPveDBU59a1X7qiRptNuxinF
	 k+NWZRd6IX5mr/cXoGsGb80E3ubezxZHOizgtleBpRS/SA3E3XMLsDOSbebtvxxR5Jf7j
	 X0V7GsLZmQOAysqVKlzIihUhXcjCR4PA4VPKyxbLYlbhO70zdmzMEAY4BtYUz3cvS2jA5
	 IWMPBxwivFwzjztgvYzWeQptbT34jMskkkahemtOPczLSKO5983obzLXM9V9lS8ON6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=cEorUyFR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F529606B116
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 10:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F529606B116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=cEorUyFR
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b4bd3d98bfso4750654a12.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 02:51:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793703104; cv=none;
        d=google.com; s=arc-20260327;
        b=nQBUmAku84sPYmOEOo0VsWQrpgd7FPiIxYUdjF9l0qB+nGhpSD6kBJ+oStRP6SU97I
         Wz2A8df0FmTtUOgTxCwW1Rf5lfthgJt5aJMzfD0bubtTvlR9zeZINPuhNLGtnnbIHL+T
         LgeXhknmRqezD5KDN1aIvCWPED8tUglyCtEJFNXrh5l1U1faoNfEBogBryoa/kKiWL9F
         X+xqpPqKMHJWoS278B/SBXfkJS75LKmEsObftK4CTuCp59h6hUH7KTyshMfojnZ7JYK2
         cCZhB6VrFLzFlCVtx5nxukd8JRXSKPC6ZDcqf+l/P5cfvaBaq+oYHSCcIycuaOk/Uc97
         um/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=D/1ZqhcC7JeZ+4fcHSpbDIsLFyuSysefblyQ8ysO7ZE=;
        fh=h3xP+my8az4RPv/PgBtVU8VjIcURMZdtkIXOfUPIU0g=;
        b=U5PnhaxJv7V/lcjs4gJQU1+GcLLOZYWFwVVr5F08WwRL+q9/aywFdnwGeFtWQbQWfM
         h24JY0csYCDAlrp3M0YTt3HazWAB/S6P07KlXI9SAv0ES4VMafx6LjoxXlXUYCgxEAou
         EKqEgoUBWDX0DhaqjbvWcF/gJAkJzxfo1+fuVaFxH7ZyfXEWpRLravaMM4S1ZvBCJ6BP
         vyxXe6GRlAubgqqGVy7DyEl1pLhm/up+P4DtXSxLgifvje2v157khqa7btmbw2NyRwe5
         4mhkdzIXIcYpKmEXQdwrYdhWrktKLyY2yEuHGckkxRlQ+JIz6BfqoJ7aSgMsCDfKGgB3
         Vkog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1793703104; x=1794307904; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D/1ZqhcC7JeZ+4fcHSpbDIsLFyuSysefblyQ8ysO7ZE=;
        b=cEorUyFRaII1X4f7IkjErJgPaUaOnVKIhlQNGUzgT1q1QTr3AJZt6Dz8hZZteXL0V4
         o7yKX4FzkbijY7xetpN5Y8bT6HUcyTG5poGpP/4ytLq1cvoL78zGmMekfnQiECYbc3aC
         Td8GcfDpeOC7hs0byQJq6W6t0rZhO/UU6vr9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793703104; x=1794307904;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D/1ZqhcC7JeZ+4fcHSpbDIsLFyuSysefblyQ8ysO7ZE=;
        b=ihY32WAnezIUB4FLREsYMUcJLBBiFWL+Kc4KO7LFLoMGx/TCSn7jalsrNUkV5AoXlR
         HwDRIQ4MH+G8rlnsCag/mq6Se2Tnyp/9BMsCb2mJ81ZaSER1g3NfLgy0W7W4riDc/EL1
         knKClFp0WXTh4u2Z5Yb+Dxu55Px+d8SEvZfTArU3z3bMQUzYGN3pkFn/99CkPjfM7aq2
         XgsIRXq5rFQ4MKeWzsvnBYKf8FOrV1nWYze82yerYsW1/XuG48tHLYdHZjhKEz63oBCb
         lTIZeTi2FcW4pS8AHMGIJfUVRrYxdswteQrmbGBSYHIL7ut+DTZKGD70VLiSWfuXqVyf
         VL5g==
X-Forwarded-Encrypted: i=1; AKwUvByJ1+G4Tqz6J4N3QfDOdusjnQxPKmT61Pz9L+Mx+WCZb1qgOJnPbI67eMLGZR5oEO5HNhE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8C27aUJdLGJ0ZlSyJ0+qXS464YK7jrSUPXsIyW5N2a55ERfC2m
	V4vx2vDYDcDy5KJdoOwgDW8DhhOYGfKRjcwZj/uEboRfqSjUB3vqoH+wS4KfqdJYFsCyb/Kvqae
	Xa81VHRry44FIWQmvUdxmKSbB9OpMxlJUXCLItf/8Nw==
X-Gm-Gg: AYBFou3WUUWDYxP0EnUt1z30hFhNrORdWlxHuirW6udj4zuXYKergO9Ei82ZzyiGBPk
	hSCiPnuGf/7VYnlflFJgL0EGRGRHF5M+yhHBLQY5ixz5omOwYwjhGwl19uKJascoLX/xOdkanU8
	MpIAq7rtC0lUT57ElPmSDmkplzpKAraSwrFJKUkyvINPLDoBZHU2nPH/jFyZA+QBHuoN7NMnWdL
	rJEBT4IjkrYC0nhuDYLnFNg78UbL31gZ7U9BC+xyR0xJ7FS+QFg7JVucw9zFY9m78Ewwp43sFya
	BVfQG+rtiPgcFxR8tzsFrU9qFitUWMm4mOiuWt2CQ4DQVBp7EHzZEaVUWUuhG4Wk5+k8KAJ/3WQ
	CD+MD2cnROgDivNQXVzZue7XaOO8+WyGxxA3wXAWs+uYORGlJQPf6Z+lvaRg=
X-Received: by 2002:a17:907:1610:b0:c46:7de7:e425 with SMTP id
 a640c23a62f3a-c4ca7a4b2eemr1054071066b.16.1793703103945; Tue, 03 Nov 2026
 02:51:43 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2279.git.1793634429929.gitgitgadget@gmail.com> <CAOLa=ZTKaJhWHuKnSxL1pYN_JXdrr1Eohy8RepqFRc=Qph92Yg@mail.gmail.com>
In-Reply-To: <CAOLa=ZTKaJhWHuKnSxL1pYN_JXdrr1Eohy8RepqFRc=Qph92Yg@mail.gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 3 Nov 2026 11:51:30 +0100
X-Gm-Features: AclHuK_kIVGY25v0HqDnsV3GPF5e5Zt92jfTiUkd04P_yLYciAJLZxw4aGWA8Qo
Message-ID: <CAL71e4NYpaOqeXD2ZxgzM7g=7HiwEWoqBsPSTHd8NYJuPCHc0g@mail.gmail.com>
Subject: Re: [PATCH] rev-list: ignore replacements in the connectivity check
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Nov 2026 at 10:54, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> Nit: Should we also modify 'Documentation/git-replace.adoc', which says:
>
>   Replacement references will be used by default by all Git commands
>   except those doing reachability traversal (prune, pack transfer and
>   fsck).

I think that sentence is actually more accurate with this patch
than without it.  The connectivity check runs as part of pack
transfer (fetch and push), so until now that part of "pack
transfer" did follow replacements, contrary to what the
documentation says.

The list was never exhaustive either: index-pack,
unpack-objects, commit-graph and multi-pack-index also disable
replacements, so we can see it as a few examples of internal
operations rather than a complete list.

Thanks,
Kristofer
