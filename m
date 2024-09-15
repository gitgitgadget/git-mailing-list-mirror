Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC531CF96
	for <git@vger.kernel.org>; Sun, 15 Sep 2024 23:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726441534; cv=none; b=Fu2iN+UIniBGHu6uZLk7OdS2OjwS6xxlepP5OQkUKRoTkkUci/8/bv6GSJVyuIlE8RRWgxfH2D5gimAsIP7ywXKtzxMyl7eFywQb/0uNf9AFBZuUW6gw7AUtAW/nNZlCHzjLUZ8cA5Vyi4OkAjU4+lCc2blKJPwF3yG5OKzH7eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726441534; c=relaxed/simple;
	bh=obGIIsLoqTIt1Ur9IWjOt6f9Lndc+geW5kdCZFCFyzw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M14QgSS7fdLO8EpznTuF+P+9H72Z76ppnw2Cqb8Xpf4lM4/PEzBafT0CQ3Hsetz0FZOsd+zLG6Hj+ay0Oj9Ml6XI8RoF5HkqaEVKUL9IjPHuAoRMwfxxgWlPosoglW5nMrGtt7svQFbPEc2vS2zmRqrQgqoKDsIFeDqA+HiWN3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=em3NWs+H; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em3NWs+H"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-375e5c12042so2085967f8f.3
        for <git@vger.kernel.org>; Sun, 15 Sep 2024 16:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726441530; x=1727046330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=beUya29Zlv0T42pPdS50NrLDt0/JVoExAf05z/36B64=;
        b=em3NWs+HijkY6Av5BLGKUfjqJezBOTdw9wwlCQ0Np5HASajAh3oYV4yg4n8PBEehxr
         qe5aQ4GXddjxfWgDf2IPN65uQELy+IEzf6OElGum3s0IdSpDccTAQNd5jX72m8aYygJx
         e3vQWbYN7zjGoV8TpSzfkdychDrm6WNQHEbOmjTfm4mSItj+RdxkvKQukh/Z2WVrkEjN
         3Xt8D7b8SV4Dxle/TE6hxnCnzfGZ1WQpd51UosE7QK/0Z/mGinCUNBaLXpcA7THhtC36
         loLNf+sRReIVhg1zlpoSYa72gCSdmfLDCOIamihQiWKC/RM4NfIfHujL51fa/737gkTT
         xrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726441530; x=1727046330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=beUya29Zlv0T42pPdS50NrLDt0/JVoExAf05z/36B64=;
        b=dC6kj3YPzbHQ1g6dmcF/l16OrcdueX/U9eemllnenjHyqQVJUARQjHLKK+0p+bJ+LP
         Yu8SkhIijl/r6iSfxQIBfyL+dKOVbx4jf2GU7mmOCf2SoknSDeF9MsESzhgC/8iR5j6n
         JV+ojgFyxYRpMTAih/6Fzh8OBQd8IIksNT3sy3vK0+cr3ADYyS21v7k9I1Zo2ToTohzl
         ocrtxfKc23z4lAJVcglH8xXCHa+H0lJRujPgh+d0zWXQkPnTFhgcy4t1kzx/jBBz/a4R
         GG0++zD0KwXsqCId/4Pwq1A4Onh4lpL2ORlpOZD63COnI0Wpfw2k9oz82ZIbadLKabbW
         6IVg==
X-Gm-Message-State: AOJu0Ywaqg/nqYWV6eT+Ms7Z10fDZEXpxzvr060z+gx9sIRvurfxo44M
	GbyKAAqD1XrtUOsrZObTqCALIHol1o2Et8CWVdcRp7QS+jI9OBpP4CeI7FvE
X-Google-Smtp-Source: AGHT+IG74caGvjbj5c3AatQw8RrappOj+DxY4ktWDNYGDDtj+GZ2dZ3qcP4Q7iA8KzQ7avi+Qy68tQ==
X-Received: by 2002:a05:6000:e09:b0:374:c3cd:73ea with SMTP id ffacd0b85a97d-378c2d1674dmr7772338f8f.35.1726441530464;
        Sun, 15 Sep 2024 16:05:30 -0700 (PDT)
Received: from void.void ([141.226.169.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22e8292sm59566685e9.26.2024.09.15.16.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 16:05:30 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH] cbtree: fix a typo
Date: Mon, 16 Sep 2024 02:05:22 +0300
Message-Id: <20240915230522.129253-1-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 cbtree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cbtree.c b/cbtree.c
index c1cc30a5dc..cf8cf75b89 100644
--- a/cbtree.c
+++ b/cbtree.c
@@ -12,7 +12,7 @@ static struct cb_node *cb_node_of(const void *p)
 	return (struct cb_node *)((uintptr_t)p - 1);
 }
 
-/* locate the best match, does not do a final comparision */
+/* locate the best match, does not do a final comparison */
 static struct cb_node *cb_internal_best_match(struct cb_node *p,
 					const uint8_t *k, size_t klen)
 {
-- 
2.39.5

