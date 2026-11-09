Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794237837;
	b=Ri5+Y2exOU+UTw1/2Wzz+VGwO83GcJIVtyR/JLsbHR3WTuefL4zEIdv/YorYo7woiAn6
	 7xISUV2uNEBzM+CmAt4mx/pjwKrVSWLWXK4I64On23/OxhLE2M2oRzyJfcgnacFxYxit5
	 LldAAb+sJ217Rz8gFi70PGE+mLj7y4YcOXYn+Ylh2C8af1smhuhXfcNcl6HpRV3tTOnNP
	 +SxumFwWuHMGgJPeMIh9pyWdoIjdGPuMdUZUmVsItj0HG2NH9yLAb2n97Q2ZYdtT/KRbg
	 l7DbJSWVkOFJ/4ETwAlOyU3ozc74576jKwCFHBDzw/FUrcvYI58qkZO5IGxM44G5Zzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=/nlEHW74Y3euwl1Fi9YCpLQQkK83F2fVjAF7fiAhQJg=;
	b=NiYWOT/PhOKOkUDYvU+Ijr9HKZSLQXQWR1KX/4s+RycGTqC9ilqmGXwdAENWn0ueb1si
	 2DbZILHX24MdoAibFrOZGcpNk494rgyn28tzJ8nDdQjN4UM6snH4fE9b5+J7982EbDYYp
	 ACKxGn6OmDfjaDgmjtk3OeaN/CB9kF8E04t05O4p1ho0M4dIgrPWYlrmP0MFJ3h9P3YTt
	 G8iDLU2TfdTjzJnGnLll+lpRgUOSxOGWQhg96dtu1G+3ccKAG69+tUyumNZ/URtZMaguw
	 BivZeYHax4StNbu8tyJ4Mzi3CEupalqckxFcBygLZyi7KiVSjTfWJNbX14Iiy+TTKzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ldwe2kDv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39689606A325
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 15:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39689606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ldwe2kDv
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-37000e7234bso993531eec.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 07:23:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794237836; cv=none;
        d=google.com; s=arc-20260327;
        b=WCuGE1stYi6Wn1mtHDV+17zxwK8h5H4nie7Gxe+uL460LKIl9uJ4igZ9nsNEgBabJa
         q02DBnFFAi/NeemShMjeNBvN6wXkYBNHiMQR6Of7VuH8nPpln2cDxWn2PxBEksfD6GL1
         PmDCiPjHnOdeUuXbRXeo9OJ6IHgTrdvOsdQ4KkYEPx7AFFuRHMqL1U70FMyiuCL6s3B7
         hKWMRPstrjmU0PWfi6rlBDjV2Ch2XxU3b6cD8hAr+8Ke566QTELGphF6tbZ2hWi8YTrm
         i+R4TCgHZ+NQcHVZilqFi43WYky+0o5fsBq4peTey56VAHdqdGKV/yaYimYqd/1BmtJP
         adbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=/nlEHW74Y3euwl1Fi9YCpLQQkK83F2fVjAF7fiAhQJg=;
        fh=ayBmy5LmYNzlKQQ/uOFbaMZB0FxtjyMaziqy8HoLpWA=;
        b=TrGETWlgpqnAGEtwHMwdK6UaFe6KxkjR+4kFs/RAagkbQwR0/JbdrBO1qe7Rn+Zk/c
         yNPY01veO2skYEb9lhxtu4B97NhbF33qBvkxdkAbeKKm73bdVvyv+WzNTcRn4fEFunBr
         99vsV2Mb/CzckGxqz8J86VJ8qBkS8UIe04LcU5JnfPzvkl2dVrKChO0MY/X4DYoMmHS5
         D4V5BbGnND1FKIcTJq/tIrKi6bfTPeW3GcyjvXjqQ8Gr1nGheCDhkakfdhg5zoxH/43T
         EBVph97ZrO74lwR5sU9TIO1Xy5cogH1eUiUHNtTQr7h+Qj8E8gL2B8t7AuBkSa0hTOht
         wndg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794237836; x=1794842636; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/nlEHW74Y3euwl1Fi9YCpLQQkK83F2fVjAF7fiAhQJg=;
        b=ldwe2kDvGfl98WCfKCfiOchmp7iI0liuppWWFyGVWLfFUwYvwI4iOLsPOVVnn2eXT/
         TrZVCGwk4kRrtw3AoPkAk+eDRyVJyZ3KYTSxXzEBTaKOLWzsSt7a5mj9eCuQ0aIzT+6j
         0cXxvjbum1NUSsxQkMUKIsIGGCT6WCXgmJo26FEIJ1yOCzkScxhgbUV+/Ld0gZkvsGvJ
         pP+59uoq3afQEEtzAbgYb71zll6BzNqw9K8a/qmsie/rZOB6USP9Rdvkvohe0ctQ3VbW
         Ao6CTQ2qYmimwCTAMAgoSRsXHh/7qG5pgua0+KBF7nM9yk+iQaTuZ232x0slY1UH7oPz
         fAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794237836; x=1794842636;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/nlEHW74Y3euwl1Fi9YCpLQQkK83F2fVjAF7fiAhQJg=;
        b=0hOhow8Cm/IPyhUbcikAspskUTDFvkTIccUxNu1gkUENQ5o2urliUHLVoHuNZZwGfv
         5he3EwnJ3GPRu8xhFTs/ccfEucYyQMnUuuqr5S2PLeJ7BXub0an4ZS8cWtAjsZHIOGJ+
         SGy5jWnTNcQPW6VdMaV3wz33H6a5Rj/4WEr1fAZDus6IYs/np4STUZ8A7tAUQq9O5FM1
         zn+lsrorJJjNOb12R74+R9yFtN0G6PY18+zOiDk1hE7Ie3oAKkXQ7PG9GfpGXT0/5MAB
         vhhTqS39n8fAqE8U5cEr6lDAegX6xS4lXTBQbagl5CBl59uuarWDSzZMiqiPfh0oOZ7M
         /kXQ==
X-Gm-Message-State: APuU4Z8BDvLi+USJNHeQP8yDie1B9Pxp+ErhCWGYe8UDkpAMUB/aDYGU
	jfAeLYu+i7bF91r5wlmzGnLPlJjvXKwBlFTsMA0AeAqOQdyQVxaKU9sl+1gzZzKH3RRwnNIENUr
	sw/3QjdUnHwrwqQHYEbtIP/pqG6DcGjdS8Q==
X-Gm-Gg: AYBFou1GEC4/Ql8AGtD/xdQVS/v+/RvwgAx6jBPx4abUZrOSjch6nPtYaWiRl6Bgs6l
	Lvea7m6TmgH23O9hGUmAmSjhJdCwbFbJPcNMVhIefMnQpf3ARIuE+JrwqltiyPqcqUIvW+1zCmt
	CU5OHOjdpZDa3/k9w5TZmwpUmhAdbfX0hhA3NtyYp1CnLI/4EeZ4hJwjnR3VmOTF4UOG6Bj3fRv
	W67uNgrpJIPyAd35+47/UMMDnkbRY3ZrRBaZYf/ydDorJE/IOR5++5xUgDXwFfjBXchcyvzgD8t
	ysSCIAGzNbOLe80JgMd0dDF78mx30k3gv7BMGrtcEjWeXJ1j3tclORXuvjDEyTU7rVnJ3i/i7+F
	bLL1L1Fvoul7WhHBUsTVCCn1gTrZyx4vpxpysdYUzslVRMbPQTIzmcwzIpwYXFrzNg3y0X51qoG
	1pBudcXYhCMM+usvRME5a5vVL1Rw==
X-Received: by 2002:a05:701b:455a:20b0:1b2:60ab:1e9d with SMTP id
 a92af1059eb24-1b39ff1912fmr6550320c88.37.1794237836173; Mon, 09 Nov 2026
 07:23:56 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Nov 2026 09:23:52 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAP8tz2KFb971L5_XY-hb8M=vfK-AsWwk_7YoMK6nCS8xhUKQ+Q@mail.gmail.com>
References: <CAP8tz2L3Dfhd+ec4+SFkZgXmzQnBg+3Y0REAV+1Hf5X415qnfw@mail.gmail.com>
 <CAOLa=ZRSQ4_EGC8qTs6f0HBQyxj_k0Z-zt+uXt0JpO2Z3Mpqzg@mail.gmail.com> <CAP8tz2KFb971L5_XY-hb8M=vfK-AsWwk_7YoMK6nCS8xhUKQ+Q@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 9 Nov 2026 09:23:52 -0600
X-Gm-Features: AclHuK8obMY8tSmrj6qiV4wEXwRp_1rQUrppPbEijhK2xpKfDsLsNwuhEvkcua0
Message-ID: <CAOLa=ZTYevwM0YF0iQFnEwKG_buV7qg0QdjoaTkw0c8OQSd-mQ@mail.gmail.com>
Subject: Re: reftable: wrong HEAD reflog when its target is updated in the
 same transaction
To: =?UTF-8?B?5LqV5LiK5Y+4?= <inoue.tsukasa.4@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="000000000000dea5e5065fd98ce7"

--000000000000dea5e5065fd98ce7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=E4=BA=95=E4=B8=8A=E5=8F=B8 <inoue.tsukasa.4@gmail.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> With the files backend, this isn't an issue only because the files
>> backend doesn't support atomicity. If it did, we'd have the same bug
>> there too ;)
>
> Thanks for looking at this so quickly. You're right, and it shows up
> with files already. files commits the updates one by one in the order
> they were queued, so the reflog is right only when the branch update
> comes before HEAD. With "symref-update HEAD" first, files also records
> the old oid, or no entry when the branch is created. I was wrong to say
> files gets it right in both cases.
>

Exactly. So it's a bigger bug than just reftables.

>> I wonder if we can move move reflog logic to the generic 'refs.c' layer.
>
> I like that direction. As a first step toward it, I'd like to add a
> helper in refs.c that returns the new oid of a ref updated in the same
> transaction, and have both backends use it before falling back to
> refs_resolve_ref_unsafe(). That fixes both backends whatever the order,
> and one test can cover both. Moving the rest of the reflog logic to
> refs.c could then come on top of that.
>
> Does that sound reasonable?
>

Sounds like a good start to me! Looking forward to the patch. To also
add more context, we've also been thinking about doing conflict
resolution for updates within a given transaction for a while now. This
seems to play into that.

So a transaction like:

   delete refs/heads/foo
   create refs/heads/foo HEAD

would currently fail, which doesn't have to, but I haven't been able to
put some time into this yet.

> Thanks,
> Tsukasa
>
> 2026=E5=B9=B411=E6=9C=889=E6=97=A5(=E6=9C=88) 7:18 Karthik Nayak <karthik=
.188@gmail.com>:

[snip]

--000000000000dea5e5065fd98ce7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6387df70a930a824_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yeDVZVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meUZsQy9zSG1RY0ZKQ21pYXZuZDBrL3VDMDVmbytrTgpXcnA0eVUzdkNy
ZGtMWG82QktZbXEwWEJpVWxObkhKNmhtL2xIaTNFb1BSZHBGVWswZGZvaVZsbm96TGVsbHZKClVp
bS92MTVVK29qYlhUSkFCcno5RWh4Z0F4UjdnUDRCUWdtTVNVcEdraFFnUStQTWN0czBqUE5TV1ZK
THhQSVgKNFFzdlpPU3QvZ3BuZUdsdDdlUkx1RitIdUdUTG5lWjhwQzNFRHVGY29ER05BUnlMNTJq
S0lFaWszcXgrR3J0Zgo3RGRyQ1Z3VnpSZ0tVazFXL0pTQlhienJCNS81NVhsTVArWDlOSm5rS1pF
alpnTTdiK0NaR29ybndXN1g2NlJBCkw1UEhOc2ZpSFZtaWNOUXErSmR0QkgrWXVzYXo3U1JNb1pk
dlgyTTZpYmpXVFYwcUZ1SUlvYUNhcWVlTXJQSTQKTUtyajlQM3BhWldSZFZpLzVuMWlScWRvMStS
anRVREk2TE0yTXU4WkNSUXhUaUFaQjMrdVczT0pMNzNsakxVTAo0UER5NzZCL0ZMSmZGSnZHT1RM
NWppbEl5ckE3MStHMS80R1prVW12MGl1VVFTdHhzOGFNVEJoNzBQcGhwOXJPCnZRTyt6dGwzcTdB
SzYvTHE3cWdZVjRxN2FPWkJ6dldFSllZZFBGND0KPW9iU0YKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000dea5e5065fd98ce7--
