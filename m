Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893591E766F
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 20:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745871892; cv=none; b=seLU/doax6v57aqHUDzrtdhcoUpXPP4D9B/UYM3YqLe2EVprmeXJfxlJoHtmXJ8xU7JnCpWNBqUmrRzULuMv+trJOQC4y0b9m4R+Ms4Gt14b+/d1fcOeCFUcFEyDDFtRauKElebCMnMLGgE+obtTJS0MPl7FkCBtsIhg0PaG2mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745871892; c=relaxed/simple;
	bh=iuj2UIPux5IA7lvqdJyE93atgaxxxkVkt1YRBWJxwGQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KKhoeqLTmCd28J1MMTPD+e3ZIfREoHcV/g7mBW75f6oLA3Qqxfhewit/XB0duHOMw8OSp+AkOy4bdK9IioN7g8+74s3uewcf8koAxhDC2S2teFqEl5UqEq3DFNVt87YtOUYIQ5OJf70J2l6ooj1dTS7EHbNQvGbzGztXqLRsVVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHZ7R5jS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHZ7R5jS"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-441ab63a415so6803625e9.3
        for <git@vger.kernel.org>; Mon, 28 Apr 2025 13:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745871888; x=1746476688; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVaOf2y3p/sfBCh5CITZU2ebpDzsW9paiPGSg/OQetg=;
        b=ZHZ7R5jS+zb0pvjDTH8Gr/12Om91zvCck4asLzBTBCLRZ7vbeyG9FNxys0oFx9dWp5
         r82y5OnMVxoMcCBQfSCzDsiQTEhEcU2i+J+FPeP1JoO/7xpfUXDiWfK7Xtr8vi4m5pDN
         pJlzn8D2yw0O8Wld7yzDgvZLu0dmSLx/M55kt0AwI9JO2Amv5ZVlpX/egT2NGDcIUKpv
         HcMyPLe9ehK4cHj++yrrUABgv9+BHU1aK3IlkEh02g4UC0yI8ti8xhaIHOdf1jKFBb0T
         9Z+HmsT3yeR/iR5mE5ciRzWTrr4bNfgX4YMwoGZgcob2RrKXI8T08ghMSYhBEA2kpaS3
         prjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745871888; x=1746476688;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVaOf2y3p/sfBCh5CITZU2ebpDzsW9paiPGSg/OQetg=;
        b=j8JjeAtHqykzsR2Mem8mWu0HXHnNjxehbqnpS4plTvyjswgEiFiE2etxrE76v2MVDZ
         Bp1WZ1/ZbeJ2mY8xuOQc+cFhgBFTX3rVomfrVQPK8VHFQuDosL2elLeBsF9nm4EFQqmK
         IB4zBqz7M1/gb42mkaVdpdWTYp78dlYbJFWwNK3gEMNiR+UVHSs1i4rVPGUwDmAcAolQ
         fpwt5+fmGgg6bJJBjbZZcI8LU00CopjqPVAtsTdqV2VZcfx9EJo4DFy3OzRrTpFTxNag
         ZPB6RBBkPXp2mcA/+x5ZB3pCmqrOuRpT40RiHcjfKisc6hxr6ASAzZK096MFWTYg5hZa
         fWow==
X-Gm-Message-State: AOJu0YzACC0ZdaTOORwE4Q32fLe68DCgkI3smvIs1OO5B+2waFR8aSVG
	oKTk6NpP3sbnPjE0yakGLwKTRicSaMonMbbP6Rgn5YSu+bD8VxhB7C+BOQ==
X-Gm-Gg: ASbGncv0mOTFmqrlki9U9xo36X6Rpo4/eWVGsBL7UgKjECggZIX7E+NQYvwduanyf0Q
	aR/BdDrnz4VGvu+eMDHi3iJvtUa3Zr9mWvKN91MNoY6C8hv5J+3QOSVOS8F0yDrRjOuETiW04xN
	pFX61X49xHrMBsL8veMcuMHWDsMb5moG2J9xZ3JqwpQacX2QXLwJcmHur46rd0Gl2960BmB8/EM
	G9jwU17cxOF2IsfO0O4GWDpwKWPP3vAzMqne3rgh306cKQkb8QsGne+B7iMEd5ggb3oBy3A+fBD
	ChnVKuXAMLgNajsbQo+jcc7BIDQ6lQYPdwgxlqDHOA==
X-Google-Smtp-Source: AGHT+IHtZ+hyx8sbHanJJZwljnBAoUTBX6xwADKTmqHzfsIk9ew4VucqmMPQKYyxaFGgrSDIb5wv7Q==
X-Received: by 2002:a05:600c:500f:b0:440:6760:d06a with SMTP id 5b1f17b1804b1-441ad3a85eamr1110035e9.5.1745871888453;
        Mon, 28 Apr 2025 13:24:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d29b990sm171553075e9.4.2025.04.28.13.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 13:24:48 -0700 (PDT)
Message-Id: <53a990e69eaf9564e6bb7a38f9205a17283321de.1745871885.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1906.v2.git.1745871885.gitgitgadget@gmail.com>
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
	<pull.1906.v2.git.1745871885.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Apr 2025 20:24:44 +0000
Subject: [PATCH v2 2/3] t5309: create failing test for 'git index-pack'
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
Cc: gitster@pobox.com,
    peff@peff.net,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

This new test demonstrates some behavior where a valid packfile is being
rejected by the Git client due to the order in which it is resolving
REF_DELTAs.

The thin packfile has a REF_DELTA chain A->B->C where C is not included
in the packfile. However, the client repository contains both C and B
already. Thus, 'git index-pack' is able to resolve A before resolving B.

When resolving B, it then attempts to resolve any other REF_DELTAs that
are pointing to B as a base. This "revisits" A and complains as if there
is a cycle, but it did not actually detect a cycle.

A fix will arrive in the next change.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t5309-pack-delta-cycles.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t5309-pack-delta-cycles.sh b/t/t5309-pack-delta-cycles.sh
index 60fc710bacb..6a936763302 100755
--- a/t/t5309-pack-delta-cycles.sh
+++ b/t/t5309-pack-delta-cycles.sh
@@ -75,4 +75,28 @@ test_expect_success 'failover to a duplicate object in the same pack' '
 	test_must_fail git index-pack --fix-thin --stdin <recoverable.pack
 '
 
+test_expect_failure 'index-pack works with thin pack A->B->C with B on disk' '
+	git init server &&
+	(
+		cd server &&
+		test_commit_bulk 4
+	) &&
+
+	A=$(git -C server rev-parse HEAD^{tree}) &&
+	B=$(git -C server rev-parse HEAD~1^{tree}) &&
+	C=$(git -C server rev-parse HEAD~2^{tree}) &&
+	git -C server reset --hard HEAD~1 &&
+
+	test-tool -C server pack-deltas --num-objects=2 >thin.pack <<-EOF &&
+	REF_DELTA $A $B
+	REF_DELTA $B $C
+	EOF
+
+	git clone "file://$(pwd)/server" client &&
+	(
+		cd client &&
+		git index-pack --fix-thin --stdin <../thin.pack
+	)
+'
+
 test_done
-- 
gitgitgadget

