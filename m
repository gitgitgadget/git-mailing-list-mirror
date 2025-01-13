Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FAA24023A
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736787076; cv=none; b=T8BKZx1hZOmWBJmDht3Zz0Kp5A7/6zXPu/tSjfAmdEVyqlYHS4h80nBpSGyCS4wSqqq9jGXvpPAiwBX6XUOzSycYJWivQ6FxuXpF+ejVs8bw9c8SPMoOFza6yIfx9PvxkSyiwK8dd6wi6klZsEyLdt5V+K18QTXD+4xK0EorHEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736787076; c=relaxed/simple;
	bh=ru7Kz13SD+qNuJ2rGfbm9G0RQ2hkVDMVqav2GFrGz+U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=W+iuSp/wJOYvWXsy5Hk5jACYiMZKBFhxktQKvpZKnasPIpkHsUy9zitgWsHZ2cm9Y5f9sGKS3ngA4VieyfwwYjnBVNHosrqO32gBXDLBnW8ln7uFwqOCDWDy36AaUkB7woxQDfk71+afA91fh/xuyvtXBdTt1g8PPBAIGIHyuW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=me3iphS3; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="me3iphS3"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5f321876499so2207727eaf.1
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 08:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736787074; x=1737391874; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNCytGlNFHLr9ys/fFeVsy42x3gAMQXob2gTcWtT1IY=;
        b=me3iphS3bQQoAvbjgt8hSV7Q8nro6+qPZR5eSVxe2viDltnhRz1sb73Gd9+19qIEwH
         37eGj3kappMpN9zyxofeJu5/Edt4BN487K9vchBHHNHlCmSA+jWdtXhovh3CNJG/NrQ7
         0zAYpwl9lLhnb+IWXHFtZkO5sQeOoiG0daDk3Jhf7PD0xhF3Z3fjH9Vu5JGyEEB3o6mw
         Wwu5LGjm/TxmtyXgv0ompLuvXd0amxl31tvW7XrhIIbQNFOq7WfSHdMWkgiq14N6+QL7
         JCxDP3dfEs7bVlEtr9MHo9ASCLecsaKV3F7eticQwO7pAA69ALhsdTIwFGpshT0WKdh2
         k0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736787074; x=1737391874;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNCytGlNFHLr9ys/fFeVsy42x3gAMQXob2gTcWtT1IY=;
        b=TgFLL/LaXMMRHdemtGiYzymJYWkvXSfEYZmaUHZqT0/vb9zHDbV9uwtbC5yTDL3njN
         Ygwy8J2xWBc7Ic4XkcEUtAccNxlbwOM5GWxDa7gwHWrVrcfXH9F3r7KRpNKgWYIWZwue
         v8O9Qz797L66++pVosJeyprrreESkQG6RhJHxI6OstMlCm2eC6Fdmn5rvpwJHArjA/CP
         dHV+gNG0Ju7+l8f8d22/1VIY5VcMYddB7PMRjPSzYptoK4RBbr54aU8fh6qUWInsHJn3
         9Rx0VZxco9+2uby0Psug96mrRpnhj8wKbRQ1Yjx7FtqJVCaBinlZabsu1pDwTkd6bhcI
         IHfQ==
X-Gm-Message-State: AOJu0YxAjRRkLlSPP9F87tZAZsM54fec7tEnPK+F2yXjTIEUV/AsYWol
	xX36+ZY+yAXEj0IlwlaaPid52lKbRFk7jsQ/3W1mqMA6qXINxJqHehBYIg==
X-Gm-Gg: ASbGncsGlJq31648caHvCzqWTacbNqfpC21knWC6Ol8GcgALzmnundrd3ZBnFZQdjTV
	HpgUXHAcfmAJPerEG7u5GC61iTPTT5SDrEn7mrkmSMN+RXrVdg4XAgfcG4Y//xsvTGX1zIZygCv
	oHV/Dp+WsTygoWUteKvI77I3tkWLfuuxJh53jsO+pbGkhAkNhl7Si36nw9Aa0P6ns/JCt14sgpY
	ObN/NRqSjCnK0JswUSn4QDxcx16J1mQ5rowOInPZ9IJ2yDe6i6t8Y7eyrRINmGSorqhb4GXlTAJ
	YHTk
X-Google-Smtp-Source: AGHT+IFq0cDcse+LW/42hhW4Yb25Ha1t46hlrpNMVN9RNDc+FSRMgv6FjHIf2nD1KrABZ2kVPbrC6Q==
X-Received: by 2002:a4a:e842:0:b0:5f2:b632:7e83 with SMTP id 006d021491bc7-5f880d1d425mr11462870eaf.2.1736787073992;
        Mon, 13 Jan 2025 08:51:13 -0800 (PST)
Received: from smtpclient.apple ([189.122.187.57])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7231861c038sm3672392a34.58.2025.01.13.08.51.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jan 2025 08:51:13 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: Bug report - Apple git
From: =?utf-8?Q?Andr=C3=A9_de_Castro?= <aramosdecastro@gmail.com>
In-Reply-To: <B50229FA-0C33-4DFD-B8D9-79F30D616F86@gmail.com>
Date: Mon, 13 Jan 2025 13:50:59 -0300
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4B31DB8A-E74B-41FF-9C53-7A877D135489@gmail.com>
References: <C2871318-4745-4481-9199-72D4544ECD5C@gmail.com>
 <5aae11ba-b283-4d04-9336-31d02ff41c93@app.fastmail.com>
 <B50229FA-0C33-4DFD-B8D9-79F30D616F86@gmail.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: Apple Mail (2.3826.300.87.4.3)


> This works for me on version 2.48.0.  It seems to have been fixed in
> 2.43.0.  You would have to update to a newer version.
>=20
> It looks like it was fixed in 4adceb5a299 (diff: fix --merge-base with
> annotated tags, 2023-10-01).[1]  The intent of the error message was =
to
> disallow non-commit-ish like trees:
>=20
>    v2.48.0^{tree}
>=20
> But it also rejected annotated tags instead of peeling them.
>=20
> =F0=9F=94=97 1: =
https://lore.kernel.org/git/20231001151845.3621551-1-hi@alyssa.is/


Indeed it works here with the homebrew version (2.48.0).

Thank you for the quick reply.

> Hm, I don't think that this group/mailing list takes responsibility
> for binaries shipped by companies.
>=20
> If you want, you can compile Git yourself to be "on par" with
> what you find under other OS.
> That is the good thing with open source - please let us know,
> if help is needed.


I was unsure whether this was the right place to post. Thanks for the =
tip.

Andr=C3=A9 de Castro=
