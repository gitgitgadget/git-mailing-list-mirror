Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7477034EF0F
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 09:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837759; cv=pass; b=qEiJqRaW2ZDoWWMOSRLUuL04mkdhYTmlOzA5p/DyeID5IFGnrr0dFFo9K8q6k2FuHu7UyXHsjmcN1BCckYAxunwDrkvNuSAeuPfd7QS9TBBaDwpKRSpVA1KMNpChECXWOE5pvetBqRy+qBfMTLTZ06y9LBffcYtNoMVZrVRuFys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837759; c=relaxed/simple;
	bh=NkV7tmaoRpcgcgkOCwOilEAES6GX0TV6fayvTEzuCIs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=NSF9NK3r8lEbsT4We2VTNjY9wk+xw1LDbnaek4+Zk9GDvHkGEF/cpCno9aiFSvpucEmhKqy4G7GDVtkD6Wfk+8GKOnx1ZW3gvpmxdv5plAWgAiQv3rAz2p3xrf78WTCDl2c3yEc3x9Whf2xw1kXFDL/rfTj7voG65W4C8p6sTGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrqgm3v3; arc=pass smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrqgm3v3"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-948c2035a27so1036770241.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 01:09:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771837757; cv=none;
        d=google.com; s=arc-20240605;
        b=TU3WB1jvEPdB+PBA6KMUkqm1Jza2maL3dULpcZ2AjBwwaWBCuVRMX4pZyZvqhbDAW5
         vB5VwJjC7+u90uz9og9YauJ6vxsTNWfY/2JR1fHa0XremkbYJneFmoPUbp7wLna8Qi79
         XTok7UYW/ekxHIagIdIHX8HD0lskZxW594dK8OXkUapBCpH4mxLPC5o9BZcnRtFGuhGs
         MFjUtwk+YpH4vYD2kAXotco4AEl9Y3DmBX9Tvx787F/6DU8Y18A9W63eWJrWs4Soy3MC
         yxWVTobckP16x8VZzD5bcbhJwtySOCKb0GQoBoAkM1+Iwcacfy3bxBIxdXAqdRuAdEM3
         bu6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=Fm9rodHOqPK/SMnDjhtEFEuxbgdj1oa8x9/7KIcoy+k=;
        fh=++9OUv5HaKEuKa2w0QVevdrNoFIfMb/a4XmrhLBGkxw=;
        b=fd2r99Vjb6fq7CNxgQ8I7aPS7w92i9+UK4OngdDD/PjPuE39+PdQVXOGvpDlsHnKae
         MupPgYVwTyI1EkaiUYlcwnGp5whrbGRsYDyfsgUY6iG97NzUHn+Lvg34r5PjucL776VM
         /KT5lDLuPgJAoT+mypl8l//nj53BsVB2En8dkT9QVy2bGTr6Wte4o765Mp65dM+E+u2u
         xbMP72ChGhEcuTRpXNbhKIAMHPoTTjwTHX9istkbCvFGEs2npdv3twsTAVfyHqnNYn8B
         UHDw7QiIiGDca3DMxmLdnCh8xTvfXiSZ5PNHFEVkP5Im09H6KLNwetViHyMO8NBWqulr
         KcNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771837757; x=1772442557; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fm9rodHOqPK/SMnDjhtEFEuxbgdj1oa8x9/7KIcoy+k=;
        b=jrqgm3v3mCXJrUREeN+TF6EbICi4iePCzzh+m8tPn3hhBDCx8hW/BS33tNHQHM/VZ2
         MXbiX4Qw3tXor3Ms2+sg4iA/9vxVfElbz9YIL51LfCMuD7sHTPMajmFaYiEnNLpT+EyM
         imCQ96BYcw5chvV5ABx06/Yi+ZORpn5YFVG0pkEX9vQ14/lGfp9wccO4yIlTGrkahEO9
         npjQI4+XYuuS112//IV8RkXNsnEHMKVXyyVqW+p8YtJ4F5mhJx/1JbJTOcBIrJJsG8wa
         RV1br2Go8efF2f4UFaS7GXbDDRctyzgSvNoofYZ4BtR3vl6fIqe8w89GzwfJWUmMQQjz
         nzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837757; x=1772442557;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fm9rodHOqPK/SMnDjhtEFEuxbgdj1oa8x9/7KIcoy+k=;
        b=upEv8Yx+n9vQNBr14lr2peqqawj/9T2jpJ4BK4FVjfXKyE0IoI76kaXRMcKvR5GIG8
         wOm4uPTABl1IIh+1WxRJyGn9CiMIRuK1muogx9HspzUCBHUrwo25hPO39/OXOSuz/WL+
         7ajEtPlqkdZPjVbPdtUwAeEYREswcAPEhYotD4L6F/vKCl5BBehoI0/pVJHePKkB5TLW
         D3dmieYAeibTb3aXkmpSBVxyh11ANy0YO6ThpqlRu93OxWZRUh0MEXA+3l0lyrR9yllG
         jWGRZv13xyfPfhEIiYk+HFSreZKt4oUNrw5GDeRIJvCMuxP4LZ98fp4mZMiW96BFDK0g
         v4BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC/9yEmzNwuBkUVURfHMR9mFqctA5Eqg6/7YkOTDa9zmuysEph/t2zIu7WmCET7TziFDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFxMDM/KoU2V8sxaePp72HdULJ9eRLcYBh8VNN+srQyMp65F0f
	8caRt+LeUHe4tiFgVgAIPLeO+1X07CwKF4OsM4jMb50Gjt1xmAhTS2wzHe1xnvHiPJMPIA+saug
	zGI1ADXTZbNwMaEbsIpZX3Nraxxs2JdY=
X-Gm-Gg: AZuq6aLAuUP8RGFeVJ7IoblrNr/cIhpdBrMYWSYnd5nhjG9dDcqAjdcyVJ+fv4pmzG8
	geKkB0pR3mfETM17AcHet3d8Yv//Bk8apzA1RhiR3ELo9ILFu2dNbZ0AYEcyQ1f6O0Jc0vSEiVF
	EqQTx8I6N71gXnXBhuKAjSY91ifZIB1qObeKMEfrPeAkaLXrSjg6y9Oar/Znveu2B6cemzx1rm4
	71Gcpuzj8G2UBvOjpYd5BihIJvrVbycMsBRSmPJ5WoNMJDUqhurl4AGpAW6k49eZcSNIC7fQBtT
	TgwbquFiS9MSw3lq1i40iY1FlV7b5j+cVm96ZdfG
X-Received: by 2002:a05:6102:3585:b0:5f5:4d9b:bd67 with SMTP id
 ada2fe7eead31-5feb2e5af0dmr2651308137.6.1771837757213; Mon, 23 Feb 2026
 01:09:17 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 04:09:15 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 04:09:15 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-10-17170bd99de1@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im> <20260220-pks-refs-for-each-unification-v1-10-17170bd99de1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Feb 2026 04:09:15 -0500
X-Gm-Features: AaiRm50-EXeomqH7yPUMd7xTs42igOyEFalyLwXerKZ93rZ_87XxhP5cos4jb7E
Message-ID: <CAOLa=ZQa5riqB37bVL0_2KZbXS3V2L=iHqpAwMYom1bjKiNsRg@mail.gmail.com>
Subject: Re: [PATCH 10/17] refs: improve verification for-each-ref options
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001e6a97064b7a20e4"

--0000000000001e6a97064b7a20e4
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Improve verification of the passed-in for-each-ref options:
>
>   - Require that the `refs` store must be given. It's arguably very
>     surprising that we simply return successfully in case the ref store
>     is a `NULL` pointer.
>
>   - When expected to trim ref prefixes we will `BUG()` in case the
>     refname would become empty or in case we're expected to trim a
>     longer prefix than the refname is long. As such, this case is only
>     guaranteed to _not_ `BUG()` in case the caller also specified a
>     prefix. And furthermore, that prefix must end in a trailing slash,
>     as otherwise it may produce an exact match that could lead us to
>     trim to the empty string.
>
> An audit shows that there are no callsites that rely on either of these
> behaviours, so this should not result in a functional change.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index 20d34faeb5..3b676432b4 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1855,7 +1855,18 @@ int refs_for_each_ref_ext(struct ref_store *refs,
>  	int ret;
>
>  	if (!refs)
> -		return 0;
> +		BUG("no refs passed");
> +

Nit: s/refs/ref store/, mostly from a readability point, but since this
is a BUG(), I think its okay to leave as is.

> +	if (opts->trim_prefix) {
> +		size_t prefix_len;
> +
> +		if (!opts->prefix)
> +			BUG("trimming only allowed with a prefix");
> +
> +		prefix_len = strlen(opts->prefix);
> +		if (prefix_len == opts->trim_prefix && opts->prefix[prefix_len - 1] != '/')
> +			BUG("ref pattern must end in a trailing slash when trimming");
> +	}
>
>  	if (opts->pattern) {
>  		if (!opts->prefix && !starts_with(opts->pattern, "refs/"))
>
> --
> 2.53.0.414.gf7e9f6c205.dirty

--0000000000001e6a97064b7a20e4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f435503bf6f69f0d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tY0dUa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN1Z6Qy85cURBUDZnRVZKZjJHVkFIMnZDSU1NOFgyTQpoejV6azJWSHc3
azc4U0IzR3lPK3V1WE14bHBtVWFpWHZYWTJ5Wksvbkl4N2ZKdGJaU0R0L0JvWXFLbTY5SXl5CjBu
c2UrbjVKM1BCaEdKQlp1VXhwYk9qeWo0Z0ltNmFZcGk3VE5jcXVzNnZOVXhMMG0ycVNETVpNNmRB
QitoMS8KZHR1MDltMHJtS0w1TVZGOEtJdS8xZFFiRVFadGVQTWZOdDV3S2ZEV0VnSnMwZS8wSjYx
MDZaNGpqR3d4emlYSwpuaUdVVWNEZXgweDhZYVo5V3RSa2pxWXZLVDRydndiRXJqVkRSQzZqRGdt
T0VzbjNxeGxpTkJpUDJDVURmVmtXCmV1alNnNkVZcE5nMXNIdXZZUnNDdjY0UlpNa0xvczQwdTUv
b3ZGS3pvNXdWWnhZTkI3KzhHdk53eXhHSUVEZ1EKbFhLc3JjWWg1QlJnYjlZcm1yeHRybHpSQWtR
UXlrZnVZL25xNmJWRzNLOXNma2xWU3o5THlZbTVHUVBBa0dXOQpBdExnejFpY3FZQ0ZRSzlnYytu
NTZGRUxFOEJabGFHVnJDN0ZZaFJtRjVHUmNJZ3ZPSDY0dHVYelVaUzI4M1A0CjN4ODFsRTF0K01J
S3B1eWhDRUNMV3JVczVSSHZNSnh2THlFT053WT0KPWowMmQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001e6a97064b7a20e4--
