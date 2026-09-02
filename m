Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C681C8604
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 00:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788308081; cv=none; b=We8j2jcl/vRw50PZBekrNkeoJ6H8O4dxHmYj4jpFIQ5YBp7oRR8GXgA3xOS2vf8HHGP+MNO2T0bmnLC/ao1km2AXHsvdp0zfZiYlV9XlodR7WorMkCYWnI+XL2Tqfcc8dn72G0bQm+nIuRuGsFPrcCNm3hosFs/GSixpk3D6dQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788308081; c=relaxed/simple;
	bh=KlgKCVNnoC5iN5siUmGt8JKEATDooWM+hXUj51s5UV4=;
	h=MIME-Version:From:To:Cc:Message-Id:Date:Subject:Content-Type; b=Ra296++OH0P/8EZgH9FYt6S26Nko7ximUZT71hCQ65F0trRzd5g5jGzyUpVm12LwKUFklhNjJXeUA7i8DyD0jvhf9geC0MWcf5TFBm5vo21a8fUQ8umS0oaAPWDVipS68aT8sZFv+ghmdHJtX/MHRZLyKE5gu+Zx6Aq9RSrn9ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wolfgangfaust.com; spf=pass smtp.mailfrom=wolfgangfaust.com; dkim=pass (2048-bit key) header.d=wolfgangfaust.com header.i=@wolfgangfaust.com header.b=SieBBdAA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iDFOdP/P; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wolfgangfaust.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfgangfaust.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wolfgangfaust.com header.i=@wolfgangfaust.com header.b="SieBBdAA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iDFOdP/P"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9A8A7EC0252;
	Tue,  1 Sep 2026 20:14:37 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-01.internal (MEProxy); Tue, 01 Sep 2026 20:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	wolfgangfaust.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1788308077; x=1788394477; bh=BLJrMDznMZh1s3Hp1xi7Kz2KdCH3D57j
	Z4PFqctvv3g=; b=SieBBdAA6ULyGJG8ZL8sUVKZ5BSfeCgH/4g92CSVyAJqZhkI
	2rLbnCVaVoRN3zT9jZh14Ps19Lz5LFYvCyHPM3QcmZphTsQKGl4w4exvO76N9G0d
	d+jS1JOIP0bGZEZbfM268HgOflIgTC85cdXkG3Z5/XroZJ54SYaAUXV/SxZyJKx+
	6XoyKA0r1RzpYUNi9fm5+vys1M8rTSGqo6+hswtsYCfNHdSaHGs5Q6RBEqMYrGm3
	OB7JEQzxEth/kTh5aCQ4Gqg2gfLHCFFtdzSRTCFC08FFMBSmAgpNoeJa6jOWnKoZ
	w4uS12KPLFJJZO2HJPRTHRXfI5eFyGYYNRZCMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1788308077; x=1788394477; bh=BLJrMDznMZh1s3Hp1xi7Kz2KdCH3
	D57jZ4PFqctvv3g=; b=iDFOdP/PYDLKxAv5wAZlS9Xg3BKOsyWSO4jmB5CLm9Gg
	hIlUqmdf6s19o+huqkgX3Cg8OIvIv8ry3x8uoU0YaZZ1Qf0vp8sqlOklnnignUCE
	fbmUPfESyzeQ712j0j+ckgoJRTi3ht+ovcZ/wBmOy3TQ7SdbgCV+VU9PEre/UNdW
	n/xnW+RoK1bG8NvDFu3LzsoMDSMZnKbmjuvGD0Pg/5t3HbovOVMWkHr7CSNmXHWK
	yi+ls7Qr2oMG7a9oo2KFfW8aZEyMjw0HdrgyPb6zyO6rqM0Xq0ojqIeAwkdRo9gS
	Qw4jP9E5ViWlv3AfjGaKaEvm0vHlWO3Pewpf7jPiSg==
X-ME-Sender: <xms:bWqXanW66JItfzWsihhzr0KRSWex8ADK2nH44bwrKuTrNeKxbgTNPg>
    <xme:bWqXaqZVB9rHNYc7cmRnw259b0bQGU2myYCLY4H_-PhEzFPDuvpJ0QPIrPl2tdjw3
    0IvoV6NnYR8454IxJisToeRM0bU0p_BAfKX2_RbWuLjKTHENsY346g>
X-ME-Proxy-Cause: dmFkZTGYbrwcR8RfOxMc/m+EUPf36VCeAsdFGzp4mFGEijtdOyYz9TYPt5p0zo1egMHBpb
    s7tkAop0N5jvqiN5GetkyGvElluWxDQ5VFhiULZJwPyqTkV1ySQ81rLWdsPbKBg44A/Sc4
    WvZQskKV0+Uj/OQtLIS9XMsUrVXBUyiV05cCmtA8wrLO2aH+kvVo+0igbUtsrAzoK8XiUR
    Es5Za9QEouwemWEJHeOyoLh3Rr5ggre+v0TH699BYHEJoZd5HhVRYDBWo/5hhNInTHfr+Q
    sEcwPDYvCr3Dp4MPVkwKIt4IFAoPHOza+MCkeAVyxzGBIfGoNNV9sag6EnCbw6DJUdZWUG
    KLHTQX5+Y7UR3IaPUFjsdCV0/LMke3RlDurRSwcj47D+RleHqs93DpLxRyB3CAdQEb/tZq
    MGeXWC8u54ClG5P/gbL4Xgfhx0/f2kLuofCCHYx4jduRanemYbqBd2Gjy8ohwghAxbN2ie
    BIf1Z4LG/UsjVisFOmnhtext3TUFwE2zLQ4CfGi+MpWaz5zp5MFmPxs+JDdFYI0I9kZiV0
    3NywKZKlvVJr1VtyCcpthqjwBAIRhir8wiM1Oz4OfDwEyUzQ2HyCdBtmj1WfErUa85/WFu
    JCzoNo+SVGsgOTqSwiiGvZ0xc5N+KtVzcb9fWF084GqZSpeWxL5IoQMZYg0A
X-ME-Proxy: <xmx:bWqXauCo2nYi0Sa_D5Iqv3wmc14u5CeijzZdUcLKcVMVE_Alf7QrWA>
    <xmx:bWqXamdwLSXTBCIjtfhgtgGZ-DCMF7NvtGH4ALq5Qea9wk685dzhtQ>
    <xmx:bWqXapLjD4KDHtQe4wYhDriM7bzpHs-zCJDxT9_VE_aNvdquoRecGQ>
    <xmx:bWqXapf8aKtROekAaKHkpGUxZqEwi2fgyohrDcSrTlB_3SPeS2ukOg>
    <xmx:bWqXahCywA6POJBqrBdiozQygkzB9D6YbByzAZHsG7qndKuWBID0uMY2>
Feedback-ID: ifd814412:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6539F18C0067; Tue,  1 Sep 2026 20:14:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Wolfgang Faust" <contrib-git@wolfgangfaust.com>
To: git@vger.kernel.org
Cc: "Aditya Garg" <gargaditya08@live.com>
Message-Id: <761c3f1b-e280-48b1-a2ad-770b68be3434@slotpi01m90>
Date: Tue, 01 Sep 2026 17:13:21 -0700
Subject: [PATCH] imap-send: add --draft to set IMAP \Draft flag
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The documented purpose of imap-send is to upload draft emails for sending
later, but it did not have any way to mark the messages as \Draft, so some
email clients presented the result as an un-editable, un-sendable email
even if it happened to be in a "Drafts" folder.

Signed-off-by: Wolfgang Faust <contrib-git@wolfgangfaust.com>
---
 Documentation/git-imap-send.adoc |  9 ++++++++-
 git-curl-compat.h                |  8 ++++++++
 imap-send.c                      | 15 +++++++++++++--
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
index 1814d94491..cf415df45a 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -9,7 +9,7 @@ git-imap-send - Send a collection of patches from stdin to an IMAP folder
 SYNOPSIS
 --------
 [synopsis]
-git imap-send [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>]
+git imap-send [-v] [-q] [--[no-]curl] [--[no-]draft] [(--folder|-f) <folder>]
 git imap-send --list
 
 
@@ -55,6 +55,13 @@ OPTIONS
 	using libcurl.  Ignored if Git was built with the NO_OPENSSL option
 	set.
 
+`--draft`::
+`--no-draft`::
+	Mark uploaded messages with the IMAP `\Draft` flag. The default is `--no-draft`.
++
+With libcurl, `--draft` requires version 8.13.0 or later.
+Older libcurl still uploads the message but cannot set the flag.
+
 `--list`::
 	Run the IMAP LIST command to output a list of all the folders present.
 
diff --git a/git-curl-compat.h b/git-curl-compat.h
index dccdd4d6e5..032aaf7126 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -67,4 +67,12 @@
 #define GIT_CURL_HAVE_CURLOPT_TCP_KEEPCNT
 #endif
 
+/**
+ * CURLOPT_UPLOAD_FLAGS and CURLULFLAG_* were added in 8.13.0,
+ * released in April 2025.
+ */
+#if LIBCURL_VERSION_NUM >= 0x080D00
+#define GIT_CURL_HAVE_CURLOPT_UPLOAD_FLAGS
+#endif
+
 #endif
diff --git a/imap-send.c b/imap-send.c
index 0d16d02029..bf1d2cf74d 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -35,6 +35,7 @@
 #include "setup.h"
 #include "strbuf.h"
 #ifdef USE_CURL_FOR_IMAP_SEND
+#include "git-curl-compat.h"
 #include "http.h"
 #endif
 
@@ -49,10 +50,11 @@
 static int verbosity;
 static int list_folders;
 static int use_curl = USE_CURL_DEFAULT;
+static int opt_draft;
 static char *opt_folder;
 
 static char const * const imap_send_usage[] = {
-	N_("git imap-send [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>] < <mbox>"),
+	N_("git imap-send [-v] [-q] [--[no-]curl] [--[no-]draft] [(--folder|-f) <folder>] < <mbox>"),
 	"git imap-send --list",
 	NULL
 };
@@ -60,6 +62,7 @@ static char const * const imap_send_usage[] = {
 static struct option imap_send_options[] = {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP server"),
+	OPT_BOOL(0, "draft", &opt_draft, "mark uploaded messages with the IMAP \\Draft flag"),
 	OPT_STRING('f', "folder", &opt_folder, "folder", "specify the IMAP folder"),
 	OPT_BOOL(0, "list", &list_folders, "list all folders on the IMAP server"),
 	OPT_END()
@@ -1416,7 +1419,8 @@ static int imap_store_msg(struct imap_store *ctx, struct strbuf *msg)
 
 	box = ctx->name;
 	prefix = !strcmp(box, "INBOX") ? "" : ctx->prefix;
-	ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\" ", prefix, box);
+	ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\" %s", prefix, box,
+			  opt_draft ? "(\\Draft) " : "");
 	imap->caps = imap->rcaps;
 	if (ret != DRV_OK)
 		return ret;
@@ -1718,6 +1722,13 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
 
+	if (opt_draft) {
+#ifdef GIT_CURL_HAVE_CURLOPT_UPLOAD_FLAGS
+		curl_easy_setopt(curl, CURLOPT_UPLOAD_FLAGS, CURLULFLAG_DRAFT);
+#else
+		warning("--draft requires libcurl 8.13.0 or later");
+#endif
+	}
 	fprintf(stderr, "Sending %d message%s to %s folder...\n",
 		total, (total != 1) ? "s" : "", server->folder);
 	while (1) {
-- 
2.52.0

