Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528FA364930
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 20:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772139254; cv=none; b=Tusu8k2iep+L1MlX38clbCgYmjKDXYQpPbyOOtX2vrQN9tOnB1VE0Y1u2liUxZozBvV6xZ5RKmRkhDKwiRKJVCthol9naqZfrV+hXYPqac0rhlnTOUene6ly6XALMz1ImPXIbG8J46q7l18xctppMgjMTfl0RGCluVF43Lsn0xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772139254; c=relaxed/simple;
	bh=jCRJxsDnudvlIxSyUPm7km0NkQvjpwwkp9KP6YYzoA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfzqY6Z0BiuPUSS64MxnNzbKfdDk27icS7Waw5nFB1IP4qEPNfMrdtKX8ywnspojjfaB2S78PFMtR3likQSJAP9U/fjWv1st/iRL2wu5dmmvE0tifCDK8NlTEbl6KImXqteiUU64EuR4KODgK0s9XSb75FRCGa53ho7kv4Nwoks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=imaszV0o; arc=none smtp.client-ip=79.136.2.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="imaszV0o"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 850173F654;
	Thu, 26 Feb 2026 21:54:02 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: pio-pvt-msa3.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GP2MLYkZgb0F; Thu, 26 Feb 2026 21:54:01 +0100 (CET)
Received: 
	by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 7E7BD3F642;
	Thu, 26 Feb 2026 21:54:01 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E3DAFB234B;
	Thu, 26 Feb 2026 21:52:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1772139160; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=EZ7/tJmUdsMAijM5mpnasnJ6bEgFShYSvXg2HZrUwu0=;
	b=imaszV0oj2ZIqVKbmytod9Q+Gdtt6MhpIAMjD7fTR+jzbDFCqgqU5qS1ZU4WbsEq0mJBL7
	cKgIYxSNXXfBnEZXYTg/YA7OPKCSW2X0nemkjI+h+XsQyG5RKo+swHordxSLQVPQHcxRj0
	10SvHqInw7t5qYhavayvu582KCmWv+AB5dcOYPcBQ+msUOIi+Ri7IbGqlN7HGy/W4GwKxw
	lnBRbq0T+YuRx0PO53NLw4j9q8wGOpSj5g87tKVLedlmf/1Rmq4p7HYoDpQ/qaYSTe6CyH
	+5NF5MYAm0l//Bw08VFI+dvcogbBU0ExYH6DwF9r2wf/PktDpTzPBSsVGzNGYA==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH v2 1/3] doc: fix list continuation in alias subsection example
Date: Thu, 26 Feb 2026 21:53:26 +0100
Message-ID: <20260226205339.1535482-2-jonatan@jontes.page>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226205339.1535482-1-jonatan@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260226205339.1535482-1-jonatan@jontes.page>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The example showing the equivalence between alias.last and
alias.last.command was missing the list continuation marks (+
between the shell session block and the following prose, leaving
the paragraph detached from the list item in the rendered output.

Signed-off-by: Jonatan Holmgren <jonatan@jontes.page>
---
 Documentation/config/alias.adoc | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/alias.adoc b/Documentation/config/alias.adoc
index 115fdbb1e3..26949a0ccb 100644
--- a/Documentation/config/alias.adoc
+++ b/Documentation/config/alias.adoc
@@ -30,13 +30,14 @@ Examples:
 ----
 +
 With a Git alias defined, e.g.,
-
++
     $ git config --global alias.last "cat-file commit HEAD"
     # Which is equivalent to
     $ git config --global alias.last.command "cat-file commit HEAD"
++
+`git last` is equivalent to `git cat-file commit HEAD`.
 
-`git last` is equivalent to `git cat-file commit HEAD`. To avoid
-confusion and troubles with script usage, aliases that
+To avoid confusion and troubles with script usage, aliases that
 hide existing Git commands are ignored except for deprecated
 commands.  Arguments are split by
 spaces, the usual shell quoting and escaping are supported.
-- 
2.53.0

