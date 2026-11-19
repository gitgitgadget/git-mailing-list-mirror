Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795047657;
	b=hZzFDfKxcJiMK2D8pTNc/CTkRTL9IlV4+8rtqCC5fTt+kMU/WYM8+7FYsrqTTevO17Ij
	 8NtQocnlQz+BOy/5HKdIoTuhcBCkoLfM+xXLtuqHwpLEcmKQa031x2blSwE6rr2e3rNgY
	 kkY5ca7bXBhhkZXgT8zVaXXpDlH4FDoWjVoyowTLXtXXEjpY7ZGJWDPG/eHCVTEExPNJO
	 Hg4s+BeRVbZCSbQlUer8fxEu1S+RlUM1wGr5RgZrGHvJ+06dlyJEo6J2HdK7qh9qreuue
	 +6E+7kczuXzdUpkuPsiHSEiZ1Fs/fvMJSjGdwYYkfy6W0Su/Yjs33bNrhXKV7fFQMng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795047657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5h8DMOWE8jg38t/HEAj2U4PE+tW8WIbbQX5TYq1itTU=;
	b=dqROxjJWKBSwDw8oT4PJx3aTVOAQVxmVn9/Z+9n+l1wX3hYtUxu0/rF/Fu26fRkEGxd7
	 fR/K+gxoc1C0HB/g3FgNgaSQfL1k11pynR81BlE5Mgj0bVALi0GSdsKW70PAkBfsKvOIT
	 TMDSAZ977uYR1azrTdnmJRPwfjfUH/3guHPJbiCSnB0DyMyLENgt/ICbC42mwJL+Xk6h9
	 b/sHzoBdnT/jFYxXYm2w1s7IZDjiLSPm2kPXnjZOfKjXHj9PA7yxSiD/Md8kcJ5RGcMhT
	 UwjTZ89pwuUziu0UAuzm7sG+ABA1vS3FmEnfNrk8Us/FnJ4r6+HsZ+tJMb5otnx4YeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0fgdJdjQ;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB1D606A333
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 00:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AB1D606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0fgdJdjQ
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6df7f544919so1049878eaf.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 16:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795047655; x=1795652455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5h8DMOWE8jg38t/HEAj2U4PE+tW8WIbbQX5TYq1itTU=;
        b=0fgdJdjQ3JGUXNMKlEIUPHn00IrOLwY62B74Sk5pA5o/3sqfjEjnmVoDyf+Uewfo3d
         yjNCr16ce8EyzqwFnUmBYg8K/KyhnlbTsqd0wLzcUrCtgXYiKEGhzyFvSpLZG3qAkF5K
         og1prK75qKmwtAbDximox1rKd3GjnCJyLetEUwdgFeHGFFqalwkiXI9py0o8L9Hfqvxc
         LyutsqtLv7l+NFmqlKQSmSbZ74FYaVwZ8eZmUBEkVBqDsy2uthopepfPF8ctCJaPk7cu
         Ie/YqM7/o2hz/fezmznPsxPMlBWar+ZXdsAtSB925liWjvkRlBoKvFgAP8tTEMkiYKTW
         fnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795047655; x=1795652455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5h8DMOWE8jg38t/HEAj2U4PE+tW8WIbbQX5TYq1itTU=;
        b=bXzMloi4wXyK9uIjCzqkQKbVLeCiKRXXGRRejgHbduNvKgPFemVSvsYbPoBC3iGp3x
         14RpaESOUe4FeqRTBesG399XYNv8ANEt+w6JSWpi1MPmxbUkoIbVrutytl5NgPJxgRhr
         f2wIE6+3m30kogDko6uyuSvmYrbJrFeTx310jUdiQJyK8vPufnqPTbW/YZtu+6GtOoKX
         lBfgJzSuw+CfezbEc1+yyy9O4LdmWK8tntXIVJ1fBBSJPYdlNkeyVe9LsLXOsfbsnCkz
         VyhrlmtWP4CbfHL7+f2TkiBPelT+wPCpNPyujLlvCQhLiW7qhvVUe7YhkAgNS4fL4C3i
         qcYQ==
X-Gm-Message-State: APuU4Z9eV7EgCodI2Q81oNAD50gcgkIgKySP6x+JhSLp95Krjt961Y9d
	E1fbHF4T45YdY2ox4t+048Lnwnay4VD0OgfQ+tSgv2v1oQGTCxSF5WMDdtABEA==
X-Gm-Gg: AYBFou3Q1cti/5FlfSb0mKem0bEe9eC+B65WPq9BhRF0BrJw+x/ZWuFCWb51k4ktEUJ
	GQwikR6eU2JQxi5JwBfrTf9CXtJMDseZapSinetDleFp+wdRXQMGRm/trGrt5+G/lbphj4RZhYC
	0EmwaWt3AU5lgHLqeTc5WSlTICZMlrTjDU5UH9EHoW+rFm79fN6o/Wy7AsqciEghFD6FFzPT6Db
	eYdn6HGLlkyoT9qMBIKnpgmlyvHAZWkpK3wWxiGf+YuiCB9UiQFHztQcT7PhOcZm8z62rQL8Os8
	XMbshDwb5jLPtrLCdnswYV1ED31J8iSQuiAy4f+2cHFNdavRBHSDmAdi4ECWoXB5IDHUa1PEdFy
	A3CWWD5stqjUWaSUaE7z/O6ox0AqyRCaCB+HyyWLpXxEZf3tDYrfIoQaBpiRyArY3EIY5AHYY5J
	unQLDg9QFuszPWCVFQxuKXbHkHRQ2dRvjDjdPDQHV/nL1LzVyJqzilICJHaUHlfJlMgqzANmXNa
	NlVOSf2dHN4zeaovetWXWp1l4kYqWp3TOKnlHKmsAqBdy5VACzQQwOvL09YlL+5uG+/4DST46YP
	Bexx+WRdOrwNFrRlubJuzlDa82Rs/h3wt2r8kpAiqj2r1zDWfEbT7vrlhEm/KmyU9Gd6
X-Received: by 2002:a05:6820:350c:10b0:713:da3b:8b37 with SMTP id 006d021491bc7-71b185597fcmr2533189eaf.60.1795047655531;
        Wed, 18 Nov 2026 16:20:55 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f01d492dsm3293400a34.6.2026.11.18.16.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 16:20:54 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 2/6] object-file: only flush batched fsync writes when enabled
Date: Wed, 18 Nov 2026 18:20:39 -0600
Message-ID: <20261119002043.2108654-3-jltobler@gmail.com>
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

When committing an ODB transaction for the "files" backend, a full
hardware flush is issued against a temporary file before the staged
objects are migrated into the main object database. This flush acts as a
barrier for objects that have been written with batched fsync, where
`odb_transaction_files_fsync()` only issues a writeout request for each
object instead of fully syncing it.

The flush is issued whenever the transaction has a temporary object
directory though, regardless of whether batched fsync is actually
enabled. For transactions configured for git-receive-pack(1), the
temporary object directory is always created, so the flush is also
performed when objects are synced individually or not synced at all. In
those cases there are no pending writeout requests and the flush is
unnecessary. Only issue the flush when batched fsync is enabled
accordingly.

Note that batched fsync only applies to loose objects. Other files
written as part of the transaction, such as packfiles, are fully synced
when written or not synced at all, and thus do not rely on this flush.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/object-file.c b/object-file.c
index 201d9d6490..1926f61f53 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1330,6 +1330,28 @@ static int write_pack_lockfiles(struct odb_transaction_files *transaction)
 	return ret;
 }
 
+/*
+ * Issue a full hardware flush against a temporary file to ensure that all
+ * objects are durable before any renames occur. The code in
+ * odb_transaction_files_fsync has already issued a writeout request, but it has
+ * not flushed any writeback cache in the storage hardware or any filesystem
+ * logs. This fsync call acts as a barrier to ensure that the data in each new
+ * object file is durable before the final name is visible.
+ */
+static void flush_batched_fsync(struct repository *repo)
+{
+	struct strbuf temp_path = STRBUF_INIT;
+	struct tempfile *temp;
+
+	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX",
+		    repo_get_object_directory(repo));
+	temp = xmks_tempfile(temp_path.buf);
+	fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
+
+	strbuf_release(&temp_path);
+	delete_tempfile(&temp);
+}
+
 static int odb_transaction_files_commit(struct odb_transaction *base)
 {
 	struct odb_transaction_files *transaction =
@@ -1339,24 +1361,8 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
 	flush_packfile_transaction(transaction);
 
 	if (transaction->objdir) {
-		struct strbuf temp_path = STRBUF_INIT;
-		struct tempfile *temp;
-
-		/*
-		 * Issue a full hardware flush against a temporary file to ensure
-		 * that all objects are durable before any renames occur. The code in
-		 * odb_transaction_files_fsync has already issued a writeout
-		 * request, but it has not flushed any writeback cache in the storage
-		 * hardware or any filesystem logs. This fsync call acts as a barrier
-		 * to ensure that the data in each new object file is durable before
-		 * the final name is visible.
-		 */
-		strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX",
-			    repo_get_object_directory(transaction->base.source->odb->repo));
-		temp = xmks_tempfile(temp_path.buf);
-		fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
-		delete_tempfile(&temp);
-		strbuf_release(&temp_path);
+		if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
+			flush_batched_fsync(transaction->base.source->odb->repo);
 
 		if (write_pack_lockfiles(transaction))
 			return error(_("unable to lock packfiles"));
-- 
2.56.0.173.gf57c9a7388

