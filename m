Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EFAA48
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707770113; cv=none; b=R6P8LmQtqARJiUydnVhoxB8qfvinMOJwYtsx/HmpgZzJOVp0en/pJZ6bEYOOvH8btoh/R7CkhUF5Z//mhq49H45dRcNhG1Ywuxof1T6R2hiVy6Daq4ESVslHsDF8LkFiK6d9MIe7ea4CB2LpmXduV833UIsZDxbyGjpZUNGCVDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707770113; c=relaxed/simple;
	bh=i2irk7X6xlHk3imfxL8UvUzJ+S9YmXzx4VWAWqaBZys=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TyF0WrU1AhEKQ6Xo4/fcLTHAPauExC23J3I0g/d07H5KScP2a5cCgTRez5sOAptBHliUIJIH84AebTSvkatThljBNMSIO5cmySNZ6cnUkOWKDVtXO8OAySfV1eQlWQBHxFs8FLMRB7z4yz+WUQp6J/ckvClUviVhDzvEemM05cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=M5lU6lbB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="M5lU6lbB"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a28a6cef709so489074666b.1
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 12:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1707770110; x=1708374910; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i2irk7X6xlHk3imfxL8UvUzJ+S9YmXzx4VWAWqaBZys=;
        b=M5lU6lbBlfB/KdedylcDVUAdxJW1eAec77VbA4OGrX3gW//NNWp8xYHrsD/ZikLHaM
         fKDscGwl9MhynQbKvjgViDAp2rR2ATP2UTtYK51dRHotnlZrltbd4HN5BXmL2fC3Vpww
         AFO8KLf1rwuXArmW35R33ScR6FJ2jcNiq19ffr/ZlAj9xxMGInbr/W+qs52VWauAA4y/
         EAob6UUEnznGhq6s00GsERWo0w9vJzqVnRbO5tlRfFJDewfa9gQzQKs8voI4pVBOnLyt
         X4S+UMB4dxBkYZdR+anJDrPdvL6hN3tEYhcOwMbLmoke3V6Ftwc3zej40mQDBLZc1KTt
         5+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707770110; x=1708374910;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i2irk7X6xlHk3imfxL8UvUzJ+S9YmXzx4VWAWqaBZys=;
        b=O7G11CDmrf9wxACxeInCNfiCMk5bu+kb6cyUXkgOyjuppw/7OD3V5QgyL1QsFPc2R2
         zAnzkvmUuKIWIl9QcgRgEjXE/U0Vu+Py+fTA5huBLnBrRGFqLgyz+avoKMZZbIovhXGg
         2o8moEnNcvZySRG/lx+OFzcaMsg5aigJMrq+PtpCucGs1JovgfJVrJkASsRuEHL3xO19
         ydrNpDXuoF0Q5RhPAwGZX0MYYfDnEPMQvsWFz36Lb/48l0dlw8iZrjjAGWf8VSJj+Bru
         1d+DaYYoJFIKetLsnqRiyYoXC58x7ejQo87mpN7bHKjUTH0RPMHwRZc4DrC1hoYBxvqm
         qWBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDUkaIQS4dlaTbBjQeDsOPMjq0NCdMaY4fjNW0KJachslEfGNCYtZToK2fIVwRJnFWlEVJb1DEAsQei6YwYS7xo6Vy
X-Gm-Message-State: AOJu0YyARV/zisvuQ0yttaKo9TCCapIDwMlGVcWpZDSQntyCQEfMZDT/
	Qsaa884iqdUlmalJQqX9L3tnlEjqLwLYjEF8Lm4DGXA=
X-Google-Smtp-Source: AGHT+IFhPmgER1HcA5EjnTGdWjt9RVplaO7Optk1M3gid4osyKNzTaeVbPFRZt/gDihYXv//rDHUvA==
X-Received: by 2002:a17:906:4f0b:b0:a3c:bd59:ca2f with SMTP id t11-20020a1709064f0b00b00a3cbd59ca2fmr1950672eju.38.1707770110305;
        Mon, 12 Feb 2024 12:35:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVSAsfvP6g9JKiv4N1ucpvxe3PiDSzFaRpFyVoTHbmiD6Iq/kGMw1XUCaBjkVTJ0AFTovWez6j5QAgCsk2HZ7Sg3E/dDWUAM93aLJYMZk+RhsoCMkBDKg==
Received: from ?IPv6:2a01:c23:954a:f200:cbd8:d105:8084:6a9b? (dynamic-2a01-0c23-954a-f200-cbd8-d105-8084-6a9b.c23.pool.telefonica.de. [2a01:c23:954a:f200:cbd8:d105:8084:6a9b])
        by smtp.gmail.com with ESMTPSA id fj9-20020a1709069c8900b00a3cf9115dbdsm8143ejc.33.2024.02.12.12.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 12:35:10 -0800 (PST)
Message-ID: <eb122f205692ef4848e3adf792d67067bb52dd1c.camel@googlemail.com>
Subject: Re: git-gui desktop launcher
From: Tobias Boesch <tobias.boesch@googlemail.com>
To: Dragan Simic <dsimic@manjaro.org>, Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Date: Mon, 12 Feb 2024 21:35:09 +0100
In-Reply-To: <c6be276bfc3c219e1a0ca1619f56c165@manjaro.org>
References: <beeab03c564e94861ab339d26c4e135b879a1ccd.camel@googlemail.com>
	 <ZcFhNPRprfMqeRu1@tapette.crustytoothpaste.net>
	 <xmqqle7xh1hc.fsf@gitster.g> <c6be276bfc3c219e1a0ca1619f56c165@manjaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-06 at 20:12 +0100, Dragan Simic wrote:
>=20
> AFAICT, Linux distributions provided their own version(s) of the
> .desktop file.=C2=A0 Perhaps the version provided by Fedora [1] could be
> consulted, for example, to see what's already expected there, and
> to provide parity in the version supplied by us.
>=20
> [1]=20
> https://koji.fedoraproject.org/koji/fileinfo?rpmID=3D37302272&filename=3D=
git-gui.desktop

The file contents of the fedora desktop launcher is here:
/home/tobiasb/.local/share/applications/git gui.desktop

It differs
- in the program name. "Git GUI" instead of "Git Gui".
- It leaves out the "portable" in the description ;-).
- I has no option to be launched from a location in file browser (open
with...)

I will adopt mine to match their file as good as possible.
