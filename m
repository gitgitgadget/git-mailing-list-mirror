Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792910144;
	b=Xtn98jGWyv/008m0VPxEsNOouHbXAdW/94vyhX1FZpn1pu+CvpUy7WhmYyWnlubzZyBi
	 1ZCg6Fd/ZLvwdjvXBhpDUUXsZVC6voNHljW8Gr/W04uOGBXPLT/Q38vi8Es4I6tck/X92
	 hCgZtI0wF5EsxbM9Zcu/GeexYIBdMoNyz+6C9tX89dlEMXOMC55QTBvkJFJqtnUCfFf03
	 VICEZAVzikauISSOC1w57I+3mKSCrEYOPfIELatHUVY22QRvoWcYwQ/AZI9rLHA82TO1N
	 m9cPC2Wv579wQ1OBccqNvHEb80sAFvUJq3Y0C2E1tHC0x1KQga73IRiTujxUto4wIdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792910144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QtL60QrAy3o5e2nHHFacsXDvRck9/w5DUKmRTa5pgWU=;
	b=iUXRG7KDQsH2iUbbfYQ8Oe0PidZlWcXGpemFX6APTifu7DEnsgSLE7p9CkMNIV3saGTv
	 HtGdzdRDfGWz1zP9Sz+nd8om0bUtCr//iEWXEOEKd46KYkl7BeHm01PnTCydxxAiA8TFX
	 RDFasNkqt+LefkLkpRDcN/ylrAV+pUqJpjpJLRcdqpKUBB66dXJV/03dv4j3QO8Xa9kIX
	 x+DLlQ8QPN4BljCG2XxigLw0CqcKIVcZWYpQ1DGHsmXTCCI7lR21IPqIjPe/JzsyE0V7w
	 ke/W83FsT4rIDyX4lbbnSwMXvif3PWxtdcaAHQUQSPR9aEu5EvZjfGZflGC4eZeWidA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tylercipriani.com;
	spf=none smtp.mailfrom=tylercipriani.com;
	dkim=pass header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=T1O+X4qh;
	arc=none smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C32606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 06:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31C32606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=T1O+X4qh
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6d7e06dbcccso1184507eaf.3
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 23:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1792910143; x=1793514943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QtL60QrAy3o5e2nHHFacsXDvRck9/w5DUKmRTa5pgWU=;
        b=T1O+X4qhghuZkBSAfEYyeVNNlAhJGdLclaICa+6bl/PzYa+IPW+L6YDahk0InFyjLU
         BoK66NrL+EBpbRdHU3HsRzJA28vDQqUNLBoYDoJZOQNSog1RB90IQOP2bqG/pGxx+xex
         q/nr/uXRMN1DbP3yjxUsjxp860XdeuirVdC0qErEJeCzvKFFOZOMwZbjkWFbUp+u5uG1
         CjVBY+C8ffk7zBiRfGXbXXIKWvkFV9z4ZVgAlA9MnaXhJoeF+zdougOScGCgOfPzPpkb
         dCRvslNVBV4J2zJr8Cf5eGMNYU/PXNY0h5UVMtOBNSUdkeHZtOmfthKA/KE5t6pMyUAV
         uMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792910143; x=1793514943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QtL60QrAy3o5e2nHHFacsXDvRck9/w5DUKmRTa5pgWU=;
        b=gJqFXlhGv1/bDrf5pp6w/QHroZjusGMThRmvWQiHiH0a1Jn1rSRRfVpb92ItsFHTOC
         koWQO9BSNZ6Ktefmtdk71hwxdZ6nwlydYPfviNtWkUvLKT7dHNQqSJXCGJxPPg8IjM3D
         X9fQ191SmwcyJno9dMdCAk/XKHSmsx66DyCmI3WzCgI7tvLavW9Rf5sZyHh2LtLiog5O
         CrYZpnwoTJEh5+3Nf9pO9Y2aWV/3VEx1MT7cyRnQsQDPuHE/yntJVYWDfbxcpsCjUcB8
         z85ka3AAafQ2CUma3gC7csLpVdQFMlORI7pWg/KfIkfl8bI/gvekSyx4XnQH91jnWMnv
         Ictg==
X-Gm-Message-State: AFq9FYL9sp7wPjgUbKyrZXQxgVcEwXufRJBItBOr+xoudv8Me1MjbpWc
	A89CRfo22e/5o9oRCcnMzsdCr30wcZryGhTalRdMKPMK9aoORv3ok3RM37rt6PUrqx0HWw1rj9g
	TvTtB
X-Gm-Gg: AYBFou3n2HLeiEG5QpQc3ZVTnxNE3U4IRldSe5WsVfrSfDbF1y3OL9EEBaGBB2Xghs7
	LIDgvDQGAqOOU5z9JbHhF60NVgODIJKsPv8KRyFJk/T96a47Kya8NohsERjUIYIvtET4AAjLCaU
	H+OKDbC4OpPZNzg3t10mWSBOgXfDqIlovxkic8W/ffIONrMaj/JNnfMfYLJmdTp3Z45l7++BaMw
	/eKcIqrrb4p3mECB7/8fqzZrLqo1S4G0eYGldtczdeCmTVthUZpYOnXOTGdpCLqwcJ9a8ePkxMH
	8GOE7mgeDCtatL11+L8YWe0Fvf7g3CXDgwS+FMpGAmb2HBuhvbjV/S3CG08N44CLndJTXtfPl3O
	lLoG/X3wIpX6loa96ymezP9O+W3/HFsIgCOgw18AOUUIb4MUDZhap4iWV2Yc7vEAkXEDTmUxYB/
	E/u/g3yyalhSJE1x1/bfYnMf1q9Kjc0K3V3HqHePo1bfakCZvm5pRVmmZuBYHp6RLl6VqtPiTyf
	VgRjOwp5pl5RPJrv5adWCOnxIC72CDNPkj558pZemwTH/TafPhc2J3itw==
X-Received: by 2002:a05:6820:8585:20b0:6d7:5105:f6b4 with SMTP id 006d021491bc7-70ba0e2ddbbmr1158577eaf.47.1792910143076;
        Sat, 24 Oct 2026 23:35:43 -0700 (PDT)
Received: from localhost ([161.97.204.248])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-850fbb25f59sm4152434a34.20.2026.10.24.23.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 23:35:42 -0700 (PDT)
From: Tyler Cipriani <tyler@tylercipriani.com>
To: git@vger.kernel.org
Cc: Tyler Cipriani <tyler@tylercipriani.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Montalbo <mmontalbo@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/4] t/interop: replace bare grep with test_grep
Date: Sun, 25 Oct 2026 00:35:05 -0600
Message-ID: <20261025063508.3026136-2-tyler@tylercipriani.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025063508.3026136-1-tyler@tylercipriani.com>
References: <xmqqjynueq81.fsf@gitster.g>
 <20261025063508.3026136-1-tyler@tylercipriani.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use test_grep for grep assertions in interop files.

In preparation for combining chainlint and greplint into a single test
command, ensure that chainlint and greplint pass on their combined list
of shell scripts under test.

Signed-off-by: Tyler Cipriani <tyler@tylercipriani.com>
---
 t/interop/i5700-protocol-transition.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/interop/i5700-protocol-transition.sh b/t/interop/i5700-protocol-transition.sh
index 97e8e580ef..b610a64dfc 100755
--- a/t/interop/i5700-protocol-transition.sh
+++ b/t/interop/i5700-protocol-transition.sh
@@ -24,7 +24,7 @@ test_expect_success "git:// clone with $VERSION_A and protocol v1" '
 	git.a -C child log -1 --format=%s >actual &&
 	git.b -C "$repo" log -1 --format=%s >expect &&
 	test_cmp expect actual &&
-	grep "version=1" log
+	test_grep "version=1" log
 '
 
 test_expect_success "git:// fetch with $VERSION_A and protocol v1" '
@@ -35,8 +35,8 @@ test_expect_success "git:// fetch with $VERSION_A and protocol v1" '
 	git.a -C child log -1 --format=%s FETCH_HEAD >actual &&
 
 	test_cmp expect actual &&
-	grep "version=1" log &&
-	! grep "version 1" log
+	test_grep "version=1" log &&
+	test_grep ! "version 1" log
 '
 
 stop_git_daemon
@@ -51,7 +51,7 @@ test_expect_success "file:// clone with $VERSION_A and protocol v1" '
 	git.a -C child2 log -1 --format=%s >actual &&
 	git.b -C parent log -1 --format=%s >expect &&
 	test_cmp expect actual &&
-	! grep "version 1" log
+	test_grep ! "version 1" log
 '
 
 test_expect_success "file:// fetch with $VERSION_A and protocol v1" '
@@ -62,7 +62,7 @@ test_expect_success "file:// fetch with $VERSION_A and protocol v1" '
 	git.a -C child2 log -1 --format=%s FETCH_HEAD >actual &&
 
 	test_cmp expect actual &&
-	! grep "version 1" log
+	test_grep ! "version 1" log
 '
 
 test_done
-- 
2.47.3

