Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581753;
	b=R69M1rQSHmr1lNQx+mqDCy9BRGNwmjGFTsxBKdJE4TOZCUUsxP9FIVfiTdkxaWi+WGb8
	 zcvw5F+/v6nZZJsZxhy7BqS0YlMRmxmiX5Rou2iQQlLvzT9N0Fe6NZhkyFxwXkQx9DvD9
	 mTQ3IzeWB3/SmljwzyIQwjM5kJgdcLD+5s9Te8TlQQKbScLzSM0feWpPOwAyD9IMjlESY
	 FGNHsEwBxMVwoEKwZy/F+ICYNAWV+t9QMRkKUYdkrwxCufsVyD1TuqPSwNTsh+KighZwv
	 kmWKEENL+4DQVk8GfryLgoT+x/+/NdKJlwPCTSsnUY6r9xzEujuTd2OEbUYZuSshedQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581753;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=3896GFkCpgzERDWwSB8ybL483WodTeBVwmIBPGZJmtI=;
	b=1EAY+JOV0bUue/J0K6RNbkMWTc40FBFMuaQ96Xi636pe+mYVpAV48leWzIFXk31LJ93c
	 1q/V4cVTHiqKPbq0Vl4pI8tbfSoq6UGjwoi2Lem6feKwrL6X7DxnrPxNxvcYKPNyPAzWg
	 iwgsrLwtJkVkzbUskOeEgvEGxaKJLtAKKMCIURzPLPXoSh/rHGbiRPFAOxGKRwVO/6SYI
	 wFHguGGP4Y6linnTdwbiq03bPZoIVnw8e7vibi+tJZyMzt8bwuu+7HvPPJgo2uc7F7De5
	 r0UbJa8HQwpmXN46fZZnUsyVzQKHexzvdf0vD8/qv3p/pEPI+MIfAYuNrK8rZTjEikg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k5Ux72ti;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5D2606A31E
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 11:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F5D2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k5Ux72ti
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cd633ef819bso208328a12.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 04:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792581752; x=1793186552; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3896GFkCpgzERDWwSB8ybL483WodTeBVwmIBPGZJmtI=;
        b=k5Ux72tiR8QQPO7THrOtKqnpllOY7gaSEwa9NcjdgYclP9yFEwxUJ9tkyaqwhakc2a
         2mrZmIMfR8noJB7XsdPZsftRqrqxtl12sdgiivLdepLS791dDtw60Mo1OTSSAj9iMAcP
         sX1dUSCajmvZHR7ZpyieAi6My/YXnCS19Pqr1JOPbTLxfizdAKBtvCJYbkfZ6T7S/s9g
         CWTWNrJukWiYezC+H5h06iJLBcTgRHcU67PoW7JVwJYvqzkIQ3w0MCDadtcKif6gHD0l
         PbJel3CInH+jwT/IbOFcNwugtb1CRGhA332+pSLudbTMY63LqpBttuVXrjVW2oYHFDm+
         1Zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792581752; x=1793186552;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3896GFkCpgzERDWwSB8ybL483WodTeBVwmIBPGZJmtI=;
        b=Wjb47xDZ/FIsWVI0fh8wjU5wKncnfShylWNLpUfNIIebdMh3k1+1zUBFZofyu/xUV7
         G2OxBYSfKL4UXxC2oah7dqR1MQLYkryYsYIb6ojggUoij+rAhrt6j/dzHBxaEj2ehfIo
         c585Uyd7NODn6EuIMzzSmGQ9pbxJ9ZkYVO+qoqLdudkLMEcnOXXooyhseO8Q281/hJ3E
         zdbpKCAkJYJLiOw/2iFJd+HOns7axEwxrGUqEfDomW8pTe0tTAHH3PVgrDV/1aTwuaU2
         68jXkBnr/NqQMFU1ak2dOaKJB6zkAW4ynNTZ4c5Pvvj6epEmN3RKmOyLbVrIEwF7D4Hc
         DBGA==
X-Gm-Message-State: AFq9FYIm/agYEHbmioZmrY3n6/Ii9Y9TgFa353p/suTGlj+ADtMsJsK1
	Gyij07xEDbM/NMftrrFtP9zHkGzg+mD7furnaoc7WqpXdavbpkNUz4KiWQzcJw==
X-Gm-Gg: AYBFou3VBOdwyrXjNBIu81Y+jy2zQM7xXkYKmVQHIvVfXgdRv28O7gxlGtd33u+AIH8
	km4nWtAoAeF3mCYUFpoDJdsHwSQ869pPhkQ9/MMto+/vpz+BTJldgjuBsxefYhiJIb10W0bS6oG
	eG0ZHJv0s70/HCZYBOnLaEQheTy9/IBJjI2tkWn2XUR5XDGC2BaBmPkeaFU3DZo149hEc/oF1We
	OWZd63E2tfi4vRmFsEvauuHfGHwTJz/+TvQFgLVZk3ou8ktVly2BXSRcCEP6OQQi73X+wpIOXrq
	xIQTBENiqulJYy88FYPxVIMuPJSVrnNK/OD0UqL6Jzt+tJoJWJT2f5d87HjapBGBHSAoh0FnYpP
	sMhF5ri2wUgGqrJhNtBt5kWLpGMvR/s7lOr/qxyqUspmbk3bgjAm0i7y33tO7dCaBgWTnn2QIn1
	5jVnKU4p5zbuY0cLnfFH69tWDom/u5oGq/qIhuv9mwBnpv/GilO30Y+22HLIM8j5gXE3BmmEr0A
	6FENRh/lMCRstKyXXJYV5qIiT/EKzW/nmruWibt5sNTMLKQpSDq0YHx
X-Received: by 2002:a17:90b:4a51:b0:3ab:413:49b6 with SMTP id 98e67ed59e1d1-3ad86ca9cddmr1624262a91.41.1792581752437;
        Wed, 21 Oct 2026 04:22:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.42.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6a86e9a7csm676243a12.20.2026.10.21.04.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 04:22:31 -0700 (PDT)
Message-Id: <87dbb1f055ded59c640b46af043d647119fe6550.1792581744.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2211.v4.git.1792581744.gitgitgadget@gmail.com>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
	<pull.2211.v4.git.1792581744.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 11:22:22 +0000
Subject: [PATCH v4 4/6] connected: add transfer.connectivityCheck config
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Patrick Steinhardt <ps@pks.im>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add the transfer.connectivityCheck configuration option to choose
the algorithm used for the connectivity check.  For now the only
accepted value is "full", which is the existing behavior and the
default.  Unknown values fall back to "full" with a warning, so
that configuration written for a newer version of Git does not
break fetches and pushes; "full" is always a correct check.

check_connected() now always tells its rev-list subprocess which
algorithm to use with an internal --connectivity-check=<mode>
option, which so far only accepts "full".  Passing the mode
explicitly means rev-list knows it is running a connectivity
check, so later optimizations can be limited to that case.

This prepares for an incremental check added in the next commit.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 Documentation/config/transfer.adoc  | 16 ++++++++++++++++
 Documentation/rev-list-options.adoc |  5 +++++
 builtin/rev-list.c                  | 23 +++++++++++++++++++++++
 connected.c                         | 26 ++++++++++++++++++++++++++
 4 files changed, 70 insertions(+)

diff --git a/Documentation/config/transfer.adoc b/Documentation/config/transfer.adoc
index f1ce50f4a6..811456f1bf 100644
--- a/Documentation/config/transfer.adoc
+++ b/Documentation/config/transfer.adoc
@@ -1,3 +1,19 @@
+transfer.connectivityCheck::
+	Choose which algorithm to use for the connectivity check
+	performed during object transfer operations such as
+	linkgit:git-fetch[1] and linkgit:git-receive-pack[1].
+	The connectivity check verifies that all objects reachable
+	from the incoming tips are available locally or, in a partial
+	clone, promised by a promisor remote.
+	The variants are as follows:
++
+--
+`full` (default);;
+	Walk the full object closure of the boundary commits.
+--
++
+Unknown values are treated as `full`, with a warning.
+
 transfer.credentialsInUrl::
 	A configured URL can contain plaintext credentials in the form
 	`<protocol>://<user>:<password>@<domain>/<path>`. You may want
diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index bd9f345690..3979a142a5 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -1102,6 +1102,11 @@ It is an error to use `--missing-only` without `--missing=print` or
 	stronger than `--missing=allow-promisor` because it limits the
 	traversal, rather than just silencing errors about missing
 	objects.
+
+`--connectivity-check=full`::
+	(For internal use only.)  Used by `check_connected()` to
+	select the connectivity check algorithm; see
+	`transfer.connectivityCheck` in linkgit:git-config[1].
 endif::git-rev-list[]
 
 `--no-walk[=(sorted|unsorted)]`::
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 0faa833fac..810eaa15e3 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -29,6 +29,24 @@
 #include "quote.h"
 #include "strbuf.h"
 
+enum connectivity_check_mode {
+	CONNECTIVITY_CHECK_FULL,
+};
+
+struct connectivity_check {
+	enum connectivity_check_mode mode;
+};
+
+static void parse_connectivity_check(struct repository *repo UNUSED,
+				     const char *arg,
+				     struct connectivity_check *check)
+{
+	if (!strcmp(arg, "full"))
+		check->mode = CONNECTIVITY_CHECK_FULL;
+	else
+		die(_("unknown --connectivity-check mode '%s'"), arg);
+}
+
 struct rev_list_info {
 	struct rev_info *revs;
 	int flags;
@@ -727,6 +745,7 @@ int cmd_rev_list(int argc,
 	int bisect_find_all = 0;
 	int use_bitmap_index = 0;
 	int filter_provided_objects = 0;
+	struct connectivity_check connectivity_check = { 0 };
 	const char *show_progress = NULL;
 	int ret = 0;
 
@@ -769,6 +788,8 @@ int cmd_rev_list(int argc,
 		if (!strcmp(arg, "--exclude-promisor-objects")) {
 			repo->fetch_if_missing = 0;
 			revs.exclude_promisor_objects = 1;
+		} else if (skip_prefix(arg, "--connectivity-check=", &arg)) {
+			parse_connectivity_check(repo, arg, &connectivity_check);
 		} else if (skip_prefix(arg, "--missing=", &arg)) {
 			parse_missing_action_value(repo, arg);
 		} else if (!strcmp(arg, "--missing-only")) {
@@ -848,6 +869,8 @@ int cmd_rev_list(int argc,
 
 		if (!strcmp(arg, "--exclude-promisor-objects"))
 			continue; /* already handled above */
+		if (starts_with(arg, "--connectivity-check="))
+			continue; /* already handled above */
 		if (skip_prefix(arg, "--missing=", &arg))
 			continue; /* already handled above */
 
diff --git a/connected.c b/connected.c
index 34045f1032..0147b7d3b3 100644
--- a/connected.c
+++ b/connected.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "config.h"
 #include "gettext.h"
 #include "hex.h"
 #include "odb.h"
@@ -66,6 +67,27 @@ static int check_connected_promisor(struct repository *repo,
 	return 1;
 }
 
+/*
+ * Fills in the --connectivity-check mode to pass to rev-list.
+ */
+static void connectivity_check_mode(struct repository *repo,
+				    struct strbuf *mode)
+{
+	const char *algorithm = NULL;
+
+	if (repo_config_get_string_tmp(repo,
+				       "transfer.connectivitycheck",
+				       &algorithm))
+		algorithm = "full";
+	if (!strcasecmp(algorithm, "full"))
+		strbuf_addstr(mode, "full");
+	else {
+		warning(_("unknown transfer.connectivityCheck algorithm '%s', "
+			  "using 'full'"), algorithm);
+		strbuf_addstr(mode, "full");
+	}
+}
+
 /*
  * If we feed all the commits we want to verify to this command
  *
@@ -84,6 +106,7 @@ int check_connected(struct repository *repo,
 	struct child_process rev_list = CHILD_PROCESS_INIT;
 	FILE *rev_list_in;
 	struct check_connected_options defaults = CHECK_CONNECTED_INIT;
+	struct strbuf mode = STRBUF_INIT;
 	const struct object_id *oid;
 	int err = 0;
 	struct packed_git *new_pack = NULL;
@@ -133,6 +156,9 @@ int check_connected(struct repository *repo,
 	if (opt->progress)
 		strvec_pushf(&rev_list.args, "--progress=%s",
 			     _("Checking connectivity"));
+	connectivity_check_mode(repo, &mode);
+	strvec_pushf(&rev_list.args, "--connectivity-check=%s", mode.buf);
+	strbuf_release(&mode);
 
 	rev_list.git_cmd = 1;
 	if (opt->env)
-- 
gitgitgadget

