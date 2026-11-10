Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270180;
	b=dPPTma5efeI+RQy9eBD/W4PFuY9xGrHA0v7PW4bPBAhsaaKsxEsRRuSoQcLkSGlE42JE
	 RnoXvEb4zUc8AaULqDM+KSg1bwUWVjtyre3t3zj3e6VBRxFfha7bzQNQn6tDD3F2Cx4UP
	 TOe2hoTNUtsxG14s6r3gl9KpzwVQ2Cf8pC6YUMxiRVim6mEmlryb3+7uLChg8ImphMHnY
	 t/6VVjKLSdtStwmdGmWQ8vfG8mTDIrAZeEHltBP/eS/G1c9paxV7rHZdYgKbyWDRnqk2o
	 dAdY/XlYDJF8w9gJiFQJ7F5Aa7mCX/8ZacqMfHkD9VrsnOBVCv6TxQzwdx+7pCFhhdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270180;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=v6P0+/U/y5Ll+rhgyO2/zyKNsO5BzFrFHZUeCsBIlYo=;
	b=gCIu4rKFPJTYZcSD5PCPhh8FSdegrP+DNb5gZj66NgM3gSAKsK2bsY0oe6Sb5l6crauu
	 lgfMDxLf8w3soIvC3zNd+huwvidvOQAERpRFJivVLznn2vYjpXZetFQVn48YwGJPaSfmX
	 8eY1+LeiaZt/HMVj7evT35jiXNb1AteIwhwYBSmbrQhFuORzi0nMk6JhQs/AvChzrstyt
	 IgI2/hcpwhFxv9MJ0vCcK+iZidQQtnEZj6uuDvxL3wzNFeEk6RjJnNL4mdDDOAWBb9ZLh
	 0PlVlFWXN2wuvP4MbSNcHV+bUdFyafgEUJ3mGzxvc0UCEkAqSyTEgK+wPB0YICZNXuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=abEePDNb;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA8160A2617
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 00:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBA8160A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=abEePDNb
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-85d363fb73cso804651a34.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 16:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794270179; x=1794874979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v6P0+/U/y5Ll+rhgyO2/zyKNsO5BzFrFHZUeCsBIlYo=;
        b=abEePDNbTz4SGAV0tP3ZBkejhdv5C+/6j9TesK0kBG488rB83PHYWMJPIXrrDZOcYz
         fPfVAo7bxWhQj2PbxYzvg8vCZSEeQzXHN8ssw/P1zLq8mU5TF3uQYaJYRkWEoC706NSu
         SpYW/FnALgV9vgxssQxMQMc7RHnUnSRlby8m9ovDdKBwhksre/AcIuhMJtRGo9azwLtD
         mB5q7+jKrXHn2pwaO6f6VqSqxxw140xfgZh9l/DHt7fNyBMqeSnbJIJulB8tGNmv40aj
         sPhNT8qi7m+V6Mdt3WvEDF/CmlefNOxs6nXeQVELJt8vYgHyAupgUH+n4mUfXalF2iQq
         uKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270179; x=1794874979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v6P0+/U/y5Ll+rhgyO2/zyKNsO5BzFrFHZUeCsBIlYo=;
        b=WJjukBFC7kM0NzfpPvkNGVr+6oRA0GVuPbG67N+armsP3/tODixbIFClxgMOY/ICWn
         ruro4r7LY5oe+s9ubPSv7FKRx6eN5czHMZQuIvbQX13gajrKU2tPV5lEBTSNR6nJRXb0
         FcRKri7Xc8fA1MG5WEPgHw+pvLnJ2S9p1JkgNA3XaSagtVsBaZqTNQjjHMeKPRT+J1n5
         h2b8As1tu7zfogwUzyzm/tI9nar+JT+l+TDhPw+kddmy4frPsw6mEI7568NXQhXBVl3p
         z4hwrQaGGE6ALMJzKrFgOZ8GW5o5ZKDzWgLQb/g7XYHAqtmR6bB4CSfyi/08bkQKRHSq
         rgZA==
X-Gm-Message-State: APuU4Z+1BF4Zvcm13X7M+8CWLFaJQBCV7ztnkxq/JSP9xX5SYxtflPfN
	wWQX6qN5nO07C5xj4SzAVv5pkmb+pwmOI7C7wRoaU3cap8dnvg+1EYTYTyPPFg==
X-Gm-Gg: AYBFou0ekwZB18V8Is9U2KnQ6kC4nXr0v0uKOWzP32mjGjbV9CfQi/oJ87SerZBzLBG
	0ixQqkc0ER7lfwo5FvjXW2YeVsX4adawQ66Mr63ZR2LLk4B4B6p++oPLzwXHuK0JeKkHWLmDs/+
	mHr74yKI81TOnbi4nHc5GriNuXYN8LihDBPhJN2HgzymtfGpA4jIJ9fLqk+W3Drm5hrFDu2BHnf
	Axi5me7kKaBn8Nb5pfVtLHfgJhtyCW8GtfMy38vWe0fhHS1QwzB6b7FTqH1ajNPT0ct8dlXELV/
	77/OiVu2Pe3Ca8rHplJqLz0o/MA9GU2DUgbsGVeYM/xOPZ4EufB4Mpakrmrh4fvj8wHUykS9JKY
	ju0hSCwSqCzTAbfKxf+cm2C+Xc4LGPbF271UGNzM3xmR0preuqy9uzgQ/Uj5kMo9R9dqqRaShQd
	mQB1WXGTD2TeSE3y7IH/LkrFn5VRCztzKHIREfyuTOMc9KdvbNv3e5BWyLvaSQSTHvp6VQWkuHu
	53G1cc2ayZqVpkcTt95KF/opvzdzcgJagpZivyn9RBPOkAt1mv7Q/52CI3Xi/s61C5c9wcX7NrI
	EEIk2DnLbf0QP2MfhZwPol4KrdwSkCpVfsgHtk1EZIGfiaUkycOgwjNYcln3YtLWPQEHgkTLqzn
	5NKnsGSbjFpls0g==
X-Received: by 2002:a05:6830:2b23:b0:826:b77:adef with SMTP id 46e09a7af769-860dc7b5766mr775684a34.14.1794270178860;
        Mon, 09 Nov 2026 16:22:58 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcbc82b5sm680518a34.17.2026.11.09.16.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:22:57 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 3/4] tmp-objdir: preserve errno when directory creation fails
Date: Mon,  9 Nov 2026 18:22:50 -0600
Message-ID: <20261110002251.2007617-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261110002251.2007617-1-jltobler@gmail.com>
References: <20261110002251.2007617-1-jltobler@gmail.com>
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

When `tmp_objdir_create()` fails to create the temporary object
directory, it cleans up after itself before returning NULL. Depending on
where the failure occurred, this cleanup may clobber `errno`, leaving
callers without a way to reliably tell why creating the directory
failed.

In a subsequent commit, ODB transactions create their temporary object
directory eagerly and report a more specific error regarding creation
failure. Preserve `errno` across the cleanup so that callers can inspect
it accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 tmp-objdir.c | 8 ++++++++
 tmp-objdir.h | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tmp-objdir.c b/tmp-objdir.c
index 5307717354..4b91d86787 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -148,10 +148,13 @@ static int setup_tmp_objdir(const char *root)
 {
 	char *path;
 	int ret = 0;
+	int saved_errno;
 
 	path = xstrfmt("%s/pack", root);
 	ret = mkdir(path, 0777);
+	saved_errno = errno;
 	free(path);
+	errno = saved_errno;
 
 	return ret;
 }
@@ -163,6 +166,7 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
 	struct odb_source_files *files = odb_source_files_downcast(r->objects->source);
 	static int installed_handlers;
 	struct tmp_objdir *t;
+	int saved_errno;
 
 	if (the_tmp_objdir)
 		BUG("only one tmp_objdir can be used at a time");
@@ -185,8 +189,10 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
 		chdir_notify_register(tmp_objdir_reparent, t);
 
 	if (!mkdtemp(t->path.buf)) {
+		saved_errno = errno;
 		/* free, not destroy, as we never touched the filesystem */
 		tmp_objdir_free(t);
+		errno = saved_errno;
 		return NULL;
 	}
 
@@ -197,7 +203,9 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
 	}
 
 	if (setup_tmp_objdir(t->path.buf)) {
+		saved_errno = errno;
 		tmp_objdir_destroy(t);
+		errno = saved_errno;
 		return NULL;
 	}
 
diff --git a/tmp-objdir.h b/tmp-objdir.h
index a301b01d84..4ef6750a01 100644
--- a/tmp-objdir.h
+++ b/tmp-objdir.h
@@ -26,7 +26,8 @@ struct tmp_objdir;
 
 /*
  * Create a new temporary object directory with the specified prefix and
- * install the directory as the primary write target; returns NULL on failure.
+ * install the directory as the primary write target; returns NULL and sets
+ * errno on failure.
  */
 struct tmp_objdir *tmp_objdir_create(struct repository *r, const char *prefix,
 				     int will_destroy);
-- 
2.56.0.173.gf57c9a7388

