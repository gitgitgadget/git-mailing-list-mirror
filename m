Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F42356764
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 04:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781323582; cv=none; b=mA99ce/cSxomBa1pYadSXziCE2mMA2KW0mAGRbO4j0TXkfN5xZUgF2gXa1/RNCOCfkTNLCVjpZhj3pnNW3YsezAIMDrRCmCwYnKtk55e8wNL2z6m7HK8hDtr6q3ZKyisEgn+Cnx9nNl1M+RuhBlJm7At9RDYWpOFhPN3ljQdM0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781323582; c=relaxed/simple;
	bh=5QDtg6gzn37OdXVFwU/xCOt2PUS4gwEGaDhfhysl5r0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OtX0z/lD6hGsqNDgEbyCDbgOTYlMatsvL4IrXt//IbqWKw06h1hnteFrmvx26jAYczCmL5y/1u51RWMBbi7dTLqlhh83Odk3MMIpxaHLxpEuh5Sbgjio30MgwTs9KRoJzYVN27jiJP4Ui9BmLmcC4gByUFdcc51dQgL3W1cmhYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrJOPaoG; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrJOPaoG"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-137dd523634so2301669c88.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 21:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781323581; x=1781928381; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESq2YLqEO5HVk/FTETy5sagY2SS89Ig05qva2heSvY8=;
        b=TrJOPaoGT1vhd7ktKPluLHz5zmyXfXxqmlQNmROdhWfwNuGDtBFZp+2/OQgTOXPiej
         50E0dUFH142krOr8qudDz/pkQO0f/wpz+hmKY9u3WHKsWFUXGd+yz56IMROlSBidF+e9
         T9yoCEUElfgb9s+ghvlJgom5W1gk97yHAzrk9MkoKSsZwBCE94uAJf9k5FqqS3GXwu7U
         RUrZTu1J/jB39+6Ucij1RpjZB8dRxBl8bAb35SW2BPbSg84qAPUqhJvVBSl9uHWuQKd5
         UW9+s321nlP9uSx1pXsuh7AcRHKDeW4ZYYEXqUYUz6cRhb5A1AvuMCHJpoTaNchzJsxu
         2gGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781323581; x=1781928381;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ESq2YLqEO5HVk/FTETy5sagY2SS89Ig05qva2heSvY8=;
        b=WCUfSud5NoU4WTcGKTeu5Wmv594ksiy9nSRDwtKKk6c3+mD2pQhK7EtdNh46INrBaW
         ubhIDgbIsLT1qkk7ucwwKL4DQZuaY5EynhAj1lt0EmohvjKloz+PdiBeyNPKVu+SHxup
         5TNKq9NNJ12PLgeE/APe2Do1B5SMNOhGPx/+PmLvWn48WD+SfArfahNlZnV8Iqr3usvy
         fJwPpBWI3WTggnlnJeqjtHbTpvIfQuXe50qb67a1F0fcHLL4RDM4HSi0SdS0z33OtnDl
         q4nwdu9s7UDZaGOsY5CZQdiXz8/nLN9/gQI/3AREGXwSkAOn7dfftgel4CRAp8Hx3k5F
         oEXA==
X-Gm-Message-State: AOJu0Yw2qTNRI+1hT9lcOn6l7C0dPDCBALwQyd9RTxuStXmGb3DmsjZh
	mQrXVU8hPyWkyXY9kCHWxuR5rtNkb6hTjUxewGPs2gC286PgNlro5xwpPA3FKw==
X-Gm-Gg: Acq92OFLKQQO7GktVd8JmnmS9CKLxPn4gW/RSkYObvLK4DnQmICDOi4p4p97Rtygmdq
	ZcnpZZ742pT4kmAU4zB6ZAjVEQ1kKeo+OQcRFl4QRdmNWNtnXxd8gW02jVB7CZfdRrGNQ/9M+vt
	4jYrCg0rYlX30LGz2v5fMvz8U+LTAo5FEUjGyNXvS79p1RLNgp7bb6e7jOKhWC/wwTqY178rNSe
	7rk0+386yn1+oHwY1mQduwnT8dutqeP43EsW8pTanrNoiP1JrpBdBGZKgg3Ghmu9ePZ9/b2fFqr
	mV+rOKp7R76jQbuws0nFzaDN7GIk19e6nkwUqXk6XB4uduwpenwiJjZ+2rYzT9xBclDs0KML9J7
	Bdi6RIpXF3guseF8+bN9IhJhvFNC6ojBVoTUPiQjeQhI1FDzmsh70cA0X4qYBUM+T5hnXVxGtUG
	tXsRqc7XgBukl1UvNoqluf7dI2
X-Received: by 2002:a05:7022:79a:b0:137:1ae1:bc2f with SMTP id a92af1059eb24-1384bafee86mr2066657c88.13.1781323580580;
        Fri, 12 Jun 2026 21:06:20 -0700 (PDT)
Received: from [127.0.0.1] ([40.65.56.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b9110d3sm4461968c88.5.2026.06.12.21.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 21:06:19 -0700 (PDT)
Message-Id: <5959cab258ad6c5099e1aa7696416cc2376b3a3d.1781323575.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.v2.git.1781323575.gitgitgadget@gmail.com>
References: <pull.2135.git.1780559158.gitgitgadget@gmail.com>
	<pull.2135.v2.git.1781323575.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 13 Jun 2026 04:06:10 +0000
Subject: [PATCH v2 1/6] t/README: document test_grep helper
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

