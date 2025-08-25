Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8B6153BED
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 22:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756162224; cv=none; b=EaublnVEFK+fWmo5xcX4XoJYUIdXDIxGucbahXqIXRF0/pqrivaC4JEa6ei/TckOOJJOU2qI7c2IgPjhamNr+juRh6N2M7k0JuDEzZtmxQwB+YmIWu1dnbw9LjXr15S/1xrxeTkC3qoaScz0bfLd5Cv2iEsOkbMF+1PGBQyCVaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756162224; c=relaxed/simple;
	bh=XXC91gRji5NrRv0ohiq6Jlh2epV5wO+aruH0SzQLFUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzzo3eew+7UcjS8WpKfHpSTT7RXx2znuMZd6/56EG9c8K/egX2UEc0h3BMEVIXsnLdeDAUfArATc9iTanw9mXw22QLPT5Cni7B4SHrGSzmWYf+tJzltrs8zNV+tKpipmCsQ+rAOOhmQVD4inyWD1xRvvLhwn4xZ0eIc3OzeBcGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=XOFwBi17; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="XOFwBi17"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1756162221;
	bh=XXC91gRji5NrRv0ohiq6Jlh2epV5wO+aruH0SzQLFUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=XOFwBi174LNpWoVM/N37MV8Afbr4k0gGlGmv4seXybonwZBr4YozVmtC8BfWYDd63
	 5byaQWtP9V/7ycFc4q//ebd+kC2QkyO9GQw28F++kV8duul4CGZTKiTNVIieKd2I61
	 leuqhMudWUFPusveZwuZajXZF6qhKTvutQv7OWAGwegFq86mJfUfdjjsDZOYsBZz06
	 UUWBEFdwR8xZOOXFngzIynM8bNMhM3jBcsB0X0ujvRqxpEVBNHFiYMI3qE526VppIR
	 zjnIxPU99neJa4FqC8Cj+aX3bkODJsBfpW/zTTKh+/LSffdoxvdX7irikcxQz3X5BR
	 pLbkSQxsXec8Q58DPKkGM18QalDc4fKf9IuSiPAjkj1BrPnNsj+NiCMC8G7KobUfUZ
	 bhHl6D0OFxPG/X4qE07LsDsVw6X7c3pE3lCSksux/5MwMTqz+qxUiBfD9qgbpUVzKA
	 InQzxbDzb3wCrT/WBtev3Wkq8E4AKT6RITQp4NmjBvUo1nEFN5o
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5044:243e:8019:42f0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 31F76200C3;
	Mon, 25 Aug 2025 22:50:21 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] docs: note that extensions.compatobjectformat is incomplete
Date: Mon, 25 Aug 2025 22:50:18 +0000
Message-ID: <20250825225018.625943-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823220601.336079-1-sandals@crustytoothpaste.net>
References: <20250823220601.336079-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The compatibility object format is only implemented for loose objects,
not packed objects, so anyone attempting to push or fetch data into a
repository with this option will likely not see it work as expected.  In
addition, the underlying storage of loose object mapping is likely to
change because the current format is inefficient and does not handle
important mapping information such as that of submodules.

It would have been preferable to initially document that this was not
yet ready for prime time, but we did not do so.  We hinted at the fact
that this functionality is incomplete in the description, but did not
say so explicitly.  Let's do so now: indicate that this feature is
incomplete and subject to change and that the option is not designed to
be used by end users.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/config/extensions.adoc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index 9e2f321a6d..9d50a3501e 100644
--- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -14,6 +14,10 @@ compatObjectFormat::
 	compatObjectFormat.  As well as being able to use oids encoded in
 	compatObjectFormat in addition to oids encoded with objectFormat to
 	locally specify objects.
++
+Note that the functionality enabled by this option is incomplete and subject to
+change.  This extension currently exists only to allow development and testing of
+the underlying feature and is not designed to be enabled by end users.
 
 noop::
 	This extension does not change git's behavior at all. It is useful only
