Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA3A451067
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 09:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864664; cv=none; b=XmCf60fTco1Awps/DQsq+Ete+QbT8K2QPZL2ZLvglXTxp//r0vY/HHQx4h5r1NL8q6BYJGtL0adEUK0oG3IHu2p2+/U6/ho8vqKmJTZ/LqJMDtxdSiTfbqrAhpyUTLLQGfm+Q4KuPS6Fy2x1zXd5HFQxiQxf5/5gtnxlfvgRweI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864664; c=relaxed/simple;
	bh=VkGc0RnrO6Z92qCFRAYHkK9g5eOu/5qGf2CpdvArL3E=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkBroWYKjt3d5+oX5AxYy3JhhUxXl6OuJ5UxLpU//C3/R6ORSD6ShvYX/eR8nnX95bEsGUAfrA4zcorh9n2HQ4+u05CvwH1sA1oFkBlcCu39uqu2HavYaJ06dkgaUM5lfYcbW++u1m6fWcsyh31K3S+JRjC3zGmhr6hU/Oyp/vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCx3ZId4; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCx3ZId4"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-9412cb281acso953073241.2
        for <git@vger.kernel.org>; Thu, 08 Jan 2026 01:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767864655; x=1768469455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wS1zrnxdeUk3MkewVgcjbZiFzTvHgzWa3UdSCugj3U0=;
        b=HCx3ZId48gezgSxYN4gBNV+3bBQ/3A6kX5L1tZjDITJzyBZwHhcWW4C4vPRc4DAXOI
         6I3x8Aw+wsmyWgF7D7AHkIGsb7rr5rXUGFMmkKo7BCCW4jt68Dkhjkq183PZ2UiGdvBy
         93A5dnpVsQdCglhNQuZrk1vYZgD6SPOtKQ8d3YMtACecWMmbEz5Vjg9ZRHdPZD/d2iWZ
         AsIFSzDrzxoJkMJALsyX4A32iK/ri27+PvchG/MioTL3+A7hUUsL/dztL/fxXVS5xzsl
         B9L3znbJAZoztFOF8GQ2Uv7Z63z08fXa8fo9DZzT6m2ixBWexV9jwqNssjOVatJwG8sY
         EB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767864655; x=1768469455;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wS1zrnxdeUk3MkewVgcjbZiFzTvHgzWa3UdSCugj3U0=;
        b=R35PjdDv4H56us0smzilJhM2HW4YU+8xTGYfY+iewn8ABJPh42dei0isAZVf7tgNWK
         gdI2q5aH31Mrc4pth/k4PBFOggL8h759ZlES/pfaiDfzzLUxEq1RSZpnlyU5Kn1/ExZh
         GsUz6X94+vy0yLi+If9OwwX60pU9xFuZ/vgKebrVbwV2OCB6tLkXpb1UOdh1x13TxlRI
         zNBMP4AZrXeETIH45/cAEJEH5BgDi92Ytcew8xE3Uoq4LmV7RrlEbKFHymmdqd8YZFS6
         pZ109zUMnrTILDNagS4KTaAx8DPbggX4PSECI/DbgmHNPB4zY6jkmUkQYnb2tH0fQ9Yq
         awXg==
X-Forwarded-Encrypted: i=1; AJvYcCX9sZ0FpDMdWD0/W9AuKkBJMOJ3QQVGwsZ2Rv5sRb6wWaeLxv6k0nCnru2sNBz04P8Iwx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm+ng/kth6TLzUELz13knRoVDkfWpUOcUkG0lCngxkpf+XvmC/
	wffev32XdNvVdjsASS06jeDBYfEyNX5rukZlEjFcmsLhWgPNXGUAILc2X5EdDVZ2wh1pTSjqDfJ
	+R3kd7YZw4g/3W9LLN4agfnjfFy3mDKjM4idA
X-Gm-Gg: AY/fxX4wMui18PGU/lfyIMTFU7O6Jr0G5F7tqGti+jsKbh7IE/o20nxufsgu8WjkLlk
	Sc3DSkYFpdm9TtyDK499624s9FS7TuuaCNctbmYjCXP+3tI53MyOF0nFv9MO+hxbw/U3hUFCfoY
	CN9Ai6fJost2yIlDHGcP/+8/zhG6qjvyHAKXxUSp71BNDUG0+xIMBam01DN+4Xhts1du4BkOcDQ
	ly/uMsfTHUnZkKK3yBZhTHEzh59o+YEspGnffsqHVlBxfW4sO72THBnlToETBT/8qldeUejKEpH
	FU4+0ik9rYiSKx0awzPytyZk02qP7g==
X-Google-Smtp-Source: AGHT+IEQd0qKMrLCUuzVrTf1+g+mh6eFDTbxgbrOqpD5qvIpSRkK1A4Foko3YDazj+xlEus1Ni0JPZPlDPH9DgHTeMk=
X-Received: by 2002:a05:6102:6046:b0:5ed:6e3:2e31 with SMTP id
 ada2fe7eead31-5ed06e3309emr1481909137.45.1767864654835; Thu, 08 Jan 2026
 01:30:54 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Jan 2026 01:30:53 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Jan 2026 01:30:53 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260107-b4-pks-odb-read-object-info-improvements-v4-0-b5d55c47082a@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
 <20260107-b4-pks-odb-read-object-info-improvements-v4-0-b5d55c47082a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 8 Jan 2026 01:30:53 -0800
X-Gm-Features: AQt7F2o0sV-SOj4rpe9fCEzUjqbADJ-IVUXMiA953RFrF-sGMr86jBuiMGyY6NA
Message-ID: <CAOLa=ZTOG7UGzch9y8-15QUDmMMSR4HqdRMyO-izSriLrKBM5g@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Improvements for reading object info
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Aaron Plattner <aplattner@nvidia.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Toon Claes <toon@iotcl.com>
Content-Type: multipart/mixed; boundary="000000000000c366370647dd1026"

--000000000000c366370647dd1026
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series contains various small improvements for reading object
> info for either loose or packed objects. These improvements were split
> out of a larger patch series where I'm about to introduce a new generic
> `odb_for_each_object()` function.
>
> Changes in v4:
>   - Extend the fix for OI_LOOSE and refactor the whole function to have
>     a single exit path as proposed by Karthik. This results in a lot
>     more changes, but makes the function way easier to reason about
>     going forward.
>   - Link to v3: https://lore.kernel.org/r/20260106-b4-pks-odb-read-object-info-improvements-v3-0-b5e02fae1fb0@pks.im
>

I had a look at the first commit which was changed in this version and
it looks much nicer now. Thanks!

--000000000000c366370647dd1026
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7606e8bc392e0236_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sZmVVc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNmpzQy85UjJFbmtSNGxqdXRkZnlMbW94RkhWMXBxTQppVkVzdG00MVVz
WGMwdk9aS3pLSW9sdGJlYzdBb2UzRUlncGQ4VW1aS2c1WFlBREFyNE9tODJjamp3QWw4RlQxCmdF
Z3YxRlY1a2RpVzRXc01JWXEweTRvTGxWeWtYWGtWemRhVEFnMTJnTS9rYXJVSGdXM0FGRWI0YXlM
aC9pMC8KT1NhSHRGdDVtMDB4TzlPdEVMNmtOb3hHWTUxMWNYZGkzNlNEUzVRTTJxYjUwYUo5aEJK
cXNxaXU4VHFqWEsxSwpBYkp3QkhMR2RmUnpBbTNJenRHcXNtWmRxOUNybDZNaEJIcUZ1akRheStK
MmlrekpuaFBVRmR3NjJQWTAwemluClp2MERjbmI3NURCTzUwaTRXbkYxcTFjSVlxbEM2blY4OU9Z
bHQ1OUx6VDloazVtK1JSMnJaTlFpSWhrK0ZrZHcKQS9sMndQR0hVR2M2ak1Nd3gvRzlBS2JYemlN
bWtIRUN3NEwxcFpRNFJqNktRc3d4WCt1QUdvTTB4NWxXNXlEOQpLcjJ6Z3llakkzekdZdmhSdm9S
akJ3d2tNYm5WTUh0L1h0Yjlpb3JiNGFjSkg2Y0xkUCtBTGg0dkpmUm9IKzBrCjg0Y2pzdjd0VHJC
K0pZd0lQVS9qYS93Zk9Kc0FkWWxUTXQ2OWNYOD0KPVdqWnEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c366370647dd1026--
