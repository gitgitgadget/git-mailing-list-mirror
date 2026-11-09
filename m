Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218321;
	b=dKseZtVuFgWTgddwwB0jbwOtKA9sLIC3ov8vX/EFbNRwdN7wmAtOULS07y31IGcR78If
	 T7tQvJTeGehKzd1X+xhQTBtReup3xgs2Lo6R8e99OViJ9APZpeyk3KZkY0LPMIe5mM9E+
	 Q8I95GTTIxPpuhhGGIcAMsGv3c47d9e4smg8Ih7Hyx5ppcKubUvZnH7SgL0RvxODYbArf
	 IQmQrw3RBM20tbGwLxiU1blL552wt7DPTRGucUZwiZf3/1fASp0cmJFDz7/lUrD1cIPuf
	 CArkdyDUF/tJAEmIBCqPnAcEdeQlaNy5Fe1HlfNyMTLWjz72kPM+iPre7ToqJ7Cu0gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218321;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=zwbPteLq67AmqAX55qCHUk/xL67nVGvx8S2LNwdWlCo=;
	b=WfjJXkQp3UWCoMsKsOEpGn9x0ZkVBQtPEMb+XT8Msth59bmR7llDwdpTcosl5KP2o1zi
	 BVI5TurQDq2z7gcA60Og0pRWpfRwodEtEUxcnBw3JtF2kcKzP0AMZKgjqJvXnyGWeMjDL
	 /AKFRMfuEMdDzFEWCyhOSBAeYfTF1rBOpsV02ydXJfYqzezg5C3fZ7nsT2KFYMTkhFGd+
	 +qSQSpPOtmX8U5TJKsJXy6NsKMrVIxIVVYeO465t1uDl2Ff0S5gy6qrCf07jpVzSPtZOx
	 CHkVr4SVLx96G1cziWLynV3s5Kdjl1pfEV/iHTg2hKiCNm6xIfNb4O50LZv84BLQ+Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=D85utkRB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="N/kKCywY";
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A294606A331
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 09:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A294606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=D85utkRB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=N/kKCywY
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7B9B07A0148
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 04:58:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 09 Nov 2026 04:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794218320;
	 x=1794304720; bh=zwbPteLq67AmqAX55qCHUk/xL67nVGvx8S2LNwdWlCo=; b=
	D85utkRBmYAvjRtC5/Z4JF9gnE74rJs6ytLjH9xRSQPu26kePvHPAE7ohxAN65gM
	W+qm3mzYgnICRsSg1KvizaevodS5eVjYxhzBMxzYGrsbWAwwSqTELz7WTgBRLqfU
	Bm7idAiK3jcWRNmFlMcyUeJUVMA+eixzbgPdT0iVmswmnK5r+eZiLxangJJayVo0
	Cy0oa3tZSdJrqE6E8j9jzi0mJPXUli59QulE1m15ldcaVezvtnuUNwk1APAa2gY9
	BkNa4IDArVHKGoju5HI0uGcGe+Gls4O4hEIj6Zp52HlbQb9KdH9X+fjW/hKhQ17d
	kFY4S/D7FQtATXaCewkdsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794218320; x=
	1794304720; bh=zwbPteLq67AmqAX55qCHUk/xL67nVGvx8S2LNwdWlCo=; b=N
	/kKCywYF4Pdr1DcYTwy/FulFY5KI7wAR+LnxVx3z0gCbemYvkSim/u1icYww3YfD
	kyr3pac31Ersxxe9rCzZPg0mlMiWqJDpfjsqPirAAUnNwnpiQJX+x33To8rQFeMu
	/Ik9znLZXD0sGVNo9vUqD0DlLpobpFo7LsRXOrIIdw9Bk310DhNXBJwQSNm2/ipC
	0liaE+/36WTD0ZS4R2854hikpHFhwQBaaosPIzcYFcvxR0gncTXouOKhDhDyEW/s
	GHAnUE+YXos9gTWHtZVuNQL5R3cSwdX7P8sWxiiKUw3j0WnF17kxPSf7hkNtEC53
	EuBOi3LGhFx7KuPKZOtpg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794218320; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:JGQzyTcaJLmtSRWqjOReD0fPCrWIHoXQXzV+QWK2KIldvMd
	5BHe8BGnpcs3l6uytUIfHw78k3++zyDt57vopH1GJ0AKZcHf6Mn35XvT4n9+zIyb
	q08oFmWen+BSvptwwsMMTlYDelCzriCotZLJ8VeHyBYZYfjrka5ZXfl/8ScyzmKL
	VuE6R/5R39Hl6zWduIG63ZSyAgR6YZ5jeqkHRbCJqWhQtG0p7mfwh7XW3lYiULJ8
	lZ+Q3wLhEwHiFbCnHGPbc1c+hyDrTONShblLOzS1rAA+nYGjH8u/2iQ8B7QOTGRX
	h1/7HtkZc0JxdmUA4j2P6DwST5SZQWjenUhVbPA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:0Xnhn+JAu5Q1LJmlV02B6jyKc7Qvqck+QG8s3RDauzo=:GPvCORn62Gv7bTKs50mRbLlJLBiIdwMLrRgAAxabCFg=;
X-ME-Sender: <xms:T5nxarNKDWXWTiLp3hdKrYMLdDbJ9jS_TWzw1JW1k-BUU5gZ4X3ftA>
    <xme:T5nxas9g-HFhqm5KhD9r4nEvvWs925sjd2fn_4NNA1bvbQxLJUWSNFEsPzfTgPJCr
    aat5wo2mBkKB3Hdmlf1RFEpVA1JsCKI7sW7AProytAD3EmQXBK4LQ>
X-ME-Received: <xmr:T5nxavQ_edws84068zAVhagGedEMw877PtppZ1n4FjrxwacwFsjKK_XUfMilHLjQZXA_QXc>
X-ME-Proxy-Cause: dmFkZTEHS3V19QIdRLRKSWjO2nNvv8zRI+iWevfOMTjXDzG7jD6FpMiqnSVyTgTUDGDL7O
    7GqzVl0ZhTwtjWpG6oJc8FvDaHIDd1niRGr311uWoTFlR6tziG9jAHB5vangbRDQ9l9o5y
    0Xud8gnegknT6zQwVrljBfr0sIbpj0JDcc6Wf6En2Rd2j73iNAkiYtuAm9dpWf2qEFlHah
    aBYwBD4VBReG6tDDEw+5nWVTKSNZP8qeGp6myRaKlRkoPbDLFnSQovmSidNlNW3devkiUp
    D6Qrq8RmMSC+IRk2dd1feHvKCKkjr08Z09fIvarRWtaPudURT5qrFbGTFaUMRw7ehQN1h5
    g7MV5y95Y9/qxGBl+K9UFZuUOUPQOIyud1DBPjvs9HomXmTp3Oz8kZQc8e9Pop7rdLP8tR
    zILeHOzW6fM2wy5o6QeGSfaWvRVCQ0VAHMCGsD0ajo6eMW6lCZC5oC1kNVSj+ObLOJ2Qjx
    TyZFPNhsNlzTEsS6W1kTO+tFYV+sLlFWTZaIYgTvS4JM7Y83D4Ymug2W1DBpLW2tRAAJxn
    gW2tlmbKvrDjVHhFd6ukS8htnLWwHb2NNllVlrecz0zjWv0hlRNvfWQgB9RsTiXZXRFd66
    9t0k0oOo7E6+PUdlPLizZbgOUD/lzqVJwLU1Qrpdlv+GqRENUoEasW3a5GKA
X-ME-Proxy: <xmx:T5nxaumAJTXvSbNPuYKnLOP_ptQlkx21AGeVZDBaKjFUfHzMUncZ3w>
    <xmx:UJnxavRu1uQ3DnWcX729Z-vsK5IsJoS1y41zTYyOuQyO8zA6O_pcYw>
    <xmx:UJnxasPDgkYuleYiy5tRJj9dwGIB3jrOCUSEnCC5KjWRiURCBD_umg>
    <xmx:UJnxaoWfPZsxfWwq3e0N92e-dreq-9qWPA9xtZyHEOvBez_7gWHpYA>
    <xmx:UJnxahmcHMqLfxSK5gJmS2i0LbwFItuGDVeT1u1CS9RihQQcYfdqJ6yQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 04:58:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c690f8d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Nov 2026 09:58:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 09 Nov 2026 10:58:24 +0100
Subject: [PATCH v2 3/7] ci: build optimized binaries with Meson
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
Message-Id: <20261109-pks-gitlab-ci-speedups-v2-3-508832602d0b@pks.im>
References: <20261109-pks-gitlab-ci-speedups-v2-0-508832602d0b@pks.im>
In-Reply-To: <20261109-pks-gitlab-ci-speedups-v2-0-508832602d0b@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: b4 0.15.2

When taking a look at our CI jobs one will quickly notice that across
the Linux-based jobs, the "fedora-breaking-changes-meson" job is running
significantly longer than any of the other jobs. While most Linux jobs
only run around 15 minutes, that particular job runs roughly twice as
long.

The root cause of this is a combination of two different things:

  - The job uses Meson to compile Git, and Meson by default uses the
    "debug" build type that translates into "-O0". Our Makefile in
    contrast to that uses "-g -O2" by default.

  - The job enables breaking changes and thus runs with SHA256 by
    default with the "block" backend, which benefits heavily from
    compiler optimizations. For example, hashing a 500MB blob with
    SHA256 takes 9.6 seconds with "-O0", whereas it takes only 1.5
    seconds with "-O2". The SHA1 code path only slows down from 0.9
    seconds to 2.1 seconds with "-O0".

Of course, compiling without optimizations also has an impact on all the
other jobs, but the Fedora job is by far the most impacted one.

Speed up executing the tests by using the "debugoptimized" build type
instead. This reduces the runtime of "fedora-breaking-changes-meson"
from 2100 to 1000 seconds. Other Linux- and macOS-based jobs benefit as
well, but they only speed up by around ~10%.

On Windows though this is a bit more muddy, as the build step gets
almost two minutes slower, whereas tests only run ~10% faster. Combined
though the total run time is roughly the same before and after this
change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml            | 2 +-
 ci/run-build-and-tests.sh | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3631393a8cc..449fed1b392 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -182,7 +182,7 @@ build:msvc-meson:
   extends: .msvc-meson
   stage: build
   script:
-    - meson setup build --vsenv -Dperl=disabled -Dbackend_max_links=1 -Dcredential_helpers=wincred -Dtest_output_directory="$TEST_OUTPUT_DIRECTORY"
+    - meson setup build --vsenv --buildtype=debugoptimized -Dperl=disabled -Dbackend_max_links=1 -Dcredential_helpers=wincred -Dtest_output_directory="$TEST_OUTPUT_DIRECTORY"
     - meson compile -C build
   artifacts:
     paths:
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 68b91e31439..fd8136af342 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -55,6 +55,7 @@ case "$jobname" in
 		--fatal-meson-warnings \
 		--warnlevel 2 --werror \
 		--wrap-mode nofallback \
+		--buildtype=debugoptimized \
 		-Dfuzzers=true \
 		-Dtest_output_directory="${TEST_OUTPUT_DIRECTORY:-$(pwd)/t}" \
 		$MESONFLAGS

-- 
2.56.0.611.g1030f0b940.dirty

