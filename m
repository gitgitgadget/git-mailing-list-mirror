Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F011494D9
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763201869; cv=none; b=nI3K+o6+vXQeqcMF6JATEOIGiuWrlEVyxuwPOgspCHF0EhSg49DPQgqCc2COYzr3WufKz0E4Gxv+YpisllGeSk15m+QkxS6o3uAF/4lH/3XnXPx+d/9ibW3UHw5YaA5LlSPf4c4sFTwHArmMbQs5/XEAlxamm2Vh1WeHb1VdAL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763201869; c=relaxed/simple;
	bh=PGBxT2SUoZaD32ZI4oyOLqE1NEfRZOHR01ZpYxMjsUg=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=QGQADhjc3aFCySCHlNVajHa8HAqWVjYV5fqfn0o7IycCrdHjTgXTPPZ9JMAxSwP8eM/ZOdp/lb4WATIvZWwdEP0M6gQLnXVAh94cYiVU+NIrEogThQMKikSZBJHfLF0yI0KfiXxvHp2P36VDRvNJaf2BvN90Buo0ndZhkLnWROI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kg8zARlb; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kg8zARlb"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b28f983333so287772985a.3
        for <git@vger.kernel.org>; Sat, 15 Nov 2025 02:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763201866; x=1763806666; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DNuDMGuS7dnMTdviD+o3bAwClU4NTzRTE5790R5s+qc=;
        b=kg8zARlbxi7V/x7Ay8esqBDDl6HPcknpagjmGeqhKG8YjfDbOxMjE68/NoAtce3sva
         HAWQ2usl5HoTxbmkiY8utg+fU2ztFpOUHDe/05WMIqPbx8zNxAxtjcXXzcryaLH5r4tI
         mkFJ8qtVEZfbxDJ4Pnlu9oRpXGyUun2ZUc8YBvN1KHngePDZnUk72E9VbRbofp3Wvtxd
         MBrqSrprBvln6lGiOeVWkYLQ8PT83lvCzU41LeLvJydqfJUiOxJUbCmDdXfeGYGjwXCf
         s6SovSQXgHi/3UAIXzbfBaeEejilBWBh3WXOJ9cBNr9QAjqIOsQ/9VNCG6xHikOy7j9L
         823Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763201866; x=1763806666;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNuDMGuS7dnMTdviD+o3bAwClU4NTzRTE5790R5s+qc=;
        b=ZpqvqwY7vXQNNaZ9TdlOh0jg8b1D4yb84ffuPUqc5qnmB5dyqiuF+BebMrpQIv2fqw
         X9kecnfkJ0S3aCLxPqav4foCXoNbrrWaj6IRrZ5c2Y7dADUF7v4/D/CID1vGJp0egy+d
         MP+EK0/eUQfNTJtt2wbmJXl0Lua7CJzqXq6UVtcc4wBYzrc3viZCq9+VcD1zCfYZ4wv2
         dfYz+ZoyuVFojM6v9vz7dmvwK9AH67tNlh5vFx9Y/lngpVTH81xHhEki0RdjXtmx0d5B
         N4UQBFLRN1GJ6p3+b/w/bscxHRE7F9uyj8jJRS7e13GjqKSCLDO+q6GFgqlpnz/6sBBw
         XF0g==
X-Gm-Message-State: AOJu0YxsbYp2ZVmUstq0lBT4hydHE4tgwi5+OBuaCTNZ3bv+vl2/kJua
	z4dPjmMc5CpleuYzafIZqeuWeuzeJksbeG20nMApBs4EaoepACfHulX24CytXQ==
X-Gm-Gg: ASbGncsXdhdX5eT0F/zr+6X2/tpRA7KC9GDleJk7sduVlN+/wGNVoYNid9tHdwfYLLW
	kFei+71HB6naJqKim3BQc4vsY+l41v2PyWGPFURV2uJjtspQBdD1Wqb+shLQGu/QQltNB0EiMnR
	Xso4DMX+3iLIayrdJYsd3kDxtY6vH9yxzeJxcgUrjOfz8yIyEitQOWfw5ZcYDEglJt55bKXJ3qw
	gqn8hHixvmMJklYOzu/NrztkoYcVtbHBrJLOTcMYgECUUfBAImdYz0uAok+T65yBRb0zzhUESVy
	svHQyUJRPRcaIRxdcpC9RWrq3UlqUKKT5ow9QENVaz38M+F+HU3ALJzTaKCRrg0Mh1TsZphzjgt
	t5MEp4rDd3IKqhD0F9Y3jcL/KeN0McWhS26J/xcQH/TG4GQ7ovQ7YBR9LwZCriRo86tpUdR69eH
	4w30iFu0l0f90=
X-Google-Smtp-Source: AGHT+IFhVlli/IMxJLDF4g6mfyyODWsNjajLrvXmXQSxpHzfdAw22VELRE0JBfLzRgmczxCgmhdbww==
X-Received: by 2002:a05:6214:29ca:b0:880:5edf:d135 with SMTP id 6a1803df08f44-882926d7c2amr91480536d6.53.1763201866106;
        Sat, 15 Nov 2025 02:17:46 -0800 (PST)
Received: from [127.0.0.1] ([20.109.39.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286532f4esm50370846d6.37.2025.11.15.02.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 02:17:45 -0800 (PST)
Message-Id: <pull.2000.git.1763201865025.gitgitgadget@gmail.com>
From: "Scott L. Burson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 15 Nov 2025 10:17:45 +0000
Subject: [PATCH] diff: "lisp" userdiff_driver
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
    "Scott L. Burson" <Scott@sympoiesis.com>,
    "Scott L. Burson" <Scott@sympoiesis.com>

From: "Scott L. Burson" <Scott@sympoiesis.com>

The "scheme" driver doesn't quite work for Common Lisp.  This driver
is very generic and should work for almost any dialect of Lisp,
including Common Lisp.

Signed-off-by: Scott L. Burson <Scott@sympoiesis.com>
---
    diff: "lisp" userdiff_driver

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2000%2Fslburson%2Flisp-userdiff_driver-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2000/slburson/lisp-userdiff_driver-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2000

 userdiff.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/userdiff.c b/userdiff.c
index fe710a68bf..e127b4a1f1 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -249,6 +249,14 @@ PATTERNS("kotlin",
 	 "|[.][0-9][0-9_]*([Ee][-+]?[0-9]+)?[fFlLuU]?"
 	 /* unary and binary operators */
 	 "|[-+*/<>%&^|=!]==?|--|\\+\\+|<<=|>>=|&&|\\|\\||->|\\.\\*|!!|[?:.][.:]"),
+PATTERNS("lisp",
+	 /* Either an unindented left paren, or a slightly indented line
+	  * starting with "(def" */
+	 "^((\\(|:space:{1,2}\\(def).*)$",
+	 /* Common Lisp symbol syntax allows arbitrary strings between vertical bars */
+	 "\\|([^\\\\]|\\\\\\\\|\\\\\\|)*\\|"
+	 /* All other words are delimited by spaces or parentheses/brackets/braces */
+	 "|([^][(){} \t])+"),
 PATTERNS("markdown",
 	 "^ {0,3}#{1,6}[ \t].*",
 	 /* -- */

base-commit: fd372d9b1a69a01a676398882bbe3840bf51fe72
-- 
gitgitgadget
