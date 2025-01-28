Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546E91DEFE4
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052900; cv=none; b=ZcK0MAa2lUzGr/MxpA99MCtgZpEeQcQq/H0pPkRHXFJVkzYzSf2KYrrIST/UwA2BWtrNa2HG3t8mMszihqQAPgsRorNkDiNnL+YmoSaqaq6lxeAhXOSB0S/UUh5UgHUiS+Jfp8SKmV8S87pnEDnHuTW5/HEzV9Q0c60gzpXIQeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052900; c=relaxed/simple;
	bh=ZQ2XEXDcUn70nxnghchKgY/1/IPyW0wJW4m9KlBlwVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dV/6BWygXpgxK7Wmg7oAybf+sWxOr0ebClCu29p/WhjL7Q48jCIYO5LN5snaQpxLqDJn3FALTSV+fs1afsJ5MPcpPy4t2lsGlyW+lDpe2e4rk2DAPaKprL+CSDOv5tJW527bMC6zVeqBTl3U/a26p7pq+LVYBiN4i8ONtV38Ufg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V3XhkV8t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ton8C1nZ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V3XhkV8t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ton8C1nZ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 258A3254024A;
	Tue, 28 Jan 2025 03:28:17 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 28 Jan 2025 03:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738052896;
	 x=1738139296; bh=OAfz3VQFjKoHw7bRx0dztIrW4fPn64Mv0AWtbw4sj0g=; b=
	V3XhkV8tMXOV8ZnLYMG8fpyFZ8RHPd450InpvywfBN7oQPgpP1a5l9tY+xMoX0GI
	i+op3TjoNHEGPczSG61IhE9bOanvsRyhxZHkVWSfa7oPiuJHJg6e2PWvrQy2Roqa
	eIA0OrSwkLt4bd4ANaalaB6RN0015QpJk8WTQr1B5P2K8xXa2y3SMC/jVUeocI5U
	vMl7lzxCeQ09wFyqHlFT6y8CMoWP7Boa2O0PgAU0gReY94OvIMwl3ASLNNBX27y0
	yoRWPbP//2iv0EgM4WKYXvEC7ahFjX/L8GlqEYT/QPMsOjDzkP/26L3mnUMLiPvw
	dt6qQ/eDlSIUxN6vNkkw/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738052896; x=
	1738139296; bh=OAfz3VQFjKoHw7bRx0dztIrW4fPn64Mv0AWtbw4sj0g=; b=t
	on8C1nZSghOK+6NeJBU88DZ1+Yf6Ls7m2+WxGZ+Ako9c7VpTljrbx4J1qPcftwua
	VmwYkpx4nM6n5l4ERrGwWkv6HlWVXqV4GdyhX3RKqE6kJhT7dVTZG1SyiWQgff5S
	g9Nf6pFBojbBIdOzuG2+cpO66G/UoVgfCR/DiMdre55qTIr+U2kize+uYvOFAlAw
	HeyxW8V6iwtexpnovpFfLlWkc4KexakQsMtHmLtnPYFC3N4nck90lXXGMquUVr1R
	EdRrUEvVfzM/cHJSDMl1C95oy0ZFreA+K6Y79hKCGURQ7+tco+9ktWUHI42Q41g+
	Fi+YyxCNfaTu8rCjptcoA==
X-ME-Sender: <xms:IJWYZzkpD5vQBJRM165i9MUzmXnB1MMlTVJxHVT34KG8JmZBUa8-KQ>
    <xme:IJWYZ23f_1psXPwt6PAW8ODRKkNonljqsl9STHzTDt_OKRSbN-NHDMuNM7nLECCaV
    0SY0a-P8PNWyYAVRA>
X-ME-Received: <xmr:IJWYZ5pnihcH6XufobC1qO0uzabIvXtY0W2xNN981-ssNpnqVKadoEhQ03PZagaSwJQHXXSjGj-o3kM16dNGYemZehayqz4Gs6PsorblmZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegvthhhohhmshhonhesvg
    gufigrrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:IJWYZ7nk3bFpWNSPdWwaNE2PANMP7mUBgzo7xualHU3O8CzoFIeFOg>
    <xmx:IJWYZx1dyJs-XQMYCNJd-0jjptHVslTQ3tRohG9PKNNm4BW5Nkq1qg>
    <xmx:IJWYZ6tPmtX-YAkfq-8L543OE3T_VduGC4EHX4lqdPD2I-U-pi-sLA>
    <xmx:IJWYZ1UficTImUFrPgaNYxapBecvxN7xYkKRfG2Gltp5kdhR6rrZ5A>
    <xmx:IJWYZ8RjXSftnAphLXr1wBTAp_9Wx_CHpreAQvDaJknxQ_lFZWluuLaz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:28:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 713607e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:28:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:28:03 +0100
Subject: [PATCH v2 02/20] reftable/stack: stop using `write_in_full()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-pks-reftable-drop-git-compat-util-v2-2-c85c20336317@pks.im>
References: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
In-Reply-To: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Similar to the preceding commit, drop our use of `write_in_full()` and
implement a new wrapper `reftable_write_full()` that handles this logic
for us. This is done to reduce our dependency on the Git library.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 9490366795..5f155b344b 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -48,6 +48,25 @@ static int stack_fsync(const struct reftable_write_options *opts, int fd)
 	return fsync(fd);
 }
 
+static ssize_t reftable_write_data(int fd, const void *data, size_t size)
+{
+	size_t total_written = 0;
+	const char *p = data;
+
+	while (total_written < size) {
+		ssize_t bytes_written = write(fd, p, size - total_written);
+		if (bytes_written < 0 && (errno == EAGAIN || errno == EINTR))
+			continue;
+		if (bytes_written < 0)
+			return REFTABLE_IO_ERROR;
+
+		total_written += bytes_written;
+		p += bytes_written;
+	}
+
+	return total_written;
+}
+
 struct fd_writer {
 	const struct reftable_write_options *opts;
 	int fd;
@@ -56,7 +75,7 @@ struct fd_writer {
 static ssize_t fd_writer_write(void *arg, const void *data, size_t sz)
 {
 	struct fd_writer *writer = arg;
-	return write_in_full(writer->fd, data, sz);
+	return reftable_write_data(writer->fd, data, sz);
 }
 
 static int fd_writer_flush(void *arg)
@@ -784,7 +803,8 @@ int reftable_addition_commit(struct reftable_addition *add)
 			goto done;
 	}
 
-	err = write_in_full(add->tables_list_lock.fd, table_list.buf, table_list.len);
+	err = reftable_write_data(add->tables_list_lock.fd,
+				  table_list.buf, table_list.len);
 	reftable_buf_release(&table_list);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
@@ -1468,8 +1488,8 @@ static int stack_compact_range(struct reftable_stack *st,
 			goto done;
 	}
 
-	err = write_in_full(tables_list_lock.fd,
-			    tables_list_buf.buf, tables_list_buf.len);
+	err = reftable_write_data(tables_list_lock.fd,
+				  tables_list_buf.buf, tables_list_buf.len);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
 		unlink(new_table_path.buf);

-- 
2.48.1.362.g079036d154.dirty

