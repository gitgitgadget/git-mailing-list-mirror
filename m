Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED576214C
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 20:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857553; cv=none; b=OqwNxrueCmJq46RkDrhkfd3aXvPEPuMR/IxnP+CmK39y4AIc0K+LA3/fHEDeWV3B6HYTZfJiZZJQU0IJkSbkOze1XMhtGQRMVhh4XTU+4Iqa3RDETFRMPfk1K4E0p7tSIWNxCBykxjjE7oWEjJ1wvBTJmIAHDouKDDXFXqz/FQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857553; c=relaxed/simple;
	bh=nKVqwyTqva0tbdDVV1iBiNAMNvjSnOzTkYM8zmRgppg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Qcv8z3XBIwAdV4V1BWdWS3MJcDGmvULc3K0I2iSva2AeKAiUycJfX0vjA8YEGcblpJSm/a+BGX+ZSzqVqIj8CAJEgfDfJUGDmCt2+RXHMS2lS6oCv03VEYT9+vjflhM3yaR4nw95lsdhCJtj5jCYwNqp+Tpr7OlQ6vXSPDSYMYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsKRzrQV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsKRzrQV"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-411d76c9ce3so3301445e9.3
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 12:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707857549; x=1708462349; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZ1vbJBqwq2j4qrnDhXesWSb1fA2Xwy+5KVtWvrKu6w=;
        b=EsKRzrQVmjtTqODsv7o30IgxBPYATOqtCFi2/xzwlLZSVyeQDsZl9r7v8G6pCennof
         fm9AO/UVbGfIcCAH+pb+9rWH/D9JXIJ0L7KP2d9hvyL/ufUq6TmSvUCOyVCYZ7qED4pJ
         dO6kOKwUffYQj6TFpcEXAKTQhQSj6xzYA9lPlgcfDoiBvJdnxWtQOrq8iM0hLW8J7+bW
         zEEBTvZfL7VyNUKKiyTUN1vUq6xWod0Fvn0QRqD8GLbl8uz0f/O73/q8GoQ/oMkem+/O
         OfQmSjttL4llteZbzCh5DMeru9UdQtSn50IXXD5+++Nwilry67K6F3e1YreocTyYJC1X
         2Tpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707857549; x=1708462349;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZ1vbJBqwq2j4qrnDhXesWSb1fA2Xwy+5KVtWvrKu6w=;
        b=DkuaydY7jC/78b2yG4SOPbAS9oEQiagjUjimTzXgysSx/W61UWP/8a0rk8TJPEjpoA
         DuVfRg+bgX53DvqpNmVvhgCvNJ0L6udszqIaOwppFyN7v+gkKNjtBVPg7oqovZ3lT4rd
         YPbal7iwCmaq4yPPWleJCOxQBsT624jXoELID24XI1gOLKq1mU3tFV5TXAbx0G9FHbkS
         arw4xbMHxj9Uc7Lxxdj5+P4zQxNdcEeeROi0wlTvsdLlYfLezEovPEfHQHqd4EsIjccv
         5n9nMlFEsIVd8x5lEIkPIFDLyTd9lrOPJJwmzGIsrFeCGrU46WpMFUb1qRyl10GuMYQ4
         m+Ag==
X-Gm-Message-State: AOJu0YxSR8lNZMZCuPyvwkLxyV83sfJ4D3I9ansX3wXHEpXZEgvkwDBK
	HOb8cUfPRaStsCNDxSynhnUTtjmyIlpe+G6RmvskQiw0kbFKbE5APX6OWcfA
X-Google-Smtp-Source: AGHT+IEH6Y3iBpHLPQwWQubG1/cDQnNOVlYZo15tYemzCdb8tlmTYkh+10+10TvKTMfX9QMz/HZ+JA==
X-Received: by 2002:a05:600c:34c8:b0:40f:cf69:3e1a with SMTP id d8-20020a05600c34c800b0040fcf693e1amr529767wmq.39.1707857548777;
        Tue, 13 Feb 2024 12:52:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c190900b00410c2f39833sm8254846wmq.30.2024.02.13.12.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 12:52:28 -0800 (PST)
Message-ID: <1df4019931c29824b174defb75e09823d604219e.1707857541.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 20:52:16 +0000
Subject: [PATCH 07/12] fsmonitor: refactor untracked-cache invalidation
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

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 fsmonitor.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 754fe20cfd0..14585b6c516 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -183,11 +183,35 @@ static int query_fsmonitor_hook(struct repository *r,
 	return result;
 }
 
+/*
+ * Invalidate the untracked cache for the given pathname.  Copy the
+ * buffer to a proper null-terminated string (since the untracked
+ * cache code does not use (buf, len) style argument).  Also strip any
+ * trailing slash.
+ */
+static void my_invalidate_untracked_cache(
+	struct index_state *istate, const char *name, int len)
+{
+	struct strbuf work_path = STRBUF_INIT;
+
+	if (!len)
+		return;
+
+	if (name[len-1] == '/')
+		len--;
+
+	strbuf_add(&work_path, name, len);
+	untracked_cache_invalidate_path(istate, work_path.buf, 0);
+	strbuf_release(&work_path);
+}
+
 static void fsmonitor_refresh_callback_unqualified(
 	struct index_state *istate, const char *name, int len, int pos)
 {
 	int i;
 
+	my_invalidate_untracked_cache(istate, name, len);
+
 	if (pos >= 0) {
 		/*
 		 * We have an exact match for this path and can just
@@ -253,6 +277,8 @@ static int fsmonitor_refresh_callback_slash(
 	int i;
 	int nr_in_cone = 0;
 
+	my_invalidate_untracked_cache(istate, name, len);
+
 	if (pos < 0)
 		pos = -pos - 1;
 
@@ -278,21 +304,9 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 
 	if (name[len - 1] == '/') {
 		fsmonitor_refresh_callback_slash(istate, name, len, pos);
-
-		/*
-		 * We need to remove the traling "/" from the path
-		 * for the untracked cache.
-		 */
-		name[len - 1] = '\0';
 	} else {
 		fsmonitor_refresh_callback_unqualified(istate, name, len, pos);
 	}
-
-	/*
-	 * Mark the untracked cache dirty even if it wasn't found in the index
-	 * as it could be a new untracked file.
-	 */
-	untracked_cache_invalidate_path(istate, name, 0);
 }
 
 /*
-- 
gitgitgadget

