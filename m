Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892530;
	b=hfk3LUlV70UDX8pvsA9gC1bzyMAmetpCG8nCMAudElmvTfoJA2KQM700kcpwFPct1JqB
	 tI83RJXomNvi3GHyTKyiWeyXfdPpWy3RdgUoY3MXBCA6HCK3ZiBIPCVTuuSBrUoSn7tNw
	 dnR+oqcqBUKjB3NENYbgqDNVM7iAt0k+1Ouy0Mgk/TuHE833ncCmD3poR8F+XeoOw6U8l
	 75YQknimYqttcgUN6UX2Xu1F6MFWBySng9kUGGaTv4kGjYKnlzBwyMQPZcQpM1SzYdQEE
	 lXrUkxNnygLTR1JjDCJqdq/mbfMLUorEgEspZGC0VaVmbISiVsXjjRYZZfjYEKlPH7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=qMCH2dPoVycDqy5mHAnJWc17jj1CnIvbBEiPyLRd8Fk=;
	b=SCVVDf7/jI0NTU20cAeugj1R0NTlfNnt+wW16Fegz32fysG1+6uNW7Ov03/ZbkXAG5k8
	 SReZjdNSt8AoWuSHGc/NhiYWFIdHX2C9/MCpa7rY+WL4HvIzB7KuwsPvdVV95xRvWAY47
	 yzmcplRbfLqIpT/4nuSGB/foByw/S3AR+yMki2rR0c+RiZrqbIkOrZvBwlY/pmmx/AOry
	 K1fH17X3tRKCaJU336uwJA4tqTOq/P72WNkGK14rk6Be8tqW1Ii1BbNYtblSe+3ecV9qb
	 Hfj1pccplab1IGb68prPccbvM6OQzrrMXeH6R8hiDYu5U/S1+0mAZHW1uYn309ruS5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sYmoXEyN;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE632606A326
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 15:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE632606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sYmoXEyN
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3535a54bed9so2644336eec.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 07:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793892529; x=1794497329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qMCH2dPoVycDqy5mHAnJWc17jj1CnIvbBEiPyLRd8Fk=;
        b=sYmoXEyNApuioV3SjQI28eNZyr5zmJqbdSiC/jtswBlTehBlIDxjgdyXS1OQYwha+2
         HTB+tut3p8sNQn8U3Ep/IG3JgIljKIWBiHLrgPXyhgy55kDfVO3bqwdfeeXzBMkBgMPY
         suG2vDcwr0PsD/u1Vad0Ubm9cy9AlXnezxLghzpmVOzA4UPxucNMR9XpURfNy/sLx1x/
         gQ4P/2BTHvKvxonhPjOh4RJ3+KcS/+SiZ+0nu4wOnHGDwdacQbsJfxavISQjOrhACy9R
         ga36AAJ5pjLJ/gVrwjHCmRm5anMZm3ZzsIkSRiHAfOowqGq3ncUo4hlYgtYeGPCm7zla
         G+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892529; x=1794497329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qMCH2dPoVycDqy5mHAnJWc17jj1CnIvbBEiPyLRd8Fk=;
        b=QFcG6116s5SJILZQVFaHWqo4JnDQ+6fXXkYZePFWYR51pcnuNYgCvZ63ZPV8S1Bcde
         WKeOtg0U6Hn5tsGtQM/jHPXpPCdVsDUAxxnnrcaoMJWUBVIADXz0is6ZcQPQ1en+iIYr
         eY6ljc2z9TiTRW5GhK0nxgKl9IkfXyoXxwLixQ+7hGGEAITYaWJDqVIGG/cuk1fDa2Zm
         T1MlwVAWRvnnruQ95vZucBV8ZfxhE3wNelflISitJLTb03R4RYVQLxPqR8Cu2KQGuu/k
         sRLn2Ss1R5QkNXd0i29beIkn+0Mh+HpgSjGshKQMqD9dgmkEAcSXBxTTh5lAboQkVWd5
         Yt8A==
X-Gm-Message-State: APuU4Z+kcRegWYk2mlzbsDU6XV4qYnabuBCDLfX4+xMVGnXCGevYyZrQ
	qvvKWIazRYS7G/vXvK2yM5PvmRaWAV+XI2ZX0izy+tRf7qltTmed8akx/LSD9nsMdHY=
X-Gm-Gg: AYBFou0HfUC6kLLCMjxFXVGWwLgH1ehMWmxTk3VgfhaU+Djbp0/xPktNitT+NdRDWUS
	wY2qdXyzMXzKiBWK2Fi1Xw/dJ60U4pv/u+3DLGAkuj4sB2OP+xhjebgg7dnWenj1KQ5b+U1h21K
	KRBlt0fPaJO7o+0eK2fNmkZCK0uKU9U2RwVPrcvBA5K9IQx2F6TlI5e/kIB+tf8XP1KQsMOaEo9
	lNBR94U388jYJAeXTfxisKpA+p9L39YI/YxW1ewP5Iv/M4jBlMFR8fpw1JQli6YPrEMO5WATC1e
	qZRBrDqeeGnGQxwWh6qzt5mCcJyBTQpTKXFPUbPLSWEqNi4og9k3KeK8gsjw5vSJ/YRmYWyx+4P
	pOri9KNo8OlsWfH6RrGOfLHIOzeKgOBBN9QoV4i/UbINFN9w2LGBXurauDxSDQHPJmT1wii4cKL
	J/KfO4paA8b3yMU0BFrekSIsskWpj2s1pWiXKHjXJw2IBfCDe5geviSDhw8dTgq92w33w5n1BSV
	6K6Ytuz7C3YqS52kRvIO+JWfZFuBXDEdANBDRK1Nkv02LbUKW+o5zIM0PVNfdQXXZ00hG156cXb
	MNYsw6QEdEeAEMuFuXnBkHG67JIA0n3p9CIO3phcF2t12ag7MlH+icOz+tjPKYGWBIxBQE0HzA=
	=
X-Received: by 2002:a05:7301:d806:b0:36f:3996:f3e8 with SMTP id 5a478bee46e88-36f3996f73fmr145142eec.36.1793892528724;
        Thu, 05 Nov 2026 07:28:48 -0800 (PST)
Received: from LAPTOP-PVRSMPQK ([223.190.82.143])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39972d4sm32391113eec.26.2026.11.05.07.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:28:48 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/3] bundle-uri: do not die on unresolvable relative URIs
Date: Thu,  5 Nov 2026 15:28:39 +0000
Message-ID: <20261105152842.566318-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.344.gfa103ac04e
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A bundle list can contain a relative URI that cannot be resolved, and
today one such entry makes the whole clone die. This series lets the
bundle code report it and skip that bundle instead.

Changes since v2:
- split into three patches
- reworded the commit message to describe relative_url() as a thin
  wrapper around relative_url_gently()
- the credentials test now compares the full error message
- the error names the URL that was passed in, not what is left of it
  after some components were stripped off

Aniket Gupta (3):
  remote: add relative_url_gently()
  remote: do not show credentials when relative_url() fails
  bundle-uri: do not die on unresolvable relative URIs

 bundle-uri.c                | 10 +++++++++-
 remote.c                    | 37 +++++++++++++++++++++++++++++++------
 remote.h                    |  8 ++++++++
 t/t0060-path-utils.sh       |  9 +++++++++
 t/t5750-bundle-uri-parse.sh | 15 +++++++--------
 5 files changed, 64 insertions(+), 15 deletions(-)


base-commit: ebdc087dc99d68bb340c282b2ba5f722def28d19
-- 
2.43.0

