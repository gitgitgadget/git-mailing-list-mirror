Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07641E8850
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 04:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739334142; cv=none; b=iX85Osl0nYmqiMz50JsSaEHIs1ILxFmenYE8p7RKukb+PKffWWQpvBR53mB58wcChBLheMsCiqpWITjOsCER50XWAhuHM+vSUMDDUmNfjSZmqg4tzcXBgtYRhz7PDSsFgOhXMbFu/EP7R4Hb/PW52YAERHr3hmtYFx+VHxguBT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739334142; c=relaxed/simple;
	bh=IDbtOoCNJsb4qfIxsmL/FuuieLx+knaYxhiM2974oX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXR7sTSMSQ56r2QIvIz0MJYH11Om093qV6eXfeM2vy1ul1pUEUhUSpXMChizs0/Ql61ux+5ZZm16eoftOPuJtxAkMUJ58ZJH8CEmDhMkDaQFsgtDxw2JtVeJvhotGTnMoDG9S77uK4+MntB1c35ulHFirs6OFYeyqNVfgN5W+Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/j6NotQ; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/j6NotQ"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5fc7ff13fb8so994620eaf.3
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 20:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739334139; x=1739938939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkUvrzZAPY22kY5GLlkusdDEMTSSiz/WD/gHvy005RY=;
        b=U/j6NotQpevDzua79nGvjiJL0jY/xGrBgVVQ+aDHLeusnavn9eDzr+UQUkNzDsIAd7
         QaJdIFehuLKer7/cEz6W9HdeVqZFtcU8ZOoTyyL/XP2WVBNhMIu1IbxO/yFN81Bn/45C
         Fp87PK2RIFxpzhyWKOdLDTyQIvUiU7CiSIdg7Z77qVoSa2PfdvvLiMBOnC/e25tO1k5u
         3iCdvJnrtTj8qpkAG6RKhu2ZyvRFDUR4d6eC9yMvIM+SP2/Z7l7m619qxdT/MDBXSRxQ
         yVR78c05Cri1o8WNlly4UNgFlqJzvNxCtqU8orrHRLWqxWRbFIWMfuaHwPo/OQ14YVMX
         L0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739334139; x=1739938939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkUvrzZAPY22kY5GLlkusdDEMTSSiz/WD/gHvy005RY=;
        b=A0tEsYSMZctpsf3DHnEaHHSe1X/Y1I7QSffkI5+Re4fjMTpWNBOq3+ppeiyzk0c8Eq
         jC6eP+vDfksTxqylcqaJGeeE29VHKhxjmGvab5ReqpLdgqI2BGPeqmW6J/HDI+LMZE8h
         paD5gReko5rGVlUabxsrqnXjJq3vRlK81dRAYoFnidLMRt7Kx0xt1cjjTXyJ9CHj99zk
         8wARuk+SR4v1lkpxT47gBWInP/YDkdywfLNl7a9rzTfu9246eVtZF+bMZHRilC6nwQUt
         YPSH9FvA7WpPfkS+Iji/09WOIP+XFiyDDgp0b6EkiWVPX9IFgk7CmISvthVmynWBcrai
         FdiA==
X-Gm-Message-State: AOJu0YxoeXN5/MOEzcxkWHlqIybjhzdCFF1P/WVQUQSUl1YAkGjRtiZm
	TNr+spv7OOv3gy1FPmPaLmqflf2idW4Rhq283x3so5p+zlNPCbh8vT77Qg==
X-Gm-Gg: ASbGnctMvW+b+D5eOV7t1iwIxFkwTIYETVcKT5nJHAXcdyH2xCNG0zmfwhrM1A4YdvX
	LjkuqIgU8dTqcJJeld2Bkpoho6luowM4QWaBM3e2aVuER6Qy8U9okRBrOURVvpULTzY/sVPdHlA
	UV0owng+I84uVCeFRo8l7oFef5NxDbQY8eGLlLReMsIJQi8dvh+z9qtshv3hr6W+csPu+yS7uFu
	vZdSFXMQts2lRzJVUXXfTjOaJXt27ugbYGu9bhVxC8BRZQ9uAbaLUO/CvmNSK9L2j2Z2XZ1o4OS
	88DDyxTD/AbupATpckcliNc=
X-Google-Smtp-Source: AGHT+IFVajISnyysux2Z5T5pMKHOrcY8uTlsKxFDTG3zW3Kfgg7GPMUxmvjBIYVqNN8wYUzHtmVvfw==
X-Received: by 2002:a05:6870:548d:b0:29e:61cd:d3b2 with SMTP id 586e51a60fabf-2b8d683cc95mr1319053fac.38.1739334138819;
        Tue, 11 Feb 2025 20:22:18 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b8a0bb67fesm2293392fac.39.2025.02.11.20.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 20:22:18 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 3/3] builtin/diff-pairs: allow explicit diff queue flush
Date: Tue, 11 Feb 2025 22:18:25 -0600
Message-ID: <20250212041825.2455031-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212041825.2455031-1-jltobler@gmail.com>
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20250212041825.2455031-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The diffs queued from git-diff-pairs(1) stdin are not flushed EOF is
reached. To enable greater flexibility, allow control over when the diff
queue is flushed by writing a single nul byte on stdin between input
file pairs. Diff output between flushes is separated by a single line
terminator.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-diff-pairs.adoc |  4 ++++
 builtin/diff-pairs.c              | 11 +++++++++++
 t/t4070-diff-pairs.sh             | 22 ++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/Documentation/git-diff-pairs.adoc b/Documentation/git-diff-pairs.adoc
index e9ef4a6615..33c0d702f0 100644
--- a/Documentation/git-diff-pairs.adoc
+++ b/Documentation/git-diff-pairs.adoc
@@ -32,6 +32,10 @@ compute diffs progressively over the course of multiple invocations of
 Each blob pair is fed to the diff machinery individually queued and the output
 is flushed on stdin EOF.
 
+To explicitly flush the diff queue, a single nul byte can be written to stdin
+between filepairs. Diff output between flushes is separated by a single line
+terminator.
+
 OPTIONS
 -------
 
diff --git a/builtin/diff-pairs.c b/builtin/diff-pairs.c
index 08f3ee81e5..2436ce3013 100644
--- a/builtin/diff-pairs.c
+++ b/builtin/diff-pairs.c
@@ -99,6 +99,17 @@ int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
 			break;
 
 		p = meta.buf;
+		if (!*p) {
+			flush_diff_queue(&revs.diffopt);
+			/*
+			 * When the diff queue is explicitly flushed, append an
+			 * additional terminator to separate batches of diffs.
+			 */
+			fprintf(revs.diffopt.file, "%c",
+				revs.diffopt.line_termination);
+			continue;
+		}
+
 		if (*p != ':')
 			die("invalid raw diff input");
 		p++;
diff --git a/t/t4070-diff-pairs.sh b/t/t4070-diff-pairs.sh
index e0a8e6f0a0..aca228a8fa 100755
--- a/t/t4070-diff-pairs.sh
+++ b/t/t4070-diff-pairs.sh
@@ -77,4 +77,26 @@ test_expect_success 'split input across multiple diff-pairs' '
 	test_cmp expect actual
 '
 
+test_expect_success 'diff-pairs explicit queue flush' '
+	git diff-tree -r -M -C -C -z base new >input &&
+	printf "\0" >>input &&
+	git diff-tree -r -M -C -C -z base new >>input &&
+
+	git diff-tree -r -M -C -C base new >expect &&
+	printf "\n" >>expect &&
+	git diff-tree -r -M -C -C base new >>expect &&
+
+	git diff-pairs <input >actual &&
+	test_cmp expect actual
+'
+j
+test_expect_success 'diff-pairs explicit queue flush null terminated' '
+	git diff-tree -r -M -C -C -z base new >expect &&
+	printf "\0" >>expect &&
+	git diff-tree -r -M -C -C -z base new >>expect &&
+
+	git diff-pairs -z <expect >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.48.1

