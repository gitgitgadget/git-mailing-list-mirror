Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD1D101DE
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 09:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711962248; cv=none; b=Q3WinmYXSpKUCft4HntxrBZc1JsWeJHWI66IohDKrD6vVHG9arZrhUKmJQt589ospTQNXvFJj3SM3GVCTvhuSLg3VZTnDAJcUtDc7xnQ5t0H90KLi4VwN9lmOoxmEXY9vjGlUp4cgdiyt0USJ45zvX5PtItzvat3HahoZ7afVWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711962248; c=relaxed/simple;
	bh=lxKQiZeAi091TK8XrXF3SjDYsgforJ8wmqtfVzbX8k4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lAV88zUVpAhW46W81eFVlNzVtUR6gUPMhS2RMOpq+A14TeYckaNv5HyEbVMI60WZY0ZSw9eXRwnYumikdqET4Iw7e5o+gKVn3TGaiMKR21Ag715azNAcnsPe4AYy9td7mRMZj0dnF1PBD/k1p+CNU4OlwbTS+tMH4y2Qm2zjGLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=NzYV+YU7; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="NzYV+YU7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1711962243; x=1712221443;
	bh=LbwfwuG5yvnK2WLJSglf4xuZZDIRNeLFqr+TcKdtjgY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NzYV+YU7O95cZuCZbRZ3zg6McqVjQlFFyU+qBZGelIUlsPota9fEkctvVachKkRbs
	 B68jzdpKTpXN0oDBvfMrjMKxOiRL6EeJ9nuHVlc08f0AmTTQuB4KlE9/hAHd6QpTA+
	 xqHWbv2z9nkE6e2b2atifNWYMUP4D5lGD8COS9eV2yp8wHNtnosfgv5kcLVK5j0Gv4
	 C7Vb4jjwrs4cF8rTVyP70G4xozcpco3qyaJKnj+hf88f5mD/k7fjL52p2b0u8MyXCj
	 n/Cu2/ZD1H0eJRPBeAovf3H5L5iJUhnH9H4teoFce+B2/06EB3Sg2P2nSHKsenHZT+
	 sR5n58an6QTHA==
Date: Mon, 01 Apr 2024 09:03:58 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH v2 8/8] fast-import: make comments more precise
Message-ID: <a503c55b83bc610aeefd72190b514264aacb8430.1711960552.git.thalia@archibald.dev>
In-Reply-To: <cover.1711960552.git.thalia@archibald.dev>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev>
Feedback-ID: 63908566:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The former is somewhat imprecise. The latter became out of sync with the
behavior in e814c39c2f (fast-import: refactor parsing of spaces,
2014-06-18).

Signed-off-by: Thalia Archibald <thalia@archibald.dev>
---
 builtin/fast-import.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 9d0f53fe04..9b66ffd2d0 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2210,7 +2210,7 @@ static int parse_mapped_oid_hex(const char *hex, stru=
ct object_id *oid, const ch
  *
  *   idnum ::=3D ':' bigint;
  *
- * Return the first character after the value in *endptr.
+ * Update *endptr to point to the first character after the value.
  *
  * Complain if the following character is not what is expected,
  * either a space or end of the string.
@@ -2243,8 +2243,8 @@ static uintmax_t parse_mark_ref_eol(const char *p)
 }
=20
 /*
- * Parse the mark reference, demanding a trailing space.  Return a
- * pointer to the space.
+ * Parse the mark reference, demanding a trailing space. Update *p to
+ * point to the first character after the space.
  */
 static uintmax_t parse_mark_ref_space(const char **p)
 {
--=20
2.44.0


