Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6588732F765
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 13:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774186175; cv=pass; b=lpFg5A7IVK/SFoesocnnAC4NDYg/GbyhaTRi4bLu9DasM/Mb95oh/d2RZF4SyhnIrEH47WLENsUsCjTjbTcT3wSiRV35ASV56T+GGnwzJ972aQ/7vehsPZghi680a2yAm/JZl183ORegQy6khGFLTreFFMFjqmshcfJUJyNFS8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774186175; c=relaxed/simple;
	bh=DDOo0hOm8qm3k0MatH+7AO1Vz7qKvbuddSG4+qsZwHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OFsKfcW+IDIvp1QcAoySuVmFJwAV4L09I7jPh09ndJcW5anwviCEPxCOFjxw6f2T5KMUCuzbJQcdM88at+gySBH4mcBXLbVnzX/qX27RPdAZgCiuyaI4Zv9zFX3QqcnfnB72unc8TQdxT2rpFvJRRUzJJC5k2MoKiBAEBTDGY5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjS0JWnM; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjS0JWnM"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-899a5db525cso29748716d6.3
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 06:29:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774186173; cv=none;
        d=google.com; s=arc-20240605;
        b=MTZmka5yhSHjjHX9ZsFUEFz6zjgdXYVwTzV9vKvC+CqkUikBolISKPoZF510s3kuDR
         xDkrygQ2JiRP5sep/yiwWlPE+lo2g7wZ97pwTdrtT5jJSatGhy1huSbaThTXdlIgLLrK
         Pr0CJc9h78n7dErNCMqYXcFoKWuh0Wb6CfzZIH6RveuqEsJ5/efvPXDTRAkjUGu33Dvo
         s3ufAOJ5HyRLW7aEXOjajatNf6Ig4LwBrK+pO3RM/LuezcfTtj8YIip3MpifOzXkVb8e
         SNqkDO7aq3O1Gf8aP5pbWNmLA55u7TkTQNla/v8Bkx4rX1K/mrzijRkuFdbExl6JsfIy
         UfFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CFbMyQgjp6IGcw4vy5h1rjeRYdYyWom3vUYd83bdASQ=;
        fh=d4YnUlLSzgvfs/h6MExh/rS82xPWo30HnZwuqMIGuVU=;
        b=hSRtUhavLgIKpwQihvZdOLciGbbcn/VgBc6ZIeHuX5SphhXb4edot/ZCmdoWelqjsD
         ci9Karsi60dFYrxPJLgF2jOshb3WcH2qm6AE5AMxLldwlvZPcT4tbajCb0YykUTDNOzM
         0oV8MD+98PrVId2fu8PErUmKXnq40RFUaOCw+Qp6TYx2FjoVq0pXZ59BE+sSlLEEzqfQ
         s2Bg/FMULLlcdpuPI8+1WczKsAHJYqLwtjn5DheZTPHEFuJPC/kNKjShMQJhQI4eIw0s
         07FDZLlBsoXsTuPPYrc7/Ve3SIcN4K+hDKkYtwCI2X9B3MJjH09H5Tsie2cIurHi+4Tk
         TIuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774186173; x=1774790973; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CFbMyQgjp6IGcw4vy5h1rjeRYdYyWom3vUYd83bdASQ=;
        b=gjS0JWnMDkDED/Bk4yGUplVvGa8Bv7ZZbt+nD7zl68BlQAbmAB6tzgh9l/g772kcKc
         HljqT5kBinrhWS36We+e5jQmBgnsNEq4We4x6ybcM6kQclTWGWtaLZkpSm0/K+QRD7GJ
         tnsIM4C4ovA5CAbxHOXYkio0ScQmAl9Ao4zNGabPudrq/xAJicWun7oNBTd+639+1cc9
         NxgmED4+sBOoNn8XcE8cPcWX3aLe2rerPBz2ebwfEf+DxoFtZs4oXnIN1m6JsvBgwDDj
         fejl8D2SP2jzOivgYAq4GzLOnar2xsM9Xc5gM1SrDDUtAEHqSK4GKZrGKqPk8sYHPzwj
         vjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774186173; x=1774790973;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFbMyQgjp6IGcw4vy5h1rjeRYdYyWom3vUYd83bdASQ=;
        b=RrpYX7dDYkGEHc4BNwQUjJjCBaWU8ZStJelaYJWmtij1G8n8X0QeIBNIUIw7kfBbZJ
         Vw0rUWOhwGVenGquB9rYCeZKoRYX5wHzFbrguqcS9xE+q8Cb14i2nS8nE73x9YofcMUC
         9ASgm2x45CzDGJAaS7+V07B0dEybblszJx4Kw1GDKxsjO/J8I5MPX2mV/l+2w97ybZ9t
         zuPwKquzRXCEVMRBygWf/FxxjrvbMOU7nK1tH6NspCIzktwMJQTTHHtNhm709/utrmkZ
         fSJCnrw6xsvdVeJj3UHWoREFaD/gAnlnWKl7RrQuDPSV2syGCHamPzZjC1rZVGxf9TrH
         BlEA==
X-Gm-Message-State: AOJu0YzhVQ+UaHLzHmgg+Alm/noWle4XnMwsTpu82mDQvNifDjWAw3Hh
	eN7BQrTWivTwcQ3Dvla9es7MVTrGqS2k50R4GnSAvW3+Ilup0ljTO9j4xM1HBgGdkuxGoHomPfm
	mDDDiD9Ui5f8UjM7R1x1TdeB/Jf2gNIk=
X-Gm-Gg: ATEYQzyZcemH/Lpha/U/9359t3065As5RXSkrbUE2rNCFp1Mtm7+9yz0NrR3uZD4+0F
	BsaxtVAOwmdeC3HUHSfegUJeKjlQri0J6vS079b8bhwvQ7OdeZ+u/PhZpfefpoUcgVQ8lXwJIbo
	yHHSsYBP4xY2jzh3wjdAO0Rlfb6BEDr0/bF0YP6Bl2BGPjrKK3itQ7WQVIQ9N9zberJ5GSl4ok0
	YVzZjpkp3V0y/6o36eW+as61cvl0g0YsfKH5hffDSVLxRNDaAHLNd+pbZ8CyoyWaXFSsPpmi06Q
	3Rfc9SZKweK8Rx7+6QKR2ehcgNYtXz1E+Oh3ILZqKCbo/vXBAAttiIbGPNoIPiSQDv7NbNx99Uu
	sXXwv4m8CX5xvUBKs/+mBaZrflVf+ZdfomSWI
X-Received: by 2002:a05:6214:4487:b0:89a:7e03:f914 with SMTP id
 6a1803df08f44-89c859fa648mr141848236d6.11.1774186173047; Sun, 22 Mar 2026
 06:29:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2247.git.git.1774183586.gitgitgadget@gmail.com> <6f71fb3e9a39d8cec62bbbc83e53543be40feef1.1774183586.git.gitgitgadget@gmail.com>
In-Reply-To: <6f71fb3e9a39d8cec62bbbc83e53543be40feef1.1774183586.git.gitgitgadget@gmail.com>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Sun, 22 Mar 2026 18:59:22 +0530
X-Gm-Features: AaiRm53jcXKrZqzKB192rVAGnYbiM4jPQv1UGMj5-ALDdmkOkiZ9CPFhN9pq0_U
Message-ID: <CA+rGoLd71J31P98_4jC94Zo+oN6qk2ZX65wnOHU=xPwthhWpqQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] t/pack-refs-tests: drop '-f' from test_path_is_missing
To: jayesh0104 via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jayesh Daga <jayeshdaga99@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jayesh,
Thanks for the patch

It is a textbook micro project ;)
But I could find a few flaws in it.


> test_path_is_missing expects exactly one argument: the path to
> --- a/t/pack-refs-tests.sh
> +++ b/t/pack-refs-tests.sh
> @@ -1,9 +1,3 @@
> -#!/bin/sh
> -
> -test_description='test pack-refs'
> -
> -. ./test-lib.sh
> -
>  pack_refs=${pack_refs:-pack-refs}
>
>  test_expect_success 'enable reflogs' '
> --
> gitgitgadget


Patch 2 removes exactly what Patch 1 adds.
You'll have to use rebase -i
i.e interactive rebase
and change em.

Here are some docs [1]

Regards,
- Jayatheerth


1 - https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History
