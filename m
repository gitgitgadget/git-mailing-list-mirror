Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EFD11C89
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 03:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658316; cv=none; b=Eev46iOfILjmanQSe98p/2hdNrXg+3Nyh3sZrfMpy4R6lPd25RgsRv+RMzOPxEwgHe4/AK3DueJF4o9m5KCdlC9ruaAV+Jj4cXj56MkDcyGFaB1ieVaItVWTTTAc+PjnxvXT/Go9JfX07T/ohSuNY10QjjvhG6MLZteIT0bZbkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658316; c=relaxed/simple;
	bh=+RJFxPxyhNAoSRYSOr0W3UbtUKn46L4I2/i53cfAsK8=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aR3xtdRee/5T+f9koe6+IC0J8Gw7E0dww1hSpPMqi12oUH/I2pTlYd1lH9ioIGxaJ/mC2DmcGXTzCYjqd9XqckU+ZvDE26Q+zQbvxJegAmQPos71LGhpEp1dUpc1n+9M8ZfQUlRFJejWTCNO6eDBiuO89RQy+l4HWr/VTpsv89I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dna8jsTm; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dna8jsTm"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412949fd224so229295e9.1
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 19:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708658312; x=1709263112; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqstBc0E6ZD2vwPCXf6WhhzYXHYFVGnSD4Cm9vEbGNo=;
        b=dna8jsTmCW9mmyAqOkhWZmgZHg3t4QFpFaUhwES1cqd8VEwfJzUKPpBxHviEp1UnfD
         PAU0EgiEJSuib7SX7ZBkqBLl4vTjw9WuEdsPqDQDaNLQD5Pg3ZmlgHr8DmectZUsZRLo
         hOEp3BbKIdS4Aw3ROJZ0dx7Y6vdAPDkBwhItCed9k05xyEOyKCuzHE9pXak2ULLZiDQi
         2L9vfNfsBij1QZrb8PfcFv4OW319QkDHwirOfz+FgBIqFswRZfUPxk1NhnJ/J51RmHa/
         9zdtIRhT5rU+OKz9ONJtK7AaLGi/GjCFJtY2fZULfdDu2GgCXGoKTGx0vo3S9qJ6IXxa
         Vz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708658312; x=1709263112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqstBc0E6ZD2vwPCXf6WhhzYXHYFVGnSD4Cm9vEbGNo=;
        b=gshrK8WKNEUO5kf9ckFX3C19bIpNjURlya8vhb9qoxjzrC99LQEdIT7021iP99vaD0
         SJcDrvvayB6WgieXPV/Rsyy++QnjK82EkADrxZ96fYEv8oooTKXnrnUwKkZa/FMndgsA
         x0aJoO+fqIUa/Q0S+AbwDs1eGAWF+pZNb3S/5JX9ORBYFolWUFA5gFWgOeQh7nsH4MKT
         2byV8myqhPeNkRI6kbwjFlYv3sAUJe5BMFa0KnxxZoZuXENDp10Qpj3TwFTNdY+2c45J
         hE1Ke/Rd8JIrguTEA6Qx+jAVT7rC7SlX/6yjLFA0lnHLev+YZ2xfGd3A2FIY8+DBjHLa
         N8Ug==
X-Gm-Message-State: AOJu0YwzRlNYElxil393YKjH1yw6oJAO8OlI8nv4TExtoUWm0DGUlfH1
	ecfUDRFdI0Qr16xBOx9smCbUx1bl6YMtHc9yYjiBve5inBK2wMClxcpFIk8+
X-Google-Smtp-Source: AGHT+IF5c7Ic+92jBdMsgnPl0xRxPXML4pvPbZyK6YDF1VXEyAOQsszWa5Zc3E89ApuW9uyyETyQSw==
X-Received: by 2002:a05:600c:a3a4:b0:412:8cfb:745c with SMTP id hn36-20020a05600ca3a400b004128cfb745cmr626031wmb.6.1708658312639;
        Thu, 22 Feb 2024 19:18:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k33-20020a05600c1ca100b00411d0b58056sm593600wms.5.2024.02.22.19.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 19:18:32 -0800 (PST)
Message-ID: <1853f77d3331f7736139f686ac2efee6d68f9207.1708658300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 03:18:15 +0000
Subject: [PATCH v2 11/16] fsmonitor: remove custom loop from non-directory
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

