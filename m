Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF83225797
	for <git@vger.kernel.org>; Wed, 28 May 2025 06:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748413209; cv=none; b=CkVs5M5MvY5vxNmkyUONaTuf7akGJo60HLAdK023kqolbr+LCXBHpFYvNtUidsII34pAd8cIKonW4NBbDqpNIFDQuty/4Y3k3OfkG66XKoWfoAhMDiXNqO8fUdhppAY/hcRLbazPMl7I5Xswuw8xbzlhKQvPuuWsQfCGIolMR/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748413209; c=relaxed/simple;
	bh=eLqAnfYqDvGKq/aLEcI8BpTe0tcw/CrJ/YpdbFwY7cI=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=s1zecnhPczO+wWT5G3VIg0J8LFmfaZW1fce2S8QoaQ8CUU0yI302zlSbGhlrLptb5M+UjjenAc3xOQur73azfJF9vrXe25Trbop01/54RPeejk9vVJ9C6b0nZ1wBh/dqTuGNGzr36D+5GIKBoe918nHS7S/WfsrrVv99uRQd4es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alFxSwHl; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alFxSwHl"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b2c3c689d20so1631867a12.3
        for <git@vger.kernel.org>; Tue, 27 May 2025 23:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748413207; x=1749018007; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLqAnfYqDvGKq/aLEcI8BpTe0tcw/CrJ/YpdbFwY7cI=;
        b=alFxSwHlDYiDKJy5JJJ1PfAZ0+PySf5Oeiqc8ciApXW7nMksKqkRcCSm+TdtYc74Lc
         q1E6xcJA2d+6Ib4IEAbJ1mhOJP6/Cl1M8+hZ7LllTUWeLTlteGy/sMV/ANjZYfY9irGO
         YaThGZtlFnfIII46mvnYH3NMsJuzQvuuz6B6loMopU4QsbxzpvGRNx93dcaqcGHxpe1q
         //mJG83ye5NQmtRdpqTIljwdWT9NbBB7zO9buHjjXp1ugeqx3j6Gmc8Q1YSLiLev4Y+j
         haTsfciWDcteY4oRXU+C7ppYDxADaKmHLYIPBhPMPgVRIy+EeMFxKfWhb1cq3Y+upZ9j
         bpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748413207; x=1749018007;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLqAnfYqDvGKq/aLEcI8BpTe0tcw/CrJ/YpdbFwY7cI=;
        b=QUjGgGOWse3wVGgedujLjxoFhVYj1fPQd57BZLJmGUyWdHEJZVMUcM92NG5iAv9eXq
         FRCRUFCkeDOkbXX2dT6xKxptoWjKvQhtp+b7YgvDkRIjS7BXC4OIkpgEe0VQkz7IclvG
         6rZKyBANMRhcfRoir3BqT3GhP236178Dm2TJNMCIFginYNDfIgOwrEHsQnIp3w3EjZqz
         4P7A515z/CA+199maz4u4QEFmEkq3bn15agukjiIvzcHk+nVH6CRIriL4Sph6+oTO5Gp
         dhiFWuPFCeAzXLvtBWBsNVLoVKuM9xnuNA1v+500j66wEgYenlbtzLS72LBR3WFISWye
         KsJA==
X-Gm-Message-State: AOJu0Yy+rN2P3aMyeSS/UaQWv3ls/DqXQeeRGm6vpZiXa06VYWSXUnK0
	gP3a9guAYd9TiL5AJYMFk0DpjcszSEvs6Orad5OWF6ilhO+L6dlXoAdC
X-Gm-Gg: ASbGncsWywGhO20S1XrbR8JPbndUpyiR6gQR3zW6uE41Jpeekqmp0RhOKN+ogbU0XLq
	+29FOm7nuAsQm5EXDh1MQDGQ0lhQuXlht4nTjyZNIcORdKRGWTJmeoIzJeiFdp+TW21KtlMH2ES
	sdQISjWS7Np8Bl5F5b4jaXeToHZ0lkmAtoSS5tU6XvwjfGDKBhcQdfdixgsIuVRWG40e/YgxJnf
	Hr5RJzwrWS6KeDw2rxjlR2kZfRQF+skoOx4xW4oBJ9tS8xLoS/F0J8gz30wvmnwa+DI8vWljSwk
	DPXnbvjIOQX1+KROHSkFgYyVfMp+rKbe2O//5vQhWs9bs7hC1xj2E66E1cLfMmr0CBM=
X-Google-Smtp-Source: AGHT+IEqweo0sWlMnuRaV3F2KveIlfy3PAUg3BouqX1NaUumM/B1FlLWVg/GM9ex9ceTwmMMmvHLFA==
X-Received: by 2002:a17:90a:d44d:b0:30a:9316:75a2 with SMTP id 98e67ed59e1d1-3110f20de60mr26352376a91.10.1748413207083;
        Tue, 27 May 2025 23:20:07 -0700 (PDT)
Received: from smtpclient.apple ([119.200.10.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-311e9b65b12sm454765a91.16.2025.05.27.23.20.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 May 2025 23:20:06 -0700 (PDT)
From: oneee <kimww0306@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] doc: sparse-checkout: Fix list markers
Message-Id: <1C18C458-3565-455E-92D5-594520413D13@gmail.com>
Date: Wed, 28 May 2025 15:19:54 +0900
Cc: git@vger.kernel.org,
 =?utf-8?B?6rmA7JuQ7Jqx?= <kimww0306@gmail.com>
To: gitgitgadget@gmail.com
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Hello, I was wondering if there=E2=80=99s any reason this hasn=E2=80=99t =
been reviewed yet. It=E2=80=99s been a month, and I believe this is a =
relatively simple change to go over.

Thanks.=
