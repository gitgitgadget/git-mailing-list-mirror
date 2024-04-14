Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496091C696
	for <git@vger.kernel.org>; Sun, 14 Apr 2024 01:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713057161; cv=none; b=vCf/jFWYPWBxlxO9PX5xzo83w0RDzG/Fzc1MdyxundUlFat0T1WovxQTAUCTNLjPjRHKaj582cPIji6C0qE/ChByeLDBNc8Rc/EfwciVD64uH3pcJQEngxXZQYOXt3SCGUpNmhEymWgVjssZipuiyhQmtv8q35EQfTXR1gs0sNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713057161; c=relaxed/simple;
	bh=GOMzc9A2sJhD5DOVQIUZe6v2ySQySH/j2AgC1HtJX0o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhcZzhyKCUUcFrsmUT6Mm1ZACkyEdCJlhPRbu0DzAGqD+hmhve72fv7fxiMoypNPITUn5XRr1e/ihRWA0cp69gB4Lx++w+rWNdc+3jg9mjyqNGwVyJtcjEnFUc6TRomKpy92IFIo51jZEfLn+oqgaK2c1pMumt7iWZp/ZnXRXic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=slhmpFjL; arc=none smtp.client-ip=185.70.40.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="slhmpFjL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1713057158; x=1713316358;
	bh=1P8Aq3RGnwXV5fAQESvxnzs78mtemBjYAyvkGom4DPc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=slhmpFjLgI0+pvMz8WvAwO5XRCZisWoooGG050LXw2xKPMwYO1E8wxFKtv8Rln97K
	 Ljbz6h0U9nqIn6aa9Ejw9GoQK4t7fccPoGd+X6rcOQGknBxCW4LNBqGhz1Qhm1lVdH
	 hnka0SRyiE8Up8cv1tD48ND0RiP8jyyLgFJHakTUwzAoMYCFQY0snzsZSSUBGNoR5P
	 5ZPW4PK6irnniWNx0f7v6G4yHNvkK6G5neXICbblX/uo8Mbx9sv20nMp2jIU3x+1c6
	 EEzyc273gctkUW94Q6/GXZmkUEUqg+2eTw+wG1fOsPNiXa5slhirL8dpSOoBceiFp5
	 s+biiEP6ijggg==
Date: Sun, 14 Apr 2024 01:12:27 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>, Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH v5 8/8] fast-import: make comments more precise
Message-ID: <65d7896e399a64670a71fc3fbde6e39dd0dc299d.1713056559.git.thalia@archibald.dev>
In-Reply-To: <cover.1713056559.git.thalia@archibald.dev>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev> <cover.1712741870.git.thalia@archibald.dev> <cover.1712907684.git.thalia@archibald.dev> <cover.1713056559.git.thalia@archibald.dev>
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
index 419ffdcdb5..dc5a9d32dd 100644
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


