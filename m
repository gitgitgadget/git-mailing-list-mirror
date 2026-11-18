Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026663;
	b=dElUy0fJ9DUAiV8g0HfjBiLRJzhDoGp/oztR3RVbmZhaNcPUI5JeqMue/pjjU+QaGSjV
	 Worph4BJz6sPNwtMny16BOji6Yz2iqgPS75wqC7v1ry8qJ7bO2VBAXEo8QCSEIalu4cCI
	 q4ugQZZZkADXnzwEzFF9SvUI7HPNEX4MstBVgV0ruVjD3olw1LKo/AM/Yp/2hl/e3yajQ
	 fDmP9FZdVZhPVTV29G9OjMuNw8yeuQbxB7rjr6TlJ5Haxxi+2ZbwIb5LUYr7j1GIY035E
	 NCSO92jDsuu+te5j0/j+ikX2IuowYbqkEdJPoic2wwIu0wnln/ibjtUE6sz/bkGm1Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026663;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type;
	bh=znHIppFrkT0MSzyZbJi6Y93a0+i+XXeq0QYzL3W+JNM=;
	b=rq1f4als18nWCEz4Bgg8G7wygqPQOsMQcf3n9QhskjGlgoQg+ydQ/FLH7tQWssujmWhQ
	 viKyRqRsEs3ZRKfmjWxllLjFHntcJbIjcG0EfkYbWAEotitM7XoeMZ05J7jW2UtZsSZpe
	 YRKCCOGptgmddDy+zRmIXm2hZGfIMNfbx3vVw6USZ/nYDLESIfeYscg9R0/rMUB2J2G1e
	 othU1hmg5KyfqS8Csikh7ZhT5sNP3u97300hyVrcUIN/irWxYHvIxzX2lriG1Y+OJ31mr
	 /EVC1mwEWkkm30qMRKTQSSMBxwXZFd3+WG2VSuN44ccGWt2nUBKAMOIL0qJRNsBhDfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="dVTT/P9r";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=HrTP3dWD;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A0F606A32F
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 18:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27A0F606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=dVTT/P9r;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=HrTP3dWD
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2E648140013D
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 13:31:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Wed, 18 Nov 2026 13:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1795026662; x=1795113062; bh=znHIppFrkT0MSzyZbJi6Y93a0+i+XXeq
	0QYzL3W+JNM=; b=dVTT/P9rlFvAT/ubNHLP7G9OPPVpZovRiNaOEkvB/ad0tv06
	n0XMDBVgQM+PLly6nbSmCbo/aDQtlyoLEgWG3NXv1Aol2Y0YxEbpADL+mD9jZuM9
	c8NbJiEFODgUzln5lYM6qLMw3RxhzfSoDVKBQrre0T8+h9F8ynOdUEw4bTTPV9xb
	6mfeud1LriHLoDK4sBg1jJgc6LYXZWwpq6ZPq6aWaoZSy3yCsTE5fx2BpVVlaomj
	9x6oeH3/ZNdcccIGLD9qkrzUhAq0fBxdArxJP6cVJYA/yth9Iy7gYDHf/ZlQROER
	5gZqdKddDUbwEmVpuXNpQmuefMqxyq1O9MeLhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795026662; x=
	1795113062; bh=znHIppFrkT0MSzyZbJi6Y93a0+i+XXeq0QYzL3W+JNM=; b=H
	rTP3dWDGW6Ub7t8hQwIal5380ALBlxWjdMmuD8EqbIVz2hKUNSzOPEuxgkQSR/bI
	HICCjr5zdQsjKHLkZFpK5fkMx+zbJq/CVVN8Z5fenUvnNXMDz45p6OPX/HzFIZO7
	xG3gKKPWCyezuxUaM2iT8d6oi/X62PjEq7p7WXQNVB9BilOt7wY0da+QJ8yiounf
	4n/72395KYs0O/nXgwyJG2qPlcgOObigLWpKHEXPlhV0c9lNV8aAp4HV2Ie0g649
	ADsNzKXxwxjGtO8QNrzVPuVeAe+JxSOSJCbqHBTEgUErKrtHMhgM40ZW9anMYWvZ
	40wfGrpLBIwXXdl5XzORA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795026662; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:e9bCGI0A8csaq3RhxnhneBTrwOqOIcMEQF9USJIwv1mJr6e
	1yFzzR4x9iWB+nVmlD0rpIlHbB/Hzybf15nR4wFlYo2BfSAcHvPoEO8oTHUO4udq
	UJQQva3t47aHGN589WUx77eBs250IJsXeP18OafIK6JVQd+0rj9GqGWzJM+9Tsan
	JaLzd5UyYcO5NTiL5zuzXqavCdLHpl8F27F9HY5a0H/oKNKfeRYQnTgxepLUZks6
	kiF1AicpX6JSJI0EPzSbdQC9N+hTaNM7wK/PLK904ZSHwQgRWT0rOipYu7P08Skp
	9yAJzvmJ7+fEer6GlgQjovl31AX1nnPbtI18Spg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=content-type,date,feedback-id,from,message-id,mime-version,
	subject,to,user-agent;
Message-Instance: m=1; h=sha256:DcPyl45bzIOmd8RPOTZyLha1GmkPBb1O5liPvHcD6TY=:WADrvZR0FtILeDkjilD80mH2Dt6xtVqOGC5JAnj03lw=;
X-ME-Sender: <xms:5u79aq2ABLUiVIGPUV37D02ZlYip4S_U35zSHJ5rjS0m5ifvsgpJ7Q>
    <xme:5u79ajHXlZxtS8ZbBYqkohPkUoxQLB7AgZ-xtaWzrkWqddwHt5an9qgT3-gpeHjnY
    Y3jbJj80X6hCqxcj7X6aqm88VXOTpsW4hKQQmUx_uk_pule_LViyw>
X-ME-Received: <xmr:5u79agicl16gMVAI0f6eFn1UPp_5PUwPszoWcL60spzZk1r1dTvQ62nrcjX3N9Vt86N8XvOTmMzHHnobgA_u3g_-OKf9LH6pS-uu>
X-ME-Proxy-Cause: dmFkZTGVWhu7yTmz1cx9HxatjL1QPJ8Mi0ZYMqDd2H8ERTrrAviCr+YNvIR5np37khoAGc
    KCuthN9N0lmgBelCWxxUBrOEGOt4sl+ttCJaN+TLswuegiP6HQdAbC/MeraY/m0d42LS87
    e8kU6O0Xvta4SBWi+u5cFGWUO6i9B6WwA5l0FBhhZrgVYn2OKvYMVJTvq3RF2e6lQJgcCK
    ZtAmMDz61H2Yzh7/ZqbBo1vgUbaTqGBu8le4F5j/SSrtCJ7JjfLGb5Ncvu8Two4BQZvNwx
    +W2XGIblwr9q7qpLHpFTVnLZ+WhvgiyIv9QVLeJbm0wx1OaRgx5UDRKgZbVWVAyvJ+NFeD
    XwwVwgmW6qzowNbwltW6c099msunUawxx7IaMEqTtQCdEHPTbEznFxjRDklXmnBIBSnzh8
    BkPYb29Tok6odGSHWGD9ff3m4+ZbKyIs/FFQvsh8q3ywQw0qK4626IFfrnChpmsgbCpsNP
    +jwvv1gPoH43tGxxtciDrz1X3aQrNkz4IW6B+A40oMyh3jjs0Ddi8tHwfiilF71bNBHscD
    /KNEBKi8Ymz40XQle87cpdiqEKmfOuYqssEo4k1zsRHOVTf3NN4r2xAtUsIe8DTppUmzLc
    i4GvcKmojwree3mcNvoaptX4RGpnoIXxnDUTbPutOy7VX4/7ylTMvyfGTM6g
X-ME-Proxy: <xmx:5u79am_o9mvuDQSRJk00T3Vh42wS18ttkCw_jDMrkZx3LozK1Ze81A>
    <xmx:5u79avouDz_PXgGyaKUVXcj-vcbza2Uj54EZsHDwrF6OmaLssneN-A>
    <xmx:5u79at-HuzWutVs4jnrGUlymV8lne5rZ4Ienf2UAEhKuJigTqedCmA>
    <xmx:5u79arXmE9wZY6PB9AnFA6PGtOCsIVUDlEhKwqU4cxu-saIxi57TYQ>
    <xmx:5u79alo_X4xS2fPdCrfNkdQlOSRiCDaiXsLCZlnIZwkKgDHnEu3R8Lkk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 13:31:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] CodingGuidelines: !! is not all that exotic
Date: Wed, 18 Nov 2026 10:31:00 -0800
Message-ID: <xmqq33sy6lgb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Remove the clause against "clever tricks" that cites !!value that is
a standard technique to normalize a value to 0/1 boolean.  We could
resurrect it if we can come up with a truly exotic example that we
would want to avoid, but this is not a good enough justification for
this rule.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * I think we saw a good example that !! was used in a recent review
   thread, and the idea to remove this rule was floated back then,
   but without following through.

 Documentation/CodingGuidelines | 4 ----
 1 file changed, 4 deletions(-)

diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuidelines
index 3c8d6c7dd3..4bfa615bac 100644
--- c/Documentation/CodingGuidelines
+++ w/Documentation/CodingGuidelines
@@ -522,10 +522,6 @@ For C programs:
 	    that_is_used_in + a_very_long_expression) {
 		...
 
- - Some clever tricks, like using the !! operator with arithmetic
-   constructs, can be extremely confusing to others.  Avoid them,
-   unless there is a compelling reason to use them.
-
  - Use the API.  No, really.  We have a strbuf (variable length
    string), several arrays with the ALLOC_GROW() macro, a
    string_list for sorted string lists, a hash map (mapping struct
