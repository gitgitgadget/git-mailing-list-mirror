Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218326;
	b=cF/yK1zbXTiPJMsv4Jn5S+8mANiNjablGzmWhGmQ97EzZk5UXA2UrL/kiteJEoBsfGCo
	 f4ClR/zRgLRyhv85SwWxKW/hXVQ9qYjW0SWqdOjqH28llasPETXC+HC3WFbjX5ZCwwYk/
	 4crkFYShuKE6/NfuJ3FXJ6aRnEiH0/g7XCijAg1SebMVpOeO6Xt+IzEJUFvfynu0ULu/X
	 DoHhz95GYJ8FT+fi7mMzALozAaDQTBy2vXh4ycDc/nt6ogCNS7sDb1gFDPTPO5qvPsP2B
	 orQMiBp8tvurxzTibaDTcgSpIhxc77l7nPdLf52LMZdoTVsLLaxAGgh67DreNktVOFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218326;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=1a1VYnsSf1ktsw9iKU4FF3IMzJXCvsWgK06Fun/SLpU=;
	b=nhJehjDEL1/VVM1I9X2OyzuTw5NhPOFym+RjHccd2AK6oL9Xk9v51ogQkoaWv0hGPNHz
	 b2RYEhvhwG6YYLdLG0M0sJWDKV2+cpHcg06uGjWQxSi24DFqI0ldXusijQgR/fMtRkp5S
	 68RQDNk7Wm1sZ5moyxeqIkWWsbDkZFBCvh9xS9fZzy3roF/nESMzcdGQg21vy0DOPP2VN
	 8WWyfsSFORBnPSGYnXvXluLOVexXmFgu02WaS1khhq86LUukfE+IJkisV3Swpcx54Fv+H
	 64TTaRoKwXOEcuIYRuVbNf+B4hwtnB7eg19IXfKUsi8wsAnHAUA6hkfkjK65ZSEgMDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=NQ3HEVMc;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="ROn/tIjE";
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEA1606EE97
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 09:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EEA1606EE97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=NQ3HEVMc;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ROn/tIjE
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CD4247A0129
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 04:58:45 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 09 Nov 2026 04:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794218325;
	 x=1794304725; bh=1a1VYnsSf1ktsw9iKU4FF3IMzJXCvsWgK06Fun/SLpU=; b=
	NQ3HEVMcZLfpEdRYmBoPVO7a8WHO6BLef+47e9lFMKou9YQl9i9fImV+fSgejqbT
	haXyvfT219yOeS4ECLI02zjWgpjkWf53QDYTbsfoaRFDVOp9Kja0kX7s7h9WpAid
	n75sB6XnCQG6xkjw62EdNbI2so06ikQd61dp6LJd1U8puYNcrvXE1tqvUWiPLlIw
	+PXz4fsxE5yazbF1dxvpeKSwxynhe5eUi5vby1CSN3xo/kNt2GDvl2RkC+7jnXX4
	ZyEYVwikFpx26GasWcdd053Q1A5JopWW3CW+51ewq9awOQBRKy2x7SBdHktQzLqx
	/SSmrWGGwTux+hfOFh2R5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794218325; x=
	1794304725; bh=1a1VYnsSf1ktsw9iKU4FF3IMzJXCvsWgK06Fun/SLpU=; b=R
	On/tIjEQGQPN9xwCv3A24CTWltN/KAFQ3uiuN2NOP4vRi3NnSmSoYdbp0R8DgIbx
	dgrNCE8uEMZAFEz8BtzUngs9ATjIasPvsM0qXJ9KDIf8LWzDIAGBNen7KhMTWOFL
	iXiFJFr38a6PL7UrmTUUu0RL8FsmsWAHAwgE+I7VgSCEPsO8ih8oqJnZiE/reAz9
	u0FzEKcjDEs312ushZ++GC+zvEjRBoSfuMit8uX8N8s5061tCIriXM+UEklklh5w
	91d915L6sN3rwWZUpRlQRpdzjIMk8VNbs/mA+DGrkwPlE7lhINWCHg3BH87nalzf
	Zem4wF+1LV+H1iooDdaHg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794218325; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:R39cI7x6GznRWydm8f253pbkOFBr7nPKuGpvJ2rIYNQ0yIw
	ym4pih6Y7oVfa/8UROXoRFkwWNYsdd2/gITcohnD85ALgzxmDpQwRS2yRgQ9KkmW
	QA+cyxR5uihAwR19gCssfQWJSXAR6TYAR4YxqnqWRpscVduX2q5ex2c+UuCVR52C
	f6K29/xstlJ4WzhQ9wHg+XQsGswEXADhapmKS+aa7Hzg+73Geyq9pN8ox4em0Wdl
	e59auCdc+qAMhyC13v2FtrjuE2EgJ9G4Q+jc+UwDBYXcGFziJNF8Qr1H0XQP6LKV
	/I+aqB9FcpEGXQ6ggMczNaKTAbHmZmgn2oL/7ng==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:YJknYBb8rd8dEFCtbbUy43obdPfbDrDtr9GHe8RbTzU=:+oFEEj7g/z5VKpvaKOcPntfQ6QBTLrD06OJ44m8YSu0=;
X-ME-Sender: <xms:VZnxaqZv-8_Q1wP4B6joQRiE6aC6DL9Yzx_SYH-9DV3gb0NuLgREJg>
    <xme:VZnxakZulLi1CdBLKGSUbwvcGnEODZxWs4OOmO8eP67_uWytxuBjC4FP-w4QA-mah
    mnPPHWjUSNHmC_0MxQK9seY43xnVnSEEMRewCm5ZhxSm-vl5mMoIQ>
X-ME-Received: <xmr:VZnxap_lt7yJQGYDOiVEnAzQTYjrrNahPnCwubJcwjNUqfq_kOTl52Pv8VIK-peUa__lGBw>
X-ME-Proxy-Cause: dmFkZTGiwaOML8tABvxNB+Xhsl5FZZPhHnkonYmkYRbH50zEaDBdkJESa46J1533mVBeI7
    U9HWby0AedgrBCLYvGD9+ClPSaNjIaoF64ev/Jy+XhCP/wQH060xSDKCU58M8vRVPoAdBf
    BRjSx6opOraX6unaJkN513DzJhxKaDSnFmI9CikUx2lYOYcH34Z9ynF3I/Npig8yrRVibP
    b0vML8ssCNSH1XmcoVnM2tDVwrSBgdkHJQihRSlyIAgUwUh5Ikk4+wD6gmDkTy3ifV37Iy
    q9nDyG+O0IeU5Xub+k3NttaXYxUzUQiN0O3SHSABPLC0Bf0YPQM8cxPUAedTAhYnm+/jjt
    +NYrZ3kSURPL5tI01I/S5vuic6diKqHGuah+15N9BEqhO5woykMKrGZO//4ofwSLRrIT93
    S0Dww9eVZve5Mx/IQ+wO3xAeywWZW9zFFchyau+zdSDpYL6aQ4MNWjkQPFhFNaFfQO1QPz
    7FWpHpoWPd0GbVQwwjlx1CNz3JqbLs/iPoJiL3k83TurL8kt5fYxuf9Uame/FCQRSajAWR
    8IvSMdEzIEsabPai9D/LKRA8xt9/hdOHxxlRlvRjjxHnZA6NLp5sNva8/7iL1K1p7uUUKG
    ponOsWyJD2uWh//bbHnTkjhG415xyiE/SgO5zSLmIx1LdM3BErTITDIFFKSg
X-ME-Proxy: <xmx:VZnxarisTfxE9GLIRnW5cqTdPARhz5YVHUMJJLAcWHAoa1_DJujvMg>
    <xmx:VZnxahcQIa077-cOv9qZogT9VPAiiQzQDaBAQLIBEkOHmvSIEoB93g>
    <xmx:VZnxaqrRUoFwuTiN7K6dYs9tsHOsViOMQB3Q7EsDJx917PaKY-gyZQ>
    <xmx:VZnxauAURbWDKzVoZqDFQUAZ80H-Mgm1tFaWlCNZroURhZSyC8dmJg>
    <xmx:VZnxahQAxLUuN7ggiRq7XFdrdvV88myy4fGRCVDC0vsmzcnOYig5SnCv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 04:58:44 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 675b38c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Nov 2026 09:58:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 09 Nov 2026 10:58:26 +0100
Subject: [PATCH v2 5/7] t0027: cache expected output files
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
Message-Id: <20261109-pks-gitlab-ci-speedups-v2-5-508832602d0b@pks.im>
References: <20261109-pks-gitlab-ci-speedups-v2-0-508832602d0b@pks.im>
In-Reply-To: <20261109-pks-gitlab-ci-speedups-v2-0-508832602d0b@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: b4 0.15.2

In the preceding commit we have optimized one aspect of t0027 already.
Another inefficiency is `compare_files ()` and `compare_ws_file ()`,
which are both called more than a 1000 times.

These functions will repeatedly generate the same expected outcome even
though there's only a small handful of input files that the expected
outcome is computed from. Recomputing those every time is of course
quite pointless.

Improve this by computing the expected outcome once, only, to reduce the
number of spawned processes. This reduces the runtime by around 20-25%,
and on Windows the runtime decreases from 480 to 380 seconds.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0027-auto-crlf.sh | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 504a7ea54bb..b021f0855a8 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -5,22 +5,23 @@ test_description='CRLF conversion all combinations'
 . ./test-lib.sh
 
 compare_files () {
-	tr '\015\000' QN <"$1" >"$1".expect &&
+	{ test -f "$1".expect || tr '\015\000' QN <"$1" >"$1".expect; } &&
 	tr '\015\000' QN <"$2" | tr -d 'Z' >"$2".actual &&
-	test_cmp "$1".expect "$2".actual &&
-	rm "$1".expect "$2".actual
+	test_cmp "$1".expect "$2".actual
 }
 
 compare_ws_file () {
 	pfx=$1
-	exp=$2.expect
+	exp=$2.ws-expect
 	act=$pfx.actual.$3
-	tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" |
-		sed -e "s/0000*/$ZERO_OID/" >"$exp" &&
+	{
+		test -f "$exp" ||
+		tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" |
+			sed -e "s/0000*/$ZERO_OID/" >"$exp" ;
+	} &&
 	tr '\015\000abcdef0123456789' QN00000000000000000 <"$3" |
 		sed -e "s/0000*/$ZERO_OID/" >"$act" &&
-	test_cmp "$exp" "$act" &&
-	rm "$exp" "$act"
+	test_cmp "$exp" "$act"
 }
 
 create_gitattributes () {

-- 
2.56.0.611.g1030f0b940.dirty

