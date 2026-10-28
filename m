Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=157.230.60.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164665;
	b=4jB6oNOue/0Ghbg5f1AFoZyjOMW6o8X9pgA0ZrB2X7JwSVhactt2tq5GzvLom+RKJ/ZI
	 zagTW0/Pk9MddgTeb7NZjlY+HTFNSd2Hq4/kqq1mg8vru3w14t2Rzdkgug6OTtLrKCtpe
	 z5Zzlc9+QCqRSovFOPIwBbz4y58mT4CzY+Mq7O9sfwXNu/iAqR//1r/OnavRZLjpAHcUR
	 xxwcf36DbB0ahh/0vQ6sl3eWbkMYgJeFrGTFCxQpBAw3PTRAwbmOnauRTVod9CeSGjSUE
	 0x8hE2uBDOkREgwmNULn/rGd8IMcktL6yJmv89JGDUyVYr//WrNW2jOG/TKmXP7JGKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164665;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=E05INjM1YGQOKumQoFI7crWTtHUxXBJcgqO6Zsq/0oA=;
	b=uvZOJJFfRZ9kPsO+YtkVTtKUjL8YE9I9XeYd9gXw2iiZYHT9e+KYMhb1D3oazvxMxyno
	 GJ6CnVT8Ang9r9CSjoOZv4Z4xtiwQStjhsJMepnadGUcLcc12kFUkDZLeBYwi/HDC+Fct
	 tklNeQ0cPQoIe0dlpHJai302peznBzC/h9VsEBoCBcrV6WjcA6OUMZbcuD1yYqD1+kVG2
	 E9K/TKmifAvWve9f/pHBkkCLE/EvLRenYED2ao5zY6239M2CejWoD2MX2h/BOGCHajm/F
	 Bss7yaIFU+2gaMjXuisWZZcu59yKLJtSPaSwdTqJnxtM8zUL14KBK5vJSXJMenJwiKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lfurio.us;
	spf=pass smtp.mailfrom=lfurio.us;
	dkim=pass header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=sGWOu04O;
	arc=none smtp.remote-ip=157.230.60.252
Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A49606A321
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 05:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3A49606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=sGWOu04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1793164658; bh=K56bAYqo/TNrkgRPoG0+jhJSi24G7bW7E8jZHtZLcQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sGWOu04OsecUPmG51xcfsTkW981MAjPDbRspnkcAZe1zKgOci7lXFEYGGrWso9BwP
	 YQREBAQmw0pioasSbKaqR8/3EscFfdnGl/MIKulLjoiohGBDlP9eeOBFyX8AmXy+y2
	 Polki+hmCcjTO5FlfzTZ3KyBsc3d7e1we5vl4Lac=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 566F26005A;
	Wed, 28 Oct 2026 05:17:38 +0000 (UTC)
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Harald Nordgren <haraldnordgren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] init: show absolute path of (re)initialized repository
Date: Wed, 28 Oct 2026 01:16:37 -0400
Message-ID: <20261028051704.2759358-1-m@lfurio.us>
X-Mailer: git-send-email 2.56.0.333.g9ad7b1359b
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

 Changes in v3:
    - expand test to cover the full output of the init command
    - Link to v2: https://patch.msgid.link/20261022120749.3567828-1-m@lfurio.us

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
index f1d227f27167..5d438dcc2804 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -1000,4 +1000,10 @@ test_expect_success 'init honors GIT_OBJECT_DIRECTORY' '
 	test_path_is_dir custom-odb/info
 '
 
+test_expect_success 'init shows absolute path to gitdir' '
+	echo "Initialized empty Git repository in $(pwd)/init-path/.git/" >expect &&
+	git init init-path >actual &&
+	test_cmp expect actual
+'
+
 test_done

Range-diff against v2:
1:  49d220d97aa8 ! 1:  6c9adee7702b init: show absolute path of (re)initialized repository
    @@ t/t0001-init.sh: test_expect_success 'init honors GIT_OBJECT_DIRECTORY' '
      '
      
     +test_expect_success 'init shows absolute path to gitdir' '
    -+	expect="$(pwd)/init-path" &&
    ++	echo "Initialized empty Git repository in $(pwd)/init-path/.git/" >expect &&
     +	git init init-path >actual &&
    -+	test_grep "$expect" actual
    ++	test_cmp expect actual
     +'
     +
      test_done

base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
-- 
2.56.0.333.g9ad7b1359b

