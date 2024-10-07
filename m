Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462AD18C932
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332174; cv=none; b=odzSxcc8TP9hp0xcrpOzbbWVuYip1Qi4SzRzzSVgx8grzE4gERRnigOyK8SEw23rXBfzFnwDC64MnvYq+s1B2j91YYUxz+xdDqYtbdnvaSdXDB5Y4E4SpdxzgARKnV2U2EXV4nMdEGR0fWdzFhgzGvYVHb9QqnFVu7dyvaMEwas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332174; c=relaxed/simple;
	bh=itOe7gB8U2GtV+3ZBYnRVOeomRllIJ4UxCWqcRIn/wA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WOn9vypc0RGQp9a1Ea72l+wa9UOZ9wPuPKg2KdeYPOriNuzNl54h+0bdC8z320UjtbjW8KxZGvxyjqqfgbAyJw78PjgLMsbIqxZDGW8RjAMhpHdJznjQPl3n0GdqC+ezjGavKCMD8kG/RV7Eqdyow7xLx/RisWkMfmhLxEgblgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=jSWoXaPE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BJw7nG2P; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="jSWoXaPE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BJw7nG2P"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 5430513803A2;
	Mon,  7 Oct 2024 16:16:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 07 Oct 2024 16:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm1; t=1728332171; x=
	1728418571; bh=I89n166pT0UFdvZYxyebTQwXw/PpRqvM3gF8ac/zfJM=; b=j
	SWoXaPE9vSB3x0tD5b8IxtbSiSr/AGfK0UN3YCaJIslAD+WyKtnv1oN3FNM3a6Eg
	IBG3rHzOIxsPcG/uts+KAp08JfMOpDNum0xZx25Ft+66HeJgxwXCOL/l7DZ+c3cS
	a+AYwTf8fg3EynBSNbYbkjkq8Ov7xDwJqiu8UTL2ubwrtam6FgryElKLq1S4sOuH
	eg9HXy/xGDN615RXcZA9Ab2t7sXoZff859S3A8bUxMi5rXRyL8IAiiQQNgoZa6so
	BMbWwVBgLj3ZbDOuBEQoGY0a0Opj1xwc6Yn7YFjTYiYY2y8I8keUk1bsu2jqpj3i
	BtTnNfcp0pe8XhRndXMQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1728332171; x=1728418571; bh=I89n166pT0UFd
	vZYxyebTQwXw/PpRqvM3gF8ac/zfJM=; b=BJw7nG2Pj+DTuuY+VSbWdwh8VwbS+
	+0VZtnTWuJRlD78UB842DC5Q7HtsPbrhWZie4zMpydNZ3u27gRcojlgBO6va6paB
	wNxXxUZNqIyobWDI5JPCgHyIpuhlJ1s7zAPX67orIc5wuKQlchWYw5dwtLFjqo8L
	4+jHzMgtsUetHpc/Uwlp1YEA6qHRD//I1pmdjTzpnFv65tsigXymW9eFMyZrs6bt
	iJ2qqZ/k4CySOS7Z5nbM11gQsGxo797IkMPguFTkUZhFeR/6rvgDHVDAeJyO4/87
	ggoR5w3lghL8oqmsftzWw7IEbBkjLhMMq2H6yMtxfHTAdCNGv9NgfnaYA==
X-ME-Sender: <xms:i0EEZ98UT1t7gBecUVIXJ7ZlDzHj_txcfEulKu13QZxrHxSONsMoLR4>
    <xme:i0EEZxtZ9tTCcrTG0k94lkTMn6zuOHyeZ4oTr_P38nufqWFZDBkTPjjMFyJErU4r-
    reiS79GkGtva0Ch_Q>
X-ME-Received: <xmr:i0EEZ7CKNocR3rJs9kplofO5iog_tQdzFOH4FbmTPlhHz5_IuvpPoiyJK10w3gXjyslDSIy_567HDpCXL_kOyiRPQ-CAh1utnqa45Z0D_ir-Oia0ji01RqcbmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgr
    uhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrf
    grthhtvghrnhepgfevhedtjeffledvheeftedtgfevieefteeujeevveejhfeludelheet
    ffdtudeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpphhusghlihgtqdhinhgsoh
    igrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggprhgtphhtthhopeefpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:i0EEZxeZ9lEkaZEBdW3OMqh1n0xiphitBBem7atMxEP0gzVaqtpuAg>
    <xmx:i0EEZyOdAcNHzde9ndjZFZiFXqmcxdB4Aqc96FaCJ_yyNi7c4pKlkQ>
    <xmx:i0EEZzn2BzKNXtWENFs6Mzpbr8qUFwCPePlHBRurNJDUPklP9MaeCw>
    <xmx:i0EEZ8udxFFDHomwbcJ0D8GOPcPa39QElwZQgNt-krgjKyLPLoSgVQ>
    <xmx:i0EEZ_qJ2UdTtelWn002XlU6p1z9Y_LFbY-bH6p47efdGK3iMrEXOX3q>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 16:16:09 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	peff@peff.net
Subject: [PATCH 0/3] object-name: don't allow @ as a branch name
Date: Mon,  7 Oct 2024 22:15:16 +0200
Message-ID: <cover.1728331771.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: 8262b81141bbd36cd7a17e6abe5eb6bb688290f3
Content-Transfer-Encoding: 8bit

I use `@` a lot for Git commands in the terminal.  I accidentally did
something that made me create a branch named `@`.  This puzzled me since
`HEAD` is not allowed.

Note that the bare/one-level `@` ref name is already banned.  So this is
just about not allowing `refs/heads/@`.

§ Research

This has come up before.  There even is a test which guards the current
behavior (allow `@` as a branch name) with the comment:[1]

```
# The thing we are testing here is that "@" is the real branch refs/heads/@,
# and not refs/heads/HEAD. These tests should not imply that refs/heads/@ is a
# sane thing, but it _is_ technically allowed for now. If we disallow it, these
# can be switched to test_must_fail.
```

There was no reply to this change in neither the first[2] nor second
version.

That series points back to a bug report thread[3] which is about
expanding `@` to a branch named `HEAD`.

Peff found a way for the branch name `HEAD` to be created While figuring
out a solution:[4]

> Checking "HEAD" afterwards means you can't actually have a branch
> named "HEAD". Doing so is probably insane, but we probably really _do_
> want to just disallow the @-conversion here.

So that was tangential to the bug fix (`HEAD` as a branch name was not
disallowed in the patch series that resulted from this bug).

🔗 1: https://lore.kernel.org/git/20170302082306.n6kfc5uqz2kdxtpm@sigill.intra.peff.net/
🔗 2: https://public-inbox.org/git/20170228121514.qajydm5bjdbzsucg@sigill.intra.peff.net/
🔗 3: https://public-inbox.org/git/20170228120633.zkwfqms57fk7dkl5@sigill.intra.peff.net/
🔗 4: https://public-inbox.org/git/20170227090233.uk7dfruggytgmuw2@sigill.intra.peff.net/

  §2 Disallow `HEAD` as a branch name

This was done later in 2017:

https://lore.kernel.org/git/20171114114259.8937-1-kaartic.sivaraam@gmail.com/

  §2 `refs/heads/@` is apparently disallowed by git-refs(1)

See `t/t1508-at-combinations.sh`:

```
error: refs/heads/@: badRefName: invalid refname format
```

Kristoffer Haugsbakk (3):
  object-name: fix whitespace
  object-name: don't allow @ as a branch name
  t1402: exercise disallowed branch names

 object-name.c                         | 5 ++---
 t/t1402-check-ref-format.sh           | 4 ++++
 t/t3204-branch-name-interpretation.sh | 9 ++-------
 3 files changed, 8 insertions(+), 10 deletions(-)

-- 
2.46.1.641.g54e7913fcb6

