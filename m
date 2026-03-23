Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBF53815C7
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303190; cv=none; b=BD8VLX/liY3FUjamQVZjz/VDyNqFiXrvXicVHqJfavZzpZ7LrQmVRPuG1TP0dwh8BBrzm83VLHwGG0t/+/lNEfrN/SJFnr1jVolym2U/VBe43jAd51ILr8yNVgd+iAHoqklZFxLTs4n5OWq/aTN6XHw1QSDLm2Cw9FWXP8ao+nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303190; c=relaxed/simple;
	bh=6Lh741IjwQ7VZygoyOwus9eIYHZDLYLVbW8SRxCnCtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZbWa/KILEBCo8pu9cINqu0AQdYUu6oG9pIq2t3xze7E84RJEBeCdat659QpYHVryHurBY1DxEgxbCsaHcnCkghLFCGECR9AYl7Ql98d7zILnL9m6IhY/CFYQpwPbYBQ9hdFOavfaBbkp5gth2zFydmaA2BexZeXJ7xZ6c25hHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSRPt7x+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSRPt7x+"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-486fe655187so42727545e9.2
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 14:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774303185; x=1774907985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdPPxUjhUqSfMtI2oZlgOmGjhEbrZfBMJ1876iKoYnY=;
        b=cSRPt7x+crReR1Hl1WFW4P3uFX/T2xufnjKwYYrUugZoElBz7vvv1MriOkCBhtc2Ob
         6pwHQGmdqNR/jXEZIv02cSoCyZwGUJ9gbj5wH2VI+Pfi4GFd7YE2fKAKe2F1DyjT+SCy
         9Itn95ppnCulxHJjdD9cdlrkZ4UDbkjp26nKFv670dffo05CyK+X/dC3eaVVptqbus/k
         0nnS5ksOiJaXuprNZWf8IqtY/QNBpLXgRYG3R3tiEk0Iq+MQlbm789CIqbUQ8M7oaP20
         huvTDnqVOERwOnb0LEZj7N3HGDEaB+W0bsoJS0IVskxm9r6ROm0nX6bStWB+dPwMFwOB
         FAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774303185; x=1774907985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IdPPxUjhUqSfMtI2oZlgOmGjhEbrZfBMJ1876iKoYnY=;
        b=r3myPTPBoj/eBfg2+kR896pYYeE98UtvWyAHSZDDXgWQTznXb51XSr9e2oRFshbCB+
         9nsI//b/BAwIyASkAIZlB7sFcyFfHLiJ1xMyF9qa7Zk163yrOTZg4685ITslm9HweD+y
         8MXtzqckdQ0ohp0aPKPcFeWVDV6N/nCuNiW6Gawt5DIZ95v2egKqniQ+7g3BzQhkz+45
         BoyLMB/rkVoa5Ozq63GfnKror+Ijq/6s+pbRjFkdybtGo2YA4SGZPsrN64o1Pnqcufpm
         5W1AvfhiSQ0X+Zkul0b62CmV54Sc14kuutFt0ZbYiDiXV5/qUsIgpQ5coQ8Wv9bndOAd
         yxtw==
X-Gm-Message-State: AOJu0YwdoP3MgHI/fF5KatmdLE9x39qITKss2+NXe6BZm+TtOwEWn57M
	VGROeYipF8E1of6NVgVbSat6ZImXE2YfTpMpn39bZNJKVgbgv0QLEnq2mB1xnxAodUGXOg==
X-Gm-Gg: ATEYQzxZvdkbwLITd6JRsLcSBW8VyLmwIe4xzXtQxHrBE4c86mS7fKoc1cuxWNNbZns
	sjgSuKQS2CeZPGjoa1rCzAJ7fn+x9XaWZGBP6g/qVnJdwpfyE9bsd2gWErf+LgaDtR6YNDkF767
	A9HIrCc/ycRu8QZZQq0vWtjdUi7+wJf2aii/OXeJ/H/IDM9Q2VeD+ne/bj2JPn1RrB8eEUILE5p
	rfWl8ntDhns62zz8O8wyRAcI42tW0oI2FHVwUFIGSwig9H323fB+GTfIkA6N1Ryi6JB9l/VWoPe
	q8fbRfwGz0qsH8yxah2p5WOkba1ISqEYMz0WfNE5OSnmXj1WmOptojXSbeBep6WKBrluwYP61st
	mGIlULAy3iZKgkcPialEMd+v49mhCct2wL0Fd3skRzFr4iKywWpqRoj2mAph5Q1gnX9x49bHo0e
	dXir8Gs9R535ndDfj0Wg6gO5h1WATV4IW6q15WTBP16ZEoKcvcvu4AiZrT07RLtylB9QUjD47Tu
	q9YGH0CTh7Zxj6fOhM6jF1mc45/dyWFwAxdlyUplZG8XLiy0W2fWjqW07M=
X-Received: by 2002:a05:600c:35c1:b0:485:3b50:fe54 with SMTP id 5b1f17b1804b1-486fedb2545mr228404395e9.11.1774303185230;
        Mon, 23 Mar 2026 14:59:45 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711693a08sm2734015e9.2.2026.03.23.14.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 14:59:44 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	chandrapratap3519@gmail.com,
	gitster@pobox.com,
	j6t@kdbg.org,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC PATCH v4 3/3] graph: add documentation and tests about --graph-lane-limit
Date: Mon, 23 Mar 2026 22:59:35 +0100
Message-ID: <20260323215935.74486-4-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323215935.74486-1-pabloosabaterr@gmail.com>
References: <20260322195406.108280-1-pabloosabaterr@gmail.com>
 <20260323215935.74486-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document --graph-lane-limit option in rev-list-options.adoc with
--graph option.

Add two tests in t4215 reusing existing graphs. The first test
limits to two lanes on a single tip and the second one limits to
three lanes on multiple tips. Both tests check that everything
is truncated correctly.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Documentation/rev-list-options.adoc |  5 +++
 t/t4215-log-skewed-merges.sh        | 53 +++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 2d195a1474..2b5a1794cd 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -1259,6 +1259,11 @@ This implies the `--topo-order` option by default, but the
 	in between them in that case. If _<barrier>_ is specified, it
 	is the string that will be shown instead of the default one.
 
+`--graph-lane-limit=<n>`::
+	When `--graph` is used, limit the number of graph lanes to be shown.
+	Lanes over the limit are replaced with a truncation mark '.'. By default
+	there is no limit.
+
 ifdef::git-rev-list[]
 `--count`::
 	Print a number stating how many commits would have been
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index 28d0779a8c..650701df42 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -370,4 +370,57 @@ test_expect_success 'log --graph with multiple tips' '
 	EOF
 '
 
+test_expect_success 'log --graph --graph-lane-limit=2 limited to two lanes' '
+	check_graph --graph-lane-limit=2 M_7 <<-\EOF
+	*-.   7_M4
+	|\ \
+	| | * 7_G
+	| | * 7_F
+	| * . 7_E
+	| * . 7_D
+	* | . 7_C
+	| |/
+	|/|
+	* | 7_B
+	|/
+	* 7_A
+	EOF
+'
+
+test_expect_success 'log --graph --graph-lane-limit=3 limited to three lanes' '
+	check_graph --graph-lane-limit=3 M_1 M_3 M_5 M_7 <<-\EOF
+	*   7_M1
+	|\
+	| | *   7_M2
+	| | |\
+	| | | * 7_H
+	| | | . 7_M3
+	| | | . 7_J
+	| | | . 7_I
+	| | | . 7_M4
+	| |_|_.
+	|/| | .
+	| | |_.
+	| |/| .
+	| | | .
+	| | |/.
+	| | * . 7_G
+	| | | .
+	| | |/.
+	| | * . 7_F
+	| * | . 7_E
+	| | |/.
+	| |/| .
+	| * | . 7_D
+	| | |/
+	| |/|
+	* | | 7_C
+	| |/
+	|/|
+	* | 7_B
+	|/
+	* 7_A
+	EOF
+'
+
 test_done
-- 
2.43.0

