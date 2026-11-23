Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795448791;
	b=Vc5EHceFoc+AcanU1KWHWwyQvfhfjE2leZOrYGlCcxitjwojZisdQb8fpu8+dhe+Q8Ek
	 J39d9UEXRMFLSId0l7mQ6RWw19vSFjOdZrh32yZm0RfKmxuc9WkuOPcVBqPbCKIeQ1g5R
	 BSLftNjEpP03c3Jfcgu7J3ndH9i+ypUwl3jGGaqv9GWuKXsQfXfcaZfTQV1AvbypPsN1B
	 GN1kdsfo7Qwfiy+uBy9Op3vzeYS3QfvCagIc28zjFVGLfv3h9v7Y2funLzJrdTxvUW0bI
	 9glkF4wGOiQmBst9NMJudeMAq4MmVNNvROu0D8W9F/Bz04GZLBCz0ZOzrTzoWw03nVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448791;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PuDpbCPKd+nOflG+mVQ7oWSyREFZRyxB4qfmi0mrMRA=;
	b=3rI1KvsBiObsZQPKb/tTUSyxQeEUn2dN5IJp4qG09J4Cf0X4q9amIITOtIfwtE2cKGbk
	 ET3SVShquK0krFV7xPmukwIoiCx/Ok3l3oSoXzaPc70SmPY28Wfd7keOwkVHaMs9Sl/5o
	 BWsY0Ad8YF79JF3dkmQ2mB8Yg8WSCepY+CT1xpaGxWiNAwC7Un/hpeDEjf7isLfNPxSyu
	 5psGJXhGxcBjsVPd2Nfcm+GuWY5lWTrzttZy1OZpw0EdZ6uv4n2oiALfH5OzbWy0+ueCY
	 /j3SHVBdCFiOMaQsAJO/GJNHXODnR/IlYOXjfiO9Kkt98gV+Bf/q2IESF21cuwxDCVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b="M/hGmVGO";
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6E5606A31E
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 15:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A6E5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=M/hGmVGO
ARC-Seal: i=1; a=rsa-sha256; t=1795448749; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gyKDYcwwCSKu1PRuJ6Obcw2ELkaGOc7cuUkuWaAN5XTDGkAl8ANZjkk6DxZfb8dpp4KNO8X+jcTueBLvrB4N4zs/qbxTfwrYKXolZRXRK0LVBtuSFTfRD5W+a4Ik+JMco5VHIZgxXuKaEahAXUcBPyQi77bygI9MxO6SEtrBX4Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795448749; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PuDpbCPKd+nOflG+mVQ7oWSyREFZRyxB4qfmi0mrMRA=; 
	b=SmVeXDsFtmixFJx8xUQCXIB2v9KUf/JORR3OjDTfLzcn1blpiteeIy54qxuS0GmtvuArkY5PT0/G40oz81IzASFuKHwoMn07HeZ0Zp4sESa2zbLNOisa3s1oGLMHZckOUiIk9uLTAwSkeMpzWtJ1VOV8HyACbMqxiTevwtO25Uc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=M/hGmVGOhQfPTb2aVslRd5K9BEt/7Jg5M/nKvImhhVw3MKa6+7P51VCyBRUnN/AKhhrMkXinNotHIfvt3XQsLkdmzeD11cK8eBWQqZw12/zVpS1brc6I9N+CCmtWdNwYp6gGG0GZxTISgH+9PzZI/6wsAIaBo/4tfYsbNZr8GCw=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=PuDpbCPKd+nOflG+mVQ7oWSyREFZRyxB4qfmi0mrMRA=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795448747900284.2327911205748;
	Mon, 23 Nov 2026 07:45:47 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Wendleder <gonsolo@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 2/5] submodule: only suggest submodulePathConfig when it is disabled
Date: Mon, 23 Nov 2026 17:44:57 +0200
Message-ID: <20261123154500.251056-3-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123154500.251056-1-adrian.ratiu@collabora.com>
References: <20261118163249.1693361-1-adrian.ratiu@collabora.com>
 <20261123154500.251056-1-adrian.ratiu@collabora.com>
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

When Git refuses to use a submodule's git dir, it suggests enabling
extensions.submodulePathConfig, sometimes even when the extension is
already enabled.

We know whether it is enabled, so only suggest it when it is not. Do
this in a common helper, so that all three places that refuse a git
dir give the same hint and error message.

Reported-by: Andreas Wendleder <gonsolo@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/submodule--helper.c                |  4 +---
 submodule.c                                | 23 ++++++++++++----------
 submodule.h                                |  7 +++++++
 t/t7425-submodule-gitdir-path-extension.sh | 22 +++++++++++++++++++++
 t/t7450-bad-git-dotfiles.sh                |  1 +
 5 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 461b682d0d..fa76d0a916 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2011,9 +2011,7 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 		char *head = xstrfmt("%s/HEAD", sm_gitdir);
 		unlink(head);
 		free(head);
-		die(_("refusing to create/use '%s' in another submodule's git dir. "
-		      "Enabling extensions.submodulePathConfig should fix this."),
-		    sm_gitdir);
+		die_refusing_submodule_git_dir(the_repository, sm_gitdir);
 	}
 
 	connect_work_tree_and_git_dir(clone_data_path, sm_gitdir, 0);
diff --git a/submodule.c b/submodule.c
index 6bdf1efd89..c9dd7eae06 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2172,10 +2172,8 @@ int submodule_move_head(const char *path, const char *super_prefix,
 				free(dotgit);
 				if (validate_submodule_git_dir(git_dir,
 							       sub->name) < 0)
-					die(_("refusing to create/use '%s' in "
-					      "another submodule's git dir. "
-					      "Enabling extensions.submodulePathConfig "
-					      "should fix this."), git_dir);
+					die_refusing_submodule_git_dir(the_repository,
+								       git_dir);
 				free(git_dir);
 			}
 		} else {
@@ -2735,6 +2733,15 @@ int submodule_to_gitdir(struct repository *repo,
 	return ret;
 }
 
+void die_refusing_submodule_git_dir(struct repository *r, const char *git_dir)
+{
+	if (!r->repository_format_submodule_path_cfg)
+		advise(_("enabling extensions.submodulePathConfig might fix the "
+			 "following error."));
+
+	die(_("refusing to create/use '%s' in another submodule's git dir."), git_dir);
+}
+
 void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
 			      const char *submodule_name)
 {
@@ -2765,10 +2772,6 @@ void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
 	}
 
 	/* validate because users might have modified the config */
-	if (validate_submodule_git_dir(buf->buf, submodule_name)) {
-		advise(_("enabling extensions.submodulePathConfig might fix the "
-			 "following error, if it's not already enabled."));
-		die(_("refusing to create/use '%s' in another submodule's "
-		      " git dir."), buf->buf);
-	}
+	if (validate_submodule_git_dir(buf->buf, submodule_name))
+		die_refusing_submodule_git_dir(r, buf->buf);
 }
diff --git a/submodule.h b/submodule.h
index b10e16e6c0..3a5e4cd9ec 100644
--- a/submodule.h
+++ b/submodule.h
@@ -142,6 +142,13 @@ void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
  */
 int validate_submodule_git_dir(char *git_dir, const char *submodule_name);
 
+/*
+ * Die because "git_dir" failed validate_submodule_git_dir(), suggesting to
+ * enable extensions.submodulePathConfig if it is disabled in "r".
+ */
+NORETURN void die_refusing_submodule_git_dir(struct repository *r,
+					     const char *git_dir);
+
 /*
  * Make sure that the given submodule path does not follow symlinks.
  */
diff --git a/t/t7425-submodule-gitdir-path-extension.sh b/t/t7425-submodule-gitdir-path-extension.sh
index ea86ecf7ee..1455dad017 100755
--- a/t/t7425-submodule-gitdir-path-extension.sh
+++ b/t/t7425-submodule-gitdir-path-extension.sh
@@ -525,4 +525,26 @@ test_expect_success 'submodule gitdir conflicts with previously encoded name (lo
 	)
 '
 
+test_expect_success 'rejected submodule gitfile does not suggest enabling the extension' '
+	git clone -c extensions.submodulePathConfig=true --recurse-submodules nested clone_moved_gitdir &&
+	(
+		cd clone_moved_gitdir &&
+		mkdir .git/modules/zoo &&
+		mv .git/modules/hippo .git/modules/zoo/hippo &&
+		git config set -f .git/modules/zoo/hippo/config core.worktree ../../../../thing1 &&
+		echo "gitdir: ../.git/modules/zoo/hippo" >thing1/.git
+	) &&
+	test_must_fail git -C clone_moved_gitdir checkout -f --recurse-submodules HEAD 2>err &&
+	test_grep "refusing to create/use" err &&
+	test_grep ! "extensions.submodulePathConfig" err
+'
+
+test_expect_success 'rejected submodule gitdir config does not suggest enabling the extension' '
+	git clone -c extensions.submodulePathConfig=true nested clone_bad_gitdir_config &&
+	git -C clone_bad_gitdir_config config set submodule.hippo.gitdir .git/modules/zoo/hippo &&
+	test_must_fail git -C clone_bad_gitdir_config submodule--helper gitdir hippo 2>err &&
+	test_grep "refusing to create/use" err &&
+	test_grep ! "extensions.submodulePathConfig" err
+'
+
 test_done
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index e17642fc16..a710c05a5d 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -391,6 +391,7 @@ test_expect_success 'checkout --recurse-submodules rejects gitfile not matching
 	) &&
 	test_must_fail git -C mismatched_gitdir checkout -f --recurse-submodules HEAD 2>err &&
 	test_grep "not a suffix of git dir" err &&
+	test_grep "enabling extensions.submodulePathConfig" err &&
 	test_grep ! "BUG" err
 '
 
-- 
2.56.1

