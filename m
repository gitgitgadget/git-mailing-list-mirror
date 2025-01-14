Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DCF2361D3
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855871; cv=none; b=U8LfTHBIZ8cRCO9L5VlJ0iqLuM1W35wkdU2xml/fXacvunAGx9jV/czCM7GLJjQUkZpmC5lN5TNtKFgQcOWLn5qpLB3n/m5ewMQPyN8L0aPpwX/cFiewkWG0Uv4zxM1GyrcOXGeMHR1eCEnbjnb/YC5mP2E2iO7hou8YGQYgS68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855871; c=relaxed/simple;
	bh=Honndp/eeZ32t7YgFoeOv9ULDC+oqWhFX5Ywk6Wp97k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ojx/SaO0aodaxYwfyVnHh0PDUbqoShgL2N72p5F93eTy9v7e+tR9aa6O1qHEo7EF561TjVDzWDZc1KGeNTonzBt4oQDoEVJtiK+zGe5mT2vgCk5IYUe9ZEuyNgjZ2BO8HrDmPqdiN3HPGiy31vSbwbxuYgrDnXavb3XqAj33dSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UmDgkJZb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hyCOJQ4J; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UmDgkJZb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hyCOJQ4J"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 034DB1380214;
	Tue, 14 Jan 2025 06:57:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 14 Jan 2025 06:57:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736855868;
	 x=1736942268; bh=yB3pGjx4Z2CVx2VaIL0yNkR09ZINvj+4TSPy2pjvZfk=; b=
	UmDgkJZbS5megWSMiYq/vsbi087yDTCKEFr9J5lTICsFIBcPdZF9AMgll1DPYOvj
	Gyy1NU2pIkxeBW7BHuK3jGJdLddY4R3qtRdi9gLK8yNzPQDZsjZfvdRTSSBA7o86
	T52gEHE8nGe8nW+2WWiIMBqEizvfiwQm8pqWPGfLgLHKSh1ztP7MRovsuDG7Q5A+
	OQoMYhpiTfqBYaNojPHYkWkRWmkTqbYWGGUTDfC3Y0Vgu14Mwkp/87BJ09l2ddsj
	fBTHrcoFDJXKGFcZS1H2L6GnCj8/FLQYVJkSj0hw8HLxmGaIoCad5H+sTd+yDG9b
	EDFA+uA0/Y6llBhEjvIJGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736855868; x=
	1736942268; bh=yB3pGjx4Z2CVx2VaIL0yNkR09ZINvj+4TSPy2pjvZfk=; b=h
	yCOJQ4JS3N9uLl/EUQuk3wu+EOJf28OBHfRrWQQHiwBjz+UXcuefo8vD7uU6ghgT
	tJ5Y1t0gZai1MOVuqPo8h5/7mqeSTPykxCxJ022IMLGxhipa2AP4L1E5dlegjNWu
	QNpF1OEHItGXD/cPJy1ZZ40Xf/CKII6TlSeBu7gEN692wCIx8Rxu6hYY7RaVWSBL
	QuHz7zCNzJDhHmHqKl3BPiJ6JC8VCNF5vOsPKegq8lfXOxz6+CnwTCPWBpP8pjcY
	3vSrfRQlDfKKjn+Luc6er+QI5n+tHrJfZxwIA9wOTzJK3rbVAtzGBR/n7//DByEB
	EmU2ZiEAtli/lzEyI2RfA==
X-ME-Sender: <xms:PFGGZxxNDsFHyn0JlKS8Axk0eTQS52uS_eX3QarBwdKNRp3lS7xX2w>
    <xme:PFGGZxQZJLKkn9DW1jIscRpez3GWU7GYlJT4WL-KtkIwPVIrnaT1nyf1u8sH8Rp9l
    B-_A8BtbJ2KBkAc4A>
X-ME-Received: <xmr:PFGGZ7X9trUMsSbJBIFuDNnLlR7Ky7ml7p-5Is2zKJcNj19MBznup1HriK8Uw8coCWV9WmuQGOoL0Lkmb95X_mG-JdhjyD46fSCiw4VwRDjETQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhm
X-ME-Proxy: <xmx:PFGGZzgQmuSPsHIweiRpKYU8OVIWV8Pvdap1-16j-YG50XMEQEFVLQ>
    <xmx:PFGGZzD8DoD1OZB2fEmol3tQFGT6GztCy6yw8w01RG7VDqREdRzs-g>
    <xmx:PFGGZ8IcG5qNjCneOOQqjQWXUKwQtZlDgFt225Ahz6-PjHvLpm-pNA>
    <xmx:PFGGZyAc1yr0XRQJASAMfDygMfksa6bFE3O4lROUMI_eO0NnGKBdIw>
    <xmx:PFGGZ2NfS9DIrcIIcX0GIGv8kohekXsVBB5DMKrhEuTMa8OpRmYqen15>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 06:57:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 14c6cf18 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 11:57:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 14 Jan 2025 12:57:44 +0100
Subject: [PATCH v2 03/10] compat: introduce new "zlib.h" header
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-b4-pks-compat-drop-uncompress2-v2-3-614a2158e34e@pks.im>
References: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
In-Reply-To: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.2

Introduce a new "compat/zlib-compat.h" header that we include instead of
including <zlib.h> directly. This will allow us to wire up zlib-ng as an
alternative backend for zlib compression in a subsequent commit.

Note that we cannot just call the file "compat/zlib.h", as that may
otherwise cause us to include that file instead of <zlib.h>.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/zlib-compat.h | 6 ++++++
 git-compat-util.h    | 2 +-
 reftable/block.c     | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/compat/zlib-compat.h b/compat/zlib-compat.h
new file mode 100644
index 0000000000000000000000000000000000000000..bc20b884efab72028d5f696923e9800e39b08ce3
--- /dev/null
+++ b/compat/zlib-compat.h
@@ -0,0 +1,6 @@
+#ifndef COMPAT_ZLIB_H
+#define COMPAT_ZLIB_H
+
+#include <zlib.h>
+
+#endif /* COMPAT_ZLIB_H */
diff --git a/git-compat-util.h b/git-compat-util.h
index c4b4b372b473ca0af2a4f5f60554f6d3df74f112..1ca26713221ba0270818ac61b6940f03cdf8b460 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1537,7 +1537,7 @@ int cmd_main(int, const char **);
 int common_exit(const char *file, int line, int code);
 #define exit(code) exit(common_exit(__FILE__, __LINE__, (code)))
 
-#include <zlib.h>
+#include "compat/zlib-compat.h"
 
 /*
  * This include must come after system headers, since it introduces macros that
diff --git a/reftable/block.c b/reftable/block.c
index 9858bbc7c5f7aa63fbcaf1acf9f4b5738e0b6d27..bc9b07963448e613ae14d2c4194b48764718290d 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -13,7 +13,7 @@ license that can be found in the LICENSE file or at
 #include "record.h"
 #include "reftable-error.h"
 #include "system.h"
-#include <zlib.h>
+#include "compat/zlib-compat.h"
 
 int header_size(int version)
 {

-- 
2.48.0.257.gd3603152ad.dirty

