Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AF934CDD
	for <git@vger.kernel.org>; Sat, 15 Jun 2024 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718452169; cv=none; b=MoMuMgYeHWlPGE5Mo2bKapmPnvJi7Hj3yh6rc44twjJzLy5ORGbXHB/7bDHrYYHF9dCR6mTRFbpwoCDtMCDWH7qYg7W/TOyPjaeVkkr2CCx4BVRvp0vOHDddPtbW2/3pGUNak8sUw427L02fHeyUXdK0rma4e1acexy68zsT0qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718452169; c=relaxed/simple;
	bh=3XhaBr5mkY7mleQsX1as/ktPZlRxWZ4PXb7zMA4QSKo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxLB/e4xpNiXhociuW2nVvnVO1Lsj4EhCXTf11L/mV1pQPRhTE24SnYa/hsExaQ8ZBoQ18sGMGEbGruVA4/mIzzWBaAOuxK4BxJbFm9UAFU5IXlRytvpdmURW5Q5j+nR5i1Y5mIg/LarCh1kQx/+mvdkiA/IKj15i2vuZ0ddScw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anPGlBHw; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anPGlBHw"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5b2e93fddafso1370159eaf.0
        for <git@vger.kernel.org>; Sat, 15 Jun 2024 04:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718452167; x=1719056967; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tLUPsuVGOfekI2cs7tX1PysqBfzp759kkvL3vuL/Xu8=;
        b=anPGlBHwHM+xYPK+ZtQxzp+vCYi0AuQKjqLmpOqUgs2vmUwleczYpBNknm7P6MELn9
         EwCF6X/M6tN89tjTVhiWvlnQDDp0vVmNKNP+80UyJzixLmcFMzZ2naDXwQDJao5yoM+K
         t/GFRoOKajWWggxjQGYYrDFoazlh/VflJ00DLHCTKxUDG31eDW8FCV9YfdJHw3ZgkfPi
         64J8oWdVhQbDQVD6GawQpPmAzSNcnkDxqLu/tnRoCfFjLbxIPMWlnQjFeUc9E0sxaW+t
         e0GcPnwSBNJx4kNw+O7tyF2eUcf0EtiVXaFk1J3DnMPVRzGqra7Zka1cWs9OS9msS8L2
         UmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718452167; x=1719056967;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tLUPsuVGOfekI2cs7tX1PysqBfzp759kkvL3vuL/Xu8=;
        b=YBqA1aWTAbzyjZdmqUlTt4Y+Ga4tvgTxJxMHd/a9REogI5PuuJZQ2YQ5Lb0s7sdhGg
         04giXq/Tb3EXxCK2cGD7te56NvXL6vGipXUWa2iT6Z0GifRD5CWZmyvDmnjzE0DK3MeD
         RqEmXLIH92gownwWYPjo14M2aVQ4Nsat6NkoK+GWR/ysJC80CxsPagIEeCxwx9/MgM88
         J9RxZnwk8N2CuvoNklAP/CBVoNkBDlhECS8Oq8AYN2E5IjYrVKIUdFWTYTri4jy54Uo4
         LdOi+O2Q75+2XskpIkFI/+oMe6FmNWj5JYQeftJqEC+xWrYjuVJMG1cmV83eACVyLGUE
         hYXg==
X-Forwarded-Encrypted: i=1; AJvYcCVZUBEf6fOmu/Yq5pAvjSBWuymD0jQshshK5/yMuLJHtgv6GdXvoCaoyIi1T5HDgzhkb1fJrwN4YN2ExDh2QkNW/LX/
X-Gm-Message-State: AOJu0YwNgxaa1iUOQw0xQVPrKYZbDOwk6IP0Rd6upiHH8FBC2pnepGIR
	Sg7ucSiwZD/XcjEKQ1QVaCTo17pqLwkLBuztfFku9GiFymHdP4haDJ+uEvHvDnG9Z8xyq9cC5gw
	tNmYRoYIo4DlSXYeStL4D3BZxN5frlACg
X-Google-Smtp-Source: AGHT+IENgsJn9puB6YAj+DVJV/NAPkFDBeclvy0dg3hZ+HHVsH4OXjXWIrRdGyvW36YI2b/SHx9X1dcI+atVqy8PbsI=
X-Received: by 2002:a05:6870:40d1:b0:254:b6f2:de86 with SMTP id
 586e51a60fabf-25840f98c1fmr2657485fac.11.1718452167310; Sat, 15 Jun 2024
 04:49:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 15 Jun 2024 07:49:26 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqjzirdyqm.fsf@gitster.g>
References: <pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com>
 <pull.1726.v3.git.git.1717719428510.gitgitgadget@gmail.com>
 <CAOLa=ZTgP+OwVrT87=og4tVdhsqjErMUJzCuT9bdDatFS=J8hQ@mail.gmail.com>
 <a03cd45e-e4e0-42c7-bb98-b25cac12e42f@gmail.com> <xmqqle38n7hv.fsf@gitster.g>
 <CAOLa=ZT2goTBD6WBtjYOYqa6vEsp=P=UzUBzs-5Om3d9HLZYbw@mail.gmail.com> <xmqqjzirdyqm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 15 Jun 2024 07:49:26 -0400
Message-ID: <CAOLa=ZSJEwha4qc9EOdkLekRAUUUYRxE=aMeu-k3M_7LX2T+SQ@mail.gmail.com>
Subject: Re: [PATCH v3] date: detect underflow/overflow when parsing dates
 with timezone offset
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	darcy via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, darcy <acednes@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000ff214d061aec522b"

--000000000000ff214d061aec522b
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> It's even OK to use a hard coded constant for the number of days
>>> since the epoch to the git-end-of-time ;-)
>>
>> That's why I noted it as a _Nit_, mostly because it wasn't anything big.
>> But I found that part of it being dynamic and part of it being static
>> was inconsistent.
>
> Sure, but it is so tiny thing, we shouldn't waste more time than we
> spend getting the tests right even on 32-bit systems.  We seem to be
> doing the opposite by talking about this part even more, which is a
> bit sad.  Any comments on the actual patch I sent as a follow-up?
>

Agreed! I looked at your patch and it looks good to me, thanks Junio.

--000000000000ff214d061aec522b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b824125dfeb85fdf_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1adGY4UVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meDNlREFDV0dGWHFadVNuLzA1Z1lsTE9iZ3hYa0Z1Sgp4L0xGWFNQbm5R
VFYwWHBKOUF5YVduZS9ESmY4UUJONEFEK0p1d0hlMU1EaXhUYmZHcmdiMEh0TW9aWk5KakxqCmpo
UnF1MFZZSGxBMzd3WEFHUWZZZzhlMjcvYTA4N2JEUStsS0FiWTBLUkYveVJxdEFtSUZjSXVFSGdC
bXdLSVYKWDdFZlU2c1J6ZFJkWVgvbDdjVTdpOE1hOXJUZ3BtblNsSkt6RjRTb0JMRTdUczh4UXBx
R3VwWWkxYXdZcEZkZwo2em5nWjZON1ZRNlN1U1hFaG90VWsrcmVsb1dzcmplM0hjbHJaK1NabXhw
dFZUUVdycTdmcjd3NnBRYitDMkNSClZJdkVvWXBqSWVIMCtabndSeCtBNERNblUyRlVYZFdhVE5j
WnRqNkNyYTA0VmRJVEJqelJGU2UveDdNM3FrTTUKMVo5SXN5NE9GaUxyTk5sMGhjb3B0U2FwN1dq
LzFnNG5tWVZ2dmVVV3dzRjh4QXViQjZOY29wWEJQRjRCcElMeApYdGsvc0hvSjRNWHBrYjdlM1h6
QklJMWMzL1hJQXZVQUR4ZnpsSS9ZQVZhUmJNYkRkeTJPUVdxNUJndTJXaVJRClZ6OEVOMXZjaUFo
U3BQUnVJeHI2b1cvZnFyWldYMWNQUEx0aDE4UT0KPVlYZHcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ff214d061aec522b--
