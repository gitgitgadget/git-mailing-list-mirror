Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FC12C08AB
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 06:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771224368; cv=none; b=eTnuqZM/MKOFIbFJkcZixnuQuYugQlKtj/D7kMk8RIw1QTnBHeZK79bZcxWwIGjbBLe/ekj7Xc5IuSZwjEKROz7Zd5KOdQF/LLG/jN1EBYVCliE4Pk6CHlQoyph5j2PEow5ZiLYYMTAaVqT+JMixAZi+anqCnpQRBF1Fyf7YZ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771224368; c=relaxed/simple;
	bh=5XwLmW40GX9zGxDbLv098P6YcBGvbyeqtGn6z/ylDvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JTcEwU7mKR7qAOR2n8KwodHE95048Z5z7+a2XMrHUebfzWpDPLjZ9K9K8QMl4xo+5YGvc3QMj/G1aS3rJJhFEJLh14qfnO45/Z1OZyM2koJrOHN3s9I/KL5Au+8ZyP3vYycJ0aE6XtIIX3h+S8wG0ZDtgjJhj6/D2W0NsfKSxWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l3ur2/hU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lI7Cnoqi; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l3ur2/hU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lI7Cnoqi"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 44A501D0021B;
	Mon, 16 Feb 2026 01:46:07 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 16 Feb 2026 01:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771224367;
	 x=1771310767; bh=g7vI9gZRnPFRcm+y8RHkt+lGlGSYJGZWhioPG1Cj8x4=; b=
	l3ur2/hUlu4yosw5ii3cE/k8RtlA7U5dYeq+cEqi/qwHQhQGiaIeaMzMuUfH2kcW
	vbhY+GmjhNesYExFWv4jEyHoITJ6JqTb6RYN7R2FuDvTwamc4inCjNaBw5CQlnOH
	4+qU8YjwkADGUX7Y4Tf2RdWZxNOWRPFS9/ZB4o8vSLiIMg+ULL6jPYq+JWyhgSwt
	FEiBrncPervFdd8iE5U0vNMe94LLdk6EcJh5yp9w94TWE3VEDeyZYzdn7K1Vl/xr
	F+G59V7YnuO9xXIyutT2lG4Qcm5RbmkzjYSw4TsgRQbx+WqBktOKqWkHK6Jz+5MA
	LQ6h1ocYJZwu/rAImMESug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771224367; x=
	1771310767; bh=g7vI9gZRnPFRcm+y8RHkt+lGlGSYJGZWhioPG1Cj8x4=; b=l
	I7CnoqibmX8x+UhIRdrQnhh0Ux3F3pkUTkcr+KRviWxMJEqQNpXV6Mo6IT+5f+c6
	XpDvbk2gl7P1brhA7FJFXwpSKhJY8qeqDHaocb/YiSUedZoBpsuXeJKzegQhjjCy
	G85xQ/a5+vYhAFjCpiy7fcAkohcjjHKRxNxfeo7p4ZHCYjlCqllhZFiws/Wh6wLR
	qwnCgEOa0ie6DBWyGmVv+06wNpb/OybgGvYl1HqRwQjwNIvTA3HSyI+LIiRhf5Hi
	wu0lPb1qyjzKWtPp0tpL81cyNdOBQpVxppNmXdmQ65fBq683MscbYfIyfpIURPqP
	beD+0W7dltWmapTtX9GwA==
X-ME-Sender: <xms:L72SaUh589SYWlIykorRJkVG1nG43-XF8PzVD1sltXhe3IS_8aLXgQ>
    <xme:L72SaUAUMAy9YYZ6uX7zM6Leg7eYiW1LH-9DIlDFwSr-4c98GR5H9pCVLuFVpIdnh
    6BCC3imeUEIK4fR699HPVboNg9Np3mL7fTgY90sB_VBUX9_1LZt4L4>
X-ME-Received: <xmr:L72SaREtlPvuPWjsWEMuqV6oUpdNdXsRJSMvo6INtkel9u-fY-5yBEQiU-8oAQKsuNl_gvgUkR0GGMRK8_txTcQPK5y-pC9D10LcxtNGrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudeiudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:L72SaUKEYGFR-DA8TjHOq2p_4-q7l7SZ2fp_k4_7ch-UaDUqfCGaHQ>
    <xmx:L72SadnRBAOF8SbQPw62oBWo6l4RbhNtDpls7RIc7qow505MZncVGg>
    <xmx:L72SaUSdOI4KXgGoZiemr4MFJk_41ZZq5yXrOwS5mL3GNRsBc0afZg>
    <xmx:L72SaXIhAeaqKu9Y-_-MxBDUooegCLiy6qThLNCuGJb0X-aLwqj-kw>
    <xmx:L72SaYnymi4UGyyJ2-DWPxiJHo3cEKW64SZwtsLIbbbVZRKI6ko9afUb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Feb 2026 01:46:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a5617f12 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Feb 2026 06:46:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Feb 2026 07:45:48 +0100
Subject: [PATCH v3 5/5] Documentation/git-history: document default for
 "--update-refs="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-b4-pks-history-dry-run-v3-5-c4db58a651fc@pks.im>
References: <20260216-b4-pks-history-dry-run-v3-0-c4db58a651fc@pks.im>
In-Reply-To: <20260216-b4-pks-history-dry-run-v3-0-c4db58a651fc@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.3

While we document the values that can be passed to the "--update-refs="
option, we don't give the user any hint what the default behaviour is.
Document it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-history.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 4dbe665ec4..cc019de697 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -70,7 +70,7 @@ OPTIONS
 	Control which references will be updated by the command, if any. With
 	`branches`, all local branches that point to commits which are
 	descendants of the original commit will be rewritten. With `head`, only
-	the current `HEAD` reference will be rewritten.
+	the current `HEAD` reference will be rewritten. Defaults to `branches`.
 
 GIT
 ---

-- 
2.53.0.352.gd1286b26eb.dirty

