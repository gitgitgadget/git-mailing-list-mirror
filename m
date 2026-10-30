Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379575;
	b=gVWkeLiM0sryURUevjXz7mN6H6b1oGVz9GPYQbLceXuYBoTN2FJQn3rW10Nj1VRmoS79
	 DxzTqOm+soFhv0HLf+Racb2zXDUC7TfNXe3a+dJGy8xQTqd72CpqvFmuITym31O7BNYx4
	 2+QqLxxKVMzPdmQwiIjDQoQkdyCjtHZX+o6dJ/eesgAz52boGqb1Krt0dPpphIZQijicU
	 k9XRp0jLEIB8+8btehKtQek4/UO8oNQ59PqOM8v19Y5jEFYAl6mmyJHkHRwb0lc6oxr7p
	 mlk0NUU5Kpmpn1T8CPidka7KxYAMx40XtYZlquP1G4F3ZjG5mnpgsG3yv6WaMT0ojZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379575;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3tNqsyQpWHQ+cBcicvq/hKEZNzqmlVUm/qvxX5wcct0=;
	b=CQ8tcJhMj4b+Nd1MtseiJVgj/yoP9H0EdbtybaWGH902dQAI2za8faaBkvhMUpL+zjy8
	 zayRtMvQHY+LBk5qYhPqiIEP8H9C/hXoJLxM8l5/U3GV3/1lt+/yQpZEKW/oWXKiMlDiS
	 KvvVyzC1tBFaViOzVMny1ywFOlkDw6MfWOZIqeVcFGoO4yo6GBnA7YwjPiYbw76opQRRu
	 zWVxfEGXusZCNZo7KTm4H282rMjDufVSYuSWp2Qtrzb4nrHs/6NWyrecnmx8c/RLtRUxt
	 PV7bC6tIQQQP/vUJZVb4zunYxaiHK2NyaXOondetuM64m7nzA/KxZz9GmDY8iRB7kOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yIWhNgo2;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDCA606A31C
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 16:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DDCA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yIWhNgo2
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so10364085e9.2
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 09:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793379573; x=1793984373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3tNqsyQpWHQ+cBcicvq/hKEZNzqmlVUm/qvxX5wcct0=;
        b=yIWhNgo25aaknSweBzfIxHZhTnUq05jYXkL4GyFsc1p3tdRfnLmidVu111/5SArkBi
         o/uKsC+5aDl/eRCPVPGPx5O1HN/YStbw7OzyNiM0GJ4Ws4KU8602F/jwSw30MSWI4WV5
         Y4b6TR4YNkvX7VEYCI/LAO77BJOytKQZbn5TgZt5yzhggOS4GdTQvXfkuecCXs+y8x4K
         ztDegtTRppZsUiiAifw+n6r+QDmYotn9A2mqjD8uiMBvi0mAhvqBHAFN11W36ttv+lPZ
         +zaJZs+lh6HbOklMgWoh8FzLtQLk7wVq4kVIkVakVUOw/vqREThXhIKuoICq0sMkWDxp
         V4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793379573; x=1793984373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3tNqsyQpWHQ+cBcicvq/hKEZNzqmlVUm/qvxX5wcct0=;
        b=ymRm6O0GKA+dyINh98+CQ9GynFPl8QFSsvAhU86E/p0Mn/GEsrZawR3aykdz9yMTg6
         7+96CE0lbdM2o+hK7+J4hm2lZijvjrnxp8KHgL4E36mnH9CHG+XgbLSRihgzNuhk2JW+
         6REi6c0GfiQL5bDwMBkSpyAHgLUc0NQj4EVJOa86mLTr4CzbhFrKBYee3YX75yOk0Z7C
         0QCjrTp1y1hZWtogqRvev8JPJVj/vMZtEzvSiVhog2CKyb5lQo3KiemMFMP2puj0BGs2
         19D/LISGYGYtd6/khpGEHaCgRPIc1wNw7dK459bx/6Mev+vGH8gOcgvW34TD+BXBbsWm
         iQNA==
X-Gm-Message-State: AFq9FYJUvY3NZJSZHtmxLoEYx9Kz7tORiBbLTOWgIvN3k/j2AWwvPh/T
	d1+PWkVeEsinNt/2xdzsiILYbzKoLviyD/xIBgUF59c5IfY/fkV3GVlkYL/ECsyz
X-Gm-Gg: AYBFou37oxkummLDTqMr/H4DrlMy0AKIY8PH3DDGBLfVNRjOt5NYEbThHEIZaUHu95i
	WuogPNPbT5/zCyBWJtXUldXROW7LOah1Itk9AtAv6GQ3wcp0WNTf2D4AuEjWRZY7XHfhBsizatO
	pna9uHJRsy+W20ou5tx/nCFIk74EDCfDURXjMcy0pMiijFItJ+ZJuAKFfRDZ2xKck53Hm/1rYhs
	//W9+V3r51Fu3vJ8IAhMHoWLfDsibAvPDUsv/9sU/8u6BnXAtjLbm2RHnEyQoRS24A92ygw05dS
	7K1za6fV0/0/2VzGGZ6P/etxq1+cp8SLwiZT7AIzZjCmW4WDPPoy4oCwjX7Fm2wXi1lvN2atcQB
	rBoJ1ZUSbqKlckH7HOlDgLw0rk2tqSm56lKvMB0SbWZE4GI5PK/NI4PUOkbgy1wUmZNFnj+hn0b
	IbYm0vQqlcA6mrh8NRFctUmUCNadsaC0FdVUJOeJXUFkRXDBcsFqViKfP7QtYwffm4aDZx1HGSW
	rlL347eG4XVbl0BZrH5mnL3bsiFyo0a0gnnLOqedpS9Dt58x5tlD/Qdj1Sfp6FFW7sB8hnqfzQj
	owqT9JqXaOgOKSwpf5khg4RemkrhtB7uoaeEF7pPZYTjLbdvgvI2CRR1w6phMJBOD5wc1FGcMu4
	=
X-Received: by 2002:a05:600c:8b63:b0:49d:34:420d with SMTP id 5b1f17b1804b1-4ac17ff9d41mr62684585e9.20.1793379572668;
        Fri, 30 Oct 2026 09:59:32 -0700 (PDT)
Received: from Stealth.zuku.co.ke ([197.237.143.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa820492cesm161264925e9.13.2026.10.30.09.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 09:59:32 -0700 (PDT)
From: Dorine Tipo <dorine.a.tipo@gmail.com>
To: git@vger.kernel.org
Cc: okhuomonajayi54@gmail.com,
	ps@pks.im,
	kaartic.sivaraam@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	usmanakinyemi202@gmail.com,
	Dorine Tipo <dorine.a.tipo@gmail.com>
Subject: [Outreachy PATCH v2] list-objects-filter-options: pass repository to partial clone helpers
Date: Fri, 30 Oct 2026 19:59:23 +0300
Message-Id: <20261030165923.53000-1-dorine.a.tipo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025190253.2207856-1-dorine.a.tipo@gmail.com>
References: <20261025190253.2207856-1-dorine.a.tipo@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

partial_clone_register() and partial_clone_get_default_filter_spec()
use `the_repository` to look up promisor remotes and to update the
repository's configuration, which ties them to the main repository of
the process.

Accept the repository as a parameter instead, and have the callers in
builtin/clone.c and builtin/fetch.c pass `the_repository` explicitly.
This moves the dependency on the global one level up, without changing
behavior.

Remove the USE_THE_REPOSITORY_VARIABLE definition from
list-objects-filter-options.c, as the file no longer uses
`the_repository`.

Helped-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Signed-off-by: Dorine Tipo <dorine.a.tipo@gmail.com>
---
Changes since v1:
 - Drop USE_THE_REPOSITORY_VARIABLE, which is no longer needed

 builtin/clone.c               |  3 ++-
 builtin/fetch.c               |  7 +++++--
 list-objects-filter-options.c | 16 ++++++++--------
 list-objects-filter-options.h |  3 +++
 4 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 44037dd428..5a6859065e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1619,7 +1619,8 @@ int cmd_clone(int argc,
 				     remote_head_points_at, &branch_top);
 
 	if (filter_options.choice)
-		partial_clone_register(remote_name, &filter_options);
+		partial_clone_register(the_repository, remote_name,
+				       &filter_options);
 
 	if (is_local)
 		clone_local(path, git_dir);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1f76ae6242..5277047476 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2436,7 +2436,8 @@ static inline void fetch_one_setup_partial(struct remote *remote,
 	 * remote if there is currently no default filter-spec.
 	 */
 	if (filter_options->choice) {
-		partial_clone_register(remote->name, filter_options);
+		partial_clone_register(the_repository, remote->name,
+				       filter_options);
 		return;
 	}
 
@@ -2446,7 +2447,9 @@ static inline void fetch_one_setup_partial(struct remote *remote,
 	 * the config.
 	 */
 	if (!filter_options->choice)
-		partial_clone_get_default_filter_spec(filter_options, remote->name);
+		partial_clone_get_default_filter_spec(the_repository,
+						      filter_options,
+						      remote->name);
 	return;
 }
 
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index bc5d98f9e6..b74caf3bf7 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "config.h"
 #include "gettext.h"
@@ -362,6 +360,7 @@ void list_objects_filter_release(
 }
 
 void partial_clone_register(
+	struct repository *repo,
 	const char *remote,
 	struct list_objects_filter_options *filter_options)
 {
@@ -370,7 +369,7 @@ void partial_clone_register(
 	char *filter_name;
 
 	/* Check if it is already registered */
-	if ((promisor_remote = repo_promisor_remote_find(the_repository, remote))) {
+	if ((promisor_remote = repo_promisor_remote_find(repo, remote))) {
 		if (promisor_remote->partial_clone_filter)
 			/*
 			 * Remote is already registered and a filter is already
@@ -378,12 +377,12 @@ void partial_clone_register(
 			 */
 			return;
 	} else {
-		if (upgrade_repository_format(the_repository, 1) < 0)
+		if (upgrade_repository_format(repo, 1) < 0)
 			die(_("unable to upgrade repository format to support partial clone"));
 
 		/* Add promisor config for the remote */
 		cfg_name = xstrfmt("remote.%s.promisor", remote);
-		repo_config_set(the_repository, cfg_name, "true");
+		repo_config_set(repo, cfg_name, "true");
 		free(cfg_name);
 	}
 
@@ -393,19 +392,20 @@ void partial_clone_register(
 	 */
 	filter_name = xstrfmt("remote.%s.partialclonefilter", remote);
 	/* NEEDSWORK: 'expand' result leaking??? */
-	repo_config_set(the_repository, filter_name,
+	repo_config_set(repo, filter_name,
 			expand_list_objects_filter_spec(filter_options));
 	free(filter_name);
 
 	/* Make sure the config info are reset */
-	repo_promisor_remote_reinit(the_repository);
+	repo_promisor_remote_reinit(repo);
 }
 
 void partial_clone_get_default_filter_spec(
+	struct repository *repo,
 	struct list_objects_filter_options *filter_options,
 	const char *remote)
 {
-	struct promisor_remote *promisor = repo_promisor_remote_find(the_repository,
+	struct promisor_remote *promisor = repo_promisor_remote_find(repo,
 								     remote);
 	struct strbuf errbuf = STRBUF_INIT;
 
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 77d7bbc846..6a349cb4da 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -6,6 +6,7 @@
 #include "strbuf.h"
 
 struct option;
+struct repository;
 
 /*
  * The list of defined filters for list-objects.
@@ -158,9 +159,11 @@ static inline void list_objects_filter_set_no_filter(
 }
 
 void partial_clone_register(
+	struct repository *repo,
 	const char *remote,
 	struct list_objects_filter_options *filter_options);
 void partial_clone_get_default_filter_spec(
+	struct repository *repo,
 	struct list_objects_filter_options *filter_options,
 	const char *remote);
 
-- 
2.34.1

