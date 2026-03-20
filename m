Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56169361DA1
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774002346; cv=pass; b=X5V44xSnKyJrjkX27qFl/Znp5sJxPWfycrHmS/IVi2v50dvqavpFe0ppLjUy+2CEHwb/w4DG465LtdhvRGhF29DyULslDlbvb4CNJfAbbSvX01aS9LJgigKEe4PXNxBFkC3/4Hne9VdQ3D2Q7ldS6Ot291tfXdy5BzAmqPgKFEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774002346; c=relaxed/simple;
	bh=VEbAN/uQvCSYENyH6J8701670uWN2rkRQw3gooQTSz4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fvz6nsil17ue4tEYOJ6lauoU4pqlJWHbpgFnC3/Uqtj+NwZQ08hcb3RhGhMXo/2qApxs1kw9uNmq31bAhoqbXd5sJASrocXuFdkBExkUo4LEq6RogrPUiuKyq/TQBEj9oyACdfvr+W8BCoY/A7stbeObsBVn7uJGAvWWItLw/14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZ77mXVI; arc=pass smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZ77mXVI"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56adf76631cso182872e0c.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2026 03:25:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774002344; cv=none;
        d=google.com; s=arc-20240605;
        b=Rsupd2AhTy204wIW0JLZfYDG1o/o3Imy1Yr7rD4R6A6HwhclVjCn2SvOrAewtfceAT
         rIs1UhCNQTicx750eQwe00EMXCntzsR1cFME2JCaqcsMmvABYnFHu0oLdFNlQSbwVbgR
         hkZlLiwCORi5MTE/72Oc0zl0AAQtl3ZuNGXVcdSTKvE8aj2sBfVh7RWMkikTG0vSS3B3
         8R+zWkRmzp+rWNt5VELBgiC6+Qlw7dLVDTy4zcPMIdRfrSacmThBtR7A63dCrDcovU9u
         pSJT6wDae89zLYvR0bMTNOLZWSzCBCTiJDdOmuKZfBWJUPNrqb36JsslbYwTFJS4CgAa
         Oqiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=WXqRDuNtmqyJvlDiRqw8fuCBTY+yvJdDuZ/nPRbyf5E=;
        fh=CWH6plwDdVGcxKv+FEvAtIi/C4LAiBZpk/RWpxjU/ps=;
        b=j5F/IntnSm68PU8sFyheDGojMAEt2OsyZr/jopRpBjUF77LY1J5T3PynHJ9L/g8eiP
         ZCCs3X6ncFcoRz5chKawDba/pvNFz1h/AU7GyiEbLTewODoYqlia4kDXEN9CtUw/uO0M
         tcJr6q+D3PzHwO9KrchdGB2mtiNEwSdZDXsXW0+R2K5LEwc1dakqyhcILUQCC1NnsAri
         W8RrmmYorwgfI6fxS6yy6wnobN6RZdhhjD57O4qFfhR4k/kZ2HrsaS9JP+0EcK+EmL9Q
         p5TP3U//qZ70or0e4DLOtIdsVgjWld3eGTeC1hFMYMAw6LLJ/SHo5Mv058bP8sK+PE5f
         j7Xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774002344; x=1774607144; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WXqRDuNtmqyJvlDiRqw8fuCBTY+yvJdDuZ/nPRbyf5E=;
        b=BZ77mXVISzS2PBYN0QwZ9VpKhTMeyoWmEP07eyI962SPcapL2RXn7V1MhgwO7Vdd7c
         iAZvJZWMJbVOtmwoXsTV6TXf/gKFZmaBzvuXOJWQltMbFe5Yn8a8zVZ3+onnHzkmC1eG
         CsZNBZblqAwbtCele98PKaG2nIK/h7P3YZx7z7QstZLnMJ+Jte2TbxtX6xoC+7K37JYD
         zakQSRFbJ8FkjoqA4gVl3p9qZMrgFQcSeIVpdFFMjuuonqPRSh+rpXTO1jmYI2GTJl9X
         Hru1MegIpwkFpAeWdOOzFFkLsc9mYfWLgkfkYbEXMOxGMvsCuCbiG0bBO1fQsdYxPwA4
         T2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774002344; x=1774607144;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXqRDuNtmqyJvlDiRqw8fuCBTY+yvJdDuZ/nPRbyf5E=;
        b=k8elHJaASuF0/+r5Q5+23IkEZjpp9RtozPs35UjmX4aR0Yi5jdy7lWKuWVfwRI2tlG
         ewUsGvcBCHWT5A11H7U53SU/cSM6dDZzr5pbb6RjyaWU/fwzr0Kb1lem0Xpkz3W2tbZz
         sQKY782SC+0jgjORaPVG4+RIkFB2hikt23KdaQ5dfrHW1nqoggp8GsAc6DTNyGmAO/up
         N5bGmjG7/1xWsdRvKlY55cNJCpa79ZZ2JJst/1a8MEPABj/WOGtfFfdhXe8nslA6U7k6
         SyMmK43wAzw29LZM5FW0KNvA7Fvx//aPqppmRDNwnRpBAH5jKtiQPAV2vLtDS1ROZeYi
         6UkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlbw8xRlCPcUR5D3ix5lqnhuQJRDR3mrM4ibIxa1ZhMflfq7kpzsBgK870E78EFNlL3BY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQmKbq2Sl8J2MMyDvhtKi7AhIQVsyozpKguOTmRQVMCtobOljh
	l+DCBYYDLC60vVl/DbGudZC0C9ShmyPS+ZoXqINx0JZLj6AAuv5PuhZtEazXw8Q+bce8m+r5LA7
	DPUNJf+VCK4E9so+4hQ69C+PgPKDP1rhS2w==
X-Gm-Gg: ATEYQzybacDv9DHVJim0cRPYnzcbkjf2pyeTDxRmMucqp7/MANW55c7HPD6/8TRKHMx
	KMk5RbJE0bqWZQXOiAZIqNu/BFTCg+WBQ9WH9BPeCGyvKrofqmwjNxIlxZ+md4t6Yi6ozVNROiY
	EZq2digpCojp5Y5U6bGhuLxZTK04ziDBXgGDdozNEvnOlJA8h/Y5eTrY1TOmGHCjQxVV3WuDArl
	H53Nt3ePqatTH0cN0/L6Q6K+ejz3Hy8FLN3d2waClhq7E8VcbBE4qH9hlT5O8+QH0Ms+PnyijzP
	Xi69Txhhtmxbw0BOUuQ=
X-Received: by 2002:a05:6102:441c:b0:5ed:f13:e58a with SMTP id
 ada2fe7eead31-602aeddbba0mr922900137.37.1774002344043; Fri, 20 Mar 2026
 03:25:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Mar 2026 03:25:43 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Mar 2026 03:25:43 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260318190942.22595-1-jerrywang183@yahoo.com>
References: <20260318003917.84792-1-jerrywang183@yahoo.com> <20260318190942.22595-1-jerrywang183@yahoo.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Mar 2026 03:25:43 -0700
X-Gm-Features: AaiRm524sg5YXOExIq0_oUqYheS-hng4KA1scUvuXEOOPlZlL0VnwqTxe93ryzQ
Message-ID: <CAOLa=ZTfL+1wqLYLNES-o1bCMJnms7rp1hG=DN+=YStgc38+vA@mail.gmail.com>
Subject: Re: [GSoC PATCH v2] object-name: turn INTERPRET_BRANCH_* constants
 into enum values
To: Jialong Wang <jerrywang183@yahoo.com>, git@vger.kernel.org
Cc: gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000008c4904064d721b80"

--0000000000008c4904064d721b80
Content-Type: text/plain; charset="UTF-8"

Jialong Wang <jerrywang183@yahoo.com> writes:

> Replace the INTERPRET_BRANCH_* preprocessor constants with enum
> values and use that type where these flags are stored or passed
> around.
>
> These flags describe which kinds of branches may be considered during
> branch-name interpretation, so represent them as an enum describing
> branch kinds while keeping the existing bitmask semantics and
> INTERPRET_BRANCH_* element names.
>
> Signed-off-by: Jialong Wang <jerrywang183@yahoo.com>

[snip]

> diff --git a/object-name.h b/object-name.h
> index cda4934cd5..167a9154ea 100644
> --- a/object-name.h
> +++ b/object-name.h
> @@ -101,9 +101,12 @@ int set_disambiguate_hint_config(const char *var, const char *value);
>   * If the input was ok but there are not N branch switches in the
>   * reflog, it returns 0.
>   */
> -#define INTERPRET_BRANCH_LOCAL (1<<0)
> -#define INTERPRET_BRANCH_REMOTE (1<<1)
> -#define INTERPRET_BRANCH_HEAD (1<<2)
> +enum interpret_branch_kind {
> +	INTERPRET_BRANCH_LOCAL = (1 << 0),
> +	INTERPRET_BRANCH_REMOTE = (1 << 1),
> +	INTERPRET_BRANCH_HEAD = (1 << 2),
> +};

Generally when we use preprocessor constants with bit setting like
`1 << 0`, we want to use them as flags which aren't mutually exclusive,
allowing us to do 'INTERPRET_BRANCH_LOCAL | INTERPRET_BRANCH_HEAD' and
so on.

Is this the case here? If not, maybe we want to mention that explicitly
and simply use '1, 2....N'?

[snip]

--0000000000008c4904064d721b80
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e84c93b07bdbac95_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tOUlLVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meSt6Qy85ZXBqd2duT1JCSnVlL1JVcFRDZitDQmxxYwp2cGNta2lZamNp
clpWNmN3anZMVzVsdi9ReStnOGNHeHRkZ0JXUm0yNHgvbUNDVFNmem1hK0hYaFQvcVJLSS9TCmNi
ZjJIMEppNEJkY1lQR3NhYTczc05pUGxKUUxaeVJmYjgvSURNWktKR1B4d3l0UmV1M1c2UzNla0FO
UXlDOTcKQk5Oai9qY05aQmJWR2p2dXJBTUNnSVJYUVpFRGgzVlUrQkhFcjBaYllkaWVOSjJ2Sk1S
bWRORDBQYVVlMnE3NgpKRmdDSFZkYXIwVmYrY25zODRxRzUydDBuVmxYbk8yaWVEZm5rVVEwczJY
Vjc1NmJBVHQ4d0poMUFvYUpidmRiCmgvWExHSGw2ZUlaUDIwckV2RTBqczFxcW1JVXZBQ3RrZUVk
aWt0Q0tRSC8waVdSSjYrRjBGeEQrcVFWYUVQN0sKbGxkR0ZTTmFmWHZSbzVxU3dNZTJmNnBGYWE4
eWNUMk85dnRkMFVqc1NLdi9mYUZqeEZhZk9nNjNlVmpHS0NFbQpoVnVYZ2htYWlpalNoZ3hhcjds
cGE5VENSZW9HVzZTVjhXSXhONm5FR2Q5VnNkeUpzS1o3SmRoeDVUclYzb05RCm1XdDYvZDBLNmZP
RzI5cHpUZld1SWVSL2trNERoK3BnOUEvbVBvcz0KPUZwTEQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008c4904064d721b80--
