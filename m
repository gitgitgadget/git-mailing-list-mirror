Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E128F6C
	for <git@vger.kernel.org>; Sat, 20 Apr 2024 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713642696; cv=none; b=hD9VvblU7HhDSTr3L8c4+PAE8hlN6vtpUVwKL1ca3BkjrC4HTZwIzGj+hqOWA8VmNLMKGaHO8GAe3g2pLlWMz+9A50/1nuYKZHy0EnDRxBt6Y4rlsk4nRry9ENLF3Cs2XzLL0TeIAnCizo9Cx5fIm8pjiYergUC0lGoeb/tYVEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713642696; c=relaxed/simple;
	bh=iqF73N1NPQOinjKGiqyW5u8GXdGPsQNDoGi4kcryBKA=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=c33MqYkopyeRmCYJ+u5/sNGXiaPQE2yEzXRs7XiFjCD1ai8nFWlNNHkTS1kiLX1n3BqiBqm8Yre2gXeg1lJfm2Mkh5gw3mpaoZFDjCepTpdlhlg2COa4UCJpzqzlYZOf+hJ77hw5KB2YUeqB++QlR3IiPfGRkJkFEvul0Ym2KTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/qQzgDP; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/qQzgDP"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3455ff1339dso2192263f8f.0
        for <git@vger.kernel.org>; Sat, 20 Apr 2024 12:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713642692; x=1714247492; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X9xP22F6O+ojrYMHBzE0/LZjFci/C3o6amukhb9yqPA=;
        b=G/qQzgDPKI//Fig4s+YIrqpkEfmUapYEQWWVK1W3fA4LYOBLUi8gcUJrKom1fdzNfU
         Xch9C8KymtPJWVycj0JSlTlfIfspMK0vhP5ZF8oy1pCSktbCTs9/WIwgRpXT6mTkawM7
         iqxjpdK5RMhrIDczscKjjtJT96xI9dcYirOZl5ag5UAKNZW0oLLUi6rGhQr7kQkHapLt
         zmRji9f+AblurLP2vTG20AIjXIJRV7awq3gw5MFSDtJ5IJsovXOko5tv7FO+hiNF3Xvq
         PQ70wQuTsvqMda0qZPhbQKSv+Vot1QhMmqvGxMLMwXDTuiqV8+2p9bBW6h89HVhIJ8cf
         bY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713642692; x=1714247492;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9xP22F6O+ojrYMHBzE0/LZjFci/C3o6amukhb9yqPA=;
        b=avnebBj5uo03y9B0SlsZVeIwRZ/DBUhSRAMFc2WF7yS5rGYKdpeBarQ7OK46YJaX1J
         jF7Kue3TsI05Pi12VXVXTdm/b/VQxuGZ8hZGdeViq81aAplyxnRzLqJ3PYquklzxEycP
         5bH2UDHiB3e13AwPN2lbqTHubAp+pVvZhqjWwrI4pBGKTmxCMJ6mKx4mSOIWbAaT7d06
         yBXfrvwL1z4kB8FhEUW0hJQsDjCDGpqUJmlIL3KHScwAY0runtYhEJffNrOfmon+3/Xy
         Cn/aYowrr6vgvNYrnAeCsZKbKmf4/GCicYDZ7VyZ9my9jW+rVlo9iCoKQ7vUBbON9qsI
         E/SQ==
X-Gm-Message-State: AOJu0YzvvDcSbUm5h6ToG84yeNYuYNe7lIrh8P0F7rCcfeHj/BNgxUnB
	vcjmfcWwzcMCcobqg94Lxs1ACHYmQVTP57hgd5zIaLJJSTJX9S9iSZVXDw==
X-Google-Smtp-Source: AGHT+IE1mSTw2sDFfqjhIedgUoHUwG8fbdco/VwPi1241RTPo0NjUWDlycpvRv8i/0FvT3Esxh1PRQ==
X-Received: by 2002:adf:b511:0:b0:349:ca9b:545a with SMTP id a17-20020adfb511000000b00349ca9b545amr4792145wrd.29.1713642691936;
        Sat, 20 Apr 2024 12:51:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a12-20020adfed0c000000b0034635bd6ba5sm7606145wro.92.2024.04.20.12.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 12:51:31 -0700 (PDT)
Message-Id: <pull.1711.git.git.1713642690371.gitgitgadget@gmail.com>
From: "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 20 Apr 2024 19:51:30 +0000
Subject: [PATCH] docs: remove duplicate entry and fix typo in 2.45 changelog
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Orgad Shaneh <orgads@gmail.com>,
    Orgad Shaneh <orgads@gmail.com>

From: Orgad Shaneh <orgads@gmail.com>

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
    docs: remove duplicate entry and fix typo in 2.45 changelog

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1711%2Forgads%2Fchangelog-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1711/orgads/changelog-v1
Pull-Request: https://github.com/git/git/pull/1711

 Documentation/RelNotes/2.45.0.txt | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/RelNotes/2.45.0.txt b/Documentation/RelNotes/2.45.0.txt
index 0570dcd8773..38458664407 100644
--- a/Documentation/RelNotes/2.45.0.txt
+++ b/Documentation/RelNotes/2.45.0.txt
@@ -100,7 +100,7 @@ Performance, Internal Implementation, Development Support etc.
 
  * The way placeholders are to be marked-up in documentation have been
    specified; use "_<placeholder>_" to typeset the word inside a pair
-   of <angle-brakets> emphasized.
+   of <angle-brackets> emphasized.
 
  * "git --no-lazy-fetch cmd" allows to run "cmd" while disabling lazy
    fetching of objects from the promisor remote, which may be handy
@@ -110,9 +110,6 @@ Performance, Internal Implementation, Development Support etc.
    clean.requireForce has been simplified, together with the
    documentation.
 
- * The code to iterate over refs with the reftable backend has seen
-   some optimization.
-
  * Uses of xwrite() helper have been audited and updated for better
    error checking and simpler code.
 

base-commit: ae3196a5ea84a9e88991d576020cf66512487088
-- 
gitgitgadget
