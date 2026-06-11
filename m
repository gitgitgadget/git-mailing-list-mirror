Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DB11BD9C9
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194819; cv=none; b=JQt6QcZmxEhy1nM/7uWKO+OKyks54PWSHL2FUdD+2MDqvLp09rjHxRjhOk3bj9TFWvoKbPUAChCZUzCGjgGaIQTEUkf+hGa2ZAHPW9ym81oUD7cMbIA4bZhvHoG0P/x34hq1ZxGXtOc3dHlNkuY8sKk9UZxxaJPCKEin5W1dP1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194819; c=relaxed/simple;
	bh=0IQmpQ4KowCakoNOOqC7h8Et8gq5IwVIEPae+j5Evss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+IeSn289NpXNQLT2RHJ3Z7QB5FXFopeNfnSKjP/Lj/CVY7aLmhj7hDJZuI7yc7qL+RFPVoUJy5gW8qsXlKaqdqU42hREG9xmU7025wCDV6GxY2mX1q6estep7AsUDqeGdFq7ZovMwpSJIyB2uJAGOITXQj7gI96BdKXJ83t+ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=lk/xy/AB; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="lk/xy/AB"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 65BGJwcS011694-65BGJwcU011694
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 11 Jun 2026 19:19:58 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wXi8M-00G7cg-RD;
	Thu, 11 Jun 2026 19:19:58 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 19:19:58 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id a40fb79e;
	Thu, 11 Jun 2026 16:19:57 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Junio C Hamano
	<gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>, Tuomas Ahola
	<taahol@utu.fi>
Subject: [PATCH v3 3/3] doc: git-config: escape erroneous highlight markup
Date: Thu, 11 Jun 2026 19:19:46 +0300
Message-ID: <20260611161946.12166-4-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260611161946.12166-1-taahol@utu.fi>
References: <20260610185148.23920-1-taahol@utu.fi>
 <20260611161946.12166-1-taahol@utu.fi>
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
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsH
 BUhYSFpIWVxIWVtYRlpbWkZaWF9GW1hIUEhYSFhIXUhYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWEhZXkgCBkYJHgEE
 CSgOGg0NRg4aSFhIW1pIAxoBGxwHDg4NGgAJHQ8bCgkDAygOCRscBQkBBEYLBwVIWEhZW0gYDQ4OKBgNDg5GBg0cSFg=
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=6RHvUUeIdBsbL2amnp397TLi+lKpqOsQRNkdzL3DxBI=;
 b=lk/xy/ABSRSl3k0RB14kKvtAbNTTkY+5+TFAF8B5LYoOzdy0YzsVahAECETe4g6OWY3rajKCuuBT
	tdzYCwSBGmjHO5hPailpoSGiSaaBd4styi6l/F0ADBDClIAnTlyiU3G0A7Fqji5OVeOh864eB7I7
	V9QV/pxT7H1VYwvBGoBGYSYTSJeOUaHTFsIBVcSQB2fg4dXlvojGbMhL1VCSbGxEEClnbyz7ffvv
	bKhrz8evSnZ98YfZA2K/r8kEagoCYnPwZhs1AOd1D7Y786pIMOnryJf59wDfxf6vg9WV6CrgmuFy
	ZH5CsSW9S/vkkrsniyVU7JRA79SOqpYEYqvklQ==

Paired octothorpes are used in AsciiDoc to mark highlighted text,
<mark> being the equivalent HTML tag.  To use the symbol as a literal
character, it can be escaped with backticks.

Do so in git-config.adoc.

While at it, tweak the text slightly to make it scan better.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---

Notes (doc-diff):
    diff --git a/ca65211ea4c351071c5e76dabe4700ad074b75d3/home/taahol/share/man/man1/git-config.1 b/e2d0cc8218242cc859daabb179af07ebf96fe459/home/taahol/share/man/man1/git-config.1
    index e0e2bf3c36..1e9e49b197 100644
    --- a/ca65211ea4c351071c5e76dabe4700ad074b75d3/home/taahol/share/man/man1/git-config.1
    +++ b/e2d0cc8218242cc859daabb179af07ebf96fe459/home/taahol/share/man/man1/git-config.1
    @@ -113,11 +113,11 @@ OPTIONS
            --comment <message>
                Append a comment at the end of new or modified lines.
    
    -           If <message> begins with one or more whitespaces followed by "", it
    -           is used as-is. If it begins with "", a space is prepended before it
    +           If <message> begins with one or more whitespaces followed by #, it
    +           is used as-is. If it begins with #, a space is prepended before it
                is used. Otherwise, a string " # " (a space followed by a hash
    -           followed by a space) is prepended to it. And the resulting string
    -           is placed immediately after the value defined for the variable. The
    +           followed by a space) is prepended to it. The resulting string is
    +           placed immediately after the value defined for the variable. The
                <message> must not contain linefeed characters (no multi-line
                comments are permitted).

 Documentation/git-config.adoc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index 8439ce97df..57af010ade 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -119,10 +119,10 @@ OPTIONS
 	Append a comment at the end of new or modified lines.
 +
 If _<message>_ begins with one or more whitespaces followed
-by "#", it is used as-is.  If it begins with "#", a space is
-prepended before it is used.  Otherwise, a string " # " (a
+by `#`, it is used as-is.  If it begins with `#`, a space is
+prepended before it is used.  Otherwise, a string `" # "` (a
 space followed by a hash followed by a space) is prepended
-to it.  And the resulting string is placed immediately after
+to it.  The resulting string is placed immediately after
 the value defined for the variable.  The _<message>_ must
 not contain linefeed characters (no multi-line comments are
 permitted).
-- 
2.30.2

