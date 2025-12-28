Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2551239594
	for <git@vger.kernel.org>; Sun, 28 Dec 2025 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766945462; cv=none; b=XtMnptKGFGA79+BCWPIZ1R1vS8G5/royIq4Lk7Hz0LxcCU8xBWDdZZLC7n4sDwIBZVluLITJT91kOjqH29E9QC0l3/mrqN9XfJP++swWb2FJqNq5GsdK4mVLgzK65+CHJzkNbpgIJTov0QIQbOXhgWdHaqe3IVDbwEhwV9jKLn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766945462; c=relaxed/simple;
	bh=vPi7vWrejtl6HNwCOD6dup0MQDcq0LF45t5YhAL1KkA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1tK+E8VgZEggTNFY+9IvZQURMZy9PB2F2lNNI+VEYGhixPAulLjxNpiJm6YhWR2u5m2HnM7u3twwvigy/exX95elnd/GYH7SygUpOE1FZC9fgdHtw5ON0xtdTGlaEu4IFc6FtCKOGL07vlNyWYk6K6B+JgulWCwczuQkGCobck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=OFsoTShH; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="OFsoTShH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766945452; x=1767550252; i=l.s.r@web.de;
	bh=Och4HuY9/2RYBcejp7KymQCZdk1YKlrTDbpu7Jh7lO0=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OFsoTShHduo4KO+pO5go58vjbFB0slbVUH7OdOe75Rcwtt7P3wzguaYPCheXE1lo
	 fMuUocf5CJlXlgwe0CfStSP2FKXKe+0lZV1BrD5RuhKlvb1ZzwutOoPX7bWhf4KaC
	 ar4X5I6+UKPDHE2IfaL3Guhm3+Oa3W2028tl1rPzBIKQwLCq4j6F78Vc5ZXaBGxtm
	 +PKc2yse3Rq4EjfqbnSRWEM27dC66qqKbZZwtWL+pfO5DLpFG4LICQ/A4XD/JpLkX
	 9/r2CGAojb43rDMbSSIhooB2idkLL0dSFslFF5NFVpGCTrDhXpLVjHRA3nmwsC2Bh
	 aSiC3h2hklhx8UCyIA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.18.156]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MAtwr-1vkcao49bl-00CGVw for <git@vger.kernel.org>; Sun, 28 Dec 2025 19:10:52
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 4/4] tag: stop using the_repository
Date: Sun, 28 Dec 2025 19:10:51 +0100
Message-ID: <20251228181051.68724-5-l.s.r@web.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251228181051.68724-1-l.s.r@web.de>
References: <20251228181051.68724-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2LJb5CbsbXvGGEyV5aNG1ZhxnTjc38m1fip8BPjduft04MKeis9
 5THTo9Q+TNBmIDGjlt67TU1Q5sx5sPTOnuF8AzZo5/ruG5pfPNj3fAOHhaop1Ubuxga4WLC
 5ecAxlOvarq33cHwhRk3IZ2zc1ujhxwb5GqGWaMgUOTQ975MO7c3BwYwbEMvyucY08pu+Mm
 6TZpRWqLCQ1hEGypaWzmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QvduymJMan8=;ViUnXf6Kx7ryT0rJCESSfrffIQX
 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
 UKIzzhy9048Y6zNwg=

gpg_verify_tag() shows the passed in object name on error.  Both callers
provide one.  It falls back to abbreviated hashes for future callers
that pass in a NULL name.  DEFAULT_ABBREV is default_abbrev, which in
turn is a global variable that's populated by git_default_config() and
only available with USE_THE_REPOSITORY_VARIABLE.

Don't let that hypothetical hold us back from getting rid of
the_repository in tag.c.  Fall back to full hashes, which are more
appropriate for error messages anyway.  This allows us to stop setting
USE_THE_REPOSITORY_VARIABLE.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 tag.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tag.c b/tag.c
index 9daeaf2a78..2f12e51024 100644
=2D-- a/tag.c
+++ b/tag.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
=20
 #include "git-compat-util.h"
@@ -58,7 +57,7 @@ int gpg_verify_tag(struct repository *r, const struct ob=
ject_id *oid,
 		return error("%s: cannot verify a non-tag object of type %s.",
 				name_to_report ?
 				name_to_report :
-				repo_find_unique_abbrev(r, oid, DEFAULT_ABBREV),
+				oid_to_hex(oid),
 				type_name(type));
=20
 	buf =3D odb_read_object(r->objects, oid, &type, &size);
@@ -66,7 +65,7 @@ int gpg_verify_tag(struct repository *r, const struct ob=
ject_id *oid,
 		return error("%s: unable to read file.",
 				name_to_report ?
 				name_to_report :
-				repo_find_unique_abbrev(r, oid, DEFAULT_ABBREV));
+				oid_to_hex(oid));
=20
 	ret =3D run_gpg_verify(buf, size, flags);
=20
=2D-=20
2.52.0

