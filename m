Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337B239FF3
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734736744; cv=none; b=TyBYlX/kndZ1YKA7sWEBVY+JlLOHjjDhrA3XAhqfBA7ooin8fyDviSGhNY0UtTvVAEoi/hG+U2Djcd3zsFRrUfDo+rFHjbZTHDloTYONQveOMukBrN6+oCh3oZuyymwAZeHUUN/WgTuP0r0ez+ss+SDNMBE8Gn5vbG6mjUS9ifY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734736744; c=relaxed/simple;
	bh=k3mcMgsHS98jIf/gTccBMkUYSxK9UUtHXLbSKnOMgf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gxD5Xb1Ovb+/DKcZFfGJ0J2msKRU2GFIEtd4EJRXCzIjdKFL7rLt33UK7cHFl8Mo1vqNpZHmTo36mKPj7hOIuIs0iKpYQjxk4CF0SdyiPUJqQv5Fl6Jabjk2tZQwlhfuvX0957A1cCBlccqlydY+d8MpTzAG/sVBG66eIcVkRFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFyFoLu0; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFyFoLu0"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5401ab97206so2365428e87.3
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 15:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734736741; x=1735341541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CPHyn2kl1c63+78H+aNqfoJNlpHPqYbr5eGmTsn7nqs=;
        b=KFyFoLu05Tzj7DmRSGOB2MUHjU8R9c1QDFs0G8mmRWZTFFj0krXslxW8MKoAAKImzu
         i6RhOzbKaw1dhK5WYJGT9ap9WeFZwls09iaXFLHyQqxCC68w7vU3wwaHxqBejgOgfOp1
         nGaCVjKY40Cyea4DFATTS+bG0aCmE/5bJsu5uWx5kW9i/bf0Xu7Lx6erjitpabphkagL
         ZdaM4IvXgq7FqwCU7LOWLe/UyWIQBDYqK0OPAE+Dw8u/vVABqpCT559lB8bsOATRmQ/b
         kkFaROCDFQv5ogX8zDDMMFDja2bOuQPyPY5KQGViDguNaPG3hmT+M+IVN1QwiGj/Xbfr
         D93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734736741; x=1735341541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPHyn2kl1c63+78H+aNqfoJNlpHPqYbr5eGmTsn7nqs=;
        b=KnQdU6F/x/9fSAAZHOSZ/LDM1TgPq4gK1Nnkpqxq6V3+nbXHTNSVW9glHRXNG6qNa5
         SOHw8DptMtmrB/hIgUUUDfGFbnjyrpMjY/Pk+X1rFXxkwtGHnhNbf9Cy7gDnK9vr5k9B
         7c3lWbSNnzuWC9Q/xMfdaFEaYQCAPGVnZQPAoc27xBYNJnqpLJl96F4dCP5AG1AJKCGR
         VtpWPYZVsqQ+zGyOjqEGeu6DOxehDZNwcNux1Yc4ROBQV9g0UdIfm/dtQpthjoTDxwMT
         EygI3TI0WDICwQr5BuGFyVsnsdXs8hDjTKsPXeubUKPmNjKbtDWLsJAcWYgBd1Jgcm2d
         phgA==
X-Gm-Message-State: AOJu0YyJr6QCrwETQLvqQQA0205p/XuD+UaHdHB6efR6gK764XN+v3nU
	F5npFwCwl2ilRqZcozyevOwN6gSLszV6v16llCG9I2aTo/zpNNHPNxwmfg==
X-Gm-Gg: ASbGncvVHJcAoZAisIFZzGb/CNi/D/stvwyIofkob5CZjDGLmzatbNUw030U3Zx0QuI
	HxVbgUFTFYNobqabssodUaPK7CEKckv5WCm/Wmf3s7sqBnBTxDDwkb2h0Gsn/0UVyg2olW5XTWi
	VUZDVdYKw/hS9PKFs+3wJhlSFp6NQIZgVOpAk/eQQ/WuGImf7YX4GZLNdlBp19MtuJ92kEzsYUN
	lEHde6i/IxXwqUqvOBIeiHKFV6+THB+WbGMvpn1PUHSaSqkiUUpV3yavsIWMK0njAiRKLIbOFAf
	T9vwCBdfox7VyHeeeWnorgVIKNk30Ayr2Vo=
X-Google-Smtp-Source: AGHT+IGNa3vx5TvNN96Q48UJTHqQsfdCwbj7He6sPGdjDBHFEIwzIHvgQM2hb5MvR8tH/NCIzc181g==
X-Received: by 2002:a05:6512:ea3:b0:542:238d:d714 with SMTP id 2adb3069b0e04-542295502dfmr1813158e87.32.1734736740728;
        Fri, 20 Dec 2024 15:19:00 -0800 (PST)
Received: from localhost.localdomain (81-227-45-223-no2667.tbcn.telia.com. [81.227.45.223])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542238137f0sm583733e87.164.2024.12.20.15.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 15:18:59 -0800 (PST)
From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/3] Asciidoctor fixes for 2.48.0
Date: Sat, 21 Dec 2024 00:18:15 +0100
Message-ID: <cover.1734734612.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.48.0.rc0.241.g3cddc25e2a
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Asciidoctor build of the documentation regressed a bit with
a38edab7c8 (Makefile: generate doc versions via GIT-VERSION-GEN,
2024-12-06).

I think these issues and fixes are fairly orthogonal to the recent
discussions beginning at [1], with fixes being discussed beginning at
[2]. I've tested these here patches on top of that series' v1 [2]
rebased onto a38edab7c8, as well as on top of its recent v3 [3] as
applied on the indicated base-commit.

With these patches, I can use

  make USE_ASCIIDOCTOR=YesPlease doc

and

  ./doc-diff --asciidoctor <...> <...>

with similar results as pre-a38edab7c8.

On top of current master [4], these patches help, but for "doc-diff",
the GIT_VERSION injection is still broken (as expected, that's why
[1,2,3] exist). These here patches don't refer to doc-diff or those
other patches [2,3] and could go in independently or on top.

These patches are based on [3] applied on its indicated base-commit.

[1] https://lore.kernel.org/git/20241218113324.GA594795@coredump.intra.peff.net/

[2] https://lore.kernel.org/git/20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im/

[3] https://lore.kernel.org/git/20241220-b4-pks-git-version-via-environment-v3-0-1fd79b52a5fb@pks.im/

[4] v2.48.0-rc0-38-gff795a5c5e

Martin

Martin Ågren (3):
  asciidoctor-extensions.rb.in: delete existing <refmiscinfo/>
  asciidoctor-extensions.rb.in: add missing word
  asciidoctor-extensions.rb.in: inject GIT_DATE

 Documentation/asciidoctor-extensions.rb.in | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.48.0.rc0.241.g3cddc25e2a
