Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EAE416842
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791306613; cv=pass; b=mSM77I0vR05gDAeKWerASAQwS6QWvAUtH+c1rFkQbgnU61jrh7b81TLOkGUC3HgcGlsb0xSjeZuphUWzPaDzp2uxIHUadCtlzST21EG/G9OvNHztVZYcAUygCgLpyXIlHDKhFjw75HyX41KuwfAj4KnzeJYSDtBCv6L4RVWED/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791306613; c=relaxed/simple;
	bh=RiFx+I/UyxDAZ0vQnKsRHuR0jhz1MuEFRM8S3Rjyw2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sx9B7qptJs6H8NO9JpwyV+1f+JBeoJ+0QjyE2YWK16aRjqaInilOIJ6Szzp/Nhk1qIzdquNav7ZEb0JiHCP4qxQQpUFcalfKbx40aGGwWCgMuSv7xAudqDKXzzvGFBdS0ImnV6khKGITb8NNt5qkSOBW8MOH/AqKGxby/TjgFZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmQ1NayR; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmQ1NayR"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso595224a12.1
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 10:10:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791306612; cv=none;
        d=google.com; s=arc-20260327;
        b=JEDGVOwxkn6p3MZJvaGw+kbroizzi2VYFOIL427WCUZjlO0rvS1fMNj4Nj1+6swP8L
         +CKCEuCuebgSvGqWUH/kqPU39/7haQfmMpHu84GuQuRi3djfpH1w/jndAIBueQct2V7K
         5tT5YrSyTKim0VBmNo+i1hHzBoKPiB20dubssRNXSCJ14zPniZc+b4G2yf8in6rieGno
         HyFGxVMOS0R77J6VyJXjXmXAlgbVZ6/84NxTi0gnLb+ukanIqALWyIk016b0UnYsS3Ko
         ay9bsWfWgXUcwGiuhzaAF4Vmq+3flFqLpi6m/Ska2P+h2NXr9at67ZqGNlSbnC2zCZAq
         eZtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RiFx+I/UyxDAZ0vQnKsRHuR0jhz1MuEFRM8S3Rjyw2A=;
        fh=hEXyd38UiZswtpv54Ix2zjKNA7LuE6K48WzeXbo5dvc=;
        b=cjwouoJsdsmDNjwvqMaJV0Lz/29KxrNuNs8N+uXE88xzkwUpZrFH/W6OxzxWvuZQbM
         SgBQyUVDNf7dN0YvL+lzdVxrSDclnHjXgoEhfruWnOVliTgjZOAmI42fsbstU+Y1CBpl
         o/WWfmpqPwZiaiW+q/Q+MoBaIqLA9kIyXwoLDfy30AlRcSmUB4Lv9LBhFKvpfOQZJK80
         Ltm4HCQ09nB3x/BL73kAb06MGrnKCa173HGtGqW2B7/NbAIhxmvIFVMxOW3SRenF1uN6
         hYllzoKLosyUCQ77o+i/fvtX66/pFjIdHtnly/XJlH5Ah9XTWDmhppfVtUypalyaoFaV
         JrRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791306612; x=1791911412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RiFx+I/UyxDAZ0vQnKsRHuR0jhz1MuEFRM8S3Rjyw2A=;
        b=UmQ1NayR6GDeb78jVX0XvW1kITiUhGYu8pG+K+9ocUM90MuazO/RaskMEBr1uE4ZII
         7+vJ3ceCqKv4qxPeXA7tPB7hd4r2FU+nXul7Rmn2Cizi4Stzz2WWyTtVc2SYPfls8n2Q
         WK1iNQ7Zn2PhxzyCAev0LB6byg6t6YsSU8z22iprMzwCL9HAuMq7TjSjXGXXEaYljRvT
         rt5IscwsSjQYqR7JvOwz4OyXUFXFfAfU6vrcFIWXOkIYpeF1S6KxAj4AvskTTCMRKgsn
         D56ClE098M3nUO4L6/pR+oJOfzAxxDf+JVwVJYjO+UwkYvKiHTsQ4rUWg15xzjF6cupq
         AghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791306612; x=1791911412;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RiFx+I/UyxDAZ0vQnKsRHuR0jhz1MuEFRM8S3Rjyw2A=;
        b=Rqy15W+dYBIrS//iQBx/tGb1BcT0MMGwYHmFA9oHRVEMOKDRe/Pe9KFxmhG53WTfIv
         81AuemrEEQJl7KiGkk5NSxDj+gdksywyP9RG4mpRjNdPx879lLlq5MpoV/fslN1b+ClX
         kbdntjhwkgGq81yKW4HsYxeu16BdXYMJGxu8/3M1lbJoB3lbK9/OWIWsK7BaOfrVfNJq
         mM8dF46mezL3d5Z01sI0Y4J8pGqLnDRuxXBZs/YUBDbMUuVlMPFpYgSki6a5DcYFOIX/
         JSSlPEka4b165+s++6Lq/D1LBNPVE3ulJtW/2++NPKuLCvgzLmNy4l4iew++iVSggemg
         ttqw==
X-Forwarded-Encrypted: i=1; AKwUvBxJ8fiD3bHCG5vqsJiPlZRGQt19YwwBRo+lp069gQBISjuKXI+keA0ijAisXy2FxoZpyJk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9Gt5fB4cnvzfarSIdn1DQyGgaVBBROXEtHjsKe518d3Hf8HQM
	N0GOGz2+U036+tBTioKc/EFtOB2ENVuzV8BVsHj1aZCnWR5h//K4zPyNkVdi00MJRl6Xz1i+kf2
	ZzLhXp3ZQi2/C6kE7+0xPYYQFtGQTQDg=
X-Gm-Gg: AYBFou0759SvT2uH3MyW8tf7KP897xy55ThehJluxBlFQEAHDFnTKFpf7neUd/L07n9
	o+K+ar29bioT4YiOApwQj9tBhmqW3nBbaodaAoYY38XguTpMxe88GkOPbQbcZmovgQUwNznSYIw
	his3/EjoDBC8YJ0OlgVp97vl12DR+/ls4ztOyJ+MwNDlKMGGetPMF3QfZgP2QXsKyrNv4bRn09v
	wj6sVt5tG5EDN6V1jVeqInjsukK2/RDAjGpxim8wR2b6rNK3nWahj7K0Jboq4ZoizdKXx9fZW9f
	5kuxkrKu0gmlO8SB9fLlcve5owHIkwCV/9tk7Qt/PWwVyaNaG5mmrONiBYgyOs2wIChgknBH5MG
	psQYb0MTn/ATkUgFQwCmf9p8qqlQAHEMEmxNZyip/TYTTQM2sWELK7F6X0I27+LEligVawFeZux
	MoayEYyS453WOlc390g5iQh5ccr3FksA==
X-Received: by 2002:a17:90b:53cb:b0:3a8:6efa:294d with SMTP id
 98e67ed59e1d1-3a873739036mr1036459a91.26.1791306611672; Tue, 06 Oct 2026
 10:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <CALnO6CA_=OsznkQ4iT0vBMWf3L=bmVKMBdk1MTHQdaKEcKwn4g@mail.gmail.com>
 <91396552-f86b-47d7-9805-8f6056c2ed66@app.fastmail.com> <CALnO6CC+h1y=Fu438nm4cd0K-dfPVYq9MqX_+k8fxBU60ot8KA@mail.gmail.com>
 <623cdf71-8076-4967-aff1-3ebeb57d1e3a@app.fastmail.com> <CALnO6CAG-z8B2zXj+QEvZNb-Ufiq=qgyPR5VvQShyH1H_+bgNA@mail.gmail.com>
In-Reply-To: <CALnO6CAG-z8B2zXj+QEvZNb-Ufiq=qgyPR5VvQShyH1H_+bgNA@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 6 Oct 2026 13:09:59 -0400
X-Gm-Features: AclHuK_dG9MbvN5kn775qPGPsT4tVPnV41nLLLWyP9hvF7I6e5IxfIpJbxQTX7Y
Message-ID: <CALnO6CBBL6f-HTVtHOf2TrgYV3SCTLU3Jw8amJ6MTM+DHQ+5TQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] [doc] Add new page on merge conflicts
To: Julia Evans <julia@jvns.ca>
Cc: Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 12:53=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>
> I'd love to hear from others on either changing status output to
> recommend "merge --continue" or admitting that, for merges, "commit"
> is the same thing.

I see now there's a patch in-flight (downside of reading mail oldest
to newest). I'll expect to discuss this particular point there,
thanks!

--=20
D. Ben Knoble
