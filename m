Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795001307;
	b=tiNTrYmlZQJa35Xyk5T2nP/mNNPN2QFXzWT9qWWG4GeZBs+CvNPbUEl3BNY4JZS7O+4V
	 8l+y1CdXPiZO6lyoXInoNyNcuWHQYfEAG8KSi2b1q6fQ+kYOn6yPqkNnTUxxKxWTUjUnT
	 bCU09TVr9oH/kjRTZWOq7EnRjwDdDEQ4mmxLHE0Sl32olDdIlG1ev+UPGgvXYzIbn3ct4
	 avxz+7SDoF9Cvr10XRuwtf31LC7Kf2JD9uWpsfZPvWwumA3cg+BVjbjgwctBQEqBJX6V3
	 cUvQzRF2YvFI/knZxLNBcZ68FrH58S8wh/CirwVy+6gj0My8VzPZ06tp1zPi2DRu9fQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795001307;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=b2YGwlFSQa5S+bKBpryxqHyWye9ttgrnM4KG/6GjCNM=;
	b=rDU3SdZ5UWvcfqUf3W1IleiPdSrW8VDLXPVdJMCfA3zQ6nJSF4e+aoRqf6lvMjSEQAEh
	 mFDdZmI2Fi7IuHkAJuXkdRT1Z2Zn50Shz47WJXBd6i6uTV+UV10Nsi1wWBIH7dquHCGg3
	 MvR0huDZHLz1Zh+nCNB+ue1tJMDugG6oo07A2y6kjOLTMdTLg948GCMVy9/212gCxnqmo
	 VHL2cBzkCqfTqrdFBtcOilhGKMLkRzkCc+Z/jFJR2PWoKxKv/rPrukrPhfRbnHh0b9OMz
	 qKAuMzUiNNpNGY/22EvIsjRlftuMJaJF7CHorQPiskv/pWw8NmcjxqpXRQZ0DZTOMEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kYfzdGhB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA4D606A32C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 11:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FA4D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kYfzdGhB
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5ee3e658c70so244327e0c.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 03:28:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795001306; cv=none;
        d=google.com; s=arc-20260327;
        b=Ee158HIkhprrU6mf9XhGS2rzF7Iqd1lgQheh+fdNk9lVETmbu5YMynGle1VjcrdPDY
         cUL1LT+C/WbK8Iq/PmTxSw/je63gSSN5Ov9N7DVtf4IBgmIHCKM7uQmLxpWoJFx70xcu
         kvgeh076egp27yjPvOILg5T3LYqnqHay+Sm5sAZhV6Ll5w8vV1RFji56TiH67pWEBK0a
         Kr24vo/YHSJ0tLHBEL8OOQzESyGt7j6fgNfnGoF4UhP0jNw+H73HW/sYAoln9BiSPE6R
         b+RHgRif33UVN0Y/jWZXmNgsXL5LQuq6DqQ+6smUleLStIIL8xfa+ZXNQZ0Vv1n2kWHD
         ScfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=b2YGwlFSQa5S+bKBpryxqHyWye9ttgrnM4KG/6GjCNM=;
        fh=wb0kO0aRGG/TjjyrjOYTQI1unt9m+32cXlwzsJWkrNU=;
        b=ivp+M916nooPn3Pwmgdp3Oqv8SD0pIyW5K/EdUBj96ZmvXVpDfC4Xhlme5GSk0ioZo
         DDCADVBTag1XC8xZ2t68Kd+cCp6CgcxTyl7RqV/HzaS6Kq3BXMhUPKPAHKb4Hznf9E10
         s7+i+1ObFHuqsnvUcgr9WjN76iKRFfOiWWIegrruR3fnwC6NVbe+Zhf5RJvAtVQAMLQK
         MZDCvgLUKOPuFbv/Tq3arMPH8qntEFkUFKCwleVNvCDvfCpRhIr8c1U3hIxEMuqWyjDt
         LeYM0YXohDOaE4FQnmlFe5dD4/RlRepBmAC9JGZj336p2YoIaGoK+E1TXlZtg8QjeDNJ
         7MYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795001306; x=1795606106; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b2YGwlFSQa5S+bKBpryxqHyWye9ttgrnM4KG/6GjCNM=;
        b=kYfzdGhBEtp5qRa4EaI9HfMPBRmq176JnWpCCV10q1ZfDXGK2wexDvaNQjmZYk9FTZ
         es1cA+aQd6JKs8eh9kVoTloC6z8VBBw13v0kwA4NXDJ6X6RBIAi3nsjcLN9MTclelzgI
         WDa7nDM0/RRtXXZBZ4hPE2rDtpMDb5ux//hxZjKdALeReeJaJSPMJ72eKSrEPYp6WJnv
         vX7UIKxTEBCc2ckGg2g1cK10LHR7EaLDGBdEaNt8GHHurS8c6B58NhqaBiK6E+VIL2WK
         j3uXUzi5kQnUuNHbPGvDV07zSgKnZh5nqf9ZMVydXUqiPMvx3MSLKcGX6T2NTHP1sDRb
         bAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795001306; x=1795606106;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b2YGwlFSQa5S+bKBpryxqHyWye9ttgrnM4KG/6GjCNM=;
        b=uVOgEnYzxSVszBqCtY/Sycl+Tp0HGSdMQ9EKHjV4QMFchIB19V17DQ+PPWWfu91+Go
         +rTASmRe+bn3EpgpSgRgzpmBdMhX9BXrQzeT8FMjJIlNbjmeNvm1W0Q8JgunRYXTg6rn
         b8jA9FoHkA8Vqn4EwymvbRC4YvUNmpr+KlE7s4PACGBCb+3ngZQZSfupRXbkJS9oYKEL
         my8a5fxvx3NNtx1gn9WD2hmlFGZUODAtZLNP5Ma9LJQDnt56ymkl0ITW5msLa7BZVhAu
         ceAvWHJc97l+VZj2nu8ygaN3aCDS75loO0YuG4ms51hINpYJkmu+fSIiKEjYJhYjzyXY
         wwsw==
X-Forwarded-Encrypted: i=1; AL+hErE3N2l4ayalqHq/3hkq0AmKZ34oT6R30DHcxniF8KTAlU14nMcH3ybeNIId/ljw8+zJgvk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9C3VMcIfUUFDvMWmkkS/rO/gZXziqYuvcoJy3d+7pAaR9N1Har
	Rp7wlbxLpDX7yFixFC/LUyrvAs3JzLiUo+0CnKcFeMNC1ZRda9K+grcqZUJnI04P8q1aklTuAPT
	3/0sEQYgANgzFMpazQ11dUWUH7NMs6BWPlQ==
X-Gm-Gg: AYBFou0X8V9yDTjC+1/HNwlCddVZR2ptZ3S26iLEYKSs0ShdipSrZc0EqbVrsUUTPG4
	chrwC4oYiEaN7Ayu2zvFM1cc+GBQcuJRMPJz3eka5Md7ar1a/2hiDAWtLEvZKQnGhxiJXQMx2Gy
	t8D1pUgWg/dJVJgwZAvjYsTg/MqDSovuLVryR1yHs65zmRswyZPx5RL3QnuO1OjV5PVqACWOM1C
	dBQuq9n2GxHosOv27UPH1t9ahZXMtcEuCiVe3PBnoPNppCGBTsC+5tC2KRmy5iHM+NYX3Jjxa9k
	Y6Vk/DUWsfJPQzgujQ0IB3SfBzYJbH+H6WqrrK3M6eS8EAheYj/GN7ZTOOxrVNH+J+h3dw0XEPX
	66w9Ah3wpfynKM9gizCAOVYAJdT1vUqeVoYyLOUYaiLfTf7GJKtI0xFOQjAKS2qO7uEZDwre2Kj
	ZbGVTrkVGmH7x8oQn25OWQYy4A2u8J1MJX6s8Qsu+zAKhevurXnw==
X-Received: by 2002:a05:6122:1310:b0:5e4:f6c8:b0a5 with SMTP id
 71dfb90a1353d-5ee644c70b2mr1057789e0c.0.1795001306240; Wed, 18 Nov 2026
 03:28:26 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Nov 2026 03:28:25 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261118-pks-reflog-expire-performance-v1-1-10b9263566a8@pks.im>
References: <20261118-pks-reflog-expire-performance-v1-0-10b9263566a8@pks.im> <20261118-pks-reflog-expire-performance-v1-1-10b9263566a8@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 18 Nov 2026 03:28:25 -0800
X-Gm-Features: Aa3M54ojr8K8IrNu_qqOFxszGjwPWgOu2rZEkyrBQHMwbQHAJhpmbLIsQe6G3e0
Message-ID: <CAOLa=ZSx=m=5+Jw8JzKXutaYp_mKOWbSsBVTHtMT3rDUk3a=eA@mail.gmail.com>
Subject: Re: [PATCH 1/4] refs/reftable: don't write new table on dry-run expire
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000003af9da06608b4f87"

--0000000000003af9da06608b4f87
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> The `git reflog expire` subcommand supports a dry-run flag. When set, we
> print what would be pruned without actually pruning anything on disk.
>
> But even though the expectation is that the on-disk state won't change,
> the reftable backend still ends up writing a new reftable to disk that
> contains the changes. This is of course rather pointless, as we would
> have already printed the entries that we're about to prune at that point
> in time.
>
> Skip writing the data, which provides a small speedup:
>
>   Benchmark 1: git reflog expire --all --dry-run (commit =3D HEAD~) (10 r=
uns)
>                   mean     =C2=B1       =CF=83          min     =E2=80=A6=
     max
>     Wall Time    414.2 ms  =C2=B1     2.2 ms     411.8 ms  =E2=80=A6   41=
8.0 ms
>     Memory       116.9 MiB =C2=B1     0.1 MiB    116.6 MiB =E2=80=A6   11=
7.0 MiB
>
>   Benchmark 2: git reflog expire --all --dry-run (commit =3D HEAD) (10 ru=
ns)
>                   mean     =C2=B1       =CF=83          min     =E2=80=A6=
     max
>     Wall Time    369.1 ms  =C2=B1     3.2 ms     361.9 ms  =E2=80=A6   37=
1.9 ms           -10.9%
>     Memory       116.8 MiB =C2=B1     0.1 MiB    116.7 MiB =E2=80=A6   11=
7.0 MiB           -0.1%
>

Nice find. Obviously the previous flow was wrong.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/reftable-backend.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 3ba6a9ac0db..4216a18684d 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -2706,6 +2706,11 @@ static int reftable_be_reflog_expire(struct ref_st=
ore *ref_store,
>  	if (flags & EXPIRE_REFLOGS_UPDATE_REF && last_hash && !is_null_oid(&oid=
))
>  		oidread(&arg.update_oid, last_hash, ref_store->repo->hash_algo);
>
> +	if ((flags & EXPIRE_REFLOGS_DRY_RUN)) {
> +		ret =3D 0;
> +		goto done;
> +	}
> +
>  	arg.refs =3D refs;
>  	arg.records =3D rewritten;
>  	arg.len =3D logs_nr;
> @@ -2720,8 +2725,7 @@ static int reftable_be_reflog_expire(struct ref_sto=
re *ref_store,
>  	 * Future improvement: we could skip writing records that were
>  	 * not changed.
>  	 */

This comment doesn't seem to get removed in the following patch.

> -	if (!(flags & EXPIRE_REFLOGS_DRY_RUN))
> -		ret =3D reftable_addition_commit(add);
> +	ret =3D reftable_addition_commit(add);
>

The changes in this patch look sensible.

>  done:
>  	if (add)
>
> --
> 2.56.1.831.g720f3f5937.dirty

--0000000000003af9da06608b4f87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: cc763c47f1f881db_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yOWk5VVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK09SQy85OWNtKy9HWCtEcnd0cXM1elhqK3BkM1lFZgpXZ3UxQkx1aVY4
N25kMC82QW1LeXJtZTk0TUpTMHhuc2JjcjBSaXZkUENzclVoSHhSNzFmN1F1QXk2K0pMOEhSCmtl
M2lrVEYyeFF1R2lZb2RLR3lzcVZsV2pWaEdFbEk3bTJwOHdQLytHeVdZbE5LNmwzdDNEdW1FUE1Y
bmZ0SlQKTjF5RFlHV3Ywb3BIRkJuKy9jeUdLUWIyRk1EWWZnNXlJQ2tQbzB6Y3BSSGVKN2ZqVWxP
c09VSmQwOXVsdG5IMApqVms5eHMxVnh1ZVpiZVFPYVZleGxSb25tV0dQSS8xT2lZNWtTT3VHMWUr
cjc5NlYzWjlMSW9ySm9mekZzam91Cmd6MlVIc2s3Qy9JenIyWHpqeHUwT3FaTnlScmZkL0R2RnZl
QlR4TEFKWHg5dE9WRkZVM3RHa2tLOUY5a1FnSVcKSzhJVktSUnU4bnQ5TFlPTndVZmxheFBCRmZU
b0VycG1WbEcxYm9BSWpUenppaE9BQnJjK1Q3ZnIxTmhQKzdSMQpad212aGpmd29RdjkrbkVvbHRM
K1Ntb29EakhlYmJXK29wNUtwcU5IQzNxVGUrejhRVDZ3a3Ryek41NFJ6VElOCnptY3FwYS90cWpv
MFRRQ3hOemJpOW8rWDRKbm4vSVFsMzJlNmpQVT0KPUZGRmgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003af9da06608b4f87--
