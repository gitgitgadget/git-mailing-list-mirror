Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E816C18BB91
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 11:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728299507; cv=none; b=b271XPJB06DSp2O293eM+/YwNsqZ8P0/Cm9RUtnHZ4hZCwcA6J03CSc2Bgl6A2FbhzqcoMeREpKIlCPutucUpj/xiGfGZue3LAftPQ17LYQz8H4MzmR8kE0EhIblxXNz0x+NeHZKGn6G+Q/000jmCMn2mavF7Pr9NiPr22aIS3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728299507; c=relaxed/simple;
	bh=fs3qLKFJtfK3dqSvDK9HC0nYSnMEBWM8rXAaLy0Vyqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UX3+LPWyweeP8+FYjFvBd7aVmoi+IRPbhDlQjS6L/CUrV7f9AOq/dgxsAPhhBax+YVphwPK4lmNOg2vl72gV4TWwpqp4hivjPvkMbBh6nUXomt2Ur5jaTIkl6K3TJmJwGIXPgwBUlUlxkvKSfmWZZDp7bc/6rTReNy1cmKwM0HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=SSFZqt/O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k7Rb1WK6; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="SSFZqt/O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k7Rb1WK6"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F2D0C11401C8;
	Mon,  7 Oct 2024 07:11:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 07 Oct 2024 07:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1728299504; x=
	1728385904; bh=NLwq5FczTksTqRNwXW5tFifv2GYcK5mpxf84BQ0RJaw=; b=S
	SFZqt/OjPFI45iuziqysEyepg9nwvp+9xZTMQFngrWuQ0bYxZXxjFVgGRnlRptb6
	C5JVmSRWNlfK71mVj3ol8rPxeAXg1khL4PqjkiUiY+J/0ywvXCuJoLVNnv0oBRqD
	C3BNCuc6IHY8F86osMqzhyLrlVA5oF/+xvmbCCGbx9I/CuzPJDhkWKnxHrfnz7FF
	41IpSpw3GHK75UpksneHsepTfLyo6CoI2WRlZNWOTCbnCx0leJ5Ib7c8KmkcnkYF
	8Ybaei04m5tA5UCiZvYxcz4tMjkWCewFzdvBmNi0k0rDEtNnkm7NcrXENZAsmff3
	CdtoYr7xWUai/MazixF2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728299504; x=
	1728385904; bh=NLwq5FczTksTqRNwXW5tFifv2GYcK5mpxf84BQ0RJaw=; b=k
	7Rb1WK6HYW/mJZvzUuSFSr6pMae25pXDtoh77Ln83HqXfHS72TLIA43ZICwjAB1U
	hn2LOy5YUwIIKjqHOc1Mijh/3oTk35fjnRm6G2Bhb7eXmxf8W6ELvjGJCx9OnyPG
	PMUwiTH3JRGmpMh7BpRSfJ/WnMrUQiQ6aM406DAxKF28hC2ysFhvMFaP1XtgvEGR
	HNG7fPZDpMapaatrKVMhT3n5PguJZYtd4h1g8Fonm/57xZL1Xy6GgBXVIT2QjgfT
	zWCZv32YEo4gxJwv5mvoXMu79AlKi7CdT6P9GvNBRV/hWYa0XnyEhFzxxG+uXpAX
	ZnrT+ajHgb+4s59cfDbpA==
X-ME-Sender: <xms:8MEDZz-N5Rvtrphf9RZqiGRf7Fr0f_Ptpy7zjaCTbUc9kVGkcZ6les8>
    <xme:8MEDZ_vZrT1JQdBTxSbyCs4jdWyoSxq3sngRr-uC3l3LjPPKRl1ZF8vY2RBn3Ek6T
    X5JLzXi4Jk7mivtww>
X-ME-Received: <xmr:8MEDZxCqoQlcvx2I7P34fbnBdMFX_WR2wcF6N5LiCTRFUW21ullGEtktu3RKVXRuOsenVSqrl17ilOwcPhyllzWtU4DvfV8VwJ-uMptG2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgr
    uhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrf
    grthhtvghrnhepteduieehgedutdfgudevkefhveduieeiteejhfffteeitdegjeeihedt
    hfejgfetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggprhgtphhtthhopeegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:8MEDZ_c0Q0T14RdMS936D3The6JJUJj5B8swkcqgQ1yz8uFRSYrJWA>
    <xmx:8MEDZ4M7K7QJqPVSs_0DXfGEne6szj0I_-aqqapLrDqdBfWJL98GFQ>
    <xmx:8MEDZxmlioUdDNCoauUCf_HHAYTfZSTdQyig6QUWEVP7NvQ-RcXgWQ>
    <xmx:8MEDZytTBsD0etJWNCrRGdKpwi7L85sZ-w_FGIIQ4QL4drocFURQYA>
    <xmx:8MEDZ1r8oL0C8UZRXt4BF0-ldXAi7Hoo7bfNc6qoMVAKnP4YISsu4heY>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 07:11:43 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	newren@gmail.com,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 3/3] doc: merge-tree: use || directly
Date: Mon,  7 Oct 2024 13:10:29 +0200
Message-ID: <4057d6386125e51fd934f92abd11c62a9d24a832.1728298931.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1728298931.git.code@khaugsbakk.name>
References: <cover.1728298931.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Commit-Hash: 4057d6386125e51fd934f92abd11c62a9d24a832
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Use `||` directly since that is more straightforward than checking the
last exit status.

Also use `echo` and `exit` since `die` is not defined.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-merge-tree.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 10f8ac7f80a..46091da022d 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -211,8 +211,10 @@ linkgit:git-commit-tree[1], linkgit:git-write-tree[1],
 linkgit:git-update-ref[1], and linkgit:git-mktag[1].  Thus, it can be
 used as a part of a series of steps such as:
 
-       newtree=$(git merge-tree --write-tree $branch1 $branch2)
-       test $? -eq 0 || die "There were conflicts..."
+       newtree=$(git merge-tree --write-tree $branch1 $branch2) || {
+           echo "There were conflicts..." 1>&2
+           exit 1
+       }
        newcommit=$(git commit-tree $newtree -mMerge -p $branch1 -p $branch2)
        git update-ref $branch1 $newcommit
 
-- 
2.46.1.641.g54e7913fcb6

