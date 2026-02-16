Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035603321AC
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771257218; cv=none; b=UQ2v5Ae9NFI/rk13aKrkk3eQnZRxHdkJyZP8UMlWKHWJuzeKwTM2MRgUlXg24fg2FW1gKUPUPPqa7YSkKAXkEnEXn+6cDb2utPpH9irDV62hjBXgggqjjuLAZqBVdjkJz9SWg67Pz6HMoMC5s6gQ57gfOU8EY5i05hhp1oQrnhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771257218; c=relaxed/simple;
	bh=Jnop/Y7hq4jPqCtbcK612NMnrFCpdCTr8EjfzYTD9FA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=krODTxz71DpnL5vIAXBL9x48kOATq1CBR6u1TVZaw5m+ov/7oPPeuPvAj8Wcd5YYqc/5d2e297qut9N9aVl4aZ4hAmEL9Md+b1y94WgBKXt85/nDChhPY9CQe6iLZL0bE8sTHGHTgS7cGf2pJv5pW4Ndo9tyjHs/pxgV2LE8y78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYIhf7H8; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYIhf7H8"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8947404b367so41726706d6.3
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 07:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771257215; x=1771862015; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4g4nWhrDtoLvXoQmGOJ6eD7xlmfg1pxaSKo6KsFwYMg=;
        b=kYIhf7H8NN7zasuNBCjJSruqcl7CplTApFI0ss+DmSiSxPjfi8Lx2wfBq5TZpffsV/
         9wXVfDYSSdpkMZflOvgf6oSS6ghg0VD4i+L/5PLViGI/vjIf8hpgRvo06Hy9iEdc4Yir
         1GZ3B8PZiUHTFk0JKAOTyyWtxK8/+6C76gs2D48ajNQms3yBULKXARQ5Zo2/2euDSYxE
         PYkYy35307ubTdb8Drk1itcUNgL8tEHuTYtOf8PbSdXjUB9pCMNibJI2qFVw5CYKqS3R
         o3pq7siiRGKOlj9y4J+MAw9LX0u6BiT/ktM/ILdAVh0BCKxLVNY6iToTFOI8+jpNtWwU
         Bedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771257215; x=1771862015;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4g4nWhrDtoLvXoQmGOJ6eD7xlmfg1pxaSKo6KsFwYMg=;
        b=Is+zH1S/lsSrAkoBY/xZ9JKj4VNcf8kevZqWDo/K5QObgPRrtbo5Xbk9IXQUcFk734
         9QAvwh4Np81j+MjjBJSziVea1JBqYcXQSgTZ3Fpx0MKP6pMP38TFpoXYVpY1QmoOQMqo
         fZBa/LtFifSYoxYl+ZtSnJnskA81SjZ42AkZe9qd0slgdPAHbtCZRTvF90NyB2hDWQNn
         b5/Bz6ekHGUAgtlkw8AwG4VM3pFEN2gF69xLvc4ESwp9K9YDG6tXSvLOQXFWxdVuTTVv
         H5q7EmntRVyCfw+XeR0auAcZpdsU/NMUgJ5SHHfLfRCw3pVNdj5LoBUvOr2YWGTrG7lc
         XHwg==
X-Gm-Message-State: AOJu0YzoYKrzsguVZQStLC0Ngu/WPs9HzAjla3p1UsYF4gzZocHaeDsU
	e2ORBlUYGvnOBEpw4xie/tfYvtAwS7XMgeBbjVuYBGyE7Bz1yZ/uXG/nIFrP++iW
X-Gm-Gg: AZuq6aLU7zXV8jnLT9B4rdrrpeBSaH8nQgKwFDQwkh7gd2L/JVmEqtOsHVzTVoghA/2
	bJhB1pGinPSgS/d1Crx6FoLjdaHlTHA5AF41kIneZqJ0kmLesvjIemJ/KT3l1qpz7iO1Jgx6gt2
	sjwzV8e2O51+xk240lAXGnSJH8T74kfMyjLd2WCdvg/AO5aEfvIA8bFXoAM/PuTqHPiLmtKQlNY
	oM+e4TfScbxsYwQR2pJHiP57F2p0PrTDtEc5M0NL5RWPbnaXzSyKgShQXengJc0ApxUcgAlh/44
	kfXoMFnBe/Uht81jOzlsEfoOyU1vF35CUgLmw30JaKeG3ahQTPYT7yX+9xiOf/o0f2h719xmNYU
	2wVyhvVpYhkdRKjeFuFa/dwmYx21AhJdMOFcKNV0fYpPAt27PLw66RcKy6Gb7UkwYnCyP5c2/72
	hNXg4IA+EANiWiZN4knK1JUO8wE3o=
X-Received: by 2002:a05:6214:1bca:b0:895:4852:ef55 with SMTP id 6a1803df08f44-8973618c6damr150354406d6.33.1771257215403;
        Mon, 16 Feb 2026 07:53:35 -0800 (PST)
Received: from [127.0.0.1] ([135.119.238.192])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc823a4sm132162036d6.8.2026.02.16.07.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 07:53:34 -0800 (PST)
Message-Id: <6383e1f7a9545c14d02570d5733b4b3e0513c960.1771257211.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.v2.git.1771257211.gitgitgadget@gmail.com>
References: <pull.2043.git.1770679038.gitgitgadget@gmail.com>
	<pull.2043.v2.git.1771257211.gitgitgadget@gmail.com>
From: "Rito Rhymes via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 16 Feb 2026 15:53:28 +0000
Subject: [PATCH v2 2/5] gitweb: prevent project search bar from overflowing on
 mobile
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Rito <rito@ritovision.com>,
    Rito Rhymes <rito@ritovision.com>

From: Rito Rhymes <rito@ritovision.com>

On narrow screens, the project search input can exceed the available width
and force page-wide horizontal scrolling.

Add a mobile media query and apply side padding to the search container,
then cap the input width to its container with border-box sizing so the
form stays within the viewport.

Signed-off-by: Rito Rhymes <rito@ritovision.com>
---
 gitweb/static/gitweb.css | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index 48d2e51015..0b63acc0e2 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -684,3 +684,15 @@ div.remote {
 .kwb    { color:#830000; }
 .kwc    { color:#000000; font-weight:bold; }
 .kwd    { color:#010181; }
+
+@media (max-width: 768px) {
+	div.projsearch {
+		padding: 0 8px;
+		box-sizing: border-box;
+	}
+
+	div.projsearch input[type="text"] {
+		max-width: 100%;
+		box-sizing: border-box;
+	}
+}
-- 
gitgitgadget

