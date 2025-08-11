Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EE82E3B03
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 21:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754949083; cv=none; b=JLKQyoTrfrSYfKzsokZHPVwbGmrZmywFpRfgUaudgctg7Fxb3z1vidVzWoKIaA8UisTvYZpTUTpEIpEFiM2SoiNEI8u8B7sM+Q1n1RMJeDXIgJSk+tsHk6568fNx6lY0AvsSPsX6Eiw2JZjHHdhHusQZXsoiKEAo8grf+sTDxsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754949083; c=relaxed/simple;
	bh=bLmeyXSHKM8Az49Ee1PjpFuNowdoVfPlCgQV1L1F/6U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kOfkC+BehKPeFFeYSmusUPRVgzpVcBW/RQmJrHg2DFdv8efuPX/PLPxV6nEiVoAjfjCiwi/GfA2hb3YwlghaTIU2jYsiujZlUlPOTSBmWK1i/a5sOQtRytK1zlj77zI4UmyPZ8LqMgKKhXwRbhnU2zDQJos0mL5xYI2nzMs7X3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvwnXjd9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvwnXjd9"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-459eb4ae596so44541305e9.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 14:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754949080; x=1755553880; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRG1tCa/IrI9Mc4Lghqvcla/Of5GXD5DMJ1yUWYoUvw=;
        b=JvwnXjd9FvgrltmNumbOKBh6GH+xqMxW6MZFW3m+ANs0MxZdYQ+S6ikHSDb+pa8zCI
         WfilFUX9eRI+U5yA5qhaKD3yl2fepW1CinTAKLUZnpU7aP+KEy+28nQo8zFUWXlqKaxk
         JUCg5g8ObrVgvtkVbV17hbkj/5YMRRtIn9wm/RIT6yq8sWFHHapI8eLmKa9f3MGu/Apw
         RRA+4J/L6Ftjlu4HG/hE8wunv6v2ivzG8BzCKH2uzuT6IdU8DEfA4Lby1TdMLkqq50/t
         QatwvhIW8NqULxN9+0LhKZUSfTwaqbhoHmKV/L6hv7GeZpSN2oDsbD4li0VcGJJ2IzgL
         P5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754949080; x=1755553880;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRG1tCa/IrI9Mc4Lghqvcla/Of5GXD5DMJ1yUWYoUvw=;
        b=xKdil3m5MiWpEVgJSSqATx7J+HL54Apo2MHisQ8mklATlzCq7bxUkHL5Mx5mfcYKUh
         7DhPbCMPyCTHpUAgP5+CJUyVdLlHHdDNp97tuhqBJWuos11pq9P6YpHrm8yyaEILUkpQ
         yhVqqoVvDgG96WcE/IzmXHtnSEsYO6/B7c59uJUxD4TdgpmUsFPGzPY439RFPwPtNgJi
         GfhmYNoZqgwsl0yzDA8Zb7AdB1jnE5prJ5xR0IY4ZkYOnFc4PCXw4jaJX05Jo5dyVgem
         EL5wfDCO7iO7dx5zPpF0ha5ORXFt7pIHS/rZ6SBoOdt9Uf2PyvO8orJ6uSOQV1B0pOZm
         XDxQ==
X-Gm-Message-State: AOJu0Yz6UjMmvU0c9YBjg7TYeb6lbFuq/5oPZ3Dq5FaCjm9c44IcGI4h
	YA18yX8rWZLxqLRiF41j6911NDYa4MefQe8zsVZsIeqVlr7bynwb5ZV3pto8FA==
X-Gm-Gg: ASbGncvhAh2O79gOEigva1NX9d/bonN7hXf1Yd4iR92EhULTdq1MS3dUIWdt2PfbXc0
	RNUsXp3l99tJOviHNpT3autO55cGXGF1kL2f1MI5IMYrhYQnv8Ywhs/Qv7xKFu1m4VncqxWsiAH
	bKJZbmMLr4oQ1KyVMpq1uDzRi0eopnM0CGHfTw1PwxuuYTh11iZA1UXIo/wd8M1T5AsPlyvkz0c
	p7e9+YX7ABuyqElSSV34nfP6oj8Sta9EQ8D/rutu+BL/wVWQqDMTuhBzz3E0nLGKwopB+0Y43CH
	mN9VlwGa2SEn6u4WDiagTT3JWK8OgyJZs+wVWTn83WjDGnTXn8wjza4hD1XnP84DlvygeQqk20j
	CnHTq4D+8o7upg4EObGg9IMODIBIvKwLdZg==
X-Google-Smtp-Source: AGHT+IEjnA4Qpg92D1+NTVOVYqsx3dgoIObVRdkB1Lc0+kxZuSEhjh6TKQ7zetIySuhlanarpZEBzQ==
X-Received: by 2002:a05:600c:3b9e:b0:459:e165:2661 with SMTP id 5b1f17b1804b1-459f4fac83emr122919725e9.23.1754949079988;
        Mon, 11 Aug 2025 14:51:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459db13fc9fsm343412075e9.7.2025.08.11.14.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 14:51:19 -0700 (PDT)
Message-Id: <7ee6b0afe88fe4f5346776192a0df99c6b64de19.1754949075.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
References: <pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
	<pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Aug 2025 21:51:13 +0000
Subject: [PATCH v6 3/5] doc: git rebase: clarify arguments syntax
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
    Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Remove duplicate explanation of `git rebase <upstream> <branch>` which
is already explained above.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index e82ceb9cbfce..6d02648a9b3c 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -62,11 +62,7 @@ one of these things:
 
    git rebase --skip
 
-If `<branch>` is specified, `git rebase` will perform an automatic
-`git switch <branch>` before doing anything else.  Otherwise
-it remains on the current branch.
-
-If `<upstream>` is not specified, the upstream configured in
+If you don't specify an `<upstream>` to rebase onto, the upstream configured in
 `branch.<name>.remote` and `branch.<name>.merge` options will be used (see
 linkgit:git-config[1] for details) and the `--fork-point` option is
 assumed.  If you are currently not on any branch or if the current
-- 
gitgitgadget

