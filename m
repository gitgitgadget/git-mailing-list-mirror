Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0C53C062A
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621412; cv=none; b=r8vEJUC7hzdbwX6oKuIYmD53KxCE5ECvO24KqCXYRvEXF5sTLGPctnhAmCvVkjXi5C0UKURfH6xhLWY32d3gZCLwCJXy4woLH1226Qp13A+nOceMFsxKFfUJIB3fRMwMoIXfAOvoKX7CIjOR6pP4Ibfo2FqonGdq5GBga9H/BJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621412; c=relaxed/simple;
	bh=U1W508UgiLLlKAEubLbQUCYMc/hnrClmjgDFhqeuATk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eCb+E3mKZ3D9pDtaUfuJAInugw7+a4wN5vCZSb73bMTSPgB4Y3VSejgDtgZggw03wKbpK8cjxLRp8bcJgeajxpK6Xyh8pOLM/nP+oQexZBRrXz6LaD87IaZ57dbPg9XLVV9DxT9G/XS7F94ptCPhFMgXBX0ADe1AaN2w3sUb4+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dl4Volr5; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dl4Volr5"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-915d17e2721so659502085a.3
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 07:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781621410; x=1782226210; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYpoF6QqLLZenLhdP2gMzSbswL0pIsMFgW6dfmoktRY=;
        b=dl4Volr5mCxeZ8eX9A6YnTQpz1fSI9ZOgi/Skx6edBJXLkgrDYCs5zOLueZFYPSVvA
         Y/dlm5Brvh4EdnOJOH2QMJ/TBAcZrWRFK728b/LFWC8nEZ43+46r0bcF0GG5f+x7t6Sa
         YvmHe6kl/EyRiNMlHUOSTooxCjo190JN8q1LwLHcDG4b/GhYGqmFmSnw9LF7xsU9dOLA
         zLEJLHIcY4ciiEhHffvvUWk/258na2WjO96U5OCmJHbWc6ypdvCRG6l4SUi8WXV4o0pE
         QUXQRGE5eQZ/L7KwGLzd+Ntx/xXJDSjRdt88v5EI2CBAt4o6GCUPKQhZlHsqfWi68RLq
         0enA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781621410; x=1782226210;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KYpoF6QqLLZenLhdP2gMzSbswL0pIsMFgW6dfmoktRY=;
        b=YFSbdTCsNAFj15B7vfWHwGrMLy8T7Ri4l6/st/OXbhDg9uKiBhlQOy5KgFGWDuaOVO
         tpQbqxn6LQakUrAI91Otf2I/tvh+zH35A9ceQkrGb2sHah1E4iYvGWUgJksrPXG2MKCw
         VbzHiHs1Q3ZVOYnZR3gWsST7Ry0BSYNfzfzu8WRZcJc3sMzfDhcoXUtHhyZWQB1XwyNW
         cUrj2tMCgBarZ3pUg9yDc06514ZggOBIS8pLhTw57PIYCPm933Bo0DajPfzpkv1RukS0
         ff7hSHJCcOni0cpz1xKgUQUP2Jmv0vg6Fvu0tTNWsu74nZFs3FgQawTndS7Lnnqi6QPB
         bX6Q==
X-Gm-Message-State: AOJu0YwH8U970SQ9+/rGHyI3Emlv7pKK5W1iLvzEK9o/7qmkk6x/EER/
	TpCCijRPHEAxK7N1nfVZ3GnwxbJQuAOyAyiiW3Wq2+d4Hmr4Ikwszn2SNlqXyA==
X-Gm-Gg: Acq92OEdn7GRUw2ThVydLD6MjFMfeSHPMnLeoRxRUCv963WRDxLp8niKgMXxy7YyRZt
	7a80rSLDsY4I8jBjYd78VSUdWpv1+1hskioo+VcPmhBzhR/QAJ/Jvehr7LMp7lYLLng1lsciOME
	qjFd6+ciFEVDpISvYQgk5Fg9lm+F35lOI2BXh/nE5IVk9dqUitOWK4e25aS2EQIk3/fIur/jiy1
	vgd/Ydi3XiY880GStTU1WBYuHy6s12+2j0f4rCAoaPKE+G1lHxkrBFo+UALRxkNZq78OyOy6vUM
	PgTx0oVy2CWTQ7Q1uPrxEYGIKysv8N7y53aH/PX98ElV+toUCAdAiQ0P3801REm2zV+jgDFLWsB
	L5KaT0SWy9wvrbwLupOCLv12pr1iBkqB5u4hpUjQe5Z8pVnQv+MySFx9TlSb3TVfXe/HjlXT8+e
	ha9GpgDKwdoVvQYVRN6FhGHOQPvQ==
X-Received: by 2002:a05:620a:2303:10b0:918:4ca7:8482 with SMTP id af79cd13be357-9184ca78669mr1640055385a.26.1781621409762;
        Tue, 16 Jun 2026 07:50:09 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.77.160])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a04f5b7sm1478055485a.38.2026.06.16.07.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:50:08 -0700 (PDT)
Message-Id: <e6bb4e6228da676cc9736acad1fca3f795933dde.1781621398.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v2.git.1781621398.gitgitgadget@gmail.com>
References: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
	<pull.2138.v2.git.1781621398.gitgitgadget@gmail.com>
From: "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Jun 2026 14:49:56 +0000
Subject: [PATCH v2 5/6] hash-object: add another >4GB/LLP64 test case
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
Cc: Philip Oakley <philipoakley@iee.email>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Philip Oakley <philipoakley@iee.email>

From: Philip Oakley <philipoakley@iee.email>

To complement the `--stdin` and `--literally` test cases that verify
that we can hash files larger than 4GB on 64-bit platforms using the
LLP64 data model, here is a test case that exercises `hash-object`
_without_ any options.

Just as before, we use the `big` file from the previous test case if it
exists to save on setup time, otherwise generate it.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1007-hash-object.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index bcae3fc54c..f96c29ce68 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -277,4 +277,12 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
 	test_cmp expect actual
 '
 
+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
+		'files over 4GB hash correctly' '
+	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
+	test_oid large5GB >expect &&
+	git hash-object -- big >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

