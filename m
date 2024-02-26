Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE75D132C12
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983579; cv=none; b=RGQ/9+C2eq6hnUN/M8BYBmGQ3xcCkR7G/Yn7CFLeAQkhlZ1hCUztZX9WXOYJM6Oa5Or75M4TQpKM1BENui/IxNe8t6iYmXls1THx47gdaRZoz0/A7IQECqASlmGmfq7/5jELjL0Aie3TH7NQwbl3u3ICdG572AFzZ+MUwpqzdQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983579; c=relaxed/simple;
	bh=+RJFxPxyhNAoSRYSOr0W3UbtUKn46L4I2/i53cfAsK8=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rX39f++M5Rgdc+n4XH8XcejQjlSHeMlgO6HngzZr6zEjecr4p0x8Fe3R3tiPTkM0HrmSBJIz+d2J0FDXnt/KCBPnq+Drsg7TzQ6z+0P2DqK1Wl46E/s+Gs4vAzAblMYh97PxKSq4aRxo1b9355ApKVYJK7jMtKc4yqcb4Y75EOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Of0hoxWp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Of0hoxWp"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4129ed6f514so15183405e9.1
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 13:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708983576; x=1709588376; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqstBc0E6ZD2vwPCXf6WhhzYXHYFVGnSD4Cm9vEbGNo=;
        b=Of0hoxWpkoQqLH5N/rt5yqatPDfxBaE8bdgN4IexCho98WjIAYofhiPs/z/FpI2RBs
         avMRp/fJWhC757Fc+B7jhpsdnzXxTz3F3/ZJ4OtgMMOCWDD9Ye+Nzd01zy/5U1nXA0Op
         aPtTJkHl/xRG7Hr9zGbIpoxm5eDw3a7hmouVUfWJRgZvMmGDjwjl4is+Vue0Y5VrlCGb
         Wfl0Y3CxveWD9re3CoKCsDZfQAtSi6mQpIrgHfIF94g10pPRi4HP9faWUrJ2k2g8P+Ka
         8JpbAKmTMt8NeD+/uceDy2ifMEt/Vefaj/08dPlzp3YJ7BzswfvWog7v3z7jE3HNJnp6
         DlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708983576; x=1709588376;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqstBc0E6ZD2vwPCXf6WhhzYXHYFVGnSD4Cm9vEbGNo=;
        b=LrnkjmgXIgwnGXMcz08DJogF/3s6QsOX8JXhDqf2f2Q72OhHy63+w3+l8tDeeCQYqd
         pEsuXsB1JKquCtXrMvx0XRJQwQC8nRmy6I+N6BUlpDC+zmblA3wr25ksCF+n9wKP8G6c
         wtMdWzA5r0DkiT5H7ji74HsoYp4NgImUMxzGacLjcD7KRMpJW7jniUXH5+XL1PhkKdUB
         z4FByHjpf45IgMXfbuEYvUInf64kObX90dVHCqQQf13mjn7A9DOJ5QELm3fwdJiSM0a3
         lljdQveHrchfdYK/RcddyL00gUdjiDvnZgkqLMP/Kvt5pTyeACSBOwRxROilHUMEh9fa
         Y48Q==
X-Gm-Message-State: AOJu0YwwpYyI00SFlamBXCfysD0vvaR+BtQeebS10EmxKWB1cMij9aDD
	iabC7zLD5v/IMBDcgaudSx4fY2GUHfbbsJid2IR46VwxsCqhlEoDIbnJIClP
X-Google-Smtp-Source: AGHT+IHxAQ9+OjS8exZ24gICmOhZqd9VFXn7283yoZGa0niLK6PbO6/zA/QJ3HFfrJ296UIChkLM9w==
X-Received: by 2002:a05:600c:468f:b0:412:6404:45d2 with SMTP id p15-20020a05600c468f00b00412640445d2mr6179062wmo.28.1708983576003;
        Mon, 26 Feb 2024 13:39:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i11-20020a05600c354b00b00412aae76435sm431040wmq.8.2024.02.26.13.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:39:35 -0800 (PST)
Message-ID: <3fa7536cf8039c4e9324d9ea6d2b0e9ae4bbb10b.1708983566.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
References: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Feb 2024 21:39:21 +0000
Subject: [PATCH v3 10/14] fsmonitor: remove custom loop from non-directory
 path handler
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff Hostetler <git@jeffhostetler.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Refactor the code that handles refresh events for pathnames that do
not contain a trailing slash.  Instead of using a custom loop to try
to scan the index and detect if the FSEvent named a file or might be a
directory prefix, use the recently created helper function to do that.

Also update the comments to describe what and why we are doing this.

On platforms that DO NOT annotate FS events with a trailing
slash, if we fail to find an exact match for the pathname
in the index, we do not know if the pathname represents a
directory or simply an untracked file.  Pretend that the pathname
is a directory and try again before assuming it is an untracked
file.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 fsmonitor.c | 55 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 9424bd17230..a51c17cda70 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -183,11 +183,23 @@ static int query_fsmonitor_hook(struct repository *r,
 	return result;
 }
 
+static size_t handle_path_with_trailing_slash(
+	struct index_state *istate, const char *name, int pos);
+
+/*
+ * The daemon sent an observed pathname without a trailing slash.
+ * (This is the normal case.)  We do not know if it is a tracked or
+ * untracked file, a sparse-directory, or a populated directory (on a
+ * platform such as Windows where FSEvents are not qualified).
+ *
+ * The pathname contains the observed case reported by the FS. We
+ * do not know it is case-correct or -incorrect.
+ *
+ * Assume it is case-correct and try an exact match.
+ */
 static void handle_path_without_trailing_slash(
 	struct index_state *istate, const char *name, int pos)
 {
-	int i;
-
 	/*
 	 * Mark the untracked cache dirty for this path (regardless of
 	 * whether or not we find an exact match for it in the index).
@@ -200,33 +212,28 @@ static void handle_path_without_trailing_slash(
 
 	if (pos >= 0) {
 		/*
-		 * We have an exact match for this path and can just
-		 * invalidate it.
+		 * An exact match on a tracked file. We assume that we
+		 * do not need to scan forward for a sparse-directory
+		 * cache-entry with the same pathname, nor for a cone
+		 * at that directory. (That is, assume no D/F conflicts.)
 		 */
 		istate->cache[pos]->ce_flags &= ~CE_FSMONITOR_VALID;
 	} else {
+		struct strbuf work_path = STRBUF_INIT;
+
 		/*
-		 * The path is not a tracked file -or- it is a
-		 * directory event on a platform that cannot
-		 * distinguish between file and directory events in
-		 * the event handler, such as Windows.
-		 *
-		 * Scan as if it is a directory and invalidate the
-		 * cone under it.  (But remember to ignore items
-		 * between "name" and "name/", such as "name-" and
-		 * "name.".
+		 * The negative "pos" gives us the suggested insertion
+		 * point for the pathname (without the trailing slash).
+		 * We need to see if there is a directory with that
+		 * prefix, but there can be lots of pathnames between
+		 * "foo" and "foo/" like "foo-" or "foo-bar", so we
+		 * don't want to do our own scan.
 		 */
-		int len = strlen(name);
-		pos = -pos - 1;
-
-		for (i = pos; i < istate->cache_nr; i++) {
-			if (!starts_with(istate->cache[i]->name, name))
-				break;
-			if ((unsigned char)istate->cache[i]->name[len] > '/')
-				break;
-			if (istate->cache[i]->name[len] == '/')
-				istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
-		}
+		strbuf_add(&work_path, name, strlen(name));
+		strbuf_addch(&work_path, '/');
+		pos = index_name_pos(istate, work_path.buf, work_path.len);
+		handle_path_with_trailing_slash(istate, work_path.buf, pos);
+		strbuf_release(&work_path);
 	}
 }
 
-- 
gitgitgadget

