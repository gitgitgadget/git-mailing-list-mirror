Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD3B3A9629
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562795; cv=none; b=CcpB8k60mOzTgFhKyXE8JTLPFm6fqYCQER09qX4JjnA87WVjHT06sAjCQ4DHpqVsWu/suartAEerf0mYcQCjUljg2enklr5d2PGyXmItFShHNniGfovL+d1zjyIsOszASZNHK6by51WtwyHeSoKpSIBqUGQzcvPUU8vA89LTB1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562795; c=relaxed/simple;
	bh=kvgBxWGCHYlOrtJmAHfKcS2jvVEuGCBQBCsKmRQu3dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbtoFxuBeRKXViWpYeO8fNGTnwrUFQV3frm7oJ3cex++yxdfXvmzHA9l6Zuae+bgHRuetK9YCtBb33euBSF/aLZzEGfVaPkFbEkn6+pwBnttLY8B8zin1jo+qqFIXjon5hK+fGIbJPCyt2qOtdR3mjBY+rhVnKFRWQOmTZe1uPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=smK1owKl; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smK1owKl"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cf5ad500fso4237049f8f.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 04:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775562792; x=1776167592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObTqrhkixx6t+mGQ7mb7VtOsPNZ2Ja948kr/t+MLORk=;
        b=smK1owKllj+IDtUZvexkDYsnkDybiNlN6k9TMFPpZcPydPQhr+y038akDmO1UC0iNS
         3Vas1AZvkfLWkHKLi9H+gYZW0sPYMBCATJneK/DlPaL2aduPyJAfygB6WAIpcYoIAYIc
         oxVdR07D42O2RqJJcz7zx7rL3RR904rhCgVz9UNEd9Q6+aNaUatPOFbogXh0GwTl2uMR
         swKSjT3iOWJBVeA8+19CB6Kbg40LYG/hD5IUsXRL3f+TCS7E5vE/CUqUjcSIPsYgzJq6
         rQ9foK4l12qLK9xOgF5DZhaPQsLUUBklk7519yx/V2aIqQwi7QE1kp4ZfC7lWACGfEpr
         GJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775562792; x=1776167592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ObTqrhkixx6t+mGQ7mb7VtOsPNZ2Ja948kr/t+MLORk=;
        b=sl2pMA/3zj8Yd4Vh+NLXbIUtGfGmxzo531S6EXg+r6lM4VJHDgy+0nlVwZ/XdVtAI6
         NeGYAUxrVDAcoCVr4wQqzrnOObBoCsN2bhqmbVbJ7iWyApeFnr0VD8VzcRYzi2iwKD9L
         MHsGdMEY14c4dZib8LKdhiej1s+Wccdv7LW89IxFgGDnl0GoxA8gXcl3xkaglN6YeZGO
         Txwl2kEhn05j4QssQamn5TvVuX+h04rPxGzK2vDcrZiFroibucsQm8TNe1n/kA9uwZhX
         gBs60E9seEh4Br1sjUPjP5/Iz+tG6Mu3H7p79I126lXzQtxFmGrnmHDwXKUruxzeq2hF
         vo/A==
X-Gm-Message-State: AOJu0YxVqqR8Njr+T3qLZ1QcvxVAfDYHo3fV3ZlGLh0hhdBTN/o3fTOn
	Sy+SPbkkLilyUAC7MLs3VM2rYIDK+135RLu1Pg1JlM+z+ay4SqMR4/Y4ejLZ+w==
X-Gm-Gg: AeBDiesrtpDDi+NRdvc+re6KltCZBQPPXiPvG7wlQzoGo0gLfMoWQT4zOh/E2uD70Ca
	6Zf9K7R/R9ZznsP0wEAr1xYqysCl4o2JFv5EKngSKP0FvY8s7hE3AhC3usXKGAVnwpAm45HlMku
	V1ywClceSZGsR2yvDc6RxXRoIekICUJEnDotB1PvoE3Hb6dOirBJNGtjU6cXAPSHE2zAF8Thh9c
	yD345W1qJZpSgl7owiD3L42DITkruW3kTp7n7UujBQq/vTbQ6JnFCpOd0/qecaqehsRGMEa7KyM
	KiiOfmgvm4tv2DexLFJaUdWJynxWZsnDFPmyKV8RuBIe27UqBwzw9Dq2HlUjcHEvp9sKQXQIqF2
	w15T0KslW0Lxpe3rKs0QCflOpXsPIAg+WT96pa9wmA+OPB3JsIh/J9/xV70nuHEhvO22O++b4EZ
	Qq9WVjrBeO3fcL/GXf2VFqbrGzw4gdNJe9eWj1UeZ5HRnglSjFOUZ0ZHEfp2dUZ3cq4VT86yqhC
	9rMRIjVCPo0JtNsTrfLnEjhcDzIerpROh6UuDY=
X-Received: by 2002:a05:6000:18a9:b0:43b:912c:25c7 with SMTP id ffacd0b85a97d-43d292daa5cmr24775883f8f.25.1775562792182;
        Tue, 07 Apr 2026 04:53:12 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f5bsm45050794f8f.7.2026.04.07.04.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:53:11 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 09/10] promisor-remote: remove the 'accepted' strvec
Date: Tue,  7 Apr 2026 13:52:42 +0200
Message-ID: <20260407115243.358642-10-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.rc0.114.g05d466edb8
In-Reply-To: <20260407115243.358642-1-christian.couder@gmail.com>
References: <20260402070613.85934-1-christian.couder@gmail.com>
 <20260407115243.358642-1-christian.couder@gmail.com>
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
index 74e65e9dd0..38fa050542 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -885,12 +885,11 @@ static enum accept_promisor accept_from_server(struct repository *repo)
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
@@ -922,7 +921,7 @@ static void filter_promisor_remote(struct repository *repo,
 			if (promisor_store_advertised_fields(advertised, store_info))
 				reload_config = true;
 
-			string_list_append(&accepted_remotes, advertised->name)->util = advertised;
+			string_list_append(accepted_remotes, advertised->name)->util = advertised;
 		} else {
 			promisor_info_free(advertised);
 		}
@@ -936,12 +935,10 @@ static void filter_promisor_remote(struct repository *repo,
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
@@ -950,23 +947,23 @@ static void filter_promisor_remote(struct repository *repo,
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
@@ -974,7 +971,7 @@ void promisor_remote_reply(const char *info, char **accepted_out)
 		}
 	}
 
-	strvec_clear(&accepted);
+	promisor_info_list_clear(&accepted_remotes);
 }
 
 void mark_promisor_remotes_as_accepted(struct repository *r, const char *remotes)
-- 
2.54.0.rc0.114.g05d466edb8

