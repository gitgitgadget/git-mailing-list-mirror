Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7851F21500E
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 19:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728414422; cv=none; b=j8mqVwBKW/rUZ1Eo3eIq9OrFsWSgQjOd25hQ1ML2xlPxLnLKJx/D2HbSRnaKejud0MR/W/640uuMQIWVWWAgy818oeI8Xc31nKWOlQS7ZVJjoNlU9w8B9LFqMQh6I1Nsa6HqGdtSsAfWdvPCuywb06imk1VR9XbDfqUFZcf5edE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728414422; c=relaxed/simple;
	bh=zCFdnW6t0qWGA9ZwS/ShqNE56OfMyY1C17q4RftwYp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=flQID3gtGGp1w94N9I5D403gjN+N6pC9HnDzsNI2AWm+qvBLdTV8CYT/IUSr/+HA4vmSA/Y6gH5/a0T9soNo/wpoRkkmpMEXO+bQ+PxE33mcBwlsSC39EoRu+CCxu9A3ym34G+mrmNumcScPfVaBAHJqI6c093shefwKcN0w2/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=JhlM9Os0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ODAk9be6; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="JhlM9Os0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ODAk9be6"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A6E5B11401B9;
	Tue,  8 Oct 2024 15:06:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 08 Oct 2024 15:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1728414419; x=1728500819; bh=ohG/QKOTA26PKP/Z3/iftCrehFXGPh1x
	LP9rYbZQcpk=; b=JhlM9Os0GxtcFNLmimU/JApzNP6qPkGEIhTN7THa31Bkq6+G
	6QfXckMYjXXBLk1D9iv5aFCZiXbW5ihbQqH0VpLlxkfqJ7N0juU9Qz19SxmWNkqx
	RNjZ45oBIj5dng0aoi9GJMg864poHs1g3KQ14a0Yi9Lq3FoQbcu4tEzWe24aZHc3
	SmneOE9WhL7Qlbto3VjqkDlzFEVLd3UrmsWijlD/rlk9/KYqfWbO5nB9RN00O0Z+
	MbNEP9DX302UfYZMyWtUJvLdyJBNg5IQBQYVGgZuiuVIHqo+3lhhiDHsVdq4JWwB
	cV6FutbFV7BMzCqIAt8McLtKLNQjSfuWpXg+PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728414419; x=
	1728500819; bh=ohG/QKOTA26PKP/Z3/iftCrehFXGPh1xLP9rYbZQcpk=; b=O
	DAk9be6wNAiOUwrnqy5peiQbAIebWsgNugsbSbFsaGdgHDkdMFq3K+BOnBV+Fhi9
	IFrBu97KkTMZbXEvHzmfr3thNkzRGxjR9ItXO+IUnA8HjsvvcMK82y9Gwq604Ua6
	P27Aeukzc2LKGv/WTkrooE6jkVRj8RwXg5pEQC60fQ1sWEQzj2wFy9I+GqUG9o/H
	2N2NaEL+ng+BTNtLmYZmmjM9Vj9Al1buq6DIFv6CHjWNm8/0+17L3Y7tEo1XfAyh
	r7yAj/v8ORQmTo37fLlhIOkDxmbHCJhL9+CJzcqYPzG0ZebR6POrPregmwYdcV/A
	NSS1IbxwbWf3OVKWJ0QjQ==
X-ME-Sender: <xms:04IFZ9eydwBj30O5gCMU3A97iMtqJUFEJhcwKiKSMx_X5H0ZP2emhb0>
    <xme:04IFZ7NrzlX1Dnl9qQDPAwD5rp9kj3zgpebpelwy4--9XC5L1iIjiG-LM-lN8L7q3
    50zmkRVZIMIb1sGLA>
X-ME-Received: <xmr:04IFZ2gFC3gwv8ddYgkGGOAo0U29j1umyx2MHDsjvA5Ub4zUnM8NZbBEs83XhDNvyXD6pBqLWmdULq0xF885owMDwEqaFVXWG2cXmnU9Ct0FBR87Y-0PBIJy4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceotghouggvse
    hkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgfelveeikeeg
    jeeikeeuvefhleeiuddvleegfeekjedtkeevtdetgfffveettdenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggr
    khhkrdhnrghmvgdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehsuhhnshhhihhnvgessh
    hunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:04IFZ28pUHTeiIGrtD4FnhCXfTh9Gdj_jJNHYvSyapcrIprsynHJGw>
    <xmx:04IFZ5si8ztlwG4HnS6h2u1fvIDtHaKOGIM71YN4a5mUjwcTZMo7ag>
    <xmx:04IFZ1GaZ8mHSfpC6gODHhNZQS_E-ZzmStXaz0eXUQNkuRjfrbVsYg>
    <xmx:04IFZwMMC8neupqgTB5y4eoagMR8exuIqLxV-vELlXKm-gsHhNv6KQ>
    <xmx:04IFZzL4QrVeNQLKZQ9CFR12phacYPMxua1ysyL9rld5iJTMndpLTwNW>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 15:06:58 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>,
	newren@gmail.com
Subject: [PATCH v2 1/2] doc: merge-tree: provide a commit message
Date: Tue,  8 Oct 2024 21:06:05 +0200
Message-ID: <b1ca5cae76845f84147d385cc5ff47f219cd471e.1728413450.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1728413450.git.code@khaugsbakk.name>
References: <cover.1728298931.git.code@khaugsbakk.name> <cover.1728413450.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Commit-Hash: b1ca5cae76845f84147d385cc5ff47f219cd471e
X-Previous-Commits: fef203471f4492af1468a0c91088324c394effd5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Provide a commit message in the example command.

The command will hang since it is waiting for a commit message on
stdin.  Which is usable but not straightforward enough since this is
example code.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Unlike on some other manuals you probably won’t end up running these
    commands directly to test things out.  But you might end up copying and
    modifying it when playing around with the command.

 Documentation/git-merge-tree.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 84cb2edf6d0..d1157f1398a 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -213,7 +213,8 @@ used as a part of a series of steps such as:
 
        NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
        test $? -eq 0 || die "There were conflicts..."
-       NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
+       NEWCOMMIT=$(git commit-tree $NEWTREE -F $FILE_WITH_COMMIT_MESSAGE \
+           -p $BRANCH1 -p $BRANCH2)
        git update-ref $BRANCH1 $NEWCOMMIT
 
 Note that when the exit status is non-zero, `NEWTREE` in this sequence
-- 
2.46.1.641.g54e7913fcb6

