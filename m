Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3204F2DC322
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840617; cv=none; b=S45zlzZ976Mhiwxmu3/Kdxc0fyBi3p3q9qx9lnUnYS04VjxZyVJyjex2zUzQ+Q0VqdJ4Seo70DPquZEbBbDzJAZzTmNu4k2vbVFxQeU4/ytdGoGfB1YicPLGaEgTTArtuZ4zIn4aV8ZuW9QAdbzoKLLPno3hTOtHpiK1gMu6ZZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840617; c=relaxed/simple;
	bh=RDCjA3ClOkzsQHgoDs0J2xHi3hyw4iZBJN37tfrevQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GHJyaLJVc6uRw6+CM4ZmozrkqhVLdHT5KxNVtcxS8unWeNV6ihdu4RBx2EiC6Wqfl3zxHT/7cG/2MFvzccqGoBIS4rGjDIGPgEwf31viZjJg2xqjIfRnQ/iiALblv4056B4qWMKUho3JlUktwPMjbVFRCLgqmJG4bDuFNF3iHD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T59oNXAN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iey0DRna; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T59oNXAN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iey0DRna"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 82B23140009D;
	Tue,  7 Oct 2025 08:36:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 07 Oct 2025 08:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759840615;
	 x=1759927015; bh=xsI4cfS/H4EeLFApealE2vDRyp9PaD53gtK2lSMPW08=; b=
	T59oNXAN3QVS3F1m8VrZViqSGEQk3QQ42LG6SoX/sCJTwAz+3ILfJCB4JfVREnBh
	YezWyyCbJctu84SMUYs1cQoWqXni/Mh3qfvsCwxGP+aNCzG9IocjfuiryzKczJBq
	f8tS09y2ZO5x0RKJvY/+0I5vlCUum/GSdG+sOacU3z/5snyqH/o+PCdxS4NADEJU
	0B/JpMD/rIWjoo6rSMWlWXXd/QJmsQ6l9vA0J82DjNEg0F6IuQXxWQKes4CCnnLJ
	TMFScq8jYJXBVn2MDK2IZPJS12kMOwyO8YnyeuzzKHFFAg4BZTMgM8qUZqX4oCHJ
	2ynxyacuSVP5NCoJTB3t3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759840615; x=
	1759927015; bh=xsI4cfS/H4EeLFApealE2vDRyp9PaD53gtK2lSMPW08=; b=i
	ey0DRnaLNJhF66dcIR3AMJjQVB6yMk05GBcx6NJoSJyDkIv7JZfL+zYTP2SQRTL7
	NLVjqgB0FN/QYU5w/o3kze/4va2qwPBWWTb40wDbI+kv1swdnga9ALG7V+ecp7FR
	vvJBeJMRODJL07DcPolxZyic374GhrH1b4FiTRHxwuCCw0eJujebGz3SeC782a91
	tQkeCHGp9UJiqdMa8jRk99DSwHo94QcPfDffLsBSwvDajyj1dLLDOo6esh01qj4Z
	0ifwD3FG5WntXFhUjDR3309T/gr6bA2qxTgm6XeCSqTO1g7h866hQqi15IMK4lsD
	8+/j+pIMdW7U3wPUIHUtQ==
X-ME-Sender: <xms:ZwnlaE_E5CawiOGblvGlEuG9hejoY8L0gDV2GnGkKu1VHHksJKq6eQ>
    <xme:ZwnlaHSdhAA1qEwk4tZHsd3-lQRGYk0di6JfObV8R6l9HqUkoCV6LPXMdDNvYo4lP
    OY1NbnEQG6G2E7w-_zON0ZGkDG0SNbAo0WHytWORV8ILZE4kuUQ>
X-ME-Received: <xmr:ZwnlaGlQ_fV0o5fXhocyWUp_7ScXxI3HQlGOUd83au08cTWXUtDrAHTN4b-Ug9XUQpKHpMgt0qWwYoeLfs-_30eTIHwohFOCsO_sR1-oAns>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeegffeihfetieejjeelhfejveeigeehfeelteejtdeijedtvefgheeghedvleffteen
    ucffohhmrghinhepphgvrhhfohhrtggvrdgtohhmpdhgihhthhhusgdrtghomhdpmhgrvh
    gvnhdrohhrghdpvddtvdefudduvdeludeghedtqdhrrdhshhenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegviigvkhhivghl
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruh
    hsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvg
X-ME-Proxy: <xmx:ZwnlaHTIJi9UwzKRtLeydutVyNGZiDkeXRJs3HBa4OKvOCxYsWQidw>
    <xmx:ZwnlaEPfIZ2434_fyYmNSGvwSGdFmDQk2VavXa_xW1n9UDW6BDtnHA>
    <xmx:ZwnlaAVVscke3WMM6SgQ1s4blGCTvExsRj_LssyvK55i44D1so-3FQ>
    <xmx:ZwnlaLeXrAQye4c0pKCpHE65FQCgMLLlWsnXE-UibUm885kwQ0VaTQ>
    <xmx:ZwnlaKHtDqFckkP0sXvBrj1Hb_whcy80CZ1VRzi80xcfVt1y9om7MOBX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 08:36:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 381ac76b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 7 Oct 2025 12:36:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Oct 2025 14:36:33 +0200
Subject: [PATCH 5/6] ci: verify minimum supported Rust version
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-b4-pks-ci-rust-v1-5-394502abe7ea@pks.im>
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
In-Reply-To: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.3

In the current state of our Rust code base we don't really have any
requirements for the minimum supported Rust version yet, as we don't use
any features introduced by a recent version of Rust. Consequently, we
have decided that we want to aim for a rather old version and edition of
Rust, where the hope is that using an old version will make alternatives
like gccrs viable earlier for compiling Git.

But while we specify the Rust edition, we don't yet specify a Rust
version. And even if we did, the Rust version would only be enforced for
our own code, but not for any of our dependencies.

We don't yet have any dependencies at the current point in time. But
let's add some safeguards by specifying the minimum supported Rust
version and using cargo-msrv(1) to verify that this version can be
satisfied for all of our dependencies.

Note that we fix the version of cargo-msrv(1) at v0.18.1. This is the
latest release supported by Ubuntu's Rust version.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Cargo.toml                 | 1 +
 ci/install-dependencies.sh | 8 ++++++++
 ci/run-rust-checks.sh      | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/Cargo.toml b/Cargo.toml
index 45c9b34981..2f51bf5d5f 100644
--- a/Cargo.toml
+++ b/Cargo.toml
@@ -2,6 +2,7 @@
 name = "gitcore"
 version = "0.1.0"
 edition = "2018"
+rust-version = "1.49.0"
 
 [lib]
 crate-type = ["staticlib"]
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index dcd22ddd95..29e558bb9c 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -10,6 +10,8 @@ begin_group "Install dependencies"
 P4WHENCE=https://cdist2.perforce.com/perforce/r23.2
 LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
 JGITWHENCE=https://repo1.maven.org/maven2/org/eclipse/jgit/org.eclipse.jgit.pgm/6.8.0.202311291450-r/org.eclipse.jgit.pgm-6.8.0.202311291450-r.sh
+CARGO_MSRV_VERSION=0.18.4
+CARGO_MSRV_WHENCE=https://github.com/foresterre/cargo-msrv/releases/download/v$CARGO_MSRV_VERSION/cargo-msrv-x86_64-unknown-linux-musl-v$CARGO_MSRV_VERSION.tgz
 
 # Make sudo a no-op and execute the command directly when running as root.
 # While using sudo would be fine on most platforms when we are root already,
@@ -130,6 +132,12 @@ RustAnalysis)
 	sudo apt-get -q -y install rustup
 	rustup default stable
 	rustup component add clippy rustfmt
+
+	wget -q "$CARGO_MSRV_WHENCE" -O "cargo-msvc.tgz"
+	sudo mkdir -p "$CUSTOM_PATH"
+	sudo tar -xf "cargo-msvc.tgz" --strip-components=1 \
+		--directory "$CUSTOM_PATH" --wildcards "*/cargo-msrv"
+	sudo chmod a+x "$CUSTOM_PATH/cargo-msrv"
 	;;
 sparse)
 	sudo apt-get -q -y install libssl-dev libcurl4-openssl-dev \
diff --git a/ci/run-rust-checks.sh b/ci/run-rust-checks.sh
index fb5ea8991b..b5ad9e8dc6 100755
--- a/ci/run-rust-checks.sh
+++ b/ci/run-rust-checks.sh
@@ -14,4 +14,9 @@ then
 	RET=1
 fi
 
+if ! group "Check for minimum required Rust version" cargo msrv verify
+then
+	RET=1
+fi
+
 exit $RET

-- 
2.51.0.764.g787ff6f08a.dirty

