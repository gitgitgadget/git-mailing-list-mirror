Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C85E3876D2
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 07:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113607; cv=none; b=V+16eItZ3ZWGuY3/RwzTk6Kn/CD+ZuStyYsknN4bTLJfsSaJMdbFCk41Dsfl6uCOwYeBIcNPl7nJ469SWzmXRPJ+Hq5jOLwcXeDr4xJ0ODe8uwcttHHsIOZ51QogBQWQiBv1WUrvvBehADoKjFIlGG3CiAP3y2JaDo8Z+M5If4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113607; c=relaxed/simple;
	bh=1eKaJEdRkkv4yIc5PgRBvutFMtaMlC9t6+A00itdn3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YuC34cnQnYVm7A2QHXHmQzzGA5eLUCkvFMs84G91M71PxX+23w2DAX2gmzfUH5YyFsu7b6YeYOMGp8rGXmHzqvW3fo1JdWwY5KpkUX6Zlkob97hWJb7mahBd/QTCbZKY6ynxycQ5BP/eZEc+mpVoZZPK93mxPRGepVbUYPVokDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ya+zakB/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ya+zakB/"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so3718495e9.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 00:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775113604; x=1775718404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KqhxqtT4mSReCg74Wm738dxSy1t7jcU2ZN9VqD0m4E=;
        b=Ya+zakB/zK/mlWfQq+k8tP8qQKVeqVXricGZLR25gLnbs0ti18OpnjoM7kqv8MjIp1
         UWkQwjAgWLy4GBfIfX79J/EE5ysyYLBmDI/kCZCGIhEGxaMKoLd1tPU+yrX9CoXwszIv
         mb0Z57PIHrJTri5QuPA0c3AW0xr52wo8XmPK8EadlD/DBbvpPsm9UxLtApmOAvBDWLzV
         fU8pYO1m6DVtJ2HAgTUJJG+x5w4Ib/bDxIkq/ZG0abMw5kVjw6oqw5ybfpbup3XpHMY5
         4lCcE8kfk6LLOmEARsyk1GIAXd+Dlkz2dkVJhGIavZjre+MUfwPmIcAJmtCIc+vHIC/Z
         43Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775113604; x=1775718404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6KqhxqtT4mSReCg74Wm738dxSy1t7jcU2ZN9VqD0m4E=;
        b=QHlcOKPnsSpAQuoD/c6GaD/RGh3MTFxyGclvsVKGAIs2k0ePD0rXprbwyFRaG4jVQ2
         t+1oSrdkEF0S6NNw1qjOosBG0/G22ZKQnguT1U3TSQtGpJay56bYwaNV4Wv56clVgJTN
         HPSiTnnIZdcjOaloJu7dsyBOsivqMXXZeBsu28Fdns7BKc3JlqajdaZ9XcthQHFKU39p
         H/wAS483MV5DzkgzrJMT8tVXmi4TDcp8leYcKLSd0cGXAmMk7JsuzJNyVEMYO768I/He
         i1OAnOMr5P4b2eIXqrkvaGDkWIudlxbEuW6K5NaX34IwF6h8+fjik+QR3tw/U02dlA+L
         6ziw==
X-Gm-Message-State: AOJu0YyCilOhrNIkk6FHnAQqolrGFcay71wQ1Ra6kc76H4msmCuZ1dFR
	GQzpC7ouWxqtbj0xjqKKmq8S9GeKLsSPrztetdfe8xvsPl5iyd7Hsbjv6p5nFQ==
X-Gm-Gg: ATEYQzw7k+HL5svpy0racbY0K8uioy+9gEsoca1mlgCLIoDPTCeCFECvP+DGzSz7AaT
	RF7kBBhBxs59lz5eDrPRDfrtC+QCr8eKmUzzau6O9EcDYSuUZTqP1c4x6uFWy6zhCuFBrBxc47M
	4yG3daJR8fEbYgwQc8avL2G+YvJNiN3Z8zZTEXAjAM1zHeoo++Lqb+9hdzdaQzsNP0Ru6HC7Am0
	cggibPNFsigxxIEpQX863BAnRwu5jROlIazxSgnpZjLPAx5yMAfDitL4nuF80jXDHw6h8NEvLj+
	CbgSmNSWGraFX8CFY3InDwJPfkBB1at4KrSqkfKgN2PGUl7hgtoK61NUAj9rvwA5V8V0gKgyRSA
	/tIzAOdxo1+VcLdGCU1w+i+jqxmUg7G/c0RTnQ7B+Lseo7IJ3A2EZmV9FhmJ6FJ/kzKsLsC9MQl
	EpSGedVFkW6uOueUE53qWaBDm4Zy9Q7LPyBJvFRlgkd2vVzfAA6NBm+KK/3vGbGHRL27YAEdw1d
	cckMxJPBLzc6IRfGtnkcR2Iwy69v5AMkqkp/IA=
X-Received: by 2002:a05:600c:3f19:b0:487:e2d:f649 with SMTP id 5b1f17b1804b1-4888359a8dcmr101010115e9.26.1775113603879;
        Thu, 02 Apr 2026 00:06:43 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8bc9dcsm101916335e9.6.2026.04.02.00.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 00:06:43 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 07/10] promisor-remote: refactor accept_from_server()
Date: Thu,  2 Apr 2026 09:06:10 +0200
Message-ID: <20260402070613.85934-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.765.g57b94de1f0.dirty
In-Reply-To: <20260402070613.85934-1-christian.couder@gmail.com>
References: <20260402070613.85934-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In future commits, we are going to add more logic to
filter_promisor_remote() which is already doing a lot of things.

Let's alleviate that by moving the logic that checks and validates the
value of the `promisor.acceptFromServer` config variable into its own
accept_from_server() helper function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index d60518f19c..8d80ef6040 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -862,20 +862,12 @@ static bool promisor_store_advertised_fields(struct promisor_info *advertised,
 	return reload_config;
 }
 
-static void filter_promisor_remote(struct repository *repo,
-				   struct strvec *accepted,
-				   const char *info)
+static enum accept_promisor accept_from_server(struct repository *repo)
 {
 	const char *accept_str;
 	enum accept_promisor accept = ACCEPT_NONE;
-	struct string_list config_info = STRING_LIST_INIT_NODUP;
-	struct string_list remote_info = STRING_LIST_INIT_DUP;
-	struct store_info *store_info = NULL;
-	struct string_list_item *item;
-	bool reload_config = false;
-	struct string_list accepted_filters = STRING_LIST_INIT_DUP;
 
-	if (!repo_config_get_string_tmp(the_repository, "promisor.acceptfromserver", &accept_str)) {
+	if (!repo_config_get_string_tmp(repo, "promisor.acceptfromserver", &accept_str)) {
 		if (!*accept_str || !strcasecmp("None", accept_str))
 			accept = ACCEPT_NONE;
 		else if (!strcasecmp("KnownUrl", accept_str))
@@ -889,6 +881,21 @@ static void filter_promisor_remote(struct repository *repo,
 				accept_str, "promisor.acceptfromserver");
 	}
 
+	return accept;
+}
+
+static void filter_promisor_remote(struct repository *repo,
+				   struct strvec *accepted,
+				   const char *info)
+{
+	struct string_list config_info = STRING_LIST_INIT_NODUP;
+	struct string_list remote_info = STRING_LIST_INIT_DUP;
+	struct store_info *store_info = NULL;
+	struct string_list_item *item;
+	bool reload_config = false;
+	struct string_list accepted_filters = STRING_LIST_INIT_DUP;
+	enum accept_promisor accept = accept_from_server(repo);
+
 	if (accept == ACCEPT_NONE)
 		return;
 
-- 
2.53.0.765.g57b94de1f0.dirty

