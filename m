Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792954985;
	b=SJyoY7pExvb1QaHZn8T1TXjTHf50biT7ETb1vO11QoQEUsmtWlSmwDfE72SE9nLPz9+z
	 R3Yinny7bukKriSakW3866d2V4U+AM1HDGL9SiisV8C90mJ/8J8xzsgftxV3moe6PTy3O
	 brqTry23+aFJXlU2Ku64DBNcofE6mqJmw6UDQpquIX+YA+KiYBO1PSVgHW51aippVsEwe
	 NODikHZaxJbl+crWuF1HmGSBPP1oS9U9HcvSDF5LxwesgXH3kfrtUglTPPYDaaxf2f2JC
	 hRGuzb+mKubdAJodNxsFHP1losewOKdrjMtRFJqL6aMJ3C1pMHaLxaJQw74TF45voGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792954985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=WcX+IOyJueCcws3+J8R+78AMewjjV37YSKJuFzZn46Y=;
	b=xXE4Ev679rJAzSORx2b7Yt9sYmkCatSj0nMPIIDh98ix2W/h5/gSUSqhIk9v6LOPgsAd
	 q6n82Z+OTvDjXFVFR4htxBhq8HsUoJu4Xl+wuMnBkOFrHDKTXJdlv5KcNddZZtDmXiNoW
	 Y/On91PdObX8Fz9zthApVXlRkBIrlGPuAJXtsV1L7NVJzOk5DaR3l8EmOcUIs6BZ2NsTP
	 aFPAhNIJj1F7HRHGd1eEJB4CN7whNP650rqvySMyiie072mN9glTFvUxNRDo7ovbMbvZr
	 HDQm/sZkMnNpcU1u+jCrrUJxZhfFAVuSWPPBqQVaWxKjyS6KRNvg1jXqQI5NfL7rxxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B00g8oeD;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E64E606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 19:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E64E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B00g8oeD
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso23924135e9.3
        for <git@vger.kernel.org>; Sun, 25 Oct 2026 12:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792954984; x=1793559784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WcX+IOyJueCcws3+J8R+78AMewjjV37YSKJuFzZn46Y=;
        b=B00g8oeD2MlrcNL5HSbcyGlWB/M4s9KNZ052UH26r7emWcFatllqGa5Wm9r2WLLRmK
         Qj7JFFNvHSugcrcNckBnfLYJB38pSwPaq3QHesA1KfU4YRx+YU/bY4Kk3yFmI/GyyJmP
         mLNeXKeR/xpbEiJaRD//0l3sCYpqLw/pd35EMf9ktlihLC3m1gjw0mHkW0rJjWHycB3m
         tk2B9+DQaFgunnpuBvfHSe3xdincd6JTa9lSky2HP8TWz7XorAv62S4heidd1aLEYw8L
         pFx1cQtny3Wlaj1QkbW2wzA+TOHFl55N9IZRR5HmhElJSQNf4gYSa9bJdYtQGSCHWrUX
         uKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792954984; x=1793559784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WcX+IOyJueCcws3+J8R+78AMewjjV37YSKJuFzZn46Y=;
        b=lQUhIjHMY++rNfI3zUNgKdG3/nI/BIu7hZUHH5wWlMXPltdQkyaqfTX20Ho2WiHMZb
         WLjF/UUHkeBLhRhZAkgqSih6nhYB/dLewNavEvt9z9Bl4tVybFcsTlb1q/+YlN24CfN9
         bUmJVe86B7A2jFKa+xbhf7C6I8u8SP4bwjI+Afxc1zqGsEo8bfnsWD4fLNoNbxPX5P+6
         5QBOpa2i4Ul5EvXlx8D3n5IujBKpu0kDt6JkMCAJDPTi7ywctrffOTR4oGxwkE62CQsy
         vpnMvxWYu/s84NUdwqnxO8yk/0Oq6B8Wmo9Nlcl1MNlqGGtLzFqGbDPiRJlOl97fBUta
         dS8g==
X-Gm-Message-State: AFq9FYLBC4w0n+GqpdJiGPYAcVcgOgGu15jhAB2x6qnJUGr17Ypsgk4s
	u1On9A+tgQY62N/PRDtci8/Cs4vi9JQlEkYvyLp1DCor1zLgKjVeogkpacQV8jxP
X-Gm-Gg: AYBFou28SqjsqooVys3lu/yvZvQapficzvx84tQ/kbbCP+63/dvpZ6J1VqRCfZcJFEF
	m8ky8z4IbeLVGWLjM1V+HJTXqBi7y9EFstQO6TiG6I5w2tEWvm1/XjJAFbVMkOfHOOVgUapeJuW
	+oPx5ntNFuu8SDxw+Oo11FcYy4K4pNPE8y/SdflO+wRpwqqgnmJ9SwzLP/5PqZHt4MCTTwYTLsO
	j+opwu6Y0/H/rxLIj0b7pTkEFQ0heDlRYVFGTyxiddpFtoVLgUlKmIRYEyolRuPuhzzccR+gk1u
	ZOukRwnKyd7LGh3IQHd3CaGeb48OYMav/U6GSFG/oni8PFU5HzvvrbvLh8spOzWAQWSc/ZDkijB
	3MqfNEwizECUejc73mfSmUG9zMAN/Cy1fNBuzBFP0p9QkyeDoTgEik/3rNaujboV0sC7n56K+aj
	beKP04kcVFb/6Zhy2EUITXp0o3i5TsBc6aObCIwCg67ip3VLFqHW8GdXTTvN7gKmS/ecEFdrfzZ
	sNEGaVAjri8S1uh10bRyttn66497KQz5HTBfeeynv7DQ/jlrbQLqRQ6oagaZq6QDpQaz8hEfl4w
	EAgGjS2jsUEpV2pY3taL5OH1Rg==
X-Received: by 2002:a05:600c:3114:b0:4a3:5a55:f454 with SMTP id 5b1f17b1804b1-4a35acc772dmr84108025e9.19.1792954983553;
        Sun, 25 Oct 2026 12:03:03 -0700 (PDT)
Received: from Stealth.zuku.co.ke ([197.237.143.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb9cesm12106658f8f.27.2026.10.25.12.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 12:03:03 -0700 (PDT)
From: Dorine Tipo <dorine.a.tipo@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	kaartic.sivaraam@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	usmanakinyemi202@gmail.com,
	Dorine Tipo <dorine.a.tipo@gmail.com>
Subject: [Outreachy PATCH] list-objects-filter-options: pass repository to partial clone helpers
Date: Sun, 25 Oct 2026 22:02:53 +0300
Message-Id: <20261025190253.2207856-1-dorine.a.tipo@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Signed-off-by: Dorine Tipo <dorine.a.tipo@gmail.com>
---
The file no longer uses `the_repository` after this change. I left
USE_THE_REPOSITORY_VARIABLE in place to keep this patch focused, and
can drop it here or in a follow-up, whichever is preferred.

 builtin/clone.c               |  3 ++-
 builtin/fetch.c               |  7 +++++--
 list-objects-filter-options.c | 14 ++++++++------
 list-objects-filter-options.h |  3 +++
 4 files changed, 18 insertions(+), 9 deletions(-)

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
index bc5d98f9e6..178624f6f5 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -362,6 +362,7 @@ void list_objects_filter_release(
 }
 
 void partial_clone_register(
+	struct repository *repo,
 	const char *remote,
 	struct list_objects_filter_options *filter_options)
 {
@@ -370,7 +371,7 @@ void partial_clone_register(
 	char *filter_name;
 
 	/* Check if it is already registered */
-	if ((promisor_remote = repo_promisor_remote_find(the_repository, remote))) {
+	if ((promisor_remote = repo_promisor_remote_find(repo, remote))) {
 		if (promisor_remote->partial_clone_filter)
 			/*
 			 * Remote is already registered and a filter is already
@@ -378,12 +379,12 @@ void partial_clone_register(
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
 
@@ -393,19 +394,20 @@ void partial_clone_register(
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

