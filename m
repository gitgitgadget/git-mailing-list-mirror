Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EFADF42
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499051; cv=none; b=dyICaHmqmZYhoRSj1im3wCrr+JFbUBLWKJdB1FzjB/NMDSaWOpvWyn8G5LmX1xX8Nde+n8NUxHrOXe4sgSxLWY2oiHkudW3cgZa2eFzaTQ5Eykr/nC3BMNcAB1zJ5b7vh7r+OIhCAiCtO+chYDI3xYOYsBj9fIY1rSV541uaPZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499051; c=relaxed/simple;
	bh=nZX7KQTZ3doNJjO1PkCIlOv5nryy9HidayfG8tXU8+I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4ET9HoKfYpl84JNKu6+9MXrDE1Qr1Uf7bdCBxThrzEt4ekW2BjtGRWLsXRuX5JDBqG9QJBCnOCZORIKm5f5dEpntycoS/txvImRwsXKj25GBBp989//aRcE8F+Aci9z7zLN4aeCUA8gu1mqFLFot89OoUUbw/byUforVXs8OMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8u5bXMJ; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8u5bXMJ"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-24c10207d15so2597507fac.2
        for <git@vger.kernel.org>; Tue, 04 Jun 2024 04:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717499047; x=1718103847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wVujNKBGliAtkERvAZM4jhhSbqDwfFyEygXLT+JEs3w=;
        b=U8u5bXMJziO0U+GeArdu2YLCKeGwLUvJYGAkRQUPRKmDpo93FVb01ZOxg5hqyKJJ7x
         6m/mj5p1mCPDQuIvi3OvWCXAQh8kixw5uPkuBQdThI4kqQFR2QIYbDZu8+36Am09gc+P
         Ut6n8m6swE68/4H4dxjeEmDeGqb/YoeimYXKykp1s9ndOTSdhr4l3IhWescY6+Sa9X4L
         f6XCat2UO/Y0D6rf/fEYyEKkdoXWA3TPMcg84vSV4YfA8J4K+GpkO/FprmoJ10E2Y/Ce
         2DuXhJKdlXaMC/Tvx5jEP6MCxzwSPBAS2v+/PB7tSa3DcMRbtAAJSmdDTDDNbIKLrHt3
         WuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717499047; x=1718103847;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVujNKBGliAtkERvAZM4jhhSbqDwfFyEygXLT+JEs3w=;
        b=pwrM/Qa23XjFtJ5U+4c9NrbkAB/IFiK68QOuAAdFXJBVBz6CDJXPPIDRbAJtI2It5J
         TMyAmTcevnbioO8YOBdgKTpSGMUFEajk1FK2rrSnuCZzuLED9PwdTiNxFlbB5IEmILNN
         bvlgA4lKxEOMojGKSmxkZWE2XfAEiexxw5hRbUsQzT68+xepZMyxfG2Qze47x+bHLPDx
         s8q5hPk5wBzYl/3NhPU2Fk/QTjLgUkHQNZP0KAKfzC3NGQUPB11DmOZMo6YTWAHcKs4C
         FdSFxnJz8+2/8F1H9Tai83hIdYvLC/sXU2KA93d0mZs8ChwzVvItwL+sbp4CjspM5hbL
         UisQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwFcTUFEvfBqQFQ4YnM9yQU3MNWhKNYbAE64Cv0EWhrkZG6/bpDCDRvA2NK6wx1FJhyUBSX//xpbIGeS0X/U7U7BIZ
X-Gm-Message-State: AOJu0YzzkUYbGoBIRTtlig15rhsy072m9z7wpP6aRzk5xj1TQ2/rXzaQ
	WHppdUBK5XaSzL3Lw2U1Uj7dRWAuEb7tmujhsinxd59x2HtSfHtQhinG/R4DiaF7wMrn9cGW/m3
	HbNezciHPptI3Y4jKz8n+gSLELfU=
X-Google-Smtp-Source: AGHT+IGK4up2sCms4QgsgRLb3kqL9mlHNZnWKCs5gLwPh5WOW76gxo7TopI74qJgkRopj3dZDYi9utCsPg7jJWNTVcc=
X-Received: by 2002:a05:6870:558d:b0:250:6be5:1fc5 with SMTP id
 586e51a60fabf-2508bbddd3amr13956568fac.38.1717499047540; Tue, 04 Jun 2024
 04:04:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Jun 2024 11:04:06 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <d0539b7456e29fad5c2d1af76657207a199a5d9a.1717402363.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im> <cover.1717402363.git.ps@pks.im> <d0539b7456e29fad5c2d1af76657207a199a5d9a.1717402363.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 4 Jun 2024 11:04:06 +0000
Message-ID: <CAOLa=ZSqHCJJEySyj77eCBLRy+9N+DsOXA=HWguE-5Av_chOjg@mail.gmail.com>
Subject: Re: [PATCH v4 04/12] refs: allow to skip creation of reflog entries
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000a198a8061a0e6896"

--000000000000a198a8061a0e6896
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 73380d7e99..bd0d63bcba 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1750,6 +1750,9 @@ static int files_log_ref_write(struct files_ref_store *refs,
>  {
>  	int logfd, result;
>
> +	if (flags & REF_SKIP_CREATE_REFLOG)
> +		return 0;
> +
>  	if (log_all_ref_updates == LOG_REFS_UNSET)
>  		log_all_ref_updates = is_bare_repository() ? LOG_REFS_NONE : LOG_REFS_NORMAL;
>
> @@ -2251,6 +2254,7 @@ static int split_head_update(struct ref_update *update,
>  	struct ref_update *new_update;
>
>  	if ((update->flags & REF_LOG_ONLY) ||
> +	    (update->flags & REF_SKIP_CREATE_REFLOG) ||
>  	    (update->flags & REF_IS_PRUNING) ||
>  	    (update->flags & REF_UPDATE_VIA_HEAD))
>  		return 0;

So updates to refs which are pointed by HEAD usually trigger a reflog
entry for HEAD itself. Here we skip that since REF_SKIP_CREATE_REFLOG is
set. Nice, this is an edge case that could have been easy to miss.

> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index f6edfdf5b3..bffed9257f 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -1103,7 +1103,8 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
>
>  			if (ret)
>  				goto done;
> -		} else if (u->flags & REF_HAVE_NEW &&
> +		} else if (!(u->flags & REF_SKIP_CREATE_REFLOG) &&
> +			   (u->flags & REF_HAVE_NEW) &&
>  			   (u->flags & REF_FORCE_CREATE_REFLOG ||
>  			    should_write_log(&arg->refs->base, u->refname))) {
>  			struct reftable_log_record *log;
> diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
> index c9efd74c2b..ad24300170 100644
> --- a/t/helper/test-ref-store.c
> +++ b/t/helper/test-ref-store.c
> @@ -126,6 +126,7 @@ static struct flag_definition transaction_flags[] = {
>  	FLAG_DEF(REF_FORCE_CREATE_REFLOG),
>  	FLAG_DEF(REF_SKIP_OID_VERIFICATION),
>  	FLAG_DEF(REF_SKIP_REFNAME_VERIFICATION),
> +	FLAG_DEF(REF_SKIP_CREATE_REFLOG),
>  	{ NULL, 0 }
>  };
>
> --
> 2.45.1.410.g58bac47f8e.dirty

--000000000000a198a8061a0e6896
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e261322449386daa_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aZTlLUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMi9oQy8wYnROVC9Md0JRc1pEcS94LzVDMFZWMFllbwpTVEw1N3k4YzNZ
OXh1azNEMFFoODVNSHQvV2R5VTkzUnBPakZ1ME8yL2ZQeVpTblhkSTNUKzFLNm1iUm1BaXZICkcy
ekVMQ2pzdWwxcUJHUE8vTlFkOXhxL1IyMjlzRFc4ZGhQa2tISG5HSkk5UmttV3prbkxZYURoWWlp
Wit0emMKSEhUZDNVRlRNTGJReDNVZ0V2bUQ5eEgyMlRFYUs1YlJJL014cXdzN25nK1FjQjJpOUEv
ZkNndFZWL2JtZDFsawo4K0hBMllScTZJdHc4MXEwN3UxVXdSbGcrVEtodi9sYVdnVHF4L0Zubi9K
NDF2Q2pYTEwyTXVFdGo4TjA3M2k0CldtRzlTNzdOUW5mTEN3SXk4VEYxejNiaE00YkJLT3Z6WGph
ekJwUFlWNlV5WUtZd3VzUGVqZkI5UlJGT2RpZVIKZWdYTzhJWlEzRFFxMzdxSEEvUWNYSS9HSUh4
bzRLS20wblZ6SHNwbXo5RWdsQkZWMXl5TFNYeWdVTEc0enFSOApNdlNZMFRhWEd4dEpST3poY3RO
REFHdG1xMGY0T2RmdE5CT1JKTnduS200ODBUS1FvTFhYY3QrL1lkN3RPZmExClM1WUdML2c0MGR3
RFc5cHlVSWxoTmpBWnAwdFF2anJ2eWlrT2hkYz0KPVNmdnEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a198a8061a0e6896--
