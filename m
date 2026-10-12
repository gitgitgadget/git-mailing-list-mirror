Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D136481AB6
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806885; cv=none; b=ivI55SbVyw0sI3+t0iMGXsBgZgZsmgYBbvn8CEbvuT9chrIyPcYfQEcMeb/qSc+9WLOjMo67Q5wC/EeMpnKiNfmft7CApfMjXsfGbE6yuzF2lbh0SyBXnWYbRs8nLkPuYSZWUoYMNyPp7v5sndVUJ0jpED4pbKHcKA92ymqk0tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806885; c=relaxed/simple;
	bh=n8Y/B1IJWAl4URtUBVRpFsarX97b3NEqL+zD5oRv2G4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ypo5Ue/FSPw0uKQxIQuPcydrE847CzaZaGnjdrHtHPjV/Zgw55fwlPW41MRFk5vP+iyQ+p24DKC3jsWI0/zharE01uhU1U/4BQjq09Q/fNo+e1RMERFUcyCaS1OZKj734ot2oy06USyXVcWfjcbHwD52H54lYazA1A7Djod3+ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tI6M8foj; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tI6M8foj"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93e56c287b3so150266385a.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 05:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791806883; x=1792411683; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b8uVXB9aO5+OSLQ/lrvJxfiA0FnQHvxgzl1uI/azX34=;
        b=tI6M8foj+rF1MluSXiRoNY3fufgDYejWAy7BlZQ4H/f/wj52oi9YApkJZIiS77wY7m
         igL/su4+fx77dQUCI/g7lew2K6cxp42pYT3+2Q/wfuNBgKqq+toroozO7WTvAN0z2OCd
         lJR00Ombl3C5z6kfoEGER7KtBWxjHWvR9+osB5kyTGuwNUlmByLXbEAoeJKwaw4QOQz8
         uW6hepgZw21JsnNpoXPIM37E4v1VZnANXNTwG5MekE5daMePisa1hys1lFwSWLCWbNYu
         QNg7YotqiezTmCre4xjWiC15S4RwXw6jP7KY4HIaIXFeD559cnawpkBwKi05Im6xigiQ
         avrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791806883; x=1792411683;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b8uVXB9aO5+OSLQ/lrvJxfiA0FnQHvxgzl1uI/azX34=;
        b=BKiEAfgqhmvLKvLJZuHyqLRFfTLPq6Ape00+FkFtwj3nTRKilbOE/qKGS878wcKWWF
         IA8gW7piPE1MiqYObhqibAxQHTgH0Z1iaVuqpCKZhq6yyUGGLzyWxxxMyaRDUgxzXTU7
         vtGFjqf04v5Lhxjj0TnygOReaJhl5Zc8dxJTqdJtwkDxfQE23g5IW802ntO4uRfuNGqv
         ktHxfq5sT3+oCHMpU8xdpiOPy7zKjbS126BihBzL29PM0IcdAEXoFMByE5QjMHrxQcfg
         MdALsOFSjiCTm7MKlj7RvsE9LO4wS2rE/ofwE36zmvHdwloPDoXD40UMnjLlgYRYKCqX
         JukA==
X-Gm-Message-State: AFq9FYLRaMjmXswVrF1vion/rquy9OtEXVhd7L5Xb72g+MKV5M4ZUCrB
	/fuiQajaJe5fYm5vDGEnrhbsCu3DV3rRxLYQLkEffSjHQI0GugWepS8ne2ur30Uf
X-Gm-Gg: AYBFou0Onk4hPXh39KgjugX31k817ghAnmQBpon2nLKwtdDBQIsLs2kQkYgcM4T6nbZ
	Rud32q7IUHp3Q/aHBrpGSCbZKrXPt8oD/S+9DaeOc/xCVo5BH9t6Cof6aDDco3++FmQO1nmqOg8
	zvCDlFJHnw85eiK7JUAGIB/ubUniV8VR+xvmSDCvawxMmk052h6KKNA21kZvrstsw66+AOWV+v0
	vKj1GA7y9YmwuG6gDM8EkLD8AKdfBzVow9GQGjYEsvz8a2VsRqQ4/+j61r4MkUCkSCC3B+YXI0b
	fTleMulHdOQlKknVaY5Vnhl3dq+twTFfNtWk+wOK83oz/T1RUW69Lz2GxAaWotxFISUiuBoTmjo
	k2uk7+H6y/q6bjrjvSRUjjiBQsy8j4eYP2bTjyvD+4RbMYpBJeUvilck18axoUj06y9Rz2WRARk
	S5nGYNfvM4HnvKXTUv3VZBneunxkdrE6lfRq6ogdRWu5D2Kpuj2V7S0/J8A/GLO6y4k0IGao1Cr
	lhXEAm548eD
X-Received: by 2002:a05:620a:6cc3:b0:93c:6028:6d2b with SMTP id af79cd13be357-93ebd208cf0mr1625222785a.43.1791806882872;
        Mon, 12 Oct 2026 05:08:02 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.13.57])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b5504de42sm93846916d6.24.2026.10.12.05.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 05:08:02 -0700 (PDT)
Message-Id: <cdf28f1df6cb36b006f367de0e18e23e3aa8d992.1791806877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2211.v3.git.1791806877.gitgitgadget@gmail.com>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
	<pull.2211.v3.git.1791806877.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 Oct 2026 12:07:56 +0000
Subject: [PATCH v3 3/4] connected: add transfer.connectivityCheck config and
 rev-list flag
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>,
    Patrick Steinhardt <ps@pks.im>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add the transfer.connectivityCheck configuration option, accepting
"full" (default) and "incremental".  When set to "incremental",
check_connected() passes --verify-trees-incremental to its rev-list
subprocess.

The rev-list flag is accepted but has no effect yet; the incremental
verification will be implemented in the next commit.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 Documentation/config/transfer.adoc  | 20 ++++++++++++++++++++
 Documentation/rev-list-options.adoc |  6 ++++++
 builtin/rev-list.c                  |  4 ++++
 connected.c                         | 24 ++++++++++++++++++++++++
 4 files changed, 54 insertions(+)

diff --git a/Documentation/config/transfer.adoc b/Documentation/config/transfer.adoc
index f1ce50f4a6..b9939d3bde 100644
--- a/Documentation/config/transfer.adoc
+++ b/Documentation/config/transfer.adoc
@@ -1,3 +1,23 @@
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
+`incremental`;;
+	Verify incoming commits by diffing their trees against parent
+	trees, recursively descending only into entries that differ.
+	The largest benefits occur when incoming commits change a
+	small fraction of a large tree closure.
+	Falls back to `full` for deepening fetches.
+--
+
 transfer.credentialsInUrl::
 	A configured URL can contain plaintext credentials in the form
 	`<protocol>://<user>:<password>@<domain>/<path>`. You may want
diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index bd9f345690..35c4bf882f 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -1102,6 +1102,12 @@ It is an error to use `--missing-only` without `--missing=print` or
 	stronger than `--missing=allow-promisor` because it limits the
 	traversal, rather than just silencing errors about missing
 	objects.
+
+`--verify-trees-incremental`::
+	(For internal use only.)  Verify tree connectivity
+	incrementally by comparing each commit's tree against its
+	parent trees.  Used by `check_connected()` when
+	`transfer.connectivityCheck` is set to `incremental`.
 endif::git-rev-list[]
 
 `--no-walk[=(sorted|unsorted)]`::
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 0faa833fac..9a76bb9c9c 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -769,6 +769,8 @@ int cmd_rev_list(int argc,
 		if (!strcmp(arg, "--exclude-promisor-objects")) {
 			repo->fetch_if_missing = 0;
 			revs.exclude_promisor_objects = 1;
+		} else if (!strcmp(arg, "--verify-trees-incremental")) {
+			repo->fetch_if_missing = 0;
 		} else if (skip_prefix(arg, "--missing=", &arg)) {
 			parse_missing_action_value(repo, arg);
 		} else if (!strcmp(arg, "--missing-only")) {
@@ -848,6 +850,8 @@ int cmd_rev_list(int argc,
 
 		if (!strcmp(arg, "--exclude-promisor-objects"))
 			continue; /* already handled above */
+		if (!strcmp(arg, "--verify-trees-incremental"))
+			continue; /* already handled above */
 		if (skip_prefix(arg, "--missing=", &arg))
 			continue; /* already handled above */
 
diff --git a/connected.c b/connected.c
index 929b9bd28d..e3dcd8e2b0 100644
--- a/connected.c
+++ b/connected.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
+#include "config.h"
 #include "gettext.h"
 #include "hex.h"
 #include "odb.h"
@@ -67,6 +68,26 @@ static int check_connected_promisor(oid_iterate_fn fn,
 	return 1;
 }
 
+static int incremental_check_applicable(struct check_connected_options *opt)
+{
+	const char *algorithm = NULL;
+
+	if (repo_config_get_string_tmp(the_repository,
+				       "transfer.connectivitycheck",
+				       &algorithm))
+		return 0;
+	if (!strcasecmp(algorithm, "full"))
+		return 0;
+	if (strcasecmp(algorithm, "incremental"))
+		die(_("unknown transfer.connectivityCheck algorithm '%s'"),
+		    algorithm);
+
+	if (opt->is_deepening_fetch)
+		return 0;
+
+	return 1;
+}
+
 /*
  * If we feed all the commits we want to verify to this command
  *
@@ -133,6 +154,9 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	if (opt->progress)
 		strvec_pushf(&rev_list.args, "--progress=%s",
 			     _("Checking connectivity"));
+	if (incremental_check_applicable(opt))
+		strvec_push(&rev_list.args,
+			    "--verify-trees-incremental");
 
 	rev_list.git_cmd = 1;
 	if (opt->env)
-- 
gitgitgadget

