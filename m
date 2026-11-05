Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793839183;
	b=sCEVQ5c48Xac/6MrC2XSizxBHMOwsSaxB207BB5Xw2e/wka6TZ5Zh3K8DuWgYxgR9XsO
	 v3kk9AYqZGNRh1zICcYWnWXnDqMaX801yhRYKek6V7Y3LeQnTNhcHrRIKfaP45PXJw8ew
	 af4ogNQROqrq9GqpZk+KEKHo2vuvzvb+EKYojlourReAR9vBBN550XBSDYCWSYU8TgQnr
	 oGwbbM1CVSOW4/Tymso4fwBjVc1WVC6OHr6oIMYjZcHsm2PcofgfH+W5FCMXomla88ZdU
	 FYdpsxp2jp8saoLL5qFRmkeOuJ99IboxcbQR7zz9SUfMAXVvYh6xoqxOlQYZ0Aue3Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793839183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tzrW+Tc3mhkgZcFp8N6z2Aa8JEg1kjoYe5MswEW2ETA=;
	b=ydbEEbE40VIfUDEGD0o0R+0AkZGdPTPDw8vWxA4psS2soFqj6Zy00RkDR+j66UQKIJcS
	 dzNQhfm6NZmY3vpx50ofd7BlwfncS9l2cWnBWjSLMytS/495tyuj6+R2BtVCt4rl2KQv1
	 4UubbRKw2s00iHhahJbAzCafcrzG000bnP26zVUl24tl947SfXOYudc4iRtzMqNA0J+Vy
	 6m4dp7VukiX8L4ghNgnaCn/kJjOcz3hp04fnIX741THLFU15Gx+GRobACS9gf3GUIyG2f
	 j5AI2VqyCWLRqwlbi+cTTCv5zPmSTkpbDLA+eHY5d389+f15C2NHXqopPWlQG6g6KSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="wPffSj/q";
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C636606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 00:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C636606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wPffSj/q
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b4f7d3cd98so1533350a12.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 16:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793839182; x=1794443982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tzrW+Tc3mhkgZcFp8N6z2Aa8JEg1kjoYe5MswEW2ETA=;
        b=wPffSj/qcynjZ5azWbC/9b29YqhLh8Sgm0EAMQdqgVlGlbpuv3GY7dDZQ7SWZkTClX
         PyNWr/TkKQdXy/zD7nN18d1cLo1Jz3RaW1ttRPRJHhn+mL6aDRr0DKotsJ+dpw9oyINC
         mXKFCM/kHcE/itMdbojiRDq0CbYVn8wd0cSiasLD1SoFuNxmUk8PSiXK8TZYWeXeWFKG
         csR32x8B9xl5VOgm29+E25rZLkdKYguxZKJ0J8a0DZNyxY8hg4blkikDcXYUrLD17z6Y
         bjMXqt5rGl7yz/XU0HLClovu0xIhCxMQEYHdab3v59Y6KSW3RkCLU+TTmGOW5BXHFQJf
         0BMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793839182; x=1794443982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tzrW+Tc3mhkgZcFp8N6z2Aa8JEg1kjoYe5MswEW2ETA=;
        b=n1P8q6EM07c58KZoRKB+yx0p6gx7ZSDY9kwYZ9r8nQDuY2rcKtcgYvKy1gLaM6j+C8
         IRjtftLlajv69sS1DWKlQP7A+BZrX6jlGbUv2h7yELikiDEhtNcZi5hQDeXMzHyylK7e
         tATNjpS6gssgsS/zotFt0jXCWugIkP7Z79Ci00rWl0lTtqgBj53E1xgo01zGEW1F5bQQ
         xHB8vV4bfnPYMo7qnk885wQQJ/8rSyWa/++Dau4bVdNzpAaoqlYCSDsT3Yvg6JRkcxfD
         6eLqs/Eut+hpaz9GsZMkveds5QxYGr1Dn7/zIruLkxlPd6FYRvAEd9Ifw60SFcp9Xi+5
         Ukpg==
X-Gm-Message-State: APuU4Z/kTUzpLgVLg1Cz6g7mG58ykchfi4ywTkKfo/WWsFxEJQQdyrIH
	A98fO7rjCRdISujYO7fs7CcyjUVNEMrsp6fZFkBxIwBAK65kOisVKnR6LqSjB78H
X-Gm-Gg: AYBFou3ASKNZxV3OB8U6Htw4PzSL/pKb+4MwUIN6wKnwjV0ASKg9UqjtxcF7fR1cfQk
	4Iqupvm0FgdzQeg3kZdDq6ge0hocJFuhxp2u1mFuX1Jfog4IG576sblrorPJEOY1/jfgBjqxStm
	3OIMZr3TyJKwbajl0JfIaebk58ya/dfmHtr7DOHkHAWsLTAHQWDi6pXvxLfyyDdQ58Hn0yRySa9
	LOmcLp7d32f35oKYDworBtdy8MZ+cwikLlZ40YmojQ9re3sJxk5XkqhD8Io1xyKTflHlGPH9bra
	0tVnG8h2QRwvyG/XCc1p7vJo+9RpVsjGaHe4DTWWz5EkcIlnbKv3Q790RGcT+zJhK5HXSwBANC8
	FTSGx/3qN3EICfr9WtqXzDfD3OdGR8FdoiAttRbBHraHrbgpZ62B+9Ij9e1YTSwVvhw9fo0KMoY
	uBkufslZKik79bfNK97P9fSrzRlXc8TGI5q2nX/SsQeOHc4+mn9DUfge5tMAO8+2kPS34zW1sHq
	9226EvrvqeckS+2U5XEBZOe3P8qkaRScgKOzU9szafnRZsce/phmBODtIoNxy/eY2HiZvbkF4W8
	+0vJ5Zo5bXHbEFkyL80wnBLgclmR5lUlzV8YPtRQGMyWmfE4slMEL1lL3DVKtxHn76eCf1wBAZU
	NpuhDhHOPhR7C5rvxxKWDGpONUr/qpro/drFz
X-Received: by 2002:aa7:d356:0:b0:6b1:c2cd:db0c with SMTP id 4fb4d7f45d1cf-6b4d4687f5amr9339378a12.10.1793839181569;
        Wed, 04 Nov 2026 16:39:41 -0800 (PST)
Received: from HP ([105.163.158.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b55ac7fa76sm1236883a12.28.2026.11.04.16.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 16:39:40 -0800 (PST)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: l.s.r@web.de,
	gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com,
	herroyalpriestess@gmail.com,
	Tanga Joris <tangajoris@gmail.com>
Subject: [Outreachy PATCH v4 2/3] git.c: drop NO_PARSEOPT from builtins that use parse-options
Date: Thu,  5 Nov 2026 03:39:12 +0300
Message-ID: <20261105003914.708836-2-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.299.g39a9a95557
In-Reply-To: <20261105003914.708836-1-tangajoris@gmail.com>
References: <20261029231621.48958-1-tangajoris@gmail.com>
 <20261105003914.708836-1-tangajoris@gmail.com>
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

The NO_PARSEOPT flag in the commands[] table marks builtins that
parse their options by hand. Builtins marked with it are left out
of "git --list-cmds=parseopt", which bash completion uses to
decide whether it can ask a command for its options with
"--git-completion-helper".

Four builtins have since been converted to parse-options, but are
still marked NO_PARSEOPT:

 - patch-id, in 2871f4d447 (builtin: patch-id: add --verbatim as a
   command mode, 2022-10-24)
 - diff-pairs, which has used parse-options since it was introduced
   in 5bd10b2adc (builtin: introduce diff-pairs command, 2025-02-28)
 - fast-import, in 863937696e (fast-import: use parse_options() for
   command line options, 2026-08-11)
 - var, in e19f0779c6 (var: add "-z" output mode, 2026-09-26)

This causes "git fast-import --<TAB>", "git patch-id --<TAB>" and
"git diff-pairs --<TAB>" to offer no options, even though they are
listed by "--git-completion-helper".

Remove the flag from these four builtins, like 66fa6e8ed8 (git.c:
update NO_PARSEOPT markings, 2022-08-19) did for others.

Signed-off-by: Tanga Joris <tangajoris@gmail.com>
---
 git.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git.c b/git.c
index d7b5f88e52..2d27ad4175 100644
--- a/git.c
+++ b/git.c
@@ -571,11 +571,11 @@ static struct cmd_struct commands[] = {
 	{ "diff", cmd_diff, NO_PARSEOPT },
 	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "diff-index", cmd_diff_index, RUN_SETUP | NO_PARSEOPT },
-	{ "diff-pairs", cmd_diff_pairs, RUN_SETUP | NO_PARSEOPT },
+	{ "diff-pairs", cmd_diff_pairs, RUN_SETUP },
 	{ "diff-tree", cmd_diff_tree, RUN_SETUP | NO_PARSEOPT },
 	{ "difftool", cmd_difftool, RUN_SETUP_GENTLY },
 	{ "fast-export", cmd_fast_export, RUN_SETUP },
-	{ "fast-import", cmd_fast_import, RUN_SETUP | NO_PARSEOPT },
+	{ "fast-import", cmd_fast_import, RUN_SETUP },
 	{ "fetch", cmd_fetch, RUN_SETUP },
 	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP | NO_PARSEOPT },
 	{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
@@ -626,7 +626,7 @@ static struct cmd_struct commands[] = {
 	{ "pack-redundant", cmd_pack_redundant, RUN_SETUP | NO_PARSEOPT | DEPRECATED },
 #endif
 	{ "pack-refs", cmd_pack_refs, RUN_SETUP },
-	{ "patch-id", cmd_patch_id, RUN_SETUP_GENTLY | NO_PARSEOPT },
+	{ "patch-id", cmd_patch_id, RUN_SETUP_GENTLY },
 	{ "pickaxe", cmd_blame, RUN_SETUP },
 	{ "prune", cmd_prune, RUN_SETUP },
 	{ "prune-packed", cmd_prune_packed, RUN_SETUP },
@@ -676,7 +676,7 @@ static struct cmd_struct commands[] = {
 	{ "upload-archive--writer", cmd_upload_archive_writer, NO_PARSEOPT },
 	{ "upload-pack", cmd_upload_pack },
 	{ "url-parse", cmd_url_parse },
-	{ "var", cmd_var, RUN_SETUP_GENTLY | NO_PARSEOPT },
+	{ "var", cmd_var, RUN_SETUP_GENTLY },
 	{ "verify-commit", cmd_verify_commit, RUN_SETUP },
 	{ "verify-pack", cmd_verify_pack },
 	{ "verify-tag", cmd_verify_tag, RUN_SETUP },
-- 
2.43.0

