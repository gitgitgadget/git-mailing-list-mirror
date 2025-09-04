Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C40A2D73B3
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757029200; cv=none; b=V6haq/0+AyS44orM1z5jQYYjD3G5wjyf6UcCJNeS6aDHcwu0QrUiYG9lyXTW4YB8rg+DNXZmbttUJxz85FNaB66bYwOcYXXfkiRh3MXMzXjJ0lLsDgBc/W9QZpEdiSYYrUESgL8Z3vobVCfDezA87m3T9Cukfs0KeujtHfOGNzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757029200; c=relaxed/simple;
	bh=vFO/yJN8RtChGm7WvPGMSfCI3FqkzqTYJkyyLd9TySE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3zcDCYYb8/GB3NIu/wLXhclDNVfsbYvknpghc6WyFoeCYQ7tk2CuEhklFcQlSwlaZ/R4emSffxuYfIvQR+c0bUSlEztkjhU0qtF1dZroFoA1mBEDm2ni+ZqXADyuQ4sXL8JkepxacesFcSVvCmrcUH8JZBNr+3QcNxB+G2LiU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lReODY2K; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lReODY2K"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3381df3b950so4609551fa.0
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 16:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757029197; x=1757633997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dlmxNudCh/MFw+sxcsYXJdjvwJxLJWbhGKO74LPyL4=;
        b=lReODY2KHZfb/peg9CtKTedTPx/mnWzmin+jgiOIsKeKYJEIup8xdNLtn3zWXkPRaA
         mkPdP+hSifxYYBddApczaQXWyscf0p6LSBDM8pvHyUVa9lZoPn9IO0g3R73a7Bht+PAj
         txxlg0stxzSnP54R6aggA2giGBjrTLEeV0YcMu3ITwrOreNPSPshHzjti4Ibqw0PmFoK
         b1H3rOBEPsnp2F+ENUO34pjyZCWa+ytWRQLsMhYUIXiT4N6cM0wazTkjEM8ZFU13kRjD
         32kWFh/fOh1XheQ65ooJr3JrDik2LK+/K3NIncELzwEEkt470rScWA5Pn2WYXxWoVV1D
         qXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757029197; x=1757633997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dlmxNudCh/MFw+sxcsYXJdjvwJxLJWbhGKO74LPyL4=;
        b=bRTrw2m+QAkITlxlXDdJR7ENkuY92B6z+viAdHm+FAMM/k81o23HOAAWVB3ylsdC4e
         yGsN6a52HF/oI+nrB153JAbHW7giUXyymiiy5XmTXFOCqYD9btm4nm5SVY/GqBaaYl9X
         Dm7jopJgFbPsz4FVmr0YKi8R5oLzEEYZQ+OyBHSDFHXejBBMzXu25mflwaS9pjIdt0N3
         MNs9sgTOWWZKv5nZf2ZE5y1smpV5YCfnLvHeQj1HLPS7ALdeNNud4uIVt3ysy1WaQkT+
         vharYuuOAI/Sfa1zhbtLJVGnE2r38GNRY6IEOA3ZBgIDQClhO5q8MTDOPe0Uw0jzuFms
         hP/A==
X-Gm-Message-State: AOJu0YzWujg68O/KRtWvbQhF8wpi73RyRbp6vpfYaMbzVD8jtU0/as4H
	G8EYCBJK786oYVgeeROl3Hm0fNXdKEXusb7lre0TD7XZr3L7tK2dbxG4sOyUjUPrZ7y9Tb5ZSI+
	BnqyfnWwWFsX3SmuXFKPFqfqwe9DntRQ=
X-Gm-Gg: ASbGnctEZBllllxq2E8EnLHkhuvqtHlXK4Zf5aT+Q/a1+5E6hTApdt35i2qQIxKn2BC
	X+GSwBwIkExddPu/N1luKAWAlBJx2Pk+7N6nXY5MxUAHkc7+cRTJs+hrgtpaVGCeMqj85tzm7xg
	Su7+wk+CJICU+u8RwrZcEbmL/5pMtB/6TTafbsPsLh2cWK/gNXtYJHAwqNrUww30LSJrqeuv/2P
	xB2J1Jlu9genHCb52loN3RpA3Gkfg==
X-Google-Smtp-Source: AGHT+IFhv4IoSDQsq5pKt1CKj5tKUgH4pYch7HLubzK5+Kas3zJgvuasztYhWs7cHH21ViJ4USzXqHHpgT8lbdw+fZ0=
X-Received: by 2002:a2e:bc26:0:b0:336:dec9:38bb with SMTP id
 38308e7fff4ca-336dec94354mr45333091fa.0.1757029196950; Thu, 04 Sep 2025
 16:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im> <20250904-b4-pks-rust-breaking-change-v1-2-3af1d25e0be9@pks.im>
In-Reply-To: <20250904-b4-pks-rust-breaking-change-v1-2-3af1d25e0be9@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 4 Sep 2025 17:39:45 -0600
X-Gm-Features: Ac12FXx2ceMUaDoBVE32I3yXFytsOe0wZsX5Syx9Q2xlm1IVdwtxrcMamDzVUj0
Message-ID: <CAH=ZcbANoa8Qjbz4OmdZatBi5b+RQVnatF+7pmffA4SQh=EFCw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] rust: implement a test balloon via the "varint" subsystem
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Ben Knoble <ben.knoble@gmail.com>, 
	Christian Brabandt <cb@256bit.org>, Collin Funk <collin.funk1@gmail.com>, 
	Eli Schwartz <eschwartz@gentoo.org>, Elijah Newren <newren@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Sam James <sam@gentoo.org>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 8:27=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> Implement a trivial test balloon for our Rust build infrastructure by
> reimplementing the "varint.c" subsystem in Rust. This subsystem is
> chosen because it is trivial to convert and because it doesn't have any
> dependencies to other components of Git.

Huh, I thought Meson couldn't run Rust tests. It's refreshing to see
someone else try a different approach on bringing Rust to Git.

There are a few reasons why I picked Cargo instead of Meson to build Rust:
  1. Needs to work with make.
  2. I've heard that using crates in Meson is quite painful.
  3. My understanding is that someday in the distant future Rust will
supplant C in Git.
  3. The IDE RustRover only understands Cargo.

As I mentioned in another thread: The reason why I made Rust a hard
dependency is because it's easier to develop and talk about that way.
I'm open to suggestions on how to make Rust optional.
