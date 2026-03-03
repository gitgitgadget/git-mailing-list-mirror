Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16675238C0D
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550786; cv=none; b=g+aadsBFpQJwsOkoet+OlpY+IiRTuRYgtTCoVHr3KtJ4sJ3eYThtMd4HxWKZJEUnpyuuPQRxvWJ2XXtnSN2zA2guUas1lO8rlBbtn/fXmELNhvAGe1WeGXraa+1daViG57JDN26K0qaSaqwJFg26kP8hXNO3hcyuGoa/VAICMGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550786; c=relaxed/simple;
	bh=MZcOf0EnmiYX1C2FhhWwsTvHuMxLSH/a2nYDWFPVH00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRQzkGovMPrRtLbsVjf3tSPHgugfZ0QfjmVxMLm9DUeqwqYQqglkWIu1ZiFF/8NZFlX0Cwl4UCejJVe4ca6s/xm1DyUjybau++c7BptJNAKipJLjovCCSMi97uNGo7Wdg2TlnJnan2YC50Lhrc2/Y+hrHBwY5dzh1IaLEqww/Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=mI35nCtl; arc=none smtp.client-ip=79.136.2.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="mI35nCtl"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 14D8F3F721;
	Tue,  3 Mar 2026 16:12:56 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Authentication-Results: pio-pvt-msa3.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hX-kxBuLPvSo; Tue,  3 Mar 2026 16:12:55 +0100 (CET)
Received: 
	by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id B6E3A3F64B;
	Tue,  3 Mar 2026 16:12:54 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F170CB2356;
	Tue,  3 Mar 2026 16:11:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1772550685; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=s/oJcPyFlTJ3l4g+j4k1SJjpLy8wV5qaHwllHXJU9c4=;
	b=mI35nCtlFdU7qPeuc1Wp03XrtTRvEH+YADD5eOfJbInqpAqGDxX0UXa/GJOo5sy2ChLeF4
	uVAUc8QAOQO1PSvMZUL/a24I/YtC+dMC+IakOeTHeh3cRVWDwffJsvow1FwXs2OHOvfXJj
	xyiAfdLbAZebml5RZ5OMmw7uW3EL8+N3y2yptqvP9qLu25h+uIdyCk7VSmLVOqsw3lYT7h
	9zoQs7gwQn8FJuk2b0WKzou+oUw79VQA5Wnnp8mDUwuJBNQ096hMkw8yfEJc4CEf9Rx1Ar
	IsPTJey+9yg17Y1sAoLG9gSQGypJcsJeBUFdGhn/SS5FDKb9r3bsMU11Imkq5A==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH] doc: fix list continuation in alias.adoc
Date: Tue,  3 Mar 2026 16:12:38 +0100
Message-ID: <20260303151238.1000191-1-jonatan@jontes.page>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add missing list continuation marks ('+') after code blocks and shell examples
so paragraphs render correctly as part of the preceding list item.

Signed-off-by: Jonatan Holmgren <jonatan@jontes.page>
---
 Documentation/config/alias.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/alias.adoc b/Documentation/config/alias.adoc
index 26949a0ccb..dc6ca0ee08 100644
--- a/Documentation/config/alias.adoc
+++ b/Documentation/config/alias.adoc
@@ -36,7 +36,7 @@ With a Git alias defined, e.g.,
     $ git config --global alias.last.command "cat-file commit HEAD"
 +
 `git last` is equivalent to `git cat-file commit HEAD`.
-
++
 To avoid confusion and troubles with script usage, aliases that
 hide existing Git commands are ignored except for deprecated
 commands.  Arguments are split by
-- 
2.53.0

