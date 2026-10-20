Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502953;
	b=Mllgw60TRzOphP7tsQgCHJpet/TDXN+xwJ57vk09gdFTZeVAsQhq5/e23Gif4Hp56K9E
	 XmDcvKOisk8CmAt9ILuzMhgg9rpNB5lyjJJebJj1Gx8Atlo+I/+qjLEV9rDIwmmFmCY23
	 ljohJJ2ThEeJcuctskG24aNAkqb/k97EVBCC7RwFzQlMYd6tGGnwN+OQRyMr545MQM02M
	 OEwWKdFPnp5/1rEIW9WTJk8hJnwSuyqM7keC8H9MIMtq5YYHhfi9/GqzQAfTefHVnmX/x
	 Xwql4SGJWmB55x26YSvBy5z7G4bQpNqVtZ7ZkbinAlfbPoASwd79liTatihuJyIvOkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tq14daDldnm55NmNSbuZF+jaHM7W/OTZuwIg85imYUE=;
	b=TqtVBKm1EnfELzHnkaCQMebDWQNuOTx3HHh9t1LChFiKN9pahR0ugeDTBvKW4s4JXdPy
	 6kisV7GN6Cs0zzHqAXkmU5Np0TLSsZ9ZH2f8aiThSlOg7BlOkYbJyFD7GpM651TI0fSoB
	 Wcnjb2mNuvjaMfOGJGUYi03ncpaoGnyDYCwF9NFLqXTU5xeYN1Zweh0l5icVlCtKh1Dre
	 UQLQKZ/WK4pxrmsCJTO+Zz57P3MLoVSBkHKNPrynpSK/fCQhtUYOHIca9oWXb14hykXdB
	 NoE8Tx6LzfNz+/ZqDlcfimKZDGh0TIfOUtcPghxIXGfL+6UpA4GXGYQ31nR6zUaDr2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eIIp2YeQ;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1568606A330
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 13:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1568606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eIIp2YeQ
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-8198a3a54d7so646791a34.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 06:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792502951; x=1793107751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tq14daDldnm55NmNSbuZF+jaHM7W/OTZuwIg85imYUE=;
        b=eIIp2YeQIVEtfmh2nhE4uKEXm7Vu+Lx7Enzj5nHRhhuZH/CGwukckj3R38L14lii5S
         5Y0uA2sbXfPdKJeKe+EzCN2QuMbOWiyVWJO8PCBBHevO2mYB6tUe0x/0dSmLMsY1uxTC
         INNZ+NB+lCiDAIKp5MWsW6bGRaIXMa+I5nAxJzxspI3a8fIIQFvZ01HznUKLfiAe3Q8d
         Lo8/d0jsDQsi3t8Va2A6G6MN9SAb94IH8eL1TlZ5qYeTnkQx4+bAbkitAfkGGVPLXTrN
         qASOB5Dc7cNooWS3lG34hkDN4A9+YnV7QG++HLnYziicsHZN0fIb54yqNoEHMyJHiLv+
         t+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502951; x=1793107751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tq14daDldnm55NmNSbuZF+jaHM7W/OTZuwIg85imYUE=;
        b=IEMvke7CmcqJrQT3Fe0E0dXvFp05WBB7lPi72xs6JwgppAEUNa0ufcs3uYLWTi5LOG
         LKPHI7M6uLfG0Akbdq/RDHJPxnMn5iY2rC2pJaj7sOKfAZPlgfMvIY8PDenkgUi0f96K
         bVQLxRCqqQNBYoGnbof3cdoEmfkXf3i5343HEpxzz7LOOJXfilLQz2MPyb8xKSvIz5PO
         Jse05f/y0BogLVuopjbcUmD4ggW9k35uNZE2tI0atnt1H59YvsXpJOjE9u1JaKxX2ecI
         /pQstQt3kKDMO6I2rqFheGtPj5XwIAdHJWP3MxgDHacxKlWUNtuPx2Lalu5q3WsT4NFm
         bFjQ==
X-Gm-Message-State: AFq9FYI5t8Qd4QHvbExMe1VLXtEvfdUo8GscBfdTwjuvwUMscdHSNkkG
	8RiYKnlIBB+lL03OK1kA0XEDJZm0CGBvz1lwagFHGprSuJG7zdVyw9Yp+xfdRg==
X-Gm-Gg: AYBFou2Rik6XLwmb9V+6WcsEJDK/MvLKMSl1qwVDgzpn3xTyvVLQTd0HzkrvMaEQHI2
	4erIWJgu6CeXPEFXrey7MOa1qWMzwpy6a4BWcR4dLwSgBLS1zYv68msWz658w5Cggr6FHmJha+6
	8lW0pozM+RO9lCVIErQJs2SpXCjUD+o7mghfY+M7MHZoIJBzs7fq045O2k3VsJsAjk3qJyFc+8U
	HgyviYjWFXbPaZas2pBaGJQfF2uXNDtwC5xbBYasQXy0M+C+xQkcranjffRE8VnHO2cBDura68P
	bf+wc/n/OxSPxVtPM44/51sN4lBCCXdJ05MKd+69oVtYe9PnqcIorw4Mre1r2E/f1se8QUWsctA
	rv709Z3bAt/yIQa4A3jNGsw0lW2KPkCt8eurcwkK8aNx7lTksBBZaRp4oNTtDetq3S6zxpQtXJo
	Hju0VKBS9T1XrYsNEofz9L2h/wFBhQmROK5ATn/3gqwIDTfanWt8fUvbwkP+zv8+neTHgY+jdIJ
	AlJbtDIZqjA5YUe2R1vriZeLzYE+GIkEPEYxg==
X-Received: by 2002:a05:6820:1906:b0:6f8:51f5:b9af with SMTP id 006d021491bc7-707bab2b76dmr1247163eaf.25.1792502951617;
        Tue, 20 Oct 2026 06:29:11 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7018f2e0d89sm9973129eaf.6.2026.10.20.06.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:29:11 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 3/4] object-file: explicitly write ".keep" lockfile
Date: Tue, 20 Oct 2026 08:28:59 -0500
Message-ID: <20261020132900.1208343-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261020132900.1208343-1-jltobler@gmail.com>
References: <20261016213716.593278-1-jltobler@gmail.com>
 <20261020132900.1208343-1-jltobler@gmail.com>
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

The `odb_transaction_write_pack()` interface for the "files" backend
relies on git-index-pack(1) to write the specified packfile into an ODB
transaction as a packfile. To prevent a concurrent housekeeping
operation from deleting the newly written packfile prior to the
references being updated, a ".keep" lockfile is also generated by
git-index-pack(1) via the `--keep` option. Consequently, the ".keep"
lockfile is written into the ODB transaction alongside the packfile and
later migrated together to the primary ODB during transaction commit.

In a subsequent commit, writing the lockfile is deferred until
transaction commit and thus cannot rely on git-index-pack(1) to write
it. In preparation for this, update `odb_transaction_files_write_pack()`
to explicitly generate the same ".keep" lockfile itself.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 105 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 83 insertions(+), 22 deletions(-)

diff --git a/object-file.c b/object-file.c
index 210984f825..ad55c01198 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1256,6 +1256,45 @@ int read_loose_object(struct repository *repo,
 	return ret;
 }
 
+static int write_pack_lockfile(struct odb_source *source, const char *pack_name,
+			       const char *keep_msg)
+{
+	struct strbuf lock_path = STRBUF_INIT;
+	struct strbuf contents = STRBUF_INIT;
+	int ret = 0;
+	int fd;
+
+	strbuf_addf(&lock_path, "%s/pack/pack-%s.keep",
+		    source->path, pack_name);
+	strbuf_addf(&contents, "%s\n", keep_msg);
+
+	fd = safe_create_file_with_leading_directories(source->odb->repo,
+						       lock_path.buf);
+	if (fd < 0) {
+		ret = error_errno(_("unable to create '%s'"), lock_path.buf);
+		goto out;
+	}
+
+	if (write_in_full(fd, contents.buf, contents.len) < 0) {
+		ret = error_errno(_("unable to write '%s'"), lock_path.buf);
+		close(fd);
+		unlink(lock_path.buf);
+		goto out;
+	}
+
+	if (close(fd) < 0) {
+		ret = error_errno(_("unable to close '%s'"), lock_path.buf);
+		unlink(lock_path.buf);
+		goto out;
+	}
+
+out:
+	strbuf_release(&lock_path);
+	strbuf_release(&contents);
+
+	return ret;
+}
+
 static int odb_transaction_files_commit(struct odb_transaction *base)
 {
 	struct odb_transaction_files *transaction =
@@ -1348,9 +1387,13 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
 		container_of(base, struct odb_transaction_files, base);
 	struct repository *repo = base->source->odb->repo;
 	struct child_process child = CHILD_PROCESS_INIT;
+	struct strbuf final_path = STRBUF_INIT;
+	struct strbuf pack_name = STRBUF_INIT;
+	struct strbuf keep_msg = STRBUF_INIT;
 	struct pack_header hdr;
 	const char *hdr_err;
 	int err_fd = opts->err_fd;
+	int ret = -1;
 	int status;
 
 	hdr_err = parse_pack_header(&hdr, pack_fd);
@@ -1390,17 +1433,12 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
 		}
 	} else {
 		char hostname[HOST_NAME_MAX + 1];
-		char *lockfile;
 
 		strvec_pushl(&child.args, "index-pack", "--stdin", NULL);
 		push_header_arg(&child.args, &hdr);
 
 		if (xgethostname(hostname, sizeof(hostname)))
 			xsnprintf(hostname, sizeof(hostname), "localhost");
-		strvec_pushf(&child.args,
-			     "--keep=receive-pack %"PRIuMAX" on %s",
-			     (uintmax_t)getpid(),
-			     hostname);
 
 		if (!opts->quiet && err_fd)
 			strvec_push(&child.args, "--show-resolving-progress");
@@ -1424,34 +1462,57 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
 			return -1;
 		}
 
-		/*
-		 * The lockfile filepath is expected to be the final location of
-		 * the ".keep" file after being migrated to the main ODB source.
-		 * This ensures the lockfile can be found and removed later
-		 * after the ODB transaction has been committed.
-		 */
-		lockfile = index_pack_lockfile(base->source, child.out, NULL);
-		if (lockfile) {
-			ALLOC_GROW(transaction->pack_lockfiles,
-				   transaction->pack_lockfiles_nr + 1,
-				   transaction->pack_lockfiles_alloc);
-			transaction->pack_lockfiles[transaction->pack_lockfiles_nr++] =
-				register_tempfile(lockfile);
-			free(lockfile);
-		}
+		ret = read_index_pack_report(repo, child.out, &pack_name, NULL);
+
 		close(child.out);
 
 		status = finish_command(&child);
 		if (status) {
 			strbuf_addstr(err_msg, "index-pack abnormal exit");
-			return -1;
+			goto out;
 		}
 
+		if (ret) {
+			strbuf_addstr(err_msg, "index-pack failed to report pack name");
+			goto out;
+		}
+
+		strbuf_addf(&keep_msg, "receive-pack %"PRIuMAX" on %s",
+			    (uintmax_t)getpid(), hostname);
+
+		if (write_pack_lockfile(transaction->quarantine, pack_name.buf,
+					keep_msg.buf)) {
+			strbuf_addstr(err_msg, "lockfile write failed");
+			goto out;
+		}
+
+		ALLOC_GROW(transaction->pack_lockfiles,
+			   transaction->pack_lockfiles_nr + 1,
+			   transaction->pack_lockfiles_alloc);
+
+		/*
+		 * The lockfile filepath is expected to be the final location of
+		 * the ".keep" file after being migrated to the main ODB source.
+		 * This ensures the lockfile can be found and removed later
+		 * after the ODB transaction has been committed.
+		 */
+		strbuf_addf(&final_path, "%s/pack/pack-%s.keep",
+			    base->source->path, pack_name.buf);
+		transaction->pack_lockfiles[transaction->pack_lockfiles_nr++] =
+			register_tempfile(final_path.buf);
+
 		odb_source_prepare(transaction->quarantine,
 				   ODB_PREPARE_FLUSH_CACHES);
 	}
 
-	return 0;
+	ret = 0;
+
+out:
+	strbuf_release(&final_path);
+	strbuf_release(&pack_name);
+	strbuf_release(&keep_msg);
+
+	return ret;
 }
 
 static int odb_transaction_files_finalize(struct odb_transaction *base)
-- 
2.56.0.173.gf57c9a7388

