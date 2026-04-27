Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623E73B8BA5
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 12:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293698; cv=none; b=kTgmxW4KUKQ1B9TqgYBJOXoM9lJ6YClZpAqSiXK6mrjtPQUiLTaPdncWpAi3VlQ/IP+wuf/BFpcqVBawFRqBJyDl5ep2B7jrAwaQ3ZQTTV7O8W/V5H3CrrQh6YR4e4pyOBQXTP9dBLfAV+S/o7Cgb5Ds6UXvuxL/I4TPxb6CqgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293698; c=relaxed/simple;
	bh=v8ZRJLVYDupF+kr0ZCInBRSqUd2bvlkToDJ/KE3T/Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqJ7Dq3i+20bGfzSlNqbCINw4HBRUy0Cm4LRMa8MNIrHnZhIC8wqb6jmR9RcGZhq4TmVqEpsQ5qEWRJSCQlSlJc7m72tt/Hq+QLREMAp4db/ZOWVYn5aKXD7XsJUUIn+Bc3+3ebFnRGx8PYLHnaz4Ut7ATyNDbOr+dS2eYWIGt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qV2nphWv; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qV2nphWv"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6788838d543so7607419a12.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 05:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777293693; x=1777898493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qkNk4olQHzL6Y7kJbShjEN8ojFedxeBWLs4jiJxFqs=;
        b=qV2nphWvUxHOxflR4sCqbwEt7sQ3ZSlsg4+LSrrfjn6SySqvWr+LINWvUyQDwxS3p1
         fhAfyuIsKXK7DT/hkRnWoLSqyqmkrL1MQR4BXLirtAfHeVYvvGQROHhGjJPCqJzYpAJa
         ApVO02IJmjED9M2kQK14vhP9DV5bHs17BbIlFH0De17URK2fEd2HSB6i/9REAt7C/8C7
         NNsQMk1y4sdChpM2+c63xfMioNSVbV0MwNbnukRR9Ja4ELRPYZQh2o385E3o+FyZSxAP
         z9HsChJmJy73D7D1vhUBKHoiQ6LnvqxodBswGEb9BUtKwSOO7Cgnagi4OMKv2O+Scloa
         laiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777293693; x=1777898493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2qkNk4olQHzL6Y7kJbShjEN8ojFedxeBWLs4jiJxFqs=;
        b=RMhuIMS7kP+MQLTZOYr5IX0yxhydEhnrWhLPO1SV5oBx40YF2AHW86JPjRT98xVtgO
         cVuLcQsKpLnZ4ftJRU3GuA2kJs+a+OnrHadQ9Q5s6mTLZJr7ibv/33YOVCBkXxUS6iu7
         tT6Uenat+u0cKmZQ4JCRR1lvj+33wY0GDyYV/U4umiK5qLYtV3Gmj5rv1hfZjCLo3NAy
         qGP3ruZHuCTlkoB8QczYfhmXfDUsYsUwUR7WgmQGYc3+R9G/FlOcgOEqSzfoJFLHHmVp
         moR4kT2pw9v3UsKLgzoOSy67IYb0E8DcrOJuD/tRXfiTCIyM6iMll8ax3lRT5oTyUGrv
         mYSw==
X-Gm-Message-State: AOJu0YwsgTn5OHUJm1HTCJBeGniDKzWbHyLhBUH9xnFo7zxEImr2b5Ci
	bslRfKS0HoZyZVr/kgZb8IG9yMCVzjazHcM5v9+ypCZLVeN/GMSLwyGzyXPMhA==
X-Gm-Gg: AeBDieuFCDE0wHdsWmXU6Dp1OqSBgYgD2fuTu4N7KXd2t8Au7aYDLucpXtum8Nx0SjS
	ib3CHyjExSqNFcplyHE9UH6uh4kzV24b7o6drLIKNGlhrRn7waLYfpcvLI1XtYBwI/PbdlTDhFx
	HDiRhjeE3C3rP66qbxXh0MtD9+89r2iCoSq2sbIYpu+6Qlmocxz4bkotPtch+pfio3iCAKriNkM
	WnC1Kr2hUzoB1V9yqnwFE+FgPIE+Gh/LOK2lToqTQXuAMmN+SxX8V4N/du8EeKDT8iTiyETFL/y
	CTIGeP17x/yCMr8ZhggTHLgzTi93uFGeEAYtcZYRVL+1H1YfTMHKSoRUOcII2M1ojeFO9zDoPh3
	xoNrrVkjuKJi7QniF/tvaPjPgE/XiNhFJqHqdXZNTDDk2GTYX5hGQVJGBVqMiCA3BQO6qqLsOTN
	PgBLJSLHyVC6LsAp6WPUR806F+L0HUXwjYTKM7sONi5vGQfhf87Htd1h6rmJTnbMSr9kDXcAhid
	339JAEPUlAHNNHgQZqF4DRky1Xhd39wLrv65aAUDjzgXS6HHw==
X-Received: by 2002:a05:6402:5058:b0:679:223c:d191 with SMTP id 4fb4d7f45d1cf-679223cd4ebmr2129038a12.13.1777293693156;
        Mon, 27 Apr 2026 05:41:33 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6744dcdf29fsm6760446a12.30.2026.04.27.05.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:41:31 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 4/8] promisor-remote: add 'local_name' to 'struct promisor_info'
Date: Mon, 27 Apr 2026 14:41:04 +0200
Message-ID: <20260427124108.3524129-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.19.gb68b9497aa
In-Reply-To: <20260427124108.3524129-1-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20260427124108.3524129-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a following commit, we will store promisor remote information under
a remote name different than the one the server advertised.

To prepare for this change, let's add a new 'char *local_name' member
to 'struct promisor_info', and let's update the related functions.

While at it, let's also add a small promisor_info_internal_name()
helper that returns `local_name` when set, `name` otherwise, and let's
use this small helper in promisor_store_advertised_fields() and in the
post-loop of filter_promisor_remote() so that lookups against the local
repo configuration use the right name.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 38fa050542..7699e259eb 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -434,13 +434,14 @@ static struct string_list *fields_stored(void)
  * Struct for promisor remotes involved in the "promisor-remote"
  * protocol capability.
  *
- * Except for "name", each <member> in this struct and its <value>
- * should correspond (either on the client side or on the server side)
- * to a "remote.<name>.<member>" config variable set to <value> where
- * "<name>" is a promisor remote name.
+ * Except for "name" and "local_name", each <member> in this struct
+ * and its <value> should correspond (either on the client side or on
+ * the server side) to a "remote.<name>.<member>" config variable set
+ * to <value> where "<name>" is a promisor remote name.
  */
 struct promisor_info {
-	const char *name;
+	const char *name;	/* name the server advertised */
+	const char *local_name;	/* name used locally (may be auto-generated) */
 	const char *url;
 	const char *filter;
 	const char *token;
@@ -449,6 +450,7 @@ struct promisor_info {
 static void promisor_info_free(struct promisor_info *p)
 {
 	free((char *)p->name);
+	free((char *)p->local_name);
 	free((char *)p->url);
 	free((char *)p->filter);
 	free((char *)p->token);
@@ -462,6 +464,11 @@ static void promisor_info_list_clear(struct string_list *list)
 	string_list_clear(list, 0);
 }
 
+static const char *promisor_info_internal_name(struct promisor_info *p)
+{
+	return p->local_name ? p->local_name : p->name;
+}
+
 static void set_one_field(struct promisor_info *p,
 			  const char *field, const char *value)
 {
@@ -829,7 +836,7 @@ static bool promisor_store_advertised_fields(struct promisor_info *advertised,
 {
 	struct promisor_info *p;
 	struct string_list_item *item;
-	const char *remote_name = advertised->name;
+	const char *remote_name = promisor_info_internal_name(advertised);
 	bool reload_config = false;
 
 	if (!(store_info->store_filter || store_info->store_token))
@@ -937,7 +944,8 @@ static void filter_promisor_remote(struct repository *repo,
 	/* Apply accepted remotes to the stable repo state */
 	for_each_string_list_item(item, accepted_remotes) {
 		struct promisor_info *info = item->util;
-		struct promisor_remote *r = repo_promisor_remote_find(repo, info->name);
+		const char *local = promisor_info_internal_name(info);
+		struct promisor_remote *r = repo_promisor_remote_find(repo, local);
 
 		if (r) {
 			r->accepted = 1;
-- 
2.54.0.19.gb68b9497aa

