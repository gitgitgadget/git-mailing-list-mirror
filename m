Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559534;
	b=XUe5MPVop+rKnu8EnnvCF32/opaOGlzyd2RuCo6O24sjQhYIZ+DwiGIxqQxNAaqf2mvl
	 xCIqlHwcJol56pf/rOLWsDginLrrYgZmL3F+TVgUeXp8Ei5IiJonZX/XCgS2HzwcCQWui
	 eeLb3qIkxE7VKYhX6WdQx6LYhNCpFZn1xP4lqzBWgID9OyiyrwMHfx/p0Xv75s8g7woGw
	 wyzJFb6f+ww4GZTYXgb7qWotVGU2UUldYW6LoJkeXvqnlNkuCL9pBObTWQkiIqGScu9bO
	 EkqhBKAi+SKQQ77rNvIdrrOszspEz9RqCWDQ8LzP8h1LKb3UgAXq9OwzcNqk/s5v9Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559534;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=Z39gp7u6jqifp/N47Fh6Yg3Zl7dRpW1JaaE5JgnHiB8=;
	b=WvKxpvbvd0jDbempNhGM18VWH1C6XRgRKLiJfr98BZ78IxENvp/eGOX8/yM0v4niKJlI
	 0uxfBUDqVY05Oeje7wmwweQRXyuKnbRZCYhRccmfPNlt57XuZdchdfMmuY7+AA7EjxiJK
	 5/napY8bZkRursGUSJiyoei24N0+CrT4U8FxfWg36zdxAWwCxGwrZtsRgft0PGH4cxjyy
	 9yK/CmKsYbKpN6hTBfQpnzimU/E92HQqO2jSjyhkiDdFh2TDE7njjes5BVJveaEXVvWs/
	 bH4exY6GkXBDiRqzUEynR9Q4WPdjq7JLLJPxpssyA57aiyHt2weHEE57Bc7YGhqncvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=K+lxQZD4;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FE7606A325
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 18:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64FE7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=K+lxQZD4
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 6A1Iwmeh005213-6A1Iwmej005213
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 1 Nov 2026 20:58:48 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xNalU-00G6ng-NA
	for git@vger.kernel.org;
	Sun, 01 Nov 2026 20:58:48 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 20:58:48 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id aabd9da0;
	Sun, 1 Nov 2026 18:58:47 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH] CodingGuidelines: update the required Perl version
Date: Sun, 1 Nov 2026 20:58:46 +0200
Message-ID: <20261101185846.24208-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-06.utu.fi (130.232.247.46) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhZSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:mime-version:content-type;
 bh=Z39gp7u6jqifp/N47Fh6Yg3Zl7dRpW1JaaE5JgnHiB8=;
 b=K+lxQZD4pOiXq3vMfKXMqyyfjufu6Z6lkEuQfUkcfxsOlksv5nezyfTU26rLKTazHZqgYo1QLScb
	42lY3fZQHx2xjpEHm+/fkoGAwVzdxMHfwCvClmZ/S6xkyoJGkNap5Uas3oJ9kms+X9efikgebesk
	Go+J/nPDE5BeeqmII0Yz/5Gh+PL18L+OhrELhgK6IKP9PoQtbnTaWLBJK6lHgXPlhBqtvaRq4DCB
	RBHn0CISGI8XE1X87MAApKQ1DSHpTu0y5mOpzJo5edF7v8wR42h1ZBM6IwNHHpHOdRfHBPY4L/ID
	0BYN3KoEt0eILjsp7x+CEEl97IBtrZ2A5kvo2w==

702d8c1f3b (Require Perl 5.26.0, 2024-10-23) bumped Git's Perl version
requirement.  Update CodingGuidelines accordingly.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 Documentation/CodingGuidelines | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index c06f5d3071..9b17ab34db 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -703,7 +703,7 @@ For Perl programs:
 
  - Most of the C guidelines above apply.
 
- - We try to support Perl 5.8.1 and later ("use Perl 5.008001").
+ - We try to support Perl 5.26.0 and later ("use Perl 5.026000").
 
  - use strict and use warnings are strongly preferred.
 

base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
ta/coding-guidelines-perl-version

