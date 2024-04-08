Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD7D21364
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 07:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712560274; cv=none; b=BBeY/xFw0nAw/0NwLNAyC4WrzAY57uD/44lMHrwpCtS0ri5BLQafqUZ0Kqj/ONFBWhaOW4aBfQKG72BdI0A1tpmeKQGDaoHa7NjDsR2Emn6N2XgzAUt3DcrhV+70plkdpFW0EB74ZqqY9aWFsCBzOatkUmVCG/HY2jIpY14fhuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712560274; c=relaxed/simple;
	bh=JyN2pH9J1zwzpy28gt/HXl2v/MA7ShiuUee23fDVeH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZdA4SliPTtwpvWXp+gDlS4jxpGJkfl0m/77mKg7CKihSKXGwUMq6DLQFH+VrcSLmd/UeQXAeexSO971hpQm2toZlBEBww9GFEHhWA0Edw6EtbUJmJ0tGXmwGSU14qyo9EeHi+yc0zXxwp1QHpKg68jkWgTX2b7/oPJXLwS3/IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-69b137d09e3so6950056d6.1
        for <git@vger.kernel.org>; Mon, 08 Apr 2024 00:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712560271; x=1713165071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=suGYxTaRe/twstWE/NDY/6L/vdC6QtM5/CH5vGeiu54=;
        b=oy+k9RgzBdBWEndL+mKLp2t9LdtCKr+yGW1ORkyceZRlpzlqcaIdNdKtENqLX01Pwk
         tf5IIlSP8yznT8UhpP71oqkTg5lv1akM2KJf/RAyc8uvRlC/HRRhGXWFGJYLDiI1NVF5
         q1D85JWPP7RgVEKyodeiVrYpKhCF7Ur4OgDJXBhjzyTJ9AXG0wjbkoBgveGY1Mpezuh3
         MyzfgVF/BbvSbzhPy8lkP5CdsPnxxPaA6kOznRcv/RFp0yzIHAet/lzB2qBwbrC4Fgsl
         FXk36SiEnTeT2832hjlTsa1sGNaf5QYfTNGzKFHPVtYadCS0cGlOs293aElCd7Um4p9C
         07ng==
X-Gm-Message-State: AOJu0YxaNq6aDeNcHWlLc3UhX8rc0B82JOpOgz+w2yVinMUv5Ih40Uwu
	kid/HnNdm+RUOml8v2ZenFW3LpAnDbgNudePF6vMh0xzIeo0PTHdruW9JjZQr1CB6LHV3zW8BKs
	LzSqUTIYZxsPWjPzX2VK7ZgZSgGU=
X-Google-Smtp-Source: AGHT+IFZcl9H9V7i+7mbetVe7ayn0TwzX0moftl6HOILOfZfKB0Z3qzRE5DZ9+Y19QfibWG9XeYPBgkabjDxYx0lS7U=
X-Received: by 2002:ad4:5949:0:b0:69b:1681:b909 with SMTP id
 eo9-20020ad45949000000b0069b1681b909mr2620739qvb.3.1712560270658; Mon, 08 Apr
 2024 00:11:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712235356.git.ps@pks.im> <cover.1712555682.git.ps@pks.im> <160b026e69547739a526fb6276a895904a4d33a8.1712555682.git.ps@pks.im>
In-Reply-To: <160b026e69547739a526fb6276a895904a4d33a8.1712555682.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 8 Apr 2024 03:10:59 -0400
Message-ID: <CAPig+cT3kvvHL+wLTFj58e5BnB7yBA=HD3C4vWC4zQhys3GCHA@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] t0612: add tests to exercise Git/JGit reftable compatibility
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>, 
	Josh Steadmon <steadmon@google.com>, Luca Milanesio <luca.milanesio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 2:47=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> While the reftable format is a recent introduction in Git, JGit already
> knows to read and write reftables since 2017. Given the complexity of
> the format there is a very real risk of incompatibilities between those
> two implementations, which is something that we really want to avoid.
>
> Add some basic tests that verify that reftables written by Git and JGit
> can be read by the respective other implementation. For now this test
> suite is rather small, only covering basic functionality. But it serves
> as a good starting point and can be extended over time.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/t/t0612-reftable-jgit-compatibility.sh b/t/t0612-reftable-jg=
it-compatibility.sh
> @@ -0,0 +1,132 @@
> +test_expect_success 'JGit can read multi-level index' '
> +               ...
> +               awk "
> +                   BEGIN {
> +                       print \"start\";
> +                       for (i =3D 0; i < 10000; i++)
> +                           printf \"create refs/heads/branch-%d HEAD\n\"=
, i;
> +                       print \"commit\";
> +                   }
> +               " >input &&

I was going to suggest that you could accomplish this more easily
directly in shell (without employing `awk`):

    {
        echo start &&
        printf "create refs/heads/branch-%d HEAD\n" $(test_seq 0 9999) &&
        echo commit
    } >input &&

but then I realized that that could potentially run afoul of
command-line length limit on some platform due to the 0-9999 sequence.
