Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9045F50A62
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909049; cv=none; b=HScN5tXjd9GbXyGOULeuzI6XjGdDb2Xsfm5Y9+ViVUGhtQtyqkT3gbrmJ0UwjwgBZzUdKGgEPg9CFGVIQ0tmKb4iwR4zY8+mk9zA2/KPsoaxbgrbYel+EwU9p1I+JIa8ebcjgFF4EWywxkLtgEymnkyhlMYpEe792ro1YmLVjlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909049; c=relaxed/simple;
	bh=s+KSrfGpa9OJzLKh4Gc7sETgBpDLK6OMh3A+HZM9tSc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EMOfH9zJvRGUy7ytE7dRrhannYkIEuKGSA9ola1p51J4rI8k9ZxYh4soDV/zs0+umL8qs0MjN19MHfsVfyKEYIe03zOj6lZq5gz3wIsNr4n49Odl5uU6Hv4B3Fomt6B3w65rOY4FYOUc5UgnXog0KUi5zJhbj2afu+1D684SqHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=gEYxJISR; arc=none smtp.client-ip=185.70.40.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="gEYxJISR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1712909041; x=1713168241;
	bh=nNlap/Saz/8xmDFehKd1u6H0Jzz6QfvQuLUSTi4ywVM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=gEYxJISRtZ+ahFW9SQDkFlGBc2cwfXQ78t2oWLimKD25l/wAVFtuRaE/aBYysYoDD
	 f68VgkrlI6d62dRO/KL0K62rCYkCruExMCMejhvokjI3xVKl1Iak3yKBHsVIBXeI+N
	 sr7oLD0crz7oENciRBaVv7NVUWLwTGOnVCOdxNly5hzWkJLXMlWA7ob/zIKxooKbyB
	 ZymWug8HnxqQY0PvF96QjfBYs4asbmt82wQpIznd8+i75wcjDYHfohv+Li8vZmm+WO
	 8HurjghUT0RgXbWCl/HNsEPis4Eo9iiUfCNVhmWV5oP82R2tswVvs4AxLA/BEWCaFJ
	 DxhJxa3/jXNaQ==
Date: Fri, 12 Apr 2024 08:03:55 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>, Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH v4 8/8] fast-import: make comments more precise
Message-ID: <6eb66fce45f16a87fa01e3e38d85c9e32131b0d4.1712907684.git.thalia@archibald.dev>
In-Reply-To: <cover.1712907684.git.thalia@archibald.dev>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev> <cover.1712741870.git.thalia@archibald.dev> <cover.1712907684.git.thalia@archibald.dev>
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


