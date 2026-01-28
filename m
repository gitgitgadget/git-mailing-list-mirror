Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0024316DC28
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769598357; cv=pass; b=C1lqnSreBvEaLDGRukHXnwYRieevgY288iJpGYBtmOEqyxePsgWTTiLKRop3u90cWPxANgj2KIBqct9LiWjIImG2VXRlzd9JpL/UHYu9PdnLrh3oaWHpiYmrEgIOcH8qYtUCDh7Em8ytWO7YoGAIwQlap7ey2Xe8K2Ax6xW4Zt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769598357; c=relaxed/simple;
	bh=soD4z6BVnk8ty7tohJAsEWk9V58UyZKEqNTQSMeFesY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZSuYKYCPXGhmCaQWxei5X+DYi6MQesqvcDzlatwrA+3kItGUjiPrDl25LpLzQtJ5VXVqksNlGnnxdrVpsR+O6O7e8jKCb6Jejg7FAeerzutr4A5Kekbsg9ugXji6XJn6Omh0YnAE/n4uZvA2pfaxaPOsPwusxJy1Z7UceieD6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFxXnNWq; arc=pass smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFxXnNWq"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5f52b0728ccso2298110137.2
        for <git@vger.kernel.org>; Wed, 28 Jan 2026 03:05:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769598355; cv=none;
        d=google.com; s=arc-20240605;
        b=cylCGDIlaYs+OA/pul9rOqU7KPyd9naxPUFWmFx32fP2iYgv/4SThzg/4nqVv2LyKT
         8mDd42RBNSDG4B6OF7ZZPIrkgBZUMiSG7PLT4eRBUIoQG4bFG2bIfciEOXMwgmzI7QIN
         yqwuKPl3m0Rh/w6NoOgZLTZbYcZ0uIkYekpV0ZvP0AltgMG7Z8vZeKdCG+2mQOUacLyb
         ph5YdSGBXT4ndnDpPRN5IWZSkjjCVzCGV+awnpGoWLzFRmFrDookmFmpff9kstMsFtGn
         7TqhGK2Hps0b2Xt30OxhuSv9Cqfta10jCMlqJc2h5s25Shc7FybBHLVyQxCLZaG0k+z8
         vHDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=soD4z6BVnk8ty7tohJAsEWk9V58UyZKEqNTQSMeFesY=;
        fh=rIENU+8kq84gqK0dJl/w1mb6eda0VGARkVMlOS2iKeY=;
        b=SNAk/QICMy147Ih8dCgqI8ej2w7N5Psk5EcAaz9BIQ8BImMjW+plmU6T/GA9v0yfGj
         elfYTQmEHcol2HMYPyQee+nBggmejqg/bphGGsK03V+k3bCLaAXEFZYzDm0lfuY99hQX
         mqNAGjKv6xqqr6JRiyDlQP7BWQOJ9Z1jCIZEAXsS4qd7zKuyvYCJovaRH6jFM14iyNyU
         XYD92cjP4IcVgwB6CsRtwDpsRax2/fdqFEdWVXC7sxh/SQpQx0JjZOykWLzpwco5ndrG
         Pz/rmxpamty2NA+9PW9q8tbIW8nehkZX9t5MQJGQYJlEMGiMAU+pQe1RxZWOc2QPg6cS
         o/xA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769598355; x=1770203155; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=soD4z6BVnk8ty7tohJAsEWk9V58UyZKEqNTQSMeFesY=;
        b=AFxXnNWq36nf/Se0rZtwvaqtO52Q8dAY3AuBpObkxJdc2Pq1R5qgwj6Iu6QUquJSdF
         qNMyisqDtYnnX+4wjh02+4XwvEXePj8tyKtD/ZD2mkL8lwoY1D5WpF1MNwkjRmaGt5Fz
         YZxm47d3tHvcdSdfY2gtV3ZzmC3JedtQX0GuTXU9lhBJlKpW9cWJgUivlo6pyxJAzzt7
         4W/os1ek9FPxZwGZc+RmmP3eoI8pcomYOVDbbEgfIPZj9P2tng6If5N7+L5CVNfZBlg/
         zP2AlkN3IhmMMOx44sRJMQpgsX9cWyrhVmVKGfG7A0Ezv6rDxZ3FUEWPaW3cvxkXjynx
         vYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769598355; x=1770203155;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=soD4z6BVnk8ty7tohJAsEWk9V58UyZKEqNTQSMeFesY=;
        b=b3BZ35IH5A6uFHmFz62nESNS9jmnmE2SshkJx8AuunVh9LsmOEN8QE6mQWl8geZiPk
         /KQudoRrfGFFxNDiGaLSKaitmXW5YEHQBVr3rn7qWDP8WRAe+ytCQ8TuIsQ/BI2Zf415
         WUi9f9jebiTijR1rKJj3/izRayxf1Y1QlGsOge/zPJPH+hjxF76iKIU6sAQ4W285EUFY
         7M9lJNeVZai5uUAYVYY7POdpbrdtFeOegz5UQc33SNYzG98VRlk1jkIQ3GVx6WKw5MRg
         AFsP/VPJ73lAakyWLo+3/dnfGXQ7GIBYDR4L2GZRr/Kv56/PqDKg6n7p56vyYoozoDT5
         Fa+g==
X-Forwarded-Encrypted: i=1; AJvYcCVNxVDU0h03w8fAYbhSY+x7KZXpWn+qNRwzYUUvNO4PGRdQUSQ2dcDd90QekXo8EiOeCRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3iOELJD3t49uWDQz46CqFxQxKKjWFenCxr7dG557FTy9mMrN4
	YP4E/KI9/UA5/RNKUcUedTk8i/WsAB+KsKRReZroEMoM6IkIV91XTeH5NCcObBNfxgSyjSKAXKc
	ty/QbKq//nQ8BsfGcoxEIkpyQWX8nrDFKV7X9
X-Gm-Gg: AZuq6aKZCtklfLqlaaeKLTHANJjj5jNUmLkuPVwL/qjK0y+4ziaW1yY5D/zFXnjX4AE
	NdvfvPz1jNwVC/yQMD1uULxON5c/aesnr7J3p+nOjqfLTRw9zo6/aMbMfWldLINcnq9GgqlMNLD
	oTanmKBBgpfKcOvO96cYa/XdinPs5DD7+GX/mLj+y+tglVg+Bpw2h6OAT3A6VGu72N6oR2KohBg
	3YWpcVLmweAYNpxbhCiYOWHw5OVZ17OAyruBPlf936XSQQXZ+UsTW5o2mgIMdRJD9RfHK5kMmfm
	jD9HH7gUeSD/PiQfqQihIRJE/ZeP
X-Received: by 2002:a05:6102:2912:b0:5f5:40ab:2d5f with SMTP id
 ada2fe7eead31-5f7238229d6mr1774394137.42.1769598354905; Wed, 28 Jan 2026
 03:05:54 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Jan 2026 05:05:53 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Jan 2026 05:05:53 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
References: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 28 Jan 2026 05:05:53 -0600
X-Gm-Features: AZwV_Qhce_QhEdTh8_OfouBYFHF4kgEoEuDvzKOVJactoDTa_dkyCyrJr4oD2oc
Message-ID: <CAOLa=ZTX1uGBgsxXFPTBujLmMgKw-X1HB1reZ2jar7yeSnzH0g@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix misuse of `refs_for_each_ref_in()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="00000000000056f550064970b99a"

--00000000000056f550064970b99a
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this small patch series fixes a bug I have discovered where configuring
> "pack.preferBitmapTips" to an exact branch will cause Git to `BUG()`.
>
> The root cause of this bug is misuse of `refs_for_each_ref_in()`: this
> function accepts a prefix to yield refs for, and then strips the prefix
> for each ref. Consequently, if passed an exact refname, then stripping
> the prefix would make us end up with an empty refname, and that is not
> supposed to happen.
>
> There was one other caller that got it wrong, too, and which is also
> fixed in this patch series.
>
> Thanks!
>
> Patrick
>

The patches look good, thanks for the fix!

--00000000000056f550064970b99a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 297869ce462aa976_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sNTdaQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNnFMQy85NkRrOERiWHlzSnpKY3pEWWlDNHpRaTdJUwpYdTJrS3ZDcHJy
TzBUM0NZU3ZFS1ZNWjhHbTVUQWFhMTVLLzlKdnVrYXRyZnlZcVdZOEtacDlJV0hBWCtUSDVqCktq
cWdSSzIwVlNqQ3VETFNBZG9DdXUyb1BROXZEWUxCV3ptM2lsd3dQZ1Z4NEpLSi9pZmJBN25vREdZ
eW5vZDgKOTkxUElHa2ZxbUNtektiWk5ueHdBZTBXUkRXVzNnajlaQlRFaklWTDhJTUdHODJiZjBR
dkZqR0d4WFg1RDhzSApNeDNQRGRWbEdEVDlWYzFFWFp5T2ZSbFgwSU5QblRuNWtPRVNDekFadGlJ
ejloa0x6RXpwamZGQ3VXT3FxWVpZCmdOblRUZFFQY0lHYnBDWG4rT0p5QTdRcnZoLzdVdkkrcWIx
WXN4N3hnaW9MZk0zOXNVczczQWZEUTlYd3ZzRFIKN3Y1NVRBWmZYVk9XL1VUbUZsb3BjVFR0bkt4
L1ZzRVByUXR6QWhCSDA3RWJtT1VjUjBha01BWlIxWTQ0enJzWApQVysxWUVoODhJN1RNc1dZSUV5
aVA5THBCK0thNU5mWTgzYVVWMXcxdXVrNlNKRVZPTHNmVEhyYWNEVThIWlhMCkgyQzVSSk5TUFRw
Y2J4MXVJdVp1RW1ad3YxSkdBL0V4ZHhnRFRUZz0KPVIzTEwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000056f550064970b99a--
