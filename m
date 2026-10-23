Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761130;
	b=0/1nP0yjZhIqNy+oq88ZIrY5zSb2OquJW3pcJYQK4piIWW3XDDseiCZBkxV3HZzSF53e
	 UwXZ51h8t/8XyTGFeXnId1Tg+3ZR8w5JYro5xZYw5j2rVm8CqZouxrWW2NjhKD4CyeKV2
	 iUFtJ2/EtTKsHqdYq8V/GMr0UD3lqcXHkhLdxIV06+NA/v6RwnXPRxWFssvJ1TDksz4ll
	 +M8AZLQax5cKfpaioqY85KDco0L8YnY4Yjuu866z+t39iyUyC+Kk2Bm4wfY513FXAYjJ1
	 qQ5XMQYuyUjwx9GHcC0R7OoKI74uLolYgGS0zqWYteAuL+w01iLGVYtiPHnX3FIDxdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=mVhfNlPmnwCIf6sTIvIxseX7Z8fURhLIa+M9mizGm4E=;
	b=iChJoNcCxhyxIpHyZOk6GMgUYDoQIoIoFyxasiCjqcAw1nPedRsIKgIyRJduE+nMXfM5
	 1WfcylNR3VFnLVQMepFitjria+pC8SWUjhIApOvQ9P0//WVynpY/enLO/F539fADdh3LZ
	 ExItnKMnR89oxfPtzz8tYu4ewb25njiB4fev8Arl3l6xFmABSIlxXKR4VEtAVH6+QKspp
	 NHbO3L0muA3JKH4Fi1E8fNNgDMMVe+M6oxHfk1N5sSK2VXCwk4goTqFyShwJ+CT7OEqno
	 WdoIc1RUcOKYPzv6KUMmu4iVRrmhSyNb61/KWAb/oibeEMBPOJjt7ZNNI9E0qzngaow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CwRxANTX;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9CF606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A9CF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CwRxANTX
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8ab432273c5so7384677b3.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792761129; x=1793365929; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mVhfNlPmnwCIf6sTIvIxseX7Z8fURhLIa+M9mizGm4E=;
        b=CwRxANTXxVzZxn5esqN0ExjbKd727dfwzwkdc++37lB8RPCUY48yhm111D9XEqS0Sv
         3nyBuXY2k+3v3qDTCaCAhmSDVeoM+X3DvKY3LOA6GN96r7CAOi7q/h/Zqt5urEcpmH42
         QdAzzhvvFI/sukNhMwpDKnJHystItnUtxwM0EsKLllxAJYAPwcvdJP9pACcB7Tskxjei
         rMmKBWASarIE1aR52WZxXypm/wqq7vzL8C8rGfyn2F+aZwVW6is4KXsWJgqieXkTMU8H
         tj56p7kpEis/hVfeBlwMhh5/4+XhTzwPf4hchxs4fGjESFu1EMugtZTMoemx/G4goBuf
         ArNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792761129; x=1793365929;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mVhfNlPmnwCIf6sTIvIxseX7Z8fURhLIa+M9mizGm4E=;
        b=eph3+F70WizT80sbvD4T8OjcRrYdUdxwgqY7qwr0YlD6YyX/6Jh1YvNZOaU/eyB/8V
         LPJPnSx4snxanQg1Zv0czVtGq6Hbig3djj5pV+SvChg3WQ/exskBcYrLFmOR0IYkIF4b
         /nLF1WVufzwGSJrDdUaxUxJJrbkcRJBmMn2I72K6q8+LKjAxHu6vVAsgwA0zkZZ8gCUb
         OF7cWbc+yaNwO1yIergV4yRJaKTb5PR6tLOkfZ22AN4R0KEWg4mbu5MK6wERw5ZgsoZF
         /9RAf1Nr3Er8yIZ/AgJbVRUjA4tA0l/ruqYs5QBil0CsriYCNPDHz3L0RFbc2KgF+HU1
         wpNA==
X-Gm-Message-State: AFq9FYL2sh8kxpLZP7gp9n2yOktj9E2NM7DgYLa4DIJ7EKj63XoqX9N8
	mqyCiBGsCzYj13oa03uMxn19MdvDNsiCDO73V5m4PhJ8iW12NkfDMYTKqZ7SX5z1
X-Gm-Gg: AYBFou1fgGP+18yZPG6w6fbWB2hlodW+GSj1xExxxXY3dE/ljBDJJUQz4Snyswf48Sp
	AOfOSb0DDtbJF6ggN0RE7QbsZ+vT/IDctUInClc7KfqdyWiVE24rhbFCYP4qKhhhM++upPUNF+R
	vz51d72LJuF8/cHu9rB5XNq0Jhc2W91tjzXIVJZFoEHF9FNdvrSkRo7KZZiowmVCiahx4qfLwXY
	e4kQZieYOpGk2lkXJoQ2jWEw5jXVae2UdwAtg7/ySxuvjH5qHAa6bsqGfw4vNRT8jxJJwORU/Qu
	6JoYKyOaQqvvAVhmIKLK9yuYQPI+6vqayHT4jaV2xWGiJQoGgsoEEsRd8rSUbDhDPJF/VeEXtZz
	qgyU4VT1NwEarGkkfrQX4kpmj+idBMfG7w1EgASX7PKfu7GJfgpF4nXR/du0JIexyNjm+9XuN4j
	QXu6osPZe19XwZY2Dy4LXZooJO6nOyhtVgrvWUopHvwL8FbBfZBv0S11tohk9kI5LRdreBCBTWn
	5THkk4Wfrbheu0HhUUuJY0hqxfOifnPoa+xDKxrEDXVfaMwb8lMDX1Y91A=
X-Received: by 2002:a05:690c:e151:10b0:8b1:ce5:be3a with SMTP id 00721157ae682-8b157e9b43cmr12578517b3.37.1792761129141;
        Fri, 23 Oct 2026 06:12:09 -0700 (PDT)
Received: from [127.0.0.1] ([52.188.86.148])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b156120c30sm13095157b3.22.2026.10.23.06.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:12:08 -0700 (PDT)
Message-Id: <7ef572bc05d96fea05289191c6738751b704fbfb.1792761119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2211.v5.git.1792761119.gitgitgadget@gmail.com>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
	<pull.2211.v5.git.1792761119.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 13:11:57 +0000
Subject: [PATCH v5 4/6] connected: add transfer.connectivityCheck config
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
 builtin/rev-list.c                  | 22 ++++++++++++++++++++++
 connected.c                         | 26 ++++++++++++++++++++++++++
 4 files changed, 69 insertions(+)

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
index 0faa833fac..619855f4e4 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -29,6 +29,23 @@
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
+static void parse_connectivity_check(const char *arg,
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
@@ -727,6 +744,7 @@ int cmd_rev_list(int argc,
 	int bisect_find_all = 0;
 	int use_bitmap_index = 0;
 	int filter_provided_objects = 0;
+	struct connectivity_check connectivity_check = { 0 };
 	const char *show_progress = NULL;
 	int ret = 0;
 
@@ -769,6 +787,8 @@ int cmd_rev_list(int argc,
 		if (!strcmp(arg, "--exclude-promisor-objects")) {
 			repo->fetch_if_missing = 0;
 			revs.exclude_promisor_objects = 1;
+		} else if (skip_prefix(arg, "--connectivity-check=", &arg)) {
+			parse_connectivity_check(arg, &connectivity_check);
 		} else if (skip_prefix(arg, "--missing=", &arg)) {
 			parse_missing_action_value(repo, arg);
 		} else if (!strcmp(arg, "--missing-only")) {
@@ -848,6 +868,8 @@ int cmd_rev_list(int argc,
 
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

