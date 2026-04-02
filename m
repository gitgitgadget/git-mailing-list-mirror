Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE4E372B21
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 22:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775169779; cv=none; b=mB/XkbEmi2qosvZ+PufpQRnCAdAtnbrjFpr8mYdfYYNxm27/XuKDZx1eejd7/lUIeAxURA2lWAwh3FLn3ccEBUcNzgqlqM+Q92lLlQBUiTWBIorigrgX3rLwX4TtfknlfIkTG/cqKO/V5LMqfiMM9j45AIs5pJxkHKjHHevmoGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775169779; c=relaxed/simple;
	bh=Gis2J1Rfk6nHQkfjU8eMSOSA5bHEdCP113I3tyWXATs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gb4hEhilDY9nW27xj8UbKaUZQIuTw3XGtSgrdI1+PmE4ktuEajgfwqWIqyE7xVYElFJxM9GicHHunevKv/YjNjD6mmiZ2w1QJ/DSdGHeSTHSgTB/ziLXejePcnWwOMWwO59ltfQcXI6arcpSn2sG9ZLWi+cd71PgYXw4xFTDlEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=fWWKD8T1; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="fWWKD8T1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1775169770;
	bh=Gis2J1Rfk6nHQkfjU8eMSOSA5bHEdCP113I3tyWXATs=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=fWWKD8T1nBgzcwreVNqC6TNF5pCqz4mPRmQAErEd+2zO8yWUz7ZPsVSQlgTKfMyjM
	 5Xx3Jxa0RmMmvJhsNCXN/qZkG2KC/09Nx9XgLNyVZuqMCqBKQEsLD6pJDSm/MDhLWX
	 jGl985EX1WKskJ4YVRFQArmBjM1HGHkRHOy51sPC2o1jHzJFRp3NMuPiT6+BcazhDQ
	 VYCdbydvVF0g0yrmUrCAXJrVvx+msegaVe28oARiwXF/2ba47Yun/yM2MSH8RovHen
	 Y+GFYDgYNw7/VOyvhbSNLr2LMqRNTc9op2A8RQkHJj3XgqRLZvDd2Uw0UtWWOH8FUb
	 JpdVpR6mlThC6Y4irI0Egx+2GwpOg46n4ugL4wkiknDROhJxseTpAmdCt5ldexVezv
	 TAKfmkpgU9U/fLWGOeTDGvMLMHriXwuAazgbzki6fZuxPSKv9kT4tkkfujChMohJW+
	 A2lzYus4kSTaPppZ1I+zS5AkGkeFclK87vk8uEzDIFSPrJvgCZ9
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:4fc4:8150:dc47:49e7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7F2702011B;
	Thu,  2 Apr 2026 22:42:50 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] docs: correct information about reftable
Date: Thu,  2 Apr 2026 22:42:41 +0000
Message-ID: <20260402224241.4104726-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our description of the reftable format is that it is experimental and
subject to change, but that is no longer true.  Remove this statement so
as not to mislead users.

In addition, the documentation says that the files format is the
default, but that is not true if breaking changes mode is on.  Correct
this information with a conditional.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
Someone who was asking a question on the list pointed out that the docs
still said reftable was experimental and I said I'd send a patch to fix
that, so here it is.

Moreover, I think the with-breaking-changes item is helpful for us to
find all the places that we'll need to change for Git 3.0, in addition
to our goal of having strictly accurate documentation.

 Documentation/ref-storage-format.adoc | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/ref-storage-format.adoc b/Documentation/ref-storage-format.adoc
index 6a8db4712b..c5e29ec831 100644
--- a/Documentation/ref-storage-format.adoc
+++ b/Documentation/ref-storage-format.adoc
@@ -1,3 +1,8 @@
-`files`;; for loose files with packed-refs. This is the default.
-`reftable`;; for the reftable format. This format is experimental and its
-  internals are subject to change.
+`files`;; for loose files with packed-refs.
+ifndef::with-breaking-changes[]
+	This is the default.
+endif::with-breaking-changes[]
+`reftable`;; for the reftable format.
+ifdef::with-breaking-changes[]
+	This is the default.
+endif::with-breaking-changes[]
