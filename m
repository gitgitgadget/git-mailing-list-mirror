Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6CC286297
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 22:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918552; cv=none; b=p2PCfuEsHTEiHlieG1eFKCAsKXlns+wU9qMovpw/BghUUoBiJ4yeXDJpUcXaBCeGKQ517GbYOpeAtzwJWXvsqM3h9DZS33f+aHS+kpXZxm21m/ov/W48iQRxbPORFgEyt76dlMh1dVVHN1qheQtoql8FmxUpPRAwxwFlxEKkqKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918552; c=relaxed/simple;
	bh=3D2t0EHtNfhhtlFCupfokGv5hrnH77cfmp9yu6VeGbc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=p/wWIUMObnJsWRdu09+OJvhz9+7cR967j+QqiinMBB+Oytut9wn3daRTrlNZwQ3Ut/Uv2onIpdc7ETWiV1sxcKQ1/5GgyhTEd9+fy02PBNGDkiJVVH9qXKsT4yfvdKfYWTFdPELG0V/ogKUF5gspLgNTTQicx0Pli31f1gstG+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsSJV3YQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsSJV3YQ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4397dff185fso28159345e9.2
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 14:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739918548; x=1740523348; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXCTFKN3kxefFwV3m/yUmKaULhptmrhWnNzOXprY0X4=;
        b=XsSJV3YQq0MVsX9srrMS8neYQNIV5HTi3fAS8gd5asqMO4A77bZO1TpEP3oniYtU9b
         0bijiYDdqr6ptv1sGX1N/rx0mUuUN+jdYFgDFpHzoGHCLWERkQ01Vy08mTfkjeNwphOh
         hwTkdOu13T3ZUvk4ui8Ib6qgQa5nUD568VSrOZPKrSet3SD+Cwk05qB9cbRzDmp/2sVm
         gfaz+k44bRQDCuf4L6CfQxi5GKJpZ497eWg4TvtGdWeIdGqwGKvafl2Md/wK8cFoU7ty
         QVRQFwZQ/elcKu/cIxYq7QlS5LLdiBBKiH2pGVGXB+8E6ChkRffxJ9RgcBlhdNmoJPoT
         EA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739918548; x=1740523348;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXCTFKN3kxefFwV3m/yUmKaULhptmrhWnNzOXprY0X4=;
        b=TmGXK+yxFlwpyWa2HtmVH1Vtz2rmIQrZFFd9ThLVSf8A8GsrYsvQRoLtf1HzclVe1v
         iWPmYU2PMR8Mry9UWaNApdEJZjHCt+EK8pbWY1h0KUnr/thZmdnMIAjf9fEqldI5AaQU
         yTR+H8SVrRwWHuAo8TAMyEmBkoXi5pNRBJx7vkTNuxyEJ42Xh4r7sekhumssvjqPtt83
         biZPX3t9wFY9qGBiITL6EzdCu6tbgHFAobALnX7XyQrvi7xD49Jq7/B/CaDeWzcABLAW
         m0Bx+7uPY0BlBJoqDCNkrUycwquKeewA+VtKmlN7phVRxu4H8s7eovf5j5RhoqKt5e6W
         5fhA==
X-Gm-Message-State: AOJu0YwbtadLPfSFrXludkMXVw3fYEJAAxq22qO1xXqE7pfeK3EddKXF
	Tb+WARzSrvSb5X5x17rFXrScTuumDOl9UHGgJwgRNzFLkzHyfTaKbxDJ+A==
X-Gm-Gg: ASbGncvG4w5IMVrCUvWOkWSdKuc9onqHdIT5lKEgfkcT3qQPM8poAbjsZ84pYfvCvxA
	C6o5bbYSkJx0Sn5QYBy0DlbM5I3JlN4WUYksRTsZfcvzE+st+bfZGLcdKQ1tLeA+WsR0884+MSz
	VTo4pUa69QSYG/jjwzW2aW29VpdeniYnJ8AysNvaTuTG7/7Z39dMV1NCEnzO1xoNZmz6CXDWbJw
	7uTSKKdcK09TFwarROdUOr6Ae1aPeAiAfp9BZZc+zxaZhfZD/MbCluw/KlaJixK2N599nuOPhQB
	EwV4uGuYT2jiUhBT
X-Google-Smtp-Source: AGHT+IFAxGob/E+mn2G0S1nPygpPvnU4abtCTUMMwsX1hYPYuCsJx+BIecDuH0B1sN2RweX4HCMFKA==
X-Received: by 2002:a05:600c:5124:b0:439:6ab6:5d45 with SMTP id 5b1f17b1804b1-43999ddae20mr12154175e9.28.1739918547996;
        Tue, 18 Feb 2025 14:42:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258dd5acsm16369295f8f.35.2025.02.18.14.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 14:42:27 -0800 (PST)
Message-Id: <d33fb3d940cf97bdfe3dc544763a51df4874a5c0.1739918546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1886.git.git.1739918546.gitgitgadget@gmail.com>
References: <pull.1886.git.git.1739918546.gitgitgadget@gmail.com>
From: "Kazuhiro Kato via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Feb 2025 22:42:25 +0000
Subject: [PATCH 1/2] Fixing file name encoding issues.
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
Cc: Kazuhiro Kato <kazuhiro.kato@hotmail.co.jp>,
    Kazuhiro Kato <kazuhiro.kato@hotmail.co.jp>

From: Kazuhiro Kato <kazuhiro.kato@hotmail.co.jp>

Signed-off-by: Kazuhiro Kato <kazuhiro.kato@hotmail.co.jp>
---
 gitk-git/gitk | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 47a7c1d29c4..88951ed2384 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -12379,6 +12379,7 @@ catch {
 if {$gitencoding == ""} {
     set gitencoding "utf-8"
 }
+encoding system utf-8
 set tclencoding [tcl_encoding $gitencoding]
 if {$tclencoding == {}} {
     puts stderr "Warning: encoding $gitencoding is not supported by Tcl/Tk"
-- 
gitgitgadget

