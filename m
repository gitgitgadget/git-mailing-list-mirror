Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF538405C
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771753513; cv=pass; b=cdrFtHvwjmzVjkjyHNr8OIOCRIIegH6t+94f9xT86WP9Ml0ekx4uRFXKVaA9PebY3bpE3GDtkF+Fzt+QzSvJpvokELYDMvt5zwCtpEPfeHDswY67er2a2E1WDxoP1UVHM5PaUev33O0xJVZV6AQdH2nvHAdC5lZvI1GCyIBg/L0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771753513; c=relaxed/simple;
	bh=VgK6IHium2emEolvvAb0xGACN/SH3HdsecIIjJne3EE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1UB47RT5AYDK7AgJY/ed6hUc78c1ao/78jCJZl82xSYjM+bbjan/WVwKGxSgoK/NBGPrWYg5y8BF6vPTjz8JyDAnH7YsaJY6fIA99MAlsZmkIB1QUWZlW2fdouzubFFKbLWYMca+399thCN8QhjVwmGLXbTgC2g++yQ9nq+gYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nx51WT30; arc=pass smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nx51WT30"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-568914bbc9aso1303309e0c.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 01:45:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771753511; cv=none;
        d=google.com; s=arc-20240605;
        b=BXpzbqYXleG9tsikrISFSHDITrOd7wrJMrK7uv8yKJI72hixum8zwGbJF5ezW6/J1r
         Khzk6dXTMAzH7ioe+Za4yr58HMS/+TOMJqHwChwkeQsjj2hpIB/Fz1oKw+R141PSgcsO
         mpPvHhS1lXbcqWgTmkWTrlo8li54U40/tspwk21Pu+KQ4sEgnMtaes4WV9TMrOaHmh3E
         Hi96qpjJ7JlIkKgHivaGTGbdYoFEqF2Uq3DoYvRUJ57niIcS2AtqyEauB0fmQ7sREVRH
         XCrUrUX51TuCSWd9YfiDSiQ/LoA1NavzrgAIXTrRNkOlVnVlB3RmNr5qxeqj68g+3/HK
         E4tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6w0vwZgg0EyfzOuNbs4ZHDr+trrgKSMHZMgcCXVvgqg=;
        fh=ZSRNA8fv6K9+CDEBPjfmNdLEPh75MFwEvC2t0kc9ILw=;
        b=WyBhQD2Qh+83gQntJ/E8XLLCODLEUF691QawhWWnAJbjWCzD0vA5wjOoCjcwcfu9tv
         C6M4zL0gmfHsC0Y8Ls+ce945ZvzbSvmSyBa2U70ENzecUzrd+UFi6J8h+63D3qz91bpI
         FVhW/er2dQcQBc+2iadaovsA1i+p7Yk/x/LhiU/5Sre2jQ9Yc4zGuWIS20GgtcpDESIK
         E49nET/cIeZ8CA2rplu5o2UlErkApEzhPDnj348PwqtWFT200yi2Fje6adWAEYA5CCXa
         mL/Fo8JKvgNXwlEEXMM+kz1eswkMOFI/LPf316o3tLGf1LHVsQfMFjNzK6HupzY2wyP9
         NXnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771753511; x=1772358311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6w0vwZgg0EyfzOuNbs4ZHDr+trrgKSMHZMgcCXVvgqg=;
        b=Nx51WT30X52DnHsyhEm+u39i8HqMC2FTbh5fbuMlFoZ0nN1zf/9e5iaTBgb5Qc8bO6
         iS79yOY2laPy3R2LgJTR/OHAOfQkv++fLXbo5PslrwI5mqm1nn3qTQ4akfCsU31kPRVo
         5huD3PmgvPig7i7/gF9p0T/l7w5f8rZayquyrjOWIPLr3gGytAVQk43AoKX9im1I1Wmj
         YgXPnGUWuiGMsqKUetPD2sOp0PCQveW6zrsUP7/4sja+JISEZP6Vw4lEx+JMcmlTemV5
         WmRAx7ORDALfX4yX8hqWVFNoFARBMH79TygG+x3o34f7TpoPUn0zu5fqI3qkj465mI3N
         zj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771753511; x=1772358311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6w0vwZgg0EyfzOuNbs4ZHDr+trrgKSMHZMgcCXVvgqg=;
        b=w0ojE+Tsi3swB2jQ7z7fbCZmnkuaVubpFW05H9E9XnTS8Z5TSRM/FDsoc9FxP0iq5j
         Pk1vNyUZeheD0tg5pg8nQnVRLcDWUWdpj+dZ7Vc2GPNhcTvDXPbqF4FhGFfirheczSiS
         5+pyLYrth3j0xMMnq5KLPpEoS+lEOHkBq6K3EgFif+IYu0u5x8V9J3qO4YHjvmMJS/qa
         H3w7LVhj/tP194g4awKfxTrYItIRnMpvMwv0Rb8sCzBihhJb+rCZ88XY5xhiJSuV26fA
         t4wfHnagMeTt+YXRBXXhaNbOpqUSSbG1h/sHF+oFq5AQNMWoFSMIsqo/krAdlDSYx/pV
         jqlA==
X-Gm-Message-State: AOJu0YxgAQ3i7qYAqLF7+Y5ZMLi8lr9oe9/1/0pT65yMRyy8fjhKCCeB
	Bex0+437CXC3HGjv4Q1eG5tud1EvGwEZ3rOGsluO3rKSW7TTPu5sbS2hakW7TtMiPcx88PooGIz
	6E0tSOPNaBNESyVtLnEBgmJYX/z+ACxd+j5gU
X-Gm-Gg: AZuq6aJICFVHIYMvFI92t4M0obKsq86viFJr9DZPhJ70ha7PJBvT5wtNw1oZrSUoQtn
	jDSSJ/WiJuT1K2bqTC+GCrdRcSSbR8f76ZWyGW8wR7EgYQBWQrl21baD/JOqkl5ebK3o7++T0bA
	deUaErTgvYYTOXRX+76lezX9folXXHlefTQ4NDhhE5Lm17uIfpHazs93IBLFOdbWNGXc9mlF0V/
	4AUDGZA0ayZb4LC2vdeuda8oywEVi1anvuyWDCJChcfmvfBHCY8gQVUcLp+geiNy5tJutqq1KqQ
	LZ9kvjoMevsSy47I1Plz+ST8KwPaPv8vMo3kOuA=
X-Received: by 2002:a05:6102:f12:b0:5f5:459f:9860 with SMTP id
 ada2fe7eead31-5feb307ab74mr2023441137.28.1771753510619; Sun, 22 Feb 2026
 01:45:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2049.git.1771694893208.gitgitgadget@gmail.com>
In-Reply-To: <pull.2049.git.1771694893208.gitgitgadget@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sun, 22 Feb 2026 15:14:59 +0530
X-Gm-Features: AaiRm526nZkmWHfck3A2AlZilQz-Afzwiff25brmBBJFC4Q0tSOJcJW2bG89I6c
Message-ID: <CAPSxiM8f59DK75BeXXo53A2wRqtxd2wQ-ejpmGTyjnSsVTJFBA@mail.gmail.com>
Subject: Re: [PATCH] t2004: use test_path_is_file instead of test -f
To: Lambert Duclos via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Lambert Duclos-de Guise <lambertddg@gmail.com>
Content-Type: text/plain; charset="UTF-8"

>                 test $(cat ../$s1) = tree1asubdir/path5)
> @@ -230,7 +230,7 @@ test_expect_success 'checkout --temp symlink' '
>         test_line_count = 1 actual &&
>         test $(cut "-d  " -f2 actual) = path6 &&
>         p=$(cut "-d     " -f1 actual) &&
> -       test -f $p &&
> +       test_path_is_file $p &&
>         test $(cat $p) = path7
>  '
>
>
> base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
> --
> gitgitgadget
I reviewed this patch, it looks good to me.
>
