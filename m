Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CBB1E25E8
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751195239; cv=none; b=crkqM2t+h2og5ydBVT9BcSCwvHe2Rhx7K+Rj9fGe4mvdE/9ffrl9PrECk3O6xeA2hRXaIQGnOPyOxhX4y5907Bmmus6M27eNLBJWixiqItgy8mhZddEs7fJa9Cu4sG5SqAoLb1caDSWHff5Pr+V5GJPArgK0UD6MLf0Y7yvNlkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751195239; c=relaxed/simple;
	bh=loNHd+BQp2Ux3pRFv6mU/7BkCZuSq982rrUGua3YifI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OIxyise79ADH4dHixEeRVPDyQj22olKgu9Z1YcBkxb1+ngJrLbG/35s/a6ztLqoanf6PfTICn0X0sCqonuc7IdA3eFM9YxuSxRxzQOr7tJLm5Y/AV2dL/hXz5U7hJoa807xtvNfMm0FcuuzDa0kIWmPIjdnSRvQw2oWsDAhUhYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from cayenne.. (unknown [IPv6:2a01:e0a:d1:f360:c2d2:c7d2:a4cd:bda7])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 2C50413F89A;
	Sun, 29 Jun 2025 13:07:04 +0200 (CEST)
From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To: Meet Soni <meetsoni3017@gmail.com>,
	git@vger.kernel.org,
	ps@pks.im,
	shejialuo@gmail.com
Cc: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH] doc:git-for-each-ref: fix styling and typos
Date: Sun, 29 Jun 2025 13:05:31 +0200
Message-ID: <20250629110652.123890-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250627074934.1761897-2-meetsoni3017@gmail.com>
References: <20250627074934.1761897-2-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This commit fixes the synopsis syntax writing and changes the wording of a few
descriptions to be more consistent with the rest of the documentation.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-for-each-ref.adoc | 30 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
index 5ef89fc0fe..c2b2660771 100644
--- a/Documentation/git-for-each-ref.adoc
+++ b/Documentation/git-for-each-ref.adoc
@@ -8,13 +8,13 @@ git-for-each-ref - Output information on each ref
 SYNOPSIS
 --------
 [verse]
-'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
-		   [(--sort=<key>)...] [--format=<format>]
-		   [--include-root-refs] [ --stdin | <pattern>... ]
+'git for-each-ref' [--count=<count>] [--shell | --perl | --python | --tcl]
+		   [(--sort=<key>)...] [--format[=<format>]]
+		   [--include-root-refs] [--stdin | <pattern>...]
 		   [--points-at=<object>]
 		   [--merged[=<object>]] [--no-merged[=<object>]]
 		   [--contains[=<object>]] [--no-contains[=<object>]]
-		   [--exclude=<pattern> ...]
+		   [(--exclude=<excluded-pattern>)...]
 
 DESCRIPTION
 -----------
@@ -35,13 +35,11 @@ OPTIONS
 	beginning up to a slash.
 
 --stdin::
-	If `--stdin` is supplied, then the list of patterns is read from
-	standard input instead of from the argument list.
+	The list of patterns is read from standard input instead of from
+	the argument list.
 
 --count=<count>::
-	By default the command shows all refs that match
-	`<pattern>`.  This option makes it stop after showing
-	that many refs.
+	Stop after showing <count> refs.
 
 --sort=<key>::
 	A field name to sort on.  Prefix `-` to sort in
@@ -50,7 +48,7 @@ OPTIONS
 	multiple times, in which case the last key becomes the primary
 	key.
 
---format=<format>::
+ --format[=<format>]::
 	A string that interpolates `%(fieldname)` from a ref being shown and
 	the object it points at. In addition, the string literal `%%`
 	renders as `%` and `%xx` - where `xx` are hex digits - renders as
@@ -100,10 +98,10 @@ TAB %(refname)`.
 	Do not print a newline after formatted refs where the format expands
 	to the empty string.
 
---exclude=<pattern>::
-	If one or more patterns are given, only refs which do not match
-	any excluded pattern(s) are shown. Matching is done using the
-	same rules as `<pattern>` above.
+--exclude=<excluded-pattern>::
+	If one or more --exclude options are given, only refs which do not
+	match any _<excluded-pattern>_ parameters are shown. Matching is done
+	using the same rules as _<pattern>_ above.
 
 --include-root-refs::
 	List root refs (HEAD and pseudorefs) apart from regular refs.
@@ -131,8 +129,8 @@ refname::
 	`refs/tags/foo` into `tags/foo` and `%(refname:rstrip=-1)`
 	turns `refs/tags/foo` into `refs`). When the ref does not have
 	enough components, the result becomes an empty string if
-	stripping with positive <N>, or it becomes the full refname if
-	stripping with negative <N>.  Neither is an error.
+	stripping with positive _<N>_, or it becomes the full refname if
+	stripping with negative _<N>_.  Neither is an error.
 +
 `strip` can be used as a synonym to `lstrip`.
 
-- 
2.49.0

