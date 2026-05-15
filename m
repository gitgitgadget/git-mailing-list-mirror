Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EDF3FF1A0
	for <git@vger.kernel.org>; Fri, 15 May 2026 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860096; cv=none; b=WleG+uajAO56rj6mk1sNFeWurL7fApIDRE6cRhIim6s5N5EqJSg4Cg9fNigKHHw26no++sxvkSK5dzamKP03OphR/38z+2SD0wjXrGKcY57ppTZge6h7Auio5uuRQ7nbA3RqOWofO169mPlkKMyw8LEeA3XdUHCL8BZ0P43874o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860096; c=relaxed/simple;
	bh=Ww++XRnE0Bb62K0rA6ILt6X56omgTsoEg10TLT6pNCg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iJ2jbDbI43dTTqpXA8GqDveX/Fprr/pAu3hP7aTS8/uK6F6nqt5dO/MY/xDXRE9D+ENV/6oyJ8bVXb9x+upWvPRhiEH4nSt2/XeEnCu9CmzH4vl8piLcYY9OzOoVdhM3cHhO8rNRbsdcpNT0TVlooaIeOOjbmFuULXD8bkV9f/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jftSBuhZ; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jftSBuhZ"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-651c7ddf514so12372115d50.1
        for <git@vger.kernel.org>; Fri, 15 May 2026 08:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778860094; x=1779464894; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulNMnHnaDqySVvheDNyxFk510fJ9/0e6UyeQ7torvsk=;
        b=jftSBuhZHWkvbKCcOExdhqE2AQk9Njz/PogbhUF7uhwtM0ZQlC3VUhMV4z0fJsI9zr
         sZ0Oe4h/dwl4j6UNu1pjvMC4lQEG6K/zE+oIPRTrLochloq5pecbJkBIEeObQEg3OabC
         INC1WVbp1mLDTkIzJqcKi0KcDcpL4pJH3KoRfmsblKnBChXYcCLyZWQiH1qjBNVkuYxF
         G2c3S3hAA+SE95MHKz2DE9xWC3NF1kL4eRHEp4Bk9GRv0ZiAAxVO+h8p6JiQuvcA6wex
         8r6Z59vTSa8ixFuRFxjNhkNgFn7E4pvO8QiZq9Lx/cH7La/w0K3J9ulvL7fohlklvCgD
         P1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778860094; x=1779464894;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ulNMnHnaDqySVvheDNyxFk510fJ9/0e6UyeQ7torvsk=;
        b=Xt+Qc9uxtBMHlsQ+Fq01ij6Gd7AUThoBrN6tYYcISN2KZTTmJdupnFx7mVzFmXh9GJ
         TY1GXhREhn/F8x0myIlMc1Gev0cgPU5+WEmyRbx0p7PivvtfAkRCo8Icnu6F//liS0ru
         pzKijLylkLLqdfYQ0QnulDmgbZcl3i40xaFf2nWdkRZ3BonP1r0O8vEwDI6E2HupvPzR
         +zMTctHFIMLQe7nBKigPV6n3dbsr3ViaU2cdrT04Nhr7nW/KA6sOaK913heH4ZLB9LDt
         RtointDVqX/XAIJFWlcTR74/1oAB6TiEqpZ3YiyL2RcFYpFFWjWsErcdRSS+vfP3gUn4
         9mWA==
X-Gm-Message-State: AOJu0Yz51JiCbZ3T82xPpTZB3sjva6ZYyW+UARkDSJ2W/sL9bNWiugq2
	DrRO7yB825qSBrfWxFNS4nYCn9OK7FnA49pjeCosNOR7R2Os7M7jTGjcEYlHoA==
X-Gm-Gg: Acq92OEbEgLpL2WSIYCEfW0tDPirTeYxra4mKvSnmaZ4TNfwkGsPjEnQN9KeZH/pyUL
	zolvJ4LSg3KM5plVhDDOyUo3RrwmgezPfAWAv/+pssYgoXAnPXQu/vbv2334XWWpVDZgSQqs8kr
	mUHYMI7y7pSY2V6y56aCiiBB2Ye6I3bC8asRGyUiezMY+eg9u7kyYpnRLQwq2CqFt/RCcialSQ0
	UAHxlnVVyrDlR71u9ZzDXTptzK5egzBVBePhhDS0gtTTzFQnqUAsuSvAZmHQdaavB+FLKxD34jk
	QC8y5tZODYvYFypHzsNTcJKqIt+yCcZWIetKMtDp7IeZXOV7iKWfnKvFlFDXwWjtIIY8TT3OvW7
	JvoQMblrDRcOU1uhkYGuAluuazR5lAY+un0ejYWScEWWAFgeNg1y6dzggpeR5IqWFXCu4hymKYv
	K2BLgBr3KYW61TlsWSagxeVWE=
X-Received: by 2002:a05:690c:6b06:b0:7be:fedd:726b with SMTP id 00721157ae682-7c95c4ef93amr50303387b3.42.1778860094381;
        Fri, 15 May 2026 08:48:14 -0700 (PDT)
Received: from [127.0.0.1] ([20.59.242.4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7c7f4ee635csm30827797b3.32.2026.05.15.08.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:48:13 -0700 (PDT)
Message-Id: <7e48be4024b3a2a75b8c549653d13585c9e88fb7.1778860091.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2304.git.git.1778860091.gitgitgadget@gmail.com>
References: <pull.2304.git.git.1778860091.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 May 2026 15:48:09 +0000
Subject: [PATCH 1/3] diff-format.adoc: remove mention of diff-tree specific
 output
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
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

In the "Raw output format" section, we start by mentioning that 'git
diff-tree' prints the hashes of what is being compared. This is only
true in --stdin mode, and is already mentioned in the description of
'--stdin' in git-diff-tree.adoc. Remove this sentence such that we only
focus on the common output between diff-tree, diff-index, diff-files and
diff --raw.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/diff-format.adoc | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/diff-format.adoc b/Documentation/diff-format.adoc
index 9f7e988241..7f18c64f1e 100644
--- a/Documentation/diff-format.adoc
+++ b/Documentation/diff-format.adoc
@@ -19,9 +19,7 @@ compared differs:
 `git-diff-files [<pattern>...]`::
         compares the index and the files on the filesystem.
 
-The `git-diff-tree` command begins its output by printing the hash of
-what is being compared. After that, all the commands print one output
-line per changed file.
+All the commands print one output line per changed file.
 
 An output line is formatted this way:
 
-- 
gitgitgadget

