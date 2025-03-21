Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ECF33F6
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 07:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742540449; cv=none; b=FXUQvewyoqdLpIuXImFBL0vVin9/r3JFmrizUHRPkRoMrF6KpuLeXUOnL7DwYi1ZLpO/fdc0E03bZIREg/8CBvAy4RPGcxeYKnqQrQNdTqV80NGRQPJFoPJYpC2W2BZxQ+/kHP1b7YFXRrhwxRsRWl7GgbTFlevo4ywmdMpNC24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742540449; c=relaxed/simple;
	bh=WUJTOAYuw3EYHwKjIT3fWMWEcQ9SbmgT6MusL440UQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txFZKJc0I3sXw6RvLBEfbc9lr6Z9J26eCIXp2C+kTFsyswnVWC5KrX93a5DyfODU1V2B03CnQxVqAbNpdLgH+T76jca4HoN9/YQSQacRVXKAtIgqYQKse+ZSbd0HYRJ2yDWST84+kbtFT+oIsmplC5DsEtBCC36WSEZu4ZzASvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5jkm21G; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5jkm21G"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-523dc190f95so912575e0c.1
        for <git@vger.kernel.org>; Fri, 21 Mar 2025 00:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742540447; x=1743145247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jX++onmaPwgTT0fVb4GVHwjhmtViJIo3ev2+QF2W+Ls=;
        b=B5jkm21G8zCguc21stTx1tJcW0yZT2/ugbJ/p5gBpF3aEAADe2MWxsKxjBhZDr7+GQ
         y9hbpsWsXOHD9OZu4NdwE5MECcbEK9qIcsBQtqgZzqDkzMcofAdb1iKvmTLdNummuYBO
         Yj+up1lR2+2fqiEB4S3vfgNdH0pMnO/652PqgRL85xg1H6NHdJCL+zzzUw9OcaUuKMdz
         QVY/oOcFFFy9GaEFwONDq2PrhXgENYEoSpOcLYHze+LW8FE7ike95BNRFHMxeWRHfYc7
         v16kgPUtlm2MFisWo83EldA39jRFkAvJJBtbHtDaxMv8V/7KwaghHjgCE7qrxXoON6FV
         rRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742540447; x=1743145247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jX++onmaPwgTT0fVb4GVHwjhmtViJIo3ev2+QF2W+Ls=;
        b=v7ojY1XHQASnfyrOByflP7wUUzFXhg09VvXFTyhxugQ9AKJEwJSMdkQPNo12y2hayB
         E1OyUfy6AeM2kO0sIfPD8yx3aXwJwUqkdiCfbq7eZ6ItRD4Fz+wXL//AtEmF2T3lFi4D
         7BpqYXDMiRSQhiZgkyACBuZRmZhUlRip5NAbIiSw8pUK4OnUToRkL/Ss82J2P2PZi5xr
         89AmMs8V+EBnfTpYilzt6/S3IMOcaUDJc45pO4Dhh3QTuRyb8qeDe1SxgKXApz12Bp61
         DA4RmD7ZwedjKThrgtV9oZnM70YRpz+w9rwPxegnDxN6kvnT3gs0P7JyJY2MGAeIcMdK
         3/ig==
X-Gm-Message-State: AOJu0Yz8bnFrk4lftzauahNDMN6YnzdlVtJ3U5iGZhHMd7pJLvn1DgDn
	MV3/CtP/p6KfVF9i3PRx2Azxr3C1bNEnp/4PmNannZaD4ancML7CncCjGa2jym5u2mK0aHr+BGv
	G+30v0r+6seSQlHQtIxCmfjTaazw=
X-Gm-Gg: ASbGnct+PCEsff70YPLp1giMZ69F2D2r7mEVpI342CV2xzsFiRLvlR2xKj87EoLzR8X
	oh5ngwhvvNuooUXbdv3iB9S3AufX/FiiWoX6X+wUbasO7TMNpeBHNOzz3zAA1pCOvwE2SvhFIBe
	BeV+/Qhv3mXYnwANcK4nnS2tnNKA==
X-Google-Smtp-Source: AGHT+IGE1LMPEr9TscwoKA3mlAKBL3FQifMgF3E8jiUBfvfhuz++kComZ/wmGyTGeuOOulOGq2U8Mb8wkiLcdC7tikQ=
X-Received: by 2002:a05:6122:88c:b0:520:60c2:3f1 with SMTP id
 71dfb90a1353d-525a80d0547mr1573306e0c.0.1742540446816; Fri, 21 Mar 2025
 00:00:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318115912.2978992-1-usmanakinyemi202@gmail.com>
 <20250318115912.2978992-10-usmanakinyemi202@gmail.com> <Z9vCCfZJBsyp8Y3-@pks.im>
In-Reply-To: <Z9vCCfZJBsyp8Y3-@pks.im>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Fri, 21 Mar 2025 12:30:35 +0530
X-Gm-Features: AQ5f1JqrKntW3Np46nglxJ6XBLkQVOptd_tGT8GzdmfdMfdDIey65qoMGUXK2X8
Message-ID: <CAPSxiM8i=BRsn=7E5e28T1HndebefzrE8nuwZ0CdN+P+YymV4w@mail.gmail.com>
Subject: Re: [PATCH 9/9] builtin/update-server-info: remove unnecessary if statement
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com, 
	johncai86@gmail.com, me@ttaylorr.com, phillip.wood123@gmail.com, 
	shejialuo@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 12:51=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Tue, Mar 18, 2025 at 05:29:01PM +0530, Usman Akinyemi wrote:
> > Since we already teach the `repo_config()` to allow `repo`
> > to be NULL, no need to check if `repo` is NULL before calling
> > `repo_config()`.
>
> I think it would be preferable to reorder this patch so that it comes
> immediately after the one where you adapt `repo_config()`.
>
> We also have a couple of additional sites where we call the function
> conditionally:
>
>   - builtin/add.c
>   - builtin/difftool.c
>   - builtin/update-server-info.c
>
> It would probably make sense to also adapt those.

Yeah, it has caused a little confusion. Maybe, let's just ignore this
patch series.

The other series which introduces the first 8 patches of this has been
marked to be merged to master. I will resend the 9th patch(
builtin/update-server-info.c) then other functions like difftool.

Thank you.
>
> Patrick
