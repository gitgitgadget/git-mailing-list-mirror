Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF5B2BE630
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 05:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775281341; cv=none; b=I87YCpcGBqoDleFtLu/RWA3E/ZzzTRZSFpfst233j6QCyJb45oBlCZYH4KJjev11vUownQNR8GvS5mR1BzCyPESJbJi8KndwYhpuptQMolhBK6vzQUyaxQ1XNOH1co1OvDI1g0pgqlE3pxpgUyJUrEy/KsghjUdWFerjlX3phWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775281341; c=relaxed/simple;
	bh=pHgAljtJmXGpFkquyInihenv/Nh6XPh9a4JwjdBERvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ei7/G9O6LVDLwaJ/awA7RUdLdaanpmsyH+xIq/vTm86EylnWZ9j/g/bDJh+Nmfu1HjTwn022zGDqHEdYZ2fOSmKK5IwT2O2F2dnl0xTL4b7MplKqPLekoFURciqag7y2sN/fmuwQSUO3ufDstggiJPKAi4VeTzW457axOSVOMbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZOMVag1J; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZOMVag1J"
Received: (qmail 239653 invoked by uid 106); 4 Apr 2026 05:42:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=pHgAljtJmXGpFkquyInihenv/Nh6XPh9a4JwjdBERvY=; b=ZOMVag1JATiB5KNS8zx12vvBW0IgXEachxHlM8cGU3jjadR/ozpnO+X8cvdXBe75Y7WEToXBJ3cFfFyut/90N2VCLS9ybcGmO/0/v5GLcD1OFCJa37CI2XJUxESTgiyBhE+ndmRgihv0PbvoSq8GKpsQxsb0IVLoRVjCV9O5rlQyjPvw6nDwnBwJAM0uUwToyFFiVa7p0KDFTAsqBE/wasQ2JpgVldGZPrkpYGkNzc454yYzEp82dCyFd2QN83xLrVJLOSaLveL8VVBhZ1l3k7jw9aFHCi35EmxyEHcteVLFXJRQD8Mzrah8dL2d+9Ls1qXgbFeo2Z8u4sEVqgm3fg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Apr 2026 05:42:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 386243 invoked by uid 111); 4 Apr 2026 05:42:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Apr 2026 01:42:12 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 4 Apr 2026 01:42:11 -0400
From: Jeff King <peff@peff.net>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Collin Funk <collin.funk1@gmail.com>,
	Michael J Gruber <git@grubix.eu>
Subject: [PATCH v2 13/12] git-compat-util: fix CONST_OUTPARAM typo and
 indentation
Message-ID: <20260404054211.GA1346444@coredump.intra.peff.net>
References: <20260402041433.GA3501120@coredump.intra.peff.net>
 <20260402041507.GH3501239@coredump.intra.peff.net>
 <87h5ps5mbc.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h5ps5mbc.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>

On Fri, Apr 03, 2026 at 01:13:11PM +0200, Toon Claes wrote:

> > +/*
> > + * Check that an out-parameter that is "at least as const as" a matching
> > + * in-parameter. For example, skip_prefix() will return "out" that is a subset
> > + * of "str". So:
> > + *
> > + *  const str, const out: ok
> > + *  non-const str, const out: ok
> > + *  non-const str, non-const out: ok
> > + *  const str, non-const out: compile error
> > + *
> > + *  See the skip_prefix macro below for an example of use.
> > + */
> > +#define CONST_OUTPARAM(in, out) \
> > +    ((const char **)(0 ? ((*(out) = (in)),(out)) : (out)))
> 
> I'm not sure it matters, but this is indented with spaces

This is in 'next', so we'd need a patch on top. Maybe not worth it on
its own, but we also missed the typo-fix that Junio pointed out earlier.

So maybe this on top:

-- >8 --
Subject: [PATCH] git-compat-util: fix CONST_OUTPARAM typo and indentation

There's a typo in the comment, making it hard to understand. And the
macro itself is indented with spaces rather than tab.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-compat-util.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 4ddac61992..ae1bdc90a4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -464,7 +464,7 @@ report_fn get_warn_routine(void);
 void set_die_is_recursing_routine(int (*routine)(void));
 
 /*
- * Check that an out-parameter that is "at least as const as" a matching
+ * Check that an out-parameter is "at least as const as" a matching
  * in-parameter. For example, skip_prefix() will return "out" that is a subset
  * of "str". So:
  *
@@ -476,7 +476,7 @@ void set_die_is_recursing_routine(int (*routine)(void));
  *  See the skip_prefix macro below for an example of use.
  */
 #define CONST_OUTPARAM(in, out) \
-    ((const char **)(0 ? ((*(out) = (in)),(out)) : (out)))
+	((const char **)(0 ? ((*(out) = (in)),(out)) : (out)))
 
 /*
  * If the string "str" begins with the string found in "prefix", return true.
-- 
2.54.0.rc0.409.g4c76eb20e4

