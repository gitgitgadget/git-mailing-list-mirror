Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834483;
	b=HHRAVd7EMvRWBNyVF1eYhtmIwQ4jrnAOO3PzyjoDI67YL/ecvi63yh8cSZjLHHNm/e9t
	 eMGKyZmF3Xs7cJQJ0shxDNfrXpFVKYR0E142HQQFhQKMHPTyTWh2Xpyl/AAdzkeQUUFYE
	 EOutTe29YcKzioSbzYxm1laN15ZtYTkQLWXxG4iSWgr9Hh2W3dkYV4xi+WEZPxvS0EsqJ
	 H2NgqgOB81ps0r93hBtAf16cKwSSYoW+LZY7Eobg5VJdYMuB5PAn1fTC2QV6bqHn0+xhJ
	 laOS1acVPRoegPWElg7TVoxDDHjNUyBdX/7Ctq1gNlAt/ZvBClk1JZXRLoB+qCmgM7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834483;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=W4Z+kgmNyVjXuhW+e7XuoTvCmZRRtK120PJiG2ji0eE=;
	b=SRS/k9e0dqXwT9QK/Hv5e6I/YVCZpaPPLGlLXCjaYard0G3KP7NwBCp8LY0o1Lg7ypPC
	 u65hcLZQkyXicJkrUUQzVEyDNVeJM+EfbdyftSDcswCytOFFBU//unUMJFPONXaTFBLYh
	 TEe94hvTgNue64jMuhJY5p0o6j4Jq+joS3q4OiLeRFrYbsosedvgqgH0VpRaDttwTLOs/
	 S4huAeVZAFNRGS+AxDW99Om7QhKVBskIZqaLnJtp9CVheV0w4hqrTATl4xSy/yZaLWNCX
	 vlg5ALK0mK56ql8uYt68uZqDRrqfhT2xuQeEJI6JV88gnONtbDbQPO4TBSLgGZpaKFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b="t/NOwL8H";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=k+Y9TrtE;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794DF606A88B
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 13:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 794DF606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=t/NOwL8H;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=k+Y9TrtE
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A4B96140002C
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 08:08:02 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 16 Nov 2026 08:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794834482;
	 x=1794920882; bh=W4Z+kgmNyVjXuhW+e7XuoTvCmZRRtK120PJiG2ji0eE=; b=
	t/NOwL8H3v09GmenqGw3qyZE3g3Gt40cnWcjs0sQ9eKU/M4mmybRqF+NG0aB9l7G
	/sgNb7t+VinIrTnPAdLVBuWHx25J5XLcOpDPb8a7lxqD+2/v2161CpbpcSvhBaHi
	zT+gseNgl071ourlwLc7h8Jr/GUmxAUHA4MH5xVglvftBZWg08qkL2HIwCg2DIFW
	zlja8RodVRH1Qm4VctMrSgS7KsWdVPs/9Lum2JqMhTUZpg5riRvp2reFcrtts9G1
	hVEUHjf2pEuS0uSrWttCvcJKFbYnfwOGI9AVqoByrIINFmgabxCru+NXm+onQnPU
	UFsRPLlf7LiFyQvzvZ1iyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794834482; x=
	1794920882; bh=W4Z+kgmNyVjXuhW+e7XuoTvCmZRRtK120PJiG2ji0eE=; b=k
	+Y9TrtESw0aqADPYgrMfD95KczjK2SYvkog5cH1je16D4abxzDc5UbgHbkXgMARc
	zn5/PIGBtRQcPt9BtKwTO6hSKE1bogj01T32xtf7SrhQgskzsu8ePOOTgsKl7Z8A
	Zco40ml+Otbrv80u9NTcMhJ6eWiw6fogpZj0uSokD4h8vCeAGsS9ejE/AHiBjuwt
	sFIeqeH494d8YrrMfpPYm3LrcKzOG9E+uCQcQLGF2hD+CRp/5tKRq9HbB2fcC7Jr
	J1th6mLypOexYfzrC1Cy4WZ2b+D8KVvWWVjswtkyWTjNUg8+fUtWDDbIQ0y+hbnn
	cfCtvVC7JTos39TMAHxJQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794834482; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:CNKGk3X1qearUcJKx+TMP7A5v+7PbG+qRb3NNK+H5RLdN8M
	z5tpwXQxSUPPcmPCepw9aw4hZm8FtCXnWRo+mEcY87vDj3GWxLzZSsj5UCIKltwa
	drh1Fu81m5SCPEdeeoBJRa2WBz0Y9QYBITGGvvARH+JSG8tSfsO3DeutsiqqhaJh
	hqApOZ6lR5TdSvw+x0kq9pgPnsMXs7q2VRK3inConZViSWaNmdgtzUcbk94GtfQh
	ZZP49YJwoIciuwVUJNhF+VhGfbczr4Ez66xMUyGCiEokb5cOqwOJFz7+BSqbXWiA
	CDfHncb7PKZ6d8u6Zph+qIa6FQGoSi4Cciqy3ug==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:UJ/G3Bqfs1K1X+byQeMa1Tx6wK0tsyeGaFbs5WT2gGA=:y8t5xEPiKMCY22oYUAyrCLtKx20RyW1JNL5XlzwPpe4=;
X-ME-Sender: <xms:MgD7ar0uh5VvHp2ksEefX9c3YPXDXaammItmvIgCM-DZXi1hrduBCw>
    <xme:MgD7ahDJaMHL7aHvcaDPPwqId5cLxJH93PaoILzV-y1j6EUuh4pyOkv1EsAetBN07
    Bcybuc2PqzjnHgmmYD5WiuCVmoMrIkwIR50-5O6Q0OEsRnxkoA57Q>
X-ME-Received: <xmr:MgD7ahhnJDWUSpRC_-Jz8pUjQNgpbWtGqoEDRbhvUBF5XAo1RPlZpVCrmHAI9s2obA9o4K4>
X-ME-Proxy-Cause: dmFkZTFZEY3dRZaxYHKztVo3PV5exS7LC5so/OemZvN+WRzyMAuPxUkF0s8DXR9rm3sIft
    TNy3msB44N8fedNp8OEKsFykHBMtYYTrfbK0L+IwZ5LKw3S98nfrCPUmkqNy5t4VRzNB1H
    O1k+n5la66tVUCb3ERJIwzKtcyG8zt2k7Nq63bv8Bsb1mnjRJ95cbEfwctWmirTzT7W0Vv
    +wbH8aDjSJMImH6U0aTopBPlpGclwtUfOlL0sb99rKBTgdFJT1iNWAATNvrbto6s5wHgrA
    pyryLSwJgJXsiTvNzA0Sp3b/jhixtqv/ivz+VDrfFpK2d437jTBw6zWR21v5KA2lf8++c1
    fmUTOxDB41GhrmpX/e/onRN9xlfr/75l8ofFonmb+kjQOTi6J0OmLLe5AzDSA3/6ozgSN7
    5riDgN63JsRTBBP8tMGLLdNkhbcaOj7NkzQk6WVRmdhcJ1wwF2HquAq08MeiLLnVOZv1OK
    zKBjUYpc8fLdz4lxbfx25T4myngr1GPUflqd+HEr7QI3BhgoTEnMdBi6MTUTJOoaKaJlJM
    23hXH9UYmjkpJFfcQpt/5IeJyQO35tQubeguj9uha/+zPtmHHyzi0nsPGagupRPCnbkCbf
    v5nHoux4nMz+Uoy9QTwGusv3xDl1RcA3xp6fH81gX+N7lwLmLYwcfPS0kEdA
X-ME-Proxy: <xmx:MgD7al_2tJf9Y4NmmvP-tVuqQs-x-vPh4QvsfWJrMQhjM5sM1XYzDg>
    <xmx:MgD7at81H1ATSp55p6FoQzlz-gQ276LQqP7_rzs1CUeoNX1va-qG8Q>
    <xmx:MgD7auA27_Tm__iIIp49e80py-rcw9gwyO0d3ICVxJx3aKjEd7ZYyA>
    <xmx:MgD7atymphozWLbfwqBVvUEdhRn9ECedlNEfAqW5kqN_qnIuhY7dhg>
    <xmx:MgD7apGb35PqaoDBTixLtdTvEtMLShJJ5h3Y7zzhkPz3gZCzkkRzkwfg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Nov 2026 08:08:02 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fb046f11 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Nov 2026 13:08:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Nov 2026 14:07:39 +0100
Subject: [PATCH 03/12] commit-graph: expose function to validate a commit
 graph chain
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
Message-Id: <20261116-pks-odb-pluggable-commit-graphs-v1-3-a83fc1ff0808@pks.im>
References: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
In-Reply-To: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When we have loaded a commit graph chain we need to validate whether all
of its layers have been written with compatible settings. If that's not
the case, then some functionality of the chain needs to be restricted as
it would otherwise yield inconsistent results.

In a subsequent commit we'll move loading of commit graphs into the
object database backend, and consequently the backend will have to
perform this validation. Expose this functionality to prepare for this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 9 +++++++--
 commit-graph.h | 7 +++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index c427a6f90f7..9464522feb5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -574,6 +574,12 @@ static void validate_mixed_bloom_settings(struct commit_graph *g)
 	}
 }
 
+void commit_graph_validate_chain(struct commit_graph *g)
+{
+	validate_mixed_generation_chain(g);
+	validate_mixed_bloom_settings(g);
+}
+
 int commit_graph_link_base(struct commit_graph *g,
 			   struct commit_graph *base)
 {
@@ -695,8 +701,7 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
 		}
 	}
 
-	validate_mixed_generation_chain(graph_chain);
-	validate_mixed_bloom_settings(graph_chain);
+	commit_graph_validate_chain(graph_chain);
 
 	fclose(fp);
 	strbuf_release(&line);
diff --git a/commit-graph.h b/commit-graph.h
index 8660c7fe698..dc4f6194c72 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -134,6 +134,13 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct object_database *odb,
  */
 int commit_graph_link_base(struct commit_graph *g,
 			   struct commit_graph *base);
+
+/*
+ * Validate the chain of commit graph layers to ensure that all layers are
+ * compatible with one another. This may disable generation data and Bloom
+ * filters in case they aren't.
+ */
+void commit_graph_validate_chain(struct commit_graph *g);
 struct commit_graph *read_commit_graph_one(struct repository *repo,
 					   const char *dir);
 

-- 
2.56.1.763.g16177fe143.dirty

