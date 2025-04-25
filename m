Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0944323497B
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564944; cv=none; b=sR0ArAnh6S/X184tbr0Z3UdsyLobk1YNcdsGAXz1yPLKC8Sg8DF85zCz7zkB1s2xaSa4Ygvz7Kb6b/aVtTVKN1bJLk+VwMsRMuJsKQ6ptF4F9OGHjw9EnaZyK4ITj4KfFB02j11sQxtovM7vZTkSrB89hzPx7oxVgxOr0FUmIYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564944; c=relaxed/simple;
	bh=AZgBgAfOdOK+kdP1dnuaFTreJHf0PAKLvuvNYQcArD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qau2s5pW+agq23l9CJmYuH8uZI9iTLdvbJOOvr5KSk/3cnkPnL0DhvNSh0j0v0a2PJE76SFyS3sON2fxTutmNf0QrF0514eFlsWzgOMN2OgkD7Ys2NOa1iz+DreIX/HVbHlAr6EVx9v64TS6QmVPIYOoH7vTewlK5Vl1vtS8Cpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=zdV8uUWk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oMb9nu5P; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="zdV8uUWk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oMb9nu5P"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 17D8F11401F4;
	Fri, 25 Apr 2025 03:09:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 25 Apr 2025 03:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745564941;
	 x=1745651341; bh=+EjiMxFVoheLXOTRDBAJ0oKNzoA5Mu3DETJiPbyRo8w=; b=
	zdV8uUWklCdWMQ5jjkqPCK+exwBOsGz0DDgDNgjacKdWXjx2VRO/6tcRnQrFTTcG
	+1nbBI7L8LDDW5AyrV53/ZmBMgA4lIcM7HGI42PV2/dV339CN7cFNVu+49RcZ93W
	RIYLIE1w5hd6MUu3V3vtGpQcoe5S0UvH0gbS8AJZ+SCEhWFpLxRgrgcZjsHHe/aB
	vjFSWJs4Gv8pGSMIbE8j5nPzrD/vjjt3SfW70fFf9byigeuM/5r0Fw3ICi4WGQsP
	yNJ6vkKlrApLo8JRjTfNmfhzS7rIBP2zO7qyGe2jk/zahaePRL2xBYht/LGSaJ30
	wN3xa/wvR5ucyJ7dmFgvpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745564941; x=
	1745651341; bh=+EjiMxFVoheLXOTRDBAJ0oKNzoA5Mu3DETJiPbyRo8w=; b=o
	Mb9nu5PC5IE1mKyHZT1QriDipAECVzw1enBR3jHYSRcigERZXWwknCdv0dit/BTp
	EpWkjRL47ehuDlIOBgw/NjGBi9vS9kCG7m4FVgmzXTLenkKkzpAWjTqVlDFR7PSL
	BUM7AU9zqo46n6ZyL92w2vO1vuj5cTzw9qTss7NNrxhcu6K1tm/sxnqXGZDCEjKI
	JotvTrjDDiaKBIFx3w/EDCZ7/W8HAJtcbJPrX2Ys4r6d8t6cN72i9IR7Sf87JUgK
	2wlYRll5iRmv575TRrwn1LnMcOt849D79T3FeYGqwlN2Fl9S7bhTsIRKZvB6bY/2
	mB78i5675+wmAKU2MNgSQ==
X-ME-Sender: <xms:DDULaNSiuOv1kvW5_BsyZEGOO9mjN7T3YHYeO6nuzO3QvMBN5KKVoA>
    <xme:DDULaGzoTXsYN_3Xu1z3m2H_2Ev91k7RWGsxFcAwryQVrdZwvheGZcGVXZ_EzMmnx
    zBiQc75MPIKr9c4Hw>
X-ME-Received: <xmr:DDULaC1W7WGH9U7Rucnu0TO1oBmVC-NQL-9eVNMBdWhJysWg5vYq1uQ9Ym9uPjO_xKOEDpB5NkL_MuLUA4ZfdfR9VWiDCi8HIHZ3cmxq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:DDULaFCL2anCslR45mLOj5xVcG9qbxxIr7qX-Art5ObOtK2wbXakiw>
    <xmx:DDULaGj1zc5FYH9c_40I9W2xLqfirqL_obulEU5L1zrIiByl_xzOHQ>
    <xmx:DDULaJqJ8wQivlA-zlceVDR0x4MAELSS1FWT70dg8N0Q8ox7WeIcDA>
    <xmx:DDULaBiE58F3lZITj0OSYf01ELx83DahDwjKa4H7ckvuE97I4NnIaw>
    <xmx:DTULaN-F_V79bPmXaR04VlvVHUUMCatoGEa0X1y84GYIWsYSNDrgI1VC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 03:09:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1d8e884d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 07:08:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 09:08:54 +0200
Subject: [PATCH v2 03/13] object-store: move and rename `odb_pack_keep()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-object-store-cleanups-v2-3-63f1695b7700@pks.im>
References: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
In-Reply-To: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

The function `odb_pack_keep()` creates a file at the passed-in path. If
this fails, then the function re-tries by first creating any potentially
missing leading directories and then trying to create the file once
again. As such, this function doesn't host any kind of logic that is
specific to the object store, but is rather a generic helper function.

Rename the function to `safe_create_file_with_leading_directories()` and
move it into "path.c". While at it, refactor it so that it loses its
dependency on `the_repository`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c |  3 ++-
 builtin/index-pack.c  |  2 +-
 object-store.c        | 13 -------------
 object-store.h        |  7 -------
 path.c                | 14 ++++++++++++++
 path.h                |  7 +++++++
 6 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index c1e198f4e34..b2839c5f439 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -811,7 +811,8 @@ static char *keep_pack(const char *curr_index_name)
 	int keep_fd;
 
 	odb_pack_name(pack_data->repo, &name, pack_data->hash, "keep");
-	keep_fd = odb_pack_keep(name.buf);
+	keep_fd = safe_create_file_with_leading_directories(pack_data->repo,
+							    name.buf);
 	if (keep_fd < 0)
 		die_errno("cannot create keep file");
 	write_or_die(keep_fd, keep_msg, strlen(keep_msg));
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 60a8ee05dbc..f49431d626b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1565,7 +1565,7 @@ static void write_special_file(const char *suffix, const char *msg,
 	else
 		filename = odb_pack_name(the_repository, &name_buf, hash, suffix);
 
-	fd = odb_pack_keep(filename);
+	fd = safe_create_file_with_leading_directories(the_repository, filename);
 	if (fd < 0) {
 		if (errno != EEXIST)
 			die_errno(_("cannot write %s file '%s'"),
diff --git a/object-store.c b/object-store.c
index e5cfb8c0079..0cbad5a19a0 100644
--- a/object-store.c
+++ b/object-store.c
@@ -83,19 +83,6 @@ int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
 	return xmkstemp_mode(temp_filename->buf, mode);
 }
 
-int odb_pack_keep(const char *name)
-{
-	int fd;
-
-	fd = open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
-	if (0 <= fd)
-		return fd;
-
-	/* slow path */
-	safe_create_leading_directories_const(the_repository, name);
-	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
-}
-
 /*
  * Return non-zero iff the path is usable as an alternate object database.
  */
diff --git a/object-store.h b/object-store.h
index 5668de62d01..aa8fc63043e 100644
--- a/object-store.h
+++ b/object-store.h
@@ -189,13 +189,6 @@ void raw_object_store_clear(struct raw_object_store *o);
  */
 int odb_mkstemp(struct strbuf *temp_filename, const char *pattern);
 
-/*
- * Create a pack .keep file named "name" (which should generally be the output
- * of odb_pack_name). Returns a file descriptor opened for writing, or -1 on
- * error.
- */
-int odb_pack_keep(const char *name);
-
 void *map_loose_object(struct repository *r, const struct object_id *oid,
 		       unsigned long *size);
 
diff --git a/path.c b/path.c
index 4505bb78e8b..3b598b2847f 100644
--- a/path.c
+++ b/path.c
@@ -1011,6 +1011,20 @@ enum scld_error safe_create_leading_directories_const(struct repository *repo,
 	return result;
 }
 
+int safe_create_file_with_leading_directories(struct repository *repo,
+					      const char *path)
+{
+	int fd;
+
+	fd = open(path, O_RDWR|O_CREAT|O_EXCL, 0600);
+	if (0 <= fd)
+		return fd;
+
+	/* slow path */
+	safe_create_leading_directories_const(repo, path);
+	return open(path, O_RDWR|O_CREAT|O_EXCL, 0600);
+}
+
 static int have_same_root(const char *path1, const char *path2)
 {
 	int is_abs1, is_abs2;
diff --git a/path.h b/path.h
index fd1a194b060..e67348f2539 100644
--- a/path.h
+++ b/path.h
@@ -266,6 +266,13 @@ enum scld_error safe_create_leading_directories_const(struct repository *repo,
 						      const char *path);
 enum scld_error safe_create_leading_directories_no_share(char *path);
 
+/*
+ * Create a file, potentially creating its leading directories in case they
+ * don't exist. Returns the return value of the open(3p) call.
+ */
+int safe_create_file_with_leading_directories(struct repository *repo,
+					      const char *path);
+
 # ifdef USE_THE_REPOSITORY_VARIABLE
 #  include "strbuf.h"
 #  include "repository.h"

-- 
2.49.0.901.g37484f566f.dirty

