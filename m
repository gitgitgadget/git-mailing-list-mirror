Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D036441B378
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971279; cv=none; b=s3nZp4wdf/1GrnRQsYoeq7okkwryZ5dEyi1ckNYOMvw63zw+X3tqkub2xNhK1JnnNbpJHSRhSjVSQSYW2IX/WgLFC/aeRc5/5GSISQN5Uxr0DsPvLdNA4JYpK7hlyAUQweTZKsEGIja9MpH3HTUoxdXMWYUO0IUzLU1Tfk6tU4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971279; c=relaxed/simple;
	bh=msYB1zYEEOXhRne0FH97/Go08Um2lHjzGi20cjvFugM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I0qmkJvrREyVVcyK1X4JMRRGnVCBtwgz0fZ1oEnLFT3twhXuYHCQesrk6eAX9v+0tKj0cz/YzfNdnYznz6uLpNADba6KsyMOAv79mSMllCUFszs7wDtAh7+tCD4kxe/cmBqxzXi1LTP7fo3lWI/7iq6eKbm7H60cPKGIQ/FaR0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o+DERE1u; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+DERE1u"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50912a097b0so33601211cf.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 08:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774971271; x=1775576071; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHQG3BIlXpIlwyLrppKmzijhQ5A68Pg2yeMNl6h5qy8=;
        b=o+DERE1ukt7NcQRbbLiDi/Y9cnZtDiPZa2pA7VvD0tLoEbR9cjiLT1LxfReEZUyjd4
         hXq2gz14C7MyPmsF6vyOYi8DstoGPeLF4ojvMVRi5jtPK60eezTQuM6cbSZxtjIHWG7D
         jd3qZj6O0qrTof6lMMRIDmY7UecBxxfckBhydPUl30s3XTY0Wjcm2dOPaFiP5wLdPtO6
         WijErqHkT5IzRq3NDMeJY/7NTu3QppmScf/OK8bASn1jo0gVzZQmw3q0/1H9GfxetVxb
         V5QsfSPD4hFYK48BvBYMCo3wlZtodyX6Zacg/zHA7Pqh9iMsTFeRG9nbmBv5Na72W1D8
         Wdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971271; x=1775576071;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AHQG3BIlXpIlwyLrppKmzijhQ5A68Pg2yeMNl6h5qy8=;
        b=pghzOWS9V5hxp9TE2OCciGIUPJ5NL184sVcUT8LEe17Rb7idZgU3OwrvP3J1anXhjg
         3YLkMW3ogeXY6l14v/l6gqXmzsk8z3ew72EVhjum8xkBi3MJxiAezmI53hrMJhFCafMX
         ibyHOWiFEVLxUunCLvXyr3qYQIfte6EqDrMSCiqbt1i7/WdCrHfF9vQ3vm+GoqqsvpAs
         QVyTYtfKF8uc0mPuJoWKUdT85dYEARGvpZVCX13/cIwQcsv8HJ9QW+veKG45U1s6V1fQ
         y4yU02tUsj9oGr5HFCnvxF+dMxQ8MuJxYF5FxBjDacyZFeNjDk52v3bOKLwASq56fyY3
         Qang==
X-Gm-Message-State: AOJu0Yzbux0iuCKfkI7SiekY/aqLD+UqOe+XDr0tUrnTOzwd1SIa4Gwe
	Jz+AEF6hdzwy8CB2+6q9DEL8OKKttVy1/fOYo8nt7GSULxRqvOilnNEDW1cpew==
X-Gm-Gg: ATEYQzxKDpsyADrpweEipgdCMbDbX7fsYfS4sdZ2NdD5tTe9hSvHyjUjF6xKrS5nFPW
	r6Vd7yXhoFwdg7aWksVRDi75Ak2I9hU8zmAutv0pcSUOqGlGY5y61yq6RsqdZ9jDIYxQIUWoKtN
	tSF1uBUypkSxtD48mViMenW3wzGsRl/9Xsf2Uj+IRADPzjxOEyWuynt33pBACxHTx0TR9HswAs7
	75GVkK1Vq5SCUMk9ANgnRf3kN0+kQ0uXwwOKoCPFHgJKSs7sbkdDNNZp9UD6CzBJJVkkju3aE82
	yLEyzGqYs70/skGogtlu30Vl0xJjxbzMk3eyegIvEvP0EEAneOsrUEMrD8i9k579eWeDPaJVEEy
	op7TyiaQX2TXkqW0saPoGFTKJ0BIoIamrYfvvmz/WtDGTQo4cvWJOATQ6IvW3ouhNvOaGd6BkaA
	Xq2mXa5m0w85jwJIQeW+vW8jJ8RPM=
X-Received: by 2002:a05:622a:5917:b0:50b:8b0b:11c4 with SMTP id d75a77b69052e-50ba380b4f9mr230725811cf.11.1774971271087;
        Tue, 31 Mar 2026 08:34:31 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.224.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2c67fefsm88124831cf.4.2026.03.31.08.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:34:30 -0700 (PDT)
Message-Id: <fbdf3271b7b05d9e3afc9aa3d476ccd64f867d08.1774971267.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2258.v2.git.git.1774971267.gitgitgadget@gmail.com>
References: <pull.2258.git.git.1774901607564.gitgitgadget@gmail.com>
	<pull.2258.v2.git.git.1774971267.gitgitgadget@gmail.com>
From: "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 31 Mar 2026 15:34:27 +0000
Subject: [PATCH v2 2/2] unpack-trees: use repository from index instead of
 global
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
Cc: Justin Tobler <jltobler@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Jayesh Daga <jayeshdaga99@gmail.com>,
    Jayesh Daga <jayeshdaga99@gmail.com>

From: Jayesh Daga <jayeshdaga99@gmail.com>

unpack_trees() currently initializes its repository from the
global 'the_repository', even though a repository instance is
already available via the source index.

Use 'o->src_index->repo' instead of the global variable,
reducing reliance on global repository state.

This is a step towards eliminating global repository usage in
unpack_trees().

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
---
 unpack-trees.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 191b9d4769..b42020f16b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1882,7 +1882,7 @@ static int verify_absent(const struct cache_entry *,
  */
 int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
 {
-	struct repository *repo = the_repository;
+	struct repository *repo = o->src_index->repo;
 	int i, ret;
 	static struct cache_entry *dfc;
 	struct pattern_list pl;
-- 
gitgitgadget
