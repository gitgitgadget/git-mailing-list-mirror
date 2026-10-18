Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30F5395240
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792356800; cv=none; b=rg9S9IXAKVRNHIGrCDefT0aRSz/XXkJaDe7khhlk3DE5+SARME/DSCdJ+YPADggORCJ2POAFO4Xy4EUZQRm8seEo5wBarOygaeHN5/jaBkgRs1MFdLyk43HX8WrUrvHtDroxnxnRFkUp4lK46l7EIF2rOb4NBDTWIo8EOBx/rqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792356800; c=relaxed/simple;
	bh=fGI6EZcOgfn1bWw2lLhnRfynrdWu46BgO92/feqGGvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XoRB4gcJ/KpDj6QYmlfM4yxbWsQGPAsfjDc2Dj/glOsA+gXql3t2xtZPlpfgvN657RMmmmC2xXoWpABtFFilwqPy8O81Y4GLKpv54w3p7eUYsmje0gkzEaCaoOxeMGq2KS1jhZreygyWhXoYMc8hwPmeHMUU1+DktEyy2AqqRf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1LTvSem; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1LTvSem"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e09aa5264so704390f8f.2
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 13:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792356797; x=1792961597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fGI6EZcOgfn1bWw2lLhnRfynrdWu46BgO92/feqGGvA=;
        b=A1LTvSemH2S2HTuvKmTC5AHgK+jWdE/Sg09BWNrPrE2XHHoh3SRGkm1ggS1/9kWax4
         QYfFOnPMpgtcEAC/uU/VMtudmA1hm1XPhq+OwI+6bEeI9xdYnwcBL7PNz36WJK4XewbO
         ZnKj/Mu6E1FxswxgF263JrbaMKOJdn9PEYMnU5Q402CC5UvsEFnvrtbbRAyv6ZfiqLI7
         hEBydduArQXxLS3MQXAzZEj2FxWRQOFaGk8emanT6eyqwiH8ZVRmfXI24UpaGzv5bDgX
         d2/NsqBfgNnfsQTFMV048LO8F2RdO7Jnrs9VqJWJVDbWzo0v2JqMshcyddJs9KUyl8PO
         SBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792356797; x=1792961597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fGI6EZcOgfn1bWw2lLhnRfynrdWu46BgO92/feqGGvA=;
        b=YTs7WfZlzE5mgOFCAc1UCLRsL6Mx/DYXD+O1+z1rQIslbBy7cPUat361+MdLEXi8n1
         o0EX8Mw+ni7QXfTpKOY0H9aurfPnNkbpnNED+fy8iQpy6HsKqDeEtNsn/viZujWMqfRK
         iU7/AANtRnCw0uBH44cIi2ivthEZ1bVQQJFZn5QlzXpBYxalqXHmKO0cQvE1R/TRoCzr
         yk0XKXCAOePc9IyrBAd2oYc9PlQiitlcTvfTpVQNenWpYtUobiT3dtCRUxOl65wiD0RC
         E4Wd2zr9spu+6exDxcRX9NL8p+OWiH0oKVf0Bj6WwGcK1atvRXNumdQsjnrjDlp7yHM+
         e8zQ==
X-Gm-Message-State: AFq9FYKzyhpTSGvDAK4eO85RstbzWOrUBpWAaPMwu5vXW0H/OWWw1LQi
	ANZ5nmRsqBUU/ejFoLf908uEnKhT/bMjeonERq09l4VZ1h4+dM9Y3QSXHC2xJzHk
X-Gm-Gg: AYBFou0T4LxRsNRyZetHffhPyV/AgMHdWM+776NblAys4JKhphktndzef2OcBcP7u6k
	z2CEhm9Ol7DjtBAKezZQFM9fQIRiHKMbpfMkPZpFk2ee8K2FByB+GaH0oNjsFCw+IlXbYL2ZhQj
	zy6pmw4IC+GP/ulPAmGJULH7DWIeNJLjimxRe1/styI9AoWqBafXV1stbbsxBvWBiXjuvxHzJ9s
	dUiXWPIcIbcijlPkbZDJVbLnKEdY5l/FWBh3/GveXjNKm98ohoeirt3EQsM37pKShnsFWzz0iq9
	QPD7hcp8PLQeya0G2PELv4cYodAylqoNbVpD9WoN4gfBONpglR4F5v43w2DPIyaehFKtu3336fJ
	4+qZMEe0Mf65TcO84lisRiFhr4daAzD4+ejVfxjEO9WK/pHo19EKOIECWT8DWcwwINoPz9OFXYG
	RTPDoN+SnlFvMtGjBkvDbQQ36QlhyuWEErbTyClWYZiK/CKSce1SBQ2sEwKAVi0z3UfGIR1NFtG
	XGP/+tLtxW8+fv/+A5W5ddW
X-Received: by 2002:a05:6000:1888:b0:48e:2b3:5269 with SMTP id ffacd0b85a97d-48e07f9c8a3mr13155615f8f.45.1792356796691;
        Sun, 18 Oct 2026 13:53:16 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([102.244.156.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd471a64sm20119676f8f.6.2026.10.18.13.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 13:53:16 -0700 (PDT)
From: kerylefondji7@gmail.com
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	gitster@pobox.com
Subject: [Outreachy] Microproject: refactor archive-zip.c to use Q_()
Date: Sun, 18 Oct 2026 21:52:27 +0100
Message-ID: <20261018205227.1440-1-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,

I would like to check if anyone is currently working on or has already submitted a patch for archive-zip.c, specifically regarding the pluralization of the "path too long" error message:

return error(_("path too long (%d chars, SHA1: %s)"), ...);

I checked lore.kernel.org as well as the commit history with `git log`, and it appears to be unclaimed. Please let me know if it is fine for me to proceed with this task.

Thanks,

Keryle
