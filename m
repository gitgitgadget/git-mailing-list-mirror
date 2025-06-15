Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C866314F9D6
	for <git@vger.kernel.org>; Sun, 15 Jun 2025 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749990409; cv=none; b=EMnN2FJBCbmC1QvgIdVDD1YM6olgmP1RJtFNaj7684GGS7WIpFCk9SeUJ7nvujXzzkabE2VqeMYuioIziIyVLUblon45tw91N3YP5hQOjwTPdppBVUFUIsGAWQ+Kk8rg0FbFMqXpVqebwVMV65Li/ha7mca70RlNbUVoF3PPsC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749990409; c=relaxed/simple;
	bh=JOaOgmNkOeVXbawylF8KVXG3/768qg95yyQckTuaJx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bEGuSfdzOh5kp3LD+LZV4TJ5XZlSY9qh2YobMbEOv+qjfRpNNsk/U2KnT5HHYQft51Ng++55yqQNOrjgqnWgeor3YRng056RWBUtl7EQE1Onk+uWqsdFclepFNcvImJgJLsq4n8OS5UyhrkPAVeH3ve44Tq76pRM0x9T63otmA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=A9WTidQh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="A9WTidQh"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ade76b8356cso709641366b.2
        for <git@vger.kernel.org>; Sun, 15 Jun 2025 05:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1749990405; x=1750595205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qc//YdXMKys2R4/bSmUYZHy+vKhr7McFcUJUx4w7OWc=;
        b=A9WTidQhCFvnIF7OCTmjM1JJGqDQ37Hy6XEcgLWnK+ouE3od2n4dZ8sesPJx3g6i4i
         GfAtp2P99D7WqshXjfSuPZqNbd1/Uy/y1SlOcUT2MOScWHhMGKsLyq37BAGRo+lKr7oH
         df47x5cqwvwakFPXo4U1v5zLDSDxaCysH+hr1sT6WEFjqRpxOFr+ydKXIn/9FxxN83LV
         jsd88ZG8jy2s2C0tfPNsfZUq/CCthboddiVzlziK8VLw1CvaKNVJnTNdsLUL2iAaor9r
         ALzA2PgkwxuwUjDNmC3Y1P1Qpzpgpsgl47iFEKHZRCYWvoPUv8GwMcxpqj/JCbA3ytRz
         VKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749990405; x=1750595205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qc//YdXMKys2R4/bSmUYZHy+vKhr7McFcUJUx4w7OWc=;
        b=k52IVvMzwQa0fHe89hy0kZM/5fFViaWRVkaj5ZB5xGyFMbb8QyYRnitnzqZ3E/LjXF
         Wc5lN7Qwu5NgXO+ruWxvpRqShPRn6XAE51+6NzElU6Xy+We9yMcEgQAE00Fxc1jPoXf4
         ZOy41nlOJeQgdwKjW/2x/L5tcIIg/9SLMdRuEy+5AiEGu3CYPfFa0sNZPgnTLztT/ckb
         Nu+dXLHEDFndGUPLe0kdLrv0SYj1OBLGECej0eIsrSPBB8SdrW/Hyu0mec+Xw88A1ZRE
         QSWriqUBacOqRqJEofoxFj3w0FCqXopsLutd3CrqBPhhfzU3Eb0XA79WUJvkpzbnofiL
         rslg==
X-Gm-Message-State: AOJu0Yy2gh5/39EwOJ0fNWN6O4NzFPq7w+eVR4NU3xa1YarwOrzcVVnk
	P8XdVgoZVNJjnZ8k26Sp0I67Lgj/Ww/bzBuvIZqKrTS6rCGymoZdPLkR1cuspsmdMKmAZxlafLp
	4ToToljk=
X-Gm-Gg: ASbGncsQf9KAe1r7etyOAn0GdcOd4W1CT1KnwDS15sBpphd2ZIM1gynFw0+d1h9WqPy
	/34x3T+esdsFBNaoMOlxv7G42YznlQLGonEMiwPlBLEb/Uze4zQ5isxEgYQMuOR/UEk5lNHZjkj
	NXSHw3CxJQ9jD+HsiTi4cPbt9KvIAWbUy66IeaP2ziROH1IP5fQn313o74sKO4c9Pxfg9APw9oX
	WAyAbGqaZwTAXEC6lqFNRyM4EP7029gKuR9iuRLS79eG36ASitbMIWWkKyixJeOL3UVtg5efoHj
	KuBDPComxEeRvwblp+RwZiHCJsNS+3254TeULmL4Pd8uOVSSQPSS+7l6ONpsXAOMRkKbx0KSVwU
	whhVPd3m9DQ==
X-Google-Smtp-Source: AGHT+IG7t6WDVR+5vytXW4zcvrFi296xjclPDexqGsQr8ksbF8qiCN83pE1Mf2x6U+2S0Mea7CeZrw==
X-Received: by 2002:a17:907:3f8b:b0:ade:409c:2cb6 with SMTP id a640c23a62f3a-adfad6fa84dmr546434766b.59.1749990404943;
        Sun, 15 Jun 2025 05:26:44 -0700 (PDT)
Received: from localhost.localdomain ([165.225.240.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec897c1fasm466469066b.168.2025.06.15.05.26.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Jun 2025 05:26:44 -0700 (PDT)
From: Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org,
	j6t@kdbg.org
Cc: worldhello.net@gmail.com,
	gitster@pobox.com,
	Alexander Shopov <ash@kambanaria.org>
Subject: [PATCH 0/1] Resubmittimg Bulgarian translation of git-gui
Date: Sun, 15 Jun 2025 14:26:32 +0200
Message-ID: <20250615122631.41988-3-ash@kambanaria.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Johannes Sixt,

Sorry for the cover letter for a small patch. I am resubmitting the updated
Bulgarian translation for Git Gui in the hope it will manage to catch the
2.50 train.

I last submitted it more than a month ago:
https://lore.kernel.org/git/20250529215350.60054-2-ash@kambanaria.org/

Is it possible to move to the same format of po-files for git-gui and gitk
that git is using - without comments pointing to the source of the string?
This is achievable by doing msgcat --no-location on the po-files.

The smaller improvement this will give is the smaller size of files of
the distribution. The larger plus is it will make the diffs we send much
saner as they will no longer be burdened by the changes of line numbers.

Kind regards:
al_shopov


Alexander Shopov (1):
  git-gui i18n: Updated Bulgarian translation (578t)

 po/bg.po | 3608 +++++++++++++++++++++++++++---------------------------
 1 file changed, 1787 insertions(+), 1821 deletions(-)

-- 
2.49.0

