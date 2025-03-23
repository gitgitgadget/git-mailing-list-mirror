Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD8F2E337D
	for <git@vger.kernel.org>; Sun, 23 Mar 2025 01:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742694423; cv=none; b=umj/NXzz+N27fjOClrg0RguqNqXxjl+G2Z28U9RET5fPPW0CqckBOBr0pHbpXHPXOyoq85Y+a45aTjSW1PHyPsIAxDMTSpWEKaGL1s/BH1j+GUvDdx2b2hq1J1PBgnvZjMiKuaUU2HepcxVTAs0ropZn8JJtVQRMsqHqQr+Bgls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742694423; c=relaxed/simple;
	bh=WobnLaUfwLF8TtQsrqmyAutFrEDGxsBi6O5r0hoe/lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMsjXdZcDlr4mFS6fFKl97s/PuEyf47gudERyya/6PTAGHh+j/8/UpbsbZRumiUWJnXPXJdoa/NfYUGLkr+OQim71UqbMUWWrKE0RiBegD8AlYjvCnJ+GgdeRlrIwua7zgX4zIr2InzSy5QPKahonilajLA21G/og43NGzz8Db4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4768a4fdf8cso1744841cf.3
        for <git@vger.kernel.org>; Sat, 22 Mar 2025 18:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742694420; x=1743299220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WobnLaUfwLF8TtQsrqmyAutFrEDGxsBi6O5r0hoe/lo=;
        b=vO5Zal02Ja30y1PVevD3ExblU/iGK/JW18lfF28lVIeJ3X/t+pJnwu5kDizGoN4WHO
         E9aCPvldrgmFKz/awdwWjCkRgqU2gyw7U3fCjeUN5DUbFNjlSgc19xOwk2okyv+kxrxE
         dzcsLySMYRvaEAeqmII9htHCG4sGGDzII2/RfVWP3ZiPRAbUr5L5uBnuxV0AkYsIvgnS
         Ch+qvVsh0lg/v+20aP/K00kmS2O7ESyg2UnfsvcPepOCKDbwzRfAOTcKHLmS4QEE62JE
         FL2ldbKq/PFrva0l+oklpchYhyoIV0uOtpC3RsYZqfN+O07xjBP2NASr9ygpdivjrYiX
         QbiQ==
X-Gm-Message-State: AOJu0YzKaxDVrpcDSCDRThY4HvCdDeP2L/yFPwZx5DFdWrRNjDy+v1fO
	KilEwCfKEAj+jRudzzAOkqnSdfLnKQFRg+h1v2SCb6GyvRMVGvc1gSBy0G3X6YpinEhrTex7VAP
	5M2mXYKu+HQRQe+7Xq+p8mWRIT0jPZI9s
X-Gm-Gg: ASbGncuGrx4B7LS8YlQMWBkr3q5lHajoNomhKvHodpmFmM4mj4DpCCS82VrZW5YGBpI
	N+P63qNtI7NDN7um9rOAG7TOT1HEeZbzH4brtrPqSinb1oXPHrXcJ+/Oz1VqkDMVb2eFMmxWCpr
	SNxClnBVyDRr/9pVAnx3kyxeBa
X-Google-Smtp-Source: AGHT+IFn6oCX2jOmdpLyLw3Id3gXUOpwm1BckqeKewHcInfC02+tGbGs4KbMhlP7O/+3BBLYCXiHtPY72jstkoHoCaQ=
X-Received: by 2002:a05:6214:cc8:b0:6d8:8283:445c with SMTP id
 6a1803df08f44-6eb3f2858ccmr39353966d6.4.1742694420463; Sat, 22 Mar 2025
 18:47:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742339107.git.josh@steadmon.net> <cover.1742594960.git.steadmon@google.com>
 <6befc95a2d0893aa269142a18d60ad07e79c6e88.1742594960.git.steadmon@google.com>
In-Reply-To: <6befc95a2d0893aa269142a18d60ad07e79c6e88.1742594960.git.steadmon@google.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 22 Mar 2025 21:46:49 -0400
X-Gm-Features: AQ5f1Jr6mD34bCs1OtFw_PHcvH5eH-913SyO9PvUDEGlZl2-1JP6zDY8P5gc1cU
Message-ID: <CAPig+cQ+05r0iJO3me2=yz1KWaU_S_WQmbeciOqZGxYWgbT8dw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] libgit-sys: add symlink to git repo root and build
 out of tree
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 6:14=E2=80=AFPM Josh Steadmon <steadmon@google.com>=
 wrote:
> Unlike `cargo build`, `cargo package` does not get access to the entire G=
it repo
> containing a Rust crate. Instead, it prepares a directory starting from t=
he
> crate root (potentially excluding files, such as those not under version
> control, or explicity excluded in the Cargo.toml file).

s/explicity/explicitly/

> diff --git a/contrib/libgit-sys/git-src b/contrib/libgit-sys/git-src
> @@ -0,0 +1 @@
> +../..
> \ No newline at end of file

Meh.
