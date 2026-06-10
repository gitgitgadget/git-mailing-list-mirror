Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A89E3451CC
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 22:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781132129; cv=none; b=JCTQTwEAVZHo47h763+xcQexDjijFRtv4mR+96kw8j469x7V2AY/FKCjQT7f9lyBLywCetV43TuqPh6/9sPL/PhpCRIArTQCSzTEn07Qx5jzkeD3M5n4H56esldFnGyPN3oOIAmJqUkxY4hxJXyvIUjb+0AQnmYXiiUffOZMfAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781132129; c=relaxed/simple;
	bh=tJYxAIfT89B78eQ8NrEtqc1DMSZbJ2lFDwfrIvlGQq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2gfsU4IGXnDvZpqI+FIA1uQtBVVXMeMv85N6ZDloH7ph5TzPyAEuuRKxogF0HjiaaCqcVVhApA54KZ/EXeoWUOVzbZMOge9rIx+f56zF7A8uaHRhbXi49B5fN8mBtGHO7g0vHmGphlDBfQo9M/iwp2zPxeEJluS+/9U7E9023Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=KW671gMZ; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="KW671gMZ"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 65AMtI57032435-65AMtI59032435
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 11 Jun 2026 01:55:18 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wXRpN-00ERzd-Vy;
	Thu, 11 Jun 2026 01:55:17 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 01:55:17 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 207dda17;
	Wed, 10 Jun 2026 22:55:17 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Junio C Hamano
	<gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH v2 3/3] doc: git-config: escape erroneous highlight markup
Date: Thu, 11 Jun 2026 01:55:13 +0300
Message-ID: <20260610225513.6269-4-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260610225513.6269-1-taahol@utu.fi>
References: <20260610185148.23920-1-taahol@utu.fi>
 <20260610225513.6269-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-12.utu.fi (130.232.247.52) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZbWEhQSFhIWEhbSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFtaSAMaARsc
 Bw4ODRoACR0PGwoJAwMoDgkbHAUJAQRGCwcFSFg=
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=VBC3R04gS/slm+5mpS1SHSC8N8Lmp5kmO3RyNDAxE34=;
 b=KW671gMZnXQ56l5Buh+VUuiCuy2kvarQWK7ZSmjy29zWrFreTEXKB+FlZelhUT2rEMZJxe3KKuwB
	8ozbJW4LQJgpQeUF+5pnu3oYMSAHRa4sROqSDmsssraA56ZDmszID0l4qTiCJZNkI8WwzrYu126l
	FNoOGunoPXTYpopp0uP/QEFyK4I3Y7Lw4bXQpCZXA7duTIDlR0MkBIBxHuDMypignvWOFmnIFpnw
	RyllpCJU/R/99SQnqZTvYEO9SR098h2NmJq2BSTzIl1+lxZWIvLripy85A8b43k6R40u6o65XVdr
	CYgvOLyDDq9DF2EVBZ3rWoRvdAN2DPT+QU2wPA==

Paired octothorpes are used in AsciiDoc to mark highlighted text,
<mark> being the equivalent HTML tag.  To use the symbol as a literal
character, it can be escaped with a backslash.

Do so in git-config.adoc.

While at it, tweak the text slightly to make it scan better.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 Documentation/git-config.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index 8439ce97df..e4af6cac68 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -119,10 +119,10 @@ OPTIONS
 	Append a comment at the end of new or modified lines.
 +
 If _<message>_ begins with one or more whitespaces followed
-by "#", it is used as-is.  If it begins with "#", a space is
+by "\#", it is used as-is.  If it begins with "\#", a space is
 prepended before it is used.  Otherwise, a string " # " (a
 space followed by a hash followed by a space) is prepended
-to it.  And the resulting string is placed immediately after
+to it.  The resulting string is placed immediately after
 the value defined for the variable.  The _<message>_ must
 not contain linefeed characters (no multi-line comments are
 permitted).
-- 
2.30.2

