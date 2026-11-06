Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961025;
	b=JkriTNYMMtHtOr0tAANH0s5A6pkZggTBnhH5bKB/9NKfQPARhlrx1pnWXvcAGgjCQNTN
	 vGsERwxhe2ler5eG6Yzt/w6C8qtXqFE5qllZ/OsJMAKTaS75jS3Tnb0UpFESnrsdxMx5u
	 C130dZyvzH0WtNDpTy5Ypx1rIy0Y+nmK6mbDLixG5qT/8zG6Mg/0oG9hNGpvD+M2ZfVxH
	 r/hlHFfBrgpqwJA4xJ2NA1rgNDuFHz36sBuDEyBx1cqUZmks0Xfx/4HG7dQWv/yaR1/SG
	 T8ErBqh0wHCoD5u9Wf1mpxhvX1kBN7mIFgYrgdQt8L+wspacq5VJCD3IbRfZFzNkZIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961025;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=qJVxtg9WI7tzVs149wNlOzOn7KIOn7fXY33h7TI3cg8=;
	b=qdbLkGISec/EbarBmr5J/fVzuHmacdAacggsN0+3q1X6sj7fI5a4ozpOxA6QvZa7VUuM
	 MT/bvYCmt+NrI4NzLvtHYJIXuvX7quC8SHAP8iRjCwIKZ+/bRdr9LQ9LYmCzhBLdGoSpw
	 SfEfB35B0h4QP1GYxc8jTWJDeM3vn8x9ivnq7xNfnu0hHKCM4MwXgvPoGqVffxsDec49A
	 X3qWBYvVPv3EK6egcC0WToT7kTHdVbZsguKvJf3oX8NootFmGIA20my8DiQTnRn1Epxyy
	 nlUwb5BHHPRxHlhUaAh61ye8WbkB66KK2Be36J4wOTo6VvD6i+7NXmlwwHPQTC2cYSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=GJuNildN;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pYf6MkAV;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D553606D807
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 10:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D553606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=GJuNildN;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pYf6MkAV
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 857F9EC01F1
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 05:30:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 06 Nov 2026 05:30:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793961024;
	 x=1794047424; bh=qJVxtg9WI7tzVs149wNlOzOn7KIOn7fXY33h7TI3cg8=; b=
	GJuNildNE/K500MiNBJChzB7JQMbwrGJ+ITB3mAt1k/ulFMEF815YjWZYvmqWUgc
	jpAzEKnD/khY1udAk/k5Oh4LndQzjamx5H5lQyk8e2YsexfEzzv0ILubVnClQPgE
	IraMGj6P9o/neWJnf9tOK8vEuQvSjOa0jex0lG0wUKlHtuYrzxSxduU0fZZXcOW0
	77HPG2z6+hqky6EYIRZkODBh++UcP4hqQhZMOR+3+scygvLRbp+x1pRvXWxRfvw3
	o3r/y46DNYJtcwHQMSC8WHRpA3EXOLPQI/O9mIdoy0E9b6UYw1iTzCONgJHpwxjv
	r0E0dl4kBybL87THViNYbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793961024; x=
	1794047424; bh=qJVxtg9WI7tzVs149wNlOzOn7KIOn7fXY33h7TI3cg8=; b=p
	Yf6MkAVKZzkQQA2WHW9mgMlUkgbAj5ReyItYyTbosC9zwIPJwPbeinB40319kt7R
	rGmMd6QAYKRTmBc3aDVjN0aJShZs9xPUqfpVfV8XwdPo3werQ1dLDHrYC0+wfCqQ
	q6IeLmgb0DEI4NBgcdArq86MiwFYyjACQS3S5hNehop3F2Pfn1FbU5SIQgKw22YA
	zzFlCUmHkwZbg9ZC9GmUKTh1EnXYwL4i4Jl4MiSCys9ZsZnCIqg9lW/4/n4YIbx8
	/4NWwmlqou5l886N/wQeidzTNLYq8ybWPjCrR41DlolKUruy29m8q8KaQVEq6IIR
	pXEkO9xSLy9PLn5iWZO2g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793961024; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:tU/2hrt0ftldt3Tf03pnWKRSjK7dwufAvO1HD1T6ekgidhO
	N5NR88U808Yx0klzhJTgsDgv+DWKKw8ZzDsEzb/NUSC2qeDovA6yyB8GtLT1OJpb
	+hLzV9vcKRuxLx6ErWESwZaqj/BWPld3OnGLZZoEuesY8qgoZAtm3+vkNb1FGCN4
	F7S5VdZzWJRryhG7RlpXDbw5g2xUfYgSDQmwCcWMVmz0l6eroBqK8PEl4QR6y2wm
	g/qyJukVL2w7juh9bwIHc5+IsIO1mCg++LPEmpXym9Z2OnrvkZBnNbECM2O2kgFD
	ZQANHNMRWfXf4t5dXIkW6YOjUgLaiGfT0TiaaIw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:y0tnOxpHZN5NnZWEbmXOL1aWACA/TAcR6SaRBEoaCAc=:lENN1i5doFkQ7wzsEVy6rJx6PnCQjPM+3c3mzQHcso0=;
X-ME-Sender: <xms:QKztaj6JJ8K9oRXxUPJ3WKbgsy7q2zltPVDlS5tdbjvQSJGFnuahNQ>
    <xme:QKztau7C3lGtCmCml7wewZzlP46C9XqY8L8-ieijAH34lLmXsaMrnF16jsXwkh0l5
    SUa9Z5JdmfgO4zTQ2uE0dgMXVs2cIpbeQZEuJ4L6HW4xGIPJXtfvaM>
X-ME-Received: <xmr:QKztaoHJq0rRnwnoJPGe-1extPpzgwah_zcNgOpK7NQ0jbrwnot1xVdy5W_GLNnpXwVsaw>
X-ME-Proxy-Cause: dmFkZTGAohKhTI20WoVqgI/VaFyawJHaD/3N4tsoMJr6M/rD0dE26f+p0+0Otw5132GQRn
    lHfMN6Vk1yMWEiArpti53C8RZ7GKYPVwdm8W1T9rrtKrcxk/cY9aDnr8SlaSK1nlAlS74O
    AEVHFUL0bARxAKdgeX8rA54iaDrp4WNqn5FPKIy9bLmizMl8shAoTP5GNMYz6d4igjjO5A
    ujhmdUa3H7AQnblMG9eMNm71pQJgeeSCHwxJP0XB3IbwzZADIWyOVR8dUVA/yvBdaCfSRj
    oxT0b03eE/bjFK+VKIYWBSt05yr5Dfg1jcUfEH9V4dPcD9nSQ+/u846RF8FwD6lyOQWjH5
    DpZGLWD7ScOXti4LHAfqmkV6DgefeENjOTn5LWdGauAgRPZORxLXJHnA7fWfnD+ixdFAaL
    y8G+Q2xxP+NEaKqe2ED6y/CKY3c9BPtrjNmgiGE02I1GNijjN7nA0n8t2v4gyIYHlRI/83
    D2kMny7wzRr8TxZjMhfSD14sJfKdJaygeRETKeTiB/cziTVN2aOMEtWfniLs4n72WKUg9w
    lBBWjjhTe7UbwT6sNH17ZvfKuC/vJAatZy4I67EBET1h7xfVt2rC6CeBV9eoe8w62Ou74d
    Pc7ApVMlAgTesIE3ubHyQkKoxO5eoav/scju3so8Qa+ONvhMvavElZwklKsw
X-ME-Proxy: <xmx:QKztavT69OqvmhZQg9q9x6A8UmY7uJJGHKU5CAv_TJDPCS1W6n2WFA>
    <xmx:QKztapuPfP7TWLbxGZsOhJJ-2UcGWo7PDpjHltQ4xLPh9dAGjZPdlg>
    <xmx:QKztamxSiq6dl6SdFQkdFv1P7jtqN6bXcgxcL7s-fnorKPqzyLItzA>
    <xmx:QKztar7SFhb5dnbA3ZI1sb0TMw0cxCLybV_AREfnEv1cGmA2vSqOEA>
    <xmx:QKztamfBkVk0Ld246IxZh-IecW3Y8TbQeyoK2EZrCOWyk0xRT4nDNetj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 05:30:23 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0d159679 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 10:30:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Nov 2026 11:30:06 +0100
Subject: [PATCH 6/7] t1092: set up repositories from templates
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
Message-Id: <20261106-pks-gitlab-ci-speedups-v1-6-1fa0374c7287@pks.im>
References: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
In-Reply-To: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

In t1092 we verify the behaviour of sparse checkouts. We use three
different repositories to do so: one with a full checkout, one with a
sparse checkout and one with a sparse index, and then verify that the
result is the same across all these configurations.

Those repositories get set up via `init_repos ()`, which initializes
them from scratch every single time with a bunch of processes. The
function is called more than a 100 times though, so the overhead adds up
quite a bit. While the tests only require around 30 seconds on Linux,
it takes more than 10 minutes on Windows.

Optimize this by instead creating the repositories once, only. So
instead of recreating them from scratch, we can then just copy the
template repositories into place and thus save a bunch of processes.
This speeds up tests on Windows by about 3 minutes.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1092-sparse-checkout-compatibility.sh | 34 +++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 05b54062b3b..5d81ec54c23 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -141,28 +141,34 @@ test_expect_success 'setup' '
 	)
 '
 
+test_expect_success 'setup template repositories' '
+	cp -r initial-repo full-checkout.template &&
+	cp -r initial-repo sparse-checkout.template &&
+	cp -r initial-repo sparse-index.template &&
+
+	# initialize sparse-checkout definitions
+	git -C sparse-checkout.template sparse-checkout init --cone &&
+	git -C sparse-checkout.template sparse-checkout set deep &&
+	git -C sparse-index.template sparse-checkout init --cone --sparse-index &&
+	test_cmp_config -C sparse-index.template true index.sparse &&
+	git -C sparse-index.template sparse-checkout set deep &&
+
+	# Disable this message to keep stderr the same.
+	git -C sparse-index.template config advice.sparseIndexExpanded false
+'
+
 init_repos () {
 	rm -rf full-checkout sparse-checkout sparse-index &&
 
 	# create repos in initial state
-	cp -r initial-repo full-checkout &&
+	cp -r full-checkout.template full-checkout &&
 	git -C full-checkout reset --hard &&
 
-	cp -r initial-repo sparse-checkout &&
+	cp -r sparse-checkout.template sparse-checkout &&
 	git -C sparse-checkout reset --hard &&
 
-	cp -r initial-repo sparse-index &&
-	git -C sparse-index reset --hard &&
-
-	# initialize sparse-checkout definitions
-	git -C sparse-checkout sparse-checkout init --cone &&
-	git -C sparse-checkout sparse-checkout set deep &&
-	git -C sparse-index sparse-checkout init --cone --sparse-index &&
-	test_cmp_config -C sparse-index true index.sparse &&
-	git -C sparse-index sparse-checkout set deep &&
-
-	# Disable this message to keep stderr the same.
-	git -C sparse-index config advice.sparseIndexExpanded false
+	cp -r sparse-index.template sparse-index &&
+	git -C sparse-index reset --hard
 }
 
 init_repos_as_submodules () {

-- 
2.56.0.500.g5d06dc02cd.dirty

