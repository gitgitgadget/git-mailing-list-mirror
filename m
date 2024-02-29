Received: from impout001.msg.chrl.nc.charter.net (impout001aa.msg.chrl.nc.charter.net [47.43.20.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA1179933
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 19:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709233469; cv=none; b=XERVcs0Coc+DLx5V++PXWQy+1AH8ybIN2ywPQIo7DJv4aw2IAo39stkEN40HerOa9zJxx35NJbZL7R9oQQ0KrSi3J4vyqyCLWdtpcgLAAAuHzkvSbHGtyzGqH9S9Bh+G9n0o0jPKXJDAN1VaqjGKwbXlNXyAn+gCWIx9TUOEQ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709233469; c=relaxed/simple;
	bh=5zzq7MRtN83RC8w+jHy0gxTevr16t4QLDJEgRc2vEXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=raGL6Sov9d61XUcgt0c2/UhBHxf/KZqCCqHEDRuWaR9ohzp8A6FJUXRuM4yTEJUKa9S1yQNegME3hA/MCx08/dUx+0IM0sPD1+2Vjp4kvSzJkquqy4n6VYmJ1CbWccWDFhGHws5bZVpAIiOH42BXvoVvkGFEmANfN1W+0yYENkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=LTJfeRrq; arc=none smtp.client-ip=47.43.20.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="LTJfeRrq"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id flfzrOVy3k96Zflg7rE5v1; Thu, 29 Feb 2024 19:02:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1709233369;
	bh=5zzq7MRtN83RC8w+jHy0gxTevr16t4QLDJEgRc2vEXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LTJfeRrqVVWahzJRv7LPBep+iF7xt56YT9bwHq4KBtnh/CF27rntkCJveC0Uv7FLZ
	 Q6rZ9suUS3+hpZEGeVhpRSPETyIGZL9j1iucpdEQ5kwWZT+G7AIqz5HXYuUuqhh/Mj
	 gpbLxXkSe5VKnjZ2GQY+GGSswb+LG+9rFA/MtcNefjD0C+XLMv5N5ecJBdU1kOZ08B
	 Gg4K9qKfOqSALgB2N2vVfL+FGxogb3yjG7JXu9mZQZ3pj+cGV9vtAYkaKTDKwjyjdM
	 DsGvyScE7g/QYFZYP/TXzMkEVXW3JG1twso7sK4BSu0g5V4SEa69WT1+kvHcgFlW9K
	 mnhbPszw11fZw==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=VsYlAf2n c=1 sm=1 tr=0 ts=65e0d4d9
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=4_4KAXEiAAAA:8 a=kdyldk7IsPFzHzsP2zMA:9 a=jYKBPJSq9nmHKCndOPe9:22
 a=2dBW64JbcpvAzUZBiPf5:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Bruno Haible <bruno@clisp.org>
Subject: [PATCH] docs: sort configuration variable groupings alphabetically
Date: Thu, 29 Feb 2024 14:02:29 -0500
Message-ID: <20240229190229.20222-1-ericsunshine@charter.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <6139934.yKrmzQ4Hd0@nimes>
References: <6139934.yKrmzQ4Hd0@nimes>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLvrA1FdnCWRF0DPJYLfvUVqkUTz1v4T9Il5hpOGo3mSU0X53YEAHq3HTS6AU75u6JJQ2QCSDMdB6+a/dtuz/v3uUyUs3ZUa31oF6t7KgA/JhfOHh/so
 IoOWGUaF1jyNpk8gTXtc19rhdvWQBrMZSkJu21S0r5dLT5NjlXbri7FDwmFBZbVAwzeCkm3Kz80z5BWR2lbGB3zYi5LVn0wYS6an/6MM2M0NWihC1ec7+BUO
 1X9KqAbeED8OJvZ9j6awcGPJyAeh2jPABBHbPqzDIXE=

From: Eric Sunshine <sunshine@sunshineco.com>

By and large, variable groupings in Documentation/config.txt are sorted
alphabetically, though a few are not. Those outliers make it more
difficult to find a specific grouping when quickly running an eye over
the list to locate a variable of interest. Address this shortcoming by
sorting the groupings alphabetically.

NOTE: This change only sorts the top-level groupings (i.e. "core.*"
comes after "completion.*"); it does not touch the ordering of variables
within each group since variables within individual groups might
intentionally be ordered in some other fashion (such as
most-common-first or most-important-first).

Reported-by: Bruno Haible <bruno@clisp.org>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/config.txt | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e3a74dd1c1..782c2bab90 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -369,20 +369,18 @@ inventing new variables for use in your own tool, make sure their
 names do not conflict with those that are used by Git itself and
 other popular tools, and describe them in your documentation.
 
-include::config/advice.txt[]
-
-include::config/attr.txt[]
-
-include::config/core.txt[]
-
 include::config/add.txt[]
 
+include::config/advice.txt[]
+
 include::config/alias.txt[]
 
 include::config/am.txt[]
 
 include::config/apply.txt[]
 
+include::config/attr.txt[]
+
 include::config/blame.txt[]
 
 include::config/branch.txt[]
@@ -405,10 +403,12 @@ include::config/commit.txt[]
 
 include::config/commitgraph.txt[]
 
-include::config/credential.txt[]
-
 include::config/completion.txt[]
 
+include::config/core.txt[]
+
+include::config/credential.txt[]
+
 include::config/diff.txt[]
 
 include::config/difftool.txt[]
@@ -421,10 +421,10 @@ include::config/feature.txt[]
 
 include::config/fetch.txt[]
 
-include::config/format.txt[]
-
 include::config/filter.txt[]
 
+include::config/format.txt[]
+
 include::config/fsck.txt[]
 
 include::config/fsmonitor--daemon.txt[]
@@ -435,10 +435,10 @@ include::config/gitcvs.txt[]
 
 include::config/gitweb.txt[]
 
-include::config/grep.txt[]
-
 include::config/gpg.txt[]
 
+include::config/grep.txt[]
+
 include::config/gui.txt[]
 
 include::config/guitool.txt[]
@@ -519,10 +519,10 @@ include::config/splitindex.txt[]
 
 include::config/ssh.txt[]
 
-include::config/status.txt[]
-
 include::config/stash.txt[]
 
+include::config/status.txt[]
+
 include::config/submodule.txt[]
 
 include::config/tag.txt[]
-- 
2.44.0

