Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DB82E64C
	for <git@vger.kernel.org>; Sat, 18 May 2024 10:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716028378; cv=none; b=Up11HhLZ5wo1OZ5LE7s5MJMBTABjoipweQHHqV3Ts2ncac3i7f1RiyDymPJ7vDl39rmHsnu3zHkk8QZOqRty/XAGFMPCv1mXdmV0R5YIU8PpUqrSj0hWF20chbU/88JZg2RjrSOgkPRHCitJhgAyewZwhcpUw00h2wTuu8KcAJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716028378; c=relaxed/simple;
	bh=9GRY60ElemT9DHs8npnd8hLlNR8z3x1QzrFwTtQ6KpE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LufRgA7g7gQJ2NA6+i0W2yXPFwzXYHF3OlNvodTX1ykY9eUNEFu4Sa8pHw7/mcGd6nN1UlK+WJaZJBxc9rtP9Vsyrrm0CLnYIoGxwV6tuYX0tppaNCodAipuSXHNjp6eqdGrGZB7QwQgn1Lob/t7XvEl6OQUi3jUsxhgF1NN04s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOR6+B85; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOR6+B85"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34d8d11a523so555500f8f.2
        for <git@vger.kernel.org>; Sat, 18 May 2024 03:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716028374; x=1716633174; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Hh0zgo3PA9OZD3gGP/KbTGUs6ILXCU7En0Epx60GCc=;
        b=NOR6+B85dwDX3GmPlIrg3IypK6PoJONNmrGQFXWn2IefNEKKq0JqDKM7AQDtnDpkHm
         bnydIF9FHGM2Tp8VamD4jKIHhV8VbN17yeXIOUGMboNAyuM5UR+lHLIG3NodRCQoT9M9
         dCluxmr8hit5582dpuDtx3fsUR+RHKMXf5g4AWY2YPG56NxmcgHrqdlDjLfAo1SsYM7Y
         Mmo9i5IDXu0rnLIUsRJw9/vnIcDlbgpKLvb9GR63g3qjR7scNEmr+HXqMjWPBsAb7QIG
         hCs3EGkklvKRa9+5sYovXkUVZRZm8WhIYrF0J9CaWiJVUK5FRBR5Uo5Bs+xNUxZvyDBA
         yU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716028374; x=1716633174;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Hh0zgo3PA9OZD3gGP/KbTGUs6ILXCU7En0Epx60GCc=;
        b=vxnmEfSVYhfH9YFWZAeS7MaWlrwRFV+ZhGeGhIAIu1+7qIYY9LAcdgWZkEMkTTMsFq
         UVuQ9k1daf5cWZN37ulyYSjZmcoYHNoDGm/Ur2mYOnPcKBhMvsI8s13abzGMN2PL3S5X
         2Dt4qXIsP12fUXTfBaPwcAALYfrJOIZADyxqp3WKb9ZmwhQkA2+V3SHbVjipnc3zEODH
         Q0ry0Q3S80+8uh4apEBlyE8n8BZc5rgmMJfBOVr9eOYfiy1+Jkp/YirC4h6Xw8ODZAnh
         IYiMNJQstVXitWbZPBz05l5/B/0iuddUBw44wZugNOq1sHlXtrz/V7rwP8dzfxck7OKt
         1KfQ==
X-Gm-Message-State: AOJu0YxZf5OnB7ci57v8eNayIQAw/n8HC0haSVcYsB1Do4FdaBWexXPZ
	xJENweCK8VE5e+m5X50FWB/FeZaW5BsSXiOzYcPjpNZlBBA4b/DAZioZyg==
X-Google-Smtp-Source: AGHT+IGmdunucJdvg7kh3XAzFBbeH0YuPXCPMCcq63rzEt2DejhVZAu+4YeZcI01waUa5WiFhQftcw==
X-Received: by 2002:a05:6000:551:b0:34d:ae55:8fb9 with SMTP id ffacd0b85a97d-3504aa6339bmr16909461f8f.66.1716028374389;
        Sat, 18 May 2024 03:32:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bdbcsm23732153f8f.23.2024.05.18.03.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 03:32:53 -0700 (PDT)
Message-Id: <cd14042b065e57f132c27d09005242fc500439e4.1716028366.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
	<pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 18 May 2024 10:32:42 +0000
Subject: [PATCH v2 4/8] tests: verify that `clone -c core.hooksPath=/dev/null`
 works again
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As part of the protections added in Git v2.45.1 and friends,
repository-local `core.hooksPath` settings are no longer allowed, as a
defense-in-depth mechanism to prevent future Git vulnerabilities to
raise to critical level if those vulnerabilities inadvertently allow the
repository-local config to be written.

What the added protection did not anticipate is that such a
repository-local `core.hooksPath` can not only be used to point to
maliciously-placed scripts in the current worktree, but also to
_prevent_ hooks from being called altogether.

We just reverted the `core.hooksPath` protections, based on the Git
maintainer's recommendation in
https://lore.kernel.org/git/xmqq4jaxvm8z.fsf@gitster.g/ to address this
concern as well as related ones. Let's make sure that we won't regress
while trying to protect the clone operation further.

Reported-by: Brooke Kuhlmann <brooke@alchemists.io>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1350-config-hooks-path.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path.sh
index f6dc83e2aab..45a04929170 100755
--- a/t/t1350-config-hooks-path.sh
+++ b/t/t1350-config-hooks-path.sh
@@ -41,4 +41,11 @@ test_expect_success 'git rev-parse --git-path hooks' '
 	test .git/custom-hooks/abc = "$(cat actual)"
 '
 
+test_expect_success 'core.hooksPath=/dev/null' '
+	git clone -c core.hooksPath=/dev/null . no-templates &&
+	value="$(git -C no-templates config --local core.hooksPath)" &&
+	# The Bash used by Git for Windows rewrites `/dev/null` to `nul`
+	{ test /dev/null = "$value" || test nul = "$value"; }
+'
+
 test_done
-- 
gitgitgadget

