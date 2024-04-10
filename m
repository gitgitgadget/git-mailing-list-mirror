Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C95157E6E
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742986; cv=none; b=rawJW6sI2LyHItB1frnT8iedd2CEUJbFBO1YcxK0idU3Mh53FBHDLbFcMMZJf0+I6lg4qYDb5qfwp5JSlJdU9KINXvXlcib183+pw+SUxqTVXD9ykWBGjZ5P2s/AqTea0gjvePHXn7tvjAkIdGTGsunI5dZZBVWz7Q0SlRQM1Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742986; c=relaxed/simple;
	bh=s+KSrfGpa9OJzLKh4Gc7sETgBpDLK6OMh3A+HZM9tSc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vx2Xg6I3U+lXBckNMwSEI0feT3LCYW6JXQjBekHtrvNbBThZ0G3UVD+5OsP8Uaep1eHMbiw5WwCp+QTuer8tePe2rxab77KSPEnqVaA5X42GYjZv/9mQXJrQ5pPp+LfVcPmF1HoTbVllDJoByFXnBbZOchFVmG2LCAb/T37h97w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=ru0DUjvo; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="ru0DUjvo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1712742983; x=1713002183;
	bh=nNlap/Saz/8xmDFehKd1u6H0Jzz6QfvQuLUSTi4ywVM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ru0DUjvovktRkDecZhaioxc8iWbz77vWcA+/uGeIeNXdfqhwkcCyCOV2LzQ66jx71
	 oV9JCybejkZAlbEmC9orwar2QVkZsLmJwyFI7jm9HgkZRFc+GKb4tYRwLTo2LA1u6i
	 l/25DehtI83rXZGdBj3I1o8rShKEzT0jdCPx4SIJDPW7o7ldBu+S6ekyLsTjG2vSh0
	 FCnG15LGxHrFAybnZNhUYD/FRJdm99+Zr3IkKseTgP/owJ7GgqAwiO2yA96LvD58df
	 Mz9mTen7fKSs+SvBmTOKAm2GPzYTANcSZxsOzZZBUCXvqPevdDoVYxzLh9Cq+gRGo5
	 6lM9lenLe//7A==
Date: Wed, 10 Apr 2024 09:56:18 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>, Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH v3 8/8] fast-import: make comments more precise
Message-ID: <5e02d887bc93a4212499c3bd13b36c401cc19081.1712741871.git.thalia@archibald.dev>
In-Reply-To: <cover.1712741870.git.thalia@archibald.dev>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev> <cover.1712741870.git.thalia@archibald.dev>
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
index 98096b6fa7..fd23a00150 100644
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


