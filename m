Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C353C18AE1
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadavpratyush.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadavpratyush.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadavpratyush.com header.i=@yadavpratyush.com header.b="fIxXKxV3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QWOfT5ny"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id A320B3200B13
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 14:08:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 15 Jan 2024 14:08:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	yadavpratyush.com; h=cc:content-type:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1705345695; x=1705432095; bh=/cIHtvorbt
	bMbP34R7WMIon6wdsIZtEoDafHshsP0IY=; b=fIxXKxV3PINDaeGqHRVPUTNmTf
	0SNC5ZbEsMb4IERIGwXH4LS17WFVUmAHezGQzddHa+rlbik5O6K6Qf5vXpEuXOr+
	st2bZ8vAdicVu2V468OCE9zB3lwEWRp9dL0QJXE+WYkLhaenJTLxEKYehWM3DsfE
	DWPCYHfpKDcFT/hKx/0anUG8kLBxJkup0GISflGN4WfbRSz1JYahiuGAUGU6wYv6
	D0Gv4JgRSNBvDt4eOlwTWlpaDBe1tjwGklmeADwhd7DHtyJwoIAflAvwsIen+Qdh
	N6w2Q4YnmVDSCfUYlYeJX71KJqPknpX1iSebo9nwJoXwbDwBVt8sOgTqG9iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1705345695; x=1705432095; bh=/cIHtvorbtbMbP34R7WMIon6wdsIZtEoDaf
	HshsP0IY=; b=QWOfT5nyFFNEEVOGGyy7d5aa4HoQiCJ+hqi3xkNS27PUbstvjzq
	QfwVL6DzexuVjI8TrQDHPu7KdgCeO8bO1PI+039NMlW8McK8CNy1auzMpnz9po3e
	up7dY6tw4f+Nk3hny5mIqu0Ft98FUpwrqfJ81zBCBUgMjuEfUy/dTxbBCm7fekbQ
	WuRt+j1TjUYZHuRcTWof95EgzfKg0t3VqfVf5IcYYbpO5FCM1FjAc3sIMOfUNS04
	fU3ukqM4acSxTNQ8NRjQaaeCL+D0jpM/xFZLzlZd2qgjNu8x6Jxb0kbHjSqIfrHD
	zQERJ3uaiRrA0bHjKVVhn4LAorRQjuxx3uQ==
X-ME-Sender: <xms:noKlZQnvYoY11xuXP6XBXunjdAvSmEo-ZHyfUmqpeQOT2_XeGABvCw>
    <xme:noKlZf34I40WBOW_Vxi8NbkrdgUgf7uN-gb0--szbqKHEJonLdjNhMKnAHgFhaQhg
    mMSg5qKDwwKZFjIBNA>
X-ME-Received: <xmr:noKlZeqpoFA1wBB9OEhQ3aHokReAPCXExXuwbx8q6WEPPAKpSEqTn60jMTLSYyR6UrtKS0IaXbDHLb-S7OsxrclFCRnXBg8vlTv43wKDcNq-RFh5HXkIF2R84K21i8zmfHIz90SZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejuddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefrrhgrthihuhhshhcujggruggrvhcuoehmvgeshigruggrvhhp
    rhgrthihuhhshhdrtghomheqnecuggftrfgrthhtvghrnhepkeeugedvhefhhefhieegvd
    efteettdduleefvddvteefvefgtdefteefveduvdffnecuffhomhgrihhnpehgihhthhhu
    sgdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepmhgvseihrggurghvphhrrghthihushhhrdgtohhm
X-ME-Proxy: <xmx:n4KlZckArIHRfAgIvP2SlmQKdVszkLnArkrceS48pVUIwKdjvlig7g>
    <xmx:n4KlZe2vgAJsj9-o8ADB5LWe2_Cb7CtP9qs7RTU0cwI7Ct5RN_ICLQ>
    <xmx:n4KlZTtyPOSosSiMBzrCNdY9ij3UYt3s7lZ-kKN3j3mmgGNXfswwrQ>
    <xmx:n4KlZXhunRgAdAwel8ybM-ge0jnXJm6CGlNbKVSCFU95fVyhcm_yVw>
Feedback-ID: i93f149c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 15 Jan 2024 14:08:14 -0500 (EST)
From: Pratyush Yadav <me@yadavpratyush.com>
To: git@vger.kernel.org
Subject: Strange behaviour when pushing a commit object to remote's refs/HEAD
Date: Mon, 15 Jan 2024 20:08:13 +0100
Message-ID: <mafs0fryypg82.fsf@yadavpratyush.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

I ran into a strange Magit bug, where when I ran magit-show-refs on a
particular repo it threw an error. The details of the Magit bug are not
very interesting, but when attempting to reproduce it, I also saw git
misbehaving for such repos.

The strange behaviour happens when you push a commit object to remote's
refs/HEAD instead of pushing a symbolic ref. Such a repository can be
found at https://github.com/prati0100/magit-reproducer. I roughly used
the below steps to create such a repo:

    $ git init
    $ echo 1 > foo && git add foo && git commit
    $ echo 2 > bar && git add bar && git commit
    $ git push
    $ git checkout 79264c3
    $ echo 2.1 > bar && git add bar && git commit
    $ git push origin 707a3d5:refs/heads/HEAD

Now with such a repo, if you do `git log --all --oneline` it would look
something like:

    707a3d5 (origin/HEAD) 2.1
    86e1c97 (HEAD -> main, origin/main) 2
    79264c3 1

And running `git for-each-ref --format='%(symref:short),%(refname:short),%(refname),%(subject)' refs/remotes/origin` gives:

    ,origin,refs/remotes/origin/HEAD,2.1
    ,origin/main,refs/remotes/origin/main,2

All well and good so far. Now delete the repo and attempt to clone it.
This time `git log --all --oneline` gives:

    86e1c97 (HEAD -> main, origin/main, origin/HEAD) 2
    79264c3 1

And running `git for-each-ref --format='%(symref:short),%(refname:short),%(refname),%(subject)' refs/remotes/origin` gives:

    origin/main,origin,refs/remotes/origin/HEAD,2
    ,origin/main,refs/remotes/origin/main,2

So suddenly the remote's HEAD becomes origin/main (symbolic ref) and the
commit (707a3d5, "2.1") is nowhere to be found. It neither shows up in
`git rev-list --all` nor in `git log --all`. The files and trees
associated with it also do not show up in `git rev-list --all --object`.
Yet if you do `git show 707a3d5` it shows up. So it does exist and did
get cloned, but git cannot properly see it.

Interestingly enough, even the GitHub UI is confused and it won't show
you the repo correctly. It will show the commit (86e1c97, "2") for both
"branches" main and HEAD. cgit's UI [0] seems to work fine with this,
though cloning from cgit still suffers from this bug.

There _is_ a way to clone the repo correctly. If you do:

    $ git init magit-reproducer
    $ git remote add origin https://github.com/prati0100/magit-reproducer.git
    $ git remote update

Now if you do git log --all or git for-each-ref, you see the correct
result.

I don't really know how to fix this but it certainly is a bug in git
since it can't clone the repo correctly. And at least one major Git host
can't display such a repo properly (I haven't tried others).

I used Git v2.40.1 to do most of this but I did compile the latest
master d4dbce1db5 ("The seventh batch") and attempted to clone using it
and I see the same problem.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/pratyush/magit-reproducer.git/

-- 
Regards,
Pratyush Yadav
