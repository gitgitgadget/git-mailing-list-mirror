Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007231EDA0B
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 16:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759335445; cv=none; b=Lg8ML8NDBwBPoS8fVdqzmqjnyGSEnkiwCdka4UxO7ZYPxch/8BsvDGBByyROv2lWzOst4GkBY37tuZ8GJxJAASZrXKocUnPmsJYXj7OQFolJYyIzhG3+lqIlA0Franb1VDqXakd+rCmWQLVZ6GV3sTOPr6T5SBWJ9Epg/S4tGIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759335445; c=relaxed/simple;
	bh=Vc5RaWFibXTKPadwLlrWxhc//s8MYa7sXDVcLcRSkoE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=M5f1gO5KfX1J6F0uD7vxIsCDkwO5b2sUoBRs/Zqw5M5mh3DD4hkpCkti0YOOcTNAc/h8K2KQnbTPmR9/uBg4FPfAB8vqc22lAPoCqemlRP8BIX7vU/fZwiv3WUmI0uXlzYu0tl1U6lUOmbygnr8rK91YuDa02nWxe8oawbtPYhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KV18UP2z; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV18UP2z"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-77f605f22easo88165b3a.2
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 09:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759335442; x=1759940242; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RuVuz/CyUxrN830tFqiN3sb1eqtXiHSI597DK1Z9Hwk=;
        b=KV18UP2zZXgyBgMZXeq44vZhOnUVoqcF9lz9/6lo1WrTAwoPWz5GtjXnjgeJ3mcQ/W
         izH/aqHFxtttn3KDXzLa/4YgUiP5Mm1XL4UJxQvSBLmjF9BJ69Rxl3pCN6cYxDHBxg0G
         UG1jea/rUdF6VEOFrGpEvzjG5Vmg8OqsViQpZU4DvnCii39txPoW6QAY5lqOzeKXXmov
         vomAJp2qvzwfiUate6GNnSXXuGyVnf3drvYNFcIBPGM2XLINRfsBG6+ra6CWg6xXsk3f
         CBDxUPE11tzeVuoXSyTx7MnktghBJfUE9r0+ekVK37kQjGyk7s99h6miHVe4f/MvWZVA
         RRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759335442; x=1759940242;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RuVuz/CyUxrN830tFqiN3sb1eqtXiHSI597DK1Z9Hwk=;
        b=GGw6CZ30POnffRDk6dCjikLaiJcDSJDqHCwGBegl17fT35ySOKIjx/RbnDjwr6Fev0
         bg5pMtg08wuCzYQXwHpbPXQd97ZWiCu5rYchqlUnScRLCNaZqjvisEj6YXtZLthGD5PL
         W2t4tauoIqXVA3Y/m/dfziILkaAk2KeZaucQ9e6sUhcE+nDGCCFhBjqs7HSyJBqfVUlu
         PELcDqeWwcuije7pZIPFrZmjxWXbrhRh1XNvGFdBus//FkP7EcLAh+tcr3yFJgStmp76
         VFLGCJaK9sAx94I4bEqZkDQ79CXPGDa9JtqFk2tpi7/f3YR78kGO1z9AwRllMEPAU2IN
         +LXQ==
X-Gm-Message-State: AOJu0Yzm9oSvGdxFoQfpWXwLmz6KaUhXV8UwZ1xU/MJnywcFN7ndceT+
	Z7PSc7+yp74uS1mv+fIKl9isefGwBfbNF21AVomd5tO8WuUN8k32XicdUvMH+qe1nub0JbQD4or
	CboAmyeGdViCuInjnVplpMqWRf+vZqQl7J/mY2HM=
X-Gm-Gg: ASbGnctH5VE4v2T35DA12Z2F7HEsgbxvFC50G0yQMeJrWUK1Rik2WNgGtz/Ocy4XG96
	HWM2t1yeiNi73cdVdHJjvVSeyqvvttA8cMBjAqwtmci/I2rK2M9PsJU+FZNWB9Hky4De/K/gq7Z
	FOCtGEw3HCdDkMfsU45OExBec4wX+zllyVITYZP9nP2oRdPnYxtKFumzdLMKtM2U/T4RSCMMFyU
	XOEOUT3RzjAQhKXP+JM2X66UFMXrJQ699qMOPFeRa6y0q5pGPR6N0r1G2Ryah6Gm65SnCpkI9Q=
X-Google-Smtp-Source: AGHT+IFMuLrobOfFmAzci2eNOwn492NCKPqxjdudaFnhtDhU4WIjq7qHPtEV/f7koBNI3u6eWloYQR2njb47a3ESTPY=
X-Received: by 2002:a17:903:19ce:b0:25e:5d83:2ddd with SMTP id
 d9443c01a7336-28e7f318766mr53521695ad.45.1759335441937; Wed, 01 Oct 2025
 09:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vedansh singh <vedh2o2@gmail.com>
Date: Wed, 1 Oct 2025 21:47:09 +0530
X-Gm-Features: AS18NWD3z5Hycv_vsurTiwcCk8w2C2_uFWnxkWPPDOzUCSh97D0tOG8ZFiaRiFY
Message-ID: <CAMWvevK2CrA_2mJC-O2HDKag4EaDVrB-0LiqQk0_gKrRaSR_ew@mail.gmail.com>
Subject: Interested in contributing to Git
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Git community,

My name is Vedansh Singh. I=E2=80=99m an active contributor within the Apac=
he
Software Foundation, where I regularly participate in discussions,
contribute patches, and review code across several Apache
projects.[Cloudstack, Doris, and Apache Root Website]

I=E2=80=99m excited  about contributing to Git.

To get started, I have:

Cloned and built Git from source successfully

Begun studying the key documentation: CodingGuidelines,
SubmittingPatches, and MyFirstContribution

Reviewed discussions on the mailing list to better understand project
workflows and community norms[Past 3 weeks]

Currently, I=E2=80=99m exploring suitable microprojects to begin contributi=
ng.
Once I identify one, I=E2=80=99ll share my progress and submit patches for
review.

I=E2=80=99m looking forward to learning more from the Git community and
contributing meaningfully during this application period.

Regards,
Vedansh
