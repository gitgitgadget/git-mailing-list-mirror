Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CF918E34A
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729426666; cv=none; b=ebEfNVSKUKm1Jsw0OiDuD96/y9Kpu7RuHWlZuYgu9BRzoXBx9qgW2eAUe3Cfmhh67QvoEc634GWGBRQS9bUsztOQfetua/vRMrBb39xeJHcfHmaL0e0cvdy4Rnu4qjzIuyuOoTC3rwOdsK/4nc/Ru7HqXsd4ggPh0IYQRCTcfew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729426666; c=relaxed/simple;
	bh=OKq2oQEPA2ECSJPKzljw5xWUgwR76WO11Fq7yxP7SM0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U9KoztpO86FgYpruNS7uPD0FOvM5OIoP/x04Tr8U/DsiC2rXRkFHh2/pt3FBaLGReTTaiZjxEBaa/bnl1+QJrUhHc7bmenoEGwmHHZxBzISGekjEZ8Za63StkiaoEElILw63+LhGubVMrWqwOrM9zDkIoFJJkPy2G/yPD/f9/wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MS5Qibic; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MS5Qibic"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a99cc265e0aso506020166b.3
        for <git@vger.kernel.org>; Sun, 20 Oct 2024 05:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729426663; x=1730031463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LPGDdVNEm57HPhvR3cdZLn5+ON0pLbzZE5YTItHcIig=;
        b=MS5QibicYGUOnAWsxotwmEv3f9ScNCysK2eubKIRAQw79mbysovNkW7bgbK91zrWnN
         lClvtKxt0+eAlOCzzvYObsNvRy4PSsnxGTLj/K16KEDruMrobZSJNYjxSCT8PAbC0Emp
         vv/FfgzUB5iPzPgRLnr0WbaYq31I8618CuTmF8t+SHGVCqKLdnBb3sNB7KmJ/HXhxp7Q
         VNy2wbUiobtdoIIETmlB/lg0qUCEDNt7C6L+HGpvdCAG6ibLuR0VhiVfFKnUZoX4M78b
         H08ww5pbqJOKbWqCsc1aedK8r3lYzc6nBixxUeZDcN15Szbj32EEKgmvMFmLB1jiYxbW
         zswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729426663; x=1730031463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPGDdVNEm57HPhvR3cdZLn5+ON0pLbzZE5YTItHcIig=;
        b=BjhMw+myPrlRA+AhH5xdsxuLK5o2paPsB/Kt7KT1wIbFWeKd+8tG2dfDxYJZlQdrQ8
         JXJGmNjoCmr0O5FeLeJeAKRL2G6j0nmVsD9m4Z4C6Q+SIJnAyCpXq6+er34CFKs8s4+M
         T1i58iPz+5K22nvKBGN0tDMjXE9gyS6pv/v5wzP8oHYfdXZdCPDRB90tdHgDZCEVCPJz
         ZUyqy4lfNRFExz1Dy4tZFpGm0x1HsZGz6Xii4obAjO99OAYos0klmW8kgdHUX19MzczW
         8/oGNc7RxxtnJUZl33Up1wj0LV4VbVld5JioBRUdo7ffT4TB6CzCjAxkxtMO7RFw5ovX
         Q9oA==
X-Gm-Message-State: AOJu0YzFYZKdp1/4iasfo1bBdZtMgn+/8Rng17fKL3/l9Ie1Ug699feL
	KL9b9cM3JMblxsRT54wqfqWWmuN4QllB2Mh0PsOEL2yjgYLQR69Z+YOY8g==
X-Google-Smtp-Source: AGHT+IFw9pzoBqs6fnemGs+iDRnL6rGkUZo1BYtnuyeLg8iqR0x/OhefDx+L2yQf02j3KINGWKgtHg==
X-Received: by 2002:a17:907:2d8c:b0:a9a:cf6:b629 with SMTP id a640c23a62f3a-a9a69a80a5amr831313766b.29.1729426662511;
        Sun, 20 Oct 2024 05:17:42 -0700 (PDT)
Received: from void.void ([31.210.181.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91575894sm84023266b.185.2024.10.20.05.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 05:17:42 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] t1016: clean up style
Date: Sun, 20 Oct 2024 15:17:29 +0300
Message-Id: <20241020121729.27032-1-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use `test_config`.

Remove whitespace after redirect operator.

Reported-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
As discussed in:
  - https://lore.kernel.org/git/ZxFyKXDCJkRZYYQY@nand.local/

Tested:
  - ubuntu-latest, GitHub Actions.

 t/t1016-compatObjectFormat.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
index be3206a16f..0cc62d2a2d 100755
--- a/t/t1016-compatObjectFormat.sh
+++ b/t/t1016-compatObjectFormat.sh
@@ -116,8 +116,8 @@ do
 		git config core.repositoryformatversion 1 &&
 		git config extensions.objectformat $hash &&
 		git config extensions.compatobjectformat $(compat_hash $hash) &&
-		git config gpg.program $TEST_DIRECTORY/t1016/gpg &&
-		echo "Hellow World!" > hello &&
+		test_config gpg.program $TEST_DIRECTORY/t1016/gpg &&
+		echo "Hellow World!" >hello &&
 		eval hello_${hash}_oid=$(git hash-object hello) &&
 		git update-index --add hello &&
 		git commit -m "Initial commit" &&
-- 
2.39.5

