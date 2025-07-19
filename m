Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8AC1FBC8E
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 22:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752962806; cv=none; b=LIx9AZQf1gDZ4cM1GnC2YdX6/QRgC1CQdzlz6G5WWU36S0VIhyP0cP//I30xpLFZPdAjA8xUaeDge7l2AP6bzmIDkp60KrL8JhaueMTI1DQNiUrWrH198s51lfgX9c/eGkoYYUlUh97VGHgMEANWY/rYj+uJmr5Xv9sXWk6OTfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752962806; c=relaxed/simple;
	bh=lZaHU3B76sfs9FG4oJwHXwryGTDZZEIFIclSkj5wvPI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=umnlw7VHO/6RLhLNpNFiBN11ofKSIcce4N+uEtkdA7C1rVWW7X64dWLBdsmuSDKGxQPMHj/m4r7Gz+MmmpvZ44XDaeSOuH5T/6+qPxL5Gef9RPq61cfr8aJnLOtnSjZeQomuRcy21PO9kZfCl4H1dBPkDs7V6rVXl5lfgmpoqX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2IEI5ar; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2IEI5ar"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-886c8de5d90so1775005241.0
        for <git@vger.kernel.org>; Sat, 19 Jul 2025 15:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752962804; x=1753567604; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZaHU3B76sfs9FG4oJwHXwryGTDZZEIFIclSkj5wvPI=;
        b=S2IEI5arqw0Hx899Pz0sNPIq8tnYAWFHh8i//Om+G4hAD+FEpTG6DikDpROwHuK/cG
         WBEwBstABtsiAJUflnlvXCHFNfRfnib/YIdz9jRKb5Fa2jnGvTT3qb4P/IuHdaAjbebS
         K2zQrlo7qKeMK7U8UjWfJlz4kq38SaL2armgAdF1R8go6MsDCccnmt+XQ0qezd812cWF
         gZ3acgR5jt7tyjmJ3rokU6O4EyNkV/nRstwPPd5qrprrhfIV1VODndSnNTAaGuu/7wLd
         qePy+Zi3DHoMx8AL62hGRAHxmcEGSc6uTaS81IcGy6Hsw8T4V7gR1MyNWUocrZ7Us1ER
         eS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752962804; x=1753567604;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZaHU3B76sfs9FG4oJwHXwryGTDZZEIFIclSkj5wvPI=;
        b=urvLS3/LSOYPWLl2LlKJoocozWUhGGoBUB4d74J4LDfpTiD48ZZfkL+thWIHn5Z6uO
         IuUtLND+7G4mg7L18dEjkV7oGdE21vc75AI6/n6y7x4eaATwEmVYNEbydjFLTGCV7Psg
         lf6aGDpqvtPhf5/A+1/u5FcHmNTZBwJTPkxp5MaZqyjD6q1tWvNigD47P07n6jlHUCZ1
         cjJ+hz7vKzxgfZXqvypdlsKyGqIx1y6T/R/e+Hy/Ws3shC4WmoRoc+cbEN7xBGqxEaDo
         ACZb6jgxmjtwhl0/eG6DhU+qUp4ks1OQuzPQdSSuDXYtPQDiT6CKCwQKTvifIllL839v
         HPFg==
X-Gm-Message-State: AOJu0YwvTsTJTa30fyRxSex+m22ZfXIYcgynfRnZ5spjf1725e72J+2g
	nqXeVWVEQ5TIUdVqdQ8e40iTTkQxA0rIimHb+FMS4r5CcYLad/Q/Z8iGQChv5Q==
X-Gm-Gg: ASbGncusTH/DOrcrZlv8DuOKy71SfAsPn/QqbtVNrD2K8aczJg70CDHm7RmGZ31qd/L
	xtYRGtoi/K+emHaMnUv4DlsceD3/iYebcUNOLqOyDLhHhZP2XEP2v1+JGaxLpmjO0XFAkSELe/L
	LpDBFaLFEHDVf6gGTW42Dwc7eBmPzuK4KJ3pJ9OheCUg0iCZeTGTD1vKwkuwtofrPawDq/0yYGC
	yJ4PZ1chXGBcxP6AlB8vVrHfrRZdpzLXqMrfrFfUM3uJtZPJN+dV1zcpbjR/kGzUJPJv70H1X8g
	PJEj2mzPql3SDEqtp4N2A05+WG5CgNecRX+K10rL6yDM4c6EfjRDA2F+ljSUxpIOwdgvWU6f1tV
	MRXRFAxjEC4jet7wxrcbdJHEcCZNpVGjAHMALt2+T1oOgCIWR
X-Google-Smtp-Source: AGHT+IFhxRka7tm1gokR+bJC7F7NH7I5v1mBYY+pOVPT4prrv0kNDM0t3M3mj7kMVRDV14awuNUYxw==
X-Received: by 2002:a05:6122:1806:b0:526:7f3:16e0 with SMTP id 71dfb90a1353d-5373fbb6674mr7657645e0c.1.1752962803630;
        Sat, 19 Jul 2025 15:06:43 -0700 (PDT)
Received: from smtpclient.apple ([179.113.63.169])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-537650880b7sm1664852e0c.31.2025.07.19.15.06.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jul 2025 15:06:43 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: A Question from a Hopeful Future Contributor
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <87y0slp23s.fsf@arch.mail-host-address-is-not-set>
Date: Sat, 19 Jul 2025 19:06:29 -0300
Cc: git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <77CAB8BB-ECA5-46FD-A72D-CD59D96B584C@gmail.com>
References: <87y0slp23s.fsf@arch.mail-host-address-is-not-set>
To: Eric Frederickson <ericfrederickson68@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> Hello everyone,
>=20
> I hope that this message finds you well! I'm a software developer and =
passionate
> git user, and I'd like to try my hand at contributing to the project.

Hi!

The suggestions from Ayush are really helpful. In the last few months I =
helped
some people (a friend and some students from my university) to join the =
Git
community and to send their first patches.

I would start with the microproject. Some of them are really easy, but =
you'll
get familiar with the contribution process (i.e. sending patches, code
conventions, commit conventions, etc).

After that, follow the tutorials for creating a new command =
(MyFirstContribution,
MyFirstObjectWalk). Perhaps you'll find something outdated in them and =
that's=20
another good opportunity to send another patch!

Another good reference is "First steps contributing to Git" [1]. It =
covers
everything that you need to know and to do to get started.

If you aren't familiar with the core concepts of Git (objects, index, =
references,
etc), read the chapter "Git Internals" from Pro Git [2].

I hope it helps you!

[1] https://matheustavares.dev/posts/first-steps-contributing-to-git
[2] https://git-scm.com/book/en/v2/Git-Internals-Plumbing-and-Porcelain

