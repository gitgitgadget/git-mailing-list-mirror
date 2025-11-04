Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BEA2D978B
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 23:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298006; cv=none; b=gsLUsdFJWxQO4gCTEm5ZCEKmFDcr0kx3jtDlHTLX98qPZ3yp021k5Ve9Y124QuqRMR+oCTxjZatvVgP8jwcfDJFswyHRBnGaUG5y3Wc047cY08h1KKCFuhPj7rNmGtrQ904Jo44a3/I+6xIaJxbvw/qD9LBV5dV9GWwisV1M+UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298006; c=relaxed/simple;
	bh=1a77ACLCR7PqYAWUN22wA208W2Q8EWtZNgaHsOJdX/Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O7XyEDahtmUBzzOOnV8w+6i9PpMwRADwA78Ql0EQqdoJhq//s/TqMkZZAGpwDNbx5isdWiC3zRE4i8MUP9yKOFUXmA//P/SRhDG68A8YHUParq8Ihi1bvgV4owbH9Frksy8OhB2LumOJAYwUT2wjIdNtucwpFjAbOpjMxUYuOVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lDhtr4cw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RzgIsYz9; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lDhtr4cw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RzgIsYz9"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A6EDDEC054E;
	Tue,  4 Nov 2025 18:13:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 04 Nov 2025 18:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1762298002; x=1762384402; bh=xIo9E3p+V8Hsh+14y5V9v76Qw+NSVDnQ
	EXr+395PciI=; b=lDhtr4cwK/I2lSVkdBiL1hsAo3AJmSjOPBliihbN9HST612o
	VS/O+s0agVeAzDTxjfICPbMJ4IbjA5NQM7Z7Dp1FWD1fbqy/hayN1nlw6yMrRPHH
	390cO/OSYMaR70DSfGWr8u2c0xjVrpcuNJ3XH+HeAR63IE7k8pcM76a08EATbq3j
	yNIJPRpIgariWocXi8nfK1AIQEo2NGIuVzCFU70EsoMV4Kg5Ii4kaK4ri6R0KkG1
	cPaURyHZ3kDkmBXdS3bdIZ5pqTobxig6P29eo+umTRyMAS2e8JZmHZIzf9XaQ085
	Y3xk/cjH2mk5DGIDPPbtcb3JfQLjo96FG9ekEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762298002; x=
	1762384402; bh=xIo9E3p+V8Hsh+14y5V9v76Qw+NSVDnQEXr+395PciI=; b=R
	zgIsYz9oF/YQFy3uFxOvkjnOMuuEvIGdC7c3+iVDoCPYbRkJMoTB1zjswRoMGvKG
	94eilw0hAa/mb/gVKC6DBlng5bHsg2vT8PN5CJyus7GRs1KjWi41tB+x4Go6uLs+
	8RKW6K/TGjU16LEhPfHaX0xnnRY6IkxHjFWeiQGtgx9QZzgpHB6GvEvEbeBNSySu
	hmr1fgzbwoeU3VrxJE5Q335YU53e2H2Qov5LuuBavurvAbobQLoG2jixVLOscrFL
	Rre7fegOPlkGv24pmdoZ68nfZbofNdsm0M0yiBSp9pPb5jw6mwaeCRLEE1WasjXW
	sZNinVxJq5yjosPmVY2pw==
X-ME-Sender: <xms:kogKac2OVt5uwMZ7VLr79yqf9yhTBUB4WwRCszwcXuMDefswppbM-w>
    <xme:kogKadGatrLUsgY952mKDf7UMVD33dXjpiHKW9WDm3xmLCXALnk7iaTCTSSKtZL69
    XLMmyA-X5U_3LShZYcsg5HB_-9kr5LwToXMn2H-gsX_lqeeTyhnbIg>
X-ME-Received: <xmr:kogKaSinzFGDkp8LRX8Glvs9jIYzpsQPoRcT5ddDaW-x-SqludXVkOpMHXQaHJCb50MwtvIqAE6BE7HVsBETmNvEFDtFqqeJVu9S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedvfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepieelieffvdehteefveegleehjeekhfekff
    efudeliedvvdelleelvdeggedvffejnecuffhomhgrihhnpehvvggtthhorhdrtggtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsth
    gvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:kogKaQ9lC6PypWcKuSBv1H_DT09f67zXTVny97ajVqQBzJY5ZYAWFA>
    <xmx:kogKaRr_P76LOEw83b6aS9aBg24ST9CtmyswFVP7tg98U6K4I8Y-uQ>
    <xmx:kogKaX_lANbiAzMBpVhLrYUUdKcDXHBzvHBCe7HUqaJD3R2JRD3zNg>
    <xmx:kogKadWDOnv7oD_4pCRiYF_D4HVJwtHU4nTuaTYq356RBrSgwXOWtQ>
    <xmx:kogKaYMH5GjAscAWLnLwYBFhsEnua2TAc38P1JCLD-D5OPCDv3k8gfAK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 18:13:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] GitHub CI: macos-13 images are no more
Date: Tue, 04 Nov 2025 15:13:20 -0800
Message-ID: <xmqqh5v9o0hb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

As this image was deprecated on Sep 22nd, and will be dropped on Dec
4th, replace these jobs to use macos-14 images instead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is a monkey-see-monkey-do patch.  There may be additional
   adjustment necessary (versions of tools available on the system
   may be different, for example).

 .github/workflows/main.yml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index aa6bce673b..f2af90ad31 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -313,16 +313,16 @@ jobs:
         vector:
           - jobname: osx-clang
             cc: clang
-            pool: macos-13
+            pool: macos-14
           - jobname: osx-reftable
             cc: clang
-            pool: macos-13
+            pool: macos-14
           - jobname: osx-gcc
             cc: gcc-13
-            pool: macos-13
+            pool: macos-14
           - jobname: osx-meson
             cc: clang
-            pool: macos-13
+            pool: macos-14
     env:
       CC: ${{matrix.vector.cc}}
       CC_PACKAGE: ${{matrix.vector.cc_package}}
-- 
2.52.0-rc0-105-gc08128fbb6

