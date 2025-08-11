Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282E11EB1AF
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 22:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754953162; cv=none; b=a7jGHh7b3CEOMM2yKyn0v7dstujdh+ccY9OKZENPCrdUt57H2yIVybCyY1KHj0WQhiYG4hVQimRQbWZRR0ZsubBy7MP/UDQoHUz/yFqUx+8S12FZgsFb2bWyqi3rXwmZMY8BPGOFmkFIho7fm8MrHsYtS8/sVyx/j2bwVNn/bU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754953162; c=relaxed/simple;
	bh=pCr3rrMiUdUCElRJ+IGHBKIBTApWKoIC7F5FksO2UVs=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=jf8VJcn3VI9cYFmspU2jtsrtliGC7HsWoui8bXbXpYG6fUxH/cOzKOp0t+BiJO+C4JXcfqIwHJx3z/CE619C5lg7OOwwqHZoCMeu74Bqwmra7seIQVdrKmJFab2ZAHXxohOB4OX/M4QjNyfpD9qTSR6pef24YqSNvvRW/QNYZV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVKhct2u; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVKhct2u"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7180bb37846so46445357b3.3
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 15:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754953160; x=1755557960; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pCr3rrMiUdUCElRJ+IGHBKIBTApWKoIC7F5FksO2UVs=;
        b=HVKhct2uJQpQpF64GlsSSadvwAj3ekfaHNcRcTaE/w3redUciZvaaisPa7+XS58cXo
         EvLgxzFNQfw28xI8poehF4vg6rqBvNKjEHlcWjfjFHP3d9Ba+J0vdPnIC+H5MKNwZlYx
         HoAuM3UE81madmOqEd0ShVxmeW59lWa4TxFbV9a1FxGiRlvMEfK/+bbHf11kvNY3zXau
         bHsAXj4SO7fNRwAfFVwC6D3KrVMSnNn4pQ7GKEqo/CDT3YEl+dpPNbE+810AmlCzO83q
         NoU81ESoght0SkXnSB+/4CtSFDiYi/GFt/ILoFA1qMw1b6i9A9/ZmgPnHtsqBA2TTdSC
         aD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754953160; x=1755557960;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCr3rrMiUdUCElRJ+IGHBKIBTApWKoIC7F5FksO2UVs=;
        b=NP8zwsbsHpvW7l+k1l+MpbZrfWiPG6P09YxYw3Lev44+wH4wK3YpX3HZRDuuLqqBAg
         gt1tobfCiQ0Na9S4vKTI7uvOLQnuvDVWPRk+IaFeMb7j/HoW51NOUuly2m3iNcacKBsQ
         uyH7ct0PoO70AhioXWwUZVtB1CSZEy+eG5M3IpEPRm5sHR0YwH6kQeHv4ojo7RmH1lvJ
         JQYH2KYUZeiX6ofislFGEpr9k55OHF2ZF5j4c7qC7xkYD1CP+c5PO1bkLO0b0KIRBzcu
         BpMgl1zq+zAfVBHRdXErjjUWmwdMKGinU4WYmUVw8X+V9Y+qEDcooQNxX/TDBn46JEzi
         yiUw==
X-Gm-Message-State: AOJu0Yy8mIEvorSjsoCiMfNgvszGvBImY9zeJem9OCKvTgpIg9CtcPA1
	5yBp+NnJpkYml4ZDLVjjNEXN6YI4FGTuNbzoroczoO+mmkOCSnERFkF2
X-Gm-Gg: ASbGncv5zmRRP6cm0sf7rJ0SToAwSHGdqXLueLx9io534rP0gI/IuBcc7qM+K6mohJP
	N+r3eMrCi7OZWCK/nqWHWBzPLFm9DYHfivLVkGm3/bHoc+7smhjDR61cILkyEEuO6f7zUWX0P7j
	fLXdSAkbKSm2Z1HbmDgU+0k+YiXM8zv9SUvgVOh+XJeyMLIbvjsYGf84Ii5psAB4R741EgnpCmn
	oNqg/FEVjLTNv1aYZmiLw9VgpJwj2rimL7gYoNnrEKqtg1Qm1Jf6w68tzvgg57jziZFkUSKJaFY
	CQqVB3eWJt5PZcJJ1ut8xCj+myEbePaTFtH7GyLu3HzsiYcVMdzEU0ILeShOmbFlv08BfcXNQ11
	Hmb8gYd8bXE02nG2LWU5uc+iiFolXOXI56IXgydy2ewX5Qa9KQ2c=
X-Google-Smtp-Source: AGHT+IEP/c+pev8fcilOKTGfEpWNZUw9M9Tmja1iTzCMStUGaO4H0CQKQzJ/QXKRH2atcfABXVActA==
X-Received: by 2002:a05:690c:d95:b0:70c:c013:f26 with SMTP id 00721157ae682-71bf0e78fa9mr196398747b3.33.1754953159890;
        Mon, 11 Aug 2025 15:59:19 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:f5e7:14b4:8a2a:aa03])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71bd09175dcsm35896797b3.78.2025.08.11.15.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 15:59:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 0/4] clean up some code around editors
Date: Mon, 11 Aug 2025 18:59:08 -0400
Message-Id: <6BCA1E93-7409-41FA-81FB-0CB75A3A55FB@gmail.com>
References: <20250811221706.67168-1-ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>
In-Reply-To: <20250811221706.67168-1-ben.knoble+github@gmail.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 11 ao=C3=BBt 2025 =C3=A0 18:17, D. Ben Knoble <ben.knoble+github@gmail.=
com> a =C3=A9crit :
>=20
> =EF=BB=BFChanges from v2:
> - shuffle setup code and use more helpers in 1/4
> - insert 2/4 to stop abusing --exec-path
> - improve environment-cleansing idioms in {2 =3D> 3}/4
>=20
> Thanks especially to Phillip's encyclopaedic knowledge of test helpers ;)

Some of this shuffling turned out to be unportable, which CI caught (but run=
ning the test locally didn=E2=80=99t??). Fortunately it pointed me at test_e=
nv and I=E2=80=99ll either use it or go back to the subshells.=
