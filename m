Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122AA1B6CEC
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 22:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918552; cv=none; b=BH6ijy7hFJ55mQmbWBqnpRdBtsHTJhANrsO7YGLy2xishaQaPyVNwpKHcbwJhins3OJPowjkw7PJZFVQcImOG+9DqIUTJ1OHMco1BvzjNyKcZgh35SeL2pJNcePGD+O5vvxvhY4KqAkzNtDxnPk8+xrLoaUspoANzCthr3XLchA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918552; c=relaxed/simple;
	bh=PMEABU78pnGxy6tWdiZrn+Hucn2naCfsWUx8s6HnmL8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=U7sLlEHbATOeDNZV0Jthj0/3PKh3YXXvC51qL6ri9v8tTXjaVIscXJdM2TdbW3yVoDf5blojIdrFzKx/EFof5fPRDlciJxUhzzIXUFeJj56xFKW4UDJLdOxPBgGH3ZDf+QVFxcOBZAX9DExuo7GjE5Dh6wDVkBh1TumzN0UHzcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ND88wZSY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ND88wZSY"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-439950a45daso7973005e9.2
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 14:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739918549; x=1740523349; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7faN9gFynbFl903jnO76/00Z///xrIr7/LGw1WUReXE=;
        b=ND88wZSYkRdo592vyvoM7rZxhbfCe1d+QLny9JtAvRTGPFfKryTAqyJXyWTWRX73Uj
         2iMSYXQU7OQqLNrOhFwPSVI6xe2pcO1V4gsrFA1d9DDGCtVlhZEE4WcLAMjaWCmkZZsU
         +ulAAJhMPlYUxtQ95lqrdimSk8y9Qtkjak0WldaKFQ+KG1Q9jwxDgngIuMOQ02PegnBy
         gRiza+CtX4NFC31rZTiEJTBLlBqAH0S0VSUcIkXayOQzBGqPEsDB/60kvOArsm/4GNvF
         RxBpoRwEb/niHTJpdUNqHIEgHtHftU2MhSaykepXyhyjyXAiifUH+lo5AmdRe3kVJIPV
         hkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739918549; x=1740523349;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7faN9gFynbFl903jnO76/00Z///xrIr7/LGw1WUReXE=;
        b=ekT+9mVBkzYe2zaxHMRkxz8RdJz77bbNNjYqsrUiLzuyDiLdSwyVJLuQzLzzETlPy3
         P8BgZbRYYZcZyQD02LVoZXPhtNfxhW/bsiBA6xaHpQNH/Md/mFagoA6crRbXyqlj0Ela
         C4DnSO2Ctpo2G5qFqchD1kDLIU1aS2PoP51oFuvFkEijfHOMJdNDvW2jdV/tBKU2n+X/
         yUzMUkM41wRzHC3lGTemZSf02KKMjQWNWoBPLU8LYDDIXvvR3OHw7J2GH3Sn+ecEcNs6
         DGevEV9mo7RHwf/efcwoqNMxey2A9AW+UuvIHM2uwHkApfNaHC20zIO3F2aazIJeUP3S
         FXMQ==
X-Gm-Message-State: AOJu0Yzh3WTmMlpGzSxBnVei0LrvZaqWJoT3Fw3wmqbBQbJYvsR0T0C2
	YRQu9xMV34+fIIaRGK8D0B/xSbQQ9zCH2+oHb8hCS/mbkYoEYiER629+wQ==
X-Gm-Gg: ASbGnctztHRfByyDo7A0t96ZmlhWBR8tM4yC0qUZv25eYmVgx4pD70PsTzxey/KP1Lv
	BsFKEBDOQUZjdF9NDozMLy4pLswSwJebQsNlglrKIRrfdGKSEFkJzFC7liBnseThRMFBO6deImn
	xIZEx65rsdrAyIi4ZFzpoenJSxtJvrbjooOqueV28e53oUCItxoG++9dOptqzXLWj2K5/HufisR
	ln/tuuI+0gvPfQ3FtRnfBSEv2YvaoWEWbWwm713SG2mj4+rtpYyLSpVql7XoA3+Xgxfa5FQiPTD
	/vkc9xItiQGRn+WS
X-Google-Smtp-Source: AGHT+IEHnoaDa7N+DLxqx6a/cOOO7ZSoQXvTGD2NKgSYZte/yROUeoebqEhZ92gyyT1WnacNCe/g6Q==
X-Received: by 2002:a05:600c:511a:b0:439:3d72:8705 with SMTP id 5b1f17b1804b1-4396e750e01mr122432785e9.20.1739918548732;
        Tue, 18 Feb 2025 14:42:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b431fsm15975998f8f.2.2025.02.18.14.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 14:42:28 -0800 (PST)
Message-Id: <c698805f088e0643e5faf027d4eaa6de14d6c1ff.1739918546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1886.git.git.1739918546.gitgitgadget@gmail.com>
References: <pull.1886.git.git.1739918546.gitgitgadget@gmail.com>
From: "Kazuhiro Kato via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Feb 2025 22:42:26 +0000
Subject: [PATCH 2/2] fix: when resolving merge conflicts, japanese file names
 become garbled.
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
 gitk-git/gitk | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 88951ed2384..f4f8dbd5fad 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -8205,12 +8205,13 @@ proc parseblobdiffline {ids line} {
 
         if {$type eq "--cc"} {
             # start of a new file in a merge diff
-            set fname [string range $line 10 end]
+            set fname_raw [string range $line 10 end]
+            set fname [encoding convertfrom $fname_raw]
             if {[lsearch -exact $treediffs($ids) $fname] < 0} {
                 lappend treediffs($ids) $fname
                 add_flist [list $fname]
             }
-
+            set fname $fname_raw
         } else {
             set line [string range $line 11 end]
             # If the name hasn't changed the length will be odd,
@@ -8310,6 +8311,7 @@ proc parseblobdiffline {ids line} {
             set diffinhdr 0
             return
         }
+        set line [encoding convertfrom $line]
         $ctext insert end "$line\n" filesep
 
     } else {
-- 
gitgitgadget
