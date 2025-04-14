Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2CC2820A2
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640844; cv=none; b=f3I5gfoJAt1Ur1mi/RQLmZw5Yxw5gPfEp8zokh+IDPlf0oSP99/3SBKM2Lj8u9F9eyjzpXGThsmqPrR0gXTZdSlH5z0SensTbk6sAUAtnUXeJxqL36OMhCoSrK2vS/LXZpMwHYWjMz1qruWym4Mnkg5xyjL5gTw21PcLetZ1l+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640844; c=relaxed/simple;
	bh=c2jkQVPKPkCwHBA5rIhcYVdLxE//3sYh5iy0CGabdiI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e53SYRqebeszAgx5xrGglrGLMRo5Wau8/nO18mBtbF6i9rAiPXCFfxwSc7vHpFEXkgIU9HwYAEqE8fRWci24yQLhUOQJz8gsWx2Lo9ESRs0ql16V0aXfMryyT228G+xsm5CZaFUrfvCdOIQXsTXxlhxSxFPZc+PfC/ZkA3/vmTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZcs+W+V; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZcs+W+V"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5240b014f47so1851160e0c.1
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 07:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744640842; x=1745245642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=who1QSzB862/BlcS6+ISiSDE7MWmoyuKEC7NjpK291w=;
        b=SZcs+W+VnEbUZxgjxZxAXH3uRBVnDQpIiGUR77E4amGwIli52k9vjN87iYjy+gVrgx
         vaM9wWMS+t4zsxK95vqs2NSUHSsNV19qb0i1ZXPAORgdtYOHSgj03V4TQhvoCfIOVl1o
         e/EbfHFZHcbufyVwNqgyq8xu50Phg2/sUH/UEWgH38MOd9UZnZcwGysFKzHRj+xUm8Mu
         pBWlDEJitFQSFRMW1oWEgC1RnFqsrFKmT8QFsHPfLASVlrSUmlKuyXN6A1aBlPsdD+s+
         nNVH04RG4ytT3BVkZLho6qibz2zLiST32Gi/I5cE59C0cq/zpXARKcvW7vGQVwM48K8/
         /HkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744640842; x=1745245642;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=who1QSzB862/BlcS6+ISiSDE7MWmoyuKEC7NjpK291w=;
        b=jmz04w6PhbD/ijL26euBM4ACfk0lPeNWNeWU7gTb5twryPZNwI5+32gdDQ3KBDio3Q
         8UnmqpK5LJ3wAgiMrxu+vaanREobmc6x7OCU6ybGU2nH381JLVlRU60n+N5Me8MICIG/
         3v4kak0aqer9FeCdDDiKWGNMaJwfFLbXchuk1WbrZNMUbRMNLb/IqBn0G2W9CUJN5z1W
         xp4sPS9LTlhu1NdqMYOYp2h01vGCbpqcWEjg+KbBvciPePc7GtWmdhaxhB9Ya5boRsz9
         yJLbusvvslcaRCmpWZ2PE9C7DY+vSxmnb69VddhCLQw2d4frbEnYIFREsl6wDsze/Hq8
         Ki3w==
X-Gm-Message-State: AOJu0YzNAgUkKyVDraPrcbybgZbY/DOFS4eNNHSJ6r72TiupWJ+2e7uH
	24GiUBmtNWaiwIMqxdjdZCZqvQNvB9SXwCnz9zbkIzQMUSMKX2oSGFjWvSz70KLc8qapmjRCbtn
	HVkZwBLwfFY3yCJMz5Eo20m/O8pU=
X-Gm-Gg: ASbGncuQe+Re/PVmXYTxX/rs0DSEOVrzmWi9+lpFttCx+/i31TzYJO05+Jod4gfbBSt
	DPlnBM+ao9cmRgVshoJDw2V3Y8gXJIF3c4J324MbEQiswVoLYWEvrNmElRvsRrfFfP/jiH0/6VN
	2S9j3S2zkspgGYFLAWxXZxINNSd3GzVjavCS5MofTvkhqSFhDAzHXwKPk=
X-Google-Smtp-Source: AGHT+IEwGFPOodvtZELTjYFXzKuaJaowm+PknQLlPOjgQjDlE8+4o8tFmjtmYKnwHavEHzEXg/36RWPep844nFibWYs=
X-Received: by 2002:a05:6122:209f:b0:50b:e9a5:cd7b with SMTP id
 71dfb90a1353d-527c35ae10cmr7539887e0c.9.1744640841513; Mon, 14 Apr 2025
 07:27:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 14 Apr 2025 09:27:20 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 14 Apr 2025 09:27:20 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqtt6voncw.fsf@gitster.g>
References: <20250410-505-wire-up-sparse-via-meson-v2-0-acb45cc8a2e5@gmail.com>
 <20250410-505-wire-up-sparse-via-meson-v2-4-acb45cc8a2e5@gmail.com>
 <7eaa33ca-0ccc-4789-94b5-de1a068e1599@gmail.com> <xmqqtt6voncw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Apr 2025 09:27:20 -0500
X-Gm-Features: ATxdqUFhE4wd14WcLOnSxYXXV0WHf1xpBLEJU-7c49LSYEU87v3xw2s-wr2__Dw
Message-ID: <CAOLa=ZQNrqf+cqatpbW7jeX6e7XAmk7NZZBH1inYMCjFj23C-Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] makefile/meson: add 'headers-check' as alias for 'hdr-check'
To: Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, toon@iotcl.com
Content-Type: multipart/mixed; boundary="0000000000009e9aca0632bdd9f3"

--0000000000009e9aca0632bdd9f3
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> On 10/04/2025 12:30, Karthik Nayak wrote:
>>> The 'hdr-check' target in meson and makefile is used to check if headers
>>> can be compiled individually. The naming however isn't readable as 'hdr'
>>> is not a common shortforme for 'header', neither is it an abbreviation.
>>> Let's introduce 'headers-check' as an alternative target for
>>> 'hdr-check'
>>> and add a `TODO` to deprecate the latter after 2 releases. Since this
>>> is an internal tool, we can use a shorter deprecation cycle.
>>
>> Can we call this "check-headers" to match the other "check-" targets
>> in the Makefile please
>
> Excellent suggestion.  If we were to change things, we should get it
> right just once.
>
> Thanks.

Yeah I agree too, I based it off 'coccicheck', but seems like 'check-*'
is more consistent.

Thanks

--0000000000009e9aca0632bdd9f3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 73d80c18a1586e41_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mOUcwY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOVZNQy85Q2NrZGJwNVRZUndJYVhLNEVoa1RYNloxOQprLytSUmFpSWJP
K1AxK1VPT3A0NVhJOVlQdWhIeUVQeUpGcWlrSDZqS200VGFta2loeURLa3RiUFpGTWZiWDR0CnEr
RUorQlJ6SlNyTlcrYmx6TVJ4VHk5SWM1dzdxcDRCZnVUV3NrbkpROFV2ajV1WjhFbnFQZU5qYnBi
OTErYlAKS3czTTZKV0pXTHpldmNDUTN6K2VkWmlkVyt6RDhWOHNVcVJJSVJxUWpnZ3hZZS93T0Z3
L0lMTWNPbExGTnJScQpJUi9tWlo4VGVwYUxUY25kZUhNaEo2SjRwaGhkSnRobldPTXZQbUdVdk1z
MkJPSmowYStNN3Z1MFQvRVh2S0ZMCjZaR2hTT3lHeEN3ZWVUaHlUUU1JUGtGM2NNMFMyeTNOS2N6
ZlRqRThUeEVDNEhHWmd0OGpLNzJYbVFtcGdiaFIKTVlBUmkvSkE2Z1lSaVU3RWwyVUJ5Q2xWNVRs
dmtRZDdhVWpKckQ4R3g2QTVLdFA5b0Vtc2p4SXBBalJxeWxTdQpueWhUbXhXbjdoOFdhMElGQ2Iv
aXZXUE1ROTJ1Vlh5cEx5WmFjVGR4UGRmSXFXNC9XWGlsRzRFVzJOeEIybC9ICmoxckVGQXlza2hx
TWJOZ1QzWjUyWFFLRU9BbHB2OUJLZGhHKzhyZz0KPXNBQksKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009e9aca0632bdd9f3--
