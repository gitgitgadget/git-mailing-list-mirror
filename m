Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307752080C8
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440275; cv=none; b=ZdkjT/Of17583VLlUkt1U3Yow0K7cpPlC0Uma1CccSfHwLHEPNti0BShnbQ1K4GmiPFQif+hNDn9qGEk5nxcj7XCZVWf5DottI7UcRE116qJ0tGNy2Tx982hCNDGhNk8vQkt39KfB3R/75WsOOwV0qNKkLxYTQvnb2PSLHAYWj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440275; c=relaxed/simple;
	bh=mcpMb+dAfutuUxXSOBs2LW9kRMBCuVs+5hmV1ZPbTuw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzAvqJZBZqvITqP/Ohk6Tio9spNizu6hDwaKfzV3DxXp0l1S/Rsce4ogNcUGc3Enz8/p7TOQqBngMMu+NDhL21EbAjcUjCvv+qLku89Q5FToIpekzcrY5zycdDM86/TOet5kRbMKDmbKRkiGkvY9wHoMjGTZr/w1Ow3jKNQnE3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxPqgG9Z; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxPqgG9Z"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-51eb1a6ca1bso202607e0c.1
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 01:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739440273; x=1740045073; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KTa3J8+i8XnhDb8sH1XKfFuy8ePbERS53nKnYf/AYts=;
        b=bxPqgG9ZLYsu5HRFDyaPSxPi/2ALmXMDhCR09kiWOFtZLjUY7eyCNs9xOZR+KNIlfy
         /tjoBdwQbC79n7Nfy5t+Hsk3YJd9CD9JjQrBQKUGDjF3hVrPgJ1yBvdJpujXWXVBvH1a
         qYI6Ke6N0xeSsuTS7D4DtkEpEL1hyNiTq/JK6mHwx72LKLChML/1SdIjnlodCYwbFSop
         vY91d9SmDoATxm0TKDUHxYwX0QjH4a4nLkZQjI99w3Ig9DgSSAhfEzbGEHELj8AlT3WI
         s4hhMlzPpwBuoCc3qN7vv9cU++fV9fjcTe4IErVAPacROYOFPWxQyZ/hk04zDfGoRWZ+
         +WoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739440273; x=1740045073;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTa3J8+i8XnhDb8sH1XKfFuy8ePbERS53nKnYf/AYts=;
        b=IButrcHMmjw0/DpMKunAiRS2Dg2C4Tq5dB26cle1yat5y8+mH/i2XJQRDq8cXxUGvT
         T5ax3jDZfHfgmj77qsB9/qzLuQiox+to5e3DeB3Gd2yofFk0gjZvcfjywr6sEJNGB7mS
         Z1JRs4QG38Y/4HcXrlkHbEBgtsRH3yf/FIxZR9mL3ZDWOrKkvpJm7uVsOKTTh32/zm5+
         JVmD/tXO1Eifaigy63oqbx5y7P5OCjGTwjvb1SNmSTAV/D2Q/Hb0vuqjkil/cR7syyaB
         OJGFnxAgvNNDFNHunrNAgPeVovEiNqRsaAP403pgI/zr88R6c+NQe85Jsl2ZQtA0xTG4
         AkLA==
X-Gm-Message-State: AOJu0YxU/jLtXvmeLjs8lFwzp0hp5YoKLZIfE0gr7Fge5MLln4eWm4gT
	vVbnj9YtVZWDXh1g1DFzTJ0gV4SrWELmur/a7dRITjunsvxd3WyVZDk3vX4aV6Xqh231/8Jgnva
	vVyRSbNOVRJ8Z8Bsxhk96ug4XLeQ=
X-Gm-Gg: ASbGncuTb8A8Dmz7Fa9ERgfrLFioi7qYKdJtk0KoHWn6vPsFocbYuKwgXMTsYar09kh
	NgOwgOmZrZLOROCi5xozQI3VIj5uhQ9geq0mDa+0qwdq0IIdAr5ZWhZVBimnizTNCOCiUr1wFqQ
	==
X-Google-Smtp-Source: AGHT+IEtx/17JaJyi3TrO+4nZbBXJoa/Razglfgn5WORzThmEW+ZUXouCmDaaYbh1cQzjV7xIZ58Kmcpm3XVDpH3uhU=
X-Received: by 2002:a67:e703:0:b0:4bb:c24b:b64c with SMTP id
 ada2fe7eead31-4bbf22e2b74mr7136632137.16.1739440272902; Thu, 13 Feb 2025
 01:51:12 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Feb 2025 04:51:12 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250209081216.241350-2-jelly.zhao.42@gmail.com>
References: <20250205014055.737190-1-jelly.zhao.42@gmail.com>
 <20250209081216.241350-1-jelly.zhao.42@gmail.com> <20250209081216.241350-2-jelly.zhao.42@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Feb 2025 04:51:12 -0500
X-Gm-Features: AWEUYZknTDP3Vo-ZmHFoZsJGRKj9yhVSbgbukpcozbJ-rD3F-oCmV0FOgV9ziWE
Message-ID: <CAOLa=ZQbVBmGnsvWUz0ByW8z5NMgLY2oZZ1RLJeoWJST9PGAvQ@mail.gmail.com>
Subject: Re: [GSOC][PATCH v2 1/6] apply: change fields in `apply_state` to unsigned
To: Zejun Zhao <jelly.zhao.42@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, newren@gmail.com, ps@pks.im
Content-Type: multipart/mixed; boundary="00000000000093359b062e02ff8a"

--00000000000093359b062e02ff8a
Content-Type: text/plain; charset="UTF-8"

Zejun Zhao <jelly.zhao.42@gmail.com> writes:

> `.max_change` and `.max_len` of `apply_state` are only used as unsigned
> integers. Misuse of `int` type would cause -Wsign-comparison warnings.
>
> Fix this by
>
>   - change `.max_change`'s type to `unsigned` since it's just a counter
>

Looking at `.max_change` it seems like this is only assigned in
`patch_stats()` where we do

  int lines = patch->lines_added + patch->lines_deleted;

  if (lines > state->max_change)
     state->max_change = lines;

In this case shouldn't we first convert `.lines_added` `.lines_deleted`
to also be 'unsigned int' in the first place?

>   - change `.max_len`'s type to `size_t` since it's a length
>

I see that this is assigned the return value of `strlen()` so this
makes sense.

>   - change the types of relevant variables in function `show_stats`
>
> Note that `printf`'s format string requires us to do some typecast
> (from `size_t` to `int`) on `max` in function `show_stats`. This is
> safe because we already set a upper bound of `50` for `max` before the
> cast.
>
> Signed-off-by: Zejun Zhao <jelly.zhao.42@gmail.com>
> ---
>  apply.c | 9 +++++----
>  apply.h | 4 ++--
>  2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index 4a7b6120ac..831b338155 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -2238,7 +2238,8 @@ static void show_stats(struct apply_state *state, struct patch *patch)
>  {
>  	struct strbuf qname = STRBUF_INIT;
>  	char *cp = patch->new_name ? patch->new_name : patch->old_name;
> -	int max, add, del;
> +	size_t max;
> +	unsigned add, del;
>

Tangential to this patch, I don't think we have a guideline on using
'unsigned' vs 'unsigned int'. Probably we should.

>  	quote_c_style(cp, &qname, NULL, 0);
>
> @@ -2257,12 +2258,12 @@ static void show_stats(struct apply_state *state, struct patch *patch)
>  	}
>
>  	if (patch->is_binary) {
> -		printf(" %-*s |  Bin\n", max, qname.buf);
> +		printf(" %-*s |  Bin\n", (int) max, qname.buf);
>  		strbuf_release(&qname);
>  		return;
>  	}
>
> -	printf(" %-*s |", max, qname.buf);
> +	printf(" %-*s |", (int) max, qname.buf);
>  	strbuf_release(&qname);
>
>  	/*
> @@ -2273,7 +2274,7 @@ static void show_stats(struct apply_state *state, struct patch *patch)
>  	del = patch->lines_deleted;
>
>  	if (state->max_change > 0) {
> -		int total = ((add + del) * max + state->max_change / 2) / state->max_change;
> +		unsigned total = ((add + del) * max + state->max_change / 2) / state->max_change;
>  		add = (add * max + state->max_change / 2) / state->max_change;
>  		del = total - add;
>  	}
> diff --git a/apply.h b/apply.h
> index 90e887ec0e..f7f369d44f 100644
> --- a/apply.h
> +++ b/apply.h
> @@ -90,8 +90,8 @@ struct apply_state {
>  	 * we've seen, and the longest filename. That allows us to do simple
>  	 * scaling.
>  	 */
> -	int max_change;
> -	int max_len;
> +	unsigned max_change;
> +	size_t max_len;
>
>  	/*
>  	 * Records filenames that have been touched, in order to handle
> --
> 2.43.0

The rest look good.

--00000000000093359b062e02ff8a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5f0a567b22a06ee_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ldHdJOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMVByQy85UHE2TFlISGRrN3VTR2Z4MVZRWVRSRDZWawpOQUFoeFFRZmF3
TjBVTnpYaTlNcEZjMEtWQ0tKSVlDMTVXa2FKYUdTdGFZRnRPc0t5TEFNREZKVU8xeEtZZGlHCjdS
R2hWT1RCVGtSM1VCelhiYlZnYVlVWjFxVTVjZjFBQkRGaGNEVnZ4MVlBRjhFbGhzRHNid0liSUFk
SnR6UGQKckZnNVlTcmxHYlVNNVpxOS9UVjJpUFA1S2U5RnlQRFpGR0M2OHdIMlJuNFhGbEF4U2di
dlRuWTU1WGpQUWNEVwpvaWI0RUpRRW4wTktJdDh3TG9jUnZ0bHIwdFM2Mmp3Sm9NZFJUQ21JNERa
RXNmeUx1L2JuY0IreXV6QkRqOTQ0Ck5mZFBDY3RVd1VocC9od1JUWmJXY1ZXSHVFdHYzTENjbEF6
NVA3ZUtWTmNwajh6clZSaHZsemNONlVWYTBETm4KbnFwdW9SM3g2SXFCT2FsVG11RDQ2cDRJL1Y4
Q1VQaXZqeGJrbzBoVmdGVjlDSkphQUR3NVcwUnp2U0FoY09kTQpmSW1UK2VJbUMwN0FyUWEzcnVC
UnFEMG8rMGJ0ZFExSnpPOXNzME03WU44TnA3NkdyOGZ2ODl5QXloYkpncHFZCmpybXdXbEFvM3Yr
RGcyVlFWNEtucHVTTGlnT1RtQkE0WlhqSUhMND0KPVljSVIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000093359b062e02ff8a--
