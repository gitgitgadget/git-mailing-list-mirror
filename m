Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795638998;
	b=OzRlckuIGDbXKnaRqVU2u6u/i3L2ZlE1VyTtCHZFOx/DEzqeG1/c2mWxX9Sk02Asr8CU
	 RKk+acdA/NAkwibZkspvSGkLT/aYRoWoLedPECnM6OoHXu41AP2gjWspEy0ZeLFYvobdn
	 65pkw+mekOScb9sQhhOhXlr+Sz9AjC53g2scOHiFuK88KpewluCWOmv/bqqAf50zyMuh1
	 eGOe0ed2UeJ5iLQ5JJWk3krxowshfHkUvmv14Eqpk0jX8FVeZqlnsLh/jupzL5cKmRwob
	 wxO22odJZWdHKex7KlaaJ/dgvBDspLVZjUtaRN2j2hBXdXCdZ8VdR+8kVrvKxmhc1+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638998;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=NJTGFOT5q5wuP+VSREEltevKDusoIXEMp7pTkwpSia4=;
	b=A20XHKY5vR8CFuIq+hf+YH12rFlbrkSX6ooJ8at4ks4nxoioxkzgs5NY5orN4MasPavr
	 jzsRt4sdQO/wxoa4DTfw9Qc38oCFCJ7IflUj1zGKrvft6//6IhaJtG+Hsh3C/AG/Kc0KY
	 W4wsRpsqzRDilt2hwAwCeZp/9+TrUvztZGolSU7YmgeJ6Fa9QUJXnG4OWof29FdIeRrBC
	 +3ARMP3RPHcFQmmPSPveZCX75AVXFXFzGb62DwkX2Rcllr2wGa92alYaGi0XmsGaZJTac
	 drsEVQsdjRjVM9fi3X6LYHPy6V0OKMde04KZtbmh8l3n5y24zFTkgqhpAGWAddW+WOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IAPae02j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.170
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E48C606A321
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 20:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E48C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IAPae02j
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-53ec9237600so2893540b6e.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 12:36:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795638997; cv=none;
        d=google.com; s=arc-20260327;
        b=fFtVcCKTjDU1dJNRLkBX1N1dDqaH68VeHNoHCfg6VpjhEIwHYt6LnD3HqiL58AQymY
         L2PwU7Y1WyN1fJUupPnwdyhsGs2MAuO1wRA2Y5aVyhWNi1B+Aj8rhkc2og0JsbCoMdNk
         NHEa5HAYENSbmgWRJI4Mx4l+UFaG4AD3S2aEjYnja9s50ZEGnjqyUWgeW01B/J51W5ID
         /bqaMGk9LFgnQUsqRI2zbRatEzYyUJmaKV4gKz/vvJKnYECvCm5yGhV/h8+9W1A0hdM3
         +8626R6rhK/qXRSmbnjQczAHtW90EMSJZg/3FFwrqtUeXhu2uscCICP4MunwjJeRKd3R
         3aaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NJTGFOT5q5wuP+VSREEltevKDusoIXEMp7pTkwpSia4=;
        fh=rbNk5rz3SjCtuSzdQyxuIhSSaGY8HoS+TJc8ANbiNPQ=;
        b=npMX1kB9orjH2m7JtD7QaicW22Q7TMWenGs4Bs3HIa/qEJ9Vg/WBJkzfHu2DLipna4
         H5tMIEJh5AdIpebfcv2xrVX12siIwIazjqIy2rTTUi1i/zao1iHW7mhqhq12ZJIDfxYW
         Ol1+/NbMg9RLOMYLHRLidFnzf+VCB7rM25banEHUDqegorxtUq9XywvxoAwGkzo2knaT
         iRqEQ2ka6KiTWTUYNKs36P2+E8SWnGncB+ZJg0ZQXm9n4ysFU7+nkA13qizd3iHp0ZJC
         ZWim8nIiqAvjaFDp6cjR1SMWsIlZq0iPjTDoKsDtq8Tz6n/R5gyz1F8nFXr0ocjTZmlK
         746Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795638997; x=1796243797; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NJTGFOT5q5wuP+VSREEltevKDusoIXEMp7pTkwpSia4=;
        b=IAPae02jfxjbj5zch1nz7p56d6GeIssm9m4EeIBLEYOp3q9L3Sqla9EHq8Lf8AC4O7
         OyYMGoFpYiRDdOWcgb/m7Kj1kNaNHUoCmi0BkqDu6DIgbuNTMaQVl7izWl2PBKcYWiR/
         xUqCZnliAXv7TnUspXlobjUeoe2iR24rySADEF4WZymNvkDRTJ9c+nl1L0AolQucMzDV
         FLemNhL+S/OTS8Wb2J/Vn2ehAQR/yG2FVb3fcvRkDRn1tX9sj9hdJ1Xx9/tGuUty8z+x
         cY5UCQoGNBPFbWZ7o6jSMCpWwoyF0l6zWsJ442r+BhSeqhl80e5Y8wMpLgJHonX+j+a2
         kcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795638997; x=1796243797;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NJTGFOT5q5wuP+VSREEltevKDusoIXEMp7pTkwpSia4=;
        b=j5ee3SmUdRy7PXzKYMwejt+3w+mWqFQ83jWkO70+h9DCNeEuM+Vn6UKWTB2Lj6dV+0
         DUaBWanJXQSFFLm9bSf09uT+mdntqtJ7oS5vMgzzMPB+JIS9aVT6nSo6BtRjQ4quk74q
         BeeCjUhYmJyygy6FDk8QPLmmXra5LDdQuCB6hQok7rPqXiGvHxzbxhGXlnNGaqc1CTUZ
         sTv4U49IvppzHJiCUJC101lhlSbRBwBDCFvi71kjdfzBV1YecQ/+BM+Zv5EaOvkza+7W
         FcUGzKN9wbEaVml1r73+HDInjliPg1uSUhFqwyWSPo7o8cRa5era9GmdDjRyPQIp+2Qp
         4lJw==
X-Forwarded-Encrypted: i=1; AL+hErGZ9XmdV7+WV7aEjBGdgOIau9vK2a+vvL2g2+ZjWfWc463OHYr7bxv0uciFtWgsVykj0+Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/QsdDujHb+NhLr4sD4MImbmsTDo9HDXfF/ow55jl0bSxtCmb+6
	RD9XR8CDJIy0jrvJB3YEXnanhCDhXPEtNEapUNTbHA719yacRGPJ03tHCOxlIXzFsd7R94qSmIx
	34dcYt+KJpCodRfoSQyjt8iOjsy95Zjk=
X-Gm-Gg: AZFdTZcKd12Lq/NT4rIO2ePDAYpu5MumeilXDv5y2kdoUwtqz6eRNv3fFbukqmxXZ32
	KyjOP//qx1wDiEDxf1SPj4y2TrrMpxp91K9QenmdaidAhglVVytHEpnZBSDlWh1aSm0xsU+naVi
	d/6Q2x41n0kTDdrKY8d9PK5nqtnWd7ed6aGhHNFrWk7gGtgWHwXSWl08E3PwJZEafJ97OrzlY7O
	6CPNURxHKeEmKLe2t+G+lqvL6fNjbLrDNH7MPNh0/OFw2Ua1GhD2JIBRFD9kVr0R8Q3B1QkDUAK
	HzjGNbwaRn0nr31CJB8ifZs86iSWQbeZe7HwCJat4Sab2Ac5pqiZWhiUeQ0QDfHENWpAoTht1/Y
	Ta0bXVcwa0sRXA8dVHOF0xhe0zqBLH98VChhZNzdvokH9pOO99YU6qPitcwGJimi9/DiIX7gGZk
	lYMDMOYCqLf+CFQ7UJdzxIeTwwgeQpqRzMCekWWvbx+Y+yTohh1jnc3IjpPGlEPlxo/d9nkvFoB
	TXqez2W5xnOFmsMYpfoJXjY1V5tjEXxUvsdsQ==
X-Received: by 2002:a05:6808:13d3:b0:531:7f68:842e with SMTP id
 5614622812f47-57a06d1a865mr20387412b6e.8.1795638997312; Wed, 25 Nov 2026
 12:36:37 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105203344.48513-1-okhuomonajayi54@gmail.com>
 <20261124172146.18330-1-okhuomonajayi54@gmail.com> <20261124172146.18330-3-okhuomonajayi54@gmail.com>
 <xmqqtsl5g28h.fsf@gitster.g> <CAFpMFfDnfJRt1HGx60esEeC-spfBbr4KKzp9ocLFceAMESx1yg@mail.gmail.com>
 <CAP8UFD3Pf-0T13OAPO312tm6DdYdmF_-NR6zRyk9-T1h9Qoi=Q@mail.gmail.com>
 <CAFpMFfAGzqWS-N4YBtCy6ar2aJm0TzyQtZEvVUozuC8qghBQSA@mail.gmail.com> <xmqq1p883eyx.fsf@gitster.g>
In-Reply-To: <xmqq1p883eyx.fsf@gitster.g>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Wed, 25 Nov 2026 21:36:25 +0100
X-Gm-Features: Aa3M54p-sIKcFUNJjDf9YK7EQ6DJW__rwF6wYsiWcbiYlsKw_QcEtwpFGPTw8WQ
Message-ID: <CAFpMFfBNdnpG2wp_H7BHQqfQ7BH7RUzQNut1Rgwz+2zZ8_AWZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] notes: use the tree's repository when reading notes
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, ps@pks.im, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 25, 2026 at 8:09 PM Junio C Hamano <gitster@pobox.com> wrote:

> Can we have a single helper function to do this? Instead of repeating
> the three-line dance all over, perhaps do
>
> t = helper(t);
>
> where the helper does
>
> static struct notes_tree *helper(struct notes_tree *t)
> {
> if (!t)
> t = &default_notes_tree;
> assert(!t->initialized);
> return t;
> }
>
> or something? Of course the helper must be given a much better name ;-)

Good idea, the three lines repeat often enough to be worth a
helper. I'll add one and route add_note(), remove_note(),
get_note(), for_each_note(), write_notes_tree(), prune_notes()
and the new copy_note() through it, as a prep patch at the front
of the series.

I'll keep the assert(t->initialized) the sites already use, and
give it a real name, something like notes_tree_or_default().

Thanks.
