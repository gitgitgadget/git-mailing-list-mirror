Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7746025DD1E
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 02:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773024926; cv=none; b=LkKUDtma5c/Y/HoG8cpsYma7vGSLolh357ZkH845EwFh3Ohk97kAKrly1Zttaw/GI4kj7waj2MwkAkUHKdzFlq85PNaInVozGhTTwIprUQejnTa55AeI8n9eSTa1P7kcuLfiDGuiIjIlRfpleeZ0sI1ACnpUKBshLIZj4rBRpb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773024926; c=relaxed/simple;
	bh=duqqbFXt9gfF7hSVvQiL582dNYLj+5EWGwDd/kNkY0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sbM109gUZsbaqgBDlAei/M1OJ83k81S0+VSvXbSSWMHWJ4+9/6Nn/wIWaPONeKJThoLKIeVCiGsIZSOYbQZ/j8vKPHI0ABQDJcAmd992t8uD7FpVuoo4DUMmKYJjyu3xhGHyY5IABJsPcAGXyR9wVHsYpQdhTI5idE3+A/v0mSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOlh6rnM; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOlh6rnM"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2be26842fd5so2965118eec.1
        for <git@vger.kernel.org>; Sun, 08 Mar 2026 19:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773024925; x=1773629725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j6K0+PUfSLtY431Oq/TE9zdRyRF2pvRE+mvoJHLx/Dg=;
        b=eOlh6rnML5zw5KLCkuCbcnXvumOxedYch6RKPQ6l7UIEfFE03EbrP0vT6vCen2d3J4
         eFTkeDBiFhev6MqZbaLtMFM+UnAHA7hal2I1mBT0JUXy/0vnwizNWMyFOTFlZ+67hYD9
         ND61Q9Yiin6e0zSrIVr18R+A6Zbib+ze4m5EWfkto0ggG4ow2INy1EmG2seVpzBJfs2Z
         iICy18bNl11nnl2k1aQo4XJRoMKHsZItl/B/XAfF1doo1P0H7/f7pqxhOlAsMlwRpVyq
         tvNzye3OwDE6tjZKXY0gamQwQjt76plTkV6KtdIAhCLyV1jfAilSat5zyWZDF8lCRsHw
         5pDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773024925; x=1773629725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6K0+PUfSLtY431Oq/TE9zdRyRF2pvRE+mvoJHLx/Dg=;
        b=KD3lM8YfpMntDO71m9jaJOeao2szCteETtQz+fM5O/dWHDaDE5DC2j7g+CH+mymAbI
         tcja/utAsAq0KzVRo9ym6pLwGQuGJS3rCWExxyA58tvKSoDDlVpKf65krnRVDrpGXC+J
         1armYTOPn64AkZd3kGk4jLccRjtTd4O1vZwCZ9wTofeUIoMi+Q81dL7Ggy040m7SEOwx
         02efDzgnd77u5Vlb+hsQy8G524rSDosQPJyvYFne+YGUHZE7tqi3j/UeCDDXVTQYRVPG
         D8tQldj9xwmjZX4S3aFccxDxsZM2gFIQ999DwZhdzsqT3mRCeaX74sd6AI8uSTc4Dq/l
         FuWg==
X-Gm-Message-State: AOJu0YxaaQLtvSjiZc/x6cX2tU1lHE3gwkeNrEDajqD5g4Kghr94Nknv
	uqNeBKg0XpXaoozioTUnIWfe/42gb+jSy2y64EA0iaYNnkjxif8m5xeEVuYNrw==
X-Gm-Gg: ATEYQzxXAFmej8LISB6wwDF+CZ3+r027WWNUjShS7l/EiJuYuA+zF9hBU/4vEAqvW75
	7RVp/GALxrcmHHYf3sUuRWPJcexNuVXAlXN5fHJ5qg2UJvYm90Bs12YSbrf1FSTFq7txtqeTL83
	EZTUBlnrTKUJKF/O4lTOJGfeXrSdVMZ8tp5VeYNkkEG/kh7S+7iPIcvO92x93ne4ux/tsZJrKe+
	eSoQWsk5t0HWu8zO+oLM55CsWT+M0IaFTywDPbTXNbMKiwdsBC66HEz1oQ55tueVcY5GZ4fUuk7
	1U2P2vdMVph10TnJBgGW7/HErYA3f/mDWYQkHZI+VVTwL37x+cZsiTJ/gsnO6ErwHfAf0MFLcd2
	wZnXlLUr9lBHBwtrD8m/ZnAZSA5mnK+ajcqQdp9P7+nWLNrATKfjoOpX8BdZqknBNr3NfcmOzm6
	5rhDp/jLS0ZUh7yoKZ9NudnaEb
X-Received: by 2002:a05:7022:6284:b0:128:d2b2:143b with SMTP id a92af1059eb24-128d2b2155cmr1678148c88.9.1773024924479;
        Sun, 08 Mar 2026 19:55:24 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8081:3770::36e5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128d4941b41sm3073688c88.12.2026.03.08.19.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 19:55:23 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: git@vger.kernel.org
Cc: Collin Funk <collin.funk1@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] bloom: remove a misleading const qualifier
Date: Sun,  8 Mar 2026 19:55:11 -0700
Message-ID: <ab59807b36213a51245965fa46c1770de10bcd2c.1773024911.git.collin.funk1@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When building with glibc-2.43 there is the following warning:

    bloom.c: In function ‘get_or_compute_bloom_filter’:
    bloom.c:515:52: warning: initialization discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
      515 |                                 char *last_slash = strrchr(path, '/');
          |                                                    ^~~~~~~

In this case, we always write through "path" through the "last_slash"
pointer. Therefore, the const qualifier on "path" is misleading and we
can just remove it.

Signed-off-by: Collin Funk <collin.funk1@gmail.com>
---
 bloom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bloom.c b/bloom.c
index 77a6fddf72..a805ac0c29 100644
--- a/bloom.c
+++ b/bloom.c
@@ -501,7 +501,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 		struct hashmap_iter iter;
 
 		for (i = 0; i < diff_queued_diff.nr; i++) {
-			const char *path = diff_queued_diff.queue[i]->two->path;
+			char *path = diff_queued_diff.queue[i]->two->path;
 
 			/*
 			 * Add each leading directory of the changed file, i.e. for
@@ -523,7 +523,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 					free(e);
 
 				if (!last_slash)
-					last_slash = (char*)path;
+					last_slash = path;
 				*last_slash = '\0';
 
 			} while (*path);
-- 
2.53.0

