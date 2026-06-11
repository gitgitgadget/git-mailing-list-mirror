Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871DD47DFB0
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197633; cv=none; b=fjW945KUzwCO9z2QjN4fn0gpetlUqZJEEHyk1HvU0YrXnwy577FWEUAkpnxi/qoJ2Nat1/v4U3+AvbtVuG0g45lHD64i0l9zKpGFSx7Ybw4NFnCWrPmv92kCmVUF7FO1Zfo9D13HLdeUVMexKnb1OIUqHXItA2NK1Yps+HtfMbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197633; c=relaxed/simple;
	bh=D0gJX+WP9LZvdPVfokadJ9eE37BzHUlGSl2+Ae/ozag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lExyjgL95SUHNWCVQNNwXZU2/+ufAMEZ6XhsbHw6ZAbeDH8NdUV5beRhv0p7YUiP2VKM8zcJsJb10FAqwH0SXjeXKzDG62OmZ1Md0kmi9GXBoXFF1r29vXFDaQoUf7/TT7S+jrUr+8Rbv+HL40W/bq+6Yih0jHy5OcU+VYMm6Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=olHw4aH4; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="olHw4aH4"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 65BH6tPg006675-65BH6tPi006675
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 11 Jun 2026 20:06:56 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wXi8F-00GYrD-7V;
	Thu, 11 Jun 2026 19:19:51 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 19:19:50 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id f116401b;
	Thu, 11 Jun 2026 16:19:50 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Junio C Hamano
	<gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>, Tuomas Ahola
	<taahol@utu.fi>
Subject: [PATCH v3 0/3] doc: config: fix AsciiDoc glitches
Date: Thu, 11 Jun 2026 19:19:43 +0300
Message-ID: <20260611161946.12166-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260610185148.23920-1-taahol@utu.fi>
References: <20260610185148.23920-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-09.utu.fi (130.232.247.49) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhdSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFleSAIGRgke
 AQQJKA4aDQ1GDhpIWEhbWkgDGgEbHAcODg0aAAkdDxsKCQMDKA4JGxwFCQEERgsHBUhYSFlbSBgNDg4oGA0ODkYGDRxIWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=eHMExwjg39b89WH/C36YIeT9Sav9W6gNGV9TFp88ZN8=;
 b=olHw4aH4IiAGaHl1P7RW00xj8TmE2UYg+/8oKGSOKBpS5rLCgyb91jYpMK+NU4QDSh2tSzIitX80
	8jhxQ5hTQaFp4I4Lj6JwP1NW0uAbdU8iiqVyPiPjyqI2TfgbVWclNOXRDtbAqsZW6jWdrEs33wmz
	hrJAh+BAodglUsDCo/7KPuCZfjlpzZCB8rt+Crp/XzJh75R6v2oNKB4WJOV6dAb4iD5Z1rQ0TBs7
	Gzf4bhvX2XvyovCsQnHb3d/rZeLNm6YE1Ri8NaJBauo6Tcr5DjWlb6DXT2tXOIgF1D5KQJwRUOzG
	8ShmVd3QmU+oe6ZgCIVlOd6+3rnLVCIdlxY9JQ==

Fix various markup shortcomings in git-config(1).

Based on 29bd7ed512 (The second batch, 2026-05-12).

Tuomas Ahola (3):
  doc: config: terminate runaway lists
  doc: config/sideband: fix description list delimiter
  doc: git-config: escape erroneous highlight markup

 Documentation/config.adoc          | 4 +++-
 Documentation/config/promisor.adoc | 2 ++
 Documentation/config/safe.adoc     | 2 ++
 Documentation/config/sideband.adoc | 2 +-
 Documentation/git-config.adoc      | 8 +++++---
 5 files changed, 13 insertions(+), 5 deletions(-)

Intervall-diff mot v2:
-:  ---------- > 1:  c9131b23fd doc: config: terminate runaway lists
-:  ---------- > 2:  ca65211ea4 doc: config/sideband: fix description list delimiter
1:  0341a4bde9 ! 3:  e2d0cc8218 doc: git-config: escape erroneous highlight markup
    @@ Commit message
     
         Paired octothorpes are used in AsciiDoc to mark highlighted text,
         <mark> being the equivalent HTML tag.  To use the symbol as a literal
    -    character, it can be escaped with a backslash.
    +    character, it can be escaped with backticks.
     
         Do so in git-config.adoc.
     
    @@ Documentation/git-config.adoc: OPTIONS
      +
      If _<message>_ begins with one or more whitespaces followed
     -by "#", it is used as-is.  If it begins with "#", a space is
    -+by "\#", it is used as-is.  If it begins with "\#", a space is
    - prepended before it is used.  Otherwise, a string " # " (a
    +-prepended before it is used.  Otherwise, a string " # " (a
    ++by `#`, it is used as-is.  If it begins with `#`, a space is
    ++prepended before it is used.  Otherwise, a string `" # "` (a
      space followed by a hash followed by a space) is prepended
     -to it.  And the resulting string is placed immediately after
     +to it.  The resulting string is placed immediately after

base-commit: 29bd7ed5127255713c1ac2f43b7c6f257d7b4594
-- 
2.30.2

