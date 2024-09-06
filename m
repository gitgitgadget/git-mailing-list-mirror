Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364731581EA
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 22:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725662372; cv=none; b=I5iAdtsK2ZothvBQdTOzc6heZ+BH9i5vC1kgPOpVBRQYbwJu5io2ExHGg6WNr1Xc4E8Mm3oka9rnnidV91vFm1vLOuHE+248XKP1b1BMyBdL+Cd1fYsqP5ihXu8KQMIElhkbIBeLklI64Sw+WevmFd/fK5VgGcrJufJL6LMNrlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725662372; c=relaxed/simple;
	bh=R3u4BPGN1dPH73LlDcaKwXOA0OerXJ/zA/cpXWauHA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3xaJfPMvf7qj8xhpNgWRuofs1AP2oc4djKnBgG9kLFsxMuhvogGMwskqFibb2zyKGV+HKx4++6pNJrlLrRYzwfRB01E4uh8eyrtNClYbSXc0S3VYxqsjy3DXmzFNH1kOII00eR5vzkO7KTKVZQf+AROkZiWCtKFX5wa8HN7tz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e1a8e2a9b7dso403489276.2
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 15:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725662369; x=1726267169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFpV/2vCq3yqcDnjw6mZlK8DuVHE4DFNLc8qViEwEFo=;
        b=QFI+kwAUNdATvycz4BYtAFqUuRfwHUivFUN0MLJbKOVIujyBRDwbJVL++/G5ej+yNx
         JZUEo1Hfz1x1qSNvfYJOKB7rmym8fPz27QtHPwCGqiPRrdNntBlUmZXCKkccr6TFO+fr
         8uUIlkpJuYtyNs4mn0PAvir65Qjnu7BeqkE7imVYkcYeKhLAndewCu3RO/rg+YPOz8Om
         hCTz0wrBQ5w+x8U3lIuaXXJzPowklYQPG0OwwxY12GhQdqwM2upjM/pDiZKk1q6h7b9D
         5t3LjPqpv4ERYW54YVrDDKTG9DQQi9T4HqrFM85oPtZDrcrZE14ipfLCJ+hapC27Oao+
         zMow==
X-Gm-Message-State: AOJu0YyjKMH+OE5aihFj+aBTdCY9meL6gW0cVaZ8yvTDJfrWbI86CsIY
	TqNxQhRNfvEcqTHtjRTlauGxNAvRUq3nwwcsW5CnqbDYUOmZpG9H4xDhtiquLltVP/GjhiRxvGO
	s6nVzX/DPGk2v3Add4MgUsneQptI=
X-Google-Smtp-Source: AGHT+IGaA1pC+zLlihszg/yYuCTBmS16wuLpAMqKF/VrCZz8k3Gfq4lyyu8sLIo+4AwAM6XP+FWVS5rmt3Ka2eDOCak=
X-Received: by 2002:a05:690c:6609:b0:6b6:760b:ddb4 with SMTP id
 00721157ae682-6db4512e257mr24152787b3.6.1725662368875; Fri, 06 Sep 2024
 15:39:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906221853.257984-1-calvinwan@google.com> <20240906222116.270196-2-calvinwan@google.com>
In-Reply-To: <20240906222116.270196-2-calvinwan@google.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 6 Sep 2024 18:39:17 -0400
Message-ID: <CAPig+cQbPCWS4LVF7cdw_DD6K8dsrLTCmmhqkmGZpz1CO93vRQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] libgit-sys: introduce Rust wrapper for libgit.a
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org, Josh Steadmon <steadmon@google.com>, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com, 
	gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	Jason@zx2c4.com, dsimic@manjaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 6:21=E2=80=AFPM Calvin Wan <calvinwan@google.com> wr=
ote:
> From: Josh Steadmon <steadmon@google.com>

This is curious...

> Co-authored-by: Kyle Lippincott <spectral@google.com>
> Co-authored-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Kyle Lippincott <spectral@google.com>

... since there is no mention of Josh here.

> diff --git a/contrib/libgit-rs/libgit-sys/Cargo.toml b/contrib/libgit-rs/=
libgit-sys/Cargo.toml
> @@ -0,0 +1,12 @@
> +[package]
> +name =3D "libgit-sys"
> [...]
> +[dependencies]
> +libz-sys =3D "1.1.19"
> \ No newline at end of file

Let's give this file a proper line terminator.

> diff --git a/contrib/libgit-rs/libgit-sys/build.rs b/contrib/libgit-rs/li=
bgit-sys/build.rs
> @@ -0,0 +1,31 @@
> +pub fn main() -> std::io::Result<()> {
> +    let crate_root =3D PathBuf::from(env::var_os("CARGO_MANIFEST_DIR").u=
nwrap());
> +    let git_root =3D crate_root.join("../../..");
> +    let dst =3D PathBuf::from(env::var_os("OUT_DIR").unwrap());
> +
> +    let make_output =3D std::process::Command::new("make")

Providing a mechanism for people to override this hardcoded spelling
of "make" could be another item for your NEEDSWORK list; in
particular, I'm thinking about platforms on which GNU "make" is
installed as "gmake".

> diff --git a/contrib/libgit-rs/libgit-sys/public_symbol_export.c b/contri=
b/libgit-rs/libgit-sys/public_symbol_export.c
> @@ -0,0 +1,20 @@
> +// Shim to publicly export Git symbols. These must be renamed so that th=
e
> +// original symbols can be hidden. Renaming these with a "libgit_" prefi=
x also
> +// avoid conflicts with other libraries such as libgit2.

s/avoid/avoids/
