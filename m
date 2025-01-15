Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE12D1791F4
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736960318; cv=none; b=qb0LZx8IKNdFAxVYsoU0eBVgBvvdu7wRrkx/boM4LOIsiaipi72zsoY8LducWNyW6wALEinShBmp/SKjoKxVx9PFDZ4inN3HZECq0EMUXi7Dzi/8IXab6LsfOd3JVB+hZqYF3qC+wea0ofqtyMxbyrZEBJI29++cAZKPhJe5Aq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736960318; c=relaxed/simple;
	bh=FgYnuJNQeLa3dZuLvo2siUEeoBDlCJhc815cFOynR+k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qHaq3z9oWoCKHD4JXKDL8SdHWRpmAYzlAnb3lukVUpOqJELoQpLg0A0BlzWv5BsLKIyoM2vRJepQHTCBfVK7lmHW807szUZp38A/x5sf93FSe17+dIafJCRUXWI7jhUiIvG6SKLt4aAHjv1BzKNruMpXVFkgNc+IwWnvCNPChpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=DglhnQyo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FICdIfAn; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="DglhnQyo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FICdIfAn"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id BC02F11401A6;
	Wed, 15 Jan 2025 11:58:35 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 15 Jan 2025 11:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736960315;
	 x=1737046715; bh=ep95veCX3mE1MhwfbWt+a4a/I2b3gDd6g6WM27DLHng=; b=
	DglhnQyosuK762zResK0RsoX3DVptJ34eyFK3WlxBOeNHMIldYYICuqTw4FEpdEl
	P7hHfqLfKBe8OpoPvralM1PsYcee68dfIimd1G4G11B6A1r7/58RAIznVygafMty
	nSnEvIi/xpzEl6FC369B89X08wkHrMyXNVbAMyj7pOUA6naSGXOxcJ7A7WaaneuF
	GclkyngFjZCzWJpDP5LRT9DN4T/9TOM+2i25IWD5MseoSks5BLC8WH3Gu/oui4Us
	QSH1LvIoZ9OO7pxfgltdcwqIfHaBCzql8v+ZroNHceFsKp46s9yhgaUWGX5gUt2H
	bjeoofeeTv80XCOQDPhhdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736960315; x=
	1737046715; bh=ep95veCX3mE1MhwfbWt+a4a/I2b3gDd6g6WM27DLHng=; b=F
	ICdIfAnm6VzYBoks55PzmlSyZGSRce4p9T5mHYFMn15qYSYLAy///i8DGbguCStH
	rpOZabB6zqForHgX0eFzjqqHbznVxEWfRcdExAk8AEiK4MU6fkCPR/AyN2EZDY8t
	TuFPVxtbbVXedIqCEhBFZI9AkHXDCoaj3HP2qa4c9VBSk2IsFSbG2wxE+rcxIA/M
	Maed+MJACRGH5CRQnS5Dcz8JDFTaEYaDQaBObimflMIerbM95XqHGB1yGcCC4lRD
	T3q0wRlw33/W3OB7Corim5Jq70O+6EXwLpeervpOLzD/rrznDmVP+evSReKQFj9r
	utF+jD7IsOsVazCBF9Hag==
X-ME-Sender: <xms:OumHZ5yWsNMzmzKFi47foybF87uVSqLg15c8SCWdc2lJeN3EZkLK_F0>
    <xme:OumHZ5RkRjHR6iHse46gddH76duHLs-JQLrumHqZJp6gTVvJ1n7kJIzPU_wMAQ4We
    TLIxYmfNx7jqBFhYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhepgedtjeeiteeghfeutdeutddtiefgvdegteektdeutddugfekleeugfelte
    ffjeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmtggvphhl
    segtvghplhdrvghupdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehjohhnrghsrdhkohhnrhgrugesuhhnihdqmhhuvghnshhtvghrrdguvgdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:OumHZzUjJkEIy7EBzHC-EjZGdWeKbzfc28EDH0O_wCtDwu1eR6Pfew>
    <xmx:OumHZ7gHnrCBnaEyStTPK9LvyGZK43MyWBX2tsvBqv3bY2THCTuzlQ>
    <xmx:OumHZ7BdHBh2x9YrMsn7BXiuj8j12u9mlJTO35PKOlSeElA-ZSXxJg>
    <xmx:OumHZ0KgZj9cOlnrt-Dj_xehMA-odMLbHIE0nKe3vHLRXSRZy_Sgaw>
    <xmx:O-mHZyMM9vZbKlRANIQhDW0YYnpJd1cVsCOJFrm7asRlV4fOStzC2fxW>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9ABFC780068; Wed, 15 Jan 2025 11:58:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 15 Jan 2025 17:55:19 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 =?UTF-8?Q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>
Cc: "Jonas Konrad" <jonas.konrad@uni-muenster.de>, git@vger.kernel.org
Message-Id: <c92e7b16-b70d-46f3-9858-2be805c5285f@app.fastmail.com>
In-Reply-To: <xmqqed1414gt.fsf@gitster.g>
References: <04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de>
 <D72M6S9O1E9F.WVEBV7ZJ1JTC@cepl.eu> <xmqqed1414gt.fsf@gitster.g>
Subject: Re: Git branch outputs usage message on stderr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jan 15, 2025, at 16:28, Junio C Hamano wrote:
> Somebody may want to go over "git help --all" and for each of them
> try "git $cmd -h >/dev/null" to find those that give the help output
> to their standard error stream.

    #!/bin/sh

    for cmd in $(git --list-cmds=builtins); do
        git $cmd -h >/dev/null
    done 2>&1 | grep '^usage: ' \
        | perl -pe 's/^usage:\s*(\(EXPERIMENTAL!\)\s*)?//; s/^(git\s+[a-zA-Z0-9-]+).*/\1/'

Gives

    git am
    git branch
    git check-ref-format
    git checkout--worker
    git checkout-index
    git commit
    git commit-tree
    git credential
    git diff
    git diff-files
    git diff-index
    git diff-tree
    git fast-import
    git fetch-pack
    git fsmonitor--daemon
    git gc
    git get-tar-commit-id
    git index-pack
    git ls-files
    git mailsplit
    git merge
    git merge-index
    git merge-ours
    git merge-recursive
    git merge-recursive-ours
    git merge-recursive-theirs
    git merge-subtree
    git pack-redundant
    git rebase
    git remote-ext
    git remote-fd
    git rev-list
    git rev-parse
    git status
    git unpack-file
    git unpack-objects
    git update-index
    git upload-archive
    git upload-archive
    git var

For

    $ git version
    git version 2.48.0
