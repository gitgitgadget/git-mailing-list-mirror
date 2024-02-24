Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA461B59B
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708774016; cv=none; b=aM3rOE3inTbxEAvaV0861X8GXGeZQscNNkd5S8otK3AdhZxR+TAbO2hP+gDU3/ZTI0el9yQRRGVnf6A8UD3vsPAeEuPImPdGE45vwRxEBXEk6FngMpH6RVItzBeuU8wsFokoz9Nn2zM326obo2qTDbJ5Ymr0l2+bGUlzZOOTpV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708774016; c=relaxed/simple;
	bh=7pXpqWs7ZbrLBIJN+1KfY3B6lQeKtYAwiPqrOcv94CU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CrqKAOMcBS9zN791jlcOUTrwlQrn/irkWQvnc6p/wfkuUzinpHm+mEw4bfqesRTSVTB9Yv/9AN0d0nTLMFVoiZojZ+qxRm1wuvqX/xPahI3erCciyd0iC2njRoze/K+rT3MYg7tVCXnasy4Ps2tOUyDqRbRPgK+2xE3w033z7Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrDL+oG7; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrDL+oG7"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-564fe0273e4so1222873a12.2
        for <git@vger.kernel.org>; Sat, 24 Feb 2024 03:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708774013; x=1709378813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y7UP4dL7cxIVooSMCzadnepZWZbtp8e1yoeiWD5jSKY=;
        b=LrDL+oG7nNCgZ8ZpD2nyuytt89RWYvEiMs0tHnWAbbdyrL8SSLruPvFIXBgpWzRJzK
         2GzxVEoLxvktIkk+sDk1XSOYb8Tehcy4uwmu6btcbrINW2lzncSD/h2euJfwNfmr75q2
         LojTiNSwJ2VfJa50JNKE13hLZaH8cXWLVC19+kXCMChrdKhSST5BKOguKxK0hzt/bT0i
         aEtmKB019280AycaevgDJgZpMEjmRTYqOFLsOq/CXhQxLWhe1sFs+p/jJ+S1X8VP70e/
         duD1/E3fElDgjvsRBGYSGncLjNJ39o0aWLrmDyHvVxbVro64VbJ7nh5lNouWwQEzFVqq
         u9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708774013; x=1709378813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7UP4dL7cxIVooSMCzadnepZWZbtp8e1yoeiWD5jSKY=;
        b=O0k2iAA7SVe39dx25bi95aXVVyltTrTn/PC0vvtyRbki4BefU3hN4NYdrKmvmLqxh0
         4kSR0IlJc4jcteeJeP07XYN6I996KcWMSmyPASNp7fLoFuowJnfzMRj4U/LmBlyVVqMJ
         /eM8rBDyE2NgZ5/nEUI6gIJQRz6g7UXF3ZvA4qwp3gPtRw7C7a9PT52GDpkDJ1xc7Als
         MSCt6geVKcOeJiy3wrVI5VOpqXaOxUbnpoAdTwdUcHAIYnDjwRUeTlj+TJUnXpOLfGRb
         38jSaVaymPLmXjFyavdF+Dhw6uKmdER04+bLLjpM8NhdCUbsXQg60aFvr036LqJ1STIj
         rYFg==
X-Gm-Message-State: AOJu0Yy1nf4gqv9UdjisqIRfHZzO0wU26yTzmDTzReCLNyG/26oDMULE
	Wv2N+jk03Kcx8jFnSF7YnRF1dMgL+vgjqTwS9S/6XnYMwNFgtdg1EJlkPGB5s+A=
X-Google-Smtp-Source: AGHT+IEDVJnZKMQZE4aZ6mspFAdlJxHydD0cyyHi09G9oEFg/nnovyXuwSvX2bADJHaV6zbX45GbWw==
X-Received: by 2002:a50:ed87:0:b0:565:bb26:545c with SMTP id h7-20020a50ed87000000b00565bb26545cmr74030edr.13.1708774012728;
        Sat, 24 Feb 2024 03:26:52 -0800 (PST)
Received: from eugenios-Air.homenet.telecomitalia.it.homenet.telecomitalia.it (host-95-235-237-78.retail.telecomitalia.it. [95.235.237.78])
        by smtp.gmail.com with ESMTPSA id c17-20020aa7c991000000b0055edfb81384sm449477edt.60.2024.02.24.03.26.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Feb 2024 03:26:52 -0800 (PST)
From: Eugenio Gigante <giganteeugenio2@gmail.com>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	gitster@pobox.com,
	Eugenio Gigante <giganteeugenio2@gmail.com>
Subject: [GSoC][PATCH 0/1] Use unsigned integral type for collection of bits.
Date: Sat, 24 Feb 2024 12:26:37 +0100
Message-ID: <20240224112638.72257-1-giganteeugenio2@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One of the suggested microprojects for the GSoC is to pick a field
of signed integral type that is used as as collection of bits, and
change its type to unsigned in case the code does not take advantage
of its MSb.
This patch finds an example in 'builtin/add.c'.


Eugenio Gigante (1):
  add: use unsigned type for collection of bits

 builtin/add.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 2a540e432fe5dff3cfa9d3bf7ca56db2ad12ebb9
-- 
2.43.0

