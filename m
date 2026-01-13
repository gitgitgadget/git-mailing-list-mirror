Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89762E541E
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 18:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768327464; cv=none; b=pF9j9IJD203yxeY3C9WY9Nr3ZYLsbfUCiwf10o4GwghN7HdIwVqj6ZRAwLenOe6if+ZynN4aXGHE0b1Hi9HtEC9gluMZtgO8JdH5lS9fI5+Tavu+MTImWOduwtpVkucUZRLxP1bXtnkq7K+PxNQ0x6DOFP+Qb3dmUQsw/JGjP/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768327464; c=relaxed/simple;
	bh=m6wfzmO6HJDgRxFeaRxOr2h4hV3gos62FCQkadXKIcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XhGTzVhkqEbS7UlUW4cvoBpkEQ+ZhmaBYZm/Sda7dgLm8SGe92F12Cy3xYx5wKL7OLUdn8IHFlyw9BcfPPcFbquk0dk0b4B186OXXL8IRC7iPXU5DiNwYp/K8JUGdoVL/fPGWw1eE1VqOffTdA4jc4Xn+z3tlC67X1Scozw8+Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5OD9VvT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5OD9VvT"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a137692691so51608005ad.0
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 10:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768327460; x=1768932260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dvt84L+kW/QVpP56iVVjmf0lClxOe5xXh0N1/UT1lnU=;
        b=M5OD9VvTTzGL/LUrG8DCRh3ilqoAPj4uWqctEb1DkDwVq9u67Qq7pB/9hNlsFzW7oH
         v7hG14OPzF7tiq2KCBSdF3loXtny3xCofEvnZ3FpGSFdxZnWsySnNxM/35xNixcFI3Za
         RXu0MmSyHrOpUbgIBE1gj8IUXaD1bbUR+58MWrR+9L6HxdJOrLBCdOsxnsSHthY3i1Nb
         Za3urCjYVYluLM7u7WA6jPAFfPqTvkmZLJDju2h87DG/7i/5HlSY9eGE5tyD3DzWdpQB
         ONYc4SSoDsleAwtGEbnEoK0vaPATUdgaiWGqHKNun5ZdJm2KmpuLdI9yTI+1XCphpqgf
         vsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768327460; x=1768932260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvt84L+kW/QVpP56iVVjmf0lClxOe5xXh0N1/UT1lnU=;
        b=MengWc1XkwfKJ+ZthE7HpCkgAbqCdw4AB4Fc9FLMq1kQ7b94kyi0eFQYqrlJjlbrSD
         O4xKUwCsdmyBNp0o7xUjlWL6HWwxGjy6uCtK0ftkrKqgQuzQ/7vOlfQZP5TpvIufZr0V
         oq8F6/DM+ixKKP/NVyg/R+w9QL6b8fvFP3AkIeweQxrFuAkC47fAcYZs/6So0mvR4sAm
         Y7KqS6MZ6h8uA+JjpsUNKyruRxZ8cRHNuPXyA3Y93k8DVbMY0G65yqg+Abwajxdpb850
         7+XTi/aw5uNgYqxebquEhBFq6LroT7/rNhJdAsxOTwUlgORyk/c4B1lUHhgdbJLKFvLh
         KQRw==
X-Gm-Message-State: AOJu0YyjK3Pb8SaHQloHwt1+/novG08L2Fu2VeNAKSFMWDxXwR8UNDME
	apNloVKqwjuyGPErfGsz9pzPBnkcWeUVym9/cZZTVSif4UEhhABpY3hNtc6Z8A==
X-Gm-Gg: AY/fxX7mUitV0HQ1/lTpVU4kEVEOSZpiDXB8GNsm8q8G7g0/Z/r8TQ0PhbeBRlpODh8
	IKidbtfTRg41PCXDwHggMjq0AGoPHWdUuuoKGAWhlP8Sp28wUMvYdDcJc071C/HXPws7vzTIf6Z
	FocBjrpytiEDS75Nug3VVOZXSXanTnIv4lELNVF2KxBsLB9cRUokHpu0s9vvN9MDNLicIIuHa7+
	xR4mjR3I5MRfqqlHc8H9eQA8rhRFFSzeKUShMHo8mM2/vZlwCtjPAxcMHIxeM50g2rJqeDkomXE
	BisI0I3p3bUSKnynmkknIAjYdvvoEi9AV4135AQgSMPt5TA8ROmWqJQtWNuAyuIah0U2Ofa5YSe
	N5S/BNpqhciT2XiZNeXsR2kaLDlfdutHS0++FXJMxd7MjByvgd3Qe7FMNG3uxQ7uQ/juLZTAJkz
	3Hsedyrgm/JCvEAD9DH8bV80Juq2kycToyTc6XOcVaEX0Sxyl9XY13E4OGUglL22mauPbR
X-Google-Smtp-Source: AGHT+IEXMYd/EnEq7zhLq4SCvP/1uCgCJbetSn8zcJRTYjBlbFKsxXjiLoHH1eO+pQQlLaYBrzGNqg==
X-Received: by 2002:a17:90a:e7cd:b0:341:8ac6:2244 with SMTP id 98e67ed59e1d1-34f68c280c8mr19967820a91.9.1768327458822;
        Tue, 13 Jan 2026 10:04:18 -0800 (PST)
Received: from localhost.localdomain ([115.98.232.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fb64bfesm20852723a91.9.2026.01.13.10.04.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Jan 2026 10:04:18 -0800 (PST)
From: amisha <amishhhaaaa@gmail.com>
To: git@vger.kernel.org
Cc: amishhhaaaa@gmail.com
Subject: [PATCH] t0100: avoid suppressing git exit code
Date: Tue, 13 Jan 2026 23:34:09 +0530
Message-ID: <20260113180409.36683-1-amishhhaaaa@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In t0100-previous.sh, the exit code of 'git cat-file' is suppressed by
piping it directly into grep. If git crashes, the test might not
notice.

Redirect the output of git to a temporary file 'actual' and grep
from that file instead. This ensures that the exit code of the
git command is properly checked.

Signed-off-by: amisha <amishhhaaaa@gmail.com>
---
 t/t0100-previous.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t0100-previous.sh b/t/t0100-previous.sh
index dd5d9b4e5e..ffe3fda495 100755
--- a/t/t0100-previous.sh
+++ b/t/t0100-previous.sh
@@ -40,7 +40,8 @@ test_expect_success 'merge @{-1}' '
 	git checkout other &&
 	git checkout main &&
 	git merge @{-1} &&
-	git cat-file commit HEAD | grep "Merge branch '\''other'\''"
+	git cat-file commit HEAD >actual &&
+	grep "Merge branch '\''other'\''" actual
 '
 
 test_expect_success 'merge @{-1}~1' '
-- 
2.51.0

