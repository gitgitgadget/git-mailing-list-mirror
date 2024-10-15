Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E861C9B68
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728985581; cv=none; b=AlfT/Z7Zg2uRTIFT0uof4217R0rRKfHTW3vv4norfws5yrSvJf8nHCTLa08OyJfsA/6kIezHngUYqJqfE52N4Jf0VW5ygcpqaQ5rqUfj3tjM9SpmkiiLiNT0jdX/c0VKBCC7L0EBP2fQAyZh3+Q4x1nw3CI2of2VDQyEm5cl1i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728985581; c=relaxed/simple;
	bh=Kl0AJ4n9zhg/y++ngEQ4g9zCh71eOBfwRGehyqJxUVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjnwz7CPZZqgXNdbOCQbbuyZxR4NOC0rLANcF76CO1oWGSCnDEmOQ2Y2NrhDW64sV2GXtpkWTd9yY2Muhddn48f2bJemBNn7Qcebll/piiu9Ecz8SjGdEpYwQi1OsJHxopiQqgwrqVwc9v74Edjcvm3Mv6TNY5fdVfaWTkCj4xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K/88nyKi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RssLjTOv; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K/88nyKi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RssLjTOv"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2825E25400B4;
	Tue, 15 Oct 2024 05:46:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 15 Oct 2024 05:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728985578; x=1729071978; bh=zYLO5UFxdR
	kmyC0RNarrzCBBDTJNtE+GRF9vYzMzkMA=; b=K/88nyKiAffGp4Rzco50X0AXTH
	EXmwePkL3gdta5kA7DhNA/8tNXk6ShDNyUE8m5yJx97nCkDQqzpilP1FIUe3scDu
	UZoD4NOvKzpYuRtLea0N25APM9ynNi01ZtDt4akM5nFOJpTlEHOOXlybci7tNbcV
	JTsziQ6Rx64u5yrOeunVG4KUGW+F6+5JyA3hEPTd9jSuxX6v2A3vX1M0BNR8xUlH
	bBOgE/4xDfaf9cf4jWM8HtirGrVViUUPHA0wsAitmjQ+0e1LPY8SN0KNNUbV/Jvd
	h7eB4GE0jA5zo89LRw4AnEIbL+su+3Pz5Xikp1u2hGtXMQeiyG+O1cFw8IPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728985578; x=1729071978; bh=zYLO5UFxdRkmyC0RNarrzCBBDTJN
	tE+GRF9vYzMzkMA=; b=RssLjTOv44iGzpUFIxT67Pd+jT9zDiUeq+Lf2dvdkqe3
	QSMVsWN7N8+8HRGRSvbMYJuo7rNOKeWTxj6qZ4zzeC+/911UR+I7+pJFrU7cI1J3
	u8V8kwPrMFg587NbpldzUZK4N8bXaVHoRTh32oS7/x2mikzcgcULeeyfgX+2qDJk
	am4vxxSsRmavCIPXFHiEpqSb/gyWp3VZ2z5dkMIsuaUGXazeU+TCkNbcGMkLp/v6
	qwzjSCY51SVnpJxTDmXga6YT2TglEJtk2kzcKXwwpNu5BEuk2rq048n9j64oPU9B
	jkJMre0tt8uwCxFvm+OZN7vN83msUkotinKIGKl8MQ==
X-ME-Sender: <xms:6TkOZ3aYnC_y39S3RSbLAH8039fs0RtKGbibwhHBxf7OztYFkpGLxA>
    <xme:6TkOZ2YKZR--KUGSWarW0BzA2NikFHy7swM6n8hA7DWaq_AVbf9FVMf25e4Mtvo5y
    oEWCB9UYI7NzftLMg>
X-ME-Received: <xmr:6TkOZ59pxSasuuAFBYVU_D4waBuSojrQZWwN5e8Df9GHSs8Y16JLvPNq9KO7JI0vit2QoBzkcY53NfS6ca4cNDsi0K_mSjBlGmkHtZhCYKfoBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgt
    phhtthhopegvughrvggvlhesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrg
    ihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:6TkOZ9o-amR_aHLjS6MWKRcG0wIvpxjTnaUu7MLGhveffBTb-0aMWw>
    <xmx:6TkOZypj8G7cV8UXsY2Pd_Aie5eA_ksm70i7OscmxSnE7jjS5CnvEg>
    <xmx:6TkOZzSREI0Xd3guq9POjWKSeRuB9em8nED7TzsmGLMFX5k0S5scPg>
    <xmx:6TkOZ6ocEFmrs_LAyhOswptXZJFr2lttrQE8PDuKNMZfrGDOQjC-cQ>
    <xmx:6TkOZ7nWZIzEvrM8iZexLIS0oAXhIWwVNapSvJYX_e8QBVDFBfulGEF2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 05:46:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 82cf4e02 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Oct 2024 09:45:01 +0000 (UTC)
Date: Tue, 15 Oct 2024 11:46:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ed Reel <edreel@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 2/3] cmake: fix compilation of clar-based unit tests
Message-ID: <447afc4a0f37812b6488a51915a86302c20ddb12.1728985514.git.ps@pks.im>
References: <CAGjHeYfyH+cOMYYYHnFR+Vu9T+RbmzO1SpB_-kbmBSf1DitJhA@mail.gmail.com>
 <cover.1728985514.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728985514.git.ps@pks.im>

The compilation of clar-based unit tests is broken because we do not
add the binary directory into which we generate the "clar-decls.h" and
"clar.suite" files as include directories. Instead, we accidentally set
up the source directory as include directory.

Fix this by including the binary directory instead of the source
directory. Furthermore, set up the include directories as PUBLIC instead
of PRIVATE such that they propagate from "unit-tests.lib" to the
"unit-tests" executable, which needs to include the same directory.

Reported-by: Ed Reel <edreel@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/buildsystems/CMakeLists.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 62af7b33d2f..093852ad9d6 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1042,7 +1042,7 @@ file(WRITE "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite" "${clar_decls}" "${clar
 list(TRANSFORM clar_test_SUITES PREPEND "${CMAKE_SOURCE_DIR}/t/unit-tests/")
 list(TRANSFORM clar_test_SUITES APPEND ".c")
 add_library(unit-tests-lib ${clar_test_SUITES} "${CMAKE_SOURCE_DIR}/t/unit-tests/clar/clar.c")
-target_include_directories(unit-tests-lib PRIVATE "${CMAKE_SOURCE_DIR}/t/unit-tests")
+target_include_directories(unit-tests-lib PUBLIC "${CMAKE_BINARY_DIR}/t/unit-tests")
 add_executable(unit-tests "${CMAKE_SOURCE_DIR}/t/unit-tests/unit-test.c")
 target_link_libraries(unit-tests unit-tests-lib common-main)
 set_target_properties(unit-tests
-- 
2.47.0.72.gef8ce8f3d4.dirty

