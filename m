Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269BD1DFCE
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709492355; cv=none; b=Q+xQ8oHdC70w3SB57D1C85tAQSukOpD6ZV85T1iyIXcHOI9BXLgHw7aFjFm1e3IPD7ty4EG/Q+LODv4Dv7WlVt7uWnGHyt/x5gGA63kJ8HrhJsFksvigzkuSPJa0AkWI5hdCFn4GrIKXE6pl3U/qC++Qze/5rGZ5ESBG9WU3rn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709492355; c=relaxed/simple;
	bh=4Zjd+1vFjzBeFsXlv3NAl18JXBBN3I40IMW5IUSehgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=La8MTgeDtF+R5tuRF1iVqXHOUX7fjsDGqqPp0KoumkIQtWgqwgOtzyMpD9aobc/mWzty4J8WuqUKKXgHk5oD5qWeQpI6chR10rudbYfok/MOmwRDA5CwFv39ECBcwoKvsJOknNuwkLEN38vFCm/6MfAqYMmWmj16r9kEzwlr97E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=CHfqOxuE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NW3/QTV/; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="CHfqOxuE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NW3/QTV/"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1B84113800CE;
	Sun,  3 Mar 2024 13:59:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 03 Mar 2024 13:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709492352; x=1709578752; bh=cN85bFBfYZbqdAU3pY/f3bBh3ZOdn28m
	lksqy0kqp2k=; b=CHfqOxuEwG+ezmqSFJS8vNNXce9ux5zTiO7WK54y3aAbRkZQ
	WigJw61af+zBnYKkur6+AMKpGfstOlg4l3jusH0d0WcW/4a487Ooy3acssDrDA6/
	Z7Yi7QI/En2mJMWKolMUSMvDtIVMJGFzjIXPqzIS4FYjWRneEjcZuZiPTFMDgrF6
	1rZZbCxG0i/yqEMbYo1D4xkDNhY+oqWgfGitthHl2sYg5Ep+axotqDCT2IDRz+ru
	yABkZK/0CYJtaztaw8YVXCQq9k4byoSWlyAfrZtH1PfXowBmTVaYZFGoqNOP4yAf
	Bw+Fj9L7E+bWevEFtA2ug/nPspiYoyi1nDWGwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709492352; x=
	1709578752; bh=cN85bFBfYZbqdAU3pY/f3bBh3ZOdn28mlksqy0kqp2k=; b=N
	W3/QTV/tYJ+3gVtD2hnSq0hIyZugqf40/3EyUfxKqrhBmCBKMVLh7H9z00D1ruQ9
	rv2DevtOomYF0HS73uRGQE7OkCUFRoXS26flxiw1inQbEAeDTSye4yx85C/lwzwP
	2o6O6B14gecvyB/D9/c89Jlfu4NzO9c5/OdW/EzilJ80v6s7kI0jN2zcKythZVWW
	3xKamHMYVAeVl9JdHqFaCUnRf7ZbYTjZrOPRWLs71pJ+RfMgCk/0x9dTxwi9ZLez
	oEUziz6wPvIWV6SbeKkjIpYc0OvbliepEFEK/5DkFFswchJR4VoxLQFm9ACgB4Ul
	3silW8E6NxUvcydaxFtMA==
X-ME-Sender: <xms:f8jkZfWw2hsOLyYo5Xd75VrWY7vGp6c-_DorPgTRAjZ6uHIFEq0aTBw>
    <xme:f8jkZXmS6zbuateYlRWBAyMOzPC0uIafCqp-_7J3i2pf5h708umVFo3cCo1DCOzu2
    UM9b1W5ADiWe4L7cg>
X-ME-Received: <xmr:f8jkZbZr0vTm3w8PzCdEvz5B1yrtkIamKQLPeUtcAJYOo5mNQgCWCgoYCEP7_nHT3y_eoqLv_29PhRLzvXarAKrjkH_GyE01KVCtCPEVghLuXdxlaPb23lZdaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheehgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgf
    elveeikeegjeeikeeuvefhleeiuddvleegfeekjedtkeevtdetgfffveettdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:f8jkZaXMCK_zOOTXWBBIR7b_uzwBagstUbEMnam1to-LmjOvs7NYzg>
    <xmx:f8jkZZkk-2jlVyvMHP2G5iEhEkGjru8WUk7ZXw94Wzl-37nbC_6LBA>
    <xmx:f8jkZXenwkF76rMgBVMT9esthV_kgMHaRgzFQGXPgArjY733u2u1Iw>
    <xmx:gMjkZezLApIhvtcmeOhScyG9DxpDT-gp7415krXF6W4Itby-j-obKg>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Mar 2024 13:59:10 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 0/1] advise about ref syntax rules
Date: Sun,  3 Mar 2024 19:58:20 +0100
Message-ID: <cover.1709491818.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.44.0.64.g52b67adbeb2
In-Reply-To: <d275d1d179b90592ddd7b5da2ae4573b3f7a37b7.1709307442.git.code@khaugsbakk.name>
References: <d275d1d179b90592ddd7b5da2ae4573b3f7a37b7.1709307442.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Point the user towards the ref/branch name syntax rules if they give an
invalid name.

§ git-replace(1)

I did not add a hint for a similar message in `builtin/replace.c`.

`builtin/replace.c` has an error message in `check_ref_valid` for an
invalid ref name:

```
return error(_("'%s' is not a valid ref name"), ref->buf);
```

But there doesn’t seem to be a point to placing a hint here.

The preceding calls to `repo_get_oid` will catch both missing refs and
existing refs with invalid names:

```
 if (repo_get_oid(r, refname, &object))
	 return error(_("failed to resolve '%s' as a valid ref"), refname);
```

Like for example this:

```
$ printf $(git rev-parse @~) > .git/refs/heads/hello..goodbye
$ git replace @ hello..goodbye
error: failed to resolve 'hello..goodbye' as a valid ref
[…]
$ git replace @ non-existing
error: failed to resolve 'non-existing' as a valid ref
```

§ Alternatives (to this change)

While working on this I also thought that it might be nice to have a
man page `gitrefsyntax`. That one could use a lot of the content from
`man git check-ref-format` verbatim. Then the hint could point towards
that man page. And it seems that AsciiDoc supports _includes_ which
means that the rules don’t have to be duplicated between the two man
pages.

§ Changes in v2

• Make the advise optional via configuration
  • At first I thought that this wasn’t needed but I imagine the advice
    could get repetitive for typos and such
• Propagate error properly with `die_message(…)` instead of `exit(1)`
• Flesh out commit message a bit

Kristoffer Haugsbakk (1):
  branch: advise about ref syntax rules

 Documentation/config/advice.txt |  3 +++
 advice.c                        |  1 +
 advice.h                        |  1 +
 branch.c                        |  8 ++++++--
 builtin/branch.c                |  8 ++++++--
 t/t3200-branch.sh               | 11 +++++++++++
 6 files changed, 28 insertions(+), 4 deletions(-)

-- 
2.44.0.64.g52b67adbeb2

