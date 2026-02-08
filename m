Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE50338F35
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770537567; cv=none; b=lLi5QtRC6/wbhaWmUHXyNK57QqEgL4Cff5xd1mJ6N2NLooEUDzTSLKqPhfELKRtPX+j9tITb3tYUZIYP5K4TW21AwFQjK06Gdp1mdPGnTf9Hs6L2xSKYFQ+uC1+foi6FPAXiIX7Afe7COtcvbeyqFz31Al81Q1mSdH5VrUgLAJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770537567; c=relaxed/simple;
	bh=P0ed+dfj7xFliKCtyg5jJ/vbWEtM8vKWI49C/9NKtlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QM+kWlHNuFYYrZDLJKF8Yjg+d5trYQ3hr/NIWDcfAoe5vNZEv65c4xHmEVL7SuqY1dG7K6K0GCEbdJI0FIX1B1UpSWdEOUexPcNzfBMdVdKIDRJVhtc2nP7LoWBcA0D6N1myGbgKek6+QCZWJGnVxJtX3E7sKc3WhOESH8bJ61A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwfmToyw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwfmToyw"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a9296b3926so23274295ad.1
        for <git@vger.kernel.org>; Sat, 07 Feb 2026 23:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770537566; x=1771142366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bP70Y6Nj4zA+30S55eb1y0qsmhjQ7M6a9j/ugvjuDp8=;
        b=DwfmToywG7CP2eQCbJZDcLJ1SjdsapSQXOG9f7MBueO1Y/pHrBLqtyWYTfjanr6Eon
         KEs59XmtkNGPL61dWrTN68ArcgoVmW7DSCEh0P2Eq+r0TwphmMXhRcETY4/eNAG4bKIN
         c3OOHqzatJAjrhBITxg9U2qttoH+Hm0W6FP6oHb6ki8A51qExBEzobEozt4GsYeXmTCk
         Z/WZ89ackzes/vzvZzglWYg3yQT6TZRc6z6f2F2CYvcLQFWyQKZbHxvhesprvRyjvwXi
         SAtwgBvJM+xVdKBWSENAcvYi1dlaBWkJn56d2iZCqn1KWWiTVyeN0evYKekVcBn64DFL
         IjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770537566; x=1771142366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bP70Y6Nj4zA+30S55eb1y0qsmhjQ7M6a9j/ugvjuDp8=;
        b=GuqvcHK6Zfmhc1JBoGx0dfbK3caDUBYy+oRX9PJBQ8OjXx4INW9NALKeHLx2KYy1Qp
         zYTa3mm0jMGIcTcJx461VFyghyzdAKCc4aO94AQeXBXzq+eZD6zjEY9msrOMeMyAOVoX
         oGYSeKbisUi/lkyoZP6D+su5R6OY0+okHquarWs5RWaq3G5XCzmayK10henN23jEhdt9
         Dm+eJpf7rkEvGpJ0tiNpqSwfuEf4J+vheADsL9GWrV8E31Ut+/2poUoycv+JXsSAJ7aZ
         72zgA1bfdBaVXYup6HweS4vit6FnjphT6LQqLf7YGfyzoeo98LlWodygnpng3mj8LXsw
         4dRQ==
X-Gm-Message-State: AOJu0Yw858LGUHaICMTZup0ifScfKE0zQOeItxy/lj+am1AeX9GMLe7y
	iNlovZEtHl13Vh1iDfDMQsMnDf83IA3x5g7UZQ9Wnps3N8wL8Q9eW2/7ESzBd5Q/
X-Gm-Gg: AZuq6aLOuGExsJz5/OgVFNIxLO7+12i2rbzbVxR2dEi2z+jYjFZMh28EjHiTTBl8h8s
	YyRiOZFxa3kJBiXg1p92ianGuRwqynNSi7GS8TpXwgNPvS8jzuoQAOKT6UaQSMy5DbZg35SrGZD
	UqrdWiTWD0iU63sGCkQu1ZKT/HFb6FXwY44Taqp6z7zN5M6YuaPPdsHOwmAoh/keTL4rSte7Ym6
	VaW2+ViM782iLa4VtCtmF1FKvcYxQ6ICDQgvuoBt7G24nwF1PUOtjxDUgUZthk29ACjn6I3ibQB
	g6Cwg+soknu1h9UjjaKQMsayEgMKWNKNEyASF4Kq/n8yn5ewdyw8SclCxcyXN2QrJKborsdP5/X
	kFseW6yNL0EbOciiIeRundX3T7DE8WitWqkTFF2jzKCuTNqZtxwD2SUt0ReyAWWeLc/lcVMQ6p8
	Y+mqEQYkQdUNNnMXTsRy5KI2WBTsoVI6RIhKCD
X-Received: by 2002:a17:902:f651:b0:2aa:d647:e1b4 with SMTP id d9443c01a7336-2aad647e468mr23901975ad.34.1770537566029;
        Sat, 07 Feb 2026 23:59:26 -0800 (PST)
Received: from AyushJha ([2409:40e4:1220:63bf:40c2:a75d:9eb0:2777])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9522287d1sm67309435ad.91.2026.02.07.23.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 23:59:25 -0800 (PST)
From: Ayush Jha <kumarayushjha123@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	Ayush Jha <kumarayushjha123@gmail.com>
Subject: [RFC GSoC PATCH v3 2/2] attr: use local repository state in read_attr
Date: Sun,  8 Feb 2026 13:29:05 +0530
Message-ID: <20260208075905.1807-2-kumarayushjha123@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260208075905.1807-1-kumarayushjha123@gmail.com>
References: <20260208075905.1807-1-kumarayushjha123@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The read_attr function currently relies on is_bare_repository() to decide whether to check the index or working tree for attributes. This function implicitly depends on the_repository, which is incorrect for library code handling secondary repositories.

Update read_attr to use the new  repo_settings_get_is_bare(istate->repo)
helper. This ensures the logic respects the context of the specific repository associated with the index, while also benefiting from the lazy-loading optimization added in the previous commit.

Signed-off-by: Ayush Jha <kumarayushjha123@gmail.com>
---
 attr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 4999b7e09d..2e1cde4615 100644
--- a/attr.c
+++ b/attr.c
@@ -23,6 +23,7 @@
 #include "refs.h"
 #include "revision.h"
 #include "odb.h"
+#include "repo-settings.h"
 #include "setup.h"
 #include "thread-utils.h"
 #include "tree-walk.h"
@@ -848,7 +849,7 @@ static struct attr_stack *read_attr(struct index_state *istate,
 		res = read_attr_from_index(istate, path, flags);
 	} else if (tree_oid) {
 		res = read_attr_from_blob(istate, tree_oid, path, flags);
-	} else if (!is_bare_repository()) {
+	} else if (!repo_settings_get_is_bare(istate->repo)) {
 		if (direction == GIT_ATTR_CHECKOUT) {
 			res = read_attr_from_index(istate, path, flags);
 			if (!res)
-- 
2.53.0.windows.1

