Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE073E5593
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140410; cv=none; b=XMYz2WJEq+4QM2oqSUvIaqTlqA/M6Tv4rzDdwtSRIb5Xjnx81X6l5F07XRBkB7+tvKRQ30/2aEx4Z5BxbZN9eb7xOw9Ki7pkGzCslCRGLyZF/G4H+GU3QXFyHqBMOIKb+JD0GxGJtHZiX+l4jKkyG34Q5eVmTOQJQn3wqBWK7D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140410; c=relaxed/simple;
	bh=N1BeQESXVc823dj66xtUEgDBbdoAuDBtL2UwjFZSrLk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AJpi7rVHTZVzC0HJzXVRyL6D1bK2egbFqn2OscwWKR29/Pe1+OOI6HV4t55/Zsbv2G8HezRSuZ5jwUak040Sn2CqTd+IoKDH0L7OZ56XyRDaQn9T1QhL/KW0fS9WOQkEt5VCXCoobDGtUQjWEQIeKaON/dGO7wvvOnPfh4WZVr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=snz8eTjG; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snz8eTjG"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cfbfdabf3fso104879085a.3
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 07:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775140407; x=1775745207; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDCvNhsw8FfrYHO3qOBtcamTF8GOzlMOJSASJ9HGgkw=;
        b=snz8eTjGfRm5fwDG75/7TaGJXlaKp2OUrZ21RlyABZx1wNHxzp9R3HS9SaIHxCstTa
         +cEr1B3hBJ3v6Ry8d4TxfRho4Bt2VuaePTNkCyllYAnJCVP/6zH9BoeIVQniphMeYpRg
         YeWSNn0noRRhFhA/aTcG6gvuJoCCxJMApLtqe3mNhpIJtLjgABOxGW9fBHmdSQIrMfed
         duGvB80WXDhGVZ7yC/uJwM/231kde3cz2kDOsSbBBG2hTe7enQUU2bXf7uTXGuJIP9X+
         67W15411SrXFmYsZWNz1kFuQlUMuyo1dcHIbsc0Cnlpod/AFpgsNRfrJrT/t7KZaI0Ho
         JUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775140407; x=1775745207;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eDCvNhsw8FfrYHO3qOBtcamTF8GOzlMOJSASJ9HGgkw=;
        b=Dp33IwGrhG/jva7UWGvqbl0XTdkOexMOX5InSDPeQ6Yl1BaypApFyD5hJTyrg/abQs
         Fb9fYP9BXl0uilFn008xSOJxe654CrEoCEKTny9A9T2ioPxfUCXkiqCj8fAQZf2JXMS6
         CIqFbqTutSFOkG0QRdLBN++FcIeR2m+kL4J9DlmThcW9RvIgrXlGKFSqHP/0iwPCl6DW
         piMfFA9A7kISMziHP/4ykrdgWWRdPXTN0xU0r+gsyux1dzlyKUAoGia/zA8QpetoO6TE
         CaO8YiWKN4LC1cfu1D/l2OVGeRezlkBMqJWEZaqkGKZzUMoPU5aV6HhDQwQBvvRVslj6
         gEEA==
X-Gm-Message-State: AOJu0YzEqFKeKXh6SCo5Hm267BcKzcwYm/i+TE4xX/1s1G0fPNbC9qFE
	45/voQH0spMnMEZ0k/u0I/i1s5XCnLA9wQui0sVPfQexRHSmgI2DC/JQieFVZw==
X-Gm-Gg: ATEYQzye5fzcA0hoppALhjMmzcQ8AHkx2p1nrSM60ogJbkLNRiSGyk5lMgr2GXBV7GA
	pgG58GvnJxukHpWhfc73pbgs6Hc4zGCI74v8M0pOLuumiKkbQP5jSqvX4Ld82QNjEjPVw8IYacA
	bsDMzzLbfO+0HyhjSuwNHsQitGj7wE2cPJ4K3IVMi61cpwaZ5/pwXH6nvqsFH/4DNHBG/gedBVg
	/UfMESqtjDxOBYETdi88uxLCay4QWj9oP05m/3r0hK+uAF1mEE44VE1o+MxCkKeuxm6ds75xOXw
	7OhixT1JCAxTW05Yb2bc/GBuPbR0R0QPNfVodvMuiSVnWPM3hJtmPc00hAhqhxGxkfaw7EafPo0
	1Wj/K0mI+b5VYy+2O/lDYYKCDpu1bG16CPdCjgoRauqn7cqrIG195PFTLO94MVl3mmvA5e/2P4O
	Qqz2Yn0Uvzhp1gFGPMvnQKzDAbJRM=
X-Received: by 2002:a05:620a:4589:b0:8c7:f61:fd7b with SMTP id af79cd13be357-8d1b5c38d01mr1081268285a.57.1775140407252;
        Thu, 02 Apr 2026 07:33:27 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a548a2f6sm217143585a.6.2026.04.02.07.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:33:26 -0700 (PDT)
Message-Id: <78744602fb33978a9f674f5f9860c58e7734d2e8.1775140403.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Apr 2026 14:33:08 +0000
Subject: [PATCH 02/17] t0001: replace `cd`+`git` with `git --git-dir` in
 `check_config`
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

To prepare for `safe.bareRepository` defaulting to `explicit`
(see 8d1a7448206e), replace `cd <dir> && git config` with `git
--git-dir=<dir> config` so the helper does not rely on implicit bare
repository discovery.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0001-init.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 6bd0a15dac..db2bf1001f 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -20,8 +20,8 @@ check_config () {
 		return 1
 	fi
 
-	bare=$(cd "$1" && git config --bool core.bare)
-	worktree=$(cd "$1" && git config core.worktree) ||
+	bare=$(git --git-dir="$1" config --bool core.bare)
+	worktree=$(git --git-dir="$1" config core.worktree) ||
 	worktree=unset
 
 	test "$bare" = "$2" && test "$worktree" = "$3" || {
-- 
gitgitgadget

