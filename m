Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0381D6A9
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431828; cv=none; b=crAxBGW02Wmu1JzGyJyQE1nRHHD5J5kL24Zuj/aKRP4/SNI4Q5E0t6EV+byc+fn2fkmpwpar9LSd52uxGpQoJIVgR68ZsaQNZawDLeLEJISBYxvbIb+N+ix7lUW7Tf9wGUUAPpoPBukEtzro1f105+ReFepCSobzgbta1lFAZW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431828; c=relaxed/simple;
	bh=T42fOAWBgz6sPUwAI7mPSAx9cfjxn9qUIMzJR9Su3Rk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cStz9hIH2bIf3IdCa9/GL/rFngIIpNLlwtedMpSo9AVqnAZyrYs9wSJgXAMs9qN46pm02NO7JoG9wjUBV+dhaO9Fjizy2Nftalv/jR7C+cevgB4f5a7hTjsg5H27yFqiZvcZKDXoULMZa6/nlq0I8sIVGMOWrzfQ4vrHK4lVUiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=EtzSIVuo; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="EtzSIVuo"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42a032cf012so7776141cf.1
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 11:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1705431825; x=1706036625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5PcaC7vByiFvGmytokH9mKOyJ5XxVf1/TRr47wy6olw=;
        b=EtzSIVuoCWFAK9WYmCvZkRxysaZnNWLHTxZ6nZYUiBU86aZ+mrEuahCsiDDy2jb62D
         BNiWAJu4Nj74cm0oVQVaAWzd8hyeEH9zv3+2of58x3frALa2z1x+/y6JwNnV5Ia/dYgp
         85SganrdE3sTp9xSMcZ1SPMsE929AjCFzuOk26va8iwqmsRjQtM1vMr1v4VozbtLos//
         t69vFc941SIG2E/URJNqijehNb/shwf0xFMIFkjp3Xj8dM2yx2OQzvt41ybOVnaWp/67
         H0s3L+fsfEjqYM2ClCeSy4WjQGuksrMGXWVVQRH3X0YHeqQ4MtbX/sKIIZVAI5FlXL7C
         nADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705431825; x=1706036625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PcaC7vByiFvGmytokH9mKOyJ5XxVf1/TRr47wy6olw=;
        b=IG97oIe7a38aPZ3xXDkVIyFRbX9kodmE0GyVX0T9vFQ1Jvk+WkqwkxUKJ7dyRUYvxE
         k7+LYLiYvmNR5Ouo32lypppApmJeelnFWpqGE34tsUf4C9ZHsvM3FxgvpgnV4CChEN+Z
         ihEVZzuw5QG4tYy/J6WZ26k/UoAOS8CAD5ZG1t1++z3g6duMRQGQIB9IFOTlrMfzWWGa
         gIsmKJoKsPSXeZ6YzIVcMAq5BzLEvJaw3C3AAZWSY/aS3Cnsu7N5o84PP8aZaBE0Jv+3
         MCSxb6v8yOypUOLe63gV2wutEeOt5l3VrGgEOP3HXK/6JdgAOQR5nvH9GQV5fK3jwMT2
         IDnQ==
X-Gm-Message-State: AOJu0YwTpJxKaV5N596RmBAPyDUKqHzOU8BJ6ExsgHQ/dJtv84KdG1a+
	lM+cG91Zebxn7WdspW5Ku1I9EydaiE5/IiDP4yIH/v9yLxs3og==
X-Google-Smtp-Source: AGHT+IF8JRQci7NzXgKSEkqpDcbLO7iOaf+IPuA46DMCGnbN/x+kzRGZqL+vN8osPGImwxAQhnx42Q==
X-Received: by 2002:a05:622a:1454:b0:429:c70a:7b55 with SMTP id v20-20020a05622a145400b00429c70a7b55mr9235869qtx.132.1705431825409;
        Tue, 16 Jan 2024 11:03:45 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id he23-20020a05622a601700b0042a09928c10sm479948qtb.33.2024.01.16.11.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 11:03:45 -0800 (PST)
Date: Tue, 16 Jan 2024 14:03:44 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] t5332-multi-pack-reuse.sh: extract pack-objects helper
 functions
Message-ID: <94dd41e1afdd6d926a106ab387295cf5fce624cf.1705431816.git.me@ttaylorr.com>
References: <cover.1705431816.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1705431816.git.me@ttaylorr.com>

Most of the tests in t5332 perform some setup before repeating a common
refrain that looks like:

    : >trace2.txt &&
    GIT_TRACE2_EVENT="$PWD/trace2.txt" \
      git pack-objects --stdout --revs --all >/dev/null &&

    test_pack_reused $objects_nr <trace2.txt &&
    test_packs_reused $packs_nr <trace2.txt

The next commit will add more tests which repeat the above refrain.
Avoid duplicating this invocation even further and prepare for the
following commit by wrapping the above in a helper function called
`test_pack_objects_reused_all()`.

Introduce another similar function `test_pack_objects_reused`, which
expects to read a list of revisions over stdin for tests which need more
fine-grained control of the contents of the pack they generate.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5332-multi-pack-reuse.sh | 70 +++++++++++++++----------------------
 1 file changed, 28 insertions(+), 42 deletions(-)

diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
index 2ba788b042..b53e821bc0 100755
--- a/t/t5332-multi-pack-reuse.sh
+++ b/t/t5332-multi-pack-reuse.sh
@@ -23,6 +23,26 @@ pack_position () {
 	grep "$1" objects | cut -d" " -f1
 }
 
+# test_pack_objects_reused_all <pack-reused> <packs-reused>
+test_pack_objects_reused_all () {
+	: >trace2.txt &&
+	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
+		git pack-objects --stdout --revs --all >/dev/null &&
+
+	test_pack_reused "$1" <trace2.txt &&
+	test_packs_reused "$2" <trace2.txt
+}
+
+# test_pack_objects_reused <pack-reused> <packs-reused>
+test_pack_objects_reused () {
+	: >trace2.txt &&
+	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
+		git pack-objects --stdout --revs >/dev/null &&
+
+	test_pack_reused "$1" <trace2.txt &&
+	test_packs_reused "$2" <trace2.txt
+}
+
 test_expect_success 'preferred pack is reused for single-pack reuse' '
 	test_config pack.allowPackReuse single &&
 
@@ -34,14 +54,10 @@ test_expect_success 'preferred pack is reused for single-pack reuse' '
 
 	git multi-pack-index write --bitmap &&
 
-	: >trace2.txt &&
-	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
-		git pack-objects --stdout --revs --all >/dev/null &&
-
-	test_pack_reused 3 <trace2.txt &&
-	test_packs_reused 1 <trace2.txt
+	test_pack_objects_reused_all 3 1
 '
 
+
 test_expect_success 'enable multi-pack reuse' '
 	git config pack.allowPackReuse multi
 '
@@ -57,21 +73,11 @@ test_expect_success 'reuse all objects from subset of bitmapped packs' '
 	^$(git rev-parse A)
 	EOF
 
-	: >trace2.txt &&
-	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
-		git pack-objects --stdout --revs <in >/dev/null &&
-
-	test_pack_reused 6 <trace2.txt &&
-	test_packs_reused 2 <trace2.txt
+	test_pack_objects_reused 6 2 <in
 '
 
 test_expect_success 'reuse all objects from all packs' '
-	: >trace2.txt &&
-	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
-		git pack-objects --stdout --revs --all >/dev/null &&
-
-	test_pack_reused 9 <trace2.txt &&
-	test_packs_reused 3 <trace2.txt
+	test_pack_objects_reused_all 9 3
 '
 
 test_expect_success 'reuse objects from first pack with middle gap' '
@@ -104,12 +110,7 @@ test_expect_success 'reuse objects from first pack with middle gap' '
 	^$(git rev-parse D)
 	EOF
 
-	: >trace2.txt &&
-	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
-		git pack-objects --stdout --delta-base-offset --revs <in >/dev/null &&
-
-	test_pack_reused 3 <trace2.txt &&
-	test_packs_reused 1 <trace2.txt
+	test_pack_objects_reused 3 1 <in
 '
 
 test_expect_success 'reuse objects from middle pack with middle gap' '
@@ -125,12 +126,7 @@ test_expect_success 'reuse objects from middle pack with middle gap' '
 	^$(git rev-parse D)
 	EOF
 
-	: >trace2.txt &&
-	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
-		git pack-objects --stdout --delta-base-offset --revs <in >/dev/null &&
-
-	test_pack_reused 3 <trace2.txt &&
-	test_packs_reused 1 <trace2.txt
+	test_pack_objects_reused 3 1 <in
 '
 
 test_expect_success 'omit delta with uninteresting base (same pack)' '
@@ -160,10 +156,6 @@ test_expect_success 'omit delta with uninteresting base (same pack)' '
 	^$base
 	EOF
 
-	: >trace2.txt &&
-	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
-		git pack-objects --stdout --delta-base-offset --revs <in >/dev/null &&
-
 	# We can only reuse the 3 objects corresponding to "other" from
 	# the latest pack.
 	#
@@ -175,8 +167,7 @@ test_expect_success 'omit delta with uninteresting base (same pack)' '
 	# The remaining objects from the other pack are similarly not
 	# reused because their objects are on the uninteresting side of
 	# the query.
-	test_pack_reused 3 <trace2.txt &&
-	test_packs_reused 1 <trace2.txt
+	test_pack_objects_reused 3 1 <in
 '
 
 test_expect_success 'omit delta from uninteresting base (cross pack)' '
@@ -189,15 +180,10 @@ test_expect_success 'omit delta from uninteresting base (cross pack)' '
 
 	git multi-pack-index write --bitmap --preferred-pack="pack-$P.idx" &&
 
-	: >trace2.txt &&
-	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
-		git pack-objects --stdout --delta-base-offset --all >/dev/null &&
-
 	packs_nr="$(find $packdir -type f -name "pack-*.pack" | wc -l)" &&
 	objects_nr="$(git rev-list --count --all --objects)" &&
 
-	test_pack_reused $(($objects_nr - 1)) <trace2.txt &&
-	test_packs_reused $packs_nr <trace2.txt
+	test_pack_objects_reused_all $(($objects_nr - 1)) $packs_nr
 '
 
 test_done
-- 
2.43.0.334.gd4dbce1db5.dirty

