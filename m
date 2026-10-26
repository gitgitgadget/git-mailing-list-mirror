Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018414;
	b=vl+KTFuV7K/eLXXYkkgi+7/xcNegJqLZbNCz3w+06NXyefflIsB43X7/QkaE64uIKzND
	 wyMleMKTGI9T5Jez/ezL9z4SwWCG95I2yd+qpu98QcXELS2aQtJZ6qEkXtzXvvlOwnPc0
	 Iytq5CMhvrBjUprVZXZgubo277zOmMrDi5PSKd+M92dty+mHzOya8TOJ8GoWn+6tf1T6t
	 DornC+pp/wlqlyU8HD6UWtAl5ljJ8SW5Vtol1+hC2wgkUuT78Khyy/96NmEY848e6nHRg
	 gBfpgjYWXaA/VQAHbku8/YP0LdN2KFoz41VdW3J0c/QsNutJR2e83tXk8svsoqprsHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=uVMN4yYvQBwSe22gBPvAn84Cr7GNBJBX2Ji9ZZYVwMo=;
	b=MbtyC9Vc62zBQjDdEGGL3nyj6eisXQIuIxWqfxoTZXSbuiJR5N/wFjKY+ieQBKe3IoBi
	 LYyh7YH7wFeNgDN1YfqD491WzWkLvbByUHxZAO0EnuizLy1SMkNpLWpnzpUxBDYBM30VY
	 iYZegv9zSZzSKSa24tb6LxtTJI4qE7KzKvGiU49Z1TygjKWkVcMhdAJP6JB2PZNLKULlf
	 lz6+etSrMCTcesm6+LyiHZaVLh092tiOXCG+UlrYaBhgwglmD4o0noWQtAEqNKmfrM+Tf
	 j0Pp3ayTz9Z7K7bqjwtjJRcrGKUTk67R5fXW158jnhQmqHhddA1Tnd9/KA5oC3ugHzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="fUrHyq/a";
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FCD606A33E
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 12:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21FCD606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fUrHyq/a
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48b001cd92bso1659779f8f.2
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 05:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793018412; x=1793623212; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uVMN4yYvQBwSe22gBPvAn84Cr7GNBJBX2Ji9ZZYVwMo=;
        b=fUrHyq/amtP09WLCUntkxJRRRc8qbd09+Ictt1wG0zSrHrekp1qAEa4Xxsx+jV1SkM
         Pp24UYlWATPfGdu5dtfQ+NVhthBJKVEFu4yTNkwEtI0U8FugVDMOwCv/fCEaFQ6Oz8K0
         A6VQNDvlzMrf4yI0kvpihcAWkZzYmAmOHBIxkbmU9jVAwI/+MM17CyZGIsgeucyBvsfV
         0lTjUjjKHQJhvVBz9csuWeLWQCkdvHvwrAl3gXNF62W1gF4WxHEx9uWlheOzPpnJmhRJ
         84Qu8ru/KKAVSJTTmH8SosqUsuSNTBlJtxyBgMLLxFVKOIWbCC4TQDBU48rCJdi9oJ66
         4ZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793018412; x=1793623212;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uVMN4yYvQBwSe22gBPvAn84Cr7GNBJBX2Ji9ZZYVwMo=;
        b=gx+9S9KNN65x/v9jZgyToo+Dm8VfvAvAbBiwDj381ex9wypAg73SLYbgtg1MTy2Pam
         l7CD5QcwEnMULBkZpyTuz6OIVtaD6uRH8gEe5SgBfilufoj5wpp4zrwGvtuZ3sDLnRD5
         VNcbPTT/AuxZs1lL1kgCFkK6XANX5opNtJMYz5PRnJu3083V4Ln11tkOS87qqM9ORJXC
         T0ARIOfFx+l0eLmsx+j4oTE/hdwgonIhmMAdctuHLRVDV9/TlQNi+WhqlQvdAok6bEQ9
         5wTEfzCnzFl9/ktKghUFvumDE3Oun/qZY8KiFoagy+xLGSDYwCMS0Xvmhb1banHv9onV
         p5hg==
X-Gm-Message-State: AFq9FYI05GU2Vdg9ei9GeqBnJjgOLTOFLoV5sN4/pQ5L0B2h5bG7PawI
	OQtV4SOlRdX+c7XrTS0xlmYo50dqZRwMJE9gOWbicW2e9fK+E2394vT4OfSwnEnhpIo=
X-Gm-Gg: AYBFou355ruZgu52dw22UPuQu6MeW4mQAURBcyoJm5qPVOO5uP0aUyl34Tfkk+GruBx
	0j4RnvOvMD2z1anQ+YJnGou/jPBNaGyw2p2F2GBsL93wKMLdG4nNYJonma21eICvH/J+FYP44eZ
	h1MKV7486TY69zKCJtyHMxoe5eMAl8P03mI7SCy1QNT/Jgom+j2zvVw+frnVGcfyJ2i55xZDhlP
	8l2FlJNjBdbcq1FPi1oBx00N4Oi9sTcPCLPny4SoKLB+QyTpvrin56+AxA5SuOqBPPyzqmqDgnq
	HitVdzwCug3sN45zoRsf2SgOSJ/E122cUhT5p9H0boosVKV2h5MocZycFqSfj8bdBTkHF3mnWWQ
	VN1IU9cQPIJrsj+IvbFiE01ZKZJwhdOpAfm1j8wkYX56HYzJnlx4Ls4AHJJyqlFozC7fCZnRn9j
	d+sPLH16OkIz9GGO6QGsudGZOTOZKuOPt2WekvjDnz59hBjtnlrXdDOu1Ebdt6ZWz40WPFS5/hR
	/NJVMPZR2D6+f949dFl5bZTD2U0k5tjTjtnvYBvyu4gUvTKwVe9BOp21GfK
X-Received: by 2002:a05:600c:b86:b0:4a3:5a7b:6002 with SMTP id 5b1f17b1804b1-4a35acab6damr121428865e9.28.1793018412357;
        Mon, 26 Oct 2026 05:40:12 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.191.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a08dcbfsm129102295e9.2.2026.10.26.05.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:40:11 -0700 (PDT)
Message-Id: <10f8947b685c4a5c2c1af9823e08a058d6944250.1793018405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.v5.git.1793018405.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v5.git.1793018405.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 12:40:03 +0000
Subject: [PATCH v5 4/6] doc: git-revert: link to new merge conflicts guide
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
 Documentation/git-revert.adoc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/git-revert.adoc b/Documentation/git-revert.adoc
index ffba365e63..bb0f859f66 100644
--- a/Documentation/git-revert.adoc
+++ b/Documentation/git-revert.adoc
@@ -31,6 +31,10 @@ both will discard uncommitted changes in your working directory.
 See "Reset, restore and revert" in linkgit:git[1] for the differences
 between the three commands.
 
+Reverting a commit may result in a merge conflict.
+See linkgit:gitmergeconflicts[7] (or `git help mergeconflicts`)
+for a guide to handling merge conflicts.
+
 OPTIONS
 -------
 <commit>...::
@@ -162,6 +166,7 @@ include::config/revert.adoc[]
 SEE ALSO
 --------
 linkgit:git-cherry-pick[1]
+linkgit:gitmergeconflicts[7]
 
 GIT
 ---
-- 
gitgitgadget

