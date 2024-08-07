Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B47155C83
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 13:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723035811; cv=none; b=XtT2hjyTiaGAD1/jroEY6jxW09XlUuEQzi8E8bc5D/CScJ6dVO6y0QfAxkKPecqClU0gW8wVUO19GuJCLH5DZipFZSuu69OcGnf3NWZRA9e5V6A2qC6F0J04GAnHZKxt134Pwtqch+dPeFdDqbTUoi9ca59DkHWRY4koCV3SaaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723035811; c=relaxed/simple;
	bh=ASHhSp3AXLRRcdD/+TEUU3Rq76LjXlrft/gGdO6P4cU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xmiu/icKhMs10y+/YBvLC8kyV7xqJCkUyirSMI3TiHFc+SIdBq+RQKBUwgOV8Wnto6gMERmIv8KkyPtENNaXR71SgptsESLPQ2XKhXWO02/hLrSPQ3CUWGdrY0XwFtetQKDnZ2BtMZBn6vzzoB4id5Jrf2mM5yDuWuzaOeL4N5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwZ0xzwD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwZ0xzwD"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so12125315e9.2
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 06:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723035808; x=1723640608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/TdcKqqid0ymDfAkJnfFcM5xNyQRJygwbvTnhG2Uds=;
        b=NwZ0xzwDK6czIUOixWkassCConFjLXKyEDI0PLHRUuV+RznSLeVSWLY6//TfqsEcyY
         9Wf1NlPxIVLlqX++UTBKVrjhq65Mh9KrCeIyhqJ/9+h+R645NC+j3n3A2rVtIGY3rOkk
         H58u1p0Ozzb9Zsb026gpKl2K2zikOPsTtjkmleGAJaxKHrG/qdOlzwlM79gkwjIgY6A4
         53Lp3o7OGndM8c41ryldx2ZtOEkTSG9YGeoq/gVDRf+3FPDHp1owBgpIdGoOq23RSXk1
         /cqFFBvLSD+ZI9qBzbvdQARZZLjyju+p8lDyefKAAWMVeXMdHeVFaiOa1WbGW/Y2CjJx
         17eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723035808; x=1723640608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/TdcKqqid0ymDfAkJnfFcM5xNyQRJygwbvTnhG2Uds=;
        b=IdXsds/d57eYCWKb19zsTHx2UUlk40FEOdJfUK78WlsD1N6IeUfN9aNjxVzKKofofI
         dUdCaWPRGRAaj8Yy/tRrglOH1OW/XPJXDLuqGN/Lf+FYs0zNYXXDRLvT2asDhBKyGzRt
         zwZlV5QROihNduuaFzPVENQT7G+TxwfP+qS9re7awJ6UVXFD3E5TRDUjFEX7FjAtmMoa
         GeAEFWz3wyfSCJIFpRIRxQn50r228EiSW+c7BfjBKBpRO0TBwP5nIpuGIACQ4SYaJV3j
         J2fLoAQ7g2URrBBuL+tEvS4cVpZ/uD4cqLSnzztzN9rN3NtISYp4zC0uaGaDILtXK8EK
         ju1Q==
X-Gm-Message-State: AOJu0YxQgkuIJBa5p8PwdBXfyUOlWjt8XeDWUBH9NfWtN9i5pt3GAfkm
	Bq13UDrxnIRPN0OL4Y0fkt9KAUaqzvGi0VUFaYRS6nbLboOSH8o01/28Unz3
X-Google-Smtp-Source: AGHT+IHdqCkEYXY/v+inrESEKGVKBfs0nW133PyVVh8KCr6TJt23oFvBu3qbZ1JzjA/eOrSGQ1DMgQ==
X-Received: by 2002:a05:600c:3ba9:b0:426:554a:e0bf with SMTP id 5b1f17b1804b1-428e6b037fcmr119351385e9.16.1723035807581;
        Wed, 07 Aug 2024 06:03:27 -0700 (PDT)
Received: from abdobngad.. ([154.182.238.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429057968d8sm29196825e9.9.2024.08.07.06.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 06:03:27 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v5 0/8] [Newcomer] t7004: modernize the style
Date: Wed,  7 Aug 2024 15:58:36 +0300
Message-ID: <20240807130259.28381-1-abdobngad@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Remove whitespace after the redirect operators.

- Move number of expect files prepared outside of
  test_expect_success to be inside the tests that use it.

- Split some lines that have two commands into two lines
  one command each.

- Turn some "<<\EOF" into "<<-\EOF" and indent their body.

- Avoid using pipes in the output from "test-tool ref-store"
  and write the output to a file.

- Change test_expect_success that are seperated from its name
  to be on the same line.

- Avoid separating test Description and test body with backslash

- Use single quotes instead of double quotes for test description and
  body.

- Use write_script which takes care of emitting the `#!/bin/sh` line
  and the `chmod +x`.

There are still tests that could lose exit status to pipe. This needs
to be modernized too, I will fix them in another patch series.

AbdAlRahman Gad (8):
  t7004: remove space after redirect operators
  t7004: one command per line
  t7004: do not prepare things outside test_expect_success
  t7004: use indented here-doc
  t7004: description on the same line as test_expect_success
  t7004: test Description and test body seperated with backslash
  t7004: use single quotes instead of double quotes
  t7004: make use of write_script

 t/t7004-tag.sh | 1144 +++++++++++++++++++++++-------------------------
 1 file changed, 549 insertions(+), 595 deletions(-)


base-commit: 406f326d271e0bacecdb00425422c5fa3f314930
-- 
2.43.0

