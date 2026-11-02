Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607307;
	b=fqe5YWOJvwI/A2yGSJ4SZQwtdtnbyzzqBkKouo8WwXkIrU96aymmNPM5ue3p+DT9iw60
	 iMUETtj9QnPvzaKLhxEqTDG8d9S0njXFvohM3oKuNFs4WRB6R4iejTpoKM0rpNCsdHurn
	 2PBfS6Uh38dWoI5zVgU2RTYyI78sSYqnqM0CZ9QLt/VoDq21tbF76DAUXUcLzoaynXi5G
	 Gl/lydNv8Nj4sTs6zBJy9IzEMJ2EA6Bm4dduzMNIVJWkpx7Uh8/pqgv1mE2ajzMFRb1EE
	 JtaETrvPUx19NCljPIdbbT97IlDxFD5wigbFgkxCIfxBVzThRbCHIIJ38LB1nVdJVCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607307;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=If5Q7z0rwLcIuSkUWpnH1Z8TXlmouVbH9faexxKfPSg=;
	b=SayQtDhn8OURGeEf/0A62tBnRC6/ufJkPaA/4Czzoa3PsgBEPx07YvDVIELiPK0RWcp0
	 gsAjVB4h+eiaerAgGdOCCU+4U4Sk3Zg9uo/s973RrOREMdw7i47czW0f+H10cfZ2rtCCk
	 U6N3UmN9iflAXW2zr3I+2bo/suac621CxS7OVirW2hFcqk7mrGYbl4Y6Uz0L1A5vshaek
	 ZkyLy4craQmjcFkEVtv5MuCPl0BMjWY6lgVErtUZT+gjoM1OSmVFz15SCE7mGi6RF5fNt
	 Ts5lcZ640CRN8knVYlQM1f6ghurmJ8w9UAout7SDgbV1qJUZcb+L17yaOCxDT7zvFBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xcy2Igwn;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA10606A329
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 08:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AA10606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xcy2Igwn
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc147d86bebso1828613a12.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 00:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793607306; x=1794212106; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=If5Q7z0rwLcIuSkUWpnH1Z8TXlmouVbH9faexxKfPSg=;
        b=xcy2IgwntrN4LhNBBL8kCTO8kkwBZk0Tb0CqqS5Yd3s7RXbuenH+somo333R4n0alE
         J5BiTKSY/VMfPRHXCAWrGMM8vbFcwVtA26BhecTLBnSZtnh3fCdkirkwu27Ik41hICC+
         XrFGsDoD/iLjSlNcMjsqT3hXyjJRxRPaDWF1Qugj2MtggWR529wxuDdrE5SA8XhBprXO
         19McdsuSBCmNPhsZXkaLfHpB0DgxTDsTqVvD8hY+/jkEp1a/JBGGktofBrCUI9QwD/VO
         BGdCu98xiV7XHyCW4dru3X3pg2OFXjrckCOvu3ou8v6UVGDUUWPHuvemj+n9F3j3NUJA
         EtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793607306; x=1794212106;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=If5Q7z0rwLcIuSkUWpnH1Z8TXlmouVbH9faexxKfPSg=;
        b=byM5UEuwvRuKEtjjMLb6bmVsCXW3eNyKRiIdTrdXJH/A5taGLje6vYgOoYISUs3ozl
         8HxW28uW9KoiEHyJ76ZlOmj+BivbvI7C1KLive6JJhOYKx/n0tEbJTn3z22qlnzN1qp5
         JV68zkMLKhVe691mQAnmDQg3QUf2QBRP6WELUgkNmutH+9QWmmzWo2G3srYyBxxfI6WM
         JeGsmcF+1vwqhtoklSzHiYZiohpQQ7RY7x1x2S6lmeCDxVQ9LNsNIgCxl1ClYaJnajac
         r42cklkYZPPRpUO/D0RcQ9ZQ8v/VALl7q1J+Soaeg9J6dB4EKXD5uUoSTSO27oen+UX9
         UreQ==
X-Gm-Message-State: AFq9FYL/WTfu5XO402D9/BPTXosxdApMBTfLxJ/b3ZmrGHbr/Ixx/moH
	VqI/xvcnB9XwJQ/a5Bg5f7uFGyBo2X51SxVMo9BCHp2T3C5X4h3nQnh1dZr0b/CX
X-Gm-Gg: AYBFou0CNWczgcrgjUKl9rqGSOHxkASPgGBhz1ETV6/xqDbAUqN4nb53eFTE4AcNXGq
	YJbVvxcpx1NYDi2fz3D5Z2LN1bD199aktDnK/GNO7QlNq2pYJaQV9g0h3B1AceRuFEL86ybMUFu
	WugAFZrDLyMwtOvBm+82C/bmLip6VtE+hsOQnPRQD61jpyFtxZa6OCVx3MFRe2ZdGr8bOsgAnSZ
	1+FM+6shyfX8ZimYaaFOLTSlGQ/F5F8u1kcM27ju7XiZLhs2RWf4fO8TjLkJYqx5nNqAJW0/zO3
	cYFRuOPEIcaiO2MPE2+KAiOgUT2D8E5MOVM0pP5lSh3F39x54rsjEzRol1FSIf3DPfwToFqBEyb
	ZSqVhorq6Kqgl0/Ndyn8FqFlwHSm9zmoweiKCrnltRFzyHhkhSmLbPEz3yz0atRG1NyQyeLx1VL
	qxjVdQvxu8gl822C7VaWRp/bRXboPpRX1mZd3rV1EDQvy3Ff1Y2nVXVoxI+ylmyDyqDby0T+wyW
	7lyAXZw1KpExdIdfc11JvKs+PRYByBPe5VnWSgLi9/3x0EPe2R1Il/17brk+f2i/v+GN83Z5BQ1
	28lqELkVGa+e2Jopc8WZKqG69Z71W1UZLQ==
X-Received: by 2002:a05:6a20:5493:b0:3e2:2a4b:1bfb with SMTP id adf61e73a8af0-3e913bc2b2cmr9925970637.29.1793607305696;
        Mon, 02 Nov 2026 00:15:05 -0800 (PST)
Received: from [127.0.0.1] ([40.75.133.103])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb09813a37sm2820415a12.23.2026.11.02.00.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 00:15:04 -0800 (PST)
Message-Id: <pull.2289.git.1793607304156.gitgitgadget@gmail.com>
From: "Ebele Lynda Okolo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Nov 2026 08:15:04 +0000
Subject: [PATCH] environment: move diff_auto_refresh_index into
 repo_config_values
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Ebele Lynda Okolo <okolo.ebelelynda@gmail.com>,
    Lynndabel <okolo.ebelelynda@gmail.com>

From: Lynndabel <okolo.ebelelynda@gmail.com>

The diff_auto_refresh_index variable is currently a global,
which makes it difficult to use Git as a library since
global state can't be isolated between different repository
instances.

Move it into repo_config_values so that each repository can
have its own setting. This follows the pattern used for other
recently migrated config options like trust_executable_bit.

Add a getter function repo_diff_auto_refresh_index() that
returns the value from the repo's config, falling back to 1
(the default) if the repo isn't initialized yet.

Update the config handler to write to the repo config struct,
remove the global variable declaration, and update the caller
in builtin/diff.c to use the new getter function.

Add tests to verify the configuration can be set to both true
and false without errors.

Signed-off-by: Lynndabel <okolo.ebelelynda@gmail.com>
---
    [Outreachy] diff: move diff_auto_refresh_index to repo_config_values

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2289%2FLynndabel%2Foutreachy-contribution-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2289/Lynndabel/outreachy-contribution-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2289

 builtin/diff.c         |  3 ++-
 diff.c                 |  4 ++--
 diff.h                 |  2 --
 environment.c          | 10 ++++++++++
 environment.h          |  5 +++++
 t/t4000-diff-format.sh | 10 ++++++++++
 6 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 18b1083e98..ed83959921 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -10,6 +10,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "ewah/ewok.h"
+#include "environment.h"
 #include "lockfile.h"
 #include "color.h"
 #include "commit.h"
@@ -522,7 +523,7 @@ int cmd_diff(int argc,
 	 * Otherwise, we are doing the usual "git" diff; set up any
 	 * further defaults that apply to regular diffs.
 	 */
-	rev.diffopt.skip_stat_unmatch = !!diff_auto_refresh_index;
+	rev.diffopt.skip_stat_unmatch = !!repo_diff_auto_refresh_index(the_repository);
 
 	/*
 	 * Default to intent-to-add entries invisible in the
diff --git a/diff.c b/diff.c
index b4ac17f8ef..5f34ce91a9 100644
--- a/diff.c
+++ b/diff.c
@@ -65,7 +65,6 @@ static unsigned int diff_interhunk_context_default;
 static char *diff_word_regex_cfg;
 static struct external_diff external_diff_cfg;
 static char *diff_order_file_cfg;
-int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
 static int diff_no_prefix;
 static char *diff_src_prefix;
@@ -400,7 +399,8 @@ int git_diff_ui_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "diff.autorefreshindex")) {
-		diff_auto_refresh_index = git_config_bool(var, value);
+		struct repo_config_values *cfg = repo_config_values(the_repository);
+		cfg->diff_auto_refresh_index = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "diff.mnemonicprefix")) {
diff --git a/diff.h b/diff.h
index bb5cddaf34..466a1230a7 100644
--- a/diff.h
+++ b/diff.h
@@ -767,6 +767,4 @@ void print_stat_summary(FILE *fp, int files,
 			int insertions, int deletions);
 void setup_diff_pager(struct diff_options *);
 
-extern int diff_auto_refresh_index;
-
 #endif /* DIFF_H */
diff --git a/environment.c b/environment.c
index c83cf44839..2947e558d4 100644
--- a/environment.c
+++ b/environment.c
@@ -152,6 +152,13 @@ int repo_has_symlinks(struct repository *repo)
 		: platform_has_symlinks();
 }
 
+int repo_diff_auto_refresh_index(struct repository *repo)
+{
+	return repo->initialized
+		? repo_config_values(repo)->diff_auto_refresh_index
+		: 1;
+}
+
 const char *repo_excludes_file(struct repository *repo)
 {
 	struct repo_config_values *cfg = repo_config_values(repo);
@@ -778,6 +785,9 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->has_symlinks = platform_has_symlinks();
 	cfg->use_nanosec = 0;
 
+	/* section "diff" config values */
+	cfg->diff_auto_refresh_index = 1;
+
 	/* section "sparse" config values */
 	cfg->sparse_expect_files_outside_of_patterns = 0;
 
diff --git a/environment.h b/environment.h
index 49c86e8879..b6304d2e5c 100644
--- a/environment.h
+++ b/environment.h
@@ -150,6 +150,9 @@ struct repo_config_values {
 	int has_symlinks;
 	int use_nanosec;
 
+	/* section "diff" config values */
+	int diff_auto_refresh_index;
+
 	/* section "sparse" config values */
 	int sparse_expect_files_outside_of_patterns;
 
@@ -203,6 +206,8 @@ int repo_trust_executable_bit(struct repository *repo);
 
 int repo_has_symlinks(struct repository *repo);
 
+int repo_diff_auto_refresh_index(struct repository *repo);
+
 const char *repo_excludes_file(struct repository *repo);
 
 void repo_config_values_init(struct repo_config_values *cfg);
diff --git a/t/t4000-diff-format.sh b/t/t4000-diff-format.sh
index 74dec7d34a..1fa98d1456 100755
--- a/t/t4000-diff-format.sh
+++ b/t/t4000-diff-format.sh
@@ -122,4 +122,14 @@ do
 	'
 done
 
+test_expect_success 'diff.autorefreshindex can be set to false' '
+	test_config diff.autorefreshindex false &&
+	git diff-files
+'
+
+test_expect_success 'diff.autorefreshindex can be set to true' '
+	test_config diff.autorefreshindex true &&
+	git diff-files
+'
+
 test_done

base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
-- 
gitgitgadget
