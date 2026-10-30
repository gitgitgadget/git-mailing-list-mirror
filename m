Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793357447;
	b=evhsW7UcE6/HNkm7nV8XS89sJtO8VfMrBkP0ZSyZrstMeRUUc69xDsoW8KONbkWapuW1
	 9O1ZnwZEJ/Xbh3kXoH5TMcvKvsOS9VN+I994xk3SB1ucOeBjsMWMxR9LVuULm08uKDmB8
	 +XmqVks6PYpIc3eQjmarmPdHAPobiMb+f7vyA5JwbRunTmiCkm9iS5CMfkCzoaJA5CA5P
	 vVjra6SLMbMvmj3qcIGEBwMKT1j1lBqXpYLC7Z0qRdKQH6TLDySLzew01Hn0ieltsK7Vl
	 9nvICUnmWJMXB6wRD00O0mT/NEUsIsiBSbxZjQXUYI0bjk5vvQXcQCUVPCP8DSr5cjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=9Jvql9PEESumD1DV2lwAo/uKsnd8XJUpWBlLgMw/FsY=;
	b=hnIr0cWIrDqYKWtuYcm+f0DXPVxd8Mz0hzf4s2pZeOqhgCC4FvgQ+BbZMrTHurkTyJhO
	 MZcSdB0RyrtFvIgJ8NopbCNrjh8E1XT7QGpEkdHFT2SlHgiYAunNwbtKaHWozfPunHoqT
	 nE80isIsYF5uLtK/RgSDQ7fsPmEIdFxueNaNlUOLMUNYj7J7N5VAtL43sWHpQmjd8ibPK
	 jBtBnKTJQVJADNi07QLe58tT4Y0hczuFGjuqWM4C28i8+L+x6tQ7jRZAS4PqQr4cnOf/O
	 aGkcPHyX/egCtO/DTAJpKVCOWZjmY+OooP2J93zzs6+ABf4X2GQug+1Xu9kDRUWXjyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jHL23Bbs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59D9606B95D
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E59D9606B95D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jHL23Bbs
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eac319a6c2so546861e0c.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:50:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793357446; cv=none;
        d=google.com; s=arc-20260327;
        b=E4BNSbYHSp51o/TunOMKxc0Z+czkwlHYm7Z68TH1rxBdqWVQQ8XIuL/V1SN+X4CfMV
         NTcRAYSuRFs5cRm3KvlblFFK7XN6cnXfCA5tTxGRgWBl7mVKFkxb53OYX1VkWk/wBSNC
         fFFDp87dY0DpNZv108BRBdjtaYAYjg9Y0uRMoPfdyyXCAfMJyqVgUMocM0hqhuu9j9C6
         cYP8MmabLX9bLUIPNSYogHkEOhjqXrTAvU0xsR5uEEQwUIj67y3YZbhZgqwRsCOWB7sp
         8jS4TSt5Dhs5YUE8eOmgrgA56VsPcMbt59oYdmDDJVlp8nbfSsrrd5SS5wfMI8DsmvX7
         wXRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=9Jvql9PEESumD1DV2lwAo/uKsnd8XJUpWBlLgMw/FsY=;
        fh=l/vA4qq5zRHgeO8NkJ7NrPBCFncQdYtZ4vd4wTEwI/c=;
        b=EuqN2RDKKUzh0eImbUSRb74qnc9Xxwc+6LbtCtXJ9pMoBc0bqW54mns7ryiSO1njoz
         eY3XzRkOVU0jQM0WL75FU7qgvRlvoLkujyIeVHLDI7JkrbtotJ3R+NPH0loaT2jYTXKK
         n3DPel2FXaUAc/lHP8LrTqtCWuWNNG3Ky5wsPjWFN9cFMUIwAbId+PWvSNis2wevYkVF
         iXbiemTuKYo65UloktEFbosq3JQIyKjefjO9Ivh3m/kWagQGHVIi1XWi1Ty9TACm9Ire
         /UsVD7AcfnfDlcEvshVIDsecynJMvHP3kxi99AgcxcRVWNbbii2xQYl+Hzx1idMzTWK/
         ZQXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793357446; x=1793962246; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Jvql9PEESumD1DV2lwAo/uKsnd8XJUpWBlLgMw/FsY=;
        b=jHL23BbsN4JtV3uvf+sSfsgZ5kBnLhG3Ct/PPYYFFm8HZDw2hejwB3sz1M1IoxWE9L
         YuE/l7vuHSU/hjZDpvxR36akDG7GYqC8UUwQv8XRCIo9LzPvUEwRzFkagz4mjyxO9sE/
         x6KHxmR44YNjJO7f/lcaRn4Crt8noopzJPGn4g++/Utgb4Q6Yq49CzUOpyy5L/ABnr8L
         vBemAKEVaQB57gDlirkltVYlisMOKgEc/F7WToYu8ccfXLbRhY5m3kchRmUzNQgEDC8W
         i7Svr4jBk5ApdJCso52Lb0MAUcaXdBEts2L/+ylWGKwQB9B4raw9Sa2tT7j66o+MJvG3
         epQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357446; x=1793962246;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Jvql9PEESumD1DV2lwAo/uKsnd8XJUpWBlLgMw/FsY=;
        b=OUeCh4QZIu2wWtW6i8j3DzqPhBnO1iQ8I3kBdS4izs5Z881XsJ5SBhGFpQ/pL+/xwu
         9iKUqBCxhz1REZiEQUhNWmD2AFpJFaxdwYY9D9jP2zn+7IXzGpwUycU3sWCVepFRCDxe
         1GB2iENfHXMAbyhkFzjloO+iFG2dcbRDInlTiQ7vPAQo1UE+fDUpjz5T+gKUqHDS7u+6
         Cmx/KmFYntkNN2MjVb8zZ8XoL4NJWQ6ffOF2R/CD6bO20uOa4xqpDQWGngdMCeEQOQTg
         PRSCf3ZwgGa49QTBjz+FXdX9fmQz90KeV1Bdx2F+gSQf+hI1B3WJ0xxpBM++92YSk6IN
         IsYw==
X-Forwarded-Encrypted: i=1; AKwUvBxXZ+oRMiM88xnqfMpuWIGINNpRqRkwxIyJPAc0DVYNS8S/ONrLRZ4A+QRD6PR6dK9k8JA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkjfhtrdJnfIos4eH5imqYMUV9UyZbTvB+ku0uUOdGxf59EYKQ
	U05Uk3qpJBPNPcu0pdj13od7QyIuHRhb6RO5UUqs4Vhu5B0Rtyxbb1OvzqLS9PKQW3KuOe7rwu8
	ADI+LRnkYOkrDfQzGqk3yc5JiH0l7B2E=
X-Gm-Gg: AYBFou0WQA5jyQk6aNWOaQfE35lTpYLtljXuA9yzPQ5qXG1CNwNmu101zP1Y/k519M3
	07K23U/zdf3aj5hyrQijKW75WBN8f0eJNHasRyXIEpHOkpBat/DmycUwF5w3XnBkO0vLi9qDAI1
	g6oT+FNkVMz27NhQU6ySpR7D+1udWSiiZxi5kwbmipbBXAZ9VkLPQ+5QIFVcOyJCAU+l6uTi22j
	vJ8WVrZ+s4GcjHjzAA4tmVq5d2377MF7HAx+0/PDzLFqXVLj7vQxD/S05BcS0xtRtXKpvUAvfNQ
	kku3GJ+MNLB6bVGWfdUZzHpRg3WtkshMbTC34fCOIMhnUc0ifZz9Lcn97Tl6QBpbKf0FPWmrX+B
	ltK4RsQWYJ6UJFxRk2dV4ilZzDOL9y4eU5Je4+6rxhq8j89uasDOfqhQRmni27VS5KEKblCmTJo
	rGUIi3R2bSLqdizfIhRhIPv3NPZk3M
X-Received: by 2002:a05:6102:149c:b0:7ad:3ad3:997a with SMTP id
 ada2fe7eead31-7d072247aa7mr1046733137.5.1793357445857; Fri, 30 Oct 2026
 03:50:45 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 19:50:44 +0900
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 19:50:44 +0900
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261029232220.1245827-3-jltobler@gmail.com>
References: <20261029002413.3291184-1-jltobler@gmail.com> <20261029232220.1245827-1-jltobler@gmail.com>
 <20261029232220.1245827-3-jltobler@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 30 Oct 2026 19:50:44 +0900
X-Gm-Features: AclHuK8-APkVBPKdk4Uhv0uovf4n0tR8riXzpbiX1inLa-c6ui-uLWpwqWjDsv0
Message-ID: <CAOLa=ZTNCcRCFDvUunqEqQCmDPE_2iu=rC4FwNmKAQujegC1Yg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] loose: lift loose object index parsing logic into helper
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000843304065f0c919b"

--000000000000843304065f0c919b
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> diff --git a/loose.c b/loose.c
> index c6f4ee0ec6..5f72c644f9 100644
> --- a/loose.c
> +++ b/loose.c
> @@ -48,67 +48,88 @@ static int insert_oid_pair(kh_oid_map_t *map, const struct object_id *key, const
>  	return 1;
>  }
>
> -static int insert_loose_map(struct odb_source_loose *loose,
> +static int insert_loose_map(struct loose_object_map *map,
> +			    struct oidtree *cache,
>  			    const struct object_id *oid,
>  			    const struct object_id *compat_oid)

Nit: with the introduction of `loose_object_map_read()`, perhaps makes
sense to keep naming consistent and rename this to
`loose_object_map_insert()`?

[snip]

The changes look good.

--000000000000843304065f0c919b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 57da42ca1facab7c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ya2RvTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md0trQy85dFhnc0J5WmRLRHBKdTduMlliYm11cElLKwoxVmR6bCtVWU94
VEhxRThsQS85dy81YXFGSFA4bWYwNndpYWRoMmxTT1ZCVjc4QVQxYlZvYXRrc2hpWHdWbUdyCmtV
clhvMDBDMVkxNEE3RnBwVWVqaHpMV214L1ppNEswVzdUWjNUV3I2TVN0TCt4N3dneG1tb2RNRXd5
Ymx5bGsKL3dzZTI4MVJ0d0Vxa1RHRlVJQ3p4NDB0Sk9RL2NISnBLekhMYWtKakV0RjNLM0VqUXdO
TElobWJxU0psQW5XVAp5bFd2a0xQR255LytNcFBjVVE5TjlWVHhvSkxBbi9EV20ycUJ0YVMwREdW
ejNWMC9jKzRDUDl2d0FOeGxVR3RVClpHa21mdHptckNzYmdObjdUbVNmNDV6aTh0N25LM3JWbjNE
TnNIT0kzQkRWbWhRMzdJaVFidTZyMEl5T1VJNUsKQkFXK2c5ckM2UnozYUZNdU1pYUpPOFAzcFIz
SGdDcnJITUh6aUliYzUrTlJYYmpiMHROR3V1blZGeWdQak12aQovcE9NV0dVRkhMWE52UmljRGJ4
M3ZJU1ZGWFdBV0pWNFgwL0lheXhTaVRGVVNlMU1NWmtZUEl5MXBHdG1XbTV1Cjk0VnVldGpyNXBk
M3NKTzFmclc5aXNPSHo4TGZHS2NyRFNHdEgzTT0KPVh0aE4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000843304065f0c919b--
