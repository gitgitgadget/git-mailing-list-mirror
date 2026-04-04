Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8B3347BD4
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 19:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775332219; cv=none; b=YQDH3Ps9MBeL+d7lYeIFYLWjUQBbiYSRsb7dL9ejjv17/lYQoA+hKv1Dl8JOT68Jepd+Tf/vdgqWVMBrH5EwqAZgQ6uNzKfVCwlh4I0fbG5XcWk30lxRHXlmUKiov9tacuBrMU46yMioJWRne61bDc9hby7WhFnlUDW+9HJPwmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775332219; c=relaxed/simple;
	bh=W1avFsUnPl1HUEJzqPmKoMwR1scWadgIStJE1XgbKxQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=c9LYMEcmRqKrbBVjopjvwM2g0YO5q/2he/sTSczJKpBvMdamxwCHKkS/L7pOzgRCs5g39WUk3wXsMLSrTn+lHnxqATk3NQVmEp3hKiq3/7r/CPHeQRhF/tVdGMREHH/5G5nIpNFO69svehpOFjqpSWzcHwgVE83K7EYs1i84OKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qoBtiBDe; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qoBtiBDe"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50b266413fbso26235451cf.1
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 12:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775332216; x=1775937016; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=So2vIHOG8Zm+vmmprAGxBjFa98UpZPTRWBgQqP4gM38=;
        b=qoBtiBDeqL0ezYlsIQpXsRsGyaWZ20DUA4i79ME2k3RL7l+zLHFdJAVwDfXjoBTMoc
         S/feslx1779zuxNxOvxYfm0jV+K0H9PSX2AspQLBnU8UbZKCEIzZlSYagGmu9OBkbhlf
         rl8KnN8jamrB8HTH/iSE//2t0gt1KcgWDd3uz0yy+3dt+4vvp7S/jjh38H6ws1wf+ukA
         f1izGs6U/y2pFk/8SslFWNm3KFBVpaPSiG6jV2LjTpoDIzloLn/ctZjRsiLSKk9MlRaq
         2N2GbXFk9ug/qr9GryWZScvMgcQhGY3qJiyMlc84sKGVeO6dNJRYJv/E85dlRu/OZog9
         1AqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775332216; x=1775937016;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=So2vIHOG8Zm+vmmprAGxBjFa98UpZPTRWBgQqP4gM38=;
        b=LkuyKB/NYFrdm2T6luWOhT+BRmulJIvS4Ypy3aWOwgwGvMWEgbA8P7pJZrHSGxnLEb
         3pTkXO2G02ttG0HfkrkevDOfrHMUrwYlFfkAjoARRThhvv9FFaq+2opVNtKZlHSIOsFW
         82UNZ+PvH1fLO5moDzWAvHBLPuR4taW+iU8Ka+LsC5HcDfooxgmfO/hGHXrHMX0wbb/Q
         7yYhK5uqH3IFYAO09wLdiWN+W7M3fVViFQ0QJaPvAN+VT1VXaDhcv91O9NAaWKM8eIzp
         d5wQsepTCLBJB4TcHV66WLQmFlUaGCbXoNTiQHopgOlR4IF8bNqNHAEzH4Ja8LdSegjk
         S5ow==
X-Gm-Message-State: AOJu0YyfyLiJCIpuuQ8BbjbZStbmTckQKI/K5Uii+vc5rSYFxa9tON1R
	ILRZK1YBYmpvhXKdMIL+A0CtDaTecpzULD0AsV2lBk2jnytuiiSZvjsJ4A/ZcccQ
X-Gm-Gg: AeBDiesXQWDtgcwvzzQEBXXKW9ummgoaK47vyr3sc9UkVvnpb9MREC95sWwJ7huPJIJ
	tem2RiZJTj75wKr/Zrd9tlmVpfqPPeB0Ie16auqwWot/a7HDGKAQBtxnZXH+aFEE9yF6eeqtgJJ
	PkJHSCoLYSAQ1G+VmbrhV9PgLJXsfDuyqh8IDUsfqHNccOF8NyiF44pQMRjSyMvln89Ro+rYGyY
	fJc5/sbgzrcRjSb3sHSZIv3ql2NuOx3D72jLswPxC119FRP1isJcuQFW5ruOEWF4g7OlBBXvhqh
	woyk8JHBV5SNHYuy7YSKqvcxnhHI1/sKo0lY9YqO3ZJaQZ4ATtmjKDXu0HqC3BhYLDXbA1c0LMM
	0A0ElFGq0S0IsdIbdNoZj2irE6OBk15aV10MP7StqlNLnTdTONOUGQD5jhY/XhYbTgAyuk1oNAv
	WaMjeXJd9gVHzCrQXhMwyTZwA9SWM=
X-Received: by 2002:a05:622a:5985:b0:501:1795:9d52 with SMTP id d75a77b69052e-50d62a960d1mr122539861cf.33.1775332216576;
        Sat, 04 Apr 2026 12:50:16 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.121.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593bf51b6sm94688726d6.17.2026.04.04.12.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 12:50:15 -0700 (PDT)
Message-Id: <00eaefbf621b96bd400577c4ab8e3ea96cc397f8.1775332197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
	<pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Apr 2026 19:49:55 +0000
Subject: [PATCH v2 15/17] t9210: pass `safe.bareRepository=all` to `scalar
 register`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This test expects `scalar register` to discover a bare repo and
reject it. Since `scalar` does not support `--git-dir` (that option
would not make sense in the context of that command), pass `-c
safe.bareRepository=all` to opt into implicit discovery of bare
repositories, so the test keeps working once the default changes to
`explicit`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9210-scalar.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index 009437a5f3..54513c220b 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -88,7 +88,7 @@ test_expect_success 'scalar enlistments need a worktree' '
 	test_when_finished rm -rf bare test &&
 
 	git init --bare bare/src &&
-	! scalar register bare/src 2>err &&
+	! scalar -c safe.bareRepository=all register bare/src 2>err &&
 	grep "Scalar enlistments require a worktree" err &&
 
 	git init test/src &&
-- 
gitgitgadget

