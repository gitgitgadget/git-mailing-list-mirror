Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A73439A7FE
	for <git@vger.kernel.org>; Sat, 30 May 2026 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164854; cv=pass; b=c4l+Hv8h3gldPd0F6TVi7sOJYik4eE3dfS7WgWz7iXxgyyqGpUMp0ZuIUZEFlk1ZKBht3Xjeb3kNUJjcf8Pvhw9KnH283es+tdoC2OR/atOqvBMdJDb4OU6yJXmLc76db5uY3uiGimuqNqPJRRbuFoAnf9orva/w8fDmXFnFFTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164854; c=relaxed/simple;
	bh=LqTNbNOxMODNyH5hiBPsWzT35e1ri4jsNwTVI7tytc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pd0B9Y8YBWxI5Ei9OnVdlI0PCo3UehCc1eX7QevNbWFPRA+/IfxWpVucN+gWSUPn0cu1FfpfxqeEP/F2+fiLdtZegpaqOQWGhCwUlI+jdOmmJszhR6YYLE3XAVMmzZPMt4DiEz4OqF2NXqmBxnlPjxrjpK8oorx1IF3BUSqbsok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYnmPo/H; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYnmPo/H"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-137dd51129bso58809c88.1
        for <git@vger.kernel.org>; Sat, 30 May 2026 11:14:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780164852; cv=none;
        d=google.com; s=arc-20240605;
        b=dJ/zj5knu/ImWZsClIdKnO+I8HFMnJ6Y6aHLG5qemIBd/cLKhlvbzLAs9BkPZrGt8B
         jJMFxhmKDdxBaatGEPIY9CI48crR01w+mjO2ZRsjmnZuTs3OggIBzoddBT+8vBs6gYJF
         dvNAY6WhcwjeJdqyRJAp3dsFPlb5L1MBvie9cJ5S0Jr28F6jLxdJDYjqO2YXM/IiA6vd
         cuVBQKXpJsNFPAcL2j+TucMQgZvbt7sLtr2Y7mTKKmFpCpRNgbCFl9oARgWoMNoPveTR
         b3lf030ZQexxSYvL7Mv1fAlG3gY8QnIpWtCOwVlTp++dRnYDijLdMOa2dEcKFM8mFdQg
         obdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LqTNbNOxMODNyH5hiBPsWzT35e1ri4jsNwTVI7tytc4=;
        fh=hEoqR+K+i2TKfZzeZdxHavFML4oufOJDrrtQSUwGObw=;
        b=Z+zZFC5XNTMCN1LgVqjudV5L1RHxEkyLcTu5lwZfkMtX+8TF5Yc9WdpV5rOh5zhDQh
         YfJXkeLU+4mS8dEjBSjfnfa5/bgirgllROj4k74hxi5OEvsjl+4Cpxtoar1V4wL7P9KQ
         4sATBNlo3qqnTCmmST+q3Ky/pmidHVPpIkNCm1mtCaVsoXvzg5kJJuKICjCJZTX8DfbD
         ktvvp0gOScuWUjN1i5zEvjIdNrxB70jY2EL6hSdf5qKTdZdvGpQkEYVWQkhm+oy7YHge
         VYZp6EM0fXOKpj2DN3EpQAbP6gSYCaC87/PonBxmMzysahhHQV0VrvCJyBjcVf/OdeNK
         8nAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780164852; x=1780769652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqTNbNOxMODNyH5hiBPsWzT35e1ri4jsNwTVI7tytc4=;
        b=KYnmPo/HLPwZG2tcyqLj4CQuHGy34ShnYylWZ/9dpxNYzOGuVAZTB7YEa8VGtS6JSp
         ZYZa06zKensYYWhfWIaNS5m1ofESD1C1zBP7PYzyRvc6+VAuEWE00kno+455n5jLNGEu
         pRsEfXMcDu0KBOuJGMxmXFqW5KhdS7Q5C+xNW5Xj7wWh7OJ3EPaecpJcfAQ+QMRvcq/n
         HVhrQqjM1YVw5r7FFWvk7EuuMEsItNvBZCrPBSE2fELjLBEvBTEMQx7/v5f0qRzp11mA
         9W/BvqHw0MZ1M/Ai1wDKAsjoDBj1Phge5J5u1mKerIfUgRvBw7WJDQxvIi0sJlBWjnP9
         wYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780164852; x=1780769652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LqTNbNOxMODNyH5hiBPsWzT35e1ri4jsNwTVI7tytc4=;
        b=RYFld/rEjWhk/S+HsSA4NhIbejtWsLDsczLSbMClNsUSdwZUHTLubwYi+5WHrJH1HG
         Q3Azmt5i8i1tHF3dqk4IDgjteLSElXnaIJ5fRgGHUveYKF1U6pTL1aHkBdwMWh9MmGFA
         Wq14LFSaeqRsJfoUR3Y9wrBxDU6SOm1QHUkfUNjOziH2QUcL/4oyEcHpLR49sz2F0C9K
         dmNEhcsoLMVsO+/rRh30zRyvJCVe5GlDVbX4+r5uxG2uqwzdoxRbJADcf6xcqpgpcvrz
         byN0yZdCykKqGrmFay+5JurupityuVSKQJyuqgZvPwY2Dw0Ch1JwvjrW/mMgRAEyNsXI
         lPuA==
X-Gm-Message-State: AOJu0YycMvZcLNB+FMLZBmt7xGbKfNO3umulSduF+xAl0UKuvAZwpDKa
	bTUk2T0ceQtUsE/H0UvoB5Ndrio4yrwwazoXG82hGN/xGY86mEDgP2kESRw0n1HT7gs7278ix5i
	J/JLFBq6zevphpnMw77KS3heF9UkhQV0=
X-Gm-Gg: Acq92OGehXwCxRi7hwVJS+kymuOZ83FmjOm60cY5GwZDDkpaswrcB9vaFDD0IFgfn/z
	YhipFKEW4kWHSlyYd7xfIR8jGJs3x8QBqTmJSj7R0ZduwyqzPvAyYJAZa9OCGpPwZSi9vKtZcSt
	mZjOOStov2yzYcV4342r4vfToAeHyRvbJRQXey720q8SFVwnoVNV6P7av+CSWbcuGZoDYf0CBtE
	Eg0IsnK1fMMfaRZNq4zpfrg2JLcYjpYBYc5HE6lola4BBsXjXuXcIkGFf0qh7pCngPXkMO0jWMW
	ufck+fJD/fRUiGFxkfOCCvpBWww4u8tiJP0smNCk8ZUnhIiW0WsMtxHkgd1b1iD+V/7eoFJJBe4
	p04s=
X-Received: by 2002:a05:7022:69a9:b0:136:c565:e83a with SMTP id
 a92af1059eb24-137d426160fmr2113298c88.24.1780164852479; Sat, 30 May 2026
 11:14:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530160520.77859-1-cat@malon.dev> <20260530160520.77859-5-cat@malon.dev>
In-Reply-To: <20260530160520.77859-5-cat@malon.dev>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 30 May 2026 20:14:01 +0200
X-Gm-Features: AVHnY4LRayEy18N6cdneRGNzDtzOgkB-x1IVsh71nFE_0IXWh4W5ZvWjnNbCDoM
Message-ID: <CAP8UFD20yij=1ZEYnR74DoCJ3g=b39yOsUxZecYuuf7nFGaKyA@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] read-cache: pass 'istate' to stat/mode helper functions
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, ps@pks.im, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Olamide Caleb Bello <belkid98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 6:05=E2=80=AFPM Tian Yuchen <cat@malon.dev> wrote:
>
> In the previous commit, the gloabl 'trust_executable_bit' was

s/gloabl/global/

> migrated into 'repo_config_values', but low-level helpers in
> read-cache.c still relied on 'the_repository' to access it.
>
> Refactor the signatures of ce_mode_from_stat(), st_mode_from_ce(),
> fake_lstat(), and check_removed() to accept a 'struct
> index_state *istate'. This allows these functions to retrieve the
> repository context via 'istate->repo'.

The cover letter contains:

"In other words, this series of patches is laying the groundwork for
the eventual elimination of 'the_repository'."

but I think it would be also interesting to have something similar
here, as this is especially relevant to this commit.

For example maybe add something like "which will help with removing
'the_repository' in the future" to the last sentence?
