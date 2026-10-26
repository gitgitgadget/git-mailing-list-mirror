Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793059029;
	b=Vd1mBOQBiEaLYC+He/XvmzP8JgQZlpZjx9ZtHijM//Y5qXC48ISv7loE88DWbqdCMRaJ
	 yD4Tvx8MwJL3gjXK2xycwcmCkmhM2VkKUHcIU8M/A6eAPrmO/JoxBLmirLLZPtuFtGqAF
	 qr1HZi0Z9kix3iMtrHIy7RGmTqvuDjd0t2Wi8naakf2yM98v/pVrOl1/9L6A8eGs3FCrd
	 TNo7NYKlch1AqdGlHuUtqe7Pe1UNqhoAnNmXw4tA677qm7V01U2zg3edh/oqcKPizwCAQ
	 CtWy4UYh8wcMmLkgQ4jyZjRNl4mt2rkdSqaBt2uXAujz+rOahFB2pHbhNc/4GbRQgtg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793059029;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=lem0VZYYE1yJpHFp+OGk0vQ6PxVE0vnnZW9gzSJPGSk=;
	b=iw+p15mXLo1rTl/NKHacMY5IPy4/DRu6frjnmfEJKysYSoV16o4aufGOlN1pYN314RB7
	 JisoPMx6tXyMnAVNoLLqqOiHbIcU46pw5ayP8E65MEmf0HetWoMKk8MD4yYggxdm9R29B
	 hkJnXuCwU/PUj+8B/hSeKc23M0A7j37EXfmyiApjBLK6d4ZWARfzmKLsHst70FI2eJcl+
	 DNMz9SrmbfDdD7xlfGX0JkhhPYMyZ6WAOYw2g3Q78awq7rFqKGbAh61pXS8fIXAutN0RO
	 ZeRaoG9NQSqqruDQ0ggqsn6LJUHn3qO5mferxaVESsJ1lISOPOP8MycdA01lzvCO08A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fLOVBlP2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9D3606A31D
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 23:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A9D3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fLOVBlP2
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6acb9c018ffso647248a12.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 16:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793059028; cv=none;
        d=google.com; s=arc-20260327;
        b=S1BGPUvhCtP9zXvaDn/U41VW/E+Da6sFYk/7Dx3JuRlLO1QwNreWIn1KMQFz3wImy7
         W7LIb7DCRzYfe+EsuW0l4yhH1W429D1fpIojhfjEe/J3pBXAYEdTTd2eCGqNsmODsFkv
         o1HaIg11KQqIcnH+tyPMJlvz0YFoSzQBL6wBseJ09UH9JzMvGEbf0FMDGwWEhAPstdBv
         tpxUSTYOku6lrm3C2F8qB9vQGQxyYxNeav8GM0kv57iPDBLWMPx6yHpcVKvm65Jp7I+C
         uUjyBw+Y0GSorJZwx/TvWr7LjfNjbQFnlCsMlsfT08cstSFJ3chcz1GAHDVy8Qe1ab8V
         9IOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lem0VZYYE1yJpHFp+OGk0vQ6PxVE0vnnZW9gzSJPGSk=;
        fh=tC8xgLhcehYtH8bWQojm0E+Xx8XGYiR8+AnNsejDUBw=;
        b=rVnvesL8LrAP5V+PVI1WEtpAXuOw8Lt1o5EcVQiC7z3bDXcBkvAIDTNXe1V4GG02bv
         SQsVcNl1jJ8MzncC2QwM+jU2CdcuvaYE60lZifB5U32ppKO+iu4+Ua+NMCfQRccdrcPx
         6rXQ/WaglQxPOBse4hlCct4dnRBn/PJ/4XCu+oYPnYwO3+2wgImZxEjE15t6htmi5tGn
         GzmGRtukUtQkbCOEvxPeVKfdc0uuCNhKrJ2eCUr4X/XNF39pRoIJGRDkAoIxkXBV9qS8
         spzCUfBw513caijCMcYWcEM6mW5iSHMGI18bZY3WOqPrQxf9a/+GA4kJQwfgTF4BdzUY
         /X6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793059028; x=1793663828; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lem0VZYYE1yJpHFp+OGk0vQ6PxVE0vnnZW9gzSJPGSk=;
        b=fLOVBlP2VRUhB/vWBX9ZActKVHrbypuOck24t8aijF5ogKqY29dQNz77mYn9iZOGoE
         W6LDoKiTdPqJhkO3pFW9aC8DzPis3Xto2fyo5LYkhR74sM5Rl3XEXZxDfCwtUqB5PPlf
         oM0uRwRHcgGBqmebXmRGYHv4sWkGg0KrJ4zXL944glZyvnjeDweS7jVBo2WDSappw76M
         9Svq4ETDZfACynuxEZwY8p3V/Dsk9Vt7HL81KP73PlMB/lpvt5lcMe3K4pR+TJS4c4Ns
         G4BkltSzA0GfKrCqW4rWHs/1oA1E9f6s1nYtyYPx70nTf4AUVJEOnBgIylIcHCp8ScTM
         KQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793059028; x=1793663828;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lem0VZYYE1yJpHFp+OGk0vQ6PxVE0vnnZW9gzSJPGSk=;
        b=WypeZXtzuzaEXoXzw14hQ0DXe5DHAoxnQ1ZPosDtxlRbjG2vnvpo7uTWPyZUO6ihlj
         h+5wYfXAvL/AQYWNlaj4et7SNn2hZDVp1iQxKdz5f7LenQRy3yR/DoHQ6+VkT6caR9jF
         4UArxMPmXRNrZLiwq8jMM7UNby2Vc0vXb24Hdgy28Kq7PmWlBi8a8z6xeeLaXXdd1uh3
         vCGlEAaiPQDIFstoatg10+VgGd0arrRC0JwfXCPlKrixWz3dD5BUwJHSRFVZUOtMmTdO
         u26+Z9YpBrhyC2ocT53Gld3TgLH0AyxWBTe+7zNTaQnllY0AoeW0CljNnaLPEvtl5/ME
         M8Gg==
X-Gm-Message-State: AFq9FYIQCFKZpdFl0Ov2C2SKmj9++1SM3JBr2WAzYrnMwJtft/ao/40J
	KGEvv5jVHmacVpeJpSEBYmgzkqox8KPQiYMiGsAfaRSOFLNiQCp20zTZ8AtgxHHVR3jvSw+UCF6
	z8F+gkKvNuoAKOrY5QO5R7gxRZBthIXUjpjaiok1TsQ==
X-Gm-Gg: AYBFou0iwAOcm0pPg0MZLEhdqTMwvhDTzt3N6ZjUjzrDOiFWDenvNiQwIxz4zXz7bKL
	TKN7+aFNWjg07YFRWUaGWPsi0O9es3iBGhKwpJA15Mlw5nxomz6nQZf7aFH7dIVjYacmHh3lK/o
	k7E/QLLwKYMGkG3D//eROgjjnzmBhpFq7joL/zI9Arbga7LPlS/fY4HsKHZOX/QRQiAIdW/aLen
	Po91+bVtU7QMUYr3ft1+3eg7VuFSbF0oeicb940F7QeIEI8ZfCagHWD8MYX2Lpk5Mfg7dvQzVYf
	er1KqKzIDrKPV6jS/f2hbfQV1CwLCZbHmRjBlHVJjg4+oDFHXGmFzXMzk6uRsTWcca+mh7OAze7
	MpPLTVz+4mWrkhTnZJaE/gsdPr+HFQMRhVOpm
X-Received: by 2002:a05:6402:5625:b0:6b4:1916:9674 with SMTP id
 4fb4d7f45d1cf-6b47bb1903bmr554045a12.5.1793059027455; Mon, 26 Oct 2026
 16:57:07 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAOcE0wJ88hbd9n-A2C0RxksKVtnt76u4vGxvhQ4rdNDEdGTmOw@mail.gmail.com>
 <CAPSxiM-dxHUE5tHf830=zHnLfg1U5jyb211-ZODS7bu8OjqEnw@mail.gmail.com>
 <CAOcE0w+EciSBZDTTNzbi8hEzZAZjB6gut=Pc9qB5yEgs-w1f2g@mail.gmail.com>
 <CAPSxiM8Nv5mnWoFVjWE284yhYG0rdLmfXN2xbZpm4H-wO7oAng@mail.gmail.com>
 <CAOcE0wL5_+m-=qSrGV8JcunTgpBKGaustYc6xgKhKuCrSzP8kg@mail.gmail.com> <CAPSxiM9Wuikgx7VHVhAycYNAxgztyGH-urCY-oe+hRNBmFkmBQ@mail.gmail.com>
In-Reply-To: <CAPSxiM9Wuikgx7VHVhAycYNAxgztyGH-urCY-oe+hRNBmFkmBQ@mail.gmail.com>
From: Priestess <herroyalpriestess@gmail.com>
Date: Tue, 27 Oct 2026 00:56:54 +0100
X-Gm-Features: AclHuK8m71-asDf1LgZ476OZLTiOzZjAzSS8Mk4Ome3lNkF6EF5YhWiBdc1q_kg
Message-ID: <CAOcE0w+F8fO8a--CtVRJXs_rtzF4=YsBLk8+AAUUxMs2edd7iQ@mail.gmail.com>
Subject: Re: [Outreachy] Applicant Introduction
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"

> Since Patrick already took a look at it already, it is more than ok.
>
> And there is not need for me to take a look at it again.


Alright.
Thank you.
