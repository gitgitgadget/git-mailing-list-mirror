Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794176287;
	b=cor7vezxFAUfJc9vVNOBDOeOp4rbSyChAjSgY0hXzG8E7V2kehCoZ0/1gF1rsFfETTWv
	 xHP+gQagYhPy2FYdMDWDSu0q6i4u94AZv38wx0IRfD9Z3QHVurMAm94oEXtbs8/k9L5E7
	 0KKSV5bKWU22WPFvc1I9dNtSzWbd4bQVtOLG9pRRz6EEHOsyX+6heEvNE0eEKaNX0lLd9
	 KAuqxLFG2bkScVDtM+zHFfA7UqP3V6AsRzibEyBrR+bGckE8ilqXUiBTIJ/q/oKERJWFL
	 Lx4wNm7n7WMf8HLS6JbjFhHlnaltMJ8fl4jynQ8kudWUFAcMT9uj7urMyt1mo//AjUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794176287;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=VR8UbcT/nwrdIHDMVzUfPr2eeBc/4783RGUEZcz7HRs=;
	b=z0MqeAY7Hyv0dfHcRktaYxtvjL4ti77ySMZ86+qjBt/ug4gq1+RydPTpkZNMokj49htD
	 25FwYVl/N5lVEe/VJUUHlAYv/YNqycsgtkeFhN2zyAZ4F1LM4o44Diqw0i/PQG8UXeJCa
	 f5rBbOKFfunkDrsZ6ILSRbBROI+TXdYk+lT/3UbC7gKXx8zBi3QdycvD4scRAF9S9j38a
	 HE4V7/lymQod8kkiioLM/9+Df53wmL1thvRLf6nD+uarU1PmHSb0wElAnZcCFPsaV8CYP
	 IDVcbe+8HZIV1LzpDCVS9smBwvkYvQfnw82FRDfZBh1BerqVGSyP5lzcna02PSN151g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WYReK5K3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0C6606A31C
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 22:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB0C6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WYReK5K3
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5ea969fafeeso89937e0c.0
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 14:18:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794176286; cv=none;
        d=google.com; s=arc-20260327;
        b=Erg8j8bRIDWxu7EaL+5iUkpVzzIYdWSRJ6H7aNnGPYbqUqiBO5y+R3qq+9I0ofIiv/
         z2w3AO6A6dmc0SxfHAdMW5npe8QSZ4t8M/at3dVmUC2rJ8gy/wsNRiON1VTLXB3cf+zS
         9HVeE4IW6Q3AMB4uRApRRjb+r5cOiwqtQFQ5lR0PBdb+TRcptoS6PkNg8LmGhLlz4Ce2
         UhEIJNmELrtm4ecKPtmEPnINLSK1CSjMdzwIQr9d1uR8KibSjZIeKl0os9Qbcoh9Ffw+
         kJcWBZBlRCQh+ncdsEUqRY5hyDmAOkcHKVSbcUjPlRgZ27zWH2syZan1AwtBap0lu1BN
         NyBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=VR8UbcT/nwrdIHDMVzUfPr2eeBc/4783RGUEZcz7HRs=;
        fh=a3oDi4v/denlaHBfNu7h+ivs4wMJGF6t1XX+QJaiJOY=;
        b=nClspaYDboLUw6Op8CE/pzUuYcFh/lrebcgT2xGHq/x+2D0G1sZWtJ5cLuNr0MwgMC
         9UtBUyeh0N0YhBY0pEHKC9lIk3EnFvUtkRiuA0ik/7DlXDruNbpQldSPx6/+zuD7Kfqt
         Q5OvJ2aYoRPnHKBbayjMPEkq8dMZqWgFWA1u8JGXxsRRICfYHLPZmNiQwo9nHwjcTsJI
         XUBODn9K40d0zuGZFU5oZZoOq4vrcnpBXbJUg0icR5hN6J5j/IIPe7xTOoe4eAhS8mT/
         UmJGVnV1A2sKat1sOwt2ByJrDwCsJS8CfIPWC0m84rsUc64n0zqWELwc9LG6yYkFZB7C
         AX8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794176286; x=1794781086; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VR8UbcT/nwrdIHDMVzUfPr2eeBc/4783RGUEZcz7HRs=;
        b=WYReK5K3HPo9n5D/omRcGtCLH6MK+3st4m1yDReCucI873GMeJZn0FbUqSn1JPVhSN
         a2et0lcpcz6YbqkofhhLqTkU73ct8PGqoIiZ+3AJh77o4VDl7hr6rguBiL+PcydYYcQf
         6x2rdNdC+aCU3bncLlPevq9OlhMNzksHyWObVj9kVhgU7m3qgLb0/oe0pgzNSxbBn6Dt
         BsVfbdzoUXTSmA0Z4rXiDom96C5FsCHsy22yCB2b4sS1XmlZ9dnIPvn+/1v9PjWawqh5
         m95nN1rfUZbpaYQX7/T3dD4XL11rHgXVtWzcncgp00Q3u4MCDTnMpzMRtdCIDRBTsrvB
         g6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794176286; x=1794781086;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VR8UbcT/nwrdIHDMVzUfPr2eeBc/4783RGUEZcz7HRs=;
        b=IK9GdumtcJwcsSm8HN5jj0eKUQwB9JYH8khvxyzqm0QBU1SQDFQUueqsr8QFBWNS3E
         rf5RHt31kaiSNP2VEGPvsSI1QWhcKow4aQevskQ271OUPfq9h2iPMJ5Dj9KOILd9fKHx
         BO6GmkTChIky7yKXNU44l4oK+GGMVpv42NHckZCm6mIAwzShWQATboEm4EZjdNpFsdnF
         6Ij8xNBHQ4lMUrAcZpgApopQBWC5H2YIZw105ZGcJNYX3ljQcD+zwAyBytopLbSWLC+l
         Em9O+/Uf8MVZlIGwqt3EAOhlPRI0NcBunqokuaDREKP6z+X+h2zsOC0PFkyftlUnwJD9
         rOQw==
X-Forwarded-Encrypted: i=1; AL+hErGQG1jyXLJtdUzi/aLDsqZLWrT42EsN6NPbDmxguRyPxtMCSSL3yKuJpC7McJohf0RfCok=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WxdIk8fuL1NxG7a4o5mo6v2PGLo2pvPhBzgEuHrtPFOeCFDRy
	7WoojfV/3GJyKKJTTykOY25Zer9vZlSr7xK4Zh0bOKvC35ICWx6CsXo/IomDpsoGkLSoZFRz0/I
	J+wYynEDSLCJmP4mz8+1LAa/X2Aa4FfA=
X-Gm-Gg: AYBFou1V0w+Q4MzOeG7h98xRzegHA/VgEtK4L2EfoL04KqGRv6YS1YC0OAZmzoVHfMW
	PeUP1D9eX4meuxiP2O9l2rlytjm7gxekXl2C9UScXrAloJ0k02lRke9jM+HW3Ixtctxq/wAe42b
	aqxt3Anurpahp8QgZlYWRgoOHuZrj4gHaMQtDOM/6UQh1OfYMDW8u+R3W+m9D/BMVt8gukASxct
	7NFHj1DyGUNe0euTIqrkqrGVgCrtJwARvqnIVzBXq6ODQD4Mm1/aHE8/3mWsfR2nnUb42GCvKty
	O9EpD2UzOL6wfpOfeLGSK02V0cUcMfbkxJeP6s8p0+sSkaLqrVFWwfSJIj65Gp+MQlrekziebHl
	orILxlRW6zSL/3+v6C4NdLmPVmFUO6WEQR7cgZDXJTylpkX/bJUlHfEygqklJCz/mFcJ+wM9Ho3
	5mB60GpSz0D7zYdtZIZDsQkSvKdIFH
X-Received: by 2002:a05:6122:e266:b0:5ea:e7aa:acb9 with SMTP id
 71dfb90a1353d-5ece720b077mr633099e0c.6.1794176285647; Sun, 08 Nov 2026
 14:18:05 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 8 Nov 2026 17:18:04 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAP8tz2L3Dfhd+ec4+SFkZgXmzQnBg+3Y0REAV+1Hf5X415qnfw@mail.gmail.com>
References: <CAP8tz2L3Dfhd+ec4+SFkZgXmzQnBg+3Y0REAV+1Hf5X415qnfw@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sun, 8 Nov 2026 17:18:04 -0500
X-Gm-Features: AclHuK_EG7llSyjjuu5GZysdcvgaWfucwicYUnpoCJzPdQEoa8JYr-1WDwAed8k
Message-ID: <CAOLa=ZRSQ4_EGC8qTs6f0HBQyxj_k0Z-zt+uXt0JpO2Z3Mpqzg@mail.gmail.com>
Subject: Re: reftable: wrong HEAD reflog when its target is updated in the
 same transaction
To: =?UTF-8?B?5LqV5LiK5Y+4?= <inoue.tsukasa.4@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="0000000000002bc507065fcb388e"

--0000000000002bc507065fcb388e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=E4=BA=95=E4=B8=8A=E5=8F=B8 <inoue.tsukasa.4@gmail.com> writes:

> Hi,
>
> With the reftable backend, if one transaction updates a branch and points
> HEAD at it, the new HEAD reflog entry records the branch's old value. If
> the branch is created in the same transaction, no HEAD reflog entry is
> written at all. The files backend records the new value in both cases.
>
> To reproduce on current master (fb255012ac):
>
>   git init -q --ref-format=3Dreftable repo && cd repo
>   git commit -q --allow-empty -m one
>   git commit -q --allow-empty -m two
>   git branch y HEAD~
>   printf '%s\n' start "update refs/heads/y $(git rev-parse HEAD)" \
>           'option no-deref' 'symref-update HEAD refs/heads/y' commit |
>   git update-ref -m test --stdin >/dev/null
>   git log -1 --format=3D'%h %s' HEAD
>   git reflog -1 --format=3D'%h %gs' HEAD
>
> HEAD is at "two", but the "test" reflog entry points at "one". With
> --ref-format=3Dfiles it points at "two".
>
> Using "create refs/heads/z <oid>" instead of updating y leaves HEAD's
> reflog without a new entry.
>

With the files backend, this isn't an issue only because the files
backend doesn't support atomicity. If it did, we'd have the same bug
there too ;)

> I think the cause is write_transaction_table() in
> refs/reftable-backend.c. For a symref update it gets the new oid for the
> log record with refs_resolve_ref_unsafe() on new_target, which reads the
> refs as they were before the transaction. So it sees the old value of y,
> or no y at all, in which case the update is treated as a dangling symref
> and the reflog entry is skipped.
>

I haven't looked at the code, but your inference seems to make sense to
me.

> I ran into this while looking at updating a new branch and HEAD in one
> transaction for "git switch -c". Would taking the new oid from the
> target's update in the same transaction, when there is one, be the right
> fix? I can try to write a patch.
>

That would definitely work, but this same bug would exist with any new
backend that is introduced and supports atomic transactions.

I wonder if we can move move reflog logic to the generic 'refs.c' layer.
So for a given transaction, 'refs.c' can already parse all the updates
and also set the reflog values. Then the individual backends would
simply receive the reflog entry to create and wouldn't have to worry
about solving inter-transaction conflict resoultion.

But that might be a complex undertaking. I prefer the generic approach,
but your approach would also definitely fix the issue and would be a
very welcome fix.

Thanks,
Karthik

--0000000000002bc507065fcb388e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 34a11c99aff4e91a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ydzlSb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOXJ3Qy85QlZoU3d0VWkxR2hVWDIydTRkWStINGw2TApJYzZ2bjVMYUtv
SVgzbG9MUHNUbE1SdUJPV2FMRzR0QUNjQUZRQWdTSWFHakE3Q28vaVk0a0s2VDZGSGdleFVLCisw
SVZ1a2cra3ppdzc0cDN3MHNxZHFlTzVLeTk5VXVPcTdSNG5yaE5qZ0d5TUpkelZiVnBZaTA1Zkky
WmkrVG8KeWRoVFl4SUNvQ1R0MlF1cGZoa1RpYkk5YzhsSHhBSUNadG56SXZNQjI1bENqc0k5T0JJ
TzNGR3VZeXNUU2hZago1eTlHMGszNjQ3K016dTdCeVV5TDB0VW10ZlJhRy9UYXRhdUZlYlIwUENa
a1MxdkZJSUZaWng1VUlySmQ0cHcyCjNzdDlrdEVVcHAwN3FFMFduK2dlaWRhV0JuRlFGdFd3SFFT
UjlUQ0ZjaEJJOXRlMWJkQVkyUGVkbzdqL0hqQXEKU2RLRmtUWFptTVpMSEtHNWtPbHJGWSticHNR
ZGYxOVRhRmxra0tlYXlITm1yRXdqTkNZcS9lT0t3L1VRYVc2egpGdnREdGFZY2VFUEFCSzJmM09z
ZHdzcGtDVkRVbElHaWx2WDdQWUdxYTdOM29KS1FnV1Y4aEJ4OWRyMVJPRTMvCkNhcTQ4VFQ4RXAz
a054RTB5L1NySEt4R2d1R0YvOWt4b0tLNmZDND0KPVJhTU0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002bc507065fcb388e--
