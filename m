Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D782179659
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423456; cv=none; b=qgcspI88r0lKyKyORsUCyQsSsNmaXAKhwZrPrnmUiiEHgCXlBdInoewHRz0kN+pDQcQErIZg1hvVNuQJkVqCdKzlOBhRZNXjGTC64NGwa3j8RgARdauqZtLviLvp8M+FOirNeBbkpsmU2XdTvkBAsDv6IbxnABWfsxhmjitnTIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423456; c=relaxed/simple;
	bh=SV96UtOJMku0cCXiWpqq/U1DmMgZJy8G1ihBQW3b354=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GP9fKrH3INxDiQ8UAqqpOlMmyMOUHi8Kbp5khm1zn33evhFR6xYe8hkLDQ8VLcgiw979MEmFHO1/EK+3ULQ3QVovbiwBEJKjsEjdMD8AhYN8daaqNsOXxO0e66WgRO+Ty7Ji+25JMOOXF0XT6ZOtFAgdYc62JC5h2DOUSx+3DaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=u1Gfd/Zf; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="u1Gfd/Zf"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6969388c36fso20414336d6.1
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 13:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714423453; x=1715028253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UJK1qt4MrO/9hMZTnFd2Wp9d2ueuTJESIE9NLlAmvSw=;
        b=u1Gfd/ZfIYSlhnLXvZh9K0fbhHWVXOVZeQiojHOXdmS3Ou8obvYiPk5Hb+h1Dybg1q
         QQZZKaOGIiMU6rpYzB0rQiIuoIE/AUGXrl9aiNmnVeUUDco0A2yvHV0SBF9DDwhYtuRI
         M17g1lWMLADhIQRKz8CQ1BHeRtFlxH+BiUMbsTKQiHDeE9Uaba162tln7mXXliw9KfFC
         UgP3JXOJ72vxoh7vvfId0Uk2xey7vkt7uWbS8FJvYZ3hxePhwHyifOCWvmGhV2aAfnzL
         IC7O3aw3Lqc8pvbsDDb9dTSOI9NsrMp87kBc8ChNEE3t8SD6440hJKhBFrSCBBp+C8t4
         Hntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423453; x=1715028253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJK1qt4MrO/9hMZTnFd2Wp9d2ueuTJESIE9NLlAmvSw=;
        b=rdYTYcZW9gPdVxtQ5AMErCsKnciSqRS6fa5mK/dWhtlsofGVfPC3Row8UsdAfJgSMQ
         fZqZPaoyRRPJl/scPRg9MwuGpjBdiyjRrJkoCOrp1Zvrck58EuHd1DNWWa+gG8+2S/EW
         YI9l0b9Xj5Yn3uaEaDu1QhMJPGWFLT7IAZPhQdoCb637r736dn0wBJslTR1mpRfQRJAa
         Ja9GUaFu02nAWtIUMGjksvP5PgUe/Q91Whg3NqgewzX+RSMsG82a+xk5HUVOK/fptQJd
         IVH051uEjZik8o20BbJKgTAuyFuvBEPG0yhvyU+1xrEjpc+ld5eBkcc6JqLnb4tMBwnk
         x0rg==
X-Gm-Message-State: AOJu0Yxc2Il6SutGiReywvGfa1UeAAxCv6yeHpRzA1j/IdOU/FFI8Kjp
	3BYWGUTSBz74z9S6g4F4kes0uvEUIlAlk4KEKeMUtdEHFjsx7Kd5RL1UPXN9WRzvaL2aPR2Fm1M
	gFPs=
X-Google-Smtp-Source: AGHT+IEm5rseE2EOIrXP4DAXUKvTlGYxAtoa6ICJnlbZO/GEkS1aQnZV1IXbcySM2AOt+EsMBEh+PA==
X-Received: by 2002:ad4:5de6:0:b0:6a0:b4fd:d0a0 with SMTP id jn6-20020ad45de6000000b006a0b4fdd0a0mr770882qvb.6.1714423453200;
        Mon, 29 Apr 2024 13:44:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ne4-20020a056214424400b006a0cfdcffbdsm1201765qvb.50.2024.04.29.13.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:44:12 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:44:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 18/23] t/test-lib-functions.sh: support `--date` in
 `test_commit_bulk()`
Message-ID: <006abdd1698999539eda7f1b08c2b5a99efaed94.1714422410.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1714422410.git.me@ttaylorr.com>

One of the tests we'll want to add for pseudo-merge bitmaps needs to be
able to generate a large number of commits at a specific date.

Support the `--date` option (with identical semantics to the `--date`
option for `test_commit()`) within `test_commit_bulk` as a prerequisite
for that.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/test-lib-functions.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 862d80c9748..16fd585e34b 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -458,6 +458,7 @@ test_commit_bulk () {
 	indir=.
 	ref=HEAD
 	n=1
+	notick=
 	message='commit %s'
 	filename='%s.t'
 	contents='content %s'
@@ -488,6 +489,12 @@ test_commit_bulk () {
 			filename="${1#--*=}-%s.t"
 			contents="${1#--*=} %s"
 			;;
+		--date)
+			notick=yes
+			GIT_COMMITTER_DATE="$2"
+			GIT_AUTHOR_DATE="$2"
+			shift
+			;;
 		-*)
 			BUG "invalid test_commit_bulk option: $1"
 			;;
@@ -507,7 +514,10 @@ test_commit_bulk () {
 
 	while test "$total" -gt 0
 	do
-		test_tick &&
+		if test -z "$notick"
+		then
+			test_tick
+		fi &&
 		echo "commit $ref"
 		printf 'author %s <%s> %s\n' \
 			"$GIT_AUTHOR_NAME" \
-- 
2.45.0.23.gc6f94b99219

