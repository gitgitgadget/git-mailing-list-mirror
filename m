Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834493;
	b=r0cGskACW2pywQaXpqD5VeDWg6usx1FeJXAK0RiE5Atj8NaMujVp/zo+kK4pwadiLZYr
	 3w6XrtL3qos9tk6kyc4Gwfz6k+RisoRs2jaBXnyVekiLcxExiuphP6ruwU2ngznEPnodR
	 2JLHRCvZ9G/rQC80XYmI4fpdvVh/xWH0AkfJhByutx03uhmLAuaa3c8wRXWDL81H7CdTW
	 dFwuOBRDK4LTAFrAnpCcrumbg4l+fK/Mlkf4QuObUJW+omYWxPjQM38xCgLjVAXBTHMfQ
	 RIDzgLQMtR/dZ5+u8LHSBp7WNCgXZRhAICD3fdN7FS46gcYfhWsmANExog9PlDf3tfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834493;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=nbIWBwy5gkla/+UH2Z8wZFgW9xrxGYUDiUTzKFqwze4=;
	b=UmJlrqts4DS2O46myQcs1ILkAcCvVDz0uUy5PMZOJZmAAFGnRpKPie0ePU86V6dLYR9S
	 RZBK6d+DRn2JuLB3BTOTcdob/s1k7PEBWzOp2jD5vRmvDdpC25IloxWmaL1rymsbLGfnz
	 0fI2JfxgDDnLvjtCW2SO0BWrqbrOlSTQyIu8h58S1W84dN7V172sOQ9C64bPDU1rmqqvx
	 +zIseqyhnmGWJysj5f/+aCv2Q6ZGUX2ptS1v6HJt7B3i9m34XbQle35XD7UBZgpYrAaVU
	 3EtLF65r+fW3vo6QqVOTZJYEW07CLiNwCh4/JcgBPNXWkVSbu3WJYoqM14u2UaNaYfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=KMxu2s6S;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=45GqSqgb;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7A2606A31C
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 13:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E7A2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=KMxu2s6S;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=45GqSqgb
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AF91A1400033
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 08:08:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 16 Nov 2026 08:08:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794834492;
	 x=1794920892; bh=nbIWBwy5gkla/+UH2Z8wZFgW9xrxGYUDiUTzKFqwze4=; b=
	KMxu2s6S/qDiJxY0BjCUMmPh6H9aC9lEUZaFA5QbL9mNsj7iqqdi0B8q7SJaznDK
	ApfBg3aB7maNLPngMsjbElVGqkFasaNjTYV16Q5cU8YTzvVY97BuLp5aQWoGLRcu
	VH/xHepuu0SqkSUq0CYPB5opCysx6c4bvZYED0RmpVNIBcGytNBmHQTzxthi8UnC
	rdUF+Ijbz3ijf1KIKfW34+Q5UIN7TQE/73LT0z5c0WuvQhcuZXdzQcUdmPVoE/p1
	XVKXP8OGiRjiiKDPlNWmBkfmiyDlhjhGioityhyrwRoWqel0vEm3141stNJivzzN
	BL9kj/TGoPqPH0jTmHws6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794834492; x=
	1794920892; bh=nbIWBwy5gkla/+UH2Z8wZFgW9xrxGYUDiUTzKFqwze4=; b=4
	5GqSqgbPBHlj8f1d5nQJghNnzljXq3uwKFt3+mmz591TR3TCimXowedoF2luv/FO
	3KzIjj7a7v6j5XX3WbzqPuxaBDbiwV/Ihe3Fmt/OTermo5ZlxH0McVFfbfTgy98s
	rEwKg1jMe15UoPDJTMxoZHkfdkw8mJvGiea88abQLVkw2WocL+6W99LjXVlidzo2
	oREnDPJiinK0zO7WSsvxyZ1hbPljlW/GviIKt6o6nHun+6Ve4JLd2DtNiNpCquzX
	D783dukoDPMRAwVgMBp1Z3l2Nf7Oc+APLslYG/uMDjJEmuKm8ovr6c4StYz0fZzZ
	hP8elCFrengTRB1F9F91g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794834492; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:MeqDwwGadbdKINjdaiwqhKmYvhh4T2zUwsjqZjsJdZIsdUj
	/wZDzOvgNX4j6xmzfvksTlfNTTfINbQKETZVFOLG8NLIL+ZuccOOq/cyCNigrKFb
	yx3kJVsAVyAjG4uvfU7bBhEbfC9JQquQLYr9fMbY+BAFQG8dFf7D2y7qzg889TUR
	1oprybSWrQwEv5eyEvaWhfUqLM79Jtvy/TSl1DoWqfLXcMHyI7tjURtxtFmcvIay
	HDkTQ4kFESh3cNkKnJ9wz8RJZ5kjndzLuM22CIsqeiZoSG69YZAq6rD0Ev/rYZ8T
	lQqHgmyETiUcuwceEWWv0lKNmgiiS+HBUMJdi1w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:PY1Tz1w3WAsVq/V6eBRZT1KFMJFaVI4F6QD7DTnAXNw=:pHFBHZRwjBfqP2jCgaYyq9LU/oD3elxhZ3Xzp6niEtY=;
X-ME-Sender: <xms:PAD7ajLKMHy46d4n2AqWTlh7gQ1uQZxvBVVnOgnOfU3RY6EyoTUF-g>
    <xme:PAD7auEXJx8-DZfA0rpN4SAPQJZN-_2A87pkF_r905UB7S9t-MPHvc4pkwvOuHdIu
    uF0YGoym8ETWhR3LtGoEjOk_7BoSCWOCmqBmhrBfvh9K7EvbR-B3Q>
X-ME-Received: <xmr:PAD7ahW8pwCkFeIZs7-H24gWURUCcEUj3D-UstuUcmsY8ZhHNqlTkb2_36Z2NAw2-BV_JsY>
X-ME-Proxy-Cause: dmFkZTFZEY3dRZaxYHKztVo3PV5exS7LC5so/OemZvN+WRzyMAuPxUkF0s8DXR9rm3sIft
    TNy3msB44N8fedNp8OEKsFykHBMtYYTrfbK0L+IwZ5LKw3S98nfrCPUmkqNy5t4VRzNB1H
    O1k+n5la66tVUCb3ERJIwzKtcyG8zt2k7Nq63bv8Bsb1mnjRJ95cbEfwctWmirTzT7W0Vv
    +wbH8aDjSJMImH6U0aTopBPlpGclwtUfOlL0sb99rKBTgdFJT1iNWAATNvrbto6s5wHgrA
    pyryLSwJgJXsiTvNzA0Sp3b/jhixtqv/ivz+VDrfFpK2d437jTBw6zWR21v5KA2lf8++PK
    nGRuay4Wcxdy5sV+hcZ21MttBJv4/MJnA29X/mMtAoxx6UNA8DpYux8JvM1VNitq6nVXRO
    2MlJVHSjogOy2GRyss3JG0owAomWqtCMmV9H4JJLXax+hKxf4m3SfV7VayrcA1Ar5gYpuW
    xD4zy50l4gPMOCKKbPkyiM6Q/FaLWp901xn7HwpTU9hSwIPJN1b/sfbOcz5uZaQGX+skGP
    nInvm/mqfGTljVQV9GaO+vbTQXhXZzxr4gWMF7OtJZwl3NJsuZZYqwMk5RcYy7iwv6rAGb
    D8haJUEyAiu8zN59vUJA271YMMfVn7Ga1GkUEtWlwo8lXcO/oyrUDGT1d3bA
X-ME-Proxy: <xmx:PAD7ahh0N_y5wX2dl-h3n_qPdQvAzSe9XgcyxuNP9debRTc3g9jNow>
    <xmx:PAD7aqTzLq2BlCKdfxJz2vAem419DR4VpakaiGo5TQiEQmMZ5BoaRw>
    <xmx:PAD7asEBvoDAZ0qbRww1CaX7CpQiIdlkFt1wIEefhYvNYcD1u3-4BQ>
    <xmx:PAD7aqkuZZHcSmYXvs1gEuy155k8lFHc3OFJwwMXuewnEFM6rspzbw>
    <xmx:PAD7aor50HWZcNxNPiBTFdN9JGvRgUjnAQc-umK6IXB5dswUpgOZdSEb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Nov 2026 08:08:12 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aa8f7fb5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Nov 2026 13:08:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Nov 2026 14:07:43 +0100
Subject: [PATCH 07/12] commit-graph: split out check whether writing commit
 graphs is allowed
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
Message-Id: <20261116-pks-odb-pluggable-commit-graphs-v1-7-a83fc1ff0808@pks.im>
References: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
In-Reply-To: <20261116-pks-odb-pluggable-commit-graphs-v1-0-a83fc1ff0808@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

In a subsequent commit we're about to split out the logic to write a
commit graph into the object database backends, which will need to
determine whether writing a graph is enabled in the first place. There
can be various reasons though why we cannot write a new graph, and we
certainly don't want to repeat this logic across all potential writers.

Extract the logic into a new function to prepare for this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 37 ++++++++++++++++++++++++-------------
 commit-graph.h |  3 +++
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index caf40fd6b01..c673c0424da 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2539,6 +2539,29 @@ static void expire_commit_graphs(const char *dirpath,
 	strbuf_release(&path);
 }
 
+bool commit_graph_write_allowed(struct repository *r)
+{
+	prepare_repo_settings(r);
+
+	if (!r->settings.core_commit_graph) {
+		warning(_("attempting to write a commit-graph, but 'core.commitGraph' is disabled"));
+		return false;
+	}
+
+	if (!commit_graph_compatible(r))
+		return false;
+
+	if (r->settings.commit_graph_changed_paths_version < -1 ||
+	    r->settings.commit_graph_changed_paths_version > 2) {
+		warning(_("attempting to write a commit-graph, but "
+			  "'commitGraph.changedPathsVersion' (%d) is not supported"),
+			r->settings.commit_graph_changed_paths_version);
+		return false;
+	}
+
+	return true;
+}
+
 int commit_graph_write(struct repository *r,
 		       const char *dir,
 		       const struct commit_graph_write_options *opts)
@@ -2562,20 +2585,8 @@ int commit_graph_write(struct repository *r,
 	if (!!opts->pack_indexes + !!opts->commits + !!(opts->flags & COMMIT_GRAPH_WRITE_REACHABLE) > 1)
 		BUG("attempting to write commit-graph with mutually incompatible options");
 
-	prepare_repo_settings(r);
-	if (!r->settings.core_commit_graph) {
-		warning(_("attempting to write a commit-graph, but 'core.commitGraph' is disabled"));
+	if (!commit_graph_write_allowed(r))
 		return 0;
-	}
-	if (!commit_graph_compatible(r))
-		return 0;
-	if (r->settings.commit_graph_changed_paths_version < -1
-	    || r->settings.commit_graph_changed_paths_version > 2) {
-		warning(_("attempting to write a commit-graph, but "
-			  "'commitGraph.changedPathsVersion' (%d) is not supported"),
-			r->settings.commit_graph_changed_paths_version);
-		return 0;
-	}
 
 	ctx.dir = absolute_pathdup(dir);
 
diff --git a/commit-graph.h b/commit-graph.h
index dc4f6194c72..e2fc0c8da4c 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -198,6 +198,9 @@ struct commit_graph_write_options {
 	.max_new_filters = -1, \
 }
 
+/* Check whether the repository's configuration allows writing commit graphs. */
+bool commit_graph_write_allowed(struct repository *r);
+
 /*
  * The commit_graph_write* methods return zero on success
  * and a negative value on failure. Note that if the repository

-- 
2.56.1.763.g16177fe143.dirty

