Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764308;
	b=C2ojhS/YthHMpsSDnBAu2pO/kmfzbLTXB66K9A7zqFEjgAV6aZ6WiZ7UG853eMYGtUXw
	 WRay5aPP0eCeuZuRQ9Q3z4nVm0H2msmZmFiJk3QHUzMa619aXnzj9R7vAwIBLE7qc/fPc
	 489gRhaunDBJx0uQwUy1Hrv99yo6gAiX7opLhRW4hf5tQ7kxhc3OxduYSQPWLDjUM2qey
	 g4USIm8yLmIyLvyukxT5ZBUUzs7jY9hRpnS/nML5vlyCmVXr7Xkz/wiP0Nq6/hDUKk6Dc
	 5VaO3eItdg8614/VSrezRf5jU2kXSfva9tLZ7hKmEUQp1ejrXhdA/jBNxsXL380pv1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=6Bp2MKaX0PpYbdRtDSzznwJnp01PYGb4f7BkjNhVFEg=;
	b=PeRTp7N1cfmk+YnLAnCTe6x2YM2Wp8bwHPlUs3hgqViiwqkf1ZhTO7M0WRLcxWmLJuBc
	 QxkEEvIPIDNwjD0c2BtzhULVtjUSE/MlbT6uir95x41/JcqijCwhZIJIGycf1N3cvbLcf
	 tKRFUctEOC9sD3YzT1rGRqdfl12bE+pm0YyH2ShyEJQmlJZkhw3UsXIDySPuowAS/AcN/
	 Z2BqzAOKZOeCvw2lpjNArKT0b95JG+ghkONbtAv0h8JbovB6ShV1Y2qbCpYcPaPwHtVWy
	 hBBgiD58pETklso/AO4FoOwg/PxNU0vqUZVHe4bCQd6pFZXfbLa0yLGG6CdULaTwfTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S83LrqBO;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6DB606A328
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF6DB606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S83LrqBO
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5365f9a04c5so10829971cf.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792764307; x=1793369107; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6Bp2MKaX0PpYbdRtDSzznwJnp01PYGb4f7BkjNhVFEg=;
        b=S83LrqBOXki1yfqEDJJJbr+COqZpmwQKlUmx11UITZPsfR4NtFqfgzjbhnY+KHbhgQ
         hMNpAU5emC9NVPpIUCPBnI7aPZJlQV5xfPSW9ooxo/FnM0HzReSE8LOd0EMTHOkMR2wk
         UIRDTvCBr4yjVRPklNcQFZckf8A98ekBLXi01XTE2py/6TJEju0z7RgPcF3FosATJOjN
         8PwHQiwckc/ZBLyFZ3Pvmqjg7ikKShx0jkqdNQUzN10rxjBsMgWqsTUXNlKYGLuaf4fU
         Z3Cq5XWS/U/B0qbbnZ7KmjtCamdxVGfKF3lYRjCuppDFl9raEOYj/czrTvr/TavCUMlW
         LPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792764307; x=1793369107;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Bp2MKaX0PpYbdRtDSzznwJnp01PYGb4f7BkjNhVFEg=;
        b=o8UyluKRivvYvLcBboICE31vhUPxYw3jouH9n13I/VeNtAQAMRDyRBfgF4Ru602/oc
         Qsa/qg77zKH4vlAXrWgSW8BRJIs94n6Y0Hg0Vx23z6OoFzJraPos2h+4DZX3tJz01Liq
         ofzEM9EKHN3ZeZZz5T8V32zVB9KdVeSArFkcUPajqISg+4O7MqU0mSY8afeBKMxdwB5m
         PUx7X5RuBbaEL8Q7aLzVlaN92C8xLaz8H3LussSS5RM5F1DnvyKDt1B8UI+caUhNzGBG
         22zs8VeP/sklSDWYzlXOpR7iX+1miRgLp7YNmm3JFU1iofqK5RxNFXJ9+ahNyDNB/RY1
         WS3w==
X-Gm-Message-State: AFq9FYJhLCPex5SmAQRkvHeEIkRFoywu2dNCkmJyNXpSdlQogDhMqzeS
	nBv9M7Z3KDeTiUK7Qce6+Bl4KMQbObJs6gF42CfKk7imedNVykpOgY3nnjf46TvgRTY=
X-Gm-Gg: AYBFou0do4ge2Wnn55HrkwRlxaEwJ6Juq8DjL2KxOqoAvs8ebj+BFbCUE4frJzpvh7t
	quodBWMYHpLDkC9FxsFxz/zi5NIbYz0DOnyPbBWjr8rBk3/JNIFPI6T2/8wXNsXpjkOuX/rDoXv
	pCeizTEJXVZwKBGH08oUDRflg3kCddena0OIF+BnOkl0PpKe6oHsdmVe2Y8+So0WyhAXyBGLcsL
	BWmvYt4RBmX1Lu8bVg1aIM7lOvbPZn/RVyw6DEfBLmbxT1gHZgj3xxystxqdwmlLhmP1f2HkF3w
	EuwhDyvMNPTk46DjWoEjMwDjeFP+Zx0rIknVDczZYSK3H2dgxgosIhmaCRPUSbzHL0uVrIlKZOC
	Ylw6al/ylKgU9Cq5zIXEvOO6bw+GjaLDe1zX3ca6GqBAhFA3SAZApw4O1qaX+HS5k0QRXpHLz6b
	AQOtTDYzzu5ouJtU9fQhkULtrLxM/ptoMmmFwkeHmGUzzXmQNSjoheoa6nwjh2wxYov9VCU8fWe
	ly4IslMvJRyw2Gbr4cMvKN5CJLUaYrLYxyCraCCLqSkHGc5GvNKiJB4jZv2irpzu4E/C43Hbpq4
	sKQ=
X-Received: by 2002:a05:622a:14d2:b0:536:6013:bea6 with SMTP id d75a77b69052e-536c2101e59mr33770171cf.2.1792764306805;
        Fri, 23 Oct 2026 07:05:06 -0700 (PDT)
Received: from [127.0.0.1] ([20.83.174.58])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536c1846ff0sm17192051cf.19.2026.10.23.07.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:05:04 -0700 (PDT)
Message-Id: <92cfdf260ccb07bdf5d255c8de3813d472610be4.1792764293.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.v4.git.1792764293.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v4.git.1792764293.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 14:04:52 +0000
Subject: [PATCH v4 5/6] doc: git-cherry-pick: link to new merge conflicts
 guide
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: ps@pks.im,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-cherry-pick.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cherry-pick.adoc b/Documentation/git-cherry-pick.adoc
index f4cd8b9db7..069e434961 100644
--- a/Documentation/git-cherry-pick.adoc
+++ b/Documentation/git-cherry-pick.adoc
@@ -19,8 +19,7 @@ Given one or more existing commits, apply the change each one
 introduces, recording a new commit for each.  This requires your
 working tree to be clean (no modifications from the HEAD commit).
 
-When it is not obvious how to apply a change, the following
-happens:
+When a merge conflict happens:
 
 1. The current branch and `HEAD` pointer stay at the last commit
    successfully made.
@@ -36,8 +35,8 @@ happens:
    conflict markers `<<<<<<<` and `>>>>>>>`.
 5. No other modifications are made.
 
-See linkgit:git-merge[1] for some hints on resolving such
-conflicts.
+See linkgit:gitmergeconflicts[7] (or `git help mergeconflicts`)
+for a guide to handling merge conflicts.
 
 OPTIONS
 -------
@@ -259,6 +258,7 @@ $ git cherry-pick -Xpatience topic^  <4>
 SEE ALSO
 --------
 linkgit:git-revert[1]
+linkgit:gitmergeconflicts[7]
 
 GIT
 ---
-- 
gitgitgadget

