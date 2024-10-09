Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32024188008
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480328; cv=none; b=ilY0/89/acbrAN6mCskXgHJjTTliFEMFi/A1MazAcHOd+4Z84MHRT1bY45uw+yBDLuK0sjkSvh3BS65oGTYKVWICMgP61Ugcx2FfOBuh89U4WX5FxiWCoz1z6h5Cz3xtK7nzEFoHfPUlY8zLOlm2kKc0tY3RQnlJcY/styl8ECs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480328; c=relaxed/simple;
	bh=buIPv8F7MkiDehp2BSZv+JBgUpUd52dsyg/ohZepuWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edMqF2NzWLNtIy8tLXS/ckC/N0BhH5vobimLyMeay0XnDn2U2dE9EtkbWv6P84lDOTEgqDqkdE+VaLGTtKOvTXWACYp3yhLfkVB+Cgu812iqC54nzAuhOzCktbXGjDfiZAQeL3v+UcgK5qlaFvIDMN1I3VsWDGc+0htxEKG2vj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f+/AI5S2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z76/2971; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f+/AI5S2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z76/2971"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 46A1713801C5;
	Wed,  9 Oct 2024 09:25:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 09 Oct 2024 09:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728480326; x=1728566726; bh=PnOZ6LigEM
	rkcISLIHbFv+8rjTSzz7nFG3RIZchvzhE=; b=f+/AI5S2QY9warP6T1X2tJE+Hf
	m+fr+kX/ZdJOzMGUNfTwHJsl6blrNcxlNV2Zgs0prl0MItrAhpwY8bAq4gNbgpb7
	c20jo+ztqxZ8+RG0aEZUWr9qhaFrwOcjKP9s2TeTuY+7vRfLDAjq8F97OkdeAidf
	dFwetY3nsJ670/DBSQ4Hu4fpdxcaYhNNzqjvkMPHbxEsWd81BhCRXGaWYcFdkuIS
	GiL1hKoplodsaKPmF4WaPWyMDOnWRCUUlwlG7FxFdz/8HvEy/PYYsdcBV/YNffKi
	N0S2H7eRaCR7EJZrP7XxY/yOAGmCw8OkrDQF5dDbVMj16Ex1TAARE0ZxxdDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728480326; x=1728566726; bh=PnOZ6LigEMrkcISLIHbFv+8rjTSz
	z7nFG3RIZchvzhE=; b=Z76/29715JxDMDi1x1vMIxwtRnjV3bdyxo18p1FJXH7k
	bDAgA3XvxjnjIKuw0hGAf7qiHpFA7YH/ONBjK/gp1KVkPidaKEOXmw5mukUsfoBh
	RwHiSswqzueYAIGnS3UwTuHSf0/vvgXcW9AYtMi2VPU16r8VQMXJIMP96ij3DsDP
	wNDiQ6m5gY8QGJZSRfNtzDAf4z44BtoczbPBernL1VRW135XqQSI1Ybegf8UbqAS
	2xnKc9hKwCaE2rHbP1xX1ErJJdh5PNXEM/nh0QRFEj0kcrVlIWk+5/sJjSAE+N8K
	aiUuYghI9PfzvWlonEU2YctJXIcgJGKF1QHlQkhldQ==
X-ME-Sender: <xms:RoQGZ4QPWttJcJUiqaLaihfE28BNFDfIsmQeLTHo-5pkErD6WGfROg>
    <xme:RoQGZ1xP71yAuHWn9FkjM-fbxY6vhB_GFKYho1YCyy7qzjfoG4WnaNszb2fkqCuGU
    b3GsqcpCWzimGfrxg>
X-ME-Received: <xmr:RoQGZ13KYXvDwmiPkAbuujqrRIxKlJliOrU_KuaRJ2v0sQxiXM2Txny3ZJJUPKra3v8UwIUhwwyjOAIXFpCW5P_eoGO6X6-b_cQYZGKE-bDigQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:RoQGZ8AjEt1n_DziVx5asxLKF5o3P-n08AU6I8dmfpCIBEx2PxtlZw>
    <xmx:RoQGZxh9Gx7u5W-96nmmmbl1ALJoj5OoQqIHzWOT65KuQbnIUNAY-A>
    <xmx:RoQGZ4pvHieepiob62ZZwzLUXqD63lVcAloaOGhH_MzRBrwIkeuEhQ>
    <xmx:RoQGZ0gLAfLS4pWXPZZenP3ltTDWMP0-1EfcJgEjBOTwErLyKJ2RVw>
    <xmx:RoQGZ0sVgK0Z92dlfYjjW-NOdQ5dnONYdiKh2ldjcadrtvzjpD0i6iW2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 09:25:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fbd98c76 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 13:24:22 +0000 (UTC)
Date: Wed, 9 Oct 2024 15:25:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 3/5] ci: handle Windows-based CI jobs in GitLab CI
Message-ID: <cb8c49b14e723221588c798a8f4a000510b1d5b5.1728480039.git.ps@pks.im>
References: <cover.1728480039.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728480039.git.ps@pks.im>

We try to abstract away any differences between different CI platforms
in "ci/lib.sh", such that knowledge specific to e.g. GitHub Actions or
GitLab CI is neatly encapsulated in a single place. Next to some generic
variables, we also set up some variables that are specific to the actual
platform that the CI operates on, e.g. Linux or macOS.

We do not yet support Windows runners on GitLab CI. Unfortunately, those
systems do not use the same "CI_JOB_IMAGE" environment variable as both
Linux and macOS do. Instead, we can use the "OS" variable, which should
have a value of "Windows_NT" on Windows platforms.

Handle the combination of "$OS,$CI_JOB_IMAGE" and introduce support for
Windows.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 74b430be23..95f39a26ea 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -250,8 +250,13 @@ then
 	CI_TYPE=gitlab-ci
 	CI_BRANCH="$CI_COMMIT_REF_NAME"
 	CI_COMMIT="$CI_COMMIT_SHA"
-	case "$CI_JOB_IMAGE" in
-	macos-*)
+
+	case "$OS,$CI_JOB_IMAGE" in
+	Windows_NT,*)
+		CI_OS_NAME=windows
+		JOBS=$NUMBER_OF_PROCESSORS
+		;;
+	*,macos-*)
 		# GitLab CI has Python installed via multiple package managers,
 		# most notably via asdf and Homebrew. Ensure that our builds
 		# pick up the Homebrew one by prepending it to our PATH as the
@@ -259,9 +264,12 @@ then
 		export PATH="$(brew --prefix)/bin:$PATH"
 
 		CI_OS_NAME=osx
+		JOBS=$(nproc)
+		;;
+	*,alpine:*|*,fedora:*|*,ubuntu:*)
+		CI_OS_NAME=linux
+		JOBS=$(nproc)
 		;;
-	alpine:*|fedora:*|ubuntu:*)
-		CI_OS_NAME=linux;;
 	*)
 		echo "Could not identify OS image" >&2
 		env >&2
@@ -272,6 +280,7 @@ then
 	CI_JOB_ID="$CI_JOB_ID"
 	CC="${CC_PACKAGE:-${CC:-gcc}}"
 	DONT_SKIP_TAGS=t
+
 	handle_failed_tests () {
 		create_failed_test_artifacts
 		return 1
@@ -280,7 +289,6 @@ then
 	cache_dir="$HOME/none"
 
 	distro=$(echo "$CI_JOB_IMAGE" | tr : -)
-	JOBS=$(nproc)
 else
 	echo "Could not identify CI type" >&2
 	env >&2
-- 
2.47.0.rc1.33.g90fe3800b9.dirty

