Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680647346D
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875791; cv=none; b=CesqwFGhZUtys3Ne2koufXGSvwM6zbZwcF3IGUyX5/3MPLCWWaXetZvDV5HPDgY4Jqn3wTwcjH7HAPmh2OeI9h/PNiYpIT0qCOy3H+a2HzeTj+Vrv0BfPGTplAswavk31RL7ccFpdS4J80MI7qtVTuqAFSEMyGg4YvfosXRSKQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875791; c=relaxed/simple;
	bh=9Omf8NmvYYYfmDh4bh5k2mHmOzwaNeEv4r9cgVaWPhA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CcV6UsLK1wbbkicHE4b7+oMfqJ7fM9UrpekLaAHPV8i/IDQ55Zp/9gfEE+l+ST96hjjuxSz/IOSDNOuHhZYii76miG1GxP0K+mX8LsuzXwUAP+oaXWUPQXWiy/wT3ldYPNElQ+8okyIl28hoZGcRfSdgOcauKSkAGrR7CTWUVbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B923532l; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B923532l"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso3959886a91.0
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 07:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741875789; x=1742480589; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Omf8NmvYYYfmDh4bh5k2mHmOzwaNeEv4r9cgVaWPhA=;
        b=B923532lAEv+N6/9sBb+o8MYFShDBERfngUYvFDCH0R61LbDh9XfqGaoO01B/ur2Bl
         3P3uuytAeBCxJ9eCB+DfazLE3BdwotmwWtjb6I2uPIWHwPievd9u1yFSWSEXLGvfyWyZ
         o3Q+ePTdHGsc8l5SZxMQJf+EO69TB90hlShsz2ewJwAsv5GlTMCdIzH+la8Zqt2e/IE+
         hgxCsEHSnzUBVh6Wd4FWwG5SDUFK9IEzZfOTXqNwjLtB6ELpnK0UrcbN5eUd6TVH3/Pa
         SSDIXEXeMEjkZu13Spsn+fGga/VBKXX2dRlyJ4irQcpPg86D2lrFIlx98OAXn4sJNUOB
         nSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741875789; x=1742480589;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Omf8NmvYYYfmDh4bh5k2mHmOzwaNeEv4r9cgVaWPhA=;
        b=AzZad1qrWGykZRY6evojyGb9bkve4HYgkPDvFfQNFXyMTyKeKhYJYJmd+oy/0fHNHr
         Q5PGaalib6mpFQv+XA4E2S7Mwi1NHI8XXahFITqZ2rLKQv3nwmc+PhwPVOkvHjld2JyJ
         XABoP/+eotFzKejeTXn18xXNEkQXnKRMLHINFz3GauKtVSUyjSp54wbwIbG05u0YIQvD
         iRNohiW0Kczp7/9im/yRCfaFjKSNbCggBBalwUdjywMjq1Hm6daMgSx0f1hZfTnZTbg0
         RWF8BVlqkWLfG7qdcddchDmKMLKfDTPs63wmNpzibWv2lmZOLETgUGdc4CLWUmVyKAnI
         NWtw==
X-Gm-Message-State: AOJu0YwgW4BxQtKnha2ZWsxvZCiNFLXbyzJK/nM4qOqiDH5lPA50XXsq
	qfJEJXz7zPTzW5Lm7953peDYR5qb3cWsgqVxRrHlfXgydy6MFf0SVyEh7Q==
X-Gm-Gg: ASbGncuyOSYaTrrzpZ3dian9RHJfWKhRSKThs8/QqtiXlb3RLtzoPS4oxSS9T6qys1a
	rZwWMc7iK5wM2GZBRX6L4i1HjCRC8x+//sRkWimpF9pBOIXQbpqz+yjbA6CKGddXQFMbZodBoZ5
	ZKiZOFCf+F9RTemYBKDFUYzyJ6FyKmBDEruluiE+ymXO4xIAtSYS1XjD0LmHgtGNpF9Fa22xUwd
	uj+yccktrXDC5NwgRsHROEvnpaVvq/DLrLuNv5N8Tc8JLkFtdClEKsLTMiDmfK6wstteZM0w6+x
	AZ/H0xaBpUfFV0fycLgZLUSu0Cs5ROyeaJ/knHX3xLlLQI4UG1y/qQLuIRb9DDgC2QRxRBv0t/a
	HqY9KhlM0KGVyvUv9gFfVeVwlXgGFs/oTI0W23Xo1nn9o
X-Google-Smtp-Source: AGHT+IEXRjzS9CEcRP+JLQ4VPjHVUeeEwD+lyQ7huUbZc1Oj+P24zCVmysx6w/z2bz6ztH5GR3cy4g==
X-Received: by 2002:a17:90b:54c3:b0:2ff:5267:e7da with SMTP id 98e67ed59e1d1-30135e90d69mr3649786a91.3.1741875788825;
        Thu, 13 Mar 2025 07:23:08 -0700 (PDT)
Received: from SEZPR01MB5486.apcprd01.prod.exchangelabs.com ([2603:1046:101:ae::5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30118235140sm3867959a91.14.2025.03.13.07.23.07
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:23:08 -0700 (PDT)
From: li li <li0371859@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [GSoC][Patch]  Add more builtin patterns for userdiff: Add builtin
 patterns for Verilog
Thread-Topic: [GSoC][Patch]  Add more builtin patterns for userdiff: Add
 builtin patterns for Verilog
Thread-Index: AQHbk75PsV8GEPCQWkeMGblyFYTKGw==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Thu, 13 Mar 2025 14:23:05 +0000
Message-ID:
	<SEZPR01MB5486F5B360F1DFA607C69F37A3D32@SEZPR01MB5486.apcprd01.prod.exchangelabs.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Add Verilog built-in to userdiff.c. I read the code and checked the previou=
s mailing list. I found that if I want git to recognize Verilog syntax, I n=
eed to add Verilog regular expressions to the userdiff_driver array of user=
diff.c and modify the .gitattributes file.=0A=
Yes, I did it.=0A=
The next step is to write test cases and submit patches.=0A=
I am not sure if this is in line with the development process specification=
s. Maybe I should make some adjustments. If so, please let me know.=0A=
=0A=
=0A=
diff --git a/.gitattributes b/.gitattributes=0A=
index 43fa883a84..8aac8574f1 100644=0A=
--- a/.gitattributes=0A=
+++ b/.gitattributes=0A=
@@ -6,6 +6,7 @@=0A=
=A0*.pm text eol=3Dlf diff=3Dperl=0A=
=A0*.py text eol=3Dlf diff=3Dpython=0A=
=A0*.bat text eol=3Dcrlf=0A=
+*.v text eof=3Dlf diff=3Dverilog=0A=
=A0CODE_OF_CONDUCT.md -whitespace=0A=
=A0/Documentation/**/*.adoc text eol=3Dlf=0A=
=A0/command-list.txt text eol=3Dlf=0A=
diff --git a/userdiff.c b/userdiff.c=0A=
index 340c4eb4f7..9f7e4c427d 100644=0A=
--- a/userdiff.c=0A=
+++ b/userdiff.c=0A=
@@ -336,6 +336,13 @@ PATTERNS("scheme",=0A=
=A0 =A0 =A0 =A0 =A0"|([^][)(}{[ \t])+"),=0A=
=A0PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",=0A=
=A0 =A0 =A0 =A0 =A0"\\\\[a-zA-Z@]+|\\\\.|([a-zA-Z0-9]|[^\x01-\x7f])+"),=0A=
+PATTERNS("verilog",=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 "^[ \t]*((module|task|function)[ \t].*)$",=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 /* -- */=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 "[a-zA-Z_][a-zA-Z0-9_]*" =A0=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 "|[0-9]+'[bdh][0-9a-fA-F_]+" =A0=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 "|<=3D|>=3D|=3D=3D|!=3D|\\|\\||&&|<<|>>"=0A=
+ =A0 =A0),=0A=
=A0{ .name =3D "default", .binary =3D -1 },=0A=
=A0};=0A=
=A0#undef PATTERNS=
