Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B1538DC75
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143924; cv=pass; b=qRQmnrP7YcG+qUbwcTDfCMYknfEy4qwBMW5ENFTLUIQ8/7I35wCkwaEvbat1YiJY1TtM6tKFh6h3ofbLzuEaDgSlP44hzDBSxoddebVWM7U4h5TywFGpoWLaZ9htte8K+bBak2w/CPRb2opwWDRR12w6oWdvlfQsaktox7kNCMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143924; c=relaxed/simple;
	bh=V4+itDe03Dn70N7z/90ZFCDFpNx96DU2LfNLmpHjIP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rlaeUT78oKNALcTBy1aRTCT7xG0FIdUVyZ0hmL463ku4MIuO+FefBi+jnqSjBQUmbeKthYJUYmniZQYlwbKkN9UUe1LV0xZOE5gM8btJ+2pewO9xuQCdSweKsoEldL5eDnwjMLJWllkGj9KR+1Nvve+8vaSY3/LcNtbacrMDIK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNEoF19j; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNEoF19j"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c350db5a761so57056166b.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 02:45:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792143916; cv=none;
        d=google.com; s=arc-20260327;
        b=Zz9bgtLYp8R3yer6JG9R74lNUq6Qu4uccXSy7F/42Zvui6nOOB3AsgxEJeHuAH524+
         FtShimk5YKVYY9UKV+IZ6NuDkXhn8y9cq4J0Z5059WW/h3g+SESRNSNoO38MG3P8MN0K
         bU/ChQ4FCrQQ9AKcnlEfpB6OOG5faGO5JKjOqMcL2OfmP9LbQlMLhOdOMGDYBQY215rI
         O5H13+73YF2t9cx3ZwO7wRRCrXAqCmLSCfEMjdz6z5ZHkdaN22UsNbEWMoyr0TlMjG2Y
         tFXOqC1J0imtssNe7TUkQuM/84Iq6KMz/IyxpPQJr6pzHOYnV9w2DEJNn1FBlLQcNs2N
         2vPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V4+itDe03Dn70N7z/90ZFCDFpNx96DU2LfNLmpHjIP4=;
        fh=dXzsdpAXkURKkSaAay1GuSc+y62QDUh61rscpEMRfNM=;
        b=KnwJrZc66rTgzZGn9m5SZD40ycbZE4klhx91vqH07nCHUwaHo3DfUBSG6H8T/OYtRe
         TLg8BgS92lTuIxEC87Ts3jbq7c6aphwAujL8IyAPQMs1aMLLGl/Rw3i31+UUHrRX0yh5
         Sy0mYM3pRQja5mTNlHyNkizEoalHU/N6iU2QyHp0ZE6RU56SPXBf5Yr+u/zOu6TYCfnT
         rxlGpziDwiuXOJUzYzTJLs3BsPhm7GmoEPmI2woC6TDrJ+K9CYnqiD1SzVsajr7raNGI
         FtUkRxfGHaLxr3o61AYmDsKd24S1R9q+TctkQe0g4xhXPRSae2dVTSJV5u37NYnvbL7l
         OY8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792143916; x=1792748716; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V4+itDe03Dn70N7z/90ZFCDFpNx96DU2LfNLmpHjIP4=;
        b=QNEoF19jwbrpERAZiLxrxRAEOexALvX8a/yCcEiYd51qbcm4OB3y2lpzggms2cLYRq
         uDrh4eJGuC0J9YWleTjuhOHwxcrTwZXOCh2xVfwXaydIvuyypHsKm7OP33WESQ4lGSoK
         nZNA8HwcE88S/EItiojdxO2EeNvXouC3G3AN1p9ZKoKjdTxPAPrK3hjXaCBqAaY9OcBv
         uOA6OtVomJF6UeLIbQ1YFBj6G7DHOBshXwnKSp3dEct4TkMLdrtc3KmF2oN7WIHdk8hQ
         AW1tRH6iCUczi8+9NtswvSPd7zf78ztN78xw4Xkwtff/1x46B8Lq9xiLfwzjK0+y6+22
         StZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792143916; x=1792748716;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V4+itDe03Dn70N7z/90ZFCDFpNx96DU2LfNLmpHjIP4=;
        b=0zXiEJxT8te7sdJ1Jo050KUuxnr0nJYjgtoclL1ODi9W5XCp+rRcDZFChXhr4gOwDs
         VeaWjw/waXseyISH9tXrz01Wj5XaQFE2LxOADROHkOuHksjJy+tH+XuPdT/rVG3z/nx+
         jyfSMZ/6eI5bnYw4VRTz+TONZAeqlZVYfjm+UizsHTL+/F9e6OpUoPyIEV/kbLIMH7AW
         WvzPm2IZQ2Ye1DpWf199loyRRsW5FHFSMd0nae+iFIPKS7/ycm4xIAbfs8ZqybbdxxbP
         drBDJbcpUNb6yPS3BSZZsvqyK9acN11SNHYM5T+2PzDw8kej2PAolX4PDucFZ0RPj9oN
         g0GA==
X-Gm-Message-State: AFq9FYJqOnMa7788pSduZ9BPOnkITYXLOzc+UP3VnmziLfh+Lr9WZtEj
	c9AZm8aT+PHNWnNAVm8vR/Ag59IIdVg/L+WisLXmNoboShYDT2r2MT/TmSXvXukMf4Nn3w0WXTU
	dwiNc46fdlu22SiR9vsnHvvS2AWLmVhk=
X-Gm-Gg: AYBFou0dBYJ139qvtBQ0Txfu36Yd2gEgjZSlRPyTdQ0nT/27CX/4lJXRf29DivSrVyO
	RbBPQaWzL7CN0wark5116USesQMYoxGjlewttVDr4S3fX2hDUtgS/Iqy+g9oCBRMY1sf0eQ8Mpu
	39e6u3f1Hb69d0tKXsmoS7JE+VSX1nU/X5eyDCHWQIwG+zv4UIvwYtfCJntWNgIRGyc9oRbj6hf
	LR+pOHPgQoCmAGuGqYotDzMcgdZ4jSQ6ySxxabIVYj6TSb8BR+qB8vb57RuCWZKbEXWnQpmDvtX
	lj7rwzDWC0pqdPiwfNqUuBMC6dkvopJmt/WAJPbnrQvu3gB71t0IzVtichpClay1c2L94lFHFkD
	lC9cyn5bpjUIx1Q==
X-Received: by 2002:a17:907:3d52:b0:c26:1648:a076 with SMTP id
 a640c23a62f3a-c31aa0e93bdmr1992365366b.49.1792143915851; Fri, 16 Oct 2026
 02:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKHXE65c9aLYsj_aYqbbkjW_1=7J6iVGTGAZNAWUhU2QaaD7ow@mail.gmail.com>
In-Reply-To: <CAKHXE65c9aLYsj_aYqbbkjW_1=7J6iVGTGAZNAWUhU2QaaD7ow@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Fri, 16 Oct 2026 10:45:04 +0100
X-Gm-Features: AclHuK8lBwA5wV_geDuh7iyExW0JgQx9QGPU9UgD2W01Iy-eK5LkKXzo-f4dciM
Message-ID: <CAPSxiM9_z3gvaCGy2OL=oh_omzwkMhUZJR+BgpM2mT24pz39EQ@mail.gmail.com>
Subject: Re: [Outreachy] - Jane Introduction
To: Jane Irungu <irungujane613@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Hi everyone,
Hello Jane,
>
> My name is Jane Irungu, a software developer from Nairobi, Kenya, and
> I am an Outreachy applicant. I=E2=80=99m interested in the project =E2=80=
=9CReduce
> Git=E2=80=99s global state to enable Git=E2=80=99s libification=E2=80=9D =
and would like to
> start contributing.
Nice meeting you Jane and thanks for your interest in the Git project.
>
> I have written C in a university project and I am comfortable with the
> command line and shell scripting. I am new to Git=E2=80=99s codebase and =
to
> contributing through patches on the mailing list.
Great.
>
> So far I have read MyFirstContribution. I would appreciate any advice
> on good first steps or a suitable microproject to start with.
When sending patches, I will advise you to send you to cc the mentors.
You can go through all the previous mentor/Git contributor comments on
other applicants patches. All other things you need to know are on the
Outreachy Git landing page.
>
> Thank you.
>
> Kind regards,
> Jane Irungu.
>
Thanks.

Usman.
