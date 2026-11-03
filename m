Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793707950;
	b=NLIBVTMOP1AZuh/WDAefzEuQhTHt6lrdCDPyvHHN0QmEbFnxFd2Jc3lbkqBmPM4ZT6B+
	 C/O0pbl7WEOG0yE7EReQ/H9L5T4uVFn1RHwl6efVomOuOW0y5FGQp0u3iwyxxznzYvphv
	 rPrkdSZflsQsTZ6LXLg8nEq+8gtxCTK/+nWeGwH7SvIE70S0wzKj7O/kxUqupErWeee++
	 BGNl7o3Z5OvzmBzEnNQzV97vsbzVFZfOVIKcL2HCju5iDPhE0xCqQNikTl0aGJacSxm/B
	 xvUPZAqejCJpZL1Gul1zUDrUexMCaQO5d77U0WYbgNE/C0XKjhtnNMHE+1W5kghKCOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707950;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=mCnJ0S9pQvAnxegZjzlj8fzZR64omKH9kAXdjvNUDVg=;
	b=0Ul0aV96Y+lRJRHM5KO5PTPPp2p1SuZj8/ANT543OzfuOL+SDRDoZYFTx9wCc7baZts4
	 dxEpPwnnnvFDYOjXzqYjios9rTeWeVuXHrONXA3kAgi+mOfIQakCTDBzn5UV/lcmwNa6Q
	 1MpZa9WexWMd5AOFUe5x04ZiBWrsU746y9U1CXa396mXU8GMgrNixp1J2bBeJ05LUc0gt
	 4Ul2YgbpKHx45tSoQmNEUO2T0e055p2LXx+diwiiKfG5S55qyvdtPO18O9OG3oYXf2ZeY
	 4PUvTe1nTl3LB3340x1B6SZQqbRVWTYIMpD3GNkxwCEtQaJ+1UHOl+H+HHN1a9iO3TQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Tt8/96iy";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10DF606D80B
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 12:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D10DF606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tt8/96iy
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b2d14968c9so20953487b3.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 04:12:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793707949; cv=none;
        d=google.com; s=arc-20260327;
        b=QeTrIyxAYImFRaHClj8XO9SfeLF3nmF4RgGahFwQwgKKtQYsJEIb1tBefFnTcn+MYX
         Z4my9ZMyXeuDczDAJOBPaBvuAxpPS7ZEf49tu1gD75W4GfdYsHiobAC+MZuzExkib7Zs
         TEkKHDQye1zGCB1rIrTMxJZQ72LDDBNS5hOMH4wNf9tbbve4JGVeCo9mIiOKBu/7b7y5
         XN2MCKWxk/B4TEnkW5psZ+KM6745vDNkHnjuMgo8wTTiOM3VwxcjtpIsSYDgCZo3HJr7
         JMJT6AYEypjFOtnC5ajm5aAYSLGsh8UyX9Tj1kB7dlk5NRIvZo4c8vbo+texRSEIRIyt
         1xuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mCnJ0S9pQvAnxegZjzlj8fzZR64omKH9kAXdjvNUDVg=;
        fh=PAjj1C9K1hPPM4TqmxTyFadGtAoFxDNtbjsyY4NMbPQ=;
        b=i3JcRaI8su/sq1lOcZ8mZ6wDtGUP7NyBRhpscAwNiT653zmyHOIlsPvQRGrrF8PAn8
         N0u60GAFKpwdUhpnNQykfSPQlylf12V7B9HJN74vmsOLK/OJc9Mec3Ij7hUk3Shrynnd
         A9uwZJDqNDl7E6bWDr7xSjxAjbW1BSRuhRlHfDp3BL5NQdIDFl5yTU9Zo3R/5KaK8j4o
         iuKUDXskcBG4DGCfv8PHQubT8/VUpXJNJOEDuCfETIU54NzdLNmjZWZMr1N/aWFKuePX
         iAE9jClm+IJ9QGJkUN6mtynHM/nOcyza5C7pxSvLWjPXqHeIzDjyhv7vS11HMGz6uxhe
         ojzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793707949; x=1794312749; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mCnJ0S9pQvAnxegZjzlj8fzZR64omKH9kAXdjvNUDVg=;
        b=Tt8/96iynNAUgjNDPCySSAa2uFYRgfr32f2F7H3XllCnlNsk4RZ0tgKn4Wk4I4j6Tg
         Hq7a97ZLpjD55XfUnDvTNhWKvsIa2Wyqk7EOmIq9E+nPLyJ/Bj0maZJP/b6yPvuFgEgU
         CvOS8Z+anMSMdNZrA/o/k/SRn3eeUlNGujDEuB3RRIDIIRhcxUr43PnkCRjLgqFfCOJo
         ldxJWcIJCEMOkhZGCsxf2d4EieDQ6tJZbTMAENhiTs03IMN3cS/VxF09pWySs48YFT61
         MaM/IwoMGl7xDpngZzxOJN5H3Uw5/N8UEPZCieIrdmwAr6XtXGIIdm8JSc0HkMi936Nr
         jjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793707949; x=1794312749;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mCnJ0S9pQvAnxegZjzlj8fzZR64omKH9kAXdjvNUDVg=;
        b=HC4yZFr3HcdSeextc5YBP/+m91+2AYbDXkaOatVEz+tcQWuwDwGoXfSwPP+scHDVzk
         G5z/xDhHnI2pq2ZTHDGn6ynaBr+UknlCDtGXk/ZbHKhA5ZdsKlnCuo0RXItB106NjAm6
         1oQcfaEsOI8E6+Hv8NCOaHWrLEDYXdw5XRdSBIU17IrttdBH29C8WMAVIjpWTe64g9ad
         /jIHKaZHdsdAJE/nL5KUVY9xZTLq0aE3I3cIUG/Cyvr6VVWpxsbMrFdNCMSL5Q6VL1wS
         edZ3M54FvnmnwNgBv2Yo0EsNG/hCx0NNYJdflpXPeUAQ/Q5IzCDdL8Gel16iQNgLR/bj
         x+yA==
X-Gm-Message-State: APuU4Z9doRbAXeoFsj960ed8AXfvZTil4CTwSrQGw3Hm8kHC0gcQMFHS
	67ZDHyLPTUkxRDq8NA9YNwBO13Uu8cLbK4vYrj+emLouBlNYw3fRuIUlmoV3aHPqFRUuCOqPIF1
	jj7zcJjHYGKZQ/V2FoOsK/Z0dm4CZM4o=
X-Gm-Gg: AYBFou1AuX9VA06zGyJcut4wt9SCb+Oqj6HvcC08JXllh+i16HmZ6a7M7nk0U9QGi1Q
	urboOTOHc+xIVR5LlCs2M1SsqjWTssm4Uda+e3WVsBK6eBEoBfSRUMYOl7Gg3sJjPVBJxiLwhLG
	IldtPNMduKV/d6JinNBgN050ES6pyTFVzSP8BVemDVTtTGGv3qTfdRYxyKbgxAhmI57PGBsWYV7
	xlQVAcbZ+xJoI49xSVBVgxJuDymGHC3Dp+O1CcqkxqFRmDBmgag+2m9fivo8JxNjAAJXdZe5DQt
	yOE/q7cDDF9te1SeNguAWBod+InfjhFd0J9m42ytw6nOd2giZ1SiLLVzSMm/RUMp9TficU7MKaC
	W3WjXDkrc5+8Cllvj19n5a8fqz+Ds+x7OkcXcEfN7yyVu8L4/eyVzqzPv7xnjUOZ1Jm0rrcHdkm
	c5OWQWoSccphbb2JTXILpbsnoWK8W5Bkc2B2ddBhF31qsmaljDv1jl1DiZST7tdDYWIP+qPfeld
	L/uMJPduGo6u58Ib7eXC/CDT3xotAnk4fTz33Zq
X-Received: by 2002:a05:690c:6b01:b0:8b1:691f:aaf8 with SMTP id
 00721157ae682-8b2b67d25c7mr66398517b3.65.1793707948622; Tue, 03 Nov 2026
 04:12:28 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027153429.14131-1-okhuomonajayi54@gmail.com> <CAP8UFD1BW7qEWp87j+7B12d=eOu80Yv1=Gf+ibEriV9s=4umag@mail.gmail.com>
In-Reply-To: <CAP8UFD1BW7qEWp87j+7B12d=eOu80Yv1=Gf+ibEriV9s=4umag@mail.gmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Tue, 3 Nov 2026 13:12:17 +0100
X-Gm-Features: AclHuK_DQ53I-un1TzbNFLB6Re7eoKWDZcWr-6VMy_uRb6iaBAA6blQPhGr5uQc
Message-ID: <CAFpMFfDeGJGbdCx-boKAe_Ab6oPuW-aunrdqAjtSkgqgWyhqrw@mail.gmail.com>
Subject: Re: [Outreachy PATCH] negotiator/default: stop using the_repository
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, usmanakinyemi202@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 12:50=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
> As you introduced `ns`, you might use it to simplify the above line using=
:
>
>          mark_common(ns, c, 0, 0);


Good point. I'll make that change in the next version.

> Many functions have their `struct repository *r` argument as their
> first argument. Is there a reason why you prefered to have it as the
> second argument?


No particular reason. I'll put the repository argument first in the
next version.

Thanks!
