Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61B119D098
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492865; cv=none; b=HosxEsXTFiG6hxFN6J7ocG34QJYxpmdvHC7qGahRM0p2L4gNqzaBOFrtgnUkxvqhntbUekDsGlNc/DA+W0anFrAmH+TlZKQvvPv2aOPguTqSP2888lEc1mtCN5iy0UdfGTs+ps7nSCEO7iwtZFD9XxrDPmc17zQwLie8bvKh184=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492865; c=relaxed/simple;
	bh=wj1v3zjCm5OFyNt0Kz7JYg43ML7eNCWkE07m2OxQW/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7bbFWfyqqPhyZRxtvko6Sg82+Ee7U/LOjiPEeFpbfSB9ZEkNTrxnkTeEdDtzoeixIyMJ45pu+2o51W3qGH3V5he/m7SS0Jd9TqIotzjRjxJTtcmMUyMFWAqJsxSAYVzYiSPOnmGZ0vz4mI/JgTQcL8cUv7D8EGfrqfsEiAIeK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=lBhU9kdI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZPMTUZUc; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="lBhU9kdI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZPMTUZUc"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0625011401D4;
	Wed,  9 Oct 2024 12:54:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 09 Oct 2024 12:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1728492863; x=1728579263; bh=abz8UV+lytZ0RV75+W072HtjC6RrZ1Du
	akPLm34z3rg=; b=lBhU9kdI2D0PTri4NBX9yePjilKmZ1ePp/fR53IZkcnYT9gm
	HJA7wSB3CAso6dqBkI21rgkypfdQQQHrn0nuqXVnVVrjiDZj4JSDLOKwj2d97qrr
	RVlJFKJKeoMoGA6Wq0u8F3b0KmEStqMcQ6A73Wv/yTnBBPtWkTMT8qa7TEhPU5QT
	M4b1Sptbv0rAj0Mf3iT508acBdv3jE3uw67Wshh+dQgI3+fj6BNGz5sN7XGDdSHj
	T51u4ThxPRzF/Y1hvtn1FMWBP8q4iUjcorBUdWWezSKdIiAWfrA/Ym0VtE/Ditlr
	gaAkvPWbWTquTumdVGeyJBhpgA91aiAd5Fb3wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728492863; x=
	1728579263; bh=abz8UV+lytZ0RV75+W072HtjC6RrZ1DuakPLm34z3rg=; b=Z
	PMTUZUcEVuT3usq5p/H4P8+O9GHqjLTGauL/lZYMutWi4V73vTQGpAL7nGnnYRFg
	erGk9y9f2Rht2rKZWPbGUTvzf1suS7pVfw8MeqdxPEGORVuoUUFySKoLyq5qg/ql
	J5d20dG82otatoc1gV5vHajaRCGCD4JxA3T6zHZRMPg6bi3ViCR8GKwfenguTazj
	VRDYm50UHGOd998z/9OGgk2qNQpmymGOMiRBAx/7X5SloKjbek41WcKSOE37obgl
	J+kNMJ7gSRaJaUh8PFxFZfzmHgNDnARuH3ngNBuE2mnNR7ky00MLMoogfRzzL0Lq
	ifEdc8DW08SBtPpkSAbMg==
X-ME-Sender: <xms:PrUGZ9wOF7C5hTpvhHZK5UjARHxRl4qCKYkumbhRZKa75Pz_FJKFTNo>
    <xme:PrUGZ9QX8XPhEk7qBCPpaRC9AyZoX-xakQYXgV9ZqcTBR1BlJza4O2A-HtCpn2WVW
    rXbX1ERqI8tgMmTSw>
X-ME-Received: <xmr:PrUGZ3X137_MQJb4sLllKzAS2cA829gJYVJGS8a_RkQ8PUJo8nSUiM8GFlQj_S-UQQyFxtmjrmIyU_ZS0g-RgGW3wSYdDdIlrx11PEXg0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceotghouggvse
    hkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgfelveeikeeg
    jeeikeeuvefhleeiuddvleegfeekjedtkeevtdetgfffveettdenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggr
    khhkrdhnrghmvgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehsuhhnshhhihhnvgessh
    hunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PrUGZ_gMouuZ01ENEUTFTuJewREohplBNvUntkd-2737KzQou1_E9w>
    <xmx:PrUGZ_AZiizDuLjiHgwgwE7b7DEau3PW-iUxL9vu2GxoBCx58s9c7g>
    <xmx:PrUGZ4JHQZT5fNjyO5NqpCnIkWJbaol74VQ8yvKnzG7yvw7Bs_TY_A>
    <xmx:PrUGZ-DPf-B8RzQckcBHX4U33S9ysDw38Le7iSvrw7ZUaQ29ra8mnA>
    <xmx:PrUGZx3jFctJp12YmywzrvjQeKcfTxpkMfmgeU5Omfu4YVE9_ge0ZAjs>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 12:54:21 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>,
	newren@gmail.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v3 1/1] doc: merge-tree: improve example script
Date: Wed,  9 Oct 2024 18:53:45 +0200
Message-ID: <c7e0d76e71eef56c6279e0f7e82a2d194f78d2a4.1728492617.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1728492617.git.code@khaugsbakk.name>
References: <cover.1728413450.git.code@khaugsbakk.name> <cover.1728492617.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: c7e0d76e71eef56c6279e0f7e82a2d194f78d2a4
X-Previous-Commits: fef203471f4492af1468a0c91088324c394effd5 4057d6386125e51fd934f92abd11c62a9d24a832 b1ca5cae76845f84147d385cc5ff47f219cd471e 13e0f3bed5dd894ee692c672b301697e0a909e04
Content-Transfer-Encoding: 8bit

• Provide a commit message in the example command.

  The command will hang since it is waiting for a commit message on
  stdin.  Which is usable but not straightforward enough since this is
  example code.
• Use `||` directly since that is more straightforward than checking the
  last exit status.

  Also use `echo` and `exit` since `die` is not defined.
• Expose variable declarations.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-merge-tree.txt | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 84cb2edf6d0..0b6a8a19b1f 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -211,9 +211,15 @@ linkgit:git-commit-tree[1], linkgit:git-write-tree[1],
 linkgit:git-update-ref[1], and linkgit:git-mktag[1].  Thus, it can be
 used as a part of a series of steps such as:
 
-       NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
-       test $? -eq 0 || die "There were conflicts..."
-       NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
+       vi message.txt
+       BRANCH1=refs/heads/test
+       BRANCH2=main
+       NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2) || {
+           echo "There were conflicts..." 1>&2
+           exit 1
+       }
+       NEWCOMMIT=$(git commit-tree $NEWTREE -F message.txt \
+           -p $BRANCH1 -p $BRANCH2)
        git update-ref $BRANCH1 $NEWCOMMIT
 
 Note that when the exit status is non-zero, `NEWTREE` in this sequence
-- 
2.46.1.641.g54e7913fcb6

