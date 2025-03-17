Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AD8205519
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 23:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742252426; cv=none; b=Tg2KxF+ybv9+NBecQLvyQdsFdHnlJ1Gfxuj7Ei51B5b5kUFXReL4/0PuVsrcXZDxnGuRgHceMhGNGB1WCIBGNgMp9QlIVLUGyNb2v15BfSGbdnQVB8q0bSm0K1M8XcyL5MciM+PmdjlPP/C8YlcI2ZyU3LsmnxeGMgPlfe7ImdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742252426; c=relaxed/simple;
	bh=jxIPEvQvN8rP1sEFzCnUAj5g/QONuIOnqem0GIk/KcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1ZgNpN9oyhOz9tf3r0bPx11E3n+FoO83nkkidEEsvZu+ryd6PzhtdD/ZMQveqAeOxxstLWBuSZe+DWr0j2anVQTpoMjy0C+c9dQcjHfXL/AJVYMN9R4RoIW616wcLHJESzq/3ylaAJjTimTnBX0BR6YJg6yzUUAfV92bA4kBxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ESHTx1Mc; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ESHTx1Mc"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-474f0c1e1c6so44521161cf.1
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 16:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742252424; x=1742857224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/HOUuAcgjzlJgRpBo8OBeUrq/KUuEh+Kj5YMB4slWRk=;
        b=ESHTx1McqI8nvUupUwYlu2y4Z7KdsoUU4nPGl7iMiegpc8E8Jf2jWsjRAOqs5RkhVy
         IYvU7IzP3MHTwKyeoteb+iblNOQOBDWoYuaLqH9HzRysECIJ39NTr4LlmcwSL37jAQhl
         4REF1q9cc3nK9aQfMg/o5AmAmn8a8q5XYj3R8q7+yCbQZh33g4AiyN4iO+Qd74EN5dBI
         CtTIsyti5kWmz0HM/PArLGybQIXfn5cXLceupoTu8oPDiPgOB9yUMKp8lua7rvT9stD0
         FAYG5DrUwbQbmxzTJPnbUUkoD81TqeJ4BU0WQ5COK2vNpa3fbxdwsk6bT81UwvyPxEhE
         zZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742252424; x=1742857224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HOUuAcgjzlJgRpBo8OBeUrq/KUuEh+Kj5YMB4slWRk=;
        b=NhzlwLyA0sD+7CMBFKyA8tmdQfeh8EeqCRgK1FIDwc3eLxcenZ2xRTKGvpBNgUzIRL
         I0zXDxNx9I/fNQgWZCPwH4D20g3bTP4KfKo4/Jwe0sw8X9iXpd7A+vsBFTGLrka6QTCr
         SpEUmfjfWug4V6jK8wseGdBeLe9hYc2+Y1N0R6j/hnBoxOfUhWhPlrTnUngVD5eKYdIv
         mIVXsFjd3qNWZGcYU5TO24r1aQmyUpRXxWlxebL1uoGJhdfIJv0Pp1e75KgHBPaRsali
         BN3FK3B+BGay2PFk2sMY2rbRdTqkvgbHqGa2XeR+t2EKA2N68Yl1jPBMhOBpojyNJ6j+
         4tQw==
X-Gm-Message-State: AOJu0YyYCRHjHlvG10FCIaEbr4D4yErkseMOfYACn4EqHAr82qAlAmHg
	i2y7jYSC5GV3YUgSXw+w/Vt+qsmUXKmYGGlM4n7/qWD/EF+PysFbTfptKhiIv08YNpK3HTD0GSe
	ttUk=
X-Gm-Gg: ASbGnctES8X+SX1TKHUvqxxEhswQQkGyBZiXPS+XPaj7PmpPNOj7wV+mCuJpy/fHpp6
	VxZPFtLgF8kJUJxKtcw0tJ2uCIAolTQMEvFPHHhv9rLVDQVZdjvOtMBYSFzRw5xWRbVYEvrq4mo
	+JCNxkBptmdGFa+YpbI9+++abHChbMNPAIgG0lf09obvN9tG7bQ/Mb0+u4Pc3EEx7p6ddi8cWvZ
	pNSzuBSY0iHbz3iTp+ZRs5jyBVAorc3X8nuGfFPFYJ8YCRn+2p10cTlSDaPUBJommxnzSQ4o+BG
	JU42FebDwdf2r31wE5bS1KtIsir1CACcptblqru+y6qxIH75xbRCwNWpWYTDvCwBt8LqLCZoxDH
	4a/AulkKpIVV2BBOk
X-Google-Smtp-Source: AGHT+IFhEwbUDnWhZ0lB1ZotUIYbwn9QP6w5O6dQPJSZ2E6Ou5WXjSpKoYJRRAil2Z01D+2YF348Jw==
X-Received: by 2002:a05:622a:548a:b0:474:fe31:a239 with SMTP id d75a77b69052e-476c812361amr250339221cf.3.1742252423891;
        Mon, 17 Mar 2025 16:00:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb7f21d9sm60724851cf.49.2025.03.17.16.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 16:00:23 -0700 (PDT)
Date: Mon, 17 Mar 2025 19:00:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 3/5] t/t7704-repack-cruft.sh: consolidate `write_blob()`
Message-ID: <b075ad86015131e4a83bd7bcd707ff2273b375b4.1742252411.git.me@ttaylorr.com>
References: <cover.1742252411.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742252411.git.me@ttaylorr.com>

A previous commit moved a handful of tests from a different script into
t7704, including one that relies on generating random blobs.

Incidentally, the original home of this test defined its own helper
"write_blob" for doing so, which is identical in function to our
"generate_random_blob" (and is slightly inferior to the latter, which
cleans up after itself).

Rewrite the test that uses "write_blob" to no longer do so and then
remove the function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t7704-repack-cruft.sh | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index e6e4c2fad8..3fd5aa6089 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -618,11 +618,6 @@ test_expect_success 'cruft repack with no reachable objects' '
 	)
 '
 
-write_blob () {
-	test-tool genrandom "$@" >in &&
-	git hash-object -w -t blob in
-}
-
 find_pack () {
 	for idx in $(ls $packdir/pack-*.idx)
 	do
@@ -641,8 +636,8 @@ test_expect_success 'cruft repack with --max-pack-size' '
 		test_commit base &&
 
 		# two cruft objects which exceed the maximum pack size
-		foo=$(write_blob foo 1048576) &&
-		bar=$(write_blob bar 1048576) &&
+		foo=$(generate_random_blob foo 1048576) &&
+		bar=$(generate_random_blob bar 1048576) &&
 		test-tool chmtime --get -1000 \
 			"$objdir/$(test_oid_to_path $foo)" >foo.mtime &&
 		test-tool chmtime --get -2000 \
-- 
2.49.0.rc0.6.g7f120c35e9

