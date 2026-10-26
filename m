Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793030913;
	b=I+o8M1lvHleeQ+5xWRIufEDHgRL+Sy9SlJTdzNNwWAHSPex1xLxGfQo5RQy8QxMDFqau
	 hYNMCVUx58kBoV8wyUPBDNHGJqE/sBaHB4P5RClcukvo2XvTzd/wL19fryLIkYQIh0a8J
	 Pn4x9DOyB0FiqDY+MfcWFwdx1FNduFX9id8lLukZoJog4fnICIURa58T5lodkJxXJ3/Q8
	 NhBtU0ywk2hh8nI3tf1ihkCv+nomy5A9/zHnJV8nEFW3IFbTfAh9dFnZ3EOfi1bJrm344
	 2x/hyYZNLwUj5G/jUouQctFj4uLTn3k6fDK1gnDEdYlojPn3y7js6uxmPdvT1xEO1xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030913;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ksAyecF26I7N/WzVnYtCvRfmQFbMdTwGZh2dK8EuhFM=;
	b=TAi7qUqJLIbt93MV1fOPEtdjUT2kM6oDBYs/djnw8HTxeDVX6ti1Gy/RFOfrtEPiDdft
	 5OKo4I192RghtzTOQtF8IkwphDNT1D7/OOtN9QImKV4vfoqG2ocu3pwkEWxdENWrSrVM/
	 Bmv5ldDpuuKZFOcEUJehBvqeVsCiDJ37B5TXd55ZEZdUfCHpmqi9wwWNJXaluHWdDCqmx
	 0oaZLfYOng5R71LBUpGNsHyJEobw/D+MeFwRmSQZ9+3Fa2tcTvd2rn9XBDmCNi6gbQJsz
	 yGRy9pTsDtltE+J0B3TFrJQ0gh1ZhGqGAyuVM+1PvptSE0VzfnsRIB50vlk2UOSpZNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lyQmb8Ps;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4DC606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 16:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C4DC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lyQmb8Ps
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7cb6dc850c7so959621137.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 09:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793030912; cv=none;
        d=google.com; s=arc-20260327;
        b=j892Dze8ClrmJy667Xf+TkFw85BbK1frOWwdD5BXZgOES3ww0kt1+7CXRx3LEg73Rj
         b7wI94KWk180IVRmC7spSF2EUwTWlqpwLn9BaGAxPEeIoZ5kwcXAxJgje6ijLpbusCvs
         NBdx5VbNNnojwv80ntP+0VxX/Ubq3jNZDQUTK7EEvu1fNac5xAz/hNuH0yyS7dJmNQSg
         OKDE1YJ9NWfUzNOkoOTmqDhCD3fc3CIreljlzwVy2cV6vit6t6VU1x3zElgPAhOrDs2U
         ojThRy/ryOru3NuIS/jMyl3LXN3m/suOLLK7VVvgV1f3A+0WN1QLwRp41IFZ9ojkpEAK
         HH3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ksAyecF26I7N/WzVnYtCvRfmQFbMdTwGZh2dK8EuhFM=;
        fh=gydUy51XY/TN5hvyLrltgqIzSdqLsMidxIKsMvmAkKM=;
        b=fI5CnoHXYEfS2/Jfb4CXAFQLAJ4XiAuhD8ytRBlZUlbz11ITULQgDPLPR0Tb6cRM67
         vkii09kCHma4FlQZrjw9evWOyvsEtf8MGs/sakMRtGm3dh4pz5TmdJJEWQkTmQ7s+xRE
         N3IaG8hDuz1QR4q5AOLlY1dKqQ0z5UTe2YxXmIPFshM03114Rll1fUow3X1c8nRs+kc5
         UKpDIVHixU/oFbYbCEfXiWJuhdB4myXH/DxkK/2BwiQxEY48IwEobGs8gqMUa1yqlcIu
         754AeyQaJEZo/j9Je1NKWGGUFFW0Vbk5A+pVur9SnA4OEznraEmBxZ8GT08AtaYKVEx1
         OwgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793030912; x=1793635712; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ksAyecF26I7N/WzVnYtCvRfmQFbMdTwGZh2dK8EuhFM=;
        b=lyQmb8Psi2jnZEkYzyAPTZixLXMsBnoq9LWJVa5QRi+2ckVnqta9Gv8UQJ6ZN/Bkb8
         F5lbhmVpT+eUQi86j4I4/qvrKQDLmwaizB4m5ieN2xBUe7Xt4iD8+Wsf86jXwuR+m+5K
         zCnOhuqrSVdM8w8hbr1vDdkTI0sSwvTfYzm8Wy4Js1zsvMefIyiL5jCocAkbA8GEMJr4
         s+DRwJriB9RIncOwGl3dGbPwSCP2oO4+85IcGBlE7wFJcbijNLn+Aq44FBCTX0mr05fR
         GYoSwdnUIBHLfJhKM1kxegpjuUgIWYL2g/myyvVfhTBVgZAljuz4Gx4tNmE59RpqN/cV
         ympg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793030912; x=1793635712;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ksAyecF26I7N/WzVnYtCvRfmQFbMdTwGZh2dK8EuhFM=;
        b=g/8udeGaDS8/jbaTijEjGv9HxV0YUJgMChsk3XoyoVSz6goCJ+L3ddhTvpyAVv+Kuo
         0i2diiCh83vJuCVbkgMFZoez3dFHVHnfvflCx7S/3tWoecG0qxaAx6jYCd8KgIi3vfo9
         nCc3gfXgk456ICykd7jJyIFz8ANLGlt4nOGdmjtElGqnF/rL7Zx0FQNcMFei9Es+dbsI
         njm/WUYSdum4Fi/obxJG627NI10d+9P6NxCbulauTXpXSnHehWZej4jWCTWtD7HFTIqk
         wPlhkQfytDuf1hvcvVQPhioQ1841I4T6Sy6JGJUxCq/d1U51lZ0THFQWTZFcVz1bD7k/
         LeZw==
X-Forwarded-Encrypted: i=1; AKwUvBw+3QbYvGc0fAc5J84VTakA7L0rIoJO/DsA24o748L7+V0VUDzN6pQVrBY1WxlYbyH3nOg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSbDCTmfWrDQcGOaLKvKo4smijgV9zIuCaQfRk9BjTAgmzSbCh
	D3Tq6ZNU5SEPw5oQQ2BjrpXGl76EoZvHVyvUWIQdVZiE4UwRLmp/EWGjG08y4uxBR8LBRNoLfjT
	Y4zI9G3aW8JOh8HFp8CVd8Mrw6G99QAlA2w==
X-Gm-Gg: AYBFou3VtConZH98Yt3IcD+d5lCRMVAoQD04LCBTyCipY0DgvZaqmoYVm/msdHH6FFB
	s1VNs1OLkK/CO8zX+T7R/zW/n/LCoFrutigOwI9jODVd3DilaNGmkCgsY8zMD+u2kBzNPJHGGAT
	KEyLivOZH49CgnkU47fKTmW3EjCA2QvaClJPoYS0yDEN2Qtz9f0UBPzGxbnjS45RZatOSXhlaeK
	zHYoX5RtIqq9L/wx3Mfq4WqwmionxC39WYlXZ32aeExwGLpd6QFUSJTdGTiwx2Qpvz7A10SehDz
	kAOu3zCQuYBK4qWRYBgMb1hmy+IlmMhigwbAbpBWiMojifUS9Z3+lGQLCVFGTHQS7KkQTVc3AP9
	Bxhwb4DM8Ap8+j7UXBHrLJfrz83j960SR6FC77t+n6W1Xw6F6ehwBzg7SZTvucdLarRy9mAQl3d
	CdU6hu95WY+hBDMo6npo/sn94tpe4=
X-Received: by 2002:a05:6102:2ad0:b0:7c3:9a14:cfdb with SMTP id
 ada2fe7eead31-7ce5cd3a0e8mr2137055137.17.1793030912006; Mon, 26 Oct 2026
 09:08:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:08:30 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:08:30 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261021182528.3055494-4-jltobler@gmail.com>
References: <20261020132900.1208343-1-jltobler@gmail.com> <20261021182528.3055494-1-jltobler@gmail.com>
 <20261021182528.3055494-4-jltobler@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 26 Oct 2026 09:08:30 -0700
X-Gm-Features: AclHuK8H79nAEkjPeL5Piv386gMUIPMXpDtFNih5261vGc54btfL6onJhTd26X0
Message-ID: <CAOLa=ZSdT2W19-Vg682iv6zhq6sEFM0+rHS-NqL=XQu--JOknw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] object-file: explicitly write ".keep" lockfile
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
Content-Type: multipart/mixed; boundary="00000000000094fc80065ec08a9b"

--00000000000094fc80065ec08a9b
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> The `odb_transaction_write_pack()` interface for the "files" backend
> relies on git-index-pack(1) to write the specified packfile into an ODB
> transaction as a packfile. To prevent a concurrent housekeeping
> operation from deleting the newly written packfile prior to the
> references being updated, a ".keep" lockfile is also generated by
> git-index-pack(1) via the `--keep` option. Consequently, the ".keep"
> lockfile is written into the ODB transaction alongside the packfile and
> later migrated together to the primary ODB during transaction commit.
>
> In a subsequent commit, writing the lockfile is deferred until
> transaction commit and thus cannot rely on git-index-pack(1) to write
> it. In preparation for this, update `odb_transaction_files_write_pack()`
> to explicitly generate the same ".keep" lockfile itself.
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  object-file.c | 107 +++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 85 insertions(+), 22 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 210984f825..74a31760bc 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1256,6 +1256,47 @@ int read_loose_object(struct repository *repo,
>  	return ret;
>  }
>
> +static int write_pack_lockfile(struct odb_source *source, const char *pack_name,
> +			       const char *keep_msg)
> +{
> +	struct strbuf lock_path = STRBUF_INIT;
> +	struct strbuf contents = STRBUF_INIT;
> +	int ret;
> +	int fd;
> +
> +	strbuf_addf(&lock_path, "%s/pack/pack-%s.keep",
> +		    source->path, pack_name);
> +	strbuf_addf(&contents, "%s\n", keep_msg);
> +
> +	fd = safe_create_file_with_leading_directories(source->odb->repo,
> +						       lock_path.buf);
> +	if (fd < 0) {
> +		ret = error_errno(_("unable to create '%s'"), lock_path.buf);
> +		goto out;
> +	}
> +
> +	if (write_in_full(fd, contents.buf, contents.len) < 0) {
> +		ret = error_errno(_("unable to write '%s'"), lock_path.buf);
> +		close(fd);
> +		unlink(lock_path.buf);

Should we use `unlink_or_warn()` here?

[snip]

The rest of the patch looks good.

--00000000000094fc80065ec08a9b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 91976fd605b3be7b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yZmV2c1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md3JLREFDWUZDV3MxZnFXdkFTV3doSi9PU1Frc3cxTwpickdiSWQ5eE9P
cThVWGhUS1R0RVJrMjlUcFAwcXFhbjBWSkxhWmpidEU4WkY4Nit1VENtTU5aTWt2dDV4d2dhCjNQ
YWd3NkFBSWk4QlJQOVNiU0VyUXpLdFNINjFGY2k0YXRkQnBVUUc5eVl5M0FTSHV0NjM3a0JPVTlp
azR5YnoKR2dhc3F4ZGpiZllxcWxGSFh4YW53S09qMUUxNkllU1dxbTZPOWJzZUpJRE9ralNFa20x
YWNSV0huZ1ozYmZCRwo0RVVyMDYxVGZqM2xrZ2FJNVVXamxYVW5ac1BkbUFleGg4UXpwTy9CSkZG
RUQ5YVdHQXZoQXE2aHEyK1pxaUpjClNlSndTdDBkOGpmcy94ZlpUbGw2VDdqeWo0dUQwaDVuc3RM
aW13QW0wMHBhVWlxVW10Vm1Ea1IycjV0bHJnVFcKTEU5cFVJYXdyYzN0aFlOU1gzMkRBSkVveStQ
UTIyTTcrNkdjSlE1Zk5xSU90aVluZlk2bTcxVFhnNURGYmNZZwozZGZxTUllUTdFMmRSVDhUcFJl
RThvN3RqQXhoZUJpYTRabjdXbWVjdnhBWTlQZzl1U3kwNGY3dksxcm1kQmoxCjlMUHJTMXE1dG1F
dy96amZYR00rUjFOeUpiaFZMblBQMWgxVk5HRT0KPXpiY1MKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000094fc80065ec08a9b--
