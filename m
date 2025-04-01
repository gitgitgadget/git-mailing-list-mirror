Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36593594F
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 20:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743540025; cv=none; b=JlAtmYK/PZdzn2klPvmQ1vK8zMf7qulcV//x0en0tswnRNoKgSwfsXT7f74GyaN7J745XpQJbcfg2ZqEsMaK2R9kZk/BBN2QEfgO27+FYMMSESHdtv4MGckru2nrvQPYzIP73BKR9M7xZ2EvPz7CKl0RzsM5BMIrgpbJ1kvYgTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743540025; c=relaxed/simple;
	bh=7HfHh+hwzBXPygZB9zu/JGLqqBsR5C1bnttl27yad3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/l35Sm1yaajZ6GhTL65qF6FBL3hyvlYFqObh7H3fyObC0KPxAr61jytgnZRyQVHzDZ+r0l7rOA8eYv6lJ49G2DiV/HVnoWsHA/NH6EqlePDvn4bTJap/S0AUkNY4pXNbS/Wa3E0xiPLpqwU0csQgipiXkGVOb+v9HUUSsAw/9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bULWI2Ly; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bULWI2Ly"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3fcfc85f1f5so1829600b6e.2
        for <git@vger.kernel.org>; Tue, 01 Apr 2025 13:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743540022; x=1744144822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BGP+VGEacfDg08XyrM3+WOH+pfseV7U2TKurD1ZIjU=;
        b=bULWI2Ly6koiWgng/qVRzN2q46u/w0r1M7Lnfel7NI1rT00Y1UrFs8E5NY4wvbvWam
         f2orVx9PSqUwnnC3valS4zD0cWxD2xS7bfbZppSv/XTW+lP1C9B4wZAJxpceY3V47XUg
         57brNLaIut9QbYDJMeCs4UMS8WTzz7piw7f7QDftosNUGacRd4JkCxUGJr4+sUycgQcC
         zcvP6Rhah6r8stzqbJ1aBYy7yf+xHHY2FVACk0bp6S5fTqX2fmv77DttbX7wxC5IHOz9
         gxpQBedv1OHMSYFWWMD/I62sTzTlSvepxlasF76OICWkNRYCNVNFYCyzR5ziMvHUUMIR
         K1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743540022; x=1744144822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BGP+VGEacfDg08XyrM3+WOH+pfseV7U2TKurD1ZIjU=;
        b=KMZ4MQueQhphcWrW+gUIV/Opp9qq4gIO0Xjuy1hZQeEGVPHKbR+6QPWblH5S+dUXpk
         eWn0DFG+dbx3Wk2yfv//WPJB9AoNDENEdiGzBUyxGebftsv6l+VQhbQKcDZYbGSxVK3E
         luTEp4KdI3cQM4h9onfJmRMRobinr2MFm45pRhwGpJOP94B2H/XjUvP4NWzWPQRWMtOu
         nDcaCbP+AZdIodF+29N3fzWQcUu0FXFATMySmul78d5TEv1NrUiyPp2Et0jyrYvzxurz
         nY2NGqPKBFk8CcihhHn31PteuYWVc6jUfsyYSODSjHV1OHSgFwp+5x5vDrDCklCcQKUa
         Nt8A==
X-Gm-Message-State: AOJu0YzvL+le9n1EiJx0lzW3IjzDuJkZAff3Eprt28mYcs949/OjALKd
	ouW12rWF53zlT3d700dF6oxDebXHTL0Uzz+y1LqWAoFDfE1I615o8/HJkw==
X-Gm-Gg: ASbGnctAfaKWjYsdx8Hcv7pMA2Q1jK0A+yqLm9paAQzS01NmDxLreg+TVdHX7yJAPzF
	zR9aA7nhJqyT+dcmApHGCucHCB6gUG3V1IAxzknmwa6AezqnXkJapsGLk3W+KR2m3uLvzkS8byx
	u1X7TjFYsYpnZz5543Q4B2ROSXef+mE7JNoExcUpoMAZEZWpHufTX6wm8G8DVhGtAW+yIeC2EBs
	Kx1z3NHtT75zOSQfObiVpvWB6gbG6srJqovi2iXjE//Myd5aH4WuhwnKOMX06lAgbIWFNkWFhwe
	/M6nQGETz/chLX4cCqg+b9YSFKoitE7jsTvbeoG/HfQ0vyxVbEeJ
X-Google-Smtp-Source: AGHT+IEAiGL50dMWpCK9O9QsS6hx1kvrStw0/zbn09CfK59cWVv6kbFmDLZWvEQJCweh/WhzOcVSWw==
X-Received: by 2002:a05:6808:2101:b0:3fb:54b0:caf6 with SMTP id 5614622812f47-3ff0f5c2c94mr7812920b6e.36.1743540022291;
        Tue, 01 Apr 2025 13:40:22 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ff051aa10bsm2100953b6e.23.2025.04.01.13.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 13:40:21 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 0/2] help: include SHA build options in version info
Date: Tue,  1 Apr 2025 15:36:28 -0500
Message-ID: <20250401203630.285451-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250328170121.157563-1-jltobler@gmail.com>
References: <20250328170121.157563-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

Additional information regarding how Git was built can be found via the
`--build-options` flag for git-version(1). This currently does not
include information about the SHA-1 and SHA-256 implementations Git is
built with.

This short series adds build option info for the SHA-1, SHA-256, and
non-crypto-SHA-1 (if any) implementations which may be useful for
diagnostic purposes

Changes since V1:

        - Each SHA backend is expected to define either `SHA1_BACKEND`,
          `SHA1_UNSAFE_BACKEND`, or `SHA256_BACKEND` as appropriate.
          These symbols are then used to print the SHA build options in
          the additional version info.

        - The names of the build options are used instead of
          human-readable names.

        - Appended "(No collision detection)" to warn about SHA1
          backends without collision detection.

        - Renamed "unsafe-SHA-1" to "non-crypto-SHA-1" in the printed
          build options.

        - Small updates to documentation.

Thanks,
-Justin

Justin Tobler (2):
  help: include SHA implementation in version info
  help: include unsafe SHA-1 build info in version

 Documentation/git-version.adoc |  6 ++++++
 hash.h                         | 11 +++++++++++
 help.c                         | 13 +++++++++++++
 3 files changed, 30 insertions(+)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
2.49.0

