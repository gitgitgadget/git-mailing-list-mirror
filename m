Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1121D257845
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 08:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207261; cv=none; b=DFR2xgprJJ/ZNMj9ZOv7WTVXfX0Rk6GZ8JOFT8gHhqHhtPSsY2Jd1cXPR4k0sasMfYbTupn/42CeecSdUq6Gu84VBrYqq9VpzCiayh7XAlQMtCcLj3Yff0Cl/qGjuCp/AEYw+9sruBpUBvn3dE0UGy9SEhnUgNLkY4E1owdO8b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207261; c=relaxed/simple;
	bh=fpiuoN31Ap7GtRG3xsKUxsTO0h+/UQe5cnUhKHGRQr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RfisMTxPHsDIrvHpdDVI9ExnFPmWCeocVh3BnoTRRqzFp49NInmPO3sHH49FCZuC/5QRfeIh8Jn291KMXvipuXwkOxDil2/Jwhi3hg5DeToUaPt8t0WxoQ4UYNXQmMWhdjk8DQ3GAFXe0YeJbRSQGbKfBpwpBLDhEvi25/3JRDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LW7TAcce; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW7TAcce"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-794e300e20dso1639891b3a.1
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 01:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761207259; x=1761812059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpiuoN31Ap7GtRG3xsKUxsTO0h+/UQe5cnUhKHGRQr4=;
        b=LW7TAcceySlRdB9wwCTMieAtwesY/vCE+6Lep9Girb++1z4O5rtKh4/WdiSpgZMBfh
         nS9Dbfus4HgGCq4wUK0FxenyM35sv+uNJrLoEXqNFydBBWH/KULHHTKm43FbqBAcoZEk
         H16KL0c3zHi8e+LWCqZIZI3tw6AZOIKJDYw70/fvZqU2Q9q1wcQyAJwcHwFsFTg82ImZ
         2oqTsOnhcqsYUDBIrUkV6ff21osSZd85X38HFwIKdObR3odpoxrMtca81ayhr5OGDYa6
         blxDUqXxI4QjHe1FzWlgEwp2wTQCw31o/HhwoCdOmgU7gLuZjlufCb+zYuJ3Yy4Gjl6A
         emSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761207259; x=1761812059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpiuoN31Ap7GtRG3xsKUxsTO0h+/UQe5cnUhKHGRQr4=;
        b=lB9SUClrGMslktXuuUmcy6Jd86LIEQbKiPSF1ie5Np6xVMzPqywY74SF6bThKuYiWA
         LhI8keGZXPt6UD2WPqwwAPuObAgGlgVFc+nIjhlIBfbioX9Gn3y4TqGMeKGLEyXWBMPP
         ziQ6KbWFUzIksNwbNZnU+X5rbRwzWaRwNJvmdkr+8iGTE7gxpuMZv76AVYOELA7L8jM5
         YufNDEfbR8TLqzhjUs4K2IPhrvOBKEpdsL7gX8pTKphowTCIPuDG8XSWHDSCZudD9gJd
         dowSz4hGi4NIckE/O/Yj3wrG/hfYMLnOyPXFi7PY4ehAdL9YEs12GXUM5CR+oc2vUAVN
         JTtg==
X-Gm-Message-State: AOJu0YwrpGir2FvgR7WSOnyYz7ojtoTff7TuT/o+NnDTknrLuM/09Qk3
	yOE0bgDfKu4GLh9WPJ7HMHOOX3tzdci+TOscGBIDmY3oa4rtRSnhlj/VIi0yC3hfNEUJ1rcLaOY
	JMfn+ElPdkGDtFh3xtpj+h3A04KxkUrg=
X-Gm-Gg: ASbGncuNfk5WyYmnwiIUqsV4mbUfXUmd1e+IxgMvy0XhK1mF5RbwfvAWPgAaJCKoOoM
	Bve6rGfQxduVUc4xpBQ8JTb7Bc+CfHTKiTQ0TSk/hAju+9Qk+rmFOGWr5k7J8l8sf0KsVodECvm
	bWopTnQPSSkfCS2aXmmHMv2IaTTwjWGtyfm6gYZyd45QAMsed/wB2Fr5bloXKehekgv/65xbx86
	txwHjHoeJwECsBlefKfRv2iF3g+naFFSfq5pFxkOvT+Tj9hMcWeq8Th5QBtq5Ex3QNeT7TNZpM=
X-Google-Smtp-Source: AGHT+IF8AWEl2pVccZ2RDykFYOPyDtlabNLfChoPrR/taiB7hm6JCc0avuzRDTyiDwyjbW+D6/2E0m9DUP3r+oNy5f8=
X-Received: by 2002:a17:902:d543:b0:265:62b6:c51a with SMTP id
 d9443c01a7336-2935e0fc471mr43861935ad.23.1761207259276; Thu, 23 Oct 2025
 01:14:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761135129.git.belkid98@gmail.com> <df8fbbd3a50748fd974083b6bbb07ffca91be465.1761135129.git.belkid98@gmail.com>
 <CAP8UFD2GCG5y7c=utQ43M=TfVPSDF0qUUAXH+U2nRpeuKfcW=w@mail.gmail.com>
In-Reply-To: <CAP8UFD2GCG5y7c=utQ43M=TfVPSDF0qUUAXH+U2nRpeuKfcW=w@mail.gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Thu, 23 Oct 2025 09:14:20 +0100
X-Gm-Features: AS18NWDrpTwLrtB1WkYRH8icEh311_d5jaDcslaaQGvQN47u-BBBrWrQv_YVQ98
Message-ID: <CAD=f0L-pmB22DpK7kDr7Oe4iztPeHgbserTqn3=icYVvryVx9w@mail.gmail.com>
Subject: Re: [Outreachy PATCH v5 1/2] gpg-interface: do not use misdesigned strbuf_split*()
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, usmanakinyemi202@gmail.com, 
	kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Oct 2025 at 14:56, Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Oct 22, 2025 at 2:40=E2=80=AFPM Olamide Caleb Bello <belkid98@gma=
il.com> wrote:
> >
> > In get_ssh_finger_print(), the output of the `ssh-keygen` command is
> > put into `fingerprint_stdout` strbuf.
> > The string in `fingerprint_stdout` is then split into up to 3 strbufs
>
> Nit: it's not clear if the first sentence of this commit message is
> part of the same paragraph as the second sentence or not. If you
> reroll this patch, I would suggest making it clearly part of the same
> paragraph like this:
>
> "In get_ssh_finger_print(), the output of the `ssh-keygen` command is
> put into `fingerprint_stdout` strbuf. The string in `fingerprint_stdout` =
is
> then split into up to 3 strbufs using strbuf_split_max(). However..."
>
> Otherwise this patch looks fine to me.
>
> Thanks.

Okay thank you very much

Bello
