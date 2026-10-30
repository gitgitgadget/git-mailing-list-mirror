Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355722;
	b=Du19d6EuuswMv81Kk+Ut44SYNEidKeZ39hFWtDd2lElP5NCoz8J/hlNUWKsFsbJm/HKr
	 IRVFUvQRBMFfjvde6P551JcDCx3LYgsuC9j9pl7jG8zVhfjP8mUztfvpkowrhctdsiIrw
	 nz52XwYEZI0tS6GQqfhIAPZVofmyE5UM98HCQMR5MfkPn84WhwV9AksODsgxYw8V/KNLQ
	 QeTIw9VapZT4aaEB2fIuEmaSK5W6sYIeszG6GM638wBVu8OtjjrIggvIIMLKAmfaClVR1
	 hnObzr4o2P1xyV4hBs6GOnVW8CxjSIFWqeL1l9KKAz6dwYxKnuudeLhlFxN911LkfJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355722;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=OKuxaKQx9565RAdkzDxDpsNPu2+rsT4yxJIBEIFQVZI=;
	b=JckXe+F92Otwu/YxV0D/qDFBT3B2bQ3aEnfhV5W7P+YDjbjgPYC62kQxDeMrC9zFHfRJ
	 bxfumWkC47Oidm45253FNuazwDVDTsCEtPbiEnM+s2eoqmsFFhamJj4qvd9UClvmhuBQO
	 JER0+zlX6sWboWrTov+KokD/o3B0+OMX0kHa8mpso0wNnLepIu7WOUuDCLvSW+8VNsp9U
	 IB+S7fnDT2/BMrfZeITN/aNbuT+i95lrBjv3AORNw9Dm3BptZHj/caL7uDh5hBp9o3M/Q
	 EPfrSbmw1nmrE/NyZQTt4Z6PFjZUoZwS1KBrn6UeAAQ7w21S/Wv8eistH1K6ghZooNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=fsfJeJiz;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ExoF9+OB;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA6D606A323
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BA6D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=fsfJeJiz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ExoF9+OB
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DBEF51D000A7
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 06:22:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 30 Oct 2026 06:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793355720;
	 x=1793442120; bh=OKuxaKQx9565RAdkzDxDpsNPu2+rsT4yxJIBEIFQVZI=; b=
	fsfJeJizv8wZU3TUnUJHvsWqXeVUlOV0FPVnT4fcg4kcoVT5N76op+btfLTidPUm
	utbwGD2Qn18awEXjIogC0MJrd3Y1sqpbMqcNqwp9/dFKZuEllfi+XJQMNgDmpwd2
	HWSyFk12w2u0TaB45/7VeZu5wPVDKwQ4+A6mu5BlHAxUIN1lgXm1IQpKTVE17KHs
	YP8cSW9sItfpHu3+RutMlcXJvLsE1KAPkE2WnvkIj8ekf5YMUDDT3eup8yiFoSZS
	ueB5rpsou3F7SU7BWs+R/rl1yeFhnmLxAaeao57xs374cuSVXE7NtRYNAC+wcn1R
	nCIcTJKmpG2icePsKMakJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793355720; x=
	1793442120; bh=OKuxaKQx9565RAdkzDxDpsNPu2+rsT4yxJIBEIFQVZI=; b=E
	xoF9+OBLIsGFFbIAZUKOZMwmrsQVL0wIiujNk4QnSVIsx1MPoQiaaYbYdNkT7oY3
	FiWAdQBdzGRpBm66vsm89d5nN10zDvSmTPnyoBSvffwJ0tpo5X/SVaxd4+/3nN0T
	xHC1DDBD6Wh+Ye3OPyxToixvqFKq4dUWBJCGXcR4TC/JYy7/zePGonjYuW4zHFJW
	odhTbOW13P6FeUUH6fD+gjJhWR0NfIi2myWNQ8DTFKKWCZ+lfZ4OZLJOde9EMYJ+
	2etE+x/aXbfbj98VphoQX74z7D2lldZqOsIMeuEwYFETxP5OQdT0NJobgKC3PVl0
	hRvuC1AVK5mxb/VeIcTQA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793355720; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:cbIuE1OQ+TESZJ59IjcK031HgKphUtII95Jfs4uJgRKBzTJ
	lIcpktYWqismjnNGw0W7nU8/2slqrCkuyxoEy/IwsWRiO6Ca4ytQ1AcyrtUBCViy
	oaF7OjmvAHg/4NkaVrm9RJEVq/Pq9nYqENnyar6l4pcRVzii6HUwilY/tMigWlwx
	yn8Q41w9Vemejy9s/bsCEJhK9yKmE5xzWhTRWk+PEy9eclakA3ssgbsBwYKgMFMN
	0XE07WFx5SP1xnqSMA1PqIKTrPZNfiJ1Q2WQPFFRQ7D96N3ROcFFFFYWhpFVlC+M
	k5gva4t5HrpWaJ64tsyJzYswC1svjhTCJbtC81w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:8N7fH+hktNdhiw/XM2X2bdaV9UB6DyJYQcy+nmb1h2I=:if18a5gsE6suI57x0/veWA/FNsU5nKZVC0mvQPMVv/E=;
X-ME-Sender: <xms:yG_katcgwIp26PzFbzuxOriKZvrErUJhleXzhDI4yHiFA_xX0oV2Ew>
    <xme:yG_kahPFFkL3NxJJ-o9dehR49RuBihm3iBYYXmBfIVrRTXdq6f37LJXWxiH9-inje
    CouZ3iC787jlTXH4kl_8hlcIYCsKeNYbDW4QNlFsLWQsNB7rK_Wxw>
X-ME-Received: <xmr:yG_kakLxjfRuKL5aVbpEOYobuE9tXgj63rzduzYvpuRHT5z72CiRu4YGXNjrY1rubvUWog>
X-ME-Proxy-Cause: dmFkZTGnfjP8Ce7Y5OxQEoi584NpxOS+ux2/AlFQpPqlCrctePrPU9xtuXEN57EydbMOeD
    uKCcBR0ZCHWL0JVVKdP2toch8j8m9MhSLZNd26rU3Jkm3/zUqEF4IuCZTnwIxaDY0V/tLj
    HPCCAd6edAcH74Fb6dTyZnpJL5lchwnIo77DZeDcJBpULBOuV/npxiguobs5HhHHcKxRwg
    DnXnPCidbyg13/FKdrwVIJXASUfEI7oDWJDcbK+MVWvtcezD0lEuTpE1YENU42Xjiy9+7a
    aou8YssUOX+9kEmTzwmAUrwGE6OIrCwqv8eeOqikEaid85oaqsh39WchJPYMjdWG/Q1aHZ
    uLqWxNjxZE5NKHtwm86dthwWGHQOb1XXgchu487tryIeNPCuCFQ6TRb5ABerFEahkPI66+
    fZmq9T/hN8UCvVxQRzhX5rBroj5XPmmgB4/J9SXunEesHlLpeSmw40UTmCNdNTOLT8UbHA
    LCSVpu63paYVJrK2q7jWUGtN0xHRe8xgfkXu7jKa9DIT9sTtpIAbAhJFIOM21ES8tlib9e
    vT5eEqrAMWUw39F+DJ+C1ILMaKbOFPjSLcaWY2TPR4WWuAhDq7V1IB/F04dEDp5Yi8RlKX
    7VOtxNGtPa5J68SgGocKVB5UxJKXOhFv+UMG/5lNt7YNeFaLrfqVhwA4T3EA
X-ME-Proxy: <xmx:yG_kaiFO43MGqgAwuzxJo7w0tFVXgYDr9GS8dxshABsxP8uYSLimNQ>
    <xmx:yG_kasRnLB4Lvs6Cq4Hhq5RnnG33HsGH8lxwtFVLMICnrIbAlZBPwQ>
    <xmx:yG_kauExavz3BSGyMqi2FyiqzKFNSfxjdAIQ2ZQodCMvXrF490R-kQ>
    <xmx:yG_kao8VCNcpD3oUWu0EqeHbiTX2aRWvn6jNomCXFe5vnIQad0F9yA>
    <xmx:yG_kakMRW_93kH9z52JmRWb5PbZK3j7ScAEhC0u5ML3bqveDkUrXx3I0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 06:22:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0b2e1d20 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Oct 2026 10:21:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 Oct 2026 11:21:49 +0100
Subject: [PATCH 3/3] builtin/grep: read ".gitmodules" via passed-in
 repository
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-pks-grep-recurse-submodule-v1-3-d4eb5c87d8fb@pks.im>
References: <20261030-pks-grep-recurse-submodule-v1-0-d4eb5c87d8fb@pks.im>
In-Reply-To: <20261030-pks-grep-recurse-submodule-v1-0-d4eb5c87d8fb@pks.im>
To: git@vger.kernel.org
Cc: Root <rootminus0x1@gmail.com>
X-Mailer: b4 0.15.2

When grepping through a list of objects with "--recurse-submodules", we
call `gitmodules_config_oid()` to load gitmodules for the specific
revision. But instead of passing `opt->repo` we pass `the_repository` to
that function, which is somewhat fishy.

This is again not a bug because `grep_objects()` is only ever called by
`cmd_grep()`, and consequently we know that `opt->repo` is always going
to be set to `the_repository`. But it's a code smell regardless of that,
so adapt the code to use `opt->repo` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index cb518d8155e..22f0a1b0d0e 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -883,7 +883,7 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 		if (recurse_submodules) {
 			submodule_free(opt->repo);
 			obj_read_lock();
-			gitmodules_config_oid(the_repository, &real_obj->oid);
+			gitmodules_config_oid(opt->repo, &real_obj->oid);
 			obj_read_unlock();
 		}
 		if (grep_object(opt, pathspec, real_obj, list->objects[i].name,

-- 
2.56.0.341.g393f52fd96.dirty

