Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1B23B8D74
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765054975; cv=none; b=ZiBrrQycAINj+C9Ys/UR/QX0uo2dqaJxvXYyV8viwQn//nR68+G8rAwI2D1GKD0Ym2yixBqRPMTfpgr8hBZ0l7/MoBRlUa23VDOuu75oXSTYLZINHRWklCGza9E7K86h7qnFfAB1p0fXmdRvrAVSHJupypMz+YU9+4mVNZrEM30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765054975; c=relaxed/simple;
	bh=473UIHV7xyiOtB5czztD5t0Mlw6l9RSTN3PdyRqgf7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgrwdCHFRkD5SCWheUFvVkwEql2E288F44Ww9IgmR+uF547jhsPFaxz46Vu0Myry1HC+cDTFx9G6D0Mk+iUdCoOpjhIEPqKz5pb5HZptdVTZNooYmmeauaHeAvAErGMI2jeD2/D/B3kl0iJ2acRnzonshwJZdGp/4UpWViMBlV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYh2teMt; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYh2teMt"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-640b06fa959so5378398a12.3
        for <git@vger.kernel.org>; Sat, 06 Dec 2025 13:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765054971; x=1765659771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=473UIHV7xyiOtB5czztD5t0Mlw6l9RSTN3PdyRqgf7Q=;
        b=lYh2teMt6VOHW5vQ3etedsMI/jLvYiP3Q6CEjuLjNfGROSfxrvrMmk59w/I7grpQjC
         vaptDl3wPNAVyrFxu1tawjKv1b/Jsb4k+le2ltorYc6hDiXwp4cJD0J0ATV2tszHGrQ1
         W/JooR5Iu2OmMfyq/qNy3mvKpMrKWpWxewO9pY6tQZi6rNkY3Xm5kH9UoYMKY2Up+j/h
         +rQKF/WRR09zl3FaCPtt1kCY/M8rFTmYhs+jnKyG8fchDTUvTSEad6jZfCifdPYcfRVT
         +gHrzzTTfvaDoC4VhZw80x8Msr5LGcfrzv88MGz7NxdG0xXJBlky/TLPdM22SXIQC6OZ
         J2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765054971; x=1765659771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=473UIHV7xyiOtB5czztD5t0Mlw6l9RSTN3PdyRqgf7Q=;
        b=nwxvag7tbRD4vvf7K5A6XRpbuXblXIzSAwIFy7WiRqNcHUD9ZreyX4v1vXfDdUdcHG
         sUZch6jwjTLnwmDWJU3A+aLG5YWjrPbpqSoQYlolW+BUaapK0u3StOQBYuVSVMRG3fEM
         PKdhRuLcOQIIZxdDezPUk8K0eXr3+0SMOcXTbENQ0NUP67VDIHvTHJpAHJtl+7oQ6Bv1
         Et2bIxeJw6D33EmuZVwyrmSXnz6RykOTy/M1m5CM3QaJrrLPujcRd8/P14Vfeu9SAxnn
         GYGj+znFZN952rcgqW9tQWGnXP9ONGQIm+qLCsKv8RRuFVqFyi6P6wlcGFB9wcwwoMHp
         JPog==
X-Forwarded-Encrypted: i=1; AJvYcCXa4eOpwHvabZh6i3aZH0awdwFrh+W095P7nK7uHu2wNZVTtmdhkbd51ksfutP2LX3zAiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVF5pfE3OOBp9XtG721kCh2jWyX2RL+xu7HRF8C6f8+h+qHkA0
	vPuEam3W4fN7gS1nzscSMdB4QMMtNATgD5sYnIgIO2oiyY1//lmgRyUE4Q9mH8xu3dLsuzwkO40
	2KTu224ii+masoL1V0+NCLOyYVsXTt0A=
X-Gm-Gg: ASbGncuXSOPQ8MKamnn5OmhRmTHsmiC82Lr3VD+/Czixv3VjiGcmGTn1N3fMYByoNC6
	z+tIvmuZBp5c+anYHrHsniXXvSfGy9KtcZUPpsn3vSQj3Bj6GZNSR/ho4VT74nDFyvY7vCYfO5J
	+zzrew1mbWwOFPi9GcsUV/PP7lNdfd4RB4w7zkVwEIlgi3WyIxSEd9U5vvAsyuKXY/syht04FVj
	A7/mKtLvcOnxwKDZUxkFuoBsyoNVJN+XWdBBnNIU50NhYXos7/PWAjHIE2JfQXBFNu6DZjyCSOM
	IN77oauUFcBunM0v0zzoQD/GFL+v9BhUtzj5HMggBHQ++/nAQNmpzEYX
X-Google-Smtp-Source: AGHT+IEcBHPD0FQkTxysxAvr0M7UyTLCBFCGqyRF8ppfah6QgfNeSadEEpUor9Brb8ejCHb3crTEKPkdGyK/rVHsOvE=
X-Received: by 2002:a05:6402:26cc:b0:640:ff5f:47a8 with SMTP id
 4fb4d7f45d1cf-6491a3d62demr2871589a12.8.1765054970866; Sat, 06 Dec 2025
 13:02:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aTMNdQ_NHTVPtwG8@air> <be503e5e-43e7-41e3-afbe-265cd3da0636@web.de>
 <aTR6Ky7Nq32uj4_5@air>
In-Reply-To: <aTR6Ky7Nq32uj4_5@air>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 6 Dec 2025 22:02:39 +0100
X-Gm-Features: AQt7F2q6SM7rHuUHm_TDQzPICeHbFKzC7WpPqSG4zTuj9M4AyyYgLI5CKKfSXwc
Message-ID: <CAP8UFD3Ta5jdC7uU83iqT9+ZYEb2-CFkUWanAGQtD6fARmxG-Q@mail.gmail.com>
Subject: Re: Git for structured data
To: Cedric Sodhi <manday@openmail.cc>
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 6, 2025 at 7:48=E2=80=AFPM Cedric Sodhi <manday@openmail.cc> wr=
ote:

> Hello and thank you for the two suggestions. I've read up on them and cam=
e to the following understanding. But first, I would like to mention that b=
y "data" that needs to be versioned, I was not referring to binary (opaque)=
 data, but rather exactly the type of data which Git currently manages ("so=
urce code", in a sense); but in a structured form. Think text or sourcecode=
 fragments in an SQL database.

Not sure it's what you are looking for but https://fossil-scm.org
stores its content in an SQLite database.
