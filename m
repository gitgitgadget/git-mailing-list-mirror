Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FEA22AE45
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848659; cv=none; b=oWfLxaZXXdPAMDQLBTHU61ndJ8HeWx5VzBKa7VB+njDscbywQRbxkRIzxz/m0fctGqglzSYySwWHj+89k5sxixjw+bvI06+a+VcYhIgGqrzwpnsfgK0dnWvOAKbodcvTyegq4c15esb2uFjqjUUOOOYld1JLvmgsjUR2DMt+sz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848659; c=relaxed/simple;
	bh=RdzOIlvPoqiFyNk1Y0C1kTPJ2bb119T2Rbql4BlXk5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfWC4NzCd1tXdgVNBp0RSsZsxC6I8cpadPJSniYVsEZbez8nprL72k6IDwpiGKBHQv4TQUufjBPI7QoPVPaOMCtMkYeQzMi1DpGi/MYKEBiiAL/mzxAoum6dd2+OQmLBse6O8MTF7ndAs9tzQ4vEW2T9PED+9OPStiwDFN42OQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbYuGvnC; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbYuGvnC"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e29d5f7672so191066185a.3
        for <git@vger.kernel.org>; Fri, 18 Jul 2025 07:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752848654; x=1753453454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sF+pLFZWXxzQLhVKaPS75mvVFYZf3GbyRmPGlpkKSg=;
        b=lbYuGvnCzpGNHSS0LjayVXHyXIJDQ33VJEKc2iAjMbRqwcv/oNBmFLl1w5Mq5ivxiJ
         wEPzYYRROOWkl7EZl4Go0A5AEkFAB7wMhyyQ0t4zRF/NdSZW9QvfVYrtBr8QWGpkaP49
         1IxbgsTefDW9qXg2eJ334VmVo+d5aR/FmVNY0NIGiVGbRH16vNNEVkp5Z3MuS98NrAHu
         FbLd9RPYQ6GLR2r7GrXLXeRBEEpih+EKBFEXC7kPMk+7JHC+hqGdE4ir4qALxGOVSsht
         obBcnyvvKZrQCDwGCfxUtdcyxpQLkoLejjnWe9ELAzCmmGpVQOtaAnETeRA+wQVKVf6u
         9YYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752848654; x=1753453454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/sF+pLFZWXxzQLhVKaPS75mvVFYZf3GbyRmPGlpkKSg=;
        b=fdTbVHCJ7Bdzoi4AF6htf0WCdX1s21zLn5P0b7Pfoskj4GdNCLK6JPcIsbHJML8g2l
         nCCsCE4uzdT+p1zxfrORsnOLi6YnwKF1oRP9NLbbOPmPAlO+pDry999Y6ncRFT1jGcqK
         kmDaYTy97XwZJuEMIg3CitX2mgvdW18LQrTsjxmvUHVT5rcsiSHL+hZg6+xSfMU8ZoJ8
         EMTqMjevnY04VwGrNAGkWF0iv3Z8GJdu6LuxIypbYgZGm6JWkneoS+kR+dJTQhLe/wDF
         T5ZRi/CdwSm039RlkrRhUenfAywaSTbz0mVOo3eXVLWiqNJM1IAU23AWDVAjojfOF0zP
         lilQ==
X-Gm-Message-State: AOJu0YxK56uPNbnXIM1+6mWCwgMLicL3K0WBu09gbft0zyoss6imWdkX
	d8bfe4GV1L9yUN3Tukm2ixmmuBgyl4DhQpBRQ9+bR/NO1I6p/BTsxx2T6GmCBSYnCn1nwVVJRFj
	MG/pQF5p44oJYxjAn1QEjQW7mmtBE1+wdLg==
X-Gm-Gg: ASbGncv+lyNoXHA+gjtba7G0V305uLk6e1pOC1DQ2b7t2MtaPbUvnR0ghswiGTY6Qf1
	Z7TSMXqBt+V9m5TPIDmpXDUFTfoMTVk5p2c6yO9anxofne/4VT5eQS6x9oLO3xbmihB41MbPpj6
	LdPy4txbOHzLa72SQHEM82rdJTzVV1sHaZUnIhU0j3PTFJMr7paM5WYo4P2AsfWILlAYcLLkMIe
	cMM2kArXFU0HuE4oLbjOt0M6uoJRf0RyNzECVs=
X-Google-Smtp-Source: AGHT+IHt6iVT5l4gfsbxpE1FaWjzsn8MN497/O76qEmRdWfWxJlxnzlmLU06PEc5LkeAeN0U5/9DDnBax3AGLO4of74=
X-Received: by 2002:ad4:5aee:0:b0:704:7df6:44b4 with SMTP id
 6a1803df08f44-704f4a85228mr210135946d6.23.1752848653919; Fri, 18 Jul 2025
 07:24:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLdTT3kdELUyHdZLWyy8e6AbfRU7kDFcVUdCmVtDi11hMw@mail.gmail.com>
 <20250608032705.11990-1-jayatheerthkulkarni2005@gmail.com>
 <20250608032705.11990-3-jayatheerthkulkarni2005@gmail.com> <xmqqa5527nzk.fsf@gitster.g>
In-Reply-To: <xmqqa5527nzk.fsf@gitster.g>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Fri, 18 Jul 2025 19:54:01 +0530
X-Gm-Features: Ac12FXziF-Gh3LFX7DUAJutrLROp4sFA0vob8PRoxmoGcAnc7so5lBsB8T9NAr4
Message-ID: <CA+rGoLfygOAxXNxn_TComuef6q+=v1wOoUSfKh4M6Ywk-0McHQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] submodule: skip redundant active entries when
 pattern covers path
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 10:28=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:
>
> > +             if (!matched) { /* no pattern matched -> force-enable */
> > +                     key =3D xstrfmt("submodule.%s.active", add_data->=
sm_name);
> > +                     git_config_set_gently(key, "true");
> > +                     free(key);
> > +             }
>
> Somehow these lines begin with SP and then HT.  If you are going to
> send an updated version, please make sure to fix the whitespace
> issues around here.
>
> In the meantime, I'll tweak the version I have in 'seen'.
>
> Thanks.


Damn, I missed the previous emails,
Actually my fault it is, I made some tweaks to my email
But anyways
I will go through and send an updated version

Thank you

- Jayatheerth
