Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CD8383313
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197664; cv=none; b=u2LGxEszW+ng0xvnBnHDRDr5NoWfFz5nJrm5+m8/XeZZAKutKFIUIo2ymYQ9DuMAe2IqgTKDYjUCdXR2oNqwXaaOi776wgWqSHaYF9mGFc+3CBuSe61ep8CDihsnMKTBktTggqKdMrfqUTR4jZcuqtWUbzxUHh58qzYMj7o9FmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197664; c=relaxed/simple;
	bh=GnGRMBaQu5GDGr3AW7ncjcdqJnd8CWiZIIW9h0QEgBA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJG9yhxfK+4Ykk7+waetWq39T8iFzagDxtzFQ8WvvsBxkTSfXDUGI+W1q/KCZXPZrVXPtYqOogm/boptZIBbAt7+Wy8MY5vggEEj8xd9tpt4aIlefUtAdDZcJmvcbl91nFtnu3KgtiORqRGzh8bhO2+AdeUs2IY472W88WWuPug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=H1nX4ETV; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="H1nX4ETV"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 65BH7WpH007277-65BH7WpJ007277
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 11 Jun 2026 20:07:32 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wXi8M-00GYrZ-Hv;
	Thu, 11 Jun 2026 19:19:58 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 19:19:58 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id b5adc188;
	Thu, 11 Jun 2026 16:19:57 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Junio C Hamano
	<gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>, Tuomas Ahola
	<taahol@utu.fi>
Subject: [PATCH v3 2/3] doc: config/sideband: fix description list delimiter
Date: Thu, 11 Jun 2026 19:19:45 +0300
Message-ID: <20260611161946.12166-3-taahol@utu.fi>
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
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhbWkgDGgEbHAcODg0aAAkdDxsK
 CQMDKA4JGxwFCQEERgsHBUhYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIXUhYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYL
 BwVIWEhZXkgCBkYJHgEECSgOGg0NRg4aSFhIW1pIAxoBGxwHDg4NGgAJHQ8bCgkDAygOCRscBQkBBEYLBwVIWEhZW0gYDQ4OKBgNDg5GBg0cSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=MRGIvgkPA++2oEuPCeFFhhbs1JY1Eg5zZu7boTh/IMo=;
 b=H1nX4ETVwbxWeIjy2PLTTOtdTxU208pYG7PRiq5dcOQ4GIMYFfM95vNkV5poT0/u7B4bkvNZ1792
	nnG3VtxyOR3ZQvOaB0fDdwnmOduGr6rFUdYgZaMGm2qgl6MDzofvj5IUbnrAwx1VVf2+ztGF3mPR
	CZY+Ju3ENq3/ShDyliYCE8mgizNzK/dbu82W3DEAaE7ftGbwCYDxTz8iFqtSFiUT3XRSCKf102/G
	jCPtAhL7adUV650QeNaXshKvseqKL/CzAFWWqND50LRa+ztHJq8ZP51a6wZpbTqrORci1+raFczB
	vdOwFi3KgDp0ZSPUU63AuW6YW8Hjv6Y0vOgbYQ==

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---

Notes (doc-diff):
    diff --git a/c9131b23fd1c8611fde5664fcfd4e6d5283648ad/home/taahol/share/man/man1/git-config.1 b/ca65211ea4c351071c5e76dabe4700ad074b75d3/home/taahol/share/man/man1/git-config.1
    index d915897ca5..e0e2bf3c36 100644
    --- a/c9131b23fd1c8611fde5664fcfd4e6d5283648ad/home/taahol/share/man/man1/git-config.1
    +++ b/ca65211ea4c351071c5e76dabe4700ad074b75d3/home/taahol/share/man/man1/git-config.1
    @@ -6827,8 +6827,10 @@ CONFIGURATION FILE
                color
                    Allow ANSI color sequences, line feeds and horizontal tabs, but
                    mask all other control characters. This is the default.
    -               cursor:: Allow control sequences that move the cursor. This is
    -               disabled by default.
    +
    +           cursor
    +               Allow control sequences that move the cursor. This is disabled
    +               by default.
    
                erase
                    Allow control sequences that erase charactrs. This is disabled

 Documentation/config/sideband.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/sideband.adoc b/Documentation/config/sideband.adoc
index 96fade7f5f..06de0d5c07 100644
--- a/Documentation/config/sideband.adoc
+++ b/Documentation/config/sideband.adoc
@@ -9,7 +9,7 @@ sideband.allowControlCharacters::
 	`color`::
 		Allow ANSI color sequences, line feeds and horizontal tabs,
 		but mask all other control characters. This is the default.
-	`cursor:`:
+	`cursor`::
 		Allow control sequences that move the cursor. This is
 		disabled by default.
 	`erase`::
-- 
2.30.2

