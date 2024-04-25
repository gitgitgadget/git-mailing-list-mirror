Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03777152E13
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079251; cv=none; b=onQp316j3OWl+e1H+ekiSu73SvRi6R1pfSr40cE/iKTZBdSWWasoHMXa/TDaZsBE5ULdgCBh9qyJrkhLsArKfSSCyVOt6BvGayWa1uYoxGCoDpRm+RfyCzWrvEW6DsgowmLmrxTrlu/iQQDyCJanOdrsf5uWSICrfId0tAivSN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079251; c=relaxed/simple;
	bh=8Le+dlZwCSGGkoreBWmTtJOlLbqPk5UGOuT1LYlfQ8Y=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fx26XWrgi3hwsIBkxkNHiWa9vz075KV4boC8VD26JeeRUMMT+v4tw8db8MleorXFOHj8i5Ce8Ac3MtZ0XLoytZDPD7gwc+XZU35swo3yPFGOnjv20cDQ7foBfQA7p9Tj9ckpUOmZqN7FCMOyjJOqOhsLPzHcKzjMeBiNTQAKUPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3dPqLn3; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3dPqLn3"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c844b6edbbso919406b6e.1
        for <git@vger.kernel.org>; Thu, 25 Apr 2024 14:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714079249; x=1714684049; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=k+wmisdSo2CcAVT1MtLa1wHQ7l1P6MRfTXcrXALbEUg=;
        b=P3dPqLn3VtxgzdIg/2SvdDvD6M0gcNPA5NP9ZLZ2XYphtDkLkt2SRnIy6wKUExuOsT
         GO2O6iFRjY1CpPxJhxEGigBd6DQrNf717jO5vGFSJp3G5ORCiH7pGIRReG2oENR4TQvw
         yjYpofxga0DPhJ3b+X2Oc9CkS9Wi7205GntXli9DdJcvJmbf41cBJV+0dArX5znrTJLa
         +IrvkmGgZGUxzIulN3kmDXAzQS+4/QnkcsSndQxgFTv1CiqTRLY6uCshaeVBzguuso7r
         DTSut9PClsML7yOXwGoIueMXhqfaaje9rp/hz2bmqqfS7Svo2UUazBUHzbmD/+HqbM5D
         Il+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714079249; x=1714684049;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+wmisdSo2CcAVT1MtLa1wHQ7l1P6MRfTXcrXALbEUg=;
        b=CvuZ+zd9JdCgS8Lq+FSiDJQN63R/G+j4doxZyFvdVXFV/6BwjTZzg7mrLsBxsZQldy
         bOUPGY12XhjhwBMyJMfRCEXVRYWzOsr3+f+g0SzniT+W1sxnXmqQxfyWTOuYjKjJgOph
         jVpGCc/VUlptUfNNpAc4g/6eNRuaZBBMP4ABiNEO9lklF03+Nmvy738hAEg5sJZ0HhFq
         vfQp2yLwjl6uMx2vM7Kw+Mca4UR9ZySkixQqLGKjneiGTCb/R9NlBvwrPz/+yMgBVT/Z
         gytDnI3M+dOthKXTJupyu4hOL12Lx2IcbZM6Y0coPutHPRkJCYYufPjRfSmJUwFogh/I
         MRFA==
X-Forwarded-Encrypted: i=1; AJvYcCVKP3/oISOJgYCLUrP9juPfedKUFoKgzFImKjY2954pTW456fsYKNBX1s8KW5eIpFVKJW17KENtfeux2GMcGhhQR4M5
X-Gm-Message-State: AOJu0YzBm51T0DgBk4QwqAZVvvwretowBoPLFrjElpF68e1dVfrHeS1D
	639mYNtZrFSS7J7uxrjQbjzrSgPey0qbu0NnNcvg9ObjvHqzutEpYONoKyItZrPvLBad/Ab+Iba
	2oKNSIIgpE8j0ilrAXlc1E+xU590=
X-Google-Smtp-Source: AGHT+IEZ9OLguZQ7F+Xq5x+cZtJg315YpTv+w60DFwdTHFy34ULacGb9hm2sXA0Kvmts+8N5kFoyCrLHrOtABrcfP+o=
X-Received: by 2002:a05:6870:2312:b0:22b:a8f3:36b7 with SMTP id
 w18-20020a056870231200b0022ba8f336b7mr652299oao.55.1714079248829; Thu, 25 Apr
 2024 14:07:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 25 Apr 2024 14:07:27 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq8r11gyhy.fsf@gitster.g>
References: <20240412095908.1134387-1-knayak@gitlab.com> <20240423212818.574123-1-knayak@gitlab.com>
 <xmqq8r11gyhy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 25 Apr 2024 14:07:27 -0700
Message-ID: <CAOLa=ZTw8Y5iohGkha2RUtaj7Xsp5WwBs1C+_XbgwP+Lbc-ALA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] refs: add symref support to 'git-update-ref'
To: Junio C Hamano <gitster@pobox.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000be6a6a0616f22c33"

--000000000000be6a6a0616f22c33
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> You'd want something like this squashed into an appropriate step to
> avoid breaking "make sparse".
>
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 175579148f..1cdafc33f3 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -228,7 +228,7 @@ static void parse_cmd_update(struct ref_transaction *transaction,
>  	have_old = !parse_next_arg(&next, end, &old_oid,
>  				   &old_target, "update", refname,
>  				   PARSE_SHA1_OLD | PARSE_REFNAME_TARGETS);
> -	have_old = have_old & !old_target.len;
> +	have_old = have_old && !old_target.len;
>
>  	if (*next != line_termination)
>  		die("update %s: extra input: %s", refname, next);

Thanks, will check and squash this in.

--000000000000be6a6a0616f22c33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 43e62184aeb855ff_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZcXhnd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md0FLQy85UHgzcC9HR1c4NXVMSFJBbTA4V1NJZUh0UQpBRVpUM2Z2OTVI
dzRXV0IyOWlRWXVqTGlFMmRKYXB4UHhnV1ZTWnlzcWQ5dXBpQmdVYitSVnlzT1RhL3FLMlpOCity
a2k5ZDdnQWlEeGZKSlZ2RWZxcGlOQXh1cVdCeG5vUFpEWDRSSnlZZ0dsT1V0b3BnK205NmtwM1RV
bG1McHcKTWJUczFrQTJOMDY0ZE9pbFlZaS8xNFozQjc4VFdPKytudG5iSEMveVRNWTlKckFIbnZu
dW1NeTR2SlI2MHV5aApGQ2ZBQ3NDZWM2MWxsNGpvamlIQTlsZllJZDFvTUtDd3dMaDVmaHhmb2Y1
ZEE5Ti9vdnUvdGFYdGRQaktwbHJ6Cm5peHZtcVJKNC8xNUlTOTVXazQ3S3ZNb1hPUFlVL2J0anRH
NkVseHFvZkV4ODQxWjQvY3paQVNoZ1NXRFk2aGwKeHZtZmU1UzQ4VDBVVTNydUJBY3RpOEZNdS91
a200Z040M2x2cHBsTGMvNnM4ZHR1dFZNdEs2NTU5NngwbVUwZApYc1VEbVBXQTMxKzJzamMwTFl2
OTVCZHBQeVNpcHZUMktrUk5tVitUbGlhSExpT2tNVjdIU1dGMFlvMTFNd3krCmx6bWd2WmpiNitn
bGxKS3d0RkMxNzdrQzhBbitjbVVFdjVZNEpNaz0KPXAwdmQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000be6a6a0616f22c33--
