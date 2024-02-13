Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AE562144
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 20:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857553; cv=none; b=FLNCksinl9n8y1ZOXE8YZDAMul+t/WJDxNlAlBCzCMl2cIqEGFaXNa457sUBaiLsu1nLAB9qX0+Vhyv0wJR7BpPSIDCn9Lg33a/vcAhq23FpMin6GKnUj9Z1fOTPGn7ntr6TPHa1/v9uJrjtGHAj7helIJ3BbbSCOkLcbr6O9Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857553; c=relaxed/simple;
	bh=j3C3MZrwnGm5zxFS0cziJeQGFQ2FE0J7FnnFY+UNimA=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=k7W7STCGRyEPgSh6nADK+8VNzQziE7jaR+WVioy4gF8JBC3UEUtOdhnJDAAoW9EXnz0CPLxhTsogWMQH+Stxm3BsgBXTcErbu7y1yPuICck7uzqOZKWNGM1ZbELAAabOfXu8qsT6CtzpwYxn1mgbz2CanPMR8z6rUK11XLmFrdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfD086YS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfD086YS"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4114e0a2978so15297295e9.3
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 12:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707857550; x=1708462350; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pt657PS+1YvskOQb//W4hDB6kfHYbQUH81vTiCfN9rU=;
        b=AfD086YSQF38ZYsWWpw81Sx5R0AIcSQ9OXSZkn/ASfJ5b3PDD+QR7kmuvaNUfh90jH
         ntUXLL/sZsge1ZFCQdx6IpEhjciPXt2vY9NE2TKrSHhFQt/YSTQstluwNvAOn1vpW763
         LGt5G5Q2EnUOX65M4qzZ+2r/fNaPK27VOB17+TQJdNt4eJzV6MH35S5XzqqeNhdupi2E
         yTMApLMBmCUbeMIBmrP/ksNOXrWN9G55/xBR9j0pvvCPwLP4E2dTE/RMrPerkq07rcTv
         UU3VzD/THoqP+94wZVisWzF+JTXTEAoACJTdzyElFddGgKbWlQq9qJtiNkRxiBlyFRxq
         y5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707857550; x=1708462350;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pt657PS+1YvskOQb//W4hDB6kfHYbQUH81vTiCfN9rU=;
        b=P6A2/pJ4V2xtI8ECs2VobjljtIqMjVOOWJ2IRjpJr2DxXw2BuFwco2jX71rYCSU3LA
         r4bZ1vLL1IO4DRZlV9/EcsjCo71nRNMG1YJ/8CYnvSUkLq4mMWY11XhW56kdi/gcmAfF
         9iLK6yyADoECieobLHsVbCUSQZmKtmXvwI3t70qkI+EPBv+XHEseD7jHoIHBA/qZ4w2z
         YzfG77VE/cyRLjxbMQJhkwG4zNqP004epkEjRJU1W70nTyL2k8+1XX0A9AJs6Mx+ilRG
         91TLnNixYMksQuz3QeSXUxI+H5QvNr1cmc7BByTMvrbMf0Mjqtjd2k+2wypDrscdZz/q
         857w==
X-Gm-Message-State: AOJu0YyVY6iW0OefKYuH0V/Q5YFdivj5ZtWjYTiKl149NIWpNCl5eGfR
	m/qjAUrM6Gi2nF0IzKO1YW8ip8xY3P910pYvMgb3QaBH0fio+0Cr6R8TFlKB
X-Google-Smtp-Source: AGHT+IHw4+Qf+Fl42QJq/5nyMHg+nJE5R/UcDCqHIl5Mt9pE7rekGx6oQA9gD0gEStj09Ma0SJiUQA==
X-Received: by 2002:a05:600c:1f8f:b0:410:c25d:37d0 with SMTP id je15-20020a05600c1f8f00b00410c25d37d0mr671969wmb.21.1707857549892;
        Tue, 13 Feb 2024 12:52:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o16-20020adfead0000000b0033b4ef142edsm10403034wrn.110.2024.02.13.12.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 12:52:29 -0800 (PST)
Message-ID: <e0029a2aad68a60f672e74368a384f68a343e21c.1707857541.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 20:52:17 +0000
Subject: [PATCH 08/12] fsmonitor: support case-insensitive directory events
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
Cc: Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Teach fsmonitor_refresh_callback() to handle case-insensitive
lookups if case-sensitive lookups fail on case-insensitive systems.
This can cause 'git status' to report stale status for files if there
are case issues/errors in the worktree.

The FSMonitor daemon sends FSEvents using the observed spelling
of each pathname.  On case-insensitive file systems this may be
different than the expected case spelling.

The existing code uses index_name_pos() to find the cache-entry for
the pathname in the FSEvent and clear the CE_FSMONITOR_VALID bit so
that the worktree scan/index refresh will revisit and revalidate the
path.

On a case-insensitive file system, the exact match lookup may fail
to find the associated cache-entry. This causes status to think that
the cached CE flags are correct and skip over the file.

Update the handling of directory-style FSEvents (ones containing a
path with a trailing slash) to optionally use the name-hash if the
case-correct search does not find a match.

(The FSMonitor daemon can send directory FSEvents if the OS provides
that information.)

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 fsmonitor.c | 122 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 120 insertions(+), 2 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 14585b6c516..73e6ac82af7 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -5,6 +5,7 @@
 #include "ewah/ewok.h"
 #include "fsmonitor.h"
 #include "fsmonitor-ipc.h"
+#include "name-hash.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "trace2.h"
@@ -183,6 +184,9 @@ static int query_fsmonitor_hook(struct repository *r,
 	return result;
 }
 
+static int fsmonitor_refresh_callback_slash(
+	struct index_state *istate, const char *name, int len, int pos);
+
 /*
  * Invalidate the untracked cache for the given pathname.  Copy the
  * buffer to a proper null-terminated string (since the untracked
@@ -205,6 +209,84 @@ static void my_invalidate_untracked_cache(
 	strbuf_release(&work_path);
 }
 
+/*
+ * Use the name-hash to lookup the pathname.
+ *
+ * Returns the number of cache-entries that we invalidated.
+ */
+static int my_callback_name_hash(
+	struct index_state *istate, const char *name, int len)
+{
+	struct cache_entry *ce = NULL;
+
+	ce = index_file_exists(istate, name, len, 1);
+	if (!ce)
+		return 0;
+
+	/*
+	 * The index contains a case-insensitive match for the pathname.
+	 * This could either be a regular file or a sparse-index directory.
+	 *
+	 * We should not have seen FSEvents for a sparse-index directory,
+	 * but we handle it just in case.
+	 *
+	 * Either way, we know that there are not any cache-entries for
+	 * children inside the cone of the directory, so we don't need to
+	 * do the usual scan.
+	 */
+	trace_printf_key(&trace_fsmonitor,
+			 "fsmonitor_refresh_callback map '%s' '%s'",
+			 name, ce->name);
+
+	my_invalidate_untracked_cache(istate, ce->name, ce->ce_namelen);
+
+	ce->ce_flags &= ~CE_FSMONITOR_VALID;
+	return 1;
+}
+
+/*
+ * Use the directory name-hash to find the correct-case spelling
+ * of the directory.  Use the canonical spelling to invalidate all
+ * of the cache-entries within the matching cone.
+ *
+ * The pathname MUST NOT have a trailing slash.
+ *
+ * Returns the number of cache-entries that we invalidated.
+ */
+static int my_callback_dir_name_hash(
+	struct index_state *istate, const char *name, int len)
+{
+	struct strbuf canonical_path = STRBUF_INIT;
+	int pos;
+	int nr_in_cone;
+
+	if (!index_dir_exists2(istate, name, len, &canonical_path))
+		return 0; /* name is untracked */
+	if (!memcmp(name, canonical_path.buf, len)) {
+		strbuf_release(&canonical_path);
+		return 0; /* should not happen */
+	}
+
+	trace_printf_key(&trace_fsmonitor,
+			 "fsmonitor_refresh_callback map '%s' '%s'",
+			 name, canonical_path.buf);
+
+	/*
+	 * The directory name-hash only tells us the corrected
+	 * spelling of the prefix.  We have to use this canonical
+	 * path to do a lookup in the cache-entry array so that we
+	 * we repeat the original search using the case-corrected
+	 * spelling.
+	 */
+	strbuf_addch(&canonical_path, '/');
+	pos = index_name_pos(istate, canonical_path.buf,
+			     canonical_path.len);
+	nr_in_cone = fsmonitor_refresh_callback_slash(
+		istate, canonical_path.buf, canonical_path.len, pos);
+	strbuf_release(&canonical_path);
+	return nr_in_cone;
+}
+
 static void fsmonitor_refresh_callback_unqualified(
 	struct index_state *istate, const char *name, int len, int pos)
 {
@@ -269,7 +351,10 @@ static void fsmonitor_refresh_callback_unqualified(
  *
  * Return the number of cache-entries that we invalidated.  We will
  * use this later to determine if we need to attempt a second
- * case-insensitive search.
+ * case-insensitive search.  That is, if a observed-case search yields
+ * any results, we assume the prefix is case-correct.  If there are
+ * no matches, we still don't know if the observed path is simply
+ * untracked or case-incorrect.
  */
 static int fsmonitor_refresh_callback_slash(
 	struct index_state *istate, const char *name, int len, int pos)
@@ -293,17 +378,50 @@ static int fsmonitor_refresh_callback_slash(
 	return nr_in_cone;
 }
 
+/*
+ * On a case-insensitive FS, use the name-hash and directory name-hash
+ * to map the case of the observed path to the canonical case expected
+ * by the index.
+ *
+ * The given pathname includes the trailing slash.
+ *
+ * Return the number of cache-entries that we invalidated.
+ */
+static int fsmonitor_refresh_callback_slash_icase(
+	struct index_state *istate, const char *name, int len)
+{
+	int nr_in_cone;
+
+	/*
+	 * Look for a case-incorrect sparse-index directory.
+	 */
+	nr_in_cone = my_callback_name_hash(istate, name, len);
+	if (nr_in_cone)
+		return nr_in_cone;
+
+	/*
+	 * (len-1) because we do not include the trailing slash in the
+	 * pathname.
+	 */
+	nr_in_cone = my_callback_dir_name_hash(istate, name, len-1);
+	return nr_in_cone;
+}
+
 static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 {
 	int len = strlen(name);
 	int pos = index_name_pos(istate, name, len);
+	int nr_in_cone;
+
 
 	trace_printf_key(&trace_fsmonitor,
 			 "fsmonitor_refresh_callback '%s' (pos %d)",
 			 name, pos);
 
 	if (name[len - 1] == '/') {
-		fsmonitor_refresh_callback_slash(istate, name, len, pos);
+		nr_in_cone = fsmonitor_refresh_callback_slash(istate, name, len, pos);
+		if (ignore_case && !nr_in_cone)
+			fsmonitor_refresh_callback_slash_icase(istate, name, len);
 	} else {
 		fsmonitor_refresh_callback_unqualified(istate, name, len, pos);
 	}
-- 
gitgitgadget

