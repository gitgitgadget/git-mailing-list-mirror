Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F98313CFA8
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720203247; cv=none; b=U6BGAj44yedJdQRQj+OTZeJMqj47ktcOK4QK+LhLVlO8HxjdoDa9EE1wAQM3uoevXTZGETKgEtquSwTvaqcY/NXJ5mOhiM2VvTm/lPWJ+J6sHmzKU/OZW6up+p5NklZf44a8Lt92SNHtuKOuF9Jrv2zLOI5Zk+ngq1Cl/FJpk98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720203247; c=relaxed/simple;
	bh=1HABZuJXmi9T32QL7iE8eFU/BWHJP3xfBPqr/rTnac8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/wROEEi/Mf9pJXQZUWOMnCA8VA+iwa9Zt3/gHq7LJbdvgb4yMzKOKPKJZqnYKRxO8BYqlPV4pE6Y1lgYOGB0q1R9NruPFayTTaipLlGgW2619ALuxclqTVMySJu+Q1EaYr3Vfaa5qFKQMt/R7sai4Fg/UnRMsUaflzZWUsqSBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvvnCaz6; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvvnCaz6"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7035c367c4cso310358a34.2
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 11:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720203245; x=1720808045; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=A/Q5WmJYBTbjYAjNz80HmS1qD/DxCJmRj95mtlgYNZU=;
        b=GvvnCaz62owzMvepqh/bhh5AjGDy7/kRfCE3dudGtRcadd3RV6ZG9GdGvuSc9+52OC
         U2c8hKw0HnF4FKxSr2tHJez00uAOJldo77rH9ZK43YGGRf08hA4VJpv0wL49e8OU148W
         yT5kS2j7gMHUpFw3sN7sMDSq1c4OJlW0lnflVf4ec2PAihQNWocC2yOUDvaX/BIHB5by
         035PrH7v/6ahXQcN1xPr0ENxZmjU9GckrftqlW1UolWKo1KacrvhSua/4nmtyMbs2KnA
         jOtZ/bfaX41Mrov72OGOOJfoWChbRDS8bqaR8BVBBh/aQfrP1DGlBmjM7nV3zuHVBc/U
         yNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720203245; x=1720808045;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A/Q5WmJYBTbjYAjNz80HmS1qD/DxCJmRj95mtlgYNZU=;
        b=hBRA4tTGq/fycaDAQihP9f0bfKYPacR3sufTlVTmGoqVWf/kzXOVzYr+ZtDtsTMlBe
         iSpq6Jo393CXCSS0gneQBd7Q9/IutnDwnvH7UXwv9PaDkRogvUOLSe7ukydzXfuLFrdM
         zwUaLRVlcrnlQp/YPJ/ak/Rwpl4lofAG+tK+CHpGWB0V4VJcB5pWZzAP8XAiqPxL4MM5
         8byyBUa4UCrjYKcisV9CJATbg17birKRJ66kikqbGmoltNlg8X3vKHc7KerxxQcIoezw
         E5P2BaaqrmLgrnBhbt1jFNZDhbD0I3l+vcqL8blJo73UT78dZZ8NP4YKNdehMt6GJolf
         HqkA==
X-Forwarded-Encrypted: i=1; AJvYcCU699mWXwErN4yrqLqwKj55kr+6kAYOAWuAnN04ZK0iznGzGC4AbSVOaYOETo7RuFevIJhmfFm9TxpY3mKHJdQ98mT0
X-Gm-Message-State: AOJu0YwhBy1qs35APcJG0bJnTr0fmz0PowdesH5qH4OZY2YZFJqI8w1w
	BcsKI44cRNQyGAlRCAXr8UVB3/WWtxyO5xZL/dfyuhezUVKy2BlAszPHgL1eWhfx+FwZTX7KDHx
	CI6TDJLD4vOVN7joMws6ZDjFMlBw=
X-Google-Smtp-Source: AGHT+IHzrCa5TZeJ4IhM32Jnp0aHuq1Mw3TBtt2E4JVCqiNN8jZmexfPKR9OL0IbmIzbB4MCxV5kvXQVZA0KVaMA6MQ=
X-Received: by 2002:a05:6870:e255:b0:25e:2923:a37b with SMTP id
 586e51a60fabf-25e2bf2ae8bmr4659052fac.55.1720203245112; Fri, 05 Jul 2024
 11:14:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Jul 2024 14:14:04 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240703171131.3929-5-chandrapratap3519@gmail.com>
References: <20240703171131.3929-1-chandrapratap3519@gmail.com> <20240703171131.3929-5-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 5 Jul 2024 14:14:04 -0400
Message-ID: <CAOLa=ZSTb-kKiGHkGJwSgx3acxcfFe_+KGW=p7O7B7=CgeX7rw@mail.gmail.com>
Subject: Re: [PATCH 4/5] t-reftable-merged: use reftable_ref_record_equal to
 compare ref records
To: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org
Cc: chriscool@tuxfamily.org
Content-Type: multipart/mixed; boundary="0000000000005deb3f061c84072d"

--0000000000005deb3f061c84072d
Content-Type: text/plain; charset="UTF-8"

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> In the test test_merged_between() defined in t-reftable-merged.c,
>

s/test_merged_between/t_merged_between

> the 'input' and 'expected' ref records are checked for equality
> by comparing their update indices. It is very much possible for
> two different ref records to have the same update indices. Use
> reftable_ref_record_equal() as well for a stronger check.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>  t/unit-tests/t-reftable-merged.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
> index 543113f3d4..656193550d 100644
> --- a/t/unit-tests/t-reftable-merged.c
> +++ b/t/unit-tests/t-reftable-merged.c
> @@ -155,6 +155,7 @@ static void t_merged_between(void)
>  	err = reftable_iterator_next_ref(&it, &ref);
>  	check(!err);
>  	check_int(ref.update_index, ==, 2);
> +	check(reftable_ref_record_equal(&r2[0], &ref, GIT_SHA1_RAWSZ));

We can actually remove `check_int(ref.update_index, ==, 2)` since the
new check also would compare the update_index.

>  	reftable_ref_record_release(&ref);
>  	reftable_iterator_destroy(&it);
>  	readers_destroy(readers, 2);
> --
> 2.45.2.404.g9eaef5822c

--0000000000005deb3f061c84072d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8cacac7c54b2f9c2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hSU4ra1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMWJmQy85a253R1pZRktJbnVUZ2NkRFdESVRYZ3EwTgovMWhtaU9QZldX
VVRrUmpUR0k2SmdJbFlFem5jTzhkUG50eCtlOE1sQXZsQXI4TnlsMG9ReHV6VzlOSUFQWW8vCkZr
UWJ1ZUdEanJ4V1JoRy9ndEFBc2NKc3YvdUppNkpEbFk2UVorVTd4eTNwU05QaFBnbFNFZ05YMkxq
cG1rb0EKWDJ4ZURKcDFpeHpFaHJpdzhxN2J2ZDVHbFkzU3JSa016Lzh0N2Q3Nm1hbU0yRlFqTHIw
bG9XUXEwZkYvNGRmTwpXckpVWFViclBDbUJMMW1aK1VURitBN1JSME1OLzVXNCsyVkRycU5lRTc2
VTIrc3FaZE5Eb0VWRnFLNlA5VHNuCjcwK3hnUHEvb3UrNHdMcHpSYktEOTlBMCtZMm1jeUVNOUJV
azlYNnBnSGkwQ1FBRmQxeHNmNlhNVUxtdHE1ZlcKdTJ1MjYvN0l5L1JNZmZkczFabWRaUUwxL0tQ
ejJRcUFxa2UwL1FhQ1A5SHNGUUthbmhmWGVZMkc5VkM2RVFGdQpNM1NYRFpHRk9ENENCZUVDOCt1
ZzlqRTNzNWVoWmtad2hHSGhpNTFCUW01OFZBeXJpNk95NGtNZjJmNHRSVzI4CkV3YWpyOXZNOE5C
NUR0SDY1NStSbEIyWXIybHJGa2RmWjZwK1JSST0KPUNtTHoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005deb3f061c84072d--
