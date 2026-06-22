Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7220C3911A1
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116918; cv=none; b=UZ2MkcpQW0RZuPa3Rm15WXC7fwDIkTIylL4FnLEugZj4uJBVBJe0upIfwB7EysFI4IQDR6f4w4gAk7dbSnhVUhKc4zxTIhhwS4g1VgiDTJGuvDAqPlv4+CumqmZMqM9dRxI1iDF67/GQN8EmkSHbYs5k1rVbiXg7F9a0cYVMDaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116918; c=relaxed/simple;
	bh=ZEBc06ZfCMzg8D5SVxbFnrG+HhdOKWtA89taXHDp8v0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kj0klDUp6/3D1tiW+J/vDERIrhvd4/9ZeSVsEPZew+lbCEA/Am9VLyEqtl9ZD4AiCt7Vy3YiK5g1FhtCQ5eN4vQg16AawHZOU9wwuqhfEVFnwV46UN+aB6hE5ECGg2UKRpnPcjtcHkNaRHJRU+zceoLvkDdKaLK5qX4K33tiv/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kh+ot6rp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GDgQKx/c; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kh+ot6rp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GDgQKx/c"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A27F41D0003D;
	Mon, 22 Jun 2026 04:28:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 22 Jun 2026 04:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782116911;
	 x=1782203311; bh=INfx7H+liujI1MbiCb1gWHHn3BL/W5QAL8l5j8XBXiI=; b=
	Kh+ot6rpQd5bQtZ4AT2Pxcbqc9gBrQXNb6K6KHOy6qjR/htMlQ72MzDw7qBtnAT9
	gZLyKIxmulZqFuRojI1i5P1vhgxljTyUBXjZY+ebMXOFUtuf7aXn8b50OBifRmkX
	AOHS2I0mlZaZYyWGsgaiouj6i+9fn/sInts9PjdtU/qsmyYjnOUxEZWUHas/uLNs
	pqxKd5pppmJjhz4fVTGB4MWm6uANd7KtxOLwtwIG/c0LPMQsELPighd5YJHZ6aEJ
	zKy1IDDCtxXk+OzNqkKNfpW5w3i/JIMAZFUF2FNQSs6u6UxvIpHznvMTcYP1OScN
	N4tUJE/zsGV6sHurExIgJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782116911; x=
	1782203311; bh=INfx7H+liujI1MbiCb1gWHHn3BL/W5QAL8l5j8XBXiI=; b=G
	DgQKx/cpGzr/Ps6RcJWeclizZaSjTc7xiQeHaW/ELsHEt3LbrwHSbUKS3mSsSEvz
	ZvyuVHPpaRAjaUHzpeem+nbrK2RacwjSZOyTsE7haShx7unlK/4y27myWpqmlaeo
	CDaImU8Yue2cB78NLfOGUuKj6Hhnx06aoPikL07lEFxFdyGtT4MAdNWrme1iRALw
	/o4vE6Vv6w3TUqb5Rpe2itjnAoYAVrlD4ajGUs83F7+i2GOewiLZPAugxwbmvjYA
	Vf7QQkZswWAwCXl6g3Tsjkt/HWT0sPS7GBnJv5jsLPxAgsQM5SHXcGpGTGntpRd4
	l2BrztaOpiuUky1r80+4Q==
X-ME-Sender: <xms:L_I4ahzm3tU6nOK2oXIER5Z7J7wO43ut61N5D8Bv5i-IjDKDO0GuUw>
    <xme:L_I4aoTiox8Ptj_93nyudics4FFhpsBUFNTzJoZzO38dpwfO1IVAgG_57wxIME81e
    JqpTBRH9fdOANuKa_YH8T6tQApQm3FFnHVbGqcHSfAjYi0gh-QOmg>
X-ME-Received: <xmr:L_I4agUY5G2Y8uob47jQZj0BmQnZ1HtaDcE4-w3oWiY-g1QztXOeXeEQprokc53pCSPcA5qucY4ZpFm7sZvwXkc9b9sWrKSAa9sVK6wMEw>
X-ME-Proxy-Cause: dmFkZTFGuvhk19wP1nIdECGxwx3gbsw2ufEFYPW/bcryZRaeS0zP3zRO2BkgCLVXG+HRAu
    eDSJo9XC9+oh3Bg4ZRtWUyrhjPNmJp3YOJHUnxHZF9fRZrG2CDlLXQ1vIYWsZ6wE8vVEag
    zy9G92nuZEbjKcNWm4jg58++glxCpMiBCJ8FdiujUMh3AT0f9M3NX3x4YMlYXDCGdPE5Jo
    sF+G7mjGMycHN/Ao7CZBomtDY3FTUdRjzmq4savyltQeIxi4PefUj35UFTgtSExhYooKOd
    zIHDBAiAvQ1kUkDPooo/KXMo5cdMPFyZNxi4JoyhlbXctSkAgq/pHTp6e/bmoS79cQ0ACK
    BsAIXWPfNqYE08cuR7APD0eDucqMXoHA8yfQnMYXA+XMknVrX+ozFbeafakF4IaSF0pSfh
    OFffNY0adHJDqcy3JKr4araV7si0GlnGPaEFKUn7idIlWCy2NhNdBg4UMHxNPA80eyRM92
    FBnddXxOhaVCjue0bgES+pHfQbqfY6s/Z6peEJgv0bFFn03kH/AAnnEPCAv0khQiP/ENJA
    iezEPIiVj2VmYAOkz1edPqVZJs6AwgwkaLtpSLgiwfTaq6CWb33++yBZ2WKIED+nBvNulG
    UHQhJRtQQbTbJ25JVL42ugz23of1205l2HjIwAcCmo2PrM1H6ys+pcUiwS4w
X-ME-Proxy: <xmx:L_I4aibGbgtF_AbUP-csJn4RLgAPsJeWRWVFt1-N9Uc03k4jNyGiRw>
    <xmx:L_I4au23ebA3rsYtkZN630tuRqIMpf8yCAnrr2zYt7LzHrUjURfqLw>
    <xmx:L_I4asiLJOIsipfwfGJ8zDwQxe9wG3U1J51Dk0CgYl4CwpN1WhfEAg>
    <xmx:L_I4aqZHcPO6PaAB2dViZMsLtHZUsH3YQbz3Bc9Z-ZDGQMx2XAeZqA>
    <xmx:L_I4akae8h4sjGAzsiwQYnqbaj0YSgN8Yog-Vl1oV1Awz5r7pLZbK9rn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 04:28:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b0a4d04c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 08:28:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 22 Jun 2026 10:28:23 +0200
Subject: [PATCH v5 01/11] setup: inline
 `check_and_apply_repository_format()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-1-018475013dbc@pks.im>
References: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
In-Reply-To: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

We have two callsites of `check_and_apply_repository_format()`. In a
subsequent commit we'll want to adapt one of those callsites to change
the order in which we read and apply the repository format, at which
point the helper function will not really be a good fit for us anymore.

Inline the function to both of the callsites.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 47 ++++++++++++++++-------------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/setup.c b/setup.c
index b4652651df..a9db1f2c23 100644
--- a/setup.c
+++ b/setup.c
@@ -1788,32 +1788,6 @@ int apply_repository_format(struct repository *repo,
 	return 0;
 }
 
-/*
- * Check the repository format version in the path found in repo_get_git_dir(repo),
- * and die if it is a version we don't understand. Generally one would
- * set_git_dir() before calling this, and use it only for "are we in a valid
- * repo?".
- *
- * If successful and fmt is not NULL, fill fmt with data.
- */
-static void check_and_apply_repository_format(struct repository *repo,
-					      struct repository_format *fmt,
-					      enum apply_repository_format_flags flags)
-{
-	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
-	struct strbuf err = STRBUF_INIT;
-
-	if (!fmt)
-		fmt = &repo_fmt;
-
-	check_repository_format_gently(repo_get_git_dir(repo), fmt, NULL);
-	if (apply_repository_format(repo, fmt, flags, &err) < 0)
-		die("%s", err.buf);
-	startup_info->have_repository = 1;
-
-	clear_repository_format(&repo_fmt);
-}
-
 const char *enter_repo(struct repository *repo, const char *path, unsigned flags)
 {
 	static struct strbuf validated_path = STRBUF_INIT;
@@ -1887,9 +1861,17 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
 	}
 
 	if (is_git_directory(".")) {
+		struct repository_format fmt = REPOSITORY_FORMAT_INIT;
+		struct strbuf err = STRBUF_INIT;
+
 		set_git_dir(repo, ".", 0);
-		check_and_apply_repository_format(repo, NULL,
-						  APPLY_REPOSITORY_FORMAT_HONOR_ENV);
+		check_repository_format_gently(".", &fmt, NULL);
+		if (apply_repository_format(repo, &fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
+			die("%s", err.buf);
+		startup_info->have_repository = 1;
+
+		clear_repository_format(&fmt);
+		strbuf_release(&err);
 		return path;
 	}
 
@@ -2820,6 +2802,7 @@ int init_db(struct repository *repo,
 	int exist_ok = flags & INIT_DB_EXIST_OK;
 	char *original_git_dir = real_pathdup(git_dir, 1);
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
+	struct strbuf err = STRBUF_INIT;
 
 	if (real_git_dir) {
 		struct stat st;
@@ -2846,9 +2829,10 @@ int init_db(struct repository *repo,
 	 * config file, so this will not fail.  What we are catching
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
-	check_and_apply_repository_format(repo, &repo_fmt,
-					  APPLY_REPOSITORY_FORMAT_HONOR_ENV);
-
+	check_repository_format_gently(repo_get_git_dir(repo), &repo_fmt, NULL);
+	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
+		die("%s", err.buf);
+	startup_info->have_repository = 1;
 	repository_format_configure(repo, &repo_fmt, hash, ref_storage_format);
 
 	/*
@@ -2904,6 +2888,7 @@ int init_db(struct repository *repo,
 	}
 
 	clear_repository_format(&repo_fmt);
+	strbuf_release(&err);
 	free(original_git_dir);
 	return 0;
 }

-- 
2.55.0.rc1.745.g43192e7977.dirty

