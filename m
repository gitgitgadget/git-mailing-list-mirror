Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D983E369D7A
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559164; cv=none; b=f51EPMpQOgYDCBH/Rqh7Csxl180ssKj7aPB0VVt0yWHP1CgO7tC24ghrD9OBj4OLOOTIYGDMFouC19vmNIabRXHf1BiIu8JyHmhI6iWDOnNXARDgLXScm/am8nM3lNy7jKXtzGjaE8pIatQxlh6mJJTrfUtQGidp+oN6uj8S208=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559164; c=relaxed/simple;
	bh=5QDtg6gzn37OdXVFwU/xCOt2PUS4gwEGaDhfhysl5r0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GdBnx5X38ymEto1E1cn8oUXmnwxxPQcIUoUS3jBR2msqmC2wqDQaFYhcrn2eK4D7E+f5GuI/9iff+/neXYjBte7vFNTkDPy1q1BTbOayp0a3IBsrTrMkrgHNFSUdSgpul3MEmmyEmUSCzBJ//CnAXaKxwsvEnZt+2XBVsDgCQas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOxhbOG2; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOxhbOG2"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8ccf18ef922so5580956d6.3
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 00:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780559162; x=1781163962; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESq2YLqEO5HVk/FTETy5sagY2SS89Ig05qva2heSvY8=;
        b=LOxhbOG2iEBh68XHATAswrfMnpsMnKMMzJB0KzdyUD1Mz2GwE+HbVjo+uk5lsFcasv
         V1CLPW7f1ie5+kD4Hoz5IE6ubX8AVwqxuBRlGwRmXPzT0YPLpRmk2V01k3lZECwlzo7u
         17UlveyQkRaqrdTMcPrY1UUl5jUnCwm53gEY+z/XH8bnyST/QkMqH0TS8BouQMr+f3kM
         OX2hMTQdRXxpEm5qNDnsE10JNwhKiJdbv9KLfCNsg5WWeIGj82pVdyvjLLRlZ9WqgRz1
         1Z9/i428nnzKk66l+ooIzmanFhx6sL7j4UoB0NyG702XPtEX5BBaNEcHYOtkURbI3NV5
         LLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780559162; x=1781163962;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ESq2YLqEO5HVk/FTETy5sagY2SS89Ig05qva2heSvY8=;
        b=WPdlFMD3ek2oIkcp+XDCeXMzDFtiEzWpob/9hA2bny3Tlst53rzn0YQzXm7W+cVEHr
         imCW+B8B5H7a3250EO5+ftlyLSyLL9UygpvCX9BpEWBcomUHhW5TR7Zh/iWh49IZhKSl
         HgXUUVaAhRmgtPmkqsfpjptsMYDJpqrz4sTzSgdZ5iqZ6UW3a7F4BDSJ08fxISOS7aI/
         h833jDTlGYRxPGk1C6KUs0O5SAcMV4oqBl46wqq3u7BC3ojYOv4X0pgQj6s3yD8sD3vG
         Gcw/21E6rkM5XEJO3NpWhSBaovL5yTsNSJLMEzzAzcJQKFsjdvOxxEw2QoLTnvqldhf/
         c50g==
X-Gm-Message-State: AOJu0YxCqpz+96tRw1tqd3Qdu4HSiCwc2T3q400X8C2oAcGNI1Ab/tpw
	smBd77ns5jZdQxB6aNttRJNcGgaHgesMIpDlNS4bCgs1zHoz+uIGEtenrkwCYwY3
X-Gm-Gg: Acq92OE5oligbkJothZJl7NYiU5eQyDhI64oflQarK9C8u+ct99F2yMprozuxkna6yo
	VcsHJcSfD4AfKGoyC2QdYDz2jslg7v60I8zGXM6oR6q5sTuf+DooSCYHk9b3OlbxOEBYWt0yhLX
	xz7Ye8a/MdQYscElAbHe6kky0kWCQuxxqHu/KRzOrsc1DUKTFKJdWt/YI2vLgTq4o4zgDGzQkUN
	hYm0GjFuZzvGRqIm5qNpyWuUDNMdEC8aF+ZXt4ZWcyrmr0PIgxC6e2/ZgCx/Aq/6tezFBl+CSwV
	cZywq2cNFMMwU3xuZAgbaMWeheJ9MebMEafbJm5P0Zrm/SozNtId+RAr+fuwzjUSnxRN3lwPjWB
	27S7uwTjhxSaJE60fJHcSDhInp0EhZ7iknFq1lRkHFS+50o15JcRuou/poqQP/m9otYernfugFF
	8mOzXh0KsxuR/c6Cd6+Jzv3BgzZUERShIRiNO2
X-Received: by 2002:a05:6214:482:b0:8ce:bfe3:6e91 with SMTP id 6a1803df08f44-8cecdf2a523mr95034276d6.33.1780559161882;
        Thu, 04 Jun 2026 00:46:01 -0700 (PDT)
Received: from [127.0.0.1] ([52.188.86.145])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd0556c0sm45486306d6.25.2026.06.04.00.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 00:46:01 -0700 (PDT)
Message-Id: <43402040bf711e6266cfe664745099b8d3574255.1780559158.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.git.1780559158.gitgitgadget@gmail.com>
References: <pull.2135.git.1780559158.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 07:45:53 +0000
Subject: [PATCH 1/6] t/README: document test_grep helper
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

test_grep is a wrapper around grep for test assertions that prints
the file contents on failure for easier debugging.  It also accepts
'!' as its first argument for negation, which preserves the
diagnostic output that '! test_grep' would suppress.

Despite being widely used (and the preferred replacement for bare
grep in assertions), test_grep has no entry in t/README alongside
the other documented helpers like test_cmp and test_line_count.
Add one.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/README | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/README b/t/README
index adbbd9acf4..c12a1c317a 100644
--- a/t/README
+++ b/t/README
@@ -1039,6 +1039,27 @@ see test-lib-functions.sh for the full list and their options.
 
    Check whether a file has the length it is expected to.
 
+ - test_grep [!] [<grep-options>] <pattern> <file>
+
+   Check whether <file> contains a line matching <pattern>, or
+   with '!' that no line matches.  Use this instead of bare
+   'grep <pattern> <file>' in test assertions.  On failure,
+   test_grep prints the contents of <file> for easier debugging,
+   whereas a bare 'grep' would fail silently.
+
+   For negation, pass '!' as the first argument:
+
+	test_grep ! "^diff --git" actual
+
+   Do not negate by writing '! test_grep', as that suppresses the
+   diagnostic output.
+
+   test_grep should only be used as a test assertion.  When grep
+   is used as a data filter (e.g. 'grep -v "^index" actual >filtered')
+   or inside a command substitution (e.g. '$(grep -c ...)'), plain
+   'grep' is the right choice because the exit code is not the
+   assertion itself.
+
  - test_path_is_file <path>
    test_path_is_dir <path>
    test_path_is_missing <path>
-- 
gitgitgadget

