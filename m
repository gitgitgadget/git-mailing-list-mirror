Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EB730FC29
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567348; cv=none; b=aa+WkAOQQhBTyGiamPylMeFm2tIbp12kIb3rVfPQglWBweDNFjaQuagZXovtcipYIW8v9l/gOKRUBeFfV2OS/0twG/8ifgtg1kgC/0sxueWjco1Uzb/9fQI/ERhFm8JF+71c6YshjskHByfEkQxyN9cXwjco+PiOZxUisSOH7lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567348; c=relaxed/simple;
	bh=7PqDbJMWMMO6q5HA1e1sXV4d4N/XN5U/LXEgvHYpaSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uu4Ddv8nZU7OHpLRDGmEWoHJy3avqWgoqsDNw7E/r2D3+6KMyNMgdwPxyI2GntricpWvInBK3a4oMLQADdCjZmTT0AL+2Et9vaNdteBQf2zTfWFMVod4NcSGoP2vVg7TUjqCy4hhYm5CfbGdINfQzeP1aLc+gup2O3mJ8hrRC9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=qqEgeRaz; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="qqEgeRaz"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d5fb5e34cso930727b3.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567343; x=1761172143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yaLG12XzN8pDdRgsaHnQo5J+ixGzZr/HseGQoDKWv+I=;
        b=qqEgeRazL/f3lCktc6eoeqiwoebz9zFPRr/yQQyw3/XqfIdDHjOfuh2EZTIBUOqsH5
         8zVHmSUM2rwHT1oNhbkNV+aTjiDb+b2qOYUFvtTzrpIxKsokMpEy2wyNfOWxa7oOdT1m
         H86vT6QhpHRcamjDzMKzeekp1ppLtK1MgFXvMN42VClfYZek5mIHQaOMGL+GtVha3szi
         bgRGDX5Z4SNzOgWKBu+a/R//WN3XaU1ah0gg/p2dYn8nKb5XLXUg3FO0Bc0hEqZ/BF/+
         +brDlWSA10H6GrTwBAumrnzb/Ahvn7XHuQPl8+KcClCeIzmochqsIkDHliQmTY1pBrg9
         FgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567343; x=1761172143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaLG12XzN8pDdRgsaHnQo5J+ixGzZr/HseGQoDKWv+I=;
        b=BhCJQJnNtIPDaRvDHuxSbv7S5ZXO4kQTkChdwwoY0EbFLT5msDcBbg8dEEYVmcxOmi
         mPLVUF/D7VJxMyHmT6w1QIcjJYZuYQvKVhgB3NOy9BtSxqL+tA9OvUiVE2D2j1XSOEPx
         EurMFu8/ecqnRSe60vd39c5xzMub2D85GqxINPKczmNhfInQYq+enGZUcwLkjCv/jNnx
         8jSzVVGysACBubykBvRtQF0F+3pL2HfAC2RSfnKaJVJDPIdOGnFo73GMe+iVgoseG5Re
         4Oauyv8QPjJj7jxyNONyI89EJDMFkRBsdteQPMMbYseX8The9fqfVbz+RNsJRQa4m7dp
         0FCQ==
X-Gm-Message-State: AOJu0Yxhy07b2LLHEAksbruie2IMm2V+52PAFAtcm7aNgtQ0Y7ZqOgiH
	EgrR65tJD6djDXhswbptCSkSrSL/HpygKUjRqpPQW99l3BrQS5UUTFhmsj/uSix45iptGTIaAqx
	Xxzic6dgbnA==
X-Gm-Gg: ASbGncurRrWImlfubJVF+3j6wTLDmIe8taPUAjKcVd971TpV+0i3HX8tnTBm8EtDO+4
	oy9kmMBeN2oYNs6tB9FuQf8CJl7JmMBBoG2EdepLicdBCOPfwHzYOFkS4srO240o9LT3rUsfYjC
	Ic7W5Ab3ono4UHGirmYJJgxTYa4Yq1M1OZ8770Zq7V1FNwfUpel2L9eBLwvv77mTo9z2soFZ6IP
	/qEYyF/DFUT365S9bAf+n78xyFMyyDuPrA+Lwtmq7YMHsY06+QaJcYrlF/Gda8caqyR+wc1oSYe
	NtoxS9chDCZpF9QucUENl4zFUvyfWR1JC9UcgPkju2WaUBsOCymt1h4P205QDhCpkVhEVvW6Jxc
	qZ1iFnHBQglMFLmiKsY+/v/0xveHL3Y4e2QO8bU8+ydlGN4H7tmhq/P4gWD5fgDxB+Olv4l+LpS
	mI4JerORXCrwTjzos5Cyh3ZhNGBdTt0v7qZn8JA4AhHpLNLWtCLQGDBBqdKVX6f45M2JLoqNwZ6
	OWVGXXZB+dNEOeGqA==
X-Google-Smtp-Source: AGHT+IFsCsKqbaluHrALaR8c5Rsdc3sFpq5mEApoOetQVCU/0dVUGfz5xklB8caUpZ8pGPnERWBo/g==
X-Received: by 2002:a05:690c:4a07:b0:772:495e:56de with SMTP id 00721157ae682-78266674251mr15815297b3.0.1760567343528;
        Wed, 15 Oct 2025 15:29:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7828d7b987bsm2741567b3.27.2025.10.15.15.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:29:03 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:29:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 35/49] builtin/repack.c: reorder
 `remove_redundant_bitmaps()`
Message-ID: <8042860b26230b50c51e98db30960272392a6b12.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

The next commit will inline the call to `remove_redundant_bitmaps()`
into `write_midx_included_packs()`. Reorder these two functions to avoid
a forward declaration to `remove_redundant_bitmaps()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 58 ++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index a57a14ef60..865e0af039 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -296,6 +296,35 @@ static void midx_included_packs(struct string_list *include,
 	strbuf_release(&buf);
 }
 
+static void remove_redundant_bitmaps(struct string_list *include,
+				     const char *packdir)
+{
+	struct strbuf path = STRBUF_INIT;
+	struct string_list_item *item;
+	size_t packdir_len;
+
+	strbuf_addstr(&path, packdir);
+	strbuf_addch(&path, '/');
+	packdir_len = path.len;
+
+	/*
+	 * Remove any pack bitmaps corresponding to packs which are now
+	 * included in the MIDX.
+	 */
+	for_each_string_list_item(item, include) {
+		strbuf_addstr(&path, item->string);
+		strbuf_strip_suffix(&path, ".idx");
+		strbuf_addstr(&path, ".bitmap");
+
+		if (unlink(path.buf) && errno != ENOENT)
+			warning_errno(_("could not remove stale bitmap: %s"),
+				      path.buf);
+
+		strbuf_setlen(&path, packdir_len);
+	}
+	strbuf_release(&path);
+}
+
 static int write_midx_included_packs(struct repack_write_midx_opts *opts)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -373,35 +402,6 @@ static int write_midx_included_packs(struct repack_write_midx_opts *opts)
 	return finish_command(&cmd);
 }
 
-static void remove_redundant_bitmaps(struct string_list *include,
-				     const char *packdir)
-{
-	struct strbuf path = STRBUF_INIT;
-	struct string_list_item *item;
-	size_t packdir_len;
-
-	strbuf_addstr(&path, packdir);
-	strbuf_addch(&path, '/');
-	packdir_len = path.len;
-
-	/*
-	 * Remove any pack bitmaps corresponding to packs which are now
-	 * included in the MIDX.
-	 */
-	for_each_string_list_item(item, include) {
-		strbuf_addstr(&path, item->string);
-		strbuf_strip_suffix(&path, ".idx");
-		strbuf_addstr(&path, ".bitmap");
-
-		if (unlink(path.buf) && errno != ENOENT)
-			warning_errno(_("could not remove stale bitmap: %s"),
-				      path.buf);
-
-		strbuf_setlen(&path, packdir_len);
-	}
-	strbuf_release(&path);
-}
-
 static int finish_pack_objects_cmd(const struct git_hash_algo *algop,
 				   struct child_process *cmd,
 				   struct string_list *names,
-- 
2.51.0.540.ga7423965ad8

