Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514B81428F2
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235898; cv=none; b=q0zaS6PHqwRRQlb0LCA1NMVp4efYmPKDhKBGhRg3kILKxPBkQwyhkqWkybBsWMsWfkzrl05G+hcEWZSPRbo4ejAsHMCZY8V0ygeduLgvO7YhotlGO9hOzLyVOSZyBZZoEpJkUeGwXjczTGz9Y38fNrIetYIpKKZwKOayPwpK0/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235898; c=relaxed/simple;
	bh=xh5+zN91pm7340SSxwh8KHpJjI9npwRCoa7nmGM8gpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbwfIDFICLGiWabLFcrWufvl/aUK3tjaxjXF6fJ/NUtift4Jzv2RqAqEKNc/qenuwSKjCRca3RKy8TI8bevDGgUa3b7Z4ZqpnNqlp/SVVNMbTwtSzO07kwWx6Fsj0wrlSOg/XiHLpCMeSGWK2o4sEhm7wFAkw7omd4dAUqG+RyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPkfjpCw; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPkfjpCw"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3ee69976c9so240125266b.0
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 11:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709235896; x=1709840696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNwfXY2uJqjlT723vc66zOC93d2dPxs6xpIDb2PyEzU=;
        b=QPkfjpCwg1VtpVrqIs2SY3sAVFcB+qIoiRcUdxcc2zEyOiqzuMiCsENxwsjCapRPo9
         WUUhQv5OV/HfRGtkLTFDYNp6uv8gpx0UWqAOhi3ebImU0UKUZ+XN+oW8P8obXtjoZ02a
         qmPk4yMhMIKhuwD835EZzSTM9JUWZMz6hEEn8LM4uRDwWexBCkeQveI8Ezkk5c5H6zCf
         zfhJo0rSjTjyIb4L0kHdMGG4D9WbxUP0fdlS7ePX9ihYorfv9VNKBnrwor5q6hkkFtES
         MU906jgUli1o2f1MpQ3YYiU9G82YR6nAxF1yZs1tqwjyvbrfM3M6By2pIkigJ+HiZ/th
         LAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709235896; x=1709840696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNwfXY2uJqjlT723vc66zOC93d2dPxs6xpIDb2PyEzU=;
        b=FbP9KCfy45QHgFQkM0EJVYhBkcr/+2HiHzHny6INzkdS8i3EXCerdAcXoegjiUWfeJ
         X9nnQJ2A4ZcwSNMJGOaEZnSo7Iv98y4Y0OBUWmh9cqkBuh+Y5o7s4luv7XQCMoNaPGZK
         kduSPs6Jjcly3vP++G7BIV79ECiOu4qSq/9n7+3XwMxmyvSXrsqB+uQ8372KE/+039mK
         o1Nosn1BQG/O7F1wgC25fGq2PttejWKIx71d3SMbpqFEFzEO/jLUK4mYJ62/psoQSWAk
         ZtH64VGaNtPKzS4YZj78ewDoQXk9b8YhR2F8y8e+wV0Cc9GVFHYdkm10t+jB0kixVAWD
         Ss8A==
X-Forwarded-Encrypted: i=1; AJvYcCVKIrBgN/SHhUgipoKKVI9xo5ZC2nvUs/x/V25kMnmesWpefKG+/7RPbUwEyLtMS5FsrkzkW19P9VshuWuJhowpiQsd
X-Gm-Message-State: AOJu0YxniqqDgIrCRoJ5CxcMqkLY7KKkvicjaJeL8tLUk1vRa6HsVu56
	7Mslv6N2xLvk96AJ+IAqSz28+lfq/mjsaojZXyZ7rc+5Yb87RjpVuXyMAI1/GOU=
X-Google-Smtp-Source: AGHT+IHvtBzlWJwX1wCGAn7GELQA/caxpA5WnRzYxGKnW1H1kx1F3/fAG11DjrZ662rFl06Xf7ShcQ==
X-Received: by 2002:a17:906:dda:b0:a3f:1139:13bc with SMTP id p26-20020a1709060dda00b00a3f113913bcmr1907488eji.74.1709235895394;
        Thu, 29 Feb 2024 11:44:55 -0800 (PST)
Received: from eugenios-Air.homenet.telecomitalia.it.homenet.telecomitalia.it (host-95-235-237-78.retail.telecomitalia.it. [95.235.237.78])
        by smtp.gmail.com with ESMTPSA id tj7-20020a170907c24700b00a413d1eda4bsm978787ejc.87.2024.02.29.11.44.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Feb 2024 11:44:55 -0800 (PST)
From: Eugenio Gigante <giganteeugenio2@gmail.com>
To: gitster@pobox.com
Cc: christian.couder@gmail.com,
	giganteeugenio2@gmail.com,
	git@vger.kernel.org,
	sunshine@sunshineco.com
Subject: [PATCH v2 1/1] add: use unsigned type for collection of bits
Date: Thu, 29 Feb 2024 20:44:44 +0100
Message-ID: <20240229194444.8499-2-giganteeugenio2@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229194444.8499-1-giganteeugenio2@gmail.com>
References: <xmqqsf1ekf34.fsf@gitster.g>
 <20240229194444.8499-1-giganteeugenio2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'refresh' function  in 'builtin/add.c'
declares 'flags' as signed, and passes it
as an argument to the 'refresh_index' function,
which though expects an unsigned value.

Since in this case 'flags' represents
a bag of bits, whose MSB is not used
in special ways, change the type
of 'flags' to unsigned.

Signed-off-by: Eugenio Gigante <giganteeugenio2@gmail.com>
---
 builtin/add.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index ada7719561..393c10cbcf 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -115,7 +115,7 @@ static int refresh(int verbose, const struct pathspec *pathspec)
 	int i, ret = 0;
 	char *skip_worktree_seen = NULL;
 	struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
-	int flags = REFRESH_IGNORE_SKIP_WORKTREE |
+	unsigned int flags = REFRESH_IGNORE_SKIP_WORKTREE |
 		    (verbose ? REFRESH_IN_PORCELAIN : REFRESH_QUIET);
 
 	seen = xcalloc(pathspec->nr, 1);
-- 
2.43.0

