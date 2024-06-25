Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E0D135A69
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337178; cv=none; b=GWFFbzfIHbA6DDuWSDdVzWTaeUby89xw3Zm7VV8G4Qyek5kli6sPvRF/2mdAMKa+qHG+OevHN+e28k8dlQEjLOC5p3aYfqlJjBe7QLPwbC3TtFeZSEm/BWlaVA9xmUQlF9kB2YqUrLxFI2b04K39xZdK7klIGPmxHx/k1eTLoG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337178; c=relaxed/simple;
	bh=YmWOwAz4SB/hukFsI3KQur+L37M/LGRkoFUEk72JVv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YW2tCC5WMD4KRCyofP72++KHfEL1uKQsewfmSedHrJKyM3XeXi/wrkr2wbQgWta9KiY57x8JSEZ1Ga0nyBTVF6Oz15ZQYdQcJCKZsycHyMrxiFOgR4kZ8x/W5dWUL6pvsfDpr8wu6IszD9jDwWluldzGRG0dr54eaNKAuatjH2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=XFSVRpS5; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="XFSVRpS5"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-79c03abfb18so55007085a.0
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 10:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1719337176; x=1719941976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S364uJfHiVxGn18CK1EUhoShH/JRj2hyg7M6i/YyePU=;
        b=XFSVRpS5Y3plUGL/NcG+rwn+ztK16KR2OYB9kpL6F4mYIVFrQZWlVrq3MXvaynwuaT
         7JkPCTha45H+or3HRC+z5Db0MrbtnLLPNnyT4fSQCzYhjKIFazdvWeOgbiFNkZbfUmv0
         hKpq65I54W0iuYebpvEzqZqeyiGCrWmQHvRml6fNRxHN0lHVaQT+hrvHddGvNJDfusDJ
         V5rj2ff6diPOQ6e8RlPNeSpdsER9CeUbkZRYjDZc1yj+IvdU7atu6JxU4bNbq3fm4GB8
         tqYGGLisvOLfqTwnUEB+bH+fXckuF+iO/MaFoxdY2VrMGhrxQiLXI4kXp9LmZ3RbNt7k
         dIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719337176; x=1719941976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S364uJfHiVxGn18CK1EUhoShH/JRj2hyg7M6i/YyePU=;
        b=ByCNxg0PTJMCN2vL3um9c89HapubgJKU4T/asTEfAZWhwImiOWTlKGpr3hUlyake2O
         Qu8M1nz4QgRCxKq/YOBHldejIgKw7gHhkfjj4dFyqrFUIe1g+8dj0mXjpnjiSx/QYBms
         c9+RJe9Xv2fI8Lu2P0HeGIgBHz4DGy7CXbYN3F72eCAR90l7bAT2J+gOu494a/TVJ70r
         FdZ2Ll07gCwyTGU8LCWKf72u8LfGbZAZGUDKh3dHXaTCAS/qadWMozFwHa5JkCjsAcqk
         1I0nPS15s2qgqRAdhMWsRbw/fAhN60EuDyMIQCNyNuAsnneUY5qEsvTHEq0CrXbA1Jtt
         349A==
X-Gm-Message-State: AOJu0Yx0fd6nKrl/C1Ug6GDhw53x8x4Cbf7e8+/UeL2TzwS+W5TfzDGA
	ysRl0sppRqXuWHQwBsZgDgGuSbwkYfU5k2t+6k7NFis/VlY90Tj/jVKyPj2XC23g+cfdY0wBaZf
	Hyqo=
X-Google-Smtp-Source: AGHT+IGsu7fL8ulf/iGkchgu1Pq+DS8fVyrVSJHfDw8JIfGcT3UeCLr3F2DKWrYjxIkJJrA6oQSofA==
X-Received: by 2002:a05:620a:3727:b0:79b:f36e:831e with SMTP id af79cd13be357-79bf36e839emr736916385a.13.1719337176087;
        Tue, 25 Jun 2024 10:39:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce89de24sm427024985a.23.2024.06.25.10.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 10:39:35 -0700 (PDT)
Date: Tue, 25 Jun 2024 13:39:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v7 04/16] gitformat-commit-graph: describe version 2 of BDAT
Message-ID: <0041600f31d23f149c20a648bbb5cd61561d9488.1719333276.git.me@ttaylorr.com>
References: <cover.1706741516.git.me@ttaylorr.com>
 <cover.1719333276.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1719333276.git.me@ttaylorr.com>

From: Jonathan Tan <jonathantanmy@google.com>

The code change to Git to support version 2 will be done in subsequent
commits.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/gitformat-commit-graph.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitformat-commit-graph.txt b/Documentation/gitformat-commit-graph.txt
index 31cad585e2..3e906e8030 100644
--- a/Documentation/gitformat-commit-graph.txt
+++ b/Documentation/gitformat-commit-graph.txt
@@ -142,13 +142,16 @@ All multi-byte numbers are in network byte order.
 
 ==== Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
     * It starts with header consisting of three unsigned 32-bit integers:
-      - Version of the hash algorithm being used. We currently only support
-	value 1 which corresponds to the 32-bit version of the murmur3 hash
+      - Version of the hash algorithm being used. We currently support
+	value 2 which corresponds to the 32-bit version of the murmur3 hash
 	implemented exactly as described in
 	https://en.wikipedia.org/wiki/MurmurHash#Algorithm and the double
 	hashing technique using seed values 0x293ae76f and 0x7e646e2 as
 	described in https://doi.org/10.1007/978-3-540-30494-4_26 "Bloom Filters
-	in Probabilistic Verification"
+	in Probabilistic Verification". Version 1 Bloom filters have a bug that appears
+	when char is signed and the repository has path names that have characters >=
+	0x80; Git supports reading and writing them, but this ability will be removed
+	in a future version of Git.
       - The number of times a path is hashed and hence the number of bit positions
 	      that cumulatively determine whether a file is present in the commit.
       - The minimum number of bits 'b' per entry in the Bloom filter. If the filter
-- 
2.45.2.664.g446e6a2b1f

