Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B97477988
	for <git@vger.kernel.org>; Mon, 11 May 2026 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523195; cv=none; b=OZ/MLaDGkHZzfFSyfy/SG4JwK24D995VxOU5keOcSeGQuilLKjSY+hfy2nWDzkZqt+2XRIgIe12B6fT87GT2UcL1BGxZ6XcNSR/OPDcrOQo9tccP92zj1ol5dd3R7kYYSmHG7JMPDECirKHaYwBOh4NgedcJzXjgzMsE1km47hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523195; c=relaxed/simple;
	bh=aJqsTBenCaaV9v4tAgQ/0ruOMqXUmnnvcvbIHXNB4VU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lbQrMsr8rymGsTn64tZ/fSm0tz94r7EeZxd9pfBsA82VRS/PvsnzgkJS/pU7+8gi3WuBwH3J593jPmy04PE/b4rHXwu59bACowfftnZ07adsEJknPnRKXkZx8+bo79n3DPWuzsMh7VWK8y5n+MZrFsusQBWjCnJhqnZceof3jzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IE6c03pi; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IE6c03pi"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-90caad2e944so27297485a.2
        for <git@vger.kernel.org>; Mon, 11 May 2026 11:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778523192; x=1779127992; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTGmM7qTm5jewS8ssjhnMwqu31YH5UBJAn/TQKx3yJg=;
        b=IE6c03piWKuNjojZoCMKhwDPNvFWePYDK+coiCkFBaXx+Z/80R5IUxgfN0ZHqvo1od
         2kHmMYr45PVhnTkoJ3iTB5vmoPj6pldcUKG+n4Kz77CmMXlpWb3GSnlCUY2EyXnBSHu9
         V1OnebznTLjn3GdQE+nmkpbMhdh5TBzz8qk/9DOtLrzOWn+6pyyZdUFyNSaqc6L0S05y
         Q/rn9wH0d4DpcQyI9ws05nhxveUBGDORCT+TgnMqLObaD9Aujt81wii9XFr9HLabhwVc
         dddub1gPNQxdVGxZquCmEQPPL3t1jTQF/+C96fqjGl7VBpH5iFvUUhvV5P06UQSppzmG
         AbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778523192; x=1779127992;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CTGmM7qTm5jewS8ssjhnMwqu31YH5UBJAn/TQKx3yJg=;
        b=XbI0wxxT6BpRQoKJpWjCrdLKWF3sDdgpVY+Hhjt0c4os/VJxF5KHAkghRf6bzJWk/A
         OrGh5wOO9un1sgXFW1jUsDOSZEe0IPjmN+ibb2qtHUqDkK3txrwn6TW50WClrjp4H1Lo
         ESaNKIXqBkp2klzUex3sqdeyA5woNiVSPyjN2zYFP2m9bYVosvV5k0uLjHp9TwI5LPgm
         qKqIIDLfCDvK6kjETPfgaDp/JDEEE45mfV6UBCjJMNSYyq7HTJzxXPOHlbC6HHsyCBFg
         3mzaJBoVWjpDA8Geu02f5ssR46pgMq/XVSYGnsXnbmUGQ/MRZnlRZFAzpw8tHZaweAPe
         g3aA==
X-Gm-Message-State: AOJu0YyUelz8hXPHfz7pWT1dU1AM6drgbnw74WHqCeffp4XGhtid+A6i
	A+2yum4L/ay0LZG3V4tstrDHQB8H1Fnl+v0ERdZryoYFMauTLlp/hxCM6we88w==
X-Gm-Gg: Acq92OH5JNeSpGTRLXnEAST8fRp/YTKisfUPqUYhOq0p801teFK+zVQA0+HqmQK4t9i
	k8oVQgOm/Cq8Ki2WkarymMoNuwtMsC2UE1UBYbBzys5Y7ajxbT9MFUyerrm+jA6p9BLeplblO8M
	WVhHJrtf8jLg7wQlz+PYlaGQ9+C/zSWXK0lJzo4w/DSUi2/Rd2n9PktzTQp66DwHOpclOEBRnID
	8MXKCi46nYK+u+6OnJFloy1JvGvWval2CFSyE7AhPNNr1O6zyEHI0L6nYKwOurxX1wx2gGBRgNX
	MWA2L/xxJeMMcdx7oiYqEqCkAaf8nk0fAPNd88FV/OOHgyxfQmVQf85KUENbtQ4Vwoyk0hmUs3C
	+30wd8Vs3xY1VKkNhjgn7Onk1UG+iIdNMVS+z+aypMCvri3hbKHNTDTaMg+rqVURSDV/VVnlQF/
	NKbGWonl8jaw5BHTW6ycINvPeUIw==
X-Received: by 2002:a05:620a:19a9:b0:8ee:f43a:bb6d with SMTP id af79cd13be357-904d71c251amr3777234685a.57.1778523192168;
        Mon, 11 May 2026 11:13:12 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.78.164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b9c524bbsm1100054185a.1.2026.05.11.11.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:13:11 -0700 (PDT)
Message-Id: <0840110116a967d39d8b63dbfe822ea9b2500088.1778523189.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
References: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
	<pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 18:12:58 +0000
Subject: [PATCH v3 01/12] t5620: make test work with path-walk var
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The GIT_TEST_PACK_PATH_WALK test variable allows enabling the
--path-walk option to 'git pack-objects' by default. This sometimes
engages the warning that --path-walk is incompatible with the --filter
option. These tests in t5620 fail due to this warning over stderr in
this case. Disable this variable for this moment until these options
work together.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t5620-backfill.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index 94f35ce190..e174290787 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -298,6 +298,9 @@ test_expect_success 'backfill with prefix pathspec' '
 	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
 	test_line_count = 48 missing &&
 
+	# If we enable --path-walk here, we will get a warning overs stderr
+	# due to incompatibilities with --filter.
+	GIT_TEST_PACK_PATH_WALK=0 \
 	git -C backfill-path backfill HEAD -- d/f 2>err &&
 	test_must_be_empty err &&
 
@@ -315,6 +318,9 @@ test_expect_success 'backfill with multiple pathspecs' '
 	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
 	test_line_count = 48 missing &&
 
+	# If we enable --path-walk here, we will get a warning overs stderr
+	# due to incompatibilities with --filter.
+	GIT_TEST_PACK_PATH_WALK=0 \
 	git -C backfill-path backfill HEAD -- d/f a 2>err &&
 	test_must_be_empty err &&
 
@@ -332,6 +338,9 @@ test_expect_success 'backfill with wildcard pathspec' '
 	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
 	test_line_count = 48 missing &&
 
+	# If we enable --path-walk here, we will get a warning overs stderr
+	# due to incompatibilities with --filter.
+	GIT_TEST_PACK_PATH_WALK=0 \
 	git -C backfill-path backfill HEAD -- "d/file.*.txt" 2>err &&
 	test_must_be_empty err &&
 
-- 
gitgitgadget

