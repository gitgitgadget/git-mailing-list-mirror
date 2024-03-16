Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0B5393
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 03:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710558306; cv=none; b=buov64GImxPLuQTkDCbcdgoHMnELMWRQIdatLKwuQBl+hxNembC1RIqJkH1E39DPwX2RsGM5cLjaFSYQXxw4KWL9qfsbRab+3sgNuE29MaOZV880D0x1Gx8xq/el0PgoSTBAbGP0dQYvp1Wi/FjtiPKcSK7xhNxwfOmkMEVYUiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710558306; c=relaxed/simple;
	bh=rEpB9clPsfWk07NaL8F3Z+6c1Ue8tsf8kIdpVRZLNNU=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=PjD6YuEw6UNWTAE5m2gZNMPPaa136N+dg/NVovUn0MAnyLpSmTgQkMrNtRwnjZsjU+4eoK4qKiOf125P7ices3YUwzlBZEA512xz3sasTIm+E1YyiXjo2GCuq5mVFOx8cqxySigaZQduUoAlUIa09msMl6putt/ICyafUbwBnXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egyiYyjq; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egyiYyjq"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3669fadea18so4327545ab.0
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 20:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710558303; x=1711163103; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NqB1TOTryob4fYeIZ6lrMAQNoaopJaRZoy/hbwRfb0g=;
        b=egyiYyjq9eB4hzAKoH90x0TXh/9u4rsKZv/JpbA/Yf03Vr+yKqeIInpuqiguoN4DPg
         Hy21vKdXWtLwkqn077Mqf6wUh9aR6MNRSMyd6GL6HA4vm+T/OuiARqrlRD0+rxavShd0
         nkmvl5SwmoP6A8AXeFcHYRhPiuriz1e6lLhczrbBMnW8wSzMMB85qs4Djg0o7XCJBAua
         JUO4Ii2kWi5gMVAm3L8B/dU9Gds4gg9wAYvyCfZmIG6vJEu7KFj66/dHowpNdhBwSx4K
         0yhz7Jb/2ykFR0+WsDjItwv3D3M9AwW6fMG84rtmSAXNr1mp668v49YqwqoTOZ1bcAkM
         JBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710558303; x=1711163103;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqB1TOTryob4fYeIZ6lrMAQNoaopJaRZoy/hbwRfb0g=;
        b=aQjlFQ5DmxMif1wVLU7pe+PgBLTu/7FFr18AABTbaU+XFXw5gtypPcR6ODuymcq8lW
         z2RPrTGCnMGSu1CMELJBKTeouu4KRI3dr6sRnmcwFS5vvO/KPToOnXP1372jNHo1fjs0
         yPAf12dgUMxFwgbUMp4Dtw890mftY2lB7Ps9DnxMWO+DkKTNiF9eqaPmsYU+jaFzKi20
         cWuK5Chvdw5vD4DFznRZgUbZrlHjutyM6wMY+w0EqS5Wsu3Zec9khmhE0FjB33cxNktU
         L+UlK4lEICCtOPcBXbuQjZRBL/JXW3kpHIGEuqXCCV0eaqsI2/kIU832E/QpMkmvKa+O
         DnPw==
X-Gm-Message-State: AOJu0YxBr4oakbaBoDOkrdV8/hayvmB8CZuj3YE5c66ULgF03XLpd2fo
	EfkhERgFTqYiUviyVGAVW3YWc0mmmfGm1NjBcGq7PMinLqcz19lnaBoAusHW
X-Google-Smtp-Source: AGHT+IEBGsTXuFd029euKhL7YxVeIAKHHwW3Kg1TW37hZl19X2n/fRb+XEiUvMIoOgNcHrQFKOFK6A==
X-Received: by 2002:a92:d287:0:b0:366:999b:f9fb with SMTP id p7-20020a92d287000000b00366999bf9fbmr2890017ilp.13.1710558303273;
        Fri, 15 Mar 2024 20:05:03 -0700 (PDT)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id t3-20020a92c0c3000000b00364ec1f92d9sm1063406ilf.9.2024.03.15.20.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 20:05:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
In-Reply-To: <xmqqil1rjdf7.fsf@gitster.g>
Cc: <git@vger.kernel.org>, <newren@gmail.com>, 
	<me@ttaylorr.com>, <phillip.wood123@gmail.com>, 
	"Phillip Wood" <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 4/7] sequencer: treat error reading HEAD as unborn branch
Message-ID: <17bd1fb6986bb4d8.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Sat, 16 Mar 2024 03:05:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


On Tue, Mar 12, 2024 at 5:25=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:

> "Brian Lyles" <brianmlyles@gmail.com> writes:
>=20
>> If I'm understanding you correctly, it sounds like you're hinting at
>> something like this:
>=20
> You may also want to add _READING (I do not know offhand).  Also
> you'd want to make sure resolve_ref_unsafe() returned a plausible
> looking refname (i.e. passes starts_with("refs/heads/").
>=20
> But other than that, yeah, doing these as "extra checks" only after
> we see the primary resolve_ref("HEAD") fails was what I had in mind.
>=20
> Thanks.

Makes sense to me. From reading the documentation for
RESOLVE_REF_READING, I think we do want that as well, and the
starts_with("refs/heads/") check works as expected too. I'll incorporate
those into v4.

--=20
Thank you,
Brian Lyles
