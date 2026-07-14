Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37553B6BFD
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031654; cv=none; b=MbsPbFxwmAV/G/nY8S7waUU1/sWx+3+0ZKJkTaXqovIHcbnQuSeih4DVo3YMNzfY5c8yGuQKX3E+Z/cwcIbZs3qb7aplRkpuAQxkSW/VD03q69sFjMC/4qBskT2LzS5a2IUEbtWiVtvAylTF62T1yWNJqOets/ZGMfFenyNLqoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031654; c=relaxed/simple;
	bh=13DCPw9Jw2ImFpv1fsgsS4DvuAirXJtFImbdrXBbMvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VH03kPTQQjkH2a9UFmeu7iPJwsi3+QKVIBUTnvZ48tyPWcs/TbUv32C80nhXePcSIXxCk4j4HlCA3FYRWrYqTc/xvdquOJecmIMu2d/3RnuReWOwK925rFoxqw9hR0UP5WV6tCVbmlvgAcjqurls1NpVGhwqrievx0hFZpI+aXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhcJjqfE; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhcJjqfE"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38511175ad3so3374575a91.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 05:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784031650; x=1784636450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LvASQhINDA8e6fV4hlddcOMMhOPDwLFe6tKMN3Zv42E=;
        b=jhcJjqfEebWVEHSNDtXjmkFx4Vny7cfZu3tWOgdK5mn/Q9lAZFkoWz63afJzIbwTWU
         kvj1oj6LdUfBAxaGLwbU5EnOmoNNqxj90h9AIFHEOjSrLRcte1cEhd6Pq8yzYl74TM6S
         E0txg7Fpq/vs1Kv9Qg4Jo2ueQhfwOcDErdwBgGjf8Mt9SlyTPqPvnd2Ge5/vvvAtR/fQ
         /dYqplyK7TurmME7PIQG22IDYJvnJz7m+pNYpY0+QkIPAZHLTSdt7SaBk9CI1H4ee2nG
         MrSn7oGzwJF45YQ3sashzhHpNUl7EJb9lA7SHNA/OiKnB20GAYKyvQG9f/rsJ75RDs+X
         EcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784031650; x=1784636450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LvASQhINDA8e6fV4hlddcOMMhOPDwLFe6tKMN3Zv42E=;
        b=sDKsvdTygelIIx4+sI1bJ0klIFr+Dd+HlaXUp1VHgbyQjl0v1BPN+c//Hx0O0dlwzE
         d7hv29344qoTkZbTScjBPzCF8nGhpKb66lYIAnI+lawNx39rPdBl9mKst6mvFF0OQtNQ
         6E8BF2tbfM4suHZpYyGd5c9G544gshyASKgS2z5+E0ZkvP5EvCrFnGipAZ/Nr+dmlsem
         lqpW693b+yO3OqgK/NOTL3kY43K+LHfUrUHk9IMtBxY9RMhOOOJIrNJw0FcVu+wMQ83Z
         bZ3nM3jBaYOJibJ7NR1MI2xTQmenVcEwdPuBPtOl50gXj2g6UylUAFICSDTOyREnflig
         LcNg==
X-Gm-Message-State: AOJu0YzdJoIa0B5vdr+RIgpLWI8Cpf/yWqL/il2YNU7/wxzHy3ElS6fH
	HqkSdbDSRiXlB1Le+v147b8du126VxHNNZ0CnMuvA1hIzOMaMwTMXPlznFi8Eyle
X-Gm-Gg: AfdE7ckpefTgqkKjwrBtLVzMRLLnhJWbvbValjq1bip83gYWLKWDsVh38nXracWTyJV
	SUvSN0q8cSZGFgwAo6bJD7kYV/rrE/GeilvL4MNe1QULiuTFBjuz7Xgz4JZb+3eHeJgTFWo5IXO
	bb3vcqxws9JolkG+ReO0Xh0R0DcoL2Dp69vgX7HhqF8AVCVww92iRTypVsR+fQaqS/z5YMV7MsV
	38MRlUV/+HLYHfOYjZcyZgK4wzmVTg8VDWCNULU3MWIrrEu4pKtrKg8fm957LStCXCwNTKGGa6U
	5OKhAx1XypQ08MZePirKeD9NJYocwCuntf1G+DSqNAECTQr1JNbACvC57wJ+fNeN6YMynhAkFFy
	ZKfRbNPiy3Hxtr1zkXHHd/dufdM5zxD0zjL5iMANMfayRKFSad5yWEsVIs6OuRghzbchsqBGcQh
	LexIFZJH9+mMlAO8MKW/lzIkq1kwqv0m94Zdrp+0DZfLhdCkE2
X-Received: by 2002:a17:90b:4f84:b0:38d:eaec:4383 with SMTP id 98e67ed59e1d1-38e1afbf3d3mr2357812a91.22.1784031650107;
        Tue, 14 Jul 2026 05:20:50 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c0a:50c7:895a:a6b8:b3bb:5640])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4cbafa1sm74390182eec.6.2026.07.14.05.20.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 05:20:49 -0700 (PDT)
From: Shlok Kulshreshtha <diy2903@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Shlok Kulshreshtha <diy2903@gmail.com>
Subject: [PATCH v3 2/2] t1100: move creation of expected output into setup test
Date: Tue, 14 Jul 2026 17:50:33 +0530
Message-ID: <20260714122033.61947-3-diy2903@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260714122033.61947-1-diy2903@gmail.com>
References: <20260714071633.35446-1-diy2903@gmail.com>
 <20260714122033.61947-1-diy2903@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "expected" file is created at the top-level of the script, outside
of any test. Code that runs outside of a test is not protected by the
test harness: a failure there is not reported as a test failure and is
easy to miss.

Move the here-doc that creates "expected" into the existing setup test
("test preparation: write empty tree"), using a "<<-" here-doc so its
body can be indented along with the rest of the test.

Signed-off-by: Shlok Kulshreshtha <diy2903@gmail.com>
---
 t/t1100-commit-tree-options.sh | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/t/t1100-commit-tree-options.sh b/t/t1100-commit-tree-options.sh
index 9a639f946c..3e888909f5 100755
--- a/t/t1100-commit-tree-options.sh
+++ b/t/t1100-commit-tree-options.sh
@@ -14,15 +14,14 @@ Also make sure that command line parser understands the normal
 
 . ./test-lib.sh
 
-cat >expected <<EOF
-tree $EMPTY_TREE
-author Author Name <author@email> 1117148400 +0000
-committer Committer Name <committer@email> 1117150200 +0000
-
-comment text
-EOF
-
 test_expect_success 'test preparation: write empty tree' '
+	cat >expected <<-EOF &&
+	tree $EMPTY_TREE
+	author Author Name <author@email> 1117148400 +0000
+	committer Committer Name <committer@email> 1117150200 +0000
+
+	comment text
+	EOF
 	git write-tree >treeid
 '
 
-- 
2.52.0

