Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217474;
	b=QpY1qoLd5lM8trsqgJjArKk1rxUF83vLLKv8cIIbfUF4f3lo0XWnrBnrtvaM+slQKDtj
	 Tc6X3jxuIa4tbUvjFppoXGnvvfeJ6U3m84eEpLHMp1Hv3GeHyF36V2qqQAVf7fMOyPgmP
	 IjDmRqTlPFBvHf5yqH8F6rXpCGqry19bipu9BnhiOz1kA1zXzxvtI1tuts5eRBJ6Erw40
	 h69wxoNVvw2VkLMVcrgEYCJsOS5oyE7RBVAPkEQevVJrWviwdKVYrbaGG6TAY9qch0m0X
	 NtUt2D1l4PvyVCJehT11gTyD3E77gjwtLt/CPwg6XWcZTTyea5wSyB6Ke4W210zxR1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217474;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type;
	bh=xxGWCk3FE091eJcPbuZD3jk9q717csQyoRzkKAu7YmQ=;
	b=iiOoaN7lHobd74de+akGs+wtoFvHQA2X3h6TO4uqxykMTi3g8TxZxiRzrGEVbSLfcVBK
	 frn0GGrajxp3VW5ekbvMMaWfjiA+FTQsi15tmL/mE8yYW708OpsqSd9kj/bjmjEZdb04O
	 miyKxuY0jttLAaP/pfN+PKjgmNKi1jO++dlrrA9VyrdKPgAdkiRUWmDo1CHvOk3YGpoyg
	 BzNnCyahq2Va90DAhMLJfP4IHyyfjF+jGKrBZPesfJLfBZTDMXRQkDRjohWAy7OOcu9Zc
	 7brIndej5OIzZHefJT9lJa2IoEvN+JUHkUxIAPlecYxyHtJ3l9jQpRvQ2Q0LaB0HRsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=UPRA7W+D;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=VBE6RxV5;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C8E606A31D
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 19:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02C8E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=UPRA7W+D;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=VBE6RxV5
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2E0801400021
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 15:57:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 28 Oct 2026 15:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1793217473; x=1793303873; bh=xxGWCk3FE091eJcPbuZD3jk9q717csQy
	oRzkKAu7YmQ=; b=UPRA7W+DPhmFbcB4xVOiXpFNmHKGtSQQakMsx8GbRVJnqG5A
	offisosBi2lRDSWs2q3qX3Npf023a8lWtuqCG68zEX5AAvaoP1wd8e0WUAKPtKxq
	w5ZcNArxddiG34m7L+YMxxqEg/wSMRUageYD4kNi1Op6ltaGhMe/LDlNHDL0uSr0
	AUwS5jtl9FK3f/siaZRt/VjRJsNspJfR+cOv470vcDey91c/2nTKeJtt5Bb84rQd
	NbzILAih078rfoQf/r+VQW+DzEhgFSea6hVT5P6jbNU0hyqrvT62M2CYzQkiQvHp
	6SJqR7evZdySvT/xEYeRJv5JklRBopq26sqrpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793217473; x=
	1793303873; bh=xxGWCk3FE091eJcPbuZD3jk9q717csQyoRzkKAu7YmQ=; b=V
	BE6RxV5Jyoskocpl1SFR28Y3rxwPwkM10tHoZLukRy1yE3uRcMZzXJOi1mKZElvb
	qJ8itjGA7tOMxSjduHNItcP6qu0AcRM4PKUCc+OLP0iqKJx9MI7Kd1m8o0o1pgle
	jsHHZBU591a0iL6WNpbZiVkf3sLg5QVqCHpgnZTnJKdScagnSJp0DQdxeZnjw829
	O0+B3DSna9rS6AycP3BW7ioabJvKjB7xhYIpeDY0q+vClbaC+McQxleEHP60sBHJ
	Eyns3R8Tujzetiw7XEais241d9r6lizszh/1z8Tk5VufsKNJMpq2EXXJkWuxCWRy
	ZN5p0ISOYna1HOBP40R6A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793217473; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:L/dBwz+/PNO94CoW74FlkSNhMRp6W5UN8ZjVc9uupYu0slc
	gf/OltqYXdAq/nTF/FWZOY703PiaCqTm42PJczslghlmjK5KFtoli2g64IhxHUBq
	tX8QlcQxM/JERcD7uOUrl69sdm7BIlx+5AMlWRgeVeTQ4qqi+jPzAcx89OeB9IQr
	3ATYVB1bc6pPnTdsyRY6jbn9+p7ys05LSD3KhYdXyn6LRCAqx0J3gW5FcCHjKH1X
	0fcB1vvVxUNFOC31/RrrJ+eeIlpvdkf6mnK1MbT6SIesUwjaH4KhkiMHHz5BwPPe
	i1S6LjaYPMBlIFu9Ds+OGiAD69263DGeWIyw9yQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=content-type,date,feedback-id,from,message-id,mime-version,
	subject,to,user-agent;
Message-Instance: m=1; h=sha256:83oFvpsPwSbuOt+y0xqhimsD+jjz4pXsvHYYmUwKTGA=:ZQVdWc1e5fJW9VxLcNvBAWbPbmEyGT9gfSceLfTuGVo=;
X-ME-Sender: <xms:wVPiagrcjwRZfxu0VG0W__Fa5pX9Lt9kCwBr2dPVg_EcUBO7UWMMjg>
    <xme:wVPiaspLvY6lrj46hv7XJ83APYOlm8tsAOnYVXdG80C30Zm-jecV-IWIMVKM0yzG6
    agNHk9qblFqn1AkKrRKPDF35st9TxWBh-qxRRDjv9ek5v55qBsEIA>
X-ME-Received: <xmr:wVPiai23MRcPieru3FSHtRhHVGh0TUlkNPEs4isMHzgivvdJyxZfZoJ_THcVaJVy-qSledRpdmGZWyE-l7_MlfrpnBrq8r_rNuad>
X-ME-Proxy-Cause: dmFkZTGhWOOFBUqpxCD7aSDUyjQFcmhF2LL2Z5sYDNT9c8b1AXQvBEavW/Jy2QsnMnIJKu
    dsT4NEYWpCgChAc05kSiZlIBPaUFl4pnvsmsq60sj5BIX74ywx286HFlBL8th3bWv//gO/
    s2R+HcZ1DGLAilU39trwp+DI8A0IsFFJK6i1YBJKIPNEb7OsMq+3WAZPIHaLfRrXNer9ES
    5iaMhPePJyIp7FV1YXX0loTOjhDM6Rxk9oDtHJXyO4yBCjj3+volAF7CikVUkLoPglp0JY
    VVVBjzDepbUdhHTexdIc9XbfjyPhupNrlu7DdA495JH/cNIl2I/QMLcNx+RtKGCqkL1GHK
    Yg79UOjFL05ii9aWQAeZo46t3slRB+81UrFqLfDDBHsK6wc0ih7THvubBYbsTX9l28VWrL
    vgwulYYNYHjWJywJE+v2ZneSi1QqrL0snONQ7xphmZCjEIvn5M1xsqN9ABN4+s9JVGx5t8
    CD/Xrxg/QeZI2tAN5HbvvituA+pii3QQbC7E/vODHzUq40ZNBe9dOsiCJogL1W2s6gMqrr
    9XIhYQixAQ4Fa3pLt7PQVVEhnASrGfe5I3RQhx3kcvs0ELSsvqlFwY0CrKo+HdJz2ASZyf
    +sBoWTl9Oc9RsXusA4KRZXAtfdRozIYgn5b80YEb1RM8i2HAW199NxOL8kAA
X-ME-Proxy: <xmx:wVPiajC1E5Y3tBhkYbVJo3IM_jAmD3FEMgYyuZHBApD6NPuXoXQdKA>
    <xmx:wVPiaifDMy17-77IqqZXmovXUlKUCVQUUK-Dj18FFfRKjn2O20LbOA>
    <xmx:wVPiaggN6xe3RtlZJohlq0bDq-Wg7xBvaym2uu4InmKGSfBoccYJkw>
    <xmx:wVPiaipvvit7CmWSvu0PdyLx498E2m7vLbocWhW3LVmyFsE9Q0RIeA>
    <xmx:wVPiakC3Rcm-MLLARYZjDTxG5giSH3DcGbXcIK_9nOfksgcxBig0PXGo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 15:57:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] add -i: hide init/clear_add_i_state() functions
Date: Wed, 28 Oct 2026 12:57:51 -0700
Message-ID: <xmqqh5i58uo0.fsf@gitster.g>
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

The "add -i" machinery is encapsulated in run_add_i() function,
which uses init_add_i_state() to initialize the machinery, does its
thing, and clear_add_i_state() to tear it down.  External callers
have no need to call anything other than run_add_i().

Make init/clear_add_i_state() file-scope static functions, and
"struct add_i_state" type as well.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 add-interactive.c | 11 ++++++++---
 add-interactive.h |  9 ---------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 3cf8a1dbf8..9a00daf9f9 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -19,14 +19,19 @@
 #include "prompt.h"
 #include "tree.h"
 
-void init_add_i_state(struct add_i_state *s, struct repository *r,
-		      struct interactive_options *opts)
+struct add_i_state {
+	struct repository *r;
+	struct interactive_config cfg;
+};
+
+static void init_add_i_state(struct add_i_state *s, struct repository *r,
+			     struct interactive_options *opts)
 {
 	s->r = r;
 	interactive_config_init(&s->cfg, r, opts);
 }
 
-void clear_add_i_state(struct add_i_state *s)
+static void clear_add_i_state(struct add_i_state *s)
 {
 	interactive_config_clear(&s->cfg);
 	memset(s, 0, sizeof(*s));
diff --git a/add-interactive.h b/add-interactive.h
index eefa2edc7c..47f67ede82 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -6,15 +6,6 @@
 struct pathspec;
 struct repository;
 
-struct add_i_state {
-	struct repository *r;
-	struct interactive_config cfg;
-};
-
-void init_add_i_state(struct add_i_state *s, struct repository *r,
-		      struct interactive_options *opts);
-void clear_add_i_state(struct add_i_state *s);
-
 int run_add_i(struct repository *r, const struct pathspec *ps,
 	      struct interactive_options *opts);
 
-- 
2.56.0-433-ga9209adf11

