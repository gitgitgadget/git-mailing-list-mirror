Received: from ste-pvt-msa2.bahnhof.se (ste-pvt-msa2.bahnhof.se [213.80.101.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE573A1E8C
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.80.101.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771953217; cv=none; b=NgiLJfLwQIWBYbm7qBWO7lkuj/MXOo17l2aVT4Yq18m+xj+xCGLpMh6UmxJ+pjVRXtigbsmy0bp7Bm69pG8GE6zacW8IxR6SDx18xW1lK359McQCT+KKajvEfVP1Cgxpejiy/CrNe9AcBHei523YDdM1d45nc/BJW3rQztSDxmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771953217; c=relaxed/simple;
	bh=O4D+IeMRmY1Xbmhyeg4/5uVh8lGakM7/NQvd5ysMpYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZttyO7B1haJnWBvqq6zMzwLMCT9/BVXVP2G/6VSGgSalCml+2q06Z2TldPr6Xf0c7Z/AgGs0n+zDcDigYD5Xifo/Dro+KTlryRMZJR7BldxT3SGTwtxtKGGolTLlHDMlzuLhnd1DFe5aNuJ/ZuSceFjc4x0o5SDeeoAKpALkyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=Ofkc4dLG; arc=none smtp.client-ip=213.80.101.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="Ofkc4dLG"
Received: from localhost (localhost [127.0.0.1])
	by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 3281D4142C;
	Tue, 24 Feb 2026 18:13:28 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: ste-pvt-msa2.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
	by localhost (ste-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qxmP59IvDjzZ; Tue, 24 Feb 2026 18:13:27 +0100 (CET)
Received: 
	by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 5783B41427;
	Tue, 24 Feb 2026 18:13:27 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4D8C1B223E;
	Tue, 24 Feb 2026 18:12:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1771953129; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Rlh40frEL/ZC//yVP9DR7jRJmTlH0xzN+Qnsgwc1Itg=;
	b=Ofkc4dLGZcLXcQJmFk04FeYd+IaNR0pRe/XWTIMfLKHsMqzIyowa6nS6tvkrNSt8DwQM/t
	mhwIySd2pMcf0DnNkxMO6LMGYQ4i7s93eD1nDNSyqlsBR4JUZzcgWnRslNkXT5i0UizuQP
	e88SdtfjijcLa56n3c65XLU6YsildN2n/+xg+zEb8N+7fkzkgt6SlWAz1Phn0UkwLe1+Rk
	39AJVn7KUdCnXzE3qRXBucIWgVQSZ26r4ze1/tOE6oWUNOYzOP/tWydWOU9I+wbS4aB4Wf
	8Vn6uRfepZwVpvxjh+OmjKXIhCLFESrcbAGA0ew5FXEjEHacipAhqfjIMd+ixQ==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH 1/2] doc: fix list continuation in alias subsection example
Date: Tue, 24 Feb 2026 18:12:35 +0100
Message-ID: <20260224171245.458377-2-jonatan@jontes.page>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224171245.458377-1-jonatan@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260224171245.458377-1-jonatan@jontes.page>
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
index 115fdbb1e3..7830379f58 100644
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

