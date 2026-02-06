Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBA43D7D85
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770384187; cv=none; b=TZkzWa/9HHtUFSI6pgal4pwTiT0pDlFfgy2zrDE1UTDKBsiGMG8lhWGPNICSqSi0YnrUWDCNFRSUkNYkqO0F3mosUdby99PEpxrLFlknGn4UnghNVWFI0v3ybRgNwSVjh4t5me3/l6y1mNBLdyNE7tEa9PLCQ9+z5qdeCM8k5j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770384187; c=relaxed/simple;
	bh=D/PwFfsFZedopiG6/lh4U7CzpQB77Ev1hqVy4XYErIE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iO+9HyE77RB6oOBPrkmPGBmPfO61cXWC77Pr3zaPPjnwzuNUyCjbPulFH2spC6FkMAsurp+zHUIKe4V3hWq81ILbxCDyQmZiiahxEhf0M8lFW7loBvHFc3avVIYHT8rj2VWDi/ICI6HPuMVxJeTlViQPfsBvLngIUnEsCz+c600=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICMU8Q57; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICMU8Q57"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b72e49776eso1165354eec.1
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 05:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770384186; x=1770988986; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLsU4q4WzgKq4BBo95ahC1/g/Lz2bCXguOdneeiiX2c=;
        b=ICMU8Q57sgbrALeCnrkhj25UcC0aze0xrUsgb5XTwmuDhSE5WGmASk0psledCadiOd
         IUyW/5QlPUPMR6dyMDVKPEhXQY4RSVHFZxum0HN5zcJyho/zx+w9vH8gnkghIJiEt+vq
         3CsDWd6xB6SF6O247j5iJYb0QCUverIviEvYdp5EMcC0mY3xQV46kfwCo1bTDn8wrZuS
         C48lchQttXRPTrxWLf8oUit5FXhANdtJW5oxuWBbC2LYyuGV1jy9x+lpKoc8pFM4hDr3
         sSGI0iiKUIPUkzCZNFy3Zcao9ky3veWLTSeuYqDCX1k8xYqSgUK05xefkzkokb4Tggow
         KGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770384186; x=1770988986;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nLsU4q4WzgKq4BBo95ahC1/g/Lz2bCXguOdneeiiX2c=;
        b=hZcK0J+Rc+XAVnZXukAw0tCJj4gc0bojXqXpp67AJZndhJtNJeRD1vK8A/wGgxg+pW
         ijA8PEmDNtypkhuATG7ImdC44je1DrNaUUrQrk9rJUoW9/D5381BbWvfGcbfFY8U5xZs
         TsVOd7fp/1FwCZ2LnGyZXVd6i4BdY8dMDxOCAw8hfkPuyFE800s/rf+F3ePSqgA0uhjp
         beJ+ZMSGwp1oYD0mAHuF+72LYunSGyZxNNWyP+IOUwr2Lcwol1Z43eXGteyo8WhFOgnW
         m6t75cWY7LbQG1UbXiC0QzW1zBdbJyVUoqBRQORP/m95lZG2KHHwGcIuIWjAP1yIi3b7
         AaHA==
X-Gm-Message-State: AOJu0YxeF+ndBCOkHT1rsyEcMI+wPi5SuwKIXz11kAxvxVlvA2f8Vewx
	ANmNuqaGYu8kIcP/aLGT/nTa6qCKNcJbnSEogqFcQCa8P5Vk5VuTH3QiYYGesxIY
X-Gm-Gg: AZuq6aJEyxFQXUWJ2r5I9V3Tx3ByilQs0lviTDhymrks2AjUX+nHBG9ZZJcSpOI9GEv
	vpJL5qfetBQMyDakxF4H4r5VhZo3aCFBqVyw0F71Vavy9wJFA35Ip+WVDB4Fg6NldIxVns+4/Pi
	cmoANVcruFCb7LBJJ373DfWZ2MnOX3e9S5DAg6ym2pLNGIX4R+YRXY/KoYqfXmnGUPJI2hx0j9O
	LK05gWgvb8MvnQPf2eUcDmkfUjpOOiKr8uk//iIClxxdIpm9HYIKme0MSRkjhDV6425sDfbYNDX
	MHc+i0r82ghZ2uo1Ld6L6TKUUpm2DXoYEyyXZ6fWk76RZ7e3B0SgCBhIvNvn71XkueHEio6ezYG
	ngY7I46ETRrgW7NwFMSZXzkOUfQp7yoLJTNZDoJoGqfQsCTqWIlzY264WgUVLwFLZkLB/SfiUxU
	JqP0puyBnuoKF19FY79dIoC3g=
X-Received: by 2002:a05:7300:d518:b0:2b7:857:db6c with SMTP id 5a478bee46e88-2b856833ac5mr1062394eec.28.1770384185589;
        Fri, 06 Feb 2026 05:23:05 -0800 (PST)
Received: from [127.0.0.1] ([57.151.137.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855c6a574sm1628521eec.26.2026.02.06.05.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 05:23:04 -0800 (PST)
Message-Id: <504edcb0f522f18cb5586bb47bd2bbaf7c3adffb.1770384180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1987.v4.git.1770384180.gitgitgadget@gmail.com>
References: <pull.1987.v3.git.1768376879.gitgitgadget@gmail.com>
	<pull.1987.v4.git.1770384180.gitgitgadget@gmail.com>
From: "Claus Schneider(Eficode) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Feb 2026 13:22:57 +0000
Subject: [PATCH v4 2/5] read-cache: submodule add need --force given
 ignore=all configuration
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
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Brandon Williams <bwilliams.eng@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

From: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

Submodules configured with ignore=all are now skipped during add operations
unless overridden by --force and the submodule path is explicitly specified.

A message is printed (like ignored files) guiding the user to use the
--force flag if the user explicitly wants to update the submodule reference.

The reason for the change is to support branch tracking in submodules
with configuration `submdule.<name>.branch` or similar workflows where the
user is not interested in tracking each update of the sha1 in the submdule.
You can additionally set `submodule.<name>.ignore=all` and the `git status`
will state nothing and, with this patch, the `git add` does not either - as
the default behaviour. This patch changes the workflow to a more logical
behaviour and similar to workflow for ignored files.

The patch gives more scenarios for submodules to be used effectively with
less friction similar to the "repo" tool. A submodule can be added for many
different reasons than a hard dependency. It can be added as loosely
coupled dependencies whereas the user wants the latest based on the
configuration `submoule.<name>.branch`, but are not interested to track
each commit in the `super-repo`. Currently it gives friction of handling
conflicts between branches even the sha1's are fast-forward and the user
just wants the latest in any way. The user can still add a sha1 explicitly
to track updates.

Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
---
 read-cache.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 0f4981d79f..cc79b25f43 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -47,6 +47,9 @@
 #include "csum-file.h"
 #include "promisor-remote.h"
 #include "hook.h"
+#include "submodule.h"
+#include "submodule-config.h"
+#include "advice.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -3910,8 +3913,68 @@ static int fix_unmerged_status(struct diff_filepair *p,
 		return DIFF_STATUS_MODIFIED;
 }
 
+static int skip_submodule(const char *path,
+						struct repository *repo,
+						struct pathspec *pathspec,
+						int ignored_too)
+{
+    struct stat st;
+    const struct submodule *sub;
+    int pathspec_matches = 0;
+    int ps_i;
+    char *norm_pathspec = NULL;
+
+    /* Only consider if path is a directory */
+    if (lstat(path, &st) || !S_ISDIR(st.st_mode))
+		return 0;
+
+    /* Check if it's a submodule with ignore=all */
+    sub = submodule_from_path(repo, null_oid(the_hash_algo), path);
+    if (!sub || !sub->name || !sub->ignore || strcmp(sub->ignore, "all"))
+		return 0;
+
+    trace_printf("ignore=all: %s\n", path);
+    trace_printf("pathspec %s\n", (pathspec && pathspec->nr)
+									? "has pathspec"
+									: "no pathspec");
+
+    /* Check if submodule path is explicitly mentioned in pathspec */
+    if (pathspec) {
+		for (ps_i = 0; ps_i < pathspec->nr; ps_i++) {
+			const char *m = pathspec->items[ps_i].match;
+			if (!m)
+				continue;
+			norm_pathspec = xstrdup(m);
+			strip_dir_trailing_slashes(norm_pathspec);
+			if (!strcmp(path, norm_pathspec)) {
+				pathspec_matches = 1;
+				FREE_AND_NULL(norm_pathspec);
+				break;
+			}
+			FREE_AND_NULL(norm_pathspec);
+		}
+    }
+
+    /* If explicitly matched and forced, allow adding */
+    if (pathspec_matches) {
+		if (ignored_too && ignored_too > 0) {
+			trace_printf("Add submodule due to --force: %s\n", path);
+			return 0;
+		} else {
+			advise_if_enabled(ADVICE_ADD_IGNORED_FILE,
+				_("Skipping submodule due to ignore=all: %s\n"
+					"Use --force if you really want to add the submodule."), path);
+			return 1;
+		}
+    }
+
+    /* No explicit pathspec match -> skip silently */
+    trace_printf("Pathspec to submodule does not match explicitly: %s\n", path);
+    return 1;
+}
+
 static void update_callback(struct diff_queue_struct *q,
-			    struct diff_options *opt UNUSED, void *cbdata)
+							struct diff_options *opt UNUSED, void *cbdata)
 {
 	int i;
 	struct update_callback_data *data = cbdata;
@@ -3921,14 +3984,19 @@ static void update_callback(struct diff_queue_struct *q,
 		const char *path = p->one->path;
 
 		if (!data->include_sparse &&
-		    !path_in_sparse_checkout(path, data->index))
+			!path_in_sparse_checkout(path, data->index))
 			continue;
 
 		switch (fix_unmerged_status(p, data)) {
 		default:
 			die(_("unexpected diff status %c"), p->status);
 		case DIFF_STATUS_MODIFIED:
-		case DIFF_STATUS_TYPE_CHANGED: {
+		case DIFF_STATUS_TYPE_CHANGED:
+			if (skip_submodule(path, data->repo,
+								data->pathspec,
+								data->ignored_too))
+				continue;
+
 			if (add_file_to_index(data->index, path, data->flags)) {
 				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
 					die(_("updating files failed"));
-- 
gitgitgadget

