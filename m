Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E7431326A
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 02:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773714106; cv=none; b=s4hlrv2+yJTjxOcoxBEql6NSEccuf0tuD3ERPC5RFvhqOuwZVH2Kf/93Y6l4D3ig6Gh0MZTlUFLW/TGbQvlGf2JFQ+DPMTKM2+YZlOj+cSY70AZdmhAxbtU0CK36cTd3iTt8o4k5VvosUGy7WDxfOXWMuaWOJO5aiGkh85U313Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773714106; c=relaxed/simple;
	bh=W8ZqmQfieFGAskdPBz9zYftHkLV4jREGII9HpWVKCCU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Tne2JG3WzAZZ+dIoQvlSRi2GXlAh4KvIL/x/VIlqGk/yWLW4ZagpEj6gEhJXSupFs6XsIW9qf67r7spDGHh7d+7K52U/c6fE9fVdevpqP6AG4b1Bw3zKBrRUxBhwO1igGSqcQiuZw6ZBsSYbE9SvKRbFs5jcj6r4/PQKlOVoSmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJ4jSAGo; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJ4jSAGo"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso6254135eec.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 19:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773714104; x=1774318904; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odnSBjJn0T+zWlvmMF13sOrYsM0Mw/fYcovDKtF23zE=;
        b=BJ4jSAGoIg9QRtt+uf1rF+8/fJlDb5Ny9xcwbnlkm1zJklYnDaoVHcDXLpzMIH0Txg
         SmopjGT2nGuAIwNrpzp4rfSXoPcYzwv1UhMNfylaltR/QxNM+10+mjEVLc8/bwkpUW2T
         bpzQ+vVGdsZUVBWLTMytc9ovIoyxgwAGJqtBtYw6dgpA1yXqq9MEwyvg+CYe6IDx/RZv
         uVgNTqF6z8KQydPAe9e4JEQPphixnfwTY3iQPeWMGjuAhzq7RPOvXyx2TInDe3xKsnq/
         wuS3/35O/LWCF1iKMCJAUTDPHhJYcs3VPJLBGC6Eb3bbSaV24GtACMz87+/IF+zofkgD
         M8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773714104; x=1774318904;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=odnSBjJn0T+zWlvmMF13sOrYsM0Mw/fYcovDKtF23zE=;
        b=TXSlzoB0B7TCeCwfm6ZiSFZ49I9Cw9eVUyomN42PMw/L+9deP4dy1/tkaxUeIdjtSE
         +w/1pD4XI81PmaM4ULOJ00bWKHgXbB2uz/6wgJDJh/zg4tJWAk3bRMtXkNEBkevjEkUh
         ruH5yIU9OxrByJpEH1Ht0voMOsJR9ycv9S5tYpR444kzlOL+YcpPqIU6RJdjGrtZTd2E
         T22oLSw1inyTI5Dlv9AycFWwA3D/Has+EcudQItcduBTHTpNIhW8vVrNKhZLS4nDOAr1
         +2zy0CXDPfYAKT6Hl+WcT7thHIUKkLx371wbVFVPHhjU1J53AUmWhtF8Z+aPSA2OD7mW
         zC5A==
X-Gm-Message-State: AOJu0Yyvhu6XL0eiJj3AotxoMSzo/gQGn4YkZ1eJNzDVMZebYamSD0YD
	3zxqr3JSLr18SiaFnr25aujGrL7N5wCu8gI+HZd/qdiFmVKWbFPfY4pR5fsSygX6
X-Gm-Gg: ATEYQzylsf/pFn1gfRN+ZM4b9/vTtqJC+czhPppSu6IiT+jnU59BiFKCR676Mod6EvL
	/XxXWioVDjF92ayLlTzSjLTHhtTbaQiVC6Ptufo2RhiaZvJfAu1XCCzMlpxcbnxtxRNnkqfoZQw
	g2yqqa0w2nmcpteT0V22YgNh6BHB8l+5pkhQBB/L9s3BfsdvWyveHDAPdpFrdCCPNkO1bIC0yjr
	bn+z19VYUy9BXpajDpFRF6w1UfGdlniNxFZn4+b3twQQUY6+WjAB9ISvWFIbRO1fateRHUtMrVW
	Xm1+PdMySRNtu0JywSGlO4jH1NnwCHwGl1R/KHoakJXHREJpPJshPcRlhmrrkEohv9QGCz/zefY
	8ZAHX0vg33SggZfJD+ukGeiCGdGK1Ftf2rLvWhIwkBpJhNHsMmGL7UOhdtwWrNfKudH6q5B/wCo
	ATqB+oirDmIA33OHo2PhlWXG8=
X-Received: by 2002:a05:7022:78f:b0:128:d1c9:3633 with SMTP id a92af1059eb24-128f3d3431fmr5893605c88.13.1773714103673;
        Mon, 16 Mar 2026 19:21:43 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.50.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f6283845sm15505513c88.2.2026.03.16.19.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 19:21:43 -0700 (PDT)
Message-Id: <93e771b7cd7775cc67e3305adb4216773acc8e90.1773714095.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2065.v2.git.1773714095.gitgitgadget@gmail.com>
References: <pull.2065.git.1772845338.gitgitgadget@gmail.com>
	<pull.2065.v2.git.1773714095.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 02:21:35 +0000
Subject: [PATCH v2 4/4] doc: note that -L supports patch formatting and
 pickaxe options
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Now that -L output flows through the standard diff pipeline,
document that patch formatting options like --word-diff,
--color-moved, --no-prefix, whitespace handling (-w, -b),
and pickaxe options (-S, -G) are supported.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/line-range-options.adoc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/line-range-options.adoc b/Documentation/line-range-options.adoc
index c44ba05320..ecb2c79fb9 100644
--- a/Documentation/line-range-options.adoc
+++ b/Documentation/line-range-options.adoc
@@ -12,4 +12,8 @@
 	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
 	`--name-only`, `--name-status`, `--check`) are not currently implemented.
 +
+Patch formatting options such as `--word-diff`, `--color-moved`,
+`--no-prefix`, and whitespace options (`-w`, `-b`) are supported,
+as are pickaxe options (`-S`, `-G`).
++
 include::line-range-format.adoc[]
-- 
gitgitgadget
