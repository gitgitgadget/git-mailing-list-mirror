Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856C828EF
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 06:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454718; cv=none; b=kx/q2OKxJnLSbdPiP0KiVH6uqAUPdrJXvMqUIMVtGds7YSx+pjMGZCI1pFMM0P9d9aEyC28e9p5YaRcV1tguxok1SDu4SMMH09tj5cfnzAN61FWyU/QWd8yJc8QK2bKdLSNNLvvy2sfnuwujLioxncF9MzeUzFQFxlqZuNQGE7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454718; c=relaxed/simple;
	bh=Sdu0eMBuncD5Cn2LXC/k1fNLv/zmDEaamVpXhnVZO84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJdDN8hGBMoHOmr0NFC5f7cIyJm3JbGH7TTiMlhMjZFbKuTlFYln31SJxz1Sm+k4fFZXS/DCBM/0k/Htet+CCVAvOglf0efjSwARZecIjMh0jBZcJzK/HSONLvABqd1fi0ymYMTX9XBOr0N9BWCVmHjpQ1cBdXtgx2SkcKdmKvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cbc9d17305so719126d6.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 23:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728454715; x=1729059515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfeyj9sNFknSS8k59pzDx1xMe/X5DdM5EemJG8B4Sgs=;
        b=tfvyTbPGInufNcreSw1K0LaUKQV/emYMcIDcBesoiIV9InZVzrrElL4jfR0/KGX39L
         m3VmQq30DDySgandWPeTY4CxeQYXzLUJyUlS0vT9N4YbzspxBwHQyAg8TVkkI0SpcdYr
         DpEwP+E/Eq4p5iVFu/ktofcoaYrJjOXuUQ1f9FG5SmdWxQHPJDagUvFv5QQ98fkN5uQ/
         O5x0clSwXkzQQfm2Fot3wBJZMm78IgVhWGaaIVLgHaPoM7o7NvBy4bW0cR23+vLgjDUb
         5Vg+l8NBv1id6ZuCMp6HN+hOd+I0TpchXP8FzLIuDD/quVzhUeonimqosQdfiU7z0JKL
         OokQ==
X-Gm-Message-State: AOJu0YwZdrK2IS+zlK25jeBdOlypq8f6kknUT7iDKsiZnZAYF0XD6sqS
	a2O8B06aR0hPmAHqk+5LjZJdfUGUq6GLyjXENV32M4Tr3vOJzbgYdvLd1ozaxHz6vqq0o3hzUkr
	5W55Gzarm1osdn+SPS4O4VNSGgqM=
X-Google-Smtp-Source: AGHT+IFYTZsgma+lr60W0RFvBFC3GrlvMvKtp77MjM/++80WedvM0dKfJr71FzHmLgBNJMl66FDjnBo6jH4DJoDVkCM=
X-Received: by 2002:ad4:5ec5:0:b0:6b9:299e:132 with SMTP id
 6a1803df08f44-6cbc953bd9amr11500006d6.9.1728454715291; Tue, 08 Oct 2024
 23:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1728429158.git.steadmon@google.com>
 <29599e9c7be1737bcf0de0541c9635212a1b691d.1728429158.git.steadmon@google.com>
In-Reply-To: <29599e9c7be1737bcf0de0541c9635212a1b691d.1728429158.git.steadmon@google.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 9 Oct 2024 02:18:24 -0400
Message-ID: <CAPig+cQEE=rOxb49rHHY5sDvSFm4+nU6RdFgXmQyt8EhMpFMLg@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] libgit: add higher-level libgit crate
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, gitster@pobox.com, 
	mh@glandium.org, sandals@crustytoothpaste.net, ps@pks.im, 
	phillip.wood123@gmail.com, allred.sean@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 7:19=E2=80=AFPM Josh Steadmon <steadmon@google.com> =
wrote:
> Wrap `struct config_set` and a few of its associated functions in
> libgit-sys. Also introduce a higher-level "libgit" crate which provides
> a more Rust-friendly interface to config_set structs.
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
> diff --git a/contrib/libgit-rs/src/lib.rs b/contrib/libgit-rs/src/lib.rs
> @@ -0,0 +1,95 @@
> +pub struct ConfigSet(*mut libgit_config_set);
> +impl ConfigSet {
> +    pub fn get_int(&mut self, key: &str) -> Option<c_int> {
> +        let key =3D CString::new(key).expect("Couldn't convert to CStrin=
g");
> +        let mut val: c_int =3D 0;
> +        unsafe {
> +            if libgit_configset_get_int(self.0, key.as_ptr(), &mut val a=
s *mut c_int) !=3D 0 {
> +                return None;
> +            }
> +        }
> +        Some(val)
> +    }

Considering that v4 finally gets around to swapping out `CString` for
`String` in order to make this high-level crate more
Rust-programmer-friendly, I was more than a little surprised to see
that this function is still exposing `c_int` rather than, say, `i64`
or such.
