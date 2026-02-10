Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12406306483
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770762500; cv=none; b=J0nvEAiRf9Ff9o+8PKjgvVKmEpErtQSXs7TckR9iD+6+Y4h+4dYT2CVr/j8j+srLZ3dI9dVElJbiUsfu2VjzLRVUo9a2tlHvdTmBPEBvsF7NZI+8xBoonKobZ9Ad+UdLWeTGi+Xlmv6glJmQeDMU4EgYH6Nm3bLmuqbCMSIoZ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770762500; c=relaxed/simple;
	bh=Y7xPNP/9KtKNHQYJ0TPoComvvV9R5XDLcHoS4dsnJGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5OX1WwgX7VPxsVBpA/mQFAkLOS4XtEuo/v2AIMgbMIkyO8TJTekeUWAt4gw+XWr/pDeikNWm1enN80K6QtlJmS9jw/ydmKfXZuCik1DBllrguKucF7NX1KlHEntwvED0j0Pm6JETawr2W+Mqg13hdyR70+Wj/m5r7W9jZUPbgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=E1aLc4v6; arc=none smtp.client-ip=79.136.2.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="E1aLc4v6"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 8A55B40537;
	Tue, 10 Feb 2026 23:28:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: pio-pvt-msa2.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9jH_pTZ5N-d7; Tue, 10 Feb 2026 23:28:15 +0100 (CET)
Received: 
	by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 57A2E403BB;
	Tue, 10 Feb 2026 23:28:14 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4AF68B1AE1;
	Tue, 10 Feb 2026 23:27:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1770762437; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gNzwI5wklXH9ht5+yet1R28aQ8ECNi/6cT19zJZPMl4=;
	b=E1aLc4v6XNSOkIO04DA0OMUlsAxxrU+5GpjBCdVsnWheHZj5gVW19K3LxX6lyW0lg6Lkwz
	lcrSZzB1zYqSy7bXXvbMHOLmqAl1Rk+/FaQceoHYSHRqTmwI6Qa47stS/sbK6R2auvmzM3
	7n3YUXL8TazFexGA7OzjP5TTULNbKxeRLC62WekzLnzvZ3KwTzOA9QLZLvdNP1dDW0v1aR
	NcqIsnZiO+sf9DLipHmWj/5Bctqoqc392VQvfRfuktcAvCKpISEWHYxH0+x10YzTP/AyaS
	JwyOsZAGWTny8/JYaRmvIggieMRcZptKcTcsDFQGoYGTktSJH/zHlmto188e6Q==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH 0/3] support UTF-8 in alias names
Date: Tue, 10 Feb 2026 23:27:42 +0100
Message-ID: <20260210222745.78575-1-jonatan@jontes.page>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

This v3 addresses all feedback from Junio on v2. Changes since v2:

- Split into three commits: a preparatory refactoring, a compatibility-
  breaking change separated explicitly, and the main feature
- Preserved error checking for value-less alias config (config_error_nonbool)
- Fixed behavior when !value to preserve adding items to list while keeping
  util as NULL
- Improved commit messages to say "ASCII alphanumeric" and better explain
  that aliases are implemented as config variable names
- Tests now properly verify value-less command key handling

The implementation follows Peff's suggestion to use config subsections
rather than modifying the config key syntax. This allows arbitrary bytes
in alias names while maintaining backward compatibility.

Suggested release note blurb:

 * Git aliases now support UTF-8 characters and special characters
   in alias names through subsection syntax: `[alias "name"] command = value`.
   This enables aliases in non-English languages. The traditional syntax
   (without subsection, e.g., `[alias] co = checkout`) continues to work.

Jonatan Holmgren (3):
  help: use list_aliases() for alias listing
  alias: prepare for subsection aliases
  alias: support non-alphanumeric names via subsection syntax

 Documentation/config/alias.adoc | 43 ++++++++++++++++++-----
 alias.c                         | 40 +++++++++++++++++++---
 help.c                          | 39 +++++++++++----------
 t/t0014-alias.sh                | 60 +++++++++++++++++++++++++++++++++
 4 files changed, 150 insertions(+), 32 deletions(-)

-- 
2.53.0
