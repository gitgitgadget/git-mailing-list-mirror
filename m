Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBDB207DE2
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 11:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742385231; cv=none; b=mUpiBennk1J5o+2G6oueLSRJrl9vYbPdCRK+5yTpDwssYOqgMvjyBOt5c4pZbhU0hCjJqzhhfl1IQDylBqakV7T8iY5rjtEM+Q2KSp8VALzrcPEplxT4GG/E6J/4CEPfLo8kC/P7M7pzNek7UWqWfqUWswl0PLSNDHk5VZtAxnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742385231; c=relaxed/simple;
	bh=540lXRCRv/FiLnNzNvAbeonSGqNbTVxXIOfYdIP1sVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zy9nyAwIooGLwtXtHKMzn+6BgGkyt0dsUJ599TmSzYym4G5b13rb0357yy1TzTszCbPVo99iL4+ngFk+bu83PStWSxmUf0ZeUHCDXsGrwiXNm4nQfrh+TeCWduagU0LrkuW/ga42hkh/SRItZhAOIEGqHJjjRQVpTOe75WTLGOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hY5yJEaO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY5yJEaO"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2239c066347so143851285ad.2
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 04:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742385229; x=1742990029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPyYSpCSy9GGKMfbECYf6Pgad8QnkAhqNLdXJ8gk/tg=;
        b=hY5yJEaOaYec3rbufbImCF3aGwgvih4wwiwmkx511ogvL6wJfcAa1Yu/SdkSAywQt9
         sCLAFliqVvYeKwTIqTUeLNYFCHf4QeC/U2z7OP/xsIbgVm1SUYumogkzLqgg4xBjiw2r
         CGuTbyxGNxkbpaniyX6PsQMK2OjBNEtfr85+SLmAKYF1K4xFfVtglgTLydDMggeVsDgz
         ztMtU58g7r9P3a1XngheuWqG2id2BLQ6TEjsYMWj8X2XeavP8NLGtcWDjNAj2bqGFYuF
         9viLv78XSeoUbAHvM1AejnDN04w7QfjAF2HPe1SU5pyqvuImuPkjbkyzz/Wb3JB7M9/x
         6ZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742385229; x=1742990029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPyYSpCSy9GGKMfbECYf6Pgad8QnkAhqNLdXJ8gk/tg=;
        b=goiyAESp/nF2ayAwQ+UDzcRWfDOjzcXicbp2V39Ascy8+49WpXCRbymyFAoGMpAdtT
         Pt6WqvEgQp+yTujdCAPZt++CZd3EFMB+qBpRUlGGAlq5WeH5g3NSGis2SR3nPb1QGOpl
         kE92wpHB+YA6tsQo058xYn8kdsJuEj0MYo8388qhdPoxMKLg6L7h7Ncn3JMyIvZozAiC
         ucFczYuNAsObf3ZJyPNwRk6+JCyx0Qbstp4YkasfE1nf3GbEzr68JbYjiR8CpKA37Acd
         X2D6jBDcIV/s+rHswhqdxmhb18Kv/ZX0OSvnAuzKOe509Sz4k2hpI8lBqFfidKQw9Utd
         hZQQ==
X-Gm-Message-State: AOJu0YxGyXDzCwjYL9U/Q65Wg+HdeXp78cK946+nWvSHE6fuhs3FF0L4
	rRhNpD0jI6oMt6aOOrxtmpKWNKbhL598LvAg9FiFE1N5G65okoXn06mN6OVLnziSS6AeEpg4JZC
	NN9Ec/M/6d03Rzi7hc6j+WtBaZEQ=
X-Gm-Gg: ASbGnctlzSydkAuc4yEj5MkVtJVS/S+jnjrdwRTHdLeN9e4ByGlaTiMwE4KcV4azIyT
	/05ZIXKDk6RPQkWlh4wfStd5yi45pC+shnzqiTewkeT2HtP5OZwKaOrlRiFwmJ6NNkLDVTrc7XT
	CRkjlFcdsk+Q1IsumtQGqOHg7G9zz/dhA6XscY+bdw5Jk4m3bODgI/6vRhoLM=
X-Google-Smtp-Source: AGHT+IEZ6Wk2wHOYnxIi6JBN7gaxkv4bKpwPhQad2V2s0+FOVnoV4dlDMumiSdBE2Ts2gSq+JCSBtqVPV4WL8ON/Mw0=
X-Received: by 2002:a17:90b:4b8e:b0:2ff:4bac:6fbf with SMTP id
 98e67ed59e1d1-301bde551f6mr3972019a91.7.1742385229280; Wed, 19 Mar 2025
 04:53:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318111616.113941-1-hmz007@gmail.com> <Z9qPMvclpdEIjQ3l@pks.im>
In-Reply-To: <Z9qPMvclpdEIjQ3l@pks.im>
From: "gtXfined H." <hmz007@gmail.com>
Date: Wed, 19 Mar 2025 19:53:36 +0800
X-Gm-Features: AQ5f1JqhePhKn68tUO1mVnuE7IzVqislELzENbruv-EcNPV_paYFpjcljlPy2_A
Message-ID: <CAGr7CZnNdTsUuJU+Z8HBX6wQu_HF-faDPPhuLx7u-Y=TGeop+w@mail.gmail.com>
Subject: Re: [PATCH] index-pack, unpack-objects: restore missing ->init_fn
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 5:32=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Mar 18, 2025 at 07:16:10PM +0800, Jensen Huang wrote:
> > Commit 0578f1e66a ("global: adapt callers to use generic hash context h=
elpers")
> > accidentally removed `->init_fn`, which is required for OpenSSL 3+ SHA1=
.
> >
> > This fixes the following error on fetch:
> >   fatal: fetch-pack: invalid index-pack output
>
> The change makes sense indeed. I do wonder though: can we maybe improve
> `git_hash_clone()` so that it is not required to initialize the context
> beforehand?

Thanks for the review!
The idea of improving git_hash_clone() so that it doesn't require
explicit init_fn() calls sounds interesting. However, based on my
current understanding of the code, I'm not sure how to implement this
properly while ensuring it works correctly for all hash
implementations.
If you have any suggestions or guidance on how this could be
approached, I'd appreciate the input!

BR,
Jensen
