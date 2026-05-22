Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAA9372048
	for <git@vger.kernel.org>; Fri, 22 May 2026 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779474282; cv=none; b=dZzjNDh47dP+H3aLpmwRG5SF92/bnuFQbvlqPFegBAsCGtcoI0dVDL4BR2Lm4QH68GhjHhoyyqe16R+oPsecWlyd2XrVSP+iaVEETzui+DMz8Qinzxza5KUDoJ/rFkYQWG1JKI00C9+ZNqMkbl8H2/HiU6/HcJa7VwKTLbBa6iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779474282; c=relaxed/simple;
	bh=aJqsTBenCaaV9v4tAgQ/0ruOMqXUmnnvcvbIHXNB4VU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ty46IYi9l0WX1zbuGJ7NHLHqyk2LGcd+FGHdEkCqORvdeg/b5ZwiY2AjDQsQAZNJc8eE80p2cUfkkw/gfhTxQURxLiBtRGwawzjd53mC5UdI95jNztXxSpkkbZb6yFZYA4VXQnpbB5/QSO5hWdW4wIjujTqLvMmJkQ5ZlWHB/TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjvWEj8i; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjvWEj8i"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8cac189e516so40251906d6.2
        for <git@vger.kernel.org>; Fri, 22 May 2026 11:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779474280; x=1780079080; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTGmM7qTm5jewS8ssjhnMwqu31YH5UBJAn/TQKx3yJg=;
        b=BjvWEj8itzX9z8Z2pEPeVR2Jrf1NHDf0DVXpWmPRxBK9wNicOe8W92OjqjVZJ3YIFQ
         D2valq4yhWCHdz64Xg7ZZidtN/pT7RIuWEp2tszjdpFJlI0jXi729Z8OBr0AMUCTs0KD
         uIkXkjHwtSiOE8AVn9EfiZcKo43jGUJKcLSSoxkumcJFQCXhbmXrJo/tmoCsntI1jttU
         oK27XmDv0aj6+u1kQGI7tQtvE+XmeqZVlGiEHi2Tl1LCyFrqnQAaEzMa6pDKt/Rz7Z4G
         S855mmBde9sSW2EjYvg+DeYfG58eIRto2f6L+brX40F6By5Cs0lbvWrZ4IW2b8a3FygQ
         +78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779474280; x=1780079080;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CTGmM7qTm5jewS8ssjhnMwqu31YH5UBJAn/TQKx3yJg=;
        b=Bk8THbJQNkinqcUCsAnqLktcTCmJC2hoPwuyIAo8hBCib7jmSxD+evFMsWmaEF1w66
         vqlHV6GSQS3RoI/A6yxAhHcG+36suUnK4d4qkG/YaJDe2WYhtFHex7jksy3kn0ZlpcSZ
         HNWXH2Rz/FI7SxfG3qF8Rn2hpP9qFj5XyxV9njWe+wQhm5FbojzPwptDv87dgY1DJHKL
         80CASX38iBHlOfHMrpQfulb6SrOBHK/ifsTC4WWRRn0SdDdQbW1g1/n4AxV/n9spDebw
         rPnABeZea3MrrhFy7kGF4XfBciLo5F9GNE6IXIaIgCAJ2+gEEBPsfKXU0DZKvPWFV7/l
         A5Jw==
X-Gm-Message-State: AOJu0YyXztPILOovvC5jnMwhVWA2HVG6+6C0rQkD+tcRo+8sQ4461EyC
	f5K9MgsBlH0uBlYsr73QXkIJx+ItZbtepyWsXov0pDKYDw+nggPMsMpXxHYc5A==
X-Gm-Gg: Acq92OEVbL1yx2d+J2TuDDiN+y0f6dq6XyGVRBmocvYAYP/3uwt/RxPfuaj/nn4bqRi
	yEa0YEQFNXIpnx05qRYm8eHO/m0AUFus1hYFm6WY6Bhv6zlL+iYU/9G8qHZXrU/OV6eYGSM3TI+
	bDdV8PGVG2xza2tiXXPsflBVrCPL4xEOlJ1jLwkk2emGaa91LJrEK3r47K2HjKui5SjGLnPWQpA
	pBBpo/2Qjhw+HgyYAj/4SSlWxzmW+L4J/jW12RIh8bGsZoPBuht4ibq0c8BH4AwfdZly0zyWhMB
	Pkg4hOEZyYtdOjWpRpxi5EfNy0WSSrRtbrk8rfPqjPmrOaDUdNNsNqMw8h4ACXORt+UEmvS8z/q
	xCktao+Yfrr7LEOi0iazgCpmXvajRHwCnme2GpfpD7v0frS+y6fXSslBEI4zHhexOB3I076+C38
	snB0AZMJyCMnC/C3kkD2VN25D62wxK243LkaJ9Eg==
X-Received: by 2002:a05:6214:54c4:b0:8ca:279b:e554 with SMTP id 6a1803df08f44-8cc7b5a8f9dmr84573616d6.29.1779474280210;
        Fri, 22 May 2026 11:24:40 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.123.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dcec8esm25879596d6.7.2026.05.22.11.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 11:24:39 -0700 (PDT)
Message-Id: <0840110116a967d39d8b63dbfe822ea9b2500088.1779474277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v5.git.1779474277.gitgitgadget@gmail.com>
References: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
	<pull.2101.v5.git.1779474277.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 18:24:25 +0000
Subject: [PATCH v5 01/13] t5620: make test work with path-walk var
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

