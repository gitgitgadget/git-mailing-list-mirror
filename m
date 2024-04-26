Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E03143882
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126144; cv=none; b=uLkSImrOfxFTwZh0ro5DaLjLp6WLN4Y+F4oTq7qZF3WhayWWsuW0vXX1ipSkBYekHyiCfQiWAe8tVXowzRx7P/I6CJjOSIc6hi05reoMb0iH4nh/buFaRWlinGyGLeSNtLvUvFzwOcSeNKdJTTWdyvAEmq3TqYSg4g3jAzxJ+F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126144; c=relaxed/simple;
	bh=8Rpooc4zhNXh+YwTvvDmZW2PNJ36rnkE4o/Jeg8Fioc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=M7FV8HGtFdNZNhbTTJXxVhvMNyunopgp9uvGXCRDSJiKKswP0mnkX699MLtJC7kG+se8h734w9SBVBU+q4DvSiCoAbr82u3bnxLrmorLlTJFjRODsfsvS+Nf9Ac9GExXjLXCcVf9pn3ZCrQT5hSmpTlUsHpRk2AUzXDbVQE4+V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8ZfbUnz; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8ZfbUnz"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-23a46c472feso1007789fac.2
        for <git@vger.kernel.org>; Fri, 26 Apr 2024 03:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714126142; x=1714730942; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M+oNOCdbUeB4NVsK/njSY4bixkw+aM3pkCCr29B8Nc0=;
        b=C8ZfbUnzZpmup2dYSMHsOKmaR9xthMJFCtU5ZYuOEvm1+dkihjE28SCSC9CmE0GmBd
         Noh3dvpI5cpPmM6IBgHCt2jUfb4ewfiB7d0PXxvXpcaK7+/FZkHdd6Qwo2FSQVTj0PcM
         yGAoWGsmDtYttFAvrhNa73YapbPHv+shuTLnsA1enK5LVZZuTB3F4Rtr3i+dY3NhQp9d
         UKfxnCG8YYnRXTkI1jZoVCtKXU8Rp3k7LUweBH6KAnJVtMmGmr6i7Ow+eLW7n1cEF2yk
         TFRk/3wFrbUfzXZFraTPN2DzbJwD/UPr/mWzCUUsfDfhdTyP8FRxCdRqw1WhxhwHeYb4
         kFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714126142; x=1714730942;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+oNOCdbUeB4NVsK/njSY4bixkw+aM3pkCCr29B8Nc0=;
        b=NmSk1EgKDxBo0icbIm3K/9RoBOutksgL7mRLDnmXbyPFMntbHl/TnN2gRI7DQmGk87
         f7g70ZGTXUco5mQcZ+9yXuhBA4TzJ95UNdOvfrhBddZAF+TNJalVAzlTbXn3aZ5NIJp3
         eTRlh6RHZpHtAGY4PpFP+G772XswofRNDH5I1HItbzJTkTeock3kEuRGHdoSxTvyLLrx
         1fMJvNQ8wpVYxEyxSXXGDN7oslhNuHxnRpgqDBX6IkETXYz7bFVCPuPy+AKc2mq/fAwl
         H6fJv9EqKHYPBm1t6p/FZ6hCeP/J/KQgLsOEQPvCfkNn2Zc+OlPrShfEK8vZ/+2IKOWr
         rfuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaXvqkupxwVw8I5/GhuQqwc09YwxZtrq7Ut3zcONGBd9MbCtXpqESdQ7B7LBTSEdCeUozdEmYW2nN/6LAQ2wtEB1DY
X-Gm-Message-State: AOJu0Yzad6kDzy8sMED3x+nFteeaSaZ39eAGF/h3cOCV3xiCgI6qVTAE
	xloJ5pT78I6rlDL0smEGx8td2q15rTZBIGX6CnOIvZ7UEcMdy2hTMw0cjB4ODhCS/Zv8F8qMsc5
	QsHrsXh/7zz5st6Nv4IvhdHxwPAHiWA==
X-Google-Smtp-Source: AGHT+IGdPXqMnrcYGjKanNkHM6ghErrKytvDVjU/zxZ3IyWAds30ZAL6yRjewbg3PrgDbtyJWRBL1YidHzqBv1kLq0w=
X-Received: by 2002:a05:6870:3044:b0:23b:50be:6b21 with SMTP id
 u4-20020a056870304400b0023b50be6b21mr2070695oau.18.1714126141719; Fri, 26 Apr
 2024 03:09:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Apr 2024 03:09:00 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240425213404.133660-1-jltobler@gmail.com>
References: <20240425213404.133660-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 26 Apr 2024 03:09:00 -0700
Message-ID: <CAOLa=ZRsbUK0Zvo-VK8h2VfSicQLQ=StC5b4VvAzrFquTBn7bQ@mail.gmail.com>
Subject: Re: [PATCH] doc: clarify practices for submitting updated patch versions
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c7244f0616fd178f"

--000000000000c7244f0616fd178f
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> The `SubmittingPatches` documentation briefly mentions that related
> patches should be grouped together in their own e-mail thread. Expand on
> this to explicitly state that updated versions of a patch series should
> also follow this. Also provide add a link to existing documentation from
> `MyFirstContribution` that provides detailed instructions on how to do
> this via `git-send-email(1)`.
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  Documentation/SubmittingPatches | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index c647c7e1b4..bc212836f9 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -415,10 +415,12 @@ e-mail tools, so that they may comment on specific portions of
>  your code.  For this reason, each patch should be submitted
>  "inline" in a separate message.
>
> -Multiple related patches should be grouped into their own e-mail
> -thread to help readers find all parts of the series.  To that end,
> -send them as replies to either an additional "cover letter" message
> -(see below), the first patch, or the respective preceding patch.
> +All subsequent versions of a patch series and other related patches should be

The 'other related patches' is not a strict rule we follow, is it?

> +grouped into their own e-mail thread to help readers find all parts of the
> +series.  To that end, send them as replies to either an additional "cover
> +letter" message (see below), the first patch, or the respective preceding patch.
> +Here is a link:MyFirstContribution.html#v2-git-send-email[step-by-step guide] on
> +how to submit updated versions of a patch series.

Thanks for this.

--000000000000c7244f0616fd178f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: dc1466c787c31a70_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZcmZUZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meThUQy8wVmxlVmhjL3AwNmdxUG12a3dQTGFmNStLTQpadTRLVnBWK0dx
SUNZbDdHY0NSNm9SV2EvSFRnSHRxeFFyQTBJOVJwMkwvMks4Vy90TEQ3VWFGR2hLL0l0NU9yCmNU
emxQRTY4RWQzVnI5NHNYc3VkT1RZTkpCUXRuVXJEZ0ZHUi8xMnkwV1UyZzAyV1VCWUNmNFpLT1pr
ZnZNanAKNE5oSUxWckFWc21VdmRWQ3F3Zit2bVp4LzdQck1najdmUzlWbkdLaEtTU0dGU2N1SW0x
cTMrQU8yU2IyZTd0YwpDMm8xNTVuMG9IS0lTeWJxWXJuRi9JU2dqdFRya2FvZVYxK3pSVEhzSHZs
b3VVbmRDaGpYNVZFbW8yVEVCcmh0CkhFSzFXNzdmdmdTbnJLelJVdEZDNE1Qd1NxWHF1VDdtMWlC
TStBQW1TZncxckM0S3hSYklIOGg3RU53aURsZXQKakVTekNBam9OQmlYTEwzR0dmNFZZcXdwOEZE
eUZHd3ZnTkE1aCs2ckpuRHkxQXlrTTF3U2RVOFE0RUxMVHhBbwpwNldRQkw4bVBCNmtZQzZzVFBl
Wk9ySDZvWjd1NlN5ZUUrL1l4YXlqa3N1Vmd0Q3d6RWp0L2h1Nm92U2E2Q2lrCnAyVmx5Q2diSmRL
QXpYcnJBOWk3bEIzS2FSdlFpTkhwcm5MZEZ3ST0KPURobmcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c7244f0616fd178f--
