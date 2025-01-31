Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA491C5D4C
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738333695; cv=none; b=czT7HM8PjBZvP2y5f1Y3ako/I4aF6UQqiaF2Etko6YpFbDmiylE2gCozkOPQZpMufpsIl/xq6ahB/3rJcT5C4oK20ly9g9w4QRtTG4B8YrEqUECdLrj8twi/V/36rM/bkFQr3nRRlhc8WkIhZdJLtcx8PGrdbvtoEa+U7LXmfk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738333695; c=relaxed/simple;
	bh=h8w4s5PjNrvGaMYMqT7j5Az5rPIYEodI4jch8PWESfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISS6FQzZGf2gECTCbfg9Fiuj6nu8hnMnHwRNK57DAmbZmKgCmAX6WjhzVifBUZraQokqu9wdNwJV2XllVACH2QyVoMcGkPrRkoD+6HvNRXbBOSSgfz6/VFewC1+9Oiu33gtJxT3JovVLhZwohQxIljeBgFAxjFnovPFGNhVfNNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6dfa69e6922so775866d6.2
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 06:28:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738333692; x=1738938492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xGmAOYjLBh+W9EdZ1cRKKX6vU5POG7nXQxinBu3OQc=;
        b=YeyBNCHgTJZKvrYk2RF3r3rYSghJKqrqhgamdYLnCbXMb3aic0om/XeAZ/cKuQu/HA
         uvZqcFchohonotJUwwu+Sf/I9kIq1QU3rYqSrjtfFBdcdbkMsjOAAbdiwn3MorUxM61X
         eekO4j/vC3dAc4AI7Eaj1RkyX76Za//pSbAqJtwTHvN1JD4OI+eynBWIoEnGA/PzwmVJ
         ElBmitIfT/30QgovGZKi7D57D9YywHfXytg8DYO+IECGvpEjqVVzJ3vNUcpFKiJSUd3h
         jI0cWY9AytXO17sjBOMaFUxW3PfVa9zQXuJ6SlXZf49FEF2T7qmjXYSUTERCr23GjTjt
         iCLw==
X-Gm-Message-State: AOJu0Ywu67rDxko1bui2hfXIbEH+6Tez3mIIkpk/mmtT1CDVcPEOPStD
	IV1KihGCUsfIIHuShTaKU+05uo9o3/oW0fSRy0rXeTHa3xqNsnlzU+XNThm6DB3eNDPNConN8qX
	LfhwbiVB5an/tgwOfkJoi1MjKsthd9g==
X-Gm-Gg: ASbGnctaFH4adPOXCw6Kuhu1LA7idh4/0y3QwMoO4u5wWlwIxJmtOR0rsuddWIZxPkG
	Tq74YKQgDu7USSBdrzUNzyvBqYCObk6w152J/Chb/EafCt/bQAu21jiF5scD39XqJ6QERC0EV/X
	L2gal051lx2jBufxiNToQeyANNz3hzsw==
X-Google-Smtp-Source: AGHT+IFZ7e5T0spSYNCPWSneVtE0DaCjbFDtk53XeOE5/wPZWUU/DMM2gB+pAqnwuxlvMqWctTXfTY5no3RmW8S5fS4=
X-Received: by 2002:a05:6214:1c85:b0:6d9:2fe3:bf16 with SMTP id
 6a1803df08f44-6e243b91903mr65886266d6.2.1738333692237; Fri, 31 Jan 2025
 06:28:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131-pks-push-atomic-respect-exit-code-v4-0-a8b41f01a676@pks.im>
 <20250131-pks-push-atomic-respect-exit-code-v4-1-a8b41f01a676@pks.im>
In-Reply-To: <20250131-pks-push-atomic-respect-exit-code-v4-1-a8b41f01a676@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 31 Jan 2025 09:28:01 -0500
X-Gm-Features: AWEUYZktic48dCFQZ4nPPnyGuxNWUT7CyYaFPAdf1Nq0xtc2uRH7TO3m5P_qhpQ
Message-ID: <CAPig+cRnm9z06YsCRyTJGqTCF_208BuD+3QoEKqwO7eWTfesAw@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] t5504: modernize test by moving heredocs into test bodies
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jiang Xin <zhiyou.jx@alibaba-inc.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 5:53=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> We have several heredocs in t5504 located outside of any particular test
> bodies. Move these into the test bodies to match our modern coding
> style.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-stri=
ct.sh
> @@ -64,12 +64,6 @@ test_expect_success 'fetch with transfer.fsckobjects' =
'
> -cat >exp <<EOF
> -To dst
> -!      refs/heads/main:refs/heads/test [remote rejected] (missing necess=
ary objects)
> -Done
> -EOF
> -
>  test_expect_success 'push without strict' '
> @@ -78,6 +72,11 @@ test_expect_success 'push without strict' '
> +       cat >exp <<-EOF &&
> +       To dst
> +       !       refs/heads/main:refs/heads/test [remote rejected] (missin=
g necessary objects)
> +       Done
> +       EOF

It's minor, but to make this conform to modern style even more, it
would use `\EOF` rather than `EOF`.

(Probably not worth a reroll on its own.)

> @@ -94,11 +93,6 @@ test_expect_success 'push with !receive.fsckobjects' '
> -cat >exp <<EOF
> -To dst
> -!      refs/heads/main:refs/heads/test [remote rejected] (unpacker error=
)
> -EOF
> -
>  test_expect_success 'push with receive.fsckobjects' '
> @@ -107,6 +101,10 @@ test_expect_success 'push with receive.fsckobjects' =
'
> +       cat >exp <<-EOF &&
> +       To dst
> +       !       refs/heads/main:refs/heads/test [remote rejected] (unpack=
er error)
> +       EOF

Ditto.

> @@ -129,15 +127,14 @@ test_expect_success 'repair the "corrupt or missing=
" object' '
> -cat >bogus-commit <<EOF
> -tree $EMPTY_TREE
> -author Bugs Bunny 1234567890 +0000
> -committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
> -
> -This commit object intentionally broken
> -EOF
> -
>  test_expect_success 'setup bogus commit' '
> +       cat >bogus-commit <<-EOF &&
> +       tree $EMPTY_TREE
> +       author Bugs Bunny 1234567890 +0000
> +       committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
> +
> +       This commit object intentionally broken
> +       EOF

This one is correctly using `EOF` since it's interpolating variables.
