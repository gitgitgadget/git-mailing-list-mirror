Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C822C136995
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841621; cv=none; b=uWq69y9vif28XsRpzeppJdS5NbLscwq5MvLst0IkXx+ZPFsMWnMQWtWIMK1WJvKODBhrYtuEuw3Ijqg+kgxoA0rFZYokZEwtim9qYLTIh65Blrp8ZuGYY9zFlMXyfkB53bG3y9SAZORfDDx0nY+V1ZAIp3y1anKh2ssUvjTzAv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841621; c=relaxed/simple;
	bh=pvCshwbdcSP04PxPAa7JlJyYNBYXiJliQBi9/jVGihU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bwich1M0jxPJUAtGThGD3j3LEOeA9cfZdCz6pmVfXtLCKVoyqDx6fiEPl6WIZzWJJMGuSL0IqlwYY4QRI3DKI/qgOULKY0v5EbNWrxkYbA4dcnZdV4A3SzAISK/+vWtyqEgikDUYYFJ4i/8va1Luz2TXWK+XSsRO0AeiCK715XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=nG9/mQZR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I99D4qw0; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="nG9/mQZR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I99D4qw0"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C5FF11140186;
	Thu,  7 Mar 2024 15:00:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 07 Mar 2024 15:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm3; t=1709841617; x=
	1709928017; bh=V0VO/AgpcRW4zohvMkOJYQWFSfaMWX21lXTSJwLWmFE=; b=n
	G9/mQZRSpWIEO2gHWOgxXi58HTUUkbOOHy0YbIm/ix7RiL538vwSAjcxsPyATLqy
	P5J5ON/Klyt9op1dTG6Xfa0pwDNGEP6oRahDAe72CI5thOqAsSWL7PxfzPQ0cm3X
	9lyvIPpSMYQPZZqSf5nSKigCqPHhIy5exKAmDte4Eqoiq1QcuczuWkHFS/M2tGxV
	dUdnAflkRkdMFtkmuuqL3yugAYM7hoKgv1lOhleCi5XWMsso0R/umuVc+s9UFmZH
	AUdJo7sNrnqXln9UgX/9SrV979cKoP6D9F/b6uTi88ff4gDC0OiDdkw+2n7bPwkT
	U2qJ4RlUuLlIo5u92Ta8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1709841617; x=1709928017; bh=V0VO/AgpcRW4z
	ohvMkOJYQWFSfaMWX21lXTSJwLWmFE=; b=I99D4qw0yvlEqXIEi5A8SuDhWq9oZ
	k3bgUL1gWTeK5MW3LyqxDqzT/WoGQcYcsi2wy1a5Hb2ngpApFqnlQIqcS80L1cBu
	TnLiErliF/kuNORfK848rUD9aIq1C9GvMfpcquX26+A+5EuksDiQ5xZYN/opWWbB
	gp4BiESgt1wHCN0KCM4ASvOATXRZzJunX61GSOeSf92yEpFtG0PiNAH8b1jgLgtI
	bB6c7SCAoqPqX+CbgL87+uGAwowN1R9SitRSXcvhqxAa7k18q2Cnmgk9Du4qcpnd
	j3xp8huNPiiEsbcgl07zJ/uvg+0qeNTegkLhASFk02v7Fg4pMj/a6YAIA==
X-ME-Sender: <xms:0RzqZbQxgzTrvhv3X--VrUlo97lctlqn313sJCxOOxwzJ_-AoNay6cA>
    <xme:0RzqZcz9aWyd9P9R8nD0IJ3MhA7qGvhY0_K3uKw1WBq676m5L92KA5hFSAiaqsB-6
    eXYwz_1UNN-n3UBbQ>
X-ME-Received: <xmr:0RzqZQ2wljpv8pMv9mF-dFmyi2JX5-36TDwJCr9dfUbCWxwn_iMM4xqRzDJOBlq4BBVTLgfuQxZ8Jai8qFLfHNJv3mj22nQ3Yk3cWn1bgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgddufedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhepteegtdegheeiheefjedtlefhueeuieettdetgfet
    hfevveeutdelvdefjeehveejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhh
    rghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:0RzqZbAPNCuK8P1nSLtmKI5Sr4PjIIZx7yd9t908kXEhbMjczJxtRQ>
    <xmx:0RzqZUiSxn2ENH1W3kPWr08ylz1BgvO1Mp9S6aPSKPz1b8Ey0sE2Hg>
    <xmx:0RzqZfqUP8DFtlEyuM5XtNxyyDTEA8wZzyWiFstrskqrmjub111YoA>
    <xmx:0RzqZcexvNiz1Sdflf-zWzMh8A0CGPSyknG1DlsWwzOkr8jBmW-mbg>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Mar 2024 15:00:16 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Maxim Cournoyer <maxim.cournoyer@gmail.com>
Subject: [PATCH 0/3] format-patch: teach `--header-cmd`
Date: Thu,  7 Mar 2024 20:59:34 +0100
Message-ID: <cover.1709841147.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.44.0.64.g52b67adbeb2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

(most of this is from the main commit with some elaboration in parts)

Teach git-format-patch(1) `--header-cmd` (with negation) and the
accompanying config variable `format.headerCmd` which allows the user to
add extra headers per-patch.

§ Motivation

format-patch knows `--add-header`. However, that seems most useful for
series-wide headers; you cannot really control what the header is like
per patch or specifically for the cover letter. To that end, teach
format-patch a new option which runs a command that has access to the
hash of the current commit (if it is a code patch) and the patch count
which is used for the patch files that this command outputs. Also
include an environment variable which tells the version of this API so
that the command can detect and error out in case the API changes.

This is inspired by `--header-cmd` of git-send-email(1).

§ Discussion

One may already get the commit hash from the commit by looking at the message id created by format-patch:

    Message-ID: <48c517ffb3dce2188aba5f0a2c1f4f9dc8df59f0.1709840255.git.code@khaugsbakk.name>

However that does not seem to be documented behavior, and relying on the
message id from various tools seems to have backfired before.[1]

It’s also more convenient to not have to parse any output from
format-patch.

One may also be interested in finding some information based on the
commit hash, not just simply to output the hash itself.

🔗 1: https://lore.kernel.org/git/20231106153214.s5abourejkuiwk64@pengutronix.de/

For example, the command could output a header for the current commit as
well as another header for the previously-published commits:

    X-Commit-Hash: 97b53c04894578b23d0c650f69885f734699afc7
    X-Previous-Commits:
        4ad5d4190649dcb5f26c73a6f15ab731891b9dfd
        d275d1d179b90592ddd7b5da2ae4573b3f7a37b7
        402b7937951073466bf4527caffd38175391c7da

One can imagine that (1) these previous commit hashes were stored on every
commit rewrite and (2) the commits that had been published previously
were also stored. Then the command just needed the current commit hash
in order to look up this information.

Now interested parties can use this information to track where the
patches come from.

This information could of course be given between the
three-dash/three-hyphen line and the patch proper. However, the
hypoethetical project in question might prefer to use this part for
extra patch information written by the author and leave the above
information for tooling; this way the extra information does not need to
disturb the reader.

§ Demonstration

The above current/previous hash example is taken from:

https://lore.kernel.org/git/97b53c04894578b23d0c650f69885f734699afc7.1709670287.git.code@khaugsbakk.name/

§ CC

For patch “log-tree: take ownership of pointer”:

Cc: Jeff King <peff@peff.net>

For the git-send-email(1) `--header-cmd` topic:[1]

Cc: Maxim Cournoyer <maxim.cournoyer@gmail.com>

🔗 1: https://lore.kernel.org/git/20230423122744.4865-1-maxim.cournoyer@gmail.com/

Kristoffer Haugsbakk (3):
  log-tree: take ownership of pointer
  format-patch: teach `--header-cmd`
  format-patch: check if header output looks valid

 Documentation/config/format.txt    |  5 ++
 Documentation/git-format-patch.txt | 26 ++++++++++
 builtin/log.c                      | 76 ++++++++++++++++++++++++++++++
 log-tree.c                         | 18 ++++++-
 revision.h                         |  2 +
 t/t4014-format-patch.sh            | 55 +++++++++++++++++++++
 6 files changed, 180 insertions(+), 2 deletions(-)

-- 
2.44.0.169.gd259cac85a8

