Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68C9E57D
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 07:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737532398; cv=none; b=IWmHksykzsEFizgn71VVXsRwtk6bNfirA/TgOs3AgSzkaqUn2/+l7uBo8M/HgxEFR/ZNmLLBIi3/1HaUIx/hWqd7zyNUURQ/a9eQ3G7vv8aSs/lwx54cv0FH1qZ45CdC62Wo94tvmIphzs+M2ARqWH+E1w/YKeUjCVzqCahgDjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737532398; c=relaxed/simple;
	bh=P9PyOLm13BcMyHTDXYBSupefqWXBfFM3LIhi8AvL8jw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PiTeRRLdBUWeBjOYlAqNqKHS44ZKKH3tH9Mp67OXHIgRgLUX6Fo/zrPYxIUCxea5wRieMJVrVPivR0xkFW0dpoclOTAFoPd6O1cEjpdaRbqC9+Tc7do0rZrdtP5U5G/qIuYVKKGsvmYrF8zr3Xixv0T699cYhUZ8neUjUqprjWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jr2c8VZx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jr2c8VZx"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2161eb94cceso82185245ad.2
        for <git@vger.kernel.org>; Tue, 21 Jan 2025 23:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737532395; x=1738137195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2j14fQmQ8WlL5R0Z6RIc/P5QGsyK62aUlqlruP1d3E=;
        b=Jr2c8VZxL8UakrUjU07AzXhsaka9RaqTms5m2CGEQtnLIv68esqMWOPhCry3e9mSwW
         0KLkl7TStGr410S/DAY9wBByzZD0alTHbiSWan72plMtfIj4yde28lypaxw/DgoQVkXE
         7p26T05irzH1z/Z+Q2TCRA1f3HKK+s5hmj0MW/oMp61g1FEY4DAoGs+cCRc1wpViOydN
         7wzWxz0vtdnqrwQu55IX84Na86TNa7qwJY+kzP/r+atmvh3fTe3489in08Q378FQxKmQ
         yENOXeetUFjmZu1fhl6CTI5NcxXxkWS6Y7QzRMW1hBX/6zNLIhz2Ye09sRZgtE2Wllgn
         pSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737532395; x=1738137195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2j14fQmQ8WlL5R0Z6RIc/P5QGsyK62aUlqlruP1d3E=;
        b=T4ACXz9TTkTr99KMeJH2jRbiL2Ea4TwRWDc53uAts02OxZ4kzJxkUL8asLILG6ul2S
         D7UwKirCzJk9DLe/brO0yT43Jl/QOZsR1GIG1PWJDK7qzbxt8JriGDzDdLALLkvc+xq6
         YujhvnhmFvVh7LBP7kmIzaTnLUGTMzyxKKb2LiYbdX/SMmnpJ8aNwvWmAWJW/aoPPac5
         H0tXiF9XAyUS0GqI/Ce5wh+CHn9QQhmedoMoDRmUoJAHcbwrk3KfPnrw4hVU/EUZuej+
         fBmGHtKyS1oULx5isbhVG1tmlFJGleXdLA7fkpaGtAQTSlU3SnpLNH86bCHF9lWEz0QR
         zrKw==
X-Gm-Message-State: AOJu0YycbfzFFa5sX+ZQX0M16HFmbIVKbXp16ttWbSJKaYGpv5wSK0cz
	KX41Hwsq++fkc7YM+ehTm2jWD7/393iRJNA2rW5TIsx80kHyMhgE3joLVLOJzOk=
X-Gm-Gg: ASbGncsSwdhdjvc/cb609GAJQ+fzdZwAdZI4Y9Edj8wtSvTj/L6/mIGl7ENnVHPdMgD
	0/x8yROiaUJ51PHAl4j5wGBeV2s7eZk+/IDkr97TJd/Vz4Ry7MufdNuifW5g3QGKuWS0LdhYXzw
	MlNkHlu9hkhd9/majFSnsEjy3Zc12e/6xadS/IpJ1UdfM2SUYYNqb5bNMGQf/rgi4fhzIqb4AIL
	nIMK2PQ1nKu5LwBbhgwVe4sgAjB3E1vEWzA5DT7Ubd8hbuggy6Ybuo/Q6qUYeptHVDX
X-Google-Smtp-Source: AGHT+IHrgTcE9zZkDPf9Ae0vOzWL0OaYJkGTgQ1oVTLVD5rThhGfiZvrhUwZJsqTiMa4rSsi/x5Cmw==
X-Received: by 2002:a17:903:703:b0:216:31aa:1308 with SMTP id d9443c01a7336-21c355e35c9mr247081835ad.34.1737532395296;
        Tue, 21 Jan 2025 23:53:15 -0800 (PST)
Received: from meet.. ([103.240.169.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3acce3sm89284155ad.119.2025.01.21.23.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 23:53:14 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: shubham.kanodia10@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [RFC PATCH 3/3] refspec: relocate apply_refspecs and related funtions
Date: Wed, 22 Jan 2025 13:21:54 +0530
Message-Id: <20250122075154.5697-4-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122075154.5697-1-meetsoni3017@gmail.com>
References: <20250122075154.5697-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the functions `apply_refspecs()` and `apply_negative_refspecs()`
from `remote.c` to `refspec.c`. These functions focus on applying
refspecs, so centralizing them in `refspec.c` improves code organization
by keeping refspec-related logic in one place.

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 refspec.c | 32 ++++++++++++++++++++++++++++++++
 refspec.h |  8 ++++++++
 remote.c  | 31 -------------------------------
 remote.h  |  8 --------
 4 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/refspec.c b/refspec.c
index 72b3911110..d279d6032a 100644
--- a/refspec.c
+++ b/refspec.c
@@ -9,6 +9,7 @@
 #include "strvec.h"
 #include "refs.h"
 #include "refspec.h"
+#include "remote.h"
 #include "strbuf.h"
 
 /*
@@ -447,3 +448,34 @@ int query_refspecs(struct refspec *rs, struct refspec_item *query)
 	}
 	return -1;
 }
+
+struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs)
+{
+	struct ref **tail;
+
+	for (tail = &ref_map; *tail; ) {
+		struct ref *ref = *tail;
+
+		if (omit_name_by_refspec(ref->name, rs)) {
+			*tail = ref->next;
+			free(ref->peer_ref);
+			free(ref);
+		} else
+			tail = &ref->next;
+	}
+
+	return ref_map;
+}
+
+char *apply_refspecs(struct refspec *rs, const char *name)
+{
+	struct refspec_item query;
+
+	memset(&query, 0, sizeof(struct refspec_item));
+	query.src = (char *)name;
+
+	if (query_refspecs(rs, &query))
+		return NULL;
+
+	return query.dst;
+}
diff --git a/refspec.h b/refspec.h
index d3c97bfdc5..294068d226 100644
--- a/refspec.h
+++ b/refspec.h
@@ -86,4 +86,12 @@ void query_refspecs_multiple(struct refspec *rs,
 				    struct refspec_item *query,
 				    struct string_list *results);
 
+/*
+ * Remove all entries in the input list which match any negative refspec in
+ * the refspec list.
+ */
+struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs);
+
+char *apply_refspecs(struct refspec *rs, const char *name);
+
 #endif /* REFSPEC_H */
diff --git a/remote.c b/remote.c
index 2c46611821..641dd1125f 100644
--- a/remote.c
+++ b/remote.c
@@ -907,37 +907,6 @@ void ref_push_report_free(struct ref_push_report *report)
 	}
 }
 
-struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs)
-{
-	struct ref **tail;
-
-	for (tail = &ref_map; *tail; ) {
-		struct ref *ref = *tail;
-
-		if (omit_name_by_refspec(ref->name, rs)) {
-			*tail = ref->next;
-			free(ref->peer_ref);
-			free(ref);
-		} else
-			tail = &ref->next;
-	}
-
-	return ref_map;
-}
-
-char *apply_refspecs(struct refspec *rs, const char *name)
-{
-	struct refspec_item query;
-
-	memset(&query, 0, sizeof(struct refspec_item));
-	query.src = (char *)name;
-
-	if (query_refspecs(rs, &query))
-		return NULL;
-
-	return query.dst;
-}
-
 int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
 {
 	return query_refspecs(&remote->fetch, refspec);
diff --git a/remote.h b/remote.h
index f3da64dc41..b4bb16af0e 100644
--- a/remote.h
+++ b/remote.h
@@ -261,14 +261,6 @@ int resolve_remote_symref(struct ref *ref, struct ref *list);
  */
 struct ref *ref_remove_duplicates(struct ref *ref_map);
 
-/*
- * Remove all entries in the input list which match any negative refspec in
- * the refspec list.
- */
-struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs);
-
-char *apply_refspecs(struct refspec *rs, const char *name);
-
 int check_push_refs(struct ref *src, struct refspec *rs);
 int match_push_refs(struct ref *src, struct ref **dst,
 		    struct refspec *rs, int flags);
-- 
2.34.1

