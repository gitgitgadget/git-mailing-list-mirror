Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496F1198A03
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900380; cv=none; b=RvBBVR5x7xJOfezYT/Yg1GRTWAeCn31YFeqm63xKSSL6YA0qHnpj62adQYjLj9r4MhA1ihF5CwepbdD1RH1IaYv1aQrBs+hY5XNCr68i6tLn4v6ZH5cDK720ZhiiICPYC7PFzY91wJu66tsfzPYK/kGCK/zsM1bdxBKsv0OFsXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900380; c=relaxed/simple;
	bh=/4OTsqp7/0XagHHoHG87U3Cq8P4orhehoCjdV+Ws0UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/ZVYshIrJdStcUjel4f9EwGzNrat9yVd1FBgOYNW5wa1fMtsTmc9x6y/qJJJYPDEMwSVwmwKDKgy5WcS1KatHuC2T1Ob/gRpdMIunKzKCm/NYExU0HWOiRPVL6r5CBLyPJBy4e4E4GsE58vYav1NmiHOgmi2B8ta6izEuOM7G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3/ohUVf; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3/ohUVf"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7a1be7b7bb5so554261a12.0
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 02:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721900378; x=1722505178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0c6I6L2UI6Z07sVX/I4RZEpVOj4WiiO0O3zVyC+4ckQ=;
        b=L3/ohUVf9TJCPXkynrhtUjbGu4VvhF1pUrP6uQbzYH+e7cLKx9ctle5UScufcIOnsL
         oT5t0ah3n9QXn0IGYPOpG0MX6utIY8E111vN/hsJG8xNDE8q4jbGsno0q67gF1Uo4QTV
         PHQG5UaN5nNa1EjCYvMNG+465Co4iApMtCF532oPZsjJg9wHT7q2B+WTAaZUGBLkw/ur
         BS09AqjJNw++4MJU9YW26ANIJElLsA0sSRYr3/PbLkQBzFO5BdrPnRQTohPBQG1cE7lT
         cMxV8tqbWrb24NqXIoc6/H4rAVVD0vAgY0aRl9p8G+5WbclcC+FO7kICzPOegCxASoV2
         Ef4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721900378; x=1722505178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0c6I6L2UI6Z07sVX/I4RZEpVOj4WiiO0O3zVyC+4ckQ=;
        b=Dn6JDxHU9N6atALQigxLlqBU1g1MAc0CafUyIB7yMMm3JNzzlgWD3bRQBK+TrNnQyn
         s8c7VRMrw/5D6wQvwUwjDuy8SY5Q3P8o7TlBPVsZC7y/tvF+m1BYlg+N3KEkfwcm0u9O
         lAC8vHQDfg9V62lXbOoK0BTDwdITOhJiP+ZHfvMpmJHRIAX1vvtf/QakGy/JWgxf+Q8Z
         BwedxyhsIDqSL7hlJwW/GUPUH65dYo3xyZpMd9oIhcptUY0m0eGU8tKTJvMZs7Gm4XuZ
         36R24EOAkiRLG1kB9wV/+kMmMkh0+b8brnLSn+kOVyFUQqReQ9Gv79vdH/OdIcB+PtRV
         sclg==
X-Gm-Message-State: AOJu0YwZ/c6ffGzP/UqvQ/XRl+m4WgHduteb5WAqQu8wwYWyHe0iA+iM
	NQDg1r2Tl534TtdQVgRrdI6MskezCc3v5kp+iUjKrDV2Ek4yVMhWxxATYQ==
X-Google-Smtp-Source: AGHT+IGteQdNImB9K8gkEHEPPI9Y1ERhOT8C8+tgR0cdKmydDG5U5fMUiJW5pBcar8IDPhsWzvIEVA==
X-Received: by 2002:a05:6a20:a129:b0:1c0:bf35:ef61 with SMTP id adf61e73a8af0-1c47b1664c2mr1345639637.2.1721900378230;
        Thu, 25 Jul 2024 02:39:38 -0700 (PDT)
Received: from Ubuntu.. ([117.96.151.20])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7cf1db4sm9950895ad.87.2024.07.25.02.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:39:37 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 4/7] t-reftable-pq: make merged_iter_pqueue_check() static
Date: Thu, 25 Jul 2024 14:55:56 +0530
Message-ID: <20240725093855.4201-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240725093855.4201-1-chandrapratap3519@gmail.com>
References: <20240723143032.4261-1-chandrapratap3519@gmail.com>
 <20240725093855.4201-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

merged_iter_pqueue_check() is a function previously defined in
reftable/pq_test.c (now t/unit-tests/t-reftable-pq.c) and used in
the testing of a priority queue as defined by reftable/pq.{c, h}.
As such, this function is only called by reftable/pq_test.c and it
makes little sense to expose it to non-testing code via reftable/pq.h.

Hence, make this function static and remove its prototype from
reftable/pq.h.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 reftable/pq.h                | 1 -
 t/unit-tests/t-reftable-pq.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/reftable/pq.h b/reftable/pq.h
index f796c23179..707bd26767 100644
--- a/reftable/pq.h
+++ b/reftable/pq.h
@@ -22,7 +22,6 @@ struct merged_iter_pqueue {
 	size_t cap;
 };
 
-void merged_iter_pqueue_check(struct merged_iter_pqueue pq);
 struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq);
 void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry *e);
 void merged_iter_pqueue_release(struct merged_iter_pqueue *pq);
diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
index a78aba9e71..220e82be19 100644
--- a/t/unit-tests/t-reftable-pq.c
+++ b/t/unit-tests/t-reftable-pq.c
@@ -10,7 +10,7 @@ license that can be found in the LICENSE file or at
 #include "reftable/constants.h"
 #include "reftable/pq.h"
 
-void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
+static void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
 {
 	for (size_t i = 1; i < pq.len; i++) {
 		size_t parent = (i - 1) / 2;
-- 
2.45.GIT

