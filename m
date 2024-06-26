Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25299186285
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412199; cv=none; b=OfKM08IarJFcWV8bDOui09DLILLes/Qdtnd2tJWsltFcX8PTOsQvcPcfWMzG9N6Okpf/Zds/Gk5KkaMnMFK8sTx/TRkjlH0FJyLDin6WIw0E7ncISwipc330u9dd7LY/rXvmQI3BJTo74FUJGTVGtOn4/GRAemHXHyZqsLI7jmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412199; c=relaxed/simple;
	bh=mKI90b/YGFpefVFGNK/0fVqAD9pGjE9PJw08JNb6Gps=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OYc21PmdB4WFT/sI1M932i96rSiAYo8aNr1BmvEiiCfSLJMhUBekY08eUqu1HDTK4EVkvGh0KvH8/qYFNuRSHCT8SidZDVzyduK6wwlgGuN5bOKii5r593cgRjdl77C880YYV0TcZTSm5HBZUuPTb08cec9gmUoKEkSRPQpg5K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TozZHU81; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TozZHU81"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ec52fbb50cso45795461fa.2
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 07:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719412196; x=1720016996; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xO1bF8/D+K6VmcsbNZerxp108u1S6w5egvhSyaxchUI=;
        b=TozZHU815mc3jQLI8olFS4/er/3wW4rrjxvTIWh3EEEFCqBbdv/a3wmwr5q1Q57jil
         p2psSZCpNzQouGFI4ZZASJo6VtwbpJOytMg9i/WFvOExxnDttUL/Uny4JnQqFXCc66Wc
         6MiSp2jdud6yxdSDpapEFb3bbndUOh9+GVcKoYbKjIjb30DNYCNFxsBskBx0Sve07dq8
         bZKgcEq21UzIxdDzNuIWLWBmuz93OdkhDI3qNEwKgi3Wkvh+7TviA2KsN7rxo7Jm1/sa
         c9Uh6cX9vRTmJdBf8LVMYM8y5LzREr6Ly2qjtLmqwCXwzFFBA+5HiyO2EO/tWI9P9Igr
         Jabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719412196; x=1720016996;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xO1bF8/D+K6VmcsbNZerxp108u1S6w5egvhSyaxchUI=;
        b=hVEDBoC/HRC8UWmkLaC7ssuvIBK+Op7/DIOaQhljBv2ns8+syrkIZ1l/f/7h2K2M5C
         XXUlZzViAlgXqRuXz6WpV6DaiED4hS5vkV7KdpeEfxSVFgOS39LpnkpwHtMpyQcyfc/W
         XSawphlUYRAGFTlQlH1k6XLRUveJi7emD4LqQqU0aEultX3ucBB85BI0zBynDAE/CXfd
         VZxd6WTCS21oN5wU6A6hkF5+45i8269KWEgLJyV33CCIoszuzZ+pN7OIkinvHeLpy/8K
         iJRq0CSYwr0tbMIx488rR/LEbhQorzRYv2XTIuEa43Kmk7LmNntgtbpFr18t2tVwU+W0
         4jwQ==
X-Gm-Message-State: AOJu0Ywo7bhO6OZfAmRdJF+Ta+crI/c+5v1P2poBin6D8xIDJHJs3Quo
	4dAIKwEwxP4P9wDJvl+4taMLzL85CrmU7lTDJGNhEpCwlHcNNuPY7uwYuw==
X-Google-Smtp-Source: AGHT+IELP5ndCbE+OHwGN60yWzOEk6SgWKRJb8hhfRnt7795RZgtA9t9d/y422WqqbMD2usSHtQIEw==
X-Received: by 2002:a2e:9d86:0:b0:2ec:5a0d:b2dd with SMTP id 38308e7fff4ca-2ec5b2f0373mr63734311fa.39.1719412195950;
        Wed, 26 Jun 2024 07:29:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8264891sm28402975e9.25.2024.06.26.07.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 07:29:55 -0700 (PDT)
Message-Id: <0a82e6b4183e007316a8b027086ad3c960901103.1719412192.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1754.v2.git.1719412192.gitgitgadget@gmail.com>
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
	<pull.1754.v2.git.1719412192.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Jun 2024 14:29:49 +0000
Subject: [PATCH v2 3/5] sparse-index: use strbuf in path_found()
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
Cc: gitster@pobox.com,
    newren@gmail.com,
    anh@canva.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The path_found() method previously reused strings from the cache entries
the calling methods were using. This prevents string manipulation in
place and causes some odd reallocation before the final lstat() call in
the method.

Refactor the method to use strbufs and copy the path into the strbuf,
but also only the parent directory and not the whole path. This looks
like extra copying when assigning the path to the strbuf, but we save an
allocation by dropping the 'tmp' string, and we are "reusing" the copy
from 'tmp' to put the data in the strbuf.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 sparse-index.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index de6e727f5c1..fec4f393360 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -440,31 +440,30 @@ void ensure_correct_sparsity(struct index_state *istate)
 }
 
 struct path_found_data {
-	const char *dirname;
-	size_t dir_len;
+	struct strbuf dir;
 	int dir_found;
 };
 
 #define PATH_FOUND_DATA_INIT { \
+	.dir = STRBUF_INIT, \
 	.dir_found = 1 \
 }
 
 static void clear_path_found_data(struct path_found_data *data)
 {
-	return;
+	strbuf_release(&data->dir);
 }
 
 static int path_found(const char *path, struct path_found_data *data)
 {
 	struct stat st;
 	char *newdir;
-	char *tmp;
 
 	/*
 	 * If dirname corresponds to a directory that doesn't exist, and this
 	 * path starts with dirname, then path can't exist.
 	 */
-	if (!data->dir_found && !memcmp(path, data->dirname, data->dir_len))
+	if (!data->dir_found && !memcmp(path, data->dir.buf, data->dir.len))
 		return 0;
 
 	/*
@@ -486,17 +485,15 @@ static int path_found(const char *path, struct path_found_data *data)
 	 * If path starts with directory (which we already lstat'ed and found),
 	 * then no need to lstat parent directory again.
 	 */
-	if (data->dir_found && data->dirname &&
-	    memcmp(path, data->dirname, data->dir_len))
+	if (data->dir_found && data->dir.buf &&
+	    memcmp(path, data->dir.buf, data->dir.len))
 		return 0;
 
 	/* Free previous dirname, and cache path's dirname */
-	data->dirname = path;
-	data->dir_len = newdir - path + 1;
+	strbuf_reset(&data->dir);
+	strbuf_add(&data->dir, path, newdir - path + 1);
 
-	tmp = xstrndup(path, data->dir_len);
-	data->dir_found = !lstat(tmp, &st);
-	free(tmp);
+	data->dir_found = !lstat(data->dir.buf, &st);
 
 	return 0;
 }
-- 
gitgitgadget

