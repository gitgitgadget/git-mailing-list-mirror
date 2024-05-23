Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F46128361
	for <git@vger.kernel.org>; Thu, 23 May 2024 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499574; cv=none; b=kfLf48ExjSg53+n1MCQ8J8b3rtzDfZ2hkNkw8Bi8zmyGLJlx2S1xoGgzKcKbklIt3cDYIwGU13MxvSGSsXR+1ZzqTwL2quIIwHqHoTiYwCqCEnJsoZX6+48q7rxlH58Y3KNkn+/g4ESlkHwI47v3AuIqLxij/Y+ucAB+HweBzKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499574; c=relaxed/simple;
	bh=+h8EBBJM6kQcimE50unyWDzE2NF0rRQFE6NERXmRZ/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBs1Hfy2empMF3I9gPo236XSPdLt9VIEwMPxKY+lf84SH+HkqeNgJU3ub1hOAWl4nQx//imuoiPeHUcEBPOU/NKYe6BUDY/UtJstMo9idaT1VcvZ/SkXkLfuJK0zfHJ9dXjj+MIeiWWEtnxrVrOkb8zI+matZZgVnhQrACr9NZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=pZbZzTru; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="pZbZzTru"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43e0a5e3c08so16596101cf.3
        for <git@vger.kernel.org>; Thu, 23 May 2024 14:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716499572; x=1717104372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nfbq6IPF09RYZATmkNgRynk012fh8jURRDPwzyjHbXA=;
        b=pZbZzTru8P7AYuxlK3TdsW6o5t44iKInS1+pljdymxQI4AUsf+5GNLzHjZW59ImT3m
         yPd6T+q50E5u49a2Ixh7CXOLVi+j7sBkH21KMsRceKvi1S1U6ItDAH3C8E18XuvnORyw
         KF9TK3PfnkxcPcEs8jjoA7NHnthAELSRO2SiuFm4rHq5VKmrGM8bj0up0eCsvG7VPQre
         Z9Wv5zeOUK6WLA+MRjZHqmvrcvznEgI61+xDpUs11WwYK3WeyT/ThnbHbk+PV9JdMHJq
         xVuan5pu0D4fAAzXw7rrvJWTauExmGr6CuYWc+knzvqNZssoiBQ3qXM57O8XlwoR9FPZ
         Ov7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499572; x=1717104372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nfbq6IPF09RYZATmkNgRynk012fh8jURRDPwzyjHbXA=;
        b=oeN3C35jwRlnT+ded69d0+Y68q14G597qrsJrtHSrYAS371TbTBgi8Xknky9L4z4tp
         +YmFW9tjKi90s+n/CFA/cUSDq/6PhsQrUC7fQKYMunVaF0X9nhHD4nWgkvF9uEaGLBF9
         4tWhIHY/tALG3O1JCJQP0aDYKhU8xVl4VR603C7HANIixAKg/mltxiLqh7X/2rc3yNUa
         hsYedf+dTkwhiIUXFYRFDD5b3iIisE9grU8eU8bve8K5+9+pGX8RYZvALBJ2RQCasgxT
         +DvgHgvZ9SG6VMqJqkPj/hU2omG9K/+AlF/gT1vWePljlRohQXBXIw8wfW4F6v4Vqk4m
         cQRA==
X-Gm-Message-State: AOJu0YwXEXi5Sf4h+7lLCpSgjsOrd06f6wW9gGgtl39Nvu4a9D8qsFAn
	qXZXawdoqFwQ+GOw414yGTrSvMeYBiHQGE85Bx08p53R6yo8QGPz257sUg4+FREh5+olVU42Pt6
	i
X-Google-Smtp-Source: AGHT+IEf+fhd/qZ1XNyi/A8gWJ+pyfiHK94v8lO1awqhRAvM1FshG9cPLcIu6PVp1eKCh0iYClYITg==
X-Received: by 2002:a05:6214:3a0a:b0:6ab:6d70:99ca with SMTP id 6a1803df08f44-6abcda78778mr2413556d6.53.1716499571976;
        Thu, 23 May 2024 14:26:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac162ef87fsm564946d6.80.2024.05.23.14.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:26:11 -0700 (PDT)
Date: Thu, 23 May 2024 17:26:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 01/24] Documentation/gitpacking.txt: initial commit
Message-ID: <0f20c9becf452ef7a7e931b36336ccddba0f1d13.1716499565.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716499565.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716499565.git.me@ttaylorr.com>

Introduce a new manual page, gitpacking(7) to collect useful information
about advanced packing concepts in Git.

In future commits in this series, this manual page will expand to
describe the new pseudo-merge bitmaps feature, as well as include
examples, relevant configuration bits, use-cases, and so on.

Outside of this series, this manual page may absorb similar pieces from
other parts of Git's documentation about packing.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/Makefile       |  1 +
 Documentation/gitpacking.txt | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 Documentation/gitpacking.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3f2383a12c7..920b6248aa4 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -51,6 +51,7 @@ MAN7_TXT += gitdiffcore.txt
 MAN7_TXT += giteveryday.txt
 MAN7_TXT += gitfaq.txt
 MAN7_TXT += gitglossary.txt
+MAN7_TXT += gitpacking.txt
 MAN7_TXT += gitnamespaces.txt
 MAN7_TXT += gitremote-helpers.txt
 MAN7_TXT += gitrevisions.txt
diff --git a/Documentation/gitpacking.txt b/Documentation/gitpacking.txt
new file mode 100644
index 00000000000..50e9900d845
--- /dev/null
+++ b/Documentation/gitpacking.txt
@@ -0,0 +1,34 @@
+gitpacking(7)
+=============
+
+NAME
+----
+gitpacking - Advanced concepts related to packing in Git
+
+SYNOPSIS
+--------
+gitpacking
+
+DESCRIPTION
+-----------
+
+This document aims to describe some advanced concepts related to packing
+in Git.
+
+Many concepts are currently described scattered between manual pages of
+various Git commands, including linkgit:git-pack-objects[1],
+linkgit:git-repack[1], and others, as well as linkgit:gitformat-pack[5],
+and parts of the `Documentation/technical` tree.
+
+There are many aspects of packing in Git that are not covered in this
+document that instead live in the aforementioned areas. Over time, those
+scattered bits may coalesce into this document.
+
+SEE ALSO
+--------
+linkgit:git-pack-objects[1]
+linkgit:git-repack[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
2.45.1.175.gcf0316ad0e9

