Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795047658;
	b=ANe1Hg1vfLvyXP3KC4kOw5zsDd1pG8eGGi/c+eE+LfBO8u3gbxaGN3Isk/jzy5kCCIqH
	 ugVE1fVELca9UtvPSuFS1CVnPHVwjjeGZgsckOGqZVn1axmLdkpQApdxilZ9WVSEwAp3p
	 KfsU4a4DzD5gNUBkFXsNPehAq+72dKEjgCMaXchs+akXnIhrF9UAVzd5rOqYpabcp58DC
	 0fOXsy5PTsqdgrCz802vyZybVI6E8gCpIZ8VK5JSP/VsYr79Tuyc+vD0K9D72M0G7b7+r
	 9F3HAEghKtFCOfGuxqQq5YHqqgMOI3qoVAodH79ia1X9Va62h2gV7RL9Bun0VGu7c6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795047658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7ZS3aZGLa2ReLHkrJ+g2qaZq+Amnl6zX9JxjzEbW/IQ=;
	b=XhGD+WYMhdjUkxee8On9uU9clbshjnv7osd3GE5xYaBBEDfU+YwuiMwUofGW0TkEyTzu
	 0jImm3XDdgTfqLmwCZTY1ii7JqCfiwhdJO11gndbnDkhf+8ACGEAatvh3WR5IbSbHyLuK
	 eCA2o9szSt5cJYirICR8zFOswrXRUl57oFl0TCSeXGBraH7lReSAizLIsyhtjMulOsQUV
	 akfbzpUCYtlTHmxZdXQYyscy2el2Y/UcTikFzotHLSKn3uQaQw3+DYotvsmkunaYL3xzo
	 lw25QV9P+ETMCD0bgHEV9YD8UNKbsx254bkjHSLAPdz65NQV7NnuLdBa6QBZAYNUH9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lNmCgDQk;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19309606A33D
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 00:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19309606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lNmCgDQk
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6d68de53053so1195629eaf.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 16:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795047657; x=1795652457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ZS3aZGLa2ReLHkrJ+g2qaZq+Amnl6zX9JxjzEbW/IQ=;
        b=lNmCgDQkp9a06ZAKlgflCmivXtKYW9cDC1olFjDNNLJ+ZzXtZV6vP/o3etAkWjPSIe
         xCvTw7pLalkY02K85BtD+LvU39M4/d0EmQ85WpdQnva/TRudPjd2tAeTUaBbWZ9ArAXV
         4+EM6x+nUynrokE/MjcLvz6eObhfofh0O/sWmAeJaUTlm7F68WGN2hHQ6QG02jMfbsOS
         Q3De7GOmGZcGDQc4faoUqqVMbWUHgqWEi9wMAwgujiQe7r59ajvkt7b10Rjd8QfZBKQ+
         gzPDnvE9qeGoL23w6nJ7dEaFzWVjB3EOynrY/lx2PVtHWM+HavTs5WSHklqEf9buwKiP
         9JtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795047657; x=1795652457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7ZS3aZGLa2ReLHkrJ+g2qaZq+Amnl6zX9JxjzEbW/IQ=;
        b=obo3gbrFeZGsGOL8qVDO5AMLbTYGQtqr1Ik0a8GY4EYDOx7hQ0aveyEG49gSiZE/K1
         tpHhZ02CoJ68esccR4fwgXTX28Kn5ZGGcQUzmaJNdzUa7sOe4E4M3vySLw/ET0qpJXsJ
         MdJ93m2vJVmf5JMTqT7nqFdsYMJ+qbhybBkuOjWoLuCT7H/FEo4dYmeVZ79aCr4m+w18
         nUx94VQCuqjcfLcM1Sg53xb8t0jbj0IPFiGrbsPV3kuRwPYbuRoLhzC9N6kaPRWReTW0
         Ujhl8vn0bJ3KSC3BHbWWvDk/ZLh9FsUUCI/QPmEnS/y2+32Kurksf+ujF+9y5ycNr7Uy
         1HPw==
X-Gm-Message-State: APuU4Z9y8TYaG5Xh3CZEbhE3EMfcVTzLusGpZEkgaNSMgmrLAdKVviwz
	ficvUVUpUjFNBc5ccChRFLSWzY8el2jMWVT7FltnX8M8LCHS8rb/mjQXGT5vkQ==
X-Gm-Gg: AYBFou1eHpP/XBefG0kBnmTk/eC3EU8uWMtFHf73aoTz4vlIlBzRfZe0/YV+YVR5/Iy
	Jcx0aedSJiiP0mBYg0E+ddjf5a0/vS3GYVrpA1C3HCAL8lnMp7dxnXT4UAAOeg2edVVs5juK5ZN
	aJXRQnBPzR+x858PnYYjfGJpgfZOgpVejqJZ74rMzHwyF9w/sDMJj0qXy5iuIT63jPlI5vGukJF
	cFSx1MjGMTyvLSst9UkZLHwDosimwnhyga1ZA3GxzSWE1bl/0ylL3SoBxXxyfdWXJ6TjKNZFxkl
	G5+OwXtbIMqcCf3LxVES66W5tb5x4XW+V5mgQKdWK33hDAlBL72fY4cWyzM5vXgkC/cvZ4IjQ6D
	SMehtbLYyvYIAoYqNBlPxhnw+w9OUPBA2D5QfBulZdToTqy5h2Q0HxXa6n+1Ve0E879lGfYaIXQ
	yBgacXWBY4rRXW9GXOaTEnxokZGwZHIssfXqG1W1xx4K124xFkSfO/mwkMo9m2s5lP/b0GkJnzc
	lcf4kOIeLkww3nPwtdYGiEe2hcyhSLTAGHIjigYnT4U53sLpYIdyxmNjLD/pQpZe8ZZifsogvSL
	nNcvINY6gU1p9F1n47JHD/dlVthhxzw5NJoAtbSWsWkusQueVL5z/pB2d8CREMpvxRVB
X-Received: by 2002:a05:6820:708c:10b0:717:10a2:89a4 with SMTP id 006d021491bc7-71b1864d702mr2317447eaf.76.1795047656972;
        Wed, 18 Nov 2026 16:20:56 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f01d492dsm3293400a34.6.2026.11.18.16.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 16:20:56 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 4/6] tmp-objdir: preserve errno when directory creation fails
Date: Wed, 18 Nov 2026 18:20:41 -0600
Message-ID: <20261119002043.2108654-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261119002043.2108654-1-jltobler@gmail.com>
References: <20261110002251.2007617-1-jltobler@gmail.com>
 <20261119002043.2108654-1-jltobler@gmail.com>
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
 tmp-objdir.c | 11 +++++++++--
 tmp-objdir.h |  3 ++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/tmp-objdir.c b/tmp-objdir.c
index c78fc0e6b6..c3549c2e8d 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -151,6 +151,7 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
 	struct odb_source_files *files = odb_source_files_downcast(r->objects->source);
 	static int installed_handlers;
 	struct tmp_objdir *t;
+	int saved_errno;
 	char *path;
 	int ret;
 
@@ -175,9 +176,10 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
 		chdir_notify_register(tmp_objdir_reparent, t);
 
 	if (!mkdtemp(t->path.buf)) {
+		saved_errno = errno;
 		/* free, not destroy, as we never touched the filesystem */
 		tmp_objdir_free(t);
-		return NULL;
+		goto error;
 	}
 
 	the_tmp_objdir = t;
@@ -188,10 +190,11 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
 
 	path = xstrfmt("%s/pack", t->path.buf);
 	ret = mkdir(path, 0777);
+	saved_errno = errno;
 	free(path);
 	if (ret) {
 		tmp_objdir_destroy(t);
-		return NULL;
+		goto error;
 	}
 
 	env_append(&t->env, ALTERNATE_DB_ENVIRONMENT,
@@ -214,6 +217,10 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
 	t->repo->disable_ref_updates = true;
 
 	return t;
+
+error:
+	errno = saved_errno;
+	return NULL;
 }
 
 /*
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

