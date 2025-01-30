Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B261EC017
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738248262; cv=none; b=J0+msk2MXhyoYOffcMiOO+Ls0pq9wZiOeAZVOqEZLYpDUEynfqgy1+RchCUR/QIO19ukeF2S91B1UXuTeGnyESRWRU5GWHKmFeuM+60MirzF1THCf+jbpKY0XXEFuk+eVqMbhuhMc8KZy7uaYT9QI14B+osMu6J2sWoBqbsF3dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738248262; c=relaxed/simple;
	bh=h3v9Ybb1s9qqSd+wwu0XTDTls7whNjHDwCKxmgF/XUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fbzOuSkkO9mKriV8r/FcRFGzLSguwLLW+r32leYiZPzuBuVCildnwNHVA3BKq54gYjsduPtIMYeIPgsPy27eisC1rI2KdLPVRoIbau6dBNJRe/dN78Mp4k27ZiyOh7kiVkvFKkpQTn21+nHPgABEfw9ARL9N8fGjHsC2eLok6/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mmkvp3xk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=po0KG5rz; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mmkvp3xk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="po0KG5rz"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 16DAD1140108;
	Thu, 30 Jan 2025 09:44:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 30 Jan 2025 09:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738248260;
	 x=1738334660; bh=UsfhuRZbMzYB+Tu2+b7MOT+3T6OtqOH6ptlD5cLlBG8=; b=
	mmkvp3xkmCiXcQC9hAJO9p6l0+otpnafbB7WKt7H40W/R+Jv0DInqplk+Jmo+lU1
	HLA8kzQQHSVCRvTGXq5n3OxCdH1GHJjrGEy+d89a+kj8oGZLxYuHJxu4dBuQ2Aww
	am499flBXaydFmBFz4RAZ8izAA6o/mZcHs3gNbyaDIjQ3Zh17JhmmeC7y674935+
	+x+Vau9+B0IaQ0ZUiKrD8EEMfOhS+G4N0LTnIN432Eto8jZG9J8MmGZXH5G5m3k5
	8rbmMtJyZ1OuPdcAmM09alJZR6aALHOyYucwDkrFoAocQU1YY8GRYU9/VCIrIxSc
	ptdUHRQBD/7M4pAXDrDEwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738248260; x=
	1738334660; bh=UsfhuRZbMzYB+Tu2+b7MOT+3T6OtqOH6ptlD5cLlBG8=; b=p
	o0KG5rzaZ9ql97ERQ0PIftVkKMhW6qLs01WY8sW/3w1/n7MqweuE4PtLzc5zdChK
	+vM3+Ef+txJhI35k/ldFwhKNxI6vyITmxd8SaUnFtt5AnzIAWibN7wTCTe5wPEM9
	BjKL03tZBmeGzaz6k7Su6FvM3wuYJsO2jfIHKiDD/I7I5P//CnxGpdWvfNn1xqub
	YhL2VQeGWMH8Gy0R2+sWZL1R8Cgp9Uw2xwg0vI/x9DXTGK28SGzQuBbd0rWm59ri
	qJA6ykkGqnwOqNBoH4khMH0ppZsRDkOujuTyyUWrbsrQhBvIFk5+Bo7ebW2Vt+9t
	X4xJeNbGJgnbIBY/gKc1w==
X-ME-Sender: <xms:Q5CbZ_wrUUpD0kVumN1Chzsd4qqEmbCqt2sr-3Rl26VY0AfnfdphWQ>
    <xme:Q5CbZ3Q-Wu7r8UQfIfJgoZtRLzPrXK5twpQaQlqEoxFiRsdIyfnb7YiuDU0RsB96y
    C0jeNIWYuNhcXviqQ>
X-ME-Received: <xmr:Q5CbZ5Un2bL9LQ66sC57qO-gj67CNC2S6UUfeklJOHnODRJe-eVXl7SFBaaPuDhLgxmOdhL_0SBMTQ-78wMvnV0evt0QI6Qi9Hks2Uc28GyG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Q5CbZ5gkRTg4Z7yygk8joDdcFucyODjqaTp0cPgUST7yz-KGx28pXA>
    <xmx:Q5CbZxDptNz3jP5keO_lL3ZhxByeD7y1oGsgOFWm3dN9PnUgnZjY7w>
    <xmx:Q5CbZyI4Er4D81WST5BRT7iFbhzCHvvATFiwqHxw8TXxDif0bTmqQw>
    <xmx:Q5CbZwAEJvoilc0N6VS9LmwBSYdUcDnMQsyhqMtnru-oDeMpT2bk4Q>
    <xmx:RJCbZ0MILixdVrRIh95neSy5F4iGMUaTiZM3zrZlsszOaQM2DRn-HlYx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 09:44:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 302e2a91 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 14:44:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 30 Jan 2025 15:44:03 +0100
Subject: [PATCH v2 11/13] meson: fix overwritten `git` variable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250130-b4-pks-meson-improvements-v2-11-2f05581ffb44@pks.im>
References: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
In-Reply-To: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

We're assigning the `git` variable in three places:

  - In "meson.build" to store the external Git executable.

  - In "meson.build" to store the compiled Git executable.

  - In "Documentation/meson.build" to store the external Git executable,
    a second time.

The last case is only needed because we overwrite the original variable
with the built version. Rename the variable used for the built Git
executable so that we don't have to resolve the external Git executable
multiple times.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/meson.build | 1 -
 meson.build               | 6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/meson.build b/Documentation/meson.build
index 2a26fa8a5f..6438fa6792 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -283,7 +283,6 @@ elif docs_backend == 'asciidoctor'
   ]
 endif
 
-git = find_program('git', required: false)
 xmlto = find_program('xmlto')
 
 cmd_lists = [
diff --git a/meson.build b/meson.build
index b5e8aca288..cf3f0d59d5 100644
--- a/meson.build
+++ b/meson.build
@@ -1605,13 +1605,13 @@ libgit_commonmain = declare_dependency(
 bin_wrappers = [ ]
 test_dependencies = [ ]
 
-git = executable('git',
+git_builtin = executable('git',
   sources: builtin_sources + 'git.c',
   dependencies: [libgit_commonmain],
   install: true,
   install_dir: get_option('libexecdir') / 'git-core',
 )
-bin_wrappers += git
+bin_wrappers += git_builtin
 
 test_dependencies += executable('git-daemon',
   sources: 'daemon.c',
@@ -1702,7 +1702,7 @@ test_dependencies += executable('git-imap-send',
 
 foreach alias : [ 'git-receive-pack', 'git-upload-archive', 'git-upload-pack' ]
   bin_wrappers += executable(alias,
-    objects: git.extract_all_objects(recursive: false),
+    objects: git_builtin.extract_all_objects(recursive: false),
     dependencies: [libgit],
   )
 

-- 
2.48.1.468.gbf5f394be8.dirty

