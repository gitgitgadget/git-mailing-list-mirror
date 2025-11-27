Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFC1271451
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 02:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764211103; cv=none; b=ueyikEauunE7WMWkrw1Ryc0ueVcTkLfr+21nFp29/dTGL9AH76s+oh2lmMVlSmEYN493IV0ezBl7Sir52c2QxHBFdlx5HBCVjTmH/iDigCmdEtU0fWY+C7ogEDwa/HCd40yjLfPMOUmoKyH6YNfkgTboJgsyaQxSRmGk7nxVA+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764211103; c=relaxed/simple;
	bh=+lh5fQrDbkinhZHuRy2X5UF8wcimD7dLKxRaydIKzsc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ls1cyfq7bzWSgPj73/UxGvyfRwd+JmM5aN2Is4+JdPAZ8yUeu38cf/+nuINvO2YKdW8XjQnFFNu85T0QqNE7ROMEHS7A+hvYf2RzWUHSkqH0ij+Q5TWCh2m+eeBuZ/aGoGyGrFsML1TA8V136fGE57Ivt86uTuEkfY1Q4U1M2Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbVXqyyZ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbVXqyyZ"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3436a97f092so478899a91.3
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 18:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764211100; x=1764815900; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fTubhSHNpP6L+VkYEq3mTY6wjQz8EDfajSuKmL9nQk=;
        b=UbVXqyyZDWs8wCZoQYF19DDB6KUVAlxCeKwQG6jEu6B8j82BpJuBTXqQFXJtWxiYGr
         NSGSk0EQTgZXOgEqEMhAMPQB6WN6gMclFkr0fU6o5QQosQM0z9Jz3iB1+elz9eKYAGzd
         ztC5XQ1wdXyX6WMq/pu2hUcpW1E6QRyHjkpLJI9LflHH0WWZUAKF32M3iHenJQBjO3cM
         RXGl5sA3sRSYtWSU8BEZHldraOm71nkJbGj2dUtMsGPlaCmXHsgPi6Pn58WQN1sRC6Xp
         REUtnjlXuwK/PmXXVsPQAsvz2Nq7vbRwyB1ZtzblwQMavZhfKfnxsxAVcTrE8HeJuqsN
         6cRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764211100; x=1764815900;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/fTubhSHNpP6L+VkYEq3mTY6wjQz8EDfajSuKmL9nQk=;
        b=lv9/PK9c1xv/7J9rgfOHQLi6CHkwPGMOd/BSo6esQY6GPTpkBG5RynnLm68vYtgeam
         shgVA5gct+h+0vFhRFwKhW8M23UewmcnUUBc7RaYts6eRw4k1lnjatOqn+XqilKB2Z+9
         dA/ZC7uUL8gWVtMMedU2jE1CxgZ+KgejAdGFVSKWNHGoLyMkYTXR4YDbst6NFQTm9Jru
         yEVN+5SIJwjTQp6vnyfmC32zbWkF2Kn3yIKHcJ1ZmnOzMDOH9BA6Ost7NTEQkrZWG2lY
         yXAF6kotgkVHiGgtM24FQq13cKPXh8xmSLpDX9sM6AR7CNAmT1dQEfefoTWXvMAxQkcB
         UKew==
X-Gm-Message-State: AOJu0YzPOMLvvbx6/A98xzoCV5nmWF8PZQeobg2hkdLYa3A46+XFcRqo
	bU0JzYaDDoTVIanS56CngMadMtQupCY4EqpIRbcGz2EG1kX0NZRBDJBJzHojymPq
X-Gm-Gg: ASbGncu8/haGmogIAtt8/7+lMhAXFyBI/UzYrArYPHnlWkbrGOGVbQzHNtjbaj75CKq
	h19sPWl2mLYbqWqTNKC3BAXnk9IsGueDzhareGsk6xTRI6Hh1CqYkAPgFQ8ZgDKC87fYsyUG81Y
	OaxXb403vj8TTKZj9Hnjl6K42FpyRQe8Zi5VShERiXRrtP7vtUyeb37rWN2BOH+Vu5/1t/vfYZi
	IGgvxWavgmSaJRDQqNkdZRH7tOpa/Uuwuue7GZ5fBft3B5ZUyz3QSif1OAZRx+85zjxN4TtkaIc
	Z1z/Y2XEgZrsHaYu7BWJDMJ5GS8RS6mOCsoH554amiuIX9FT97Vi1r/GDy8ShRSow30g8ar790R
	GtEOGA4lFU7MNWXJqilf7FqGgmHMhnaDY1K6DpCVxKzA7s0REHuXuV+TmbldH+xIpblQEmujSyV
	DgcFwFQWsS3I8=
X-Google-Smtp-Source: AGHT+IEkqAUUHyBE9M/co+vnLkHIe2fD7e1gTriXkONe3Sws+5JQSERCdcZdrd/jj1AB95qz+6+Cpg==
X-Received: by 2002:a05:7023:b89:b0:11b:3742:1257 with SMTP id a92af1059eb24-11cbba4a6aemr8596284c88.34.1764211100359;
        Wed, 26 Nov 2025 18:38:20 -0800 (PST)
Received: from [127.0.0.1] ([52.234.41.68])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee660asm810257c88.3.2025.11.26.18.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 18:38:19 -0800 (PST)
Message-Id: <86315aa3e36afa1ee741a2c9b9e95a71ca569302.1764211096.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2000.v2.git.1764211096.gitgitgadget@gmail.com>
References: <pull.2000.git.1763201865025.gitgitgadget@gmail.com>
	<pull.2000.v2.git.1764211096.gitgitgadget@gmail.com>
From: "Scott L. Burson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Nov 2025 02:38:16 +0000
Subject: [PATCH v2 2/2] merge with Scheme regexp; fix bugs
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Sixt <j6t@kdbg.org>,
    =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Jaydeep P Das <jaydeepjd.8914@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    "Scott L. Burson" <Scott@sympoiesis.com>,
    "Scott L. Burson" <Scott@sympoiesis.com>

From: "Scott L. Burson" <Scott@sympoiesis.com>

This commit merges (by disjoining) the new generic Lisp regexp into
the existing Scheme regexp.  It also fixes two bugs: the new regexp
was unintentionally allowing tabs, and the matching of "(def" should
be case-insensitive.

Signed-off-by: Scott L. Burson <Scott@sympoiesis.com>
---
 userdiff.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index e127b4a1f1..b67dfddbef 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -249,14 +249,6 @@ PATTERNS("kotlin",
 	 "|[.][0-9][0-9_]*([Ee][-+]?[0-9]+)?[fFlLuU]?"
 	 /* unary and binary operators */
 	 "|[-+*/<>%&^|=!]==?|--|\\+\\+|<<=|>>=|&&|\\|\\||->|\\.\\*|!!|[?:.][.:]"),
-PATTERNS("lisp",
-	 /* Either an unindented left paren, or a slightly indented line
-	  * starting with "(def" */
-	 "^((\\(|:space:{1,2}\\(def).*)$",
-	 /* Common Lisp symbol syntax allows arbitrary strings between vertical bars */
-	 "\\|([^\\\\]|\\\\\\\\|\\\\\\|)*\\|"
-	 /* All other words are delimited by spaces or parentheses/brackets/braces */
-	 "|([^][(){} \t])+"),
 PATTERNS("markdown",
 	 "^ {0,3}#{1,6}[ \t].*",
 	 /* -- */
@@ -352,14 +344,21 @@ PATTERNS("rust",
 	 "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"
 	 "|[-+*\\/<>%&^|=!:]=|<<=?|>>=?|&&|\\|\\||->|=>|\\.{2}=|\\.{3}|::"),
 PATTERNS("scheme",
-	 "^[\t ]*(\\(((define|def(struct|syntax|class|method|rules|record|proto|alias)?)[-*/ \t]|(library|module|struct|class)[*+ \t]).*)$",
+	 /* A possibly indented left paren followed by a Scheme keyword. */
+	 "^[\t ]*(\\(((define|def(struct|syntax|class|method|rules|record|proto|alias)?)[-*/ \t]|(library|module|struct|class)[*+ \t]).*)$\n"
+	 /*
+	  * For other Lisp dialects: either an unindented left paren, or a
+	  * slightly indented line starting with "(def".
+	  */
+	 "^((\\(| {1,2}\\([Dd][Ee][Ff]).*)$",
 	 /*
-	  * R7RS valid identifiers include any sequence enclosed
-	  * within vertical lines having no backslashes
+	  * The union of R7RS and Common Lisp symbol syntax: allows arbitrary
+	  * strings between vertical bars, including escaped backslashes and
+	  * vertical bars.
 	  */
-	 "\\|([^\\\\]*)\\|"
+	 "\\|([^\\\\]|\\\\\\\\|\\\\\\|)*\\|"
 	 /* All other words should be delimited by spaces or parentheses */
-	 "|([^][)(}{[ \t])+"),
+	 "|([^][)(}{ \t])+"),
 PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
 	 "\\\\[a-zA-Z@]+|\\\\.|([a-zA-Z0-9]|[^\x01-\x7f])+"),
 { .name = "default", .binary = -1 },
-- 
gitgitgadget
