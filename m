Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794525227;
	b=huOYX4MfIusnkW3zoeIRUrF156m3+l8TlOW4C073scEuz5/ZFIOmXJfcdTHf0wZOxhgD
	 lf0KXy5kQbGLH8nrC4m4BpDg+otZYmtONWfZjWVFPj2PYukH3YWGFVRLdHHo9VqwrFatR
	 tQcvlZby14kAFRLT5JPaeYFlP2NJM0e4rsq8vsiZINwysov+HVPPAVa8cy5D3Y4FTjQQu
	 0s5qpmGDaZsb604DrX7UreJgrAxzKc4MocMZyaDWcLCP1wbmeq0cZgm/6YcHni1FyFqn8
	 w+ANPvhKEPej8tudkMVwtBoNhRlhMkWR19Qx2Ha/9LRijhYiqDovrzEv0lNmblhnAzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794525227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=UX3Liso+MDX2dnmt9aZMwFZQONuaepIZ1DC5mBDLEYc=;
	b=QHSGIPwgh/+wD5lgYmormZyabFbPqO8g2MjHpe5vVjEU6pzFr4FTp+YXcElFfQLxE1N3
	 P5FAyOCy5JytsyCmaUTDB0NRW7bjHbs19TayMRTwA2/R0LKZ/4W71ThwgNYKvMZU4q8dY
	 KiuYSNIPIkcei7YrguwlbIAIvr9qVFV64nU1vYi3UEdskN7GwOwsL/NjvzRJP3APaaJ6D
	 VWdiH9Ut9SZci3YHvjrLnDgUAyqva3YTjfY3cD+BzDgbxa1/6YXBD6AwlqP39y0NYusD9
	 eTHDvfc7LHR64z4cEqeM5//829Lw97+ZTU64b00IInS7wurAZf2m/ct6h5eCNwi9Lgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GfzIFAJk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0C2606A31C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 23:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C0C2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GfzIFAJk
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7d2dc9a7b52so375138137.3
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 15:13:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794525225; cv=none;
        d=google.com; s=arc-20260327;
        b=VY8+oDBQA0ZumDvr8OkA8vKTQo3WyW71+3wMwPPCF4JxveH5Nl2wvCb4xSliEYLmwG
         Ghy1kdcjrFLNMpUn3f8NY9WIKAdK640ol/+7572m5gAecA2UIPtL2IcY82ZxDgiuTG8x
         NPOwz1JO8GZvxu+9fpdc60Dz+0aHYvtJ+Czp4O2ULDzXHMRgui7RSoNTKpY6sipelZp9
         jmpl2pvDczkm8Mpjh3Ged6THlNlxya1j5D0fBv1ikTJqRfNSvtMLJnTcVhOORif6ACjT
         1rJJ3ihKrLsKZ+Ig1zw8nwG3JxqAEa+oCIYqgbwxTeQaGH0KBi+IlwJ7J5h+/jc9GJcf
         DDzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=UX3Liso+MDX2dnmt9aZMwFZQONuaepIZ1DC5mBDLEYc=;
        fh=r3u9I2/f7NmeBK72O72lZA7aETriChc/LvwpWWFq7O8=;
        b=PDhz/ZVJQ5jdxLmsuWnlZ4Hrn1iEj2D5bBBIT3q4AgdhhUX6VRn6+uKNvefyC2wiXU
         mpS5bQhdFgAKS7oE5kMx2RJCHrivYT8X3K4b+ckEUQuo12eBw0IYIo2YtvBh16DPrQDL
         FX6yv24/tgM/haKJHE59UyGmoIl17ssNh8pBJYx2p0m9f8kVtgyH5CJnO9jEvedVLzEQ
         U33lrYisQMUHFc3vuo0/MnyQ0AJqlVBg3t8izSYfFjQhs2nOtkF1emT9dhiPpDKHbjXF
         jt46z5F0Jc9ec8RWjCJOs17Cd9cWrZKUaP9r/8CXNayf1bDCcU09q5tNPHLTdWBcSxgk
         wKAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794525225; x=1795130025; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UX3Liso+MDX2dnmt9aZMwFZQONuaepIZ1DC5mBDLEYc=;
        b=GfzIFAJkgB0WaW9qmaLNn+BXIVplyGkG/ykUewSvjxCuw36GPlkVr3n99E7IcX8GXA
         3Au3e/WAHD0V9849Vbh/QLx3EA9o2tdLMLcyDS4hwxMJXECPJQhBEBjBvEQdTtm+vSL8
         PRsf9CtS7Il3qPKOzv0Y7EgOfUEHzav78YkEVvlfW5RJmdOaOBo8KObB2TRNKMaM1EE+
         gqBlG79JwAjJMPEUs7kMK6azp5qKCuacgc8go7OhrXpUB41MLnuxafiOCRAIEUT3g0Ee
         oQa+VdfFcPrWjfc3sdqPdukgWhLtYRcEnHED+accqv/AOLxN0d1PQRjg3Js/Z+Gv4aRC
         lVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794525225; x=1795130025;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UX3Liso+MDX2dnmt9aZMwFZQONuaepIZ1DC5mBDLEYc=;
        b=MW0KyoetXhyuUNKXEpE3g3uNqEAsowAff9nb3ersv9wn7R++l6keEjb9GuFfDDKE8x
         eCuObJoLDbRc4Zs3O0nBBNv2BR8221ZoUyxilzJwqCajuHEKW2LNjdJcNDy5fKRliJ//
         tpUZQRIxFxmz2N32SBKtySoV2ltFwywMFSa3wg/gIPmxgrzhr7ENPu0L5eCdAtsV+3Bu
         dzfcYgstCsCpezmQAFM8+Ju8bWlBgjTs+7Nv8l4kW19kKHD6nXrqkvhfpDoNe6wp9zB1
         BbigCKg3eOdUk1rlebtzqccf3pfA+Sb52Y3PSgKg6tFl7kjh0m9UmtpGhAZQxncMJGel
         wQ3A==
X-Forwarded-Encrypted: i=1; AL+hErHZSnYHu+fNOnHeZqx2Suwaz0CRFMTmLKlyV/soM1N3v9OKUKjS/Suw9PK5Xw5zccWk1TE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NWyd06ch+KiFxiMKP5hdMrd6Cn8C1H/VLwIsjmzF2gn9+aY7K
	+YviK1UuBZA6QFbW4o4tTscx0hat31ba4C+v8XLkjzw7gQs8hi5on34XOkRtZvp7ciK0lKC1dxc
	I/t+sXs34jybdmqRtU6l/3BleeF+0FRWXOA==
X-Gm-Gg: AYBFou0vgVloJsDT8wfbkbAnaGzHxUTTPo+m4Yd1kTPuELV4R2Hb8SISBvoygetA82j
	slYUMoUX2nqzhYF4yzQelF/sR0pQ2UmJ6Vu9+hHGARe8i/TXvPb0m6geQqU9xZQLqrCYUS8WgU0
	+ObKaNE4t1PQ8L6xy+BbmEKlhXqJja9R6TfZPGbvZdNE1FocALXeLpfDlz2mQkXIgcTz3702vIz
	kS3STYKfWjo23XM8MungzkE/naByDMrVLgxaRAfJL2JV89ridrm6l5ZN5RYXasnm7VoYyESOdaW
	+4UTkVfYyuaRSv7IVllF8FHuas9mRMFgvdyEJr6Muxi38UHqlUqQB+QhIcaIUmdM96ybtBM1+R3
	TaU8UzI91XdJkKmSbznUoO1xV3AKkGKO1EmORapDdulX1FRyzJyt7/fE0UXLhPQ7Nv321yvZ5ND
	9AIm9Bndp6VyB1Iy101iKUlPWqLqQ=
X-Received: by 2002:a05:6102:f06:b0:7d2:d9c0:2e96 with SMTP id
 ada2fe7eead31-7d64d8e378cmr302932137.31.1794525225593; Thu, 12 Nov 2026
 15:13:45 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Nov 2026 18:13:43 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqqzgphjyb.fsf@gitster.g>
References: <20261112-mb-ref-filter-missing-object-double-free-maint-v1-1-d6d56a3c8dbe@gitlab.com>
 <CAOLa=ZQuT5+x-Rvxcv1CSYka3aGG2nV_hPFRDTYJEGgjbLhJwA@mail.gmail.com> <xmqqqzgphjyb.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 18:13:43 -0500
X-Gm-Features: AclHuK9jSMWGLOObtauTd_4rcgHEnK1xwsjIVAl8sIv9loNINr_mqAJx0EFExag
Message-ID: <CAOLa=ZRnYo0CBw5acvu5m4bLjUZgeLv+Vf61kbnuN34eMHQr9w@mail.gmail.com>
Subject: Re: [PATCH] ref-filter: fix double free when an object is missing
To: Junio C Hamano <gitster@pobox.com>
Cc: Mustafa Bayar via B4 Relay <devnull+mbayar.gitlab.com@kernel.org>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Mustafa Bayar <mbayar@gitlab.com>
Content-Type: multipart/mixed; boundary="0000000000009cd0cf06601c7621"

--0000000000009cd0cf06601c7621
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> Similar to `maybe_object`, reset `content` at the start of get_object().
>>> Add a regression test that exercises this path.
>>
>> I had only reviewed this patch internally and we did some iterations
>> there [1], so mostly just rubber-stamping here that it looks good to me.
>>
>> Thanks for working on this!
>
>
> I take the above with "only" -> "already".  Thanks for writing and
> reviewing.
>

Sigh! that's what I meant :)

> Will queue and mark the topic ready for 'next'.  The patch is very
> well written, together with historical reference and all.
>
> Thanks.

--0000000000009cd0cf06601c7621
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ed062f2b408e4df5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yMlNDVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN0VJQy93SW9xMTlDUmorQk5OVE9ibGUzaUZwM3paNwpTNlhkUjNVaThs
NWNnd2ZBY3JQdlk3eUUwRHNQcVc5LzIyclQ0Z0YyNHJGUVI4SjdMWWtvZ3lnczllOEJiaDdXCnNz
VkRzSWcyYlc0RkN0T3NKOHJJSmRHUnNEcVRRVzh6WWxFRXJYM2RiSW10U1dHa3QrWXdVVTF4SFV6
NVVsb1gKRkI2VTNBV2oxWU1nVFFjWGw2VUpjcXhVU3FwYThXSkhXb05XSVN4d1BkV1NyY2ZKbWhJ
YnFhNW9LVExUZGE5bApKaFlCdlVBZ2k3QlpYdE5VUFBEbGlSMnhraTBKMXlJdGoybFo4a2Z2ZWFo
MFhoUWJLN3g3WkhIeWpITVlaYjJ1CmZLcnY3MENERytSSTc4VDV3cnpocnlDcGZpVENOUlVaM0dL
eVJJaDE0cS8wRnExSzJiVFNKOUtaa2dCZnlTaVQKV3BJak1sUzN0NjdBNk4vWUprdEtFazJLTWV3
a2dxQkRmeTE5eGRVQkJQeUdZSFZEYjUrbUdHUktZbHRLc002bgpPMDZLVmtCek94T1JLdHNocmxk
UWJSZCtpRzRiL2hKN2dWZjVrSzV3OTNrSldNdzAyRTQzeWhwMTNrQWVUK2k4CjhORTlWWXlvK05m
QkJVa3hKL2NrVHpVWkFVdWYxQ3huUkdWb25pMD0KPUxiSFoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009cd0cf06601c7621--
