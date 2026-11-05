Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903969;
	b=zU5nuYhCU8Qx2g8lLLhjeI5Kh2MAkn4tuxV5ZlJItd5nPzsbEbvPLFNO6cHGlselF41G
	 grPaXf98Dsh2zyRehCsCzF5A7nw2fvP3HVehqLaEEvb9FvIjJk+AS4J+FqzheliiJN8di
	 tvBbERjvBDDMoiF9L2UdvAFcniyKjwBhZ7HrQfGabaso7VLUw5resjjqPzs2rDdUkdXtC
	 KAfgG2Q9dERp38ZW0ngKaqH64ZjZtAzYEPXzzp3KgSiSa81FYcDb1jI5Cc/93HtiyQ8KH
	 zgQjzhBeJ1nnaKLQnQEJEO3yjsPWW1jid/+JSKQwi0u6Q2JOeEb61mqXV5nyYahAP5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903969;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-FEAS-BEC-Info:X-FEAS-Client-IP:
	 X-FE-Last-Public-Client-IP:X-FE-Policy-ID:X-FE-Hostname:
	 DKIM-Signature;
	bh=E9zMZRphkpAL10VRfrni4apyLjglYhXD1MK31rwQo+U=;
	b=AWizV4GT2+nRRltXvtilvFfFUeQxG/5naGq8yuhAkmmXP0gcJtI8yqfQzi7Y06i9YL/o
	 hmclQfH5ZHDs+ZyKtPuryRVAFiDemUM/3KBpXlTUG++suh4OHgx6n7eRZVYQWB7cf0ysW
	 BwgSn7z09BEMiLqtbkOzCRJwobnEKQkrlmltlSleP4Bl718f2uNZ1KW0/eVBpjRjjveQA
	 u8o8etiaaTJjRXAJ2p7MmxQeDO6TqApYlfUFjAWhSNAIz62uU4WP6mR4GGH36/zjyAMYz
	 3bu3mhkVtnU4E5gXhxvH8LFXOyryvIVHU1C1rX0fkPOfnKzZNYD4l1yNi61T9+AT22A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=lw0+AXTn;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444E2606A326
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 18:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 444E2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=lw0+AXTn
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 6A5IdHFv031889-6A5IdHFx031889
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 5 Nov 2026 20:39:17 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xP2Mn-005F9m-C8;
	Thu, 05 Nov 2026 20:39:17 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:39:17 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id bca31b6d;
	Thu, 5 Nov 2026 18:39:16 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Junio C Hamano <gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>, "brian m
 . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2] CodingGuidelines: update the required Perl version
Date: Thu, 5 Nov 2026 20:39:00 +0200
Message-ID: <20261105183900.28597-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20261101185846.24208-1-taahol@utu.fi>
References: <20261101185846.24208-1-taahol@utu.fi>
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
X-ClientProxiedBy: ex19-14.utu.fi (130.232.247.54) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhaUEgbCQYMCQQbKAsaHRscERwH
 BxwAGAkbHA1GBg0cSFhIWkhZXEhZW1hGWltaRlpYX0ZbWEhQSFhIWEhbSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhY
 SFpQSBsJBgwJBBsoCxodGxwRHAcHHAAYCRscDUYGDRxIWA==
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=E9zMZRphkpAL10VRfrni4apyLjglYhXD1MK31rwQo+U=;
 b=lw0+AXTn/LkItpFRiINqvodurj6GyT2bEUxnaAs6ZZMGDSB40uR5h2HlldgV7ZUOl/7bh/36Fo2L
	UURfgqYOh93STDMTeCvffcIcUMy3FP/GjNXlB8YeNCWkLvz3+W8NJBUke8Oe12M10aB4/yKt++g/
	y7TIi68mqTr8RfAExK7UgeHMM0quQzJpi3P4aWVpL4GeHYMTJOk6+vsKE7WxeJzxFO2U5vnoXvld
	TtIg7L1CnblRAffqUlQbuYtNAKJQuPJfuKXcrNGXpEVZsyK6ifM9FqAaxY3XE5oeHKknQtb3gfdR
	cz24iQMOSPhktqfCaHT2cwzASC8gdjsf5vByuw==

702d8c1f3b (Require Perl 5.26.0, 2024-10-23) bumped Git's Perl version
requirement and migrated the codebase to use "require vx.y.z" in lieu
of "use x.y_z".  Update CodingGuidelines accordingly.

Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
Intervall-diff mot v1:
1:  d18ca7697d ! 1:  70e2656643 CodingGuidelines: update the required Perl version
    @@ Commit message
         CodingGuidelines: update the required Perl version
     
         702d8c1f3b (Require Perl 5.26.0, 2024-10-23) bumped Git's Perl version
    -    requirement.  Update CodingGuidelines accordingly.
    +    requirement and migrated the codebase to use "require vx.y.z" in lieu
    +    of "use x.y_z".  Update CodingGuidelines accordingly.
     
    +    Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
         Signed-off-by: Tuomas Ahola <taahol@utu.fi>
     
      ## Documentation/CodingGuidelines ##
    @@ Documentation/CodingGuidelines: For Perl programs:
       - Most of the C guidelines above apply.
      
     - - We try to support Perl 5.8.1 and later ("use Perl 5.008001").
    -+ - We try to support Perl 5.26.0 and later ("use Perl 5.026000").
    ++ - We try to support Perl 5.26.0 and later ("require v5.26").
      
       - use strict and use warnings are strongly preferred.
      

 Documentation/CodingGuidelines | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index c06f5d3071..bc0470c154 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -703,7 +703,7 @@ For Perl programs:
 
  - Most of the C guidelines above apply.
 
- - We try to support Perl 5.8.1 and later ("use Perl 5.008001").
+ - We try to support Perl 5.26.0 and later ("require v5.26").
 
  - use strict and use warnings are strongly preferred.
 

base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
ta/cg-require-perl-5.26.0

