Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B6535CBD6
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253155; cv=none; b=XHvLOTv+2OBaNyTpSQU3yXcW5GlEUbmU0qsH+3+lHN3Xiu1dkOjXuJc0Aej31qaKqd1sAmCSn4vZKDw6yRs9CC98M7TDfobH2+goVIC5513VsQY3CiN4xrv7ozBAmzEPM4JZTX3l5Fx7JqNzQWnueYIB6Jq8ypoM+vGnhLSXQ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253155; c=relaxed/simple;
	bh=1yJM2ReZWW+P7lMYUXBL6SYF2EgKcxNIfD7YveOvgWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKX8AXGU4lkDIkiWtbfgQ1B6b5Sh2uy+6ycuOsp3Z9gtS+Px7khjygxwEGDPOM1EfR0ZL+nUW+1iWR3AwuAogy3rD/kylRke9coVA/kl3ss2GkmVh3LzRKo0K5Hw5kO58NjAO6JK82keSe4hbLmHtTrKLluySKnY3+/m4dE2dHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAkLHVLT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAkLHVLT"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48704db565eso14983285e9.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 01:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774253149; x=1774857949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXNCU/6HGMRVJGqNPuvyWRKjiRuqV5FWD0ZanLOrpwc=;
        b=GAkLHVLTYa9XDeBREhJzrRmpLE2fNibJIDi1TcZBlo3DtzAEYsgRcR99j5IMjB+VI7
         Tl84EV2e+8qwFzU2TNpmf3YDIaiVFhrgYo4JXynndMelwfPQNIbT7/g5D5PQ9BvrDlNN
         dyVQX7qXn5tz3EJ3vtL95KHgsIyssSEKH+eTpPx5SLtnt5RzAFPWqqIeh3e6qx18ccDB
         bu9O+35itosw6hGzUNG+xagNbp4u3PMEzXXJtvch/GuOlOvhJ6ZPpYXe/gmjUr/S/hrG
         M6Fq/9c2mC4popP07dw6a2vwvvJsYF43ddBS01c9V8yeRiV+xtuULi6eQ4AXWNkFsxLk
         JLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774253149; x=1774857949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dXNCU/6HGMRVJGqNPuvyWRKjiRuqV5FWD0ZanLOrpwc=;
        b=eu356SGm3kytcOwj+wbcZ74K750b82AeaZCjK8v0Auw2cbvzQI5t3jeFqxsyVI4fC/
         PkHwz3Z87iPFirkxOTnYrDLkCMt190Z5IQz2ncEgO+eiyfAz/bHjfgxlIlSch1RSx1b3
         Z7xF+/6TromwTiNwjA98O5wPE+Ls8CvG7JKYbNlwTyvc8iHoeUG8MUeZtgsgDrzdAPi0
         KjDlTPFZ4VPHG3oJMfQEqIYctjDSf0/T+DAXhti6iHpD9iAlRHX9VOFEpPcew3EmcB/J
         ezBsyRIfs2P27lbKJww51cjxHxWfddnmmYvLtJltOrac5SD08wdGvsiqfmGMWTB5vfxb
         eyag==
X-Gm-Message-State: AOJu0YzYZijr8CbpP1SoTSvceW4B2L6WbFj5WdEfisr6deqDMzOLX2eS
	jsWfWKm/TRW4YrPkMsQ0YCj0zDsrNBJcomExPy9FmYabFDbuCA1ZjiwGkgAY/A==
X-Gm-Gg: ATEYQzyS47R4RUJ4aWxF6yglxHyQuIDgqk4S8ANjedy3NaD6/gVn8AXKPdRcldpKdrR
	lIRlOQlYzKejrhXudGIEFbuUTvRxxaWtotJP77xqsEyprf/L6gNcOGEcHAgPUKaEVe86vWD3yJp
	mcWWoTTnjL9IuM6MLeLzzCqB8jx5SmZwWdcxTZr/VFmBvOHq9soM6OtCpy8GEqdO+MKVvfJYeGo
	oD55GVsE8KDWgc3+gycWRaiZ8hyCuT54UfjIo2k2sEcGQ20Q/V20jddqa+oRT3NSy5jU+NSN7D5
	ASTAjAl7LwqjXgmeKsV4CDVc2e3L/2R8uGsRVHWBEtKrbYE+TNFfaGV9RckkA1UTtls9mSGSU98
	joNhlpGUube+ZKCqcAY4nCjCqP54DmLRnpA8nIUQToxQKsJ9l8FCZY8S4MJCXXWGNwQYU017alR
	qoOfMICV0yNjpoNB3aBdICpWwXCM+Iva47tx1McqkABKuw7NWuSph6OxKGXId0pAgfS9pkpOnx8
	ensOVIO0w36VMd1Ub6BxrydjKtYVKecKz/zkMA=
X-Received: by 2002:a05:600c:4fc8:b0:485:40db:d40c with SMTP id 5b1f17b1804b1-486febb5cf5mr166660085e9.3.1774253149274;
        Mon, 23 Mar 2026 01:05:49 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703650sm27834067f8f.20.2026.03.23.01.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:05:48 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 08/16] promisor-remote: remove the 'accepted' strvec
Date: Mon, 23 Mar 2026 09:05:11 +0100
Message-ID: <20260323080520.887550-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.625.g20f70b52bb
In-Reply-To: <20260323080520.887550-1-christian.couder@gmail.com>
References: <20260323080520.887550-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a previous commit, filter_promisor_remote() was refactored to keep
accepted 'struct promisor_info' instances alive instead of dismantling
them into separate parallel data structures.

Let's go one step further and replace the 'struct strvec *accepted'
argument passed to filter_promisor_remote() with a
'struct string_list *accepted_remotes' argument.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 34b4ca5806..bdfc5e7608 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -875,12 +875,11 @@ static enum accept_promisor accept_from_server(struct repository *repo)
 }
 
 static void filter_promisor_remote(struct repository *repo,
-				   struct strvec *accepted,
+				   struct string_list *accepted_remotes,
 				   const char *info)
 {
 	struct string_list config_info = STRING_LIST_INIT_NODUP;
 	struct string_list remote_info = STRING_LIST_INIT_DUP;
-	struct string_list accepted_remotes = STRING_LIST_INIT_NODUP;
 	struct store_info *store_info = NULL;
 	struct string_list_item *item;
 	bool reload_config = false;
@@ -912,7 +911,7 @@ static void filter_promisor_remote(struct repository *repo,
 			if (promisor_store_advertised_fields(advertised, store_info))
 				reload_config = true;
 
-			string_list_append(&accepted_remotes, advertised->name)->util = advertised;
+			string_list_append(accepted_remotes, advertised->name)->util = advertised;
 		} else {
 			promisor_info_free(advertised);
 		}
@@ -926,12 +925,10 @@ static void filter_promisor_remote(struct repository *repo,
 		repo_promisor_remote_reinit(repo);
 
 	/* Apply accepted remotes to the stable repo state */
-	for_each_string_list_item(item, &accepted_remotes) {
+	for_each_string_list_item(item, accepted_remotes) {
 		struct promisor_info *info = item->util;
 		struct promisor_remote *r = repo_promisor_remote_find(repo, info->name);
 
-		strvec_push(accepted, info->name);
-
 		if (r) {
 			r->accepted = 1;
 			if (info->filter) {
@@ -940,23 +937,23 @@ static void filter_promisor_remote(struct repository *repo,
 			}
 		}
 	}
-
-	promisor_info_list_clear(&accepted_remotes);
 }
 
 void promisor_remote_reply(const char *info, char **accepted_out)
 {
-	struct strvec accepted = STRVEC_INIT;
+	struct string_list accepted_remotes = STRING_LIST_INIT_NODUP;
 
-	filter_promisor_remote(the_repository, &accepted, info);
+	filter_promisor_remote(the_repository, &accepted_remotes, info);
 
 	if (accepted_out) {
-		if (accepted.nr) {
+		if (accepted_remotes.nr) {
 			struct strbuf reply = STRBUF_INIT;
-			for (size_t i = 0; i < accepted.nr; i++) {
-				if (i)
+			struct string_list_item *item;
+
+			for_each_string_list_item(item, &accepted_remotes) {
+				if (reply.len)
 					strbuf_addch(&reply, ';');
-				strbuf_addstr_urlencode(&reply, accepted.v[i], allow_unsanitized);
+				strbuf_addstr_urlencode(&reply, item->string, allow_unsanitized);
 			}
 			*accepted_out = strbuf_detach(&reply, NULL);
 		} else {
@@ -964,7 +961,7 @@ void promisor_remote_reply(const char *info, char **accepted_out)
 		}
 	}
 
-	strvec_clear(&accepted);
+	promisor_info_list_clear(&accepted_remotes);
 }
 
 void mark_promisor_remotes_as_accepted(struct repository *r, const char *remotes)
-- 
2.53.0.625.g20f70b52bb

