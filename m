Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2CC33A029
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787824859; cv=pass; b=j/1vizp8QeX4mNNBOkGM0rXgP+o/A4ayrHSbXEiB3Uycq4D0qD1GCjCYlsDNcCpFTmBoJOjUgkskqMuDl9F2twc+RU6wRTc/DlfTx/PacOn/c1L45Vb9d0qd2pbehF/09ny52MQnLuhU9639aX1UCqxFq19y6q17mQYuHbkEi8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787824859; c=relaxed/simple;
	bh=82FWXKHHW/ZCCScXEFLVAyP0tYldsbCcBNpxlq65DjQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=LlbLPfIugYQL5LDpC7Kn258GgMnCKDXYQeqomtfgUfoW9uXczyol9v4qOtsuk5svFeTWmEa4aa4hsvH6nXDgk26pyBMYyhPTwx4/H5h7YzFFV6yJ1eBb/6O7RH1mSCCa+o6KLH4+LFHWehnSWzMJfP6hV3bYXCY+6eh7hto5IN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvgJqap6; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvgJqap6"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-785073ad5ccso81804137.1
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 03:00:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787824838; cv=none;
        d=google.com; s=arc-20260327;
        b=J6ITdPr1OI16zqrddFQ8xbuGp1DEZ2Q9lBcAjHcO4RdcdIQ13a6rDtxXETtFzFft8W
         4mZ9tEqxiLXuzav0QwmJgrR8WYh5HQWuuumDOwAFXc1giOh58sLENOMw7ahvW19W7/50
         p7tazZ1l0TJlIarzKPSe46QLbbFypx4ZmXiFhKiuy1uvPDvlqjlI1nBCksoKQes+OE6U
         xHxvccMdWoe00oZXFYnwGrtSdkOHhgLq3s49uv6eQSkYJuDCBFvFLuF6V/j+XUvWAdTn
         O7QwJ+qMWCmzJHkskFEk+KpYkm+SSqMXo42U1i5xMhHvYt7E7PVa4qS0qLFQIk2sCbPB
         lQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=+rP5Aib2eWz3SnaKEN5yBea2eGfPtCAUavw/1IiRRwM=;
        fh=42E0RWObJh7uaC+z1gmQ7h//dQsMvk1x1fFadHGZo8E=;
        b=cRtltDNgoZDXEEo1kuNy0V3QYhTwnanlw/6R1u3jOMgu0v/doM/xjS3POtCG8q04gC
         cJL7Ysq/AOsLOlZeuWbZOWjLbw57A3+cnjiY+CQL7TcGj0pNvdkcMzKERM+oFA+WvguG
         cWrSBLhZ5fUUFsR+MXj/kYu9Ed/wPBKoMqsxIhzbiEOLijT0yWsjwpGvgRBkOq2fVIzH
         vquLdEjduRpycMf7C02d3kcXkdo/g1ahb+mOZYvmnpzH7XHvqPM4+ICarOhdBGP409w9
         8pHb2FbjinsaKQXIGfEjWKXJNI4Bao/+Cu+Pjh/ujfpZTeTQ71h85ZIdLph4d/muTySr
         g+8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787824838; x=1788429638; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+rP5Aib2eWz3SnaKEN5yBea2eGfPtCAUavw/1IiRRwM=;
        b=BvgJqap6AfnbdXCSkpLxBsXySbRZGGMGxXKlLntcZSqYS/eOlknEH/HhS7rNlzOEPN
         U+m90v94Wnjr8hZEYB4pnY24z3sKSQrAv4T6c9cn4ZCCRu0SVraNSs+N+lDy0NmBIdcb
         r+QMoczlIJ48iy0zbITNsK6z1uUx3Zx+gG+6m4YCyfqnVcVCPWfxjnsZn8q3DFx5tDB1
         ISl9kz4EfWyZ3ZGyv4inLCc5dhfwVv6Bk0LHImNIPHZeeC/ZdpUhKHLWJh82cWLnN0DS
         y6t6RkrrpOc5ntY5NpsN5kve4Q7A6OoTeLU+8JGJjHlGEQsJLNSV6XKndb1EQOQy+T2W
         IR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787824838; x=1788429638;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+rP5Aib2eWz3SnaKEN5yBea2eGfPtCAUavw/1IiRRwM=;
        b=a6xrhOa/RfgbUyBQLTdci3z7iVy1PgzMZYjxBeKmNjUmZ2Qf0roBdnvnzdDTQnMiBt
         bQQS5e9pLeGKXGA9MlhMaAnwts3AkcKGk2VdoKlICfxLuJk6vUrva9RTPIg4VtmyeDiQ
         JEbQdrbitj4MdX1GaXdQU/zDO61vWGM+0b4Gd4Ym0DryZSTq/QNm2kkt2IZhBySXDBjN
         TlNr8RemVuuD0f7hzz5hiPd591sCCMHYEsm/caGAs/ekdWO0dxrRcaZYP78mGuQDWLNc
         G7Fb9Y27VDHxDtIWRQ+lc6Rh7vFtYQg5cYDGeHQb3dqPP+6LbZ23qZSVK7sGRKwA2BLR
         VBxg==
X-Forwarded-Encrypted: i=1; AHgh+RoH4laIiOZvfn+AiL3Js3e1GB8yR0KADsXFyZXTnPj4vOZCxUPCs/ZwerGPOh9bBku/B5U=@vger.kernel.org
X-Gm-Message-State: AFuF++lOHig3WgpGZcCOI3HtUWWifSq9qnt69Gs/FFiChfn72o0WnRjF
	ZKcteNiu198HGwJmgWyNXg5QmyzuCCtmdlCcWbACq5BEn9sfeMBDx1jNDL8DwFvPT3rdDMgOcqX
	4ThHKgFkBw9LyOUI4h8w4dcNt5FdzwJdLu4G/
X-Gm-Gg: AR+sD11Hb+N47BOY6AUatbX4OCwiKKgMIBCNHT8E4tprVtv31RG7bLXjKjni0UNySWC
	MGyXY8I5aqiNeFKpZGqJaq/K/87ARLGr7DTpvu6aqvcLqhqQatfaiOVAAsmI7i7agqzsYNSymQL
	YTFgS8Uy89qszv6dnrzl/y3wN6C006VTX6oXb4KRL8qQi9ucIR9ldN10Kzse6EJlzrnwiZoeQkh
	+JOHr/qlOGnfIXSyjnS86p0u0LnyKAt+DKY4czbOqGjGQNEA0Z7xgZFSyc45/DU8odTYX3OEKq0
	b2RlkYgB0hKlk71q/JWJ16JJCR7XAMY+FkObvd5ghQ5pY4uSJh86DI2bY2zrQIKUZx/APEnu/FW
	3hUM/3GF9uLYXRSSidbPN79D5oVtx5qtCK80Vf5M+wmta
X-Received: by 2002:a05:6102:3ecf:b0:77b:b14e:b6c5 with SMTP id
 ada2fe7eead31-782c19fbed6mr5404679137.9.1787824837938; Thu, 27 Aug 2026
 03:00:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 06:00:37 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 06:00:37 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260825-pks-odb-source-fsck-v1-1-b756de0bf24f@pks.im>
References: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im> <20260825-pks-odb-source-fsck-v1-1-b756de0bf24f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 06:00:37 -0400
X-Gm-Features: AcwNN1U829wBLlUUKuQkbTugn8nAr-bGRw78gWQe27d_pyFBkJ80OkqlYAzGBK8
Message-ID: <CAOLa=ZQyGk65qhF2uRV6Q48c_F948XuTWOdHOTwenfGestLxWw@mail.gmail.com>
Subject: Re: [PATCH 01/10] builtin/fsck: use `fsck_obj_buffer()` when checking
 loose objects
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000062f25e065a0468ac"

--00000000000062f25e065a0468ac
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When checking loose objects we manually parse the object buffer we have
> read from the on-disk file, mark the object and then call `fsck_obj()`.
> Almost the exact same steps are also performed by `fsck_obj_buffer()`.
>

I was wondering what the difference was, there seems to be none, nit:
perhaps we can drop 'Almost'.

> Stop open-coding this logic and call `fsck_obj_buffer()` instead.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/fsck.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 892c5661d9..3c4127f4d8 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -722,7 +722,6 @@ static int fsck_loose(const struct object_id *oid, const char *path,
>  		      void *cb_data)
>  {
>  	struct for_each_loose_cb *data = cb_data;
> -	struct object *obj;
>  	enum object_type type = OBJ_NONE;
>  	size_t size;
>  	void *contents = NULL;
> @@ -751,21 +750,7 @@ static int fsck_loose(const struct object_id *oid, const char *path,
>  	if (!contents && type != OBJ_BLOB)
>  		BUG("read_loose_object streamed a non-blob");
>
> -	obj = parse_object_buffer(data->repo, oid, type, size,
> -				  contents, &eaten);
> -
> -	if (!obj) {
> -		errors_found |= ERROR_OBJECT;
> -		error(_("%s: object could not be parsed: %s"),
> -		      oid_to_hex(oid), path);
> -		if (!eaten)
> -			free(contents);

This is now moved to the bottom below fsck_obj_buffer() call. So that's
okay.

> -		return 0; /* keep checking other objects */
> -	}
> -
> -	obj->flags &= ~(REACHABLE | SEEN);
> -	obj->flags |= HAS_OBJ;
> -	if (fsck_obj(data->repo, obj, contents, size))
> +	if (fsck_obj_buffer(oid, type, size, contents, &eaten, data->repo))
>  		errors_found |= ERROR_OBJECT;
>

I see `fsck_obj_buffer()` also sets adds the `ERROR_OBJECT` flag, but
that's okay.

>  	if (!eaten)
>
> --
> 2.55.0.822.g20453c30eb.dirty

--00000000000062f25e065a0468ac
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1134116c0ddf4dd1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xUUNzSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMW95Qy80d0txS3l4azNyRURCT1JwZ2ZMY1VCZ01LUgpWTDJieVVpVVR2
ZVpMT3RFZzNCRGVlM0lnL3drbXdkZndxdnZsaEpXb0MrV1JVLzd0Q1o2SmVWMzI2NTZ0TXZUCkxs
QzBaTkxIQWkxU1JEaE1CSElPYThzMk5vYWJGSHlWckFIcG83LzhZa2V3TFBvblV2RmFicmJOWHY5
TVFId04KT3NCUU5WZ1MxN2JjalR2aEJCVmV6R0NzNXFNL0Q0QTFQS2hnRFUwa2Y4SmF0YlRWSzJK
WXhYY2twUkpFMC9YRApoRnp3MHdpVHZUaXY0djJ1RC9tS3Qwai8vMXZRS1N6RHNQWHhaVUdrRmVN
NUx1cUhkc05ER0p4VWxKL3NTMlNGCi8rUWd3KzkzVGg4aitFTDdiQ1gyaEVtRlh3elpSdDMxUVRZ
OG5nNkpzK2FxR1c2UkNSaFZTS2ZIbEQ5WWRlOW4KRUVMZlZKdU1lOExCV0Z5Uy9aWDRPRm5PWjR6
S0ZXSSs4QS9jSG1zZ3FlMXdqTnRjN1hqSFU0a2Y3U3Bnc0I0SApEZGZNYlQyVzZyeUZONmV2RmRm
N0RFZ1BNRHIxTko3VUFzNFk2VFpIeDJSZFYvWVdlQmdMVk4rVGNLQnM4Y1EwCjZkYXptWko0VWpp
TFN1NkJmbHRmWkNqeTNha1FINFJ3NWtSdTJBRT0KPXhuUkkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000062f25e065a0468ac--
