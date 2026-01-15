Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E65289E06
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 23:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768519125; cv=none; b=mQhNdl7tIYZyvou+g+QXKxT+8YL0n3zqsVaPa0eP3nqg2XRKu2CP844NWXqOyGk0ZC+dvm5j2kw50Pa3g3eicMyWW0pCWBfqEU870TBzgunQeoPsqosfDVmmbZtbDTPZ6v5zhegsg/uXQ9ix1a4O8C7wU5HqaQYGVFFopieFMKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768519125; c=relaxed/simple;
	bh=44ImBGmz4MmdavPxBFsyB3NqDcy7s+bsWYLlWUKuVCk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=g146kCIYS+Ltj2oBik1nQ2buDwSlTc7o156TIvIRxy4O3Ps6gKOcko/KhjBikRUHr/b3W7i2UdDh7T1S8OiKGS/ex9v3uQczmYsbwVSRRTmx//cU+3h3FjP0n5o9C+CmIcjXcvoMiuJmjpy1iEkX+aY1pBl5Jw7odya9vUE3MWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lilL5UpD; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lilL5UpD"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7cfd57f0bf7so877693a34.3
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 15:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768519122; x=1769123922; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNgGm7WFmC/IhAypI0rIu3Q2kpJskb56si8bwx3skTs=;
        b=lilL5UpDZ1PmHpNKepbxoG5nbtxJaDoj8+CftWIu0hDTCXRaxVBmxm1IKMXpxkZ5ln
         8xpX2C5tF/LN/3w7VDT/ixPdWOeiIKw407V0d8s1EXHhXfDBsSAXB3lmpRlJ0H6VXRWG
         crm8mK7hbtLqNzCrrw988qaSOpklsQzkK6u9fPDWwT+sQ1Hhxq42AhHAjWEGDc1LFAEE
         UrKJJzHNmvcbayFrKAXFyJnysOkTvspAGWZ2WzYHZ46q3lEocBISHSewG1z1GylDq3uB
         eW/OkPesdNUfoCFzBtv82TIamoiXdUJBL9jCaoYZOp/jQJEOR14k76zNieDJNAXVA5+e
         Xdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768519122; x=1769123922;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SNgGm7WFmC/IhAypI0rIu3Q2kpJskb56si8bwx3skTs=;
        b=dPObdsEyn5N7Q2qQyiXrpYg5JD/X8Hm1TDrn9fogPlwu7KK0O5FSbaqfid1Cj6XNbK
         yOrKP4BYwoy7OBzyObddVahqHcYv0VxxG6oDX0JIHUp1AHtISjgsdPVwxh5V4cBwAEhT
         CuQjR3rOBRsF8TYsvYZDNyG3wVbDK4416jTNAHqSNIrU0NHW4KQ51IAYdsLK9Q5hU2OM
         QfXGz1H72d/gwfs4kdPdInQpspGIY25a20W6B8VIfDdZWfK2GlhIuBrlHS7njVLWK90I
         Ai9Unhz7wGp14Hwqwd/nvIS0d/i4824mFKsMGAHIuaNoM5za0XIx7RIGX0dtkc6q9jzt
         eFaw==
X-Gm-Message-State: AOJu0YyPZkTdZKrkF4u5fD/fxF8tCmOXkl73gRQilThn9AnPxiuqlXFm
	3RrNz9hMwl3sgJ2Gbp47b4yCEsc6LD5QZ6AUOlgKrWTMfIzA5tv1Oh+M4LWwtQ==
X-Gm-Gg: AY/fxX6G1+KoGyZyhfguz4hZMhwnCriTWzZ9nkNZit2nwSsKVLoPRrejg+Rm3ZoNrqv
	6wSnQi+0HPeU2Vzo8Br5vJzwPONEeQuH/Nd5NE+TBWVdNPWASM1ZilPmS1stsDES6RldWov9qDR
	caS1vIAJDdOyGtaQ2CGz9sUj1TVYiwVFdMD92eH8KVERCqJrJWiqMIlfjOGD/Im16+Nm41dvGUX
	YTZH+RT+5yy3lTUDlyvPfN/Py6mh0fIqRUdhLCgD48902d+1MnA1sznrQwCzY/dg3a9ehaFYCA8
	mPCC0cOCwqXF2Kr8Q4TezR3kRflYL1l4NSlmelfN4RhWd6zBkCyfWmY6ntDlCQmRYHog8CN8gwX
	uNwLDWsBbc4YYLB98zzJ/vVmpdW1ZU1jd4IxIbvOxqM16sDkagARHGrKPXrEqRCof3rW2xW/yUK
	7CygqAng0Wf+eK
X-Received: by 2002:a05:6830:2a91:b0:7cf:dd0c:2ba6 with SMTP id 46e09a7af769-7cfdee132acmr496946a34.22.1768519122108;
        Thu, 15 Jan 2026 15:18:42 -0800 (PST)
Received: from [127.0.0.1] ([132.196.32.74])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf2a60f1sm552387a34.23.2026.01.15.15.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 15:18:41 -0800 (PST)
Message-Id: <pull.2000.v3.git.1768519120.gitgitgadget@gmail.com>
In-Reply-To: <pull.2000.v2.git.1764211096.gitgitgadget@gmail.com>
References: <pull.2000.v2.git.1764211096.gitgitgadget@gmail.com>
From: "Scott L. Burson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Jan 2026 23:18:38 +0000
Subject: [PATCH v3 0/2] userdiff: extend Scheme support to cover other Lisp dialects
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
    "Scott L. Burson" <Scott@sympoiesis.com>

Common Lisp, Emacs Lisp, and other dialects have some top-level forms, most
importantly 'defun', that are not matched by the current Scheme pattern.
Also, it is common in these dialects, when defining user macros intended as
top-level forms, to prefix their names with "def" instead of "define"; such
forms are also not currently matched. Some such forms don't even begin with
"def".

On the other hand, it is an established formatting convention in the Lisp
community that only top-level forms start at the left margin. So matching
any unindented line starting with an open parenthesis is an acceptable
heuristic; false positives will be rare.

However, there are also cases where notionally top-level forms are grouped
together within some containing form. At least in the Common Lisp community,
it is conventional to indent these by two spaces, or sometimes one. But
matching just an open parenthesis indented by two spaces would be too broad;
so the pattern added by this commit requires an indented form to start with
"(def". It is believed that this strikes a good balance between potential
false positives and false negatives.

This commit disjoins a regexp employing these heuristics to the existing
Scheme regexp, so it will still match everything that it did previously.

Johannes Sixt (1):
  userdiff: tighten word-diff test case of the scheme driver

Scott L. Burson (1):
  userdiff: extend Scheme support to cover other Lisp dialects

 Documentation/gitattributes.adoc           |  1 +
 t/t4018/scheme-lisp-defun-a                |  4 ++++
 t/t4018/scheme-lisp-defun-b                |  4 ++++
 t/t4018/scheme-lisp-eval-when              |  4 ++++
 t/t4018/{scheme-module => scheme-module-a} |  0
 t/t4018/scheme-module-b                    |  6 ++++++
 t/t4034/scheme/expect                      |  5 +++--
 t/t4034/scheme/post                        |  3 ++-
 t/t4034/scheme/pre                         |  3 ++-
 userdiff.c                                 | 22 ++++++++++++++++------
 10 files changed, 42 insertions(+), 10 deletions(-)
 create mode 100644 t/t4018/scheme-lisp-defun-a
 create mode 100644 t/t4018/scheme-lisp-defun-b
 create mode 100644 t/t4018/scheme-lisp-eval-when
 rename t/t4018/{scheme-module => scheme-module-a} (100%)
 create mode 100644 t/t4018/scheme-module-b


base-commit: 8745eae506f700657882b9e32b2aa00f234a6fb6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2000%2Fslburson%2Flisp-userdiff_driver-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2000/slburson/lisp-userdiff_driver-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2000

Range-diff vs v2:

 1:  da99bb0bcd < -:  ---------- diff: "lisp" userdiff_driver
 2:  86315aa3e3 < -:  ---------- merge with Scheme regexp; fix bugs
 -:  ---------- > 1:  e20ac5b6a6 userdiff: tighten word-diff test case of the scheme driver
 -:  ---------- > 2:  fb4c8dc5d4 userdiff: extend Scheme support to cover other Lisp dialects

-- 
gitgitgadget
