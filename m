Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED36D8BF3
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541791; cv=none; b=NnbW7KgbxZWud94lMKzWbnRcGH6Atm0X4uyLPwerzQw65ioSp2s2L0mBbsAhk5SrFsw/ge3FQ1uHABAlXUOmDc9lif42KjA8oofdyZm/6/1zfJQj65Pr4CIK3SKAf8C6csUQ9rfnSp/P0qzh4J2fwnC+aAwjIHyWGHdcK2pD/9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541791; c=relaxed/simple;
	bh=9p3yNz5PRO19CEe28uQpUg5rEJSmbXMtFT3D5p9oOkY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=Lm5Ca6QHLVe+z26qc1kGxhtQ04ey5UicvYLJ5dMivlwTHePooNugyksSigtuFXoGFahqtV5mommXBWDisc3A1d0FEWrzFVZjGD/7e0HA/sbgDB7qDo6n44AfNR+rvQYL6+u1YuMkqZdLYEnhJxcVi2lAN9JuhTnvQWukj8KZtWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gscBkglv; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gscBkglv"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5d5e1c86b83so3299650eaf.3
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 02:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723541789; x=1724146589; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uTOlma4L+W2xkLSi9kGG03xERGBI4xUh3/VUoOsOQXk=;
        b=gscBkglvq0FM6+5l9XjzuSw1DlYOTpIThzn79FVJNgEyO1XOE8YgBbpsLL1Gj67+a0
         fgsoqixraEosHu8s6rJIWaL5w7PpUbjTeswtPeE7QsHlGwS7JYf8m/LrIDSV8jCLQb/s
         MpNUShUQSarYJk7IrG/XNE9UXEW6+BFyiLfQHbUiY+8SQ8sRumZL/k7e42ybRlg+6YBW
         UikFKNHSyOXTDdma+4Bc5oJsYOhwTpqHz1rKbZ8PXS2vALh2EmxuoMY3x9pAHuNrrHQE
         MS0wL/9ynsCUSn7MVZbx51ZC1IR/VNJoIblajqZy2aSqu7FfU53E04tanTQ5B55SlpdM
         Liow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723541789; x=1724146589;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTOlma4L+W2xkLSi9kGG03xERGBI4xUh3/VUoOsOQXk=;
        b=ZphyUYLkWScRps6xwMshQbx5gd01UuAiSuQquAwTruTs+fBQs9HUfSG3NfXWTzRMg/
         ErVp1tCCjWdZ27KyOtPlPCP+P3s9lZ1fvFQkTyPTfjDRFuVYwglMxb1PpKdCyALzGztz
         HnbHZwMaayqehLIcFTwC0w8Mc6viM1/EETRJS57Iee9yExV/IXmrQdgEnyfFZM0Eb6UA
         EArR+Ha5dZg0JtxodBTR+/bKkT6svVnuXu57Tg06ofa/yg14Z0aYcld2TF0S47kIGj8n
         o+YGuJm61IhDM/RlEdXAm3b3M2cMxd9MjbHsRWSV42IgKFMr4OHrJeyfPzaF/xr1BKqt
         mCHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWElna+09VlFqsZWZxR+k9boBdyf9jmCUXHowrmZqMVlckK32OPmvIDflwBfry5eRCsfrUnxO6yJBfyfCu987ep6pCj
X-Gm-Message-State: AOJu0Ywn1SmPbLarhNB9bjtyHQ//ZH3jvpZVlOx/ktV2LkFlOI9gmLMx
	HH9qP4pebHdSsLI79/fI4puvgTkPq+/UAIKOzb2fc2u+p/9QpQYiedxG85DiqavYUyPftQKnIRV
	AzWXz0uEY2JNAEJJvjqfzqbM7cdexbA==
X-Google-Smtp-Source: AGHT+IFlGOGU68KsjHAOKzPd64Xt5KNl4dmDuSB6oGJjy9H2GzYXHJu47odXKS7Cr+yYDDu5mOCR32/JE6Caha+N5rg=
X-Received: by 2002:a05:6820:605:b0:5c2:2a3d:a671 with SMTP id
 006d021491bc7-5da689e6cafmr3311469eaf.8.1723541788823; Tue, 13 Aug 2024
 02:36:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Aug 2024 05:36:27 -0400
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <404d64effde3bee424e338d858ed507ff83dff20.1723528765.git.ps@pks.im>
References: <cover.1723528765.git.ps@pks.im> <404d64effde3bee424e338d858ed507ff83dff20.1723528765.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 13 Aug 2024 05:36:27 -0400
Message-ID: <CAOLa=ZSY8EWuXAK_tF4sSYGHs2Mv6nE-YtVtVkau4k5h=hOEdA@mail.gmail.com>
Subject: Re: [PATCH 01/10] reftable/merged: expose functions to initialize iterators
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000143455061f8d5853"

--000000000000143455061f8d5853
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> We do not expose any functions via our public headers that would allow a
> caller to initialize a reftable iterator from a merged table. Instead,
> they are expected to go via the generic `reftable_table` interface,
> which is somewhat roundabout.
>
> Implement two new functions to initialize iterators for ref and log
> records to plug this gap.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/merged.c          | 12 ++++++++++++
>  reftable/reftable-merged.h |  8 ++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/reftable/merged.c b/reftable/merged.c
> index 6adce44f4b..8d78b3da71 100644
> --- a/reftable/merged.c
> +++ b/reftable/merged.c
> @@ -254,6 +254,18 @@ void merged_table_init_iter(struct reftable_merged_table *mt,
>  	iterator_from_merged_iter(it, mi);
>  }
>
> +void reftable_merged_table_init_ref_iterator(struct reftable_merged_table *mt,
> +					     struct reftable_iterator *it)
> +{
> +	merged_table_init_iter(mt, it, BLOCK_TYPE_REF);
> +}
> +
> +void reftable_merged_table_init_log_iterator(struct reftable_merged_table *mt,
> +					     struct reftable_iterator *it)
> +{
> +	merged_table_init_iter(mt, it, BLOCK_TYPE_LOG);
> +}
> +

These too look similar to `static void
reftable_merged_table_init_iter_void` defined a little below, I wonder
if we could have simply exposed that? Perhaps we remove it in the
upcoming patches.

[snip]

--000000000000143455061f8d5853
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6a74faf0f1a7dae4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hN0tSb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md2RSQy93SnpsYVVqakFhb1hrVHVGNHFHZndpR3ZWMwpoaWF3ZHk5QnJr
ZUlWZWJRWE5UMnFidTI3eW5ZQTBMaHZocWtkRGRKU0c1aVkzc1VscWhBYi9naVNkeTJtNExpCnNj
cVFQcFZWUVJQMmhiTHJOMkVmUlBhVkRvS3oxTGJkTVYwaUZVMThUczZRc01jd0wvUlkvSmV4d2lK
T1FWS3oKblZ2TmJ5RktqRzcwVjNaeGFJbks0UmR4NEZSRnlweDl1dWFOMkxOSTJQM2xTR3FKSnVz
bFp6OExPV3NZM2NIagpOM0NyZ0VIaVhTd1lTeU1JdU5HbWNaRkhQQ0RZZG9TN1RJRk1DT1lsY1pJ
bWJFSHppSkgxalFyOENQM3QvRG4zCkcxS1R6WWhBd2pDUlFiWEVuTG9aK05wdTJ1L1ZhS28xUFBz
Q3U5OXdHOGdYb3QyaWQ3ZVZ3RXJzVGNnbGtGUmcKejNIWjZ6SXl1L3ZJZC93OEdENzhET1hDSTNZ
S3ZpeGFEREFFc0lXTDFsNmhtV3JFZ3hXMldyeElrOHk0VDF0bQp4OGJuaEFubjNyVzUrR1V3bldt
WE5mU1Y2MktoSDlEUXZvRlhNU0l3NGxHSWNIaGt3QWVQaytYK2EwNWJJRXVsCjcvRnAvVXV3SXVn
UHQ2cC8ycHF6czlJSTdIdnZ1eTZGMkhuWEQyST0KPXUrK3EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000143455061f8d5853--
