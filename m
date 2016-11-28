Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF8331FC96
	for <e@80x24.org>; Mon, 28 Nov 2016 09:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932393AbcK1Jn6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 04:43:58 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32771 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932334AbcK1Jn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 04:43:56 -0500
Received: by mail-pf0-f195.google.com with SMTP id 144so6213172pfv.0
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 01:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T2gHqkwNSzUB0IRL+NfP9eW+MVPHXzJ/q9/yPx1ge+8=;
        b=IAUXibmpPZHuPM+CmMNa9LpnbyB4M5t3EnUbeSrfRSpqvwq1ScjckqIsmrk99D/yqT
         ImJvEWhmnt2ufsfYuNA8YW4aiV1lUj+FeWGlA8HxtkTbFFt3qZSw8MkEGqVZG0dIRdRJ
         py62RA/iNzUEObMgu6AzNYSaUeh7Kg2G5BnHl0pBdOSxcO0hL5Z6puwfOYN93ZRP8Sj+
         apLsU3HEjQJ234+lj4t/PCgUTL79p46oxOoTStjTzymn57DMVD142EAbKzRaAXqm6fJj
         5a5AsQUIU7+u5PrNRuQAwjJ3GBgvm4pzibcrZoNgME646McuNBRe4RFtNEtZdsVCehki
         VtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T2gHqkwNSzUB0IRL+NfP9eW+MVPHXzJ/q9/yPx1ge+8=;
        b=Sx/QN9DN/QWchSm2gBlh5NrVPoJugtLRgB0IbcNP0WFAO8gFckeqE6GRREBmguyZwc
         QZNfLu2THk0KMuExU7wjkXzRVjAsrUqcQiFOnFWZ2qSphy8E7GU2ku6oAqN87dIr686W
         K4kcxePvlvLV3YDWvmS4CyWAma+7blDEHTQrlu7LzAjSFGh39WhHB9zteR0iKARb457q
         R5MLmpzeNkNO12XhRZnzk7/c0OQLOgzTVPsQPnef3ugabRiw4sbwMT3YVMe0/mlpS52G
         T78+Cmpi05XVRP0Ng0twp9FznzRInDR80UL628Jisetj8RqXacXpUYyrVJVbLoG8yNNx
         NCwg==
X-Gm-Message-State: AKaTC03BjWXQMZXN509udjwOwCebknsW9OiHOU8jp0H1tEBfrgEGxS/GYcELd9IRw55kbA==
X-Received: by 10.99.133.200 with SMTP id u191mr37877338pgd.28.1480326235795;
        Mon, 28 Nov 2016 01:43:55 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id t193sm67973952pgb.4.2016.11.28.01.43.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2016 01:43:55 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 28 Nov 2016 16:43:50 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 02/11] copy.c: delete unused code in copy_file()
Date:   Mon, 28 Nov 2016 16:43:10 +0700
Message-Id: <20161128094319.16176-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161128094319.16176-1-pclouds@gmail.com>
References: <20161112022337.13317-1-pclouds@gmail.com>
 <20161128094319.16176-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 - selinux preservation code
 - make-link code
 - delete link dereference code
 - non-recursive copy code
 - stat no preservation code
 - verbose printing code

Some of these are "cp" features that we don't need (for "git worktree
move"). Some do not make sense in source-control context (SELinux).
Some probably need a reimplementation to better fit in (verbose
printing code).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 copy.c | 101 +++++------------------------------------------------------------
 1 file changed, 7 insertions(+), 94 deletions(-)

diff --git a/copy.c b/copy.c
index 79623ac..b7a87f1 100644
--- a/copy.c
+++ b/copy.c
@@ -82,14 +82,7 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 	smallint dest_exists = 0;
 	smallint ovr;
 
-/* Inverse of cp -d ("cp without -d") */
-#define FLAGS_DEREF (flags & (FILEUTILS_DEREFERENCE + FILEUTILS_DEREFERENCE_L0))
-
-	if ((FLAGS_DEREF ? stat : lstat)(source, &source_stat) < 0) {
-		/* This may be a dangling symlink.
-		 * Making [sym]links to dangling symlinks works, so... */
-		if (flags & (FILEUTILS_MAKE_SOFTLINK|FILEUTILS_MAKE_HARDLINK))
-			goto make_links;
+	if (lstat(source, &source_stat) < 0) {
 		bb_perror_msg("can't stat '%s'", source);
 		return -1;
 	}
@@ -109,35 +102,12 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 		dest_exists = 1;
 	}
 
-#if ENABLE_SELINUX
-	if ((flags & FILEUTILS_PRESERVE_SECURITY_CONTEXT) && is_selinux_enabled() > 0) {
-		security_context_t con;
-		if (lgetfilecon(source, &con) >= 0) {
-			if (setfscreatecon(con) < 0) {
-				bb_perror_msg("can't set setfscreatecon %s", con);
-				freecon(con);
-				return -1;
-			}
-		} else if (errno == ENOTSUP || errno == ENODATA) {
-			setfscreatecon_or_die(NULL);
-		} else {
-			bb_perror_msg("can't lgetfilecon %s", source);
-			return -1;
-		}
-	}
-#endif
-
 	if (S_ISDIR(source_stat.st_mode)) {
 		DIR *dp;
 		const char *tp;
 		struct dirent *d;
 		mode_t saved_umask = 0;
 
-		if (!(flags & FILEUTILS_RECUR)) {
-			bb_error_msg("omitting directory '%s'", source);
-			return -1;
-		}
-
 		/* Did we ever create source ourself before? */
 		tp = is_in_ino_dev_hashtable(&source_stat);
 		if (tp) {
@@ -160,8 +130,6 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 			saved_umask = umask(0);
 
 			mode = source_stat.st_mode;
-			if (!(flags & FILEUTILS_PRESERVE_STATUS))
-				mode = source_stat.st_mode & ~saved_umask;
 			/* Allow owner to access new dir (at least for now) */
 			mode |= S_IRWXU;
 			if (mkdir(dest, mode) < 0) {
@@ -210,45 +178,17 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 		goto preserve_mode_ugid_time;
 	}
 
-	if (flags & (FILEUTILS_MAKE_SOFTLINK|FILEUTILS_MAKE_HARDLINK)) {
-		int (*lf)(const char *oldpath, const char *newpath);
- make_links:
-		/* Hmm... maybe
-		 * if (DEREF && MAKE_SOFTLINK) source = realpath(source) ?
-		 * (but realpath returns NULL on dangling symlinks...) */
-		lf = (flags & FILEUTILS_MAKE_SOFTLINK) ? symlink : link;
-		if (lf(source, dest) < 0) {
-			ovr = ask_and_unlink(dest, flags);
-			if (ovr <= 0)
-				return ovr;
-			if (lf(source, dest) < 0) {
-				bb_perror_msg("can't create link '%s'", dest);
-				return -1;
-			}
-		}
-		/* _Not_ jumping to preserve_mode_ugid_time:
-		 * (sym)links don't have those */
-		return 0;
-	}
-
-	if (/* "cp thing1 thing2" without -R: just open and read() from thing1 */
-	    !(flags & FILEUTILS_RECUR)
-	    /* "cp [-opts] regular_file thing2" */
-	 || S_ISREG(source_stat.st_mode)
-	 /* DEREF uses stat, which never returns S_ISLNK() == true.
-	  * So the below is never true: */
-	 /* || (FLAGS_DEREF && S_ISLNK(source_stat.st_mode)) */
-	) {
+	if (S_ISREG(source_stat.st_mode) ) { /* "cp [-opts] regular_file thing2" */
 		int src_fd;
 		int dst_fd;
 		mode_t new_mode;
 
-		if (!FLAGS_DEREF && S_ISLNK(source_stat.st_mode)) {
+		if (S_ISLNK(source_stat.st_mode)) {
 			/* "cp -d symlink dst": create a link */
 			goto dont_cat;
 		}
 
-		if (ENABLE_FEATURE_PRESERVE_HARDLINKS && !FLAGS_DEREF) {
+		if (ENABLE_FEATURE_PRESERVE_HARDLINKS) {
 			const char *link_target;
 			link_target = is_in_ino_dev_hashtable(&source_stat);
 			if (link_target) {
@@ -295,25 +235,6 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 			}
 		}
 
-#if ENABLE_SELINUX
-		if ((flags & (FILEUTILS_PRESERVE_SECURITY_CONTEXT|FILEUTILS_SET_SECURITY_CONTEXT))
-		 && is_selinux_enabled() > 0
-		) {
-			security_context_t con;
-			if (getfscreatecon(&con) == -1) {
-				bb_perror_msg("getfscreatecon");
-				return -1;
-			}
-			if (con) {
-				if (setfilecon(dest, con) == -1) {
-					bb_perror_msg("setfilecon:%s,%s", dest, con);
-					freecon(con);
-					return -1;
-				}
-				freecon(con);
-			}
-		}
-#endif
 		if (bb_copyfd_eof(src_fd, dst_fd) == -1)
 			retval = -1;
 		/* Careful with writing... */
@@ -348,9 +269,8 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 				bb_perror_msg("can't create symlink '%s'", dest);
 				return -1;
 			}
-			if (flags & FILEUTILS_PRESERVE_STATUS)
-				if (lchown(dest, source_stat.st_uid, source_stat.st_gid) < 0)
-					bb_perror_msg("can't preserve %s of '%s'", "ownership", dest);
+			if (lchown(dest, source_stat.st_uid, source_stat.st_gid) < 0)
+				bb_perror_msg("can't preserve %s of '%s'", "ownership", dest);
 		}
 		/* _Not_ jumping to preserve_mode_ugid_time:
 		 * symlinks don't have those */
@@ -370,10 +290,7 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 
  preserve_mode_ugid_time:
 
-	if (flags & FILEUTILS_PRESERVE_STATUS
-	/* Cannot happen: */
-	/* && !(flags & (FILEUTILS_MAKE_SOFTLINK|FILEUTILS_MAKE_HARDLINK)) */
-	) {
+	if (1 /*FILEUTILS_PRESERVE_STATUS*/) {
 		struct timeval times[2];
 
 		times[1].tv_sec = times[0].tv_sec = source_stat.st_mtime;
@@ -389,10 +306,6 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 			bb_perror_msg("can't preserve %s of '%s'", "permissions", dest);
 	}
 
-	if (flags & FILEUTILS_VERBOSE) {
-		printf("'%s' -> '%s'\n", source, dest);
-	}
-
 	return retval;
 }
 #endif
-- 
2.8.2.524.g6ff3d78

