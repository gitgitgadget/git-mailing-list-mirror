Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270179;
	b=X9Azbp5FWl+Co7TT1W8QQzLt3qTRoXSmeMK8zt2OYVNQyj3xuVoCRNxa+UuLaX6pXerS
	 J4y8BfAsc7BG93OSROQzFWaNu19jhPULR38n7l5zszvs080O0I7A3BDM37v5hMf8hmxdR
	 xgG+Enmmx8000Y6OG0tr8cyp6coQGiycEhfXmrOhbhzdm62SoGdYRBDifNdz6BYURuYlT
	 /ltSeB+IsHR+p49++AB5eVRqcnZ6H7rQ6B7P/L4IyMCBXgtMgwxuMRoi61oTBLb7I4Xlw
	 h3Cal9fSwm2lJvlklIt4/5GSTuUDHMg0f9FmEDWS0GpFReNEunv2JMLXy0X4sQ71Klg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270179;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5BdrC5msk6Q0fxX0dHcQVyW78YYKjp9JzhVvKBayZlA=;
	b=NdMv1AAcEmI+CkP7zZ9L8ZLYS+AksnoLttmaRXAHkw9pwWD3Kcxva+5JsBOPyanJe1JE
	 TbjoZI1yC66UZ79do9peVHGhiUZBe26FdWG1uOVsPRG8OwMPj5wTtbwdDstt8iG7jyQyB
	 NrhKU6571zjBRtFIxWl9qpkPoXokT8vDVAjfOdiCm2OmzHE/aO5clvcsYQ8+cOwO9Gwrz
	 EJOfNmSB+NaRtcD3jgpkAc5sio6VLgSykLWLmeHGqRCcJJW1wNRaxBKZgY25vL1C1iBCv
	 xY94Rba+sNcaCEIcy4tBEAr9lsNI8Wb+pfnHIdHLbkATgDho0w3xN1/uvX1zOG4NvOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="YOe/GuCI";
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A003B60A2603
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 00:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A003B60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YOe/GuCI
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-833e671ee9fso1452896a34.0
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 16:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794270177; x=1794874977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5BdrC5msk6Q0fxX0dHcQVyW78YYKjp9JzhVvKBayZlA=;
        b=YOe/GuCIOPqyAV0jSV4Q65gW84xR5z/mwQnfLmN098ArYGJoV98vL/LTQ6/N5Lu1KX
         Py+8W1QxKrfQpe1/j/g6gZyYleFHOxoIH3Jd4f19kWL1+igKgq9nL7dQSEMQPDYsCPvl
         NK0i64sIEqb082bzf5rg9aJxDVr3kaeDuzXo+1HlU7rab8LlA1554XrtTpL6D7IWr/VS
         rPFXqfcvuPrkHCbFNXc3r+o03UhZ4svEo0qkO3sRbJ0zO8085161PyVr/nI5FAs5WL/8
         U8xK9vHCCkWbEZRi2PWoD5hVEOHUq3e0RlN1qTY0wfrqznWIkr05V8YjUsrXh0oMBbCn
         Zjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270177; x=1794874977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5BdrC5msk6Q0fxX0dHcQVyW78YYKjp9JzhVvKBayZlA=;
        b=Y5VqiGsUWWHKmW/cZJApgiNgkNO2BNVe/fTvfRCkNIlQ7VlgGLjAn0Gfiomt8dNXZ0
         WCxQp3U7ABeeKaWOtiVnFnoi8GsvH86vfJqBXlD2GnvyzGL/Mwb9U2VKuXqya6Ru3H6V
         4jHvcU/90RCsQnG4jQ7BUOCwi06OkkYAiW1unV7X02iNf72EuegcCLORSvVhkyM3zdQs
         /laJ9CjCXraxCNJYQZ5M5HDLk04HPJVyvz4DuL1HH9ZMS/3u696BLnmy4AN5fTwOS3G0
         v3NrYS9JXvsC0HO0kvhCnGcG5gvfx1x+9aLCPvNly6Ck8oy8GoUL/E7PT3mm/1PQ69QQ
         TS/A==
X-Gm-Message-State: APuU4Z+HttmbrRGP4q8HKU7VwRq1LeK+M9yMcisY6TGkmgWkRv7humFQ
	8JEnE03YIss20zH+zrcpKn0MYMTmiv0uOWWZ0bKCm5H4Z4PZoj4oKxUfUZWBXA==
X-Gm-Gg: AYBFou3Sm0s+EUQLXtnN4rj88gpvU23vO6koUOliVTu4ZOQ3bca/3ij8IW3YMEBIoJv
	o3LXs8ebgBsCSeL9N2QEHjfoRxdJOe7xGYZ3RHZtnW2THTHuBiNZKh9MhsPPbkgThJU/pB4titg
	vVWd2zcX6UIoaSljKE64ktPr6fCLcnIxEje5wCrjdjJYw08N2NxP6ijHZFpMlkI8OHQazo3byPT
	SNUxQTwNmnP8+LmijzeBxcd1qI41yYhHrxhkAE4qmNyxa2GzyKsBFK7H15upe6K8GEBGY3R0VJn
	f7Rt51TBlFlBTFbNcqKN4jQI92aDUVrQ7xO52IbBijWlMY4/DSv6duL5tqDN6GzscWgIXYkasjs
	d5lbn3qswJ4EMv79QR9j7ldhNz2+fU0suit2TalkvPQSmJHSktwXUnCIbNwPmKNQCfj7BRucVoo
	cqARzShnRPNgKpzxBLK303YvSCHUElbR37HrQv1FnoZtc3UrvLfrE3t4jn7NJmc13fus/xVVH82
	JT8PI493NtB5Fpg/t+n0tXtdLGmUZbE0ardI3CMgmWNGfEzeaD6XIhsdiw2gpwEK47tIAO99+AH
	4KAWpWpEAd1eb3j1PdJskvXcvf1/6orVH9suiWrl6HaCFEq4NMWCY6GeC0BbONzJ/kPK9Db81CJ
	ObChcdW8ntXbnMA==
X-Received: by 2002:a05:6830:6810:b0:855:4d49:10a3 with SMTP id 46e09a7af769-860dc7cddedmr698006a34.22.1794270177458;
        Mon, 09 Nov 2026 16:22:57 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcbc82b5sm680518a34.17.2026.11.09.16.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:22:56 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 2/4] object-file: only flush batched fsync writes when enabled
Date: Mon,  9 Nov 2026 18:22:49 -0600
Message-ID: <20261110002251.2007617-3-jltobler@gmail.com>
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

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/object-file.c b/object-file.c
index 201d9d6490..da189111bd 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1330,6 +1330,29 @@ static int write_pack_lockfiles(struct odb_transaction_files *transaction)
 	return ret;
 }
 
+static void flush_batched_fsync(struct repository *repo)
+{
+	struct strbuf temp_path = STRBUF_INIT;
+	struct tempfile *temp;
+
+	/*
+	 * Issue a full hardware flush against a temporary file to ensure
+	 * that all objects are durable before any renames occur. The code in
+	 * odb_transaction_files_fsync has already issued a writeout
+	 * request, but it has not flushed any writeback cache in the storage
+	 * hardware or any filesystem logs. This fsync call acts as a barrier
+	 * to ensure that the data in each new object file is durable before
+	 * the final name is visible.
+	 */
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
@@ -1339,24 +1362,8 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
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

