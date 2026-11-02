Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618296;
	b=Ly4z/OpDTQfTD0U4vpBFPAriAg3y09GpMTnNyTDGZJ7OxacRyE/RXbOXRIcSZfwjxWuL
	 GnRSdCfG50gOKPVGePZKVD6oe45lrqsXK4WhebJj6Mbh2AUkCC4rDtFsWJs3MBOAqnHUu
	 JGZwTdrW6WONDM8HO8j3EcsYjglmrD/H+kHlbxCBIKZWFY34ROwYBlnxCaTY+nc0JhNOe
	 QYgSfbKCDNi81V9IEwbtVSljeSKHQdGyCmIzkl3m9LkCp77v57K7ZFsRiREERFkpqxqmP
	 N0aDju9GatBkEWN0NxMp+gKA8HBC94uAC9xtqK/zSX/2w5sbJO2Ky+BkMXnag/9LLDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618296;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=gg+z83AEZTW4MxL/RpoUijnCybkfibYFVQKt+mVCKu8=;
	b=jV64ixi80qPu6jeVSboySWC+RQQ/j0WZkfR+Ol8ytrAyhwGEmRqhF8BvXQKvfosWt50i
	 bOzD4U8lmRiGOCMmdb3xCuIm6GjLG5lepK6AFxcnwZ6J13FMIZGJAO4psqrulYVqOkn42
	 zEKfmhuzsDZwOrHgay65VGN4n5hrnH2RDFaFQDRd16fuN11/fQOuX1mmnB4GyaYiw7TQ8
	 M30C9WO4Ay/A5VdrlCt4I+Mkuvt0M8EeA7i4OvFlURPXuuLzdSEvHElwGwj+slE3EtrF7
	 d8KiDdZFuVsNQgoKO6q2eWg+oL/YVC2zoYkchzn5aATaAG5Vmgk24ybBJTurax6as9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=sqqUCTjg;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Jmm+Za4R;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4F460A263D
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A4F460A263D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=sqqUCTjg;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Jmm+Za4R
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B1E051D00226
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 06:18:15 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 02 Nov 2026 06:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793618294;
	 x=1793704694; bh=gg+z83AEZTW4MxL/RpoUijnCybkfibYFVQKt+mVCKu8=; b=
	sqqUCTjg8FHBhHXm2PZ5MouvSjP8J8VYwwYdHofLBrBw0msYE8OtNTkSoZUs/Tia
	Pp7zlIy4mXNS60lIWApFgYG7AzzoemTAJPR6Zd1RPjG2L2jktN3DKBPV/1hGL2F1
	Uqg/ZQMtyjc4CmpvDi0Wa0Ru1l7ZNbcSEQ7cOA1WdBr3I3n1rLKI2rwhlqyJVhq9
	Ey7UPTQVJ31Eoq9WwGLAYLySarb3REnphY7I73almaadv/hT9jsv+U+dGRYTo6MO
	dkThFddm2yZCNW9jX11LcEQRZvEUaHU3j6kfM7vQvxIcuhyFGZK9TlqKGVTRNUKA
	4u6i06/DGtuoaQh3G6gXBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793618294; x=
	1793704694; bh=gg+z83AEZTW4MxL/RpoUijnCybkfibYFVQKt+mVCKu8=; b=J
	mm+Za4RDDLmm0oFtkOZO7Gca0x7W0WSbcxs8CDWIh/d3elvnSe0ttheeT+UXbdpa
	gX8wHBFu+2qwYITHxTocC5OLDhN6rOnCT+/LoQ/HdLVVv2g6W9BdlDBafhMNPDJ9
	J3EX8z+xhuju0XUF0YvIGmH9ph80Nq/5kkhBbec9t7AW8TsEhVob+FYeoGyTd+Rg
	hgCreFGxeGLNHnclJPKkQ53e+93xkYwGPxpR8njygy/Pyc1BM1vCKV57lINWhRp6
	sS/i1FCbmzIQxFyU6gz+teEfwUVnI+hJZe38MNzA7KxO4ptVv/HHVABFkZv/wpgR
	d0bf6O2yVn42XoTVmfyiw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793618294; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:coZLxNlk/0y6kefN4JIPewbXI1zbYUhFMHfJZyrXQ9J8CIR
	ItTWa7DN/yvASXs0s60w5QuaY0cekKmfw1CQcVXKzoY46FgDzl9oLTBk5vKen4Ik
	jHe8LnX6b8TGZTA7ALfubbK7czJ2jtFOYTZO+7dJ7idyS4B7qQxUodKWjTWRhtpd
	JKf5A7yZ2cxSsdwR9f9P1ZyxgW5Mhq/ssPwGonU69zm4KU/wDA/nohCgOHGCQWNQ
	FIpmU0BqWJ6Wc4lBbr0dfflKl4p4eOEMPx9N69IfQDadxv4oVtAW0W7fFeDlsv17
	fHsHvgkBG8xP9JXnhloGc8egIQYAGS1S4128+Ng==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:i4GDXRHL3Iaiy9yxaxScVHKCHt4nX0KAIlWDgY7Uo1Y=:hiwcFxC06+yJ4rINjNGETzT59mx4Ul0thSTAzC9o6+Y=;
X-ME-Sender: <xms:dnHoagqh_CjV-h6VQUPLdlHjxk5gCMLtTUOo1XzYeG0bXk-RGlTqng>
    <xme:dnHoav_8ZHF3PCDStgYXqCrk5Ap71G3ReJBhR2mB_e1u1WLRdGXbAJ5RfgKQiQvCI
    axKzevgp07t6UfEMtvj9MaJo77_wEwZfjCf_h99grxxKpBgqsUuH-4>
X-ME-Received: <xmr:dnHoaseh1sYpdNrKkxpIfHUYM_6IqfjgvQFQWRssdwZsd0pKZhnCcaNNpI9YObCGd6mrNg>
X-ME-Proxy-Cause: dmFkZTEXyuhHrrnb1gS/aM7tkRlNQcp8bibU3vAgVGavHNMWT6/jkpRLB5emEJHRPiClN3
    ME/PMR2+hmJSyTlsXe5D2PDaoBSbU1APtpz6KlKGYqDUGSLjLskiL62loOhamsPeQc5AH2
    168HRYHZluXKzaVKnNAUKQoRWJvILJ9fUmBGE1KA+IY4b8Aam9arfoWOZ73Jxak6bP3W3C
    u7CbkpDmNzxmZ3aARVN9/njbookCGclpDLcz/zoeEO+adtBUAQLPA+tk8DozF3LOUA6ZBY
    WpxueVw/5NkwbLZDrVr0wLRo5qgehigUsqQB8gnvuWyhJDBotL/qc+CstJU9OAWU+oxDKI
    9ukdnuhOAHzQuvFd9vo0ixloopldWFa9Tzp0m1Ohrgh4Jtnd2s1FpnyCeFX6xvaJbQlLZ6
    IF28n9s+XUmzMnY7otGzkPnIep3qm4p7TU8wdf5kov5ua/I3YxGDP3eul6E3XgY85OAT9f
    JyQ04KGU08NcCZXqlYpg9QtTIhIP92GwlKXJsAONcRWox9L2oGlB1V8H3GGPc5tcpzlvql
    Qpi34rKZKya5i2Cg6v0Y4RHjIcDJU0mj5veVM76V40lCqXNeITwlk0HiYGoTOth9HJeMdc
    nzNQIiRV4At5EDwuVjvdchFulF2YqVYZYViac/FWm3iADVrR0R74i+NUkjFg
X-ME-Proxy: <xmx:dnHoapLKX8N4a_pwrZFvt4ROpI4chRsA81vxPf0LZu41fjsRGvFulQ>
    <xmx:dnHoasjiaKhtzxhSXsF7FQiDObo9OOfrrOjU233-gk5BCnA0Knucxw>
    <xmx:dnHoanRDlm_kqB-L6gzQUiySHfMpZFCJoWf1hN9wd-Hu_Wp_PCGxlg>
    <xmx:dnHoamXMyDU4ZZH4aYVnKa_KEYNZMDJdVDM7GfH1iEc7QwnsYJlprA>
    <xmx:dnHoagXNEI2av-p0qhdtkytRWTT9aHmH1uTX9zDFmgFz5M03Uofa6i_F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 06:18:13 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 86f5a09b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Nov 2026 11:18:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Nov 2026 12:17:54 +0100
Subject: [PATCH v2 6/7] ci/lib: add another NO_RUST build using glibc
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
Message-Id: <20261102-b4-pks-ci-test-vars-consolidation-v2-6-a5485c437c62@pks.im>
References: <20261102-b4-pks-ci-test-vars-consolidation-v2-0-a5485c437c62@pks.im>
In-Reply-To: <20261102-b4-pks-ci-test-vars-consolidation-v2-0-a5485c437c62@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

With 32d5b90590 (Enable Rust by default, 2026-04-09) we have enabled
Rust by default. As part of that change we also lost test coverage of
non-Rust builds, as the only platform where we still exercise without
Rust is on Alpine Linux with musl libc.

Adapt the "linux-asan-ubsan" job to disable Rust to restore some of that
coverage. This job was chosen because we also get more bang for the buck
checking for memory safety issues in a job where we use C instead of
Rust, as Rust is supposedly memory-safe by itself already.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 7f67a95cdcc..82bc169ed7a 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -427,7 +427,7 @@ linux-leaks|linux-reftable-leaks)
 linux-asan-ubsan)
 	export SANITIZE=address,undefined
 	export NO_SVN_TESTS=LetsSaveSomeTime
-	MAKEFLAGS="$MAKEFLAGS NO_PYTHON=YepBecauseP4FlakesTooOften"
+	MAKEFLAGS="$MAKEFLAGS NO_PYTHON=YepBecauseP4FlakesTooOften NO_RUST=Yes"
 	;;
 osx-meson)
 	MESONFLAGS="$MESONFLAGS -Dcredential_helpers=osxkeychain"

-- 
2.56.0.500.g5d06dc02cd.dirty

