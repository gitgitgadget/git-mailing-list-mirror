Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793171520;
	b=3fKZMG9v0vRtJdVT4FP9UO3im/qpLR1MnoSNW/XMv0SQdBxDq8AaEfE7+fd7AIlDytKN
	 jmKyJoa4htmUemXvdlOXhhMXGDSI+rGciyfwVmt+RsVd/3RErjlIMXUvBlwZcIHUk1EbV
	 zuXARr3fdfp2FgJh6L3RhUCxwDpBca0EkxD86PDonsn715Llw99kpqhyEqt7VTZwWUmak
	 psBIxzSQN3g8Zfyn2q4IpelcoaLqXVEIeCHHykbeQaKFJCw7JD6HY6KS4kX5+xe1HTip4
	 LenCuv2BVWW0MsXNL/50nC9CAYG5wDk8YFAqmxTgmoO4XGutPjKZE1a+RmvhHgbEncw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171520;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=mOsMvDbVHdFOLoMe7uwXPaHTgtabHUQKSn2hBtdDlh8=;
	b=VgbPqmn0ppsQ0B+SfyWDg0eDkc3kSYlTSS3asPKr/qNGTXNkne21kdAToRpi1bVcIrbm
	 52pUaRae3bXoaUC9ThyEE5BXIYzB5CkUAbCef/hSk5tLaLjzuI1P/hSyHkv8P6npFnSFf
	 O96lZmw70og8RnJrbNfLmS+Ru0MuyY8fg2mSJEgYGhhO0hHB9/9gSouE1jljIcbe7bRmB
	 6IYKUV3fitTt9C0mT5KRlOdXfJw0b9908jhlXjgEVZ04VMTJGekm48hPpy53OzCLNRfD+
	 UAnwL2WhsH2TyOUzYqKc2mIjyuvLHxxQQYPVzJYKAFAnk/y2z+Doe7dmqq9FvMrH6qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=vl4DYOl1;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yPz92bMP;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED1B606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 07:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ED1B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=vl4DYOl1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yPz92bMP
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E100F7A0176
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 03:11:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 28 Oct 2026 03:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793171518;
	 x=1793257918; bh=mOsMvDbVHdFOLoMe7uwXPaHTgtabHUQKSn2hBtdDlh8=; b=
	vl4DYOl1QJd7mpM11EHi74XnzKUNu5hlrAk+ImL8d4iHAi8+0PMpS1vrUhGMhwqw
	XCMxwpuu5RFZd6DQe1pS6pNhrGiep6Y+AeuTC0ko4cQsXqELB9IgLC19VI8XudTr
	L5nWo7KS3Mbnm0ByAzs92Csaiu4K5EfxzKAGus44yAotptwx1NsP8kfvS0Hglz86
	SuDJMwUzLcEcV1i+8HD+p+jgOAS9EqGEkYWTxi9eBVGZ8GuyD9RDMuuZp20vWJn4
	WU2lSWZGZMdKcY0f+qcV/IKQSaTrMzcGbJFlPkPtTqoZZ/aSYmrJl/pl8fvy1vq/
	pbfOi77I8W4tqYMIYLADcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793171518; x=
	1793257918; bh=mOsMvDbVHdFOLoMe7uwXPaHTgtabHUQKSn2hBtdDlh8=; b=y
	Pz92bMP0elVGpHfEVoQBK8t4U+Ga2hzbM+MFggR3MzrM8JCAzEKFIGKnFw3jbUfi
	qdG/J1tFvmmOCuBFw7UfnD2YgVgQkkYGqSYgzmDRvJGVkgzHXL/O5i3ZxXvZKIzi
	wM5eWkcSkOVQ5bju27jLs0oskGt8pGHQmyyYEq8ObocRR9h1W6jh/GDYaNp1q+Wo
	ATYMWsZrORr3xNJ5JB4G7SZ04imtvAV6LiOJr4QXkp4LEfbkH2YmmqN9xqoaMO59
	hz7fGuLqOaEmE9T24oj1XbY30MbAcUhoZEnRTLSYEW6K8tBao9NajG+xRTCYTQZk
	b1uykj1f8FRALrmQrcWVA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793171518; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:aii/UBAdPQoj23RH/DQ0yKboRUAkUoqHT3XVP50D7S2ROtc
	Dav1ePlPkNvq2CbQYffrZRLBbZ8Lkuo1jV8yZWmn1l0qjZJ2dVbMK3OLU7Z2toYI
	N9e74RlJfbNJzzoY1q92HMz6eAmUIYRzj1tk7ygGcGoE7QR1+UO7BefDnl5NGm7q
	r3hRyji4JSi4zT3LUEAQ3hZzhVcmxSyKy9UeF2ZHnkFTPuNyrWM1YLwE2OBdwwQu
	EvbDF6OgUEo4lQ6xJhwK1hWk9a0R/K4WFZ34eggSeIWw2ePGCTsrt2XzIbCAgMxi
	uiOerPK8E+iP15c89Sn8OoMDO7drCQz7bJ6WfHg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:/twkMeUi3L+cBcY03fwFeBka4sS8SAEzMLkjGF8xRik=:e1Rt/EWT4C3392do8r3OCXtvpc0CGfI5Studce1gRrQ=;
X-ME-Sender: <xms:PqDhar_GL2BuHluGjBa1vcFbLiD-B8zw6Z7mlbk4sUXIL6HyyXiLCw>
    <xme:PqDhatvYjpOj9IIGkHKFasv_hv4Emnp7UsC2lXWpxh5riPJLeAFxOXQqzMFvnNiUF
    SkfIiZ5XK1LgYkzPb8QfsY6P0_cNVgGsxQ1K_lD14tuHn2JTYyC8PY>
X-ME-Received: <xmr:PqDhamoN1DITVjch70avFuvm3D55L6r0tYwCq27cf-az9XvG1nSh-g>
X-ME-Proxy-Cause: dmFkZTEc37deRu1YjV1twq5x8S9h2vHzSpOqVUeY/oQALEq4MTycwj++wTftSJtpmBg179
    SJnohMVvYziqzg//5jnQToKdvt+XMQRpOm6yEJQlohEgJkkmNJdHX7XJwpxhGgueoh5KMu
    s9r8Js2aIJXnOsxIYKWDUruYSO/k92nvZABL2lKBtb9zjIUDB9aaPM5r4UpAGris3HVsGV
    Qg+H2VLQceKg6IlswIZKBbZHJZF6SwIx6wOXNwiEVtTmHiBBGHmXU30qTItsWyIS3nXmQy
    RPkL5ZHovsqaU4xY9l/R3h+um4aBLRdxuv/2iAYPEd17NECs0PSntrPYQ9YFKrO9aR77EY
    Sc9hk8Ek4kA//Exv0ZJWsrxP8mXESQOfir839OotDtPRgvdct6P1g9t/E+Sxi3qeVywCqw
    mDYqPmNbzolAmwAdB9pBECMMUIHvJmDL889/qGVWPP7mjutjsTKuUcAvMi+rfe610gGHis
    RuuiCm/ND6VPDlS2uF8/fmPsud5sKKFz4Ze+fxKEIOGvYLsKq8Rvyrz7W05uBlBWUOOJyG
    +mfGgsdE80Yg7LKMlY61GBwKwc+D60gaFedVcyCuw4BXWxd97l7KZAowHUCr4WWvtoOqYo
    I7YOI6+++BCs6Um+qvb01d8zo3SdW7ID6NkiLtxpupIsJowx/hYN6ez5VeBg
X-ME-Proxy: <xmx:PqDhaik76ZnkdbF59mt_2AUYhEu79XDFowdRvp14hjwQkLj-00wH0w>
    <xmx:PqDhaiyEBxVbSWtkwgrZ9qN8RqLoo5_X1YtBNRSmqcreJOypYuge2g>
    <xmx:PqDhaim6GlMzuFllSwrdiMir4wfr5LWRXNpZDMBDSN_z5kaZMLeH5Q>
    <xmx:PqDhajfMAm38m56REQs19gcWUCW63XUXlnt3M1avrj36WuSxEow48Q>
    <xmx:PqDhaqvVDLAuNxbdaEdIdb3DYXO5zFf42vT5-A6B_jSu7GJkebt-M_Nd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 03:11:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dc8a1880 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Oct 2026 07:11:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 28 Oct 2026 08:11:43 +0100
Subject: [PATCH v3 5/6] odb/source-files: avoid stat'ing already-known
 alternates
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261028-pks-odb-files-reload-alternates-v3-5-011ddb64b626@pks.im>
References: <20261028-pks-odb-files-reload-alternates-v3-0-011ddb64b626@pks.im>
In-Reply-To: <20261028-pks-odb-files-reload-alternates-v3-0-011ddb64b626@pks.im>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>
X-Mailer: b4 0.15.2

When adding alternates we first check whether the alternate exists
before checking whether we already know about it. This results in a
useless stat(3p) syscall in the case where we already track the
alternate.

Reorder the logic so that we first check whether we know the alternate
already before checking whether its directory exists to avoid the
syscall. Using the same benchmark as in the preceding commit:

  Benchmark 1: ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd~) (50 runs)
                  mean     ±       σ          min     …     max
    Wall Time    289.5 ms  ±     3.4 ms     285.0 ms  …   300.7 ms
    Memory         5.6 MiB ±     0.1 MiB      5.5 MiB …     5.7 MiB

  Benchmark 2: ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd) (50 runs)
                  mean     ±       σ          min     …     max
    Wall Time    185.3 ms  ±     3.5 ms     181.2 ms  …   200.8 ms           -36.0%  (1.6x faster)
    Memory         5.7 MiB ±     0.0 MiB      5.5 MiB …     5.7 MiB           +0.2%

  Benchmark 3: ./git -C /tmp/repo cat-file --batch-check (rev = HEAD~) (50 runs)
                  mean     ±       σ          min     …     max
    Wall Time    269.2 ms  ±     4.5 ms     264.9 ms  …   290.0 ms            -7.0%
    Memory         5.9 MiB ±     0.1 MiB      5.6 MiB …     6.1 MiB           +4.9%

  Benchmark 4: ./git -C /tmp/repo cat-file --batch-check (rev = HEAD) (50 runs)
                  mean     ±       σ          min     …     max
    Wall Time    260.7 ms  ±     3.4 ms     256.8 ms  …   271.1 ms           -10.0%
    Memory         5.9 MiB ±     0.1 MiB      5.8 MiB …     6.1 MiB           +4.7%

Note that this causes a user-visible change in behaviour: when an
alternate was already linked into the "files" backend, its directory
disappears afterwards and we later try to reload alternates, then we now
stop printing the error message that the object directory does not
exist. That feels sufficiently niche to not really matter in practice
though, and other than that the user-observable behaviour remains the
exact same.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 8b63d0eff2b..4a2b9039784 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -185,14 +185,6 @@ static bool odb_files_dir_is_usable(struct odb_source_files *files,
 	struct strbuf buf = STRBUF_INIT;
 	bool usable = false;
 
-	/* Detect cases where alternate disappeared */
-	if (!is_directory(path)) {
-		error(_("object directory %s does not exist; "
-			"check .git/objects/info/alternates"),
-		      path);
-		goto out;
-	}
-
 	/*
 	 * Prevent the common mistake of listing the same thing twice,
 	 * or object directory itself.
@@ -241,6 +233,14 @@ static bool odb_files_dir_is_usable(struct odb_source_files *files,
 	if (strset_contains(&files->dir_paths, buf.buf))
 		goto out;
 
+	/* Detect cases where alternate disappeared */
+	if (!is_directory(path)) {
+		error(_("object directory %s does not exist; "
+			"check .git/objects/info/alternates"),
+		      path);
+		goto out;
+	}
+
 	usable = true;
 
 out:

-- 
2.56.0.341.g393f52fd96.dirty

