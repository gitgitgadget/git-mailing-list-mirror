Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64ED134D8
	for <git@vger.kernel.org>; Sun,  7 Jan 2024 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemon.garden
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lemon.garden
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lemon.garden header.i=@lemon.garden header.b="rCAJqcwB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t693q34Q"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id F1D8A3200A32
	for <git@vger.kernel.org>; Sun,  7 Jan 2024 10:22:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 07 Jan 2024 10:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lemon.garden; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1704640943; x=1704727343; bh=Tkhzr5fiII
	aXfmn26CJfYnNCTMaanMKo7FTCQeWqrfs=; b=rCAJqcwBJXXdZhVGch22wvl+r/
	kQ26ETRrIpb114fs5D4vqZfyXHzOSY1VJqYPBw9XaewM8y1XEkfPT+v81B+TngLc
	pOBvPDoxNv0V/TLC2ipPy+irWzb3we2aQPlxrEkXouWuYTppwn+GNGkJuAYk+TVI
	edzvx68KqMrN8a/166qEycihgclgSsxy+whtSHsRm6aXrgAt5r0f+BDVYPmV/f96
	Kz+UID721BvnZ6aSNqGpY+pj5ocZ1VerAOejQRSxnVuQEheX+Xq0jvLW1HD7MlMU
	wJ7g/btyWAjFBkcpEDbmdLALlqLEBvpjRHSDzQ2hMan3pwbOe5h3SIulugRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704640943; x=1704727343; bh=Tkhzr5fiIIaXfmn26CJfYnNCTMaa
	nMKo7FTCQeWqrfs=; b=t693q34QvJI4nFZoHYJEQPKbx8j5Y2uc4KB5R+Hu5f6V
	nMY7FAbxwTLKuiGIdZFZqYgZwe3faoftI/WqlbRj5TZ/KpqxdJq20Zpdkh80plew
	nkCBeU3r1/kH9XScWo9AcQ3v6RgNdC6eb46gs3n/1JPihr2dDSNlzghmoinuFIJB
	Qygq70SWNPSwrazH/6t8CFOvf6K4U8b4cZOdjfuZbe571pi/4WlDgVgR0DQQbooo
	d1pe34wP9ePK4Dph/JSRq+vDUgMznF5oO9bdXUA5AkgR0dkwB5KQrw/WrTsPjHPr
	sFcaeQ0TrsAD2rZNsgA3aeNV19TnGF23HhU80rjUWw==
X-ME-Sender: <xms:r8GaZVLh-7GeYqB3YMQgzZFLzAlULSEY7BdsgRQxvwc_4M0D8nByyA>
    <xme:r8GaZRK4PDB4fIfSf20_WtNffxmwVAku6BgaCyOLRAo5iZqwcg_-rVsZupXP4_i7J
    T7-NOz3MtUkOWS7WWw>
X-ME-Received: <xmr:r8GaZdvjMluq73KXJzZxZ2e5CDP6aHZ3_2Tln4Z0r77mW5SP0Oxi51g1ARx5YU9IVFDXGCzjJdo5mYHJgTvosYUUfu2Jds4WnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehgedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhtgfgggfukfffvffosehtqhhmtd
    hhtddvnecuhfhrohhmpefprghthhgrnhcuofgrnhgtvggruhigqdfrrghnohhtuceofhhr
    vghshhdrthhrvggvfeeihedusehlvghmohhnrdhgrghruggvnheqnecuggftrfgrthhtvg
    hrnhepveekudekhfejhfduleffueelvdfgudduteeufedvheelkeetkeejfeefudegvdeu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhrvg
    hshhdrthhrvggvfeeihedusehlvghmohhnrdhgrghruggvnh
X-ME-Proxy: <xmx:r8GaZWYyKcqiCgtjIeaZKHSbzpzRvvpalU6BBdYZs9BPWpRHx0CYGQ>
    <xmx:r8GaZcbdHT2LYN-NBZhs4QSX7NM9tMIaWlBvdGZkAli2KuiUwF8tZA>
    <xmx:r8GaZaDtZYJWucKKQEKbXbU8TcFIiVL20i9me_dKvVNfWU_s0YwI8Q>
    <xmx:r8GaZS0bhSYhuaddol8bD7KS3QUngQGg9LbZARRmQ-CMajtYOjkgoA>
Feedback-ID: i28a14937:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Sun, 7 Jan 2024 10:22:22 -0500 (EST)
From: Nathan Manceaux-Panot <fresh.tree3651@lemon.garden>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Analyzing a corrupted index file
Message-Id: <B38C5D82-33E3-4D10-8119-7E0D59DD3DA2@lemon.garden>
Date: Sun, 7 Jan 2024 16:22:02 +0100
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hello all,

I have a corrupted git index file, and am trying to read it by hand, to =
understand what's wrong with it. Are there any tools that'll let me =
parse the on-disk, binary version of the index file, to unpack it into a =
human-readable data structure?
I found the spec for the index binary format, but reading it in that way =
is beyond my abilities.

For context, I'm writing a git tool, and my code is causing the index =
file to be screwed up in some unknown way. When it's in that state, git =
(v2.43) becomes inconsistent with itself:
- In the workdir, the file contains A
- According to `git show :file`, the file in the index contains B
- But `git diff` reports no changes!
The inconsistency goes away with a simple `git reset`, but can then be =
easily reproduced by re-executing my tool.

Thank you,
Nathan

