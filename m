Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618286;
	b=KcSviQTSd+ahM03TfmKJ0bmDN/MrqKu/StDbHqlwdaOFKRUYC3S3iO/YDPhvxw8AnhqW
	 3v8gKEuDFSPZDAQlL4njk/Q+O9i0mJLpaDDBjLN/gflRV74H84yIEoUyWPdwmC9PP/SyK
	 51lVAJkXJGFJQF46QwIzQW2mDfnCH8vWZvKjvvoA6r7cGF78sLluXBodjL7Llt20NbI+F
	 Vf0+m71EL8XUPw4xc4J471meYkh8t+2Mmf36m8Q1uNebIIUru2BwgrULOx6iVGFUp3h2o
	 9O70bAx6RA9f276U7J+AvntQO4lt/hQbgQAVZttCwO8yf5fcg9ukc8lDo22yNevLkLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618286;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=QLsMX+dZNVuKEGKLvy/X/EeJgP68D/7tDTDaqxb2Vvs=;
	b=Ty8eGpxBeEUN11oqOeWgqqEuJB+DEobSoCxkoqpekDTzWP7nX6wFqNb2/Ga5AR4Tmno5
	 sBESrQKAn9TUZAMkbHdvJ01Yq87gKOcI2+1IAzr9xtrVdnh0Mo0CUVMm49Q3WJDjL5mnV
	 SA7y51qgHVWxBGKoMu7XKDtKtsci3ZemGSsTc1YiM3uLutAtCNMuTLSeM2dH7dS6TGfY5
	 /RrtBlWrRvKPPxWfBkrcfzRq2Xql0ium0M7uteOyswyy5WdhU9V+Om/8FQI8eDhvKT0+/
	 ctAaH/ibATIkkbRZdUx7HujcfAgjEKJIy2Fo9VAdxG/q3tQj8mMKwcAwGzV0SA3MupQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=LAEgX8oj;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=muPPTI3L;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA3860A261A
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EA3860A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=LAEgX8oj;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=muPPTI3L
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 2EAD41D00037
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 06:18:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 02 Nov 2026 06:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793618284;
	 x=1793704684; bh=QLsMX+dZNVuKEGKLvy/X/EeJgP68D/7tDTDaqxb2Vvs=; b=
	LAEgX8ojFySyZyPHRluiZVL3WQNWvDbVMY8NgSvey3cy88qJ7biYhNtM3AUGa7MW
	CyAlmYANyIT5OTcXp9dHjSJ7zkVJjyRX0tatz2lZXPPwRViT8EQAP93SDuc0VQfH
	UPuZc98GVXXYpgUiJLDISSRsltNhQV+JEz+g7ll4Aul/4eSYskRlm/rygbPsi23L
	QYmK9lX+bI23WK9V+S6zykfWRCRNsLNdG6UFRuX5gUFXRH0hWszQz1b3wRnmxBDi
	HqbCHABvbcCfmlr5YeSDjokqVp+3ICpZM2QbBd9RY1oCxDXTnVxidIJGxVhPThNB
	pmcp3K2wqhQm1+Lkq/65rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793618284; x=
	1793704684; bh=QLsMX+dZNVuKEGKLvy/X/EeJgP68D/7tDTDaqxb2Vvs=; b=m
	uPPTI3Lu3obGgy2WnxtuT7jdQOMxArpPqBYEG9LuLYXcMyiq6+hROZKbt5t/QFkW
	vJCRMQOZCtioKqmd3lJGuoNaKA8q8Y7OwKvWUA/2GvrIyvQim+Rp/M3lBDUTkYDJ
	b7TLAYcGMMQnktMJtwVMAON2HPVkVVKxx1Pr2jU/JdnKuLAanInJTXKIkUjLhxfT
	wm32U9tVmjzeEbSDJDg/33GucWIV3ZBaUnlonH6oREIyoJDnF2dZzhRyYzQ4sCSu
	L2jBwg9JKlejrHSgOnQnqNEDQNSYA/nCJpIDYhJiUTKXRLQWR+MsmSl8IsflS1la
	6TiGT6mjmLCKriUwiOxVA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793618284; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ptV/UOlVK8yXrq/+InoD4/lHXq5dcqYpNxtFPh+tLJgEIz2
	K3atBbge80ShsY+WKcSuit2TRrkIfIFQzymRSl9zugIheC15i4qNVir+WSeWgOpE
	zKPIxB9dQb7sJrlaOkGL8ees8R5xdOGPAh+Cb3kmtFT5de4HE+jfUeoESqjbGwzw
	2zvOq5SAQ8YOzQjHaYuhx6ZGYQKytgW4mmzbyPoEOsZnbfSg7ijU276qMHXSbkNj
	0asD3oygScPyP1yytTUu5E0N9iq4KWrtzOkpDGCnmNAo29TYve6B3qN/ZwQ+r/Kb
	odswfjrp2nBVNhkLDG5fMdkqAv6dEn2CMN30ZaQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:koxKBBf9mVf1wSj6rzpmkARMbgHHKGobC6ZVHUoG6/Y=:+dF/k8Fw1rgfsSsFDw5t4wIeqptD+dbwHkR27/2pMC4=;
X-ME-Sender: <xms:bHHoajNaRAqWcZGpst4pitLVPSoOzOa23lDLDJTTWdYDOtmxwXGLaw>
    <xme:bHHoanSpFQ2wLAIzy2iGIf5wWLwRfWlEXDu-QARwbTWHzGdHgMtsH9VB8phokyjOM
    TP1AU8uokkvWsnmh5_64KsiKBJHal2qhBZpa5JV1wq_RYM5wTsG2Hw>
X-ME-Received: <xmr:bHHoapgt3T1xTYVxMSYj060cgu-5YxpbcdQowOS6GEqFC7o8fbgYafdHi_4v7X4SOt_L6g>
X-ME-Proxy-Cause: dmFkZTEXyuhHrrnb1gS/aM7tkRlNQcp8bibU3vAgVGavHNMWT6/jkpRLB5emEJHRPiClN3
    ME/PMR2+hmJSyTlsXe5D2PDaoBSbU1APtpz6KlKGYqDUGSLjLskiL62loOhamsPeQc5AH2
    168HRYHZluXKzaVKnNAUKQoRWJvILJ9fUmBGE1KA+IY4b8Aam9arfoWOZ73Jxak6bP3W3C
    u7CbkpDmNzxmZ3aARVN9/njbookCGclpDLcz/zoeEO+adtBUAQLPA+tk8DozF3LOUA6ZBY
    WpxueVw/5NkwbLZDrVr0wLRo5qgehigUsqQB8gnvuWyhJDBotL/qc+CstJU9OAWU+oxDg0
    OL296yJiBnlqo10DHVHZdvczakloCv5yn73NXyDcE+5vU8emhiYUg7CZG4bVZm+cV63L3B
    ad6RkIjClGZTwbCGrsGsOiSVO5b/nriV7UIIODdX4rcHDM8dn2UOjTmrd2qX6USu2DpLK6
    h0NfUWrLsbwIuBWPjuLR/y+hLMpoBuVW1v+AEF8gmrL9+grM6ZutQhAdhN9z97yN8Web5h
    hQQw5aEvyVRHV9H5SBqsBr1HkqYZ4QDAILcDaU4dYgjXbAoz4oXRrqn8S9bt3KKp1+12Q6
    e66F5Jzm19GwpGWDNZLlG6xbZMDTSIm/MYQHkM9GTXnP/TsKY9u0jXISJsEw
X-ME-Proxy: <xmx:bHHoao8Yc3XdRb0gIVIXPUJ9a6qWhCmV94sJqVKPJoy-25iS0MZUIA>
    <xmx:bHHoaoFl7h1W8SfiU1TIeUs_l8IXYfAMP7rfmmh9f-dO-zrtU7VaFg>
    <xmx:bHHoajkibV09gCYMMdecInUcGOOBCvhHbV08XtDgc9lBGOUFkvoVVg>
    <xmx:bHHoakakBrqCEV3Kl4JCR7gKYMJjvty-WQPD_m_Or3HJiAlE5ts9EA>
    <xmx:bHHoap63h3FHVT2E3cG18937hszN0ygatFLPQNSYi6XVlEa4w99eQ-TU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 06:18:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id df4b9dcf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Nov 2026 11:18:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Nov 2026 12:17:50 +0100
Subject: [PATCH v2 2/7] ci/lib: always set GIT_TEST_USE_SET_E on Linux jobs
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
Message-Id: <20261102-b4-pks-ci-test-vars-consolidation-v2-2-a5485c437c62@pks.im>
References: <20261102-b4-pks-ci-test-vars-consolidation-v2-0-a5485c437c62@pks.im>
In-Reply-To: <20261102-b4-pks-ci-test-vars-consolidation-v2-0-a5485c437c62@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

The GIT_TEST_USE_SET_E test variable determines whether we run our test
suite with `set -e` enabled or not. This works on all of our supported
Linux distributions, but it doesn't work on macOS because the version of
Bash used there is rather old and thus has some differences in
behaviour.

We currently set that variable for a bunch of distros explicitly, which
is tedious to keep up-to-date. For example, our "linux32" job does not
enable the test variable even though it could. Adapt the script to
instead set it on any Linux distribution.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index d0bd8113d35..560d785f67c 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -367,6 +367,12 @@ esac
 CUSTOM_PATH="${CUSTOM_PATH:-$HOME/path}"
 export PATH="$CUSTOM_PATH:$PATH"
 
+case "$CI_OS_NAME" in
+linux)
+	export GIT_TEST_USE_SET_E=yes
+	;;
+esac
+
 case "$jobname" in
 linux32)
 	CC=gcc
@@ -397,10 +403,6 @@ esac
 case "$jobname" in
 linux-musl-meson)
 	MESONFLAGS="$MESONFLAGS -Drust=disabled"
-	export GIT_TEST_USE_SET_E=yes
-	;;
-almalinux-*|debian-*|fedora-*|linux-*)
-	export GIT_TEST_USE_SET_E=yes
 	;;
 esac
 

-- 
2.56.0.500.g5d06dc02cd.dirty

