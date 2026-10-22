Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=157.230.60.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670910;
	b=tYV9qiWBfKhw4WIK74bw757F7tXHibk4W++1sqHL3jZLzF1G04VgBGZ+T5LpAo4L67cM
	 5TFV/kn2j4hEe3QVi428JiaAXU/+Khbi4jQbZdRHBrbCSZ7NqH8y4xtz86gofG2AtOsrm
	 tWhXkdYJa8wNyhN9UsTKbPM1QajJHgTDuoEc+Biq91oPx6A/DSrFgLnwZg4m9w0a09Fyg
	 GXUQ8WHVaEVs8yOI6t3JyfuXrjs5aNRrjJTqRqXSVx4Dr/ILKEDu1r1v9pIhAJJ+HE5dC
	 03+JZMXxv61EHJwqC+82bwDm6xBjjEEYg7w3/P27lBjJHDEmtKiEVRffOSgmhtYVRyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670910;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IwMshZIUMwOA5WaPedIdHpB/t9lUWr8oNqbxPR+RldA=;
	b=WrQDKF8QUnpVJ+7cvDcIdg7ZxCmceEnUGDzMWVGGi8vXr9bQdFIdbD8Hm/v8xTUNlcBJ
	 kJNWtFp18wt3a/Ya4idvHLyc3ZpnWb111sqPWttEgiZnk5SOSQROOfdJnoLD+sCvtDYMY
	 6h3foGYv7gW5JG56F1AVusOdAj2RB5MrjvUYEI4S95+SaQKcU+J61Ob5uaeX6qWVyQTzE
	 eI6cv4Y1vmc8b8M7PB6AiHqFz2eie+Aqx7N5IgS2p7QDseq3nCB6fKeDaFevwFJcvU37r
	 MEgT4/SKUhEkbUAL2wI2uOM8gMJgbI0dQyoR9EcIt9x6+EkvVR/qNWy05jBK9PXpbow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lfurio.us;
	spf=pass smtp.mailfrom=lfurio.us;
	dkim=pass header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=K4zUt6YS;
	arc=none smtp.remote-ip=157.230.60.252
Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38EF606A31A
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 12:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F38EF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=K4zUt6YS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1792670903; bh=4Qdc4z+mYAwscH+QYTOhr35R/qOnYXPAfpMtjnF3Gew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K4zUt6YSLDXmcQSYkIAfBcSOTj4jIepYAcxpv3n42PSM40reCjiy227oMwDUCZJq5
	 wlDW+rDVceIMYsDqwg2R+OwRd9SrHm2ON9D6DPpfo0EL2JS6sUwN5DidbPYjYaXVhj
	 aHYIw9VlS6a4Ko5ZLIzEEbwmhjOzfB/STX/bcTRw=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id E5EE762D5A;
	Thu, 22 Oct 2026 12:08:22 +0000 (UTC)
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Harald Nordgren <haraldnordgren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] init: show absolute path of (re)initialized repository
Date: Thu, 22 Oct 2026 08:06:32 -0400
Message-ID: <20261022120749.3567828-1-m@lfurio.us>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27
In-Reply-To: <20261020053932.1274210-1-m@lfurio.us>
References: <20261020053932.1274210-1-m@lfurio.us>
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

Since 20e38cba3926 (setup: split up concerns of `init_db()`,
2026-09-10), git-init produces the message:

    Initialized empty Git repository in .git/

instead of the previous

    Initialized empty Git repository in /full/path/to/repo/.git/

Prior to 20e38cba3926, the code producing this message was in function
init_db (renamed at the time to create_repository).  In that context,
the git_dir variable was updated by 'git_dir = repo_get_git_dir(repo);'
earlier in the function, to set the value used in printf.

None of the discussion [1] around the original patch indicates that this
change was intentional, so address the regression by similarly using
repo_get_git_dir in this code's new location.

1: https://lore.kernel.org/git/20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im/

Signed-off-by: Matt Hunter <m@lfurio.us>
---

 Changes in v2:
    - len type is updated to size_t
    - added a regression test (changed my mind on this)
    - some text is stripped from the patch message
    - Link to v1: https://patch.msgid.link/20261020053932.1274210-1-m@lfurio.us

 builtin/init-db.c | 7 ++++---
 t/t0001-init.sh   | 6 ++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 374ed3a74706..9612d2b8bfca 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -248,18 +248,19 @@ int cmd_init_db(int argc,
 	create_object_database(the_repository, NULL);
 
 	if (!quiet) {
-		int len = strlen(git_dir);
+		const char *full_git_dir = repo_get_git_dir(the_repository);
+		size_t len = strlen(full_git_dir);
 
 		if (reinit)
 			printf(repo_settings_get_shared_repository(the_repository)
 			       ? _("Reinitialized existing shared Git repository in %s%s\n")
 			       : _("Reinitialized existing Git repository in %s%s\n"),
-			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
+			       full_git_dir, len && full_git_dir[len-1] != '/' ? "/" : "");
 		else
 			printf(repo_settings_get_shared_repository(the_repository)
 			       ? _("Initialized empty shared Git repository in %s%s\n")
 			       : _("Initialized empty Git repository in %s%s\n"),
-			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
+			       full_git_dir, len && full_git_dir[len-1] != '/' ? "/" : "");
 	}
 
 	free(template_dir_to_free);
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index f1d227f27167..fbf8a0e41dad 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -1000,4 +1000,10 @@ test_expect_success 'init honors GIT_OBJECT_DIRECTORY' '
 	test_path_is_dir custom-odb/info
 '
 
+test_expect_success 'init shows absolute path to gitdir' '
+	expect="$(pwd)/init-path" &&
+	git init init-path >actual &&
+	test_grep "$expect" actual
+'
+
 test_done

Range-diff against v1:
1:  c0869122d3fb ! 1:  49d220d97aa8 init: show absolute path of (re)initialized repository
    @@ Commit message
         change was intentional, so address the regression by similarly using
         repo_get_git_dir in this code's new location.
     
    -    In this case, git_dir is referencing owned memory that is later freed,
    -    so declare a new variable to hold the used string.
    -
         1: https://lore.kernel.org/git/20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im/
     
         Signed-off-by: Matt Hunter <m@lfurio.us>
    @@ builtin/init-db.c: int cmd_init_db(int argc,
      	if (!quiet) {
     -		int len = strlen(git_dir);
     +		const char *full_git_dir = repo_get_git_dir(the_repository);
    -+		int len = strlen(full_git_dir);
    ++		size_t len = strlen(full_git_dir);
      
      		if (reinit)
      			printf(repo_settings_get_shared_repository(the_repository)
    @@ builtin/init-db.c: int cmd_init_db(int argc,
      	}
      
      	free(template_dir_to_free);
    +
    + ## t/t0001-init.sh ##
    +@@ t/t0001-init.sh: test_expect_success 'init honors GIT_OBJECT_DIRECTORY' '
    + 	test_path_is_dir custom-odb/info
    + '
    + 
    ++test_expect_success 'init shows absolute path to gitdir' '
    ++	expect="$(pwd)/init-path" &&
    ++	git init init-path >actual &&
    ++	test_grep "$expect" actual
    ++'
    ++
    + test_done

base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
-- 
2.56.0.257.gf7497c7d27

