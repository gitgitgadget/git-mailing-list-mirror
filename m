Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1033B9937
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786623962; cv=pass; b=s8qwpaqYLYeyT/iDk4m9rlw3JxDgWtvOyO8UM03W0fwKf9Bb9TmH4brjj4476gRUddsxCYAEgEA5JBROeL9V/qJu2B7YsPtqXn18sI/n+yQdP99cGJoukC6s6wDwNohuuUwlliwOhbQPMfFbr2aYn4yDNfykkbLyACkevcnM0OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786623962; c=relaxed/simple;
	bh=QuyluVmR2wNo2oA8kt7vCtJkIdhYipw2LDXshhsQTnQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFUwDqiYPv0kmiT7PftnWNOo7k/c8KvmoCfUfF49jHE64/5JhLLkDZTgv9TpZYp/qRtkeFP07oK5ZXgrmyjKel89AEPPFbaaDOQoKOd+AhoWXQjkAl3kTrU6UFOxhDGtmoD0rg/huWEBJWlWoybVZuqbqQWB5bvsT/BVdPg0Krs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrH2IwKq; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrH2IwKq"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-745497ac8fcso196159137.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 05:26:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786623960; cv=none;
        d=google.com; s=arc-20260327;
        b=dDc2456Sq5nnAQiilfYPC0W/2hLqcfxroOrNdhEi7pJ81awdgIUHwHHiXynPcCrXHL
         iPvVvMmYfW77uxTygEKPB0bCsQ8fveRVRSrpvMyQS9mCIXlVA/t9H3o5T6qgeDD4bFhP
         eACmL6e6ST3kB8fIRVT/70u1LEyNSl7dZxbq4j/OH7K8vv3ZtLVKuPgkp57zMpbwIH67
         xPkkscSOR6l6eIQRjIzYh8x8VZRTeL6UDbr/102HQfouKO58Ipukq7qD75CLPetudKzK
         wuvX4f/pzf0U5SexUB9cHjN7hfvsCLMUplkUNSo/h8k6DFrpubxRPMUtjd/jhmr4sFfY
         u9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=7PzHSNVAhW6aWOrRfFl1dDCaHDwwldHkjR2J6pACs84=;
        fh=e5Jk398Z9Iu8/+LvgXGi+/e9Yac0qPx3Y7QltNomeFU=;
        b=Vx2RAnuDoI72xrQx8ZHDRfwJbMnID0H2XJ3PzsKyj9DkZyTpug33rDV5eKWRBuzMe8
         1ssB1RpNAhQPDOl6V47FWMK6YlURKrYk6cINQcYejlr0mNdDgCm1HEwlg8wThTeFNHHK
         VnUgaqv+wTLfCW0KXgqtBKwRaVrlTsYSptkoAXZrTWU1KvFM15rP5bsXTO+VYOm9H3xv
         42A25wdQOQmK3KrSbqDSOxJ4qMMmI6UH/qdQifuAiuyaXw9Ug6Uz9wMis+aL30yIktQI
         Inf1WwFhj9fUbUFov6BXAumvP5cYiNMUiRgBaLuXbwwdAk9mTrMjQuWw8tekFn0/g6b1
         IDng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786623960; x=1787228760; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7PzHSNVAhW6aWOrRfFl1dDCaHDwwldHkjR2J6pACs84=;
        b=NrH2IwKqIUooN9TxqYc6JYfGYL9ukdy9+swRbSCEAe2bQyCgk2SYeKXXumSIja4Kfp
         dyq9N2qWVx7gL29L2HvC7EELTLBcs6hXg2j8Hs2zQ7OWxvbXtvWAHDRmy+s58YvHBkGo
         UPL14/HCnMfhYhogA9V1FIfXH0ClYm20WSGcg1sg5VKVgH2uQ5hHLBf+mnuKrY2iPNSL
         7ekYJEo4wT5SSuhNL9agNaUAyr5ScWjIY7o8yZMONthtvtg5LtCBn0V90u/tfq3KiA5W
         cpSay7I68XTpBYhvz+ZFcdBVaAY5DIWDGG/PaA7dSzEVIxkosPDSz4WKd1zrWDtC54hi
         89uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786623960; x=1787228760;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7PzHSNVAhW6aWOrRfFl1dDCaHDwwldHkjR2J6pACs84=;
        b=RX48ZAVDh4zyATYp8RnuWNalefJRBrLeZimmaXFjp4UkTVGVPAFpDC/vqOJQ61ngGF
         POFIfvW8xINmy9i2KnWI7JTp62jf+MmefQ1Q8SudwmI93nzjVobcIx/CuTEfI5OjEEiC
         6atlcE2NGQfpwTRtJIeMOIKEH8NDwpk+216/o7xUJQjYuNKMgOUWbxa0evXbeFZXeMnE
         qLdunmB4t9o3jL1DoFrc4IK2L3hXhRpobbImalHjTSvgocEgxpPFWdxyztxECERxpmdl
         2BVTLBmOW1k1n3JTKVsT5T5RPaoRn9g+n40tg3ftlIbB2FApGyA+2OEEq2LYlnJGST1q
         QgjA==
X-Forwarded-Encrypted: i=1; AHgh+RrtAtNb1Vak0zXQDJODrpvjtPCSyZjcwXdOosudPDgpn7QZlnfHqq3j7wxcg7Hmk6Q4SZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLiFKsimdrzGuB+6breR51xiU98iy4/840r8tZhGRzpUslrcyF
	u8lQGQ8hYaOkV0ZRK1N025lRgQW9nWm0NONTNL3nxGRCzzh/Ijyb+OUGke+KCFZU2NAWgSOX1PH
	Ph73Ilxmm2mskGMgENtxovDgwykALBS7UsWmm
X-Gm-Gg: AR+sD11zHX/uoAkcrgurd+kJLtBxvufnyIBiHXUSCUR7qHssN6WmiPOhQE09ZfJKjfW
	FLCJg6d/6lr5N0aRXQIQt7KFgMPC5wI5a219UGePsp1VD4hfadpxzXB1dtloUfFWY644AxF4Zpj
	hqLeUXO0e14UZvSSpunNLqzZlImdidpzRSI1DnonIcmKkrMvtEXfcLEgBMZwaj1NRIE5prZFU89
	LEfKR/RW/ZMk9vO/lUa198v0heo/Ia08+QNbSX2XvgDsTsTu4C0ATUtG+y/yIkC04PdJVPaxrNn
	aVPqeeX7qknI/hGCuK8X0VHozhyVnN3qkBPYuQBjaSPfuzxR7RM3oJe1M2aTZtzUpaDM2t77UpM
	zoYEuqSJ/B1pem3DfvzKQqDPVMcPQTq5QTLw=
X-Received: by 2002:a05:6102:448d:b0:73e:5068:824d with SMTP id
 ada2fe7eead31-76db7f96101mr1162465137.14.1786623959876; Thu, 13 Aug 2026
 05:25:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 07:25:58 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 07:25:58 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260812-pks-odb-eagerly-prepare-alternates-v2-3-522b9a5bc1ea@pks.im>
References: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
 <20260812-pks-odb-eagerly-prepare-alternates-v2-3-522b9a5bc1ea@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Aug 2026 07:25:58 -0500
X-Gm-Features: AUfX_mwPYzPJWXFPqivt3fQGQVOt4YB3tChbWzB_srJc8v1YjOKGLwJ2cs3qhwA
Message-ID: <CAOLa=ZR1CHHXYjfuJBC0wGqzCYkKUMr2oBbmeUnzz_vCNkegBw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] odb: drop `loaded_alternates` field
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000079e5360658ecced9"

--00000000000079e5360658ecced9
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The `struct object_database::loaded_alternates` field tells us whether
> or not alternates have been loaded already. This field was useful before
> the preceding commit as we were indeed lazy-loading alternates. But now
> that we started to eagerly load them we can assume them to be loaded
> after `odb_new()`, and hence the field does not serve any purpose
> anymore.
>
> Remove it.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c | 9 +--------
>  odb.h | 2 --
>  2 files changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/odb.c b/odb.c
> index 2ae8228dd2..2eb37a2f44 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -230,8 +230,7 @@ void odb_add_to_alternates_file(struct object_database *odb,
>  	int ret = odb_source_write_alternate(odb->sources, dir);
>  	if (ret < 0)
>  		die(NULL);
> -	if (odb->loaded_alternates)
> -		odb_add_alternate_recursively(odb, dir, 0);
> +	odb_add_alternate_recursively(odb, dir, 0);
>  }
>
>  struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
> @@ -495,16 +494,11 @@ static void odb_prepare_alternates(struct object_database *odb)
>  {
>  	struct strvec sources = STRVEC_INIT;
>
> -	if (odb->loaded_alternates)
> -		return;
> -
>  	parse_alternates(odb->alternate_db, PATH_SEP, NULL, &sources);
>  	odb_source_read_alternates(odb->sources, &sources);
>  	for (size_t i = 0; i < sources.nr; i++)
>  		odb_add_alternate_recursively(odb, sources.v[i], 0);
>
> -	odb->loaded_alternates = 1;
> -
>  	strvec_clear(&sources);
>  }
>
> @@ -1132,7 +1126,6 @@ void odb_prepare(struct object_database *o, enum odb_prepare_flags flags)
>  	 * the lifetime of the process.
>  	 */
>  	if (flags & ODB_PREPARE_FLUSH_CACHES) {
> -		o->loaded_alternates = 0;
>  		odb_prepare_alternates(o);
>  		o->object_count_valid = 0;
>  	}

I was looking at this exact field in the previous commit and wondering
if it needs to be removed, spot on. Makes sense.

> diff --git a/odb.h b/odb.h
> index fbafee174b..aefb34213f 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -69,8 +69,6 @@ struct object_database {
>  	 */
>  	int source_paths_icase;
>
> -	int loaded_alternates;
> -
>  	/*
>  	 * A list of alternate object directories loaded from the environment;
>  	 * this should not generally need to be accessed directly, but will
>
> --
> 2.55.0.679.g6767b8d81c.dirty

The patch looks good.

--00000000000079e5360658ecced9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3dcdd950c0683195_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1wOXQ5VVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMFUzQy80aGsrRDN0YWg2UXVxdHpoMXY0SExvSHhpcQprZ1JheXBlSisy
NG90Wk9hejd4b1Bla043b2cvQldVeEVQUnpJWExvWlRjVHdFODhNV3Z1Sno1VWVDS0F2SWFXCkhI
MmM5S0ZJSDFqWVlVNDlIU0oyOXpaYmxMZ1NxMjU0L3lCYjYrMUplaFhkYWZuQXNTVmtwNjljV0JS
d2dnS24KSURlZU93R29maGxhWC9XeHFQQm05OENyN0ZTWTZFb0pmN0pmNStRRGlxSG9pem1RSjg4
cDJVSVZSaThWY3pmNApPYndTQ0t4OWNVcW44YnlRWUMzejRSR1pXNTd1ZFV3eXJOSEhiSkZzN0da
NjU0SFIyOWoyLzJhM3VzR25vdWxhCkJ5aGhsWmdxNjh4Y0U5dHhOancwZUtpc01xdmZtMlV4UnNq
a2hXQUxwZGE2b09HS2dXT2djeVVmbnpGTm5GdDgKeUxXU3o4VXBlOVcvOE8yOVkwQ29WTU5lLzhw
all6UEk5ak10VHFkb2NSd2R3OGJyMEljOTlmSm5hV2FWejhjVQo5QVhMZU1nRm5uVnprVGhvTTBy
UUxUa3pRbVlEYVphTW40bzFRdWFwU1l3UDZGMGZDUlh0UVo2bEdxNDd0UnlUCmROT1YxWjZvUksr
TUljU20rQzFUREFvUEtGdExGOXhSdFRTTGd0dz0KPWE1TUgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000079e5360658ecced9--
