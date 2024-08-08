Received: from cat-hlzsim-prod-mail1.catalyst.net.nz (cat-hlzsim-prod-mail1.catalyst.net.nz [103.250.242.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3E913D265
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 11:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.250.242.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116573; cv=none; b=St+q8DwygWYk50IviJ6DFvPo3WF0O1muMa02hkiihSZ1SkCuGyRbstPCk1tnCvgc9wJdb4WCyvZ+NgFv7Qg708teXE1wXu+yKQnMR/whqAdicF7jPiVg40ePS0PVcmwS4/MV+ixFtZ2aIpNkz4bj9skmZoA4Lar4iPp3EucIvtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116573; c=relaxed/simple;
	bh=sITQgpgrc05V0HzqYvZUKnmWoi7PBBgBW78RZ30CUmU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=dFGCPW7SWP1mixZowprb7WneDrF7GwuO2t2X8mo/nrIwMGq9rafjOk0R/QbNdXmjpYEbPias+37NTEP3JIMfcd1LVM38EXwLOShXJmqeePBwC+N7ltP3IT3rUTXkjEVy9nIgJf0PkL3jEmhBNxupY2X2EBsfXGsAChw2Sqgal9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=catalyst.net.nz; spf=pass smtp.mailfrom=catalyst.net.nz; dkim=pass (2048-bit key) header.d=catalyst.net.nz header.i=@catalyst.net.nz header.b=AH3G8szn; arc=none smtp.client-ip=103.250.242.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=catalyst.net.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catalyst.net.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=catalyst.net.nz header.i=@catalyst.net.nz header.b="AH3G8szn"
Received: from phil-lp (unknown [115.69.188.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: phil@catalyst.net.nz)
	by cat-hlzsim-prod-mail1.catalyst.net.nz (Postfix) with ESMTPSA id F17E24279F;
	Thu,  8 Aug 2024 23:20:25 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=catalyst.net.nz;
	s=default; t=1723116027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=IbDvh9MN8Wrg5wWLr87oC6Jcg8vfyXsPZ5eNZM41yds=;
	b=AH3G8sznf7N7G/kXbjxOZ2REAIcXJ8qzM8rW5LUY9vt4p715vrir7LCNMn7RQNz0Kci0Eu
	hUxnOGINt4kFBIe1VKtAtSEvm0x77kTbesRJrCRYKUaPEmtA/WyGZPBoBmW58eC22vmWxc
	jCVUq1XMCRer8ii4NpWLmAoQk+hA20HqAeW/YyyThrTYHeuqQ2SbgcAtLOQHczFQnOVaHM
	fLdbMoWjB6FED55UPdtdqZdjmEWaMkjJBPIoTaqECh/QwrF9xVB9d9ewPfhGDwDol+cmbj
	+kthlgdm4GSD0IWKvjuJl+bJKwPNXKL1M6yrcOTgDvoEW5Xd5jOVJW3FZLXLBg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=phil@catalyst.net.nz smtp.mailfrom=phil@catalyst.net.nz
From: Phil Sainty <phil@catalyst.net.nz>
To: pclouds@gmail.com
Cc: git@vger.kernel.org,hvoigt@hvoigt.net,me@ikke.info,rafa.almas@gmail.com
Subject: Re: Adding nested repository with slash adds files instead of gitlink
In-Reply-To: <CACsJy8CW1=Ea984s8J0Y6y4B6qJKZMdsXVFRQc8YcuoQNfXEqw@mail.gmail.com>
Date: Thu, 08 Aug 2024 23:20:18 +1200
Message-ID: <s5wr0azfeh9.fsf@catalyst.net.nz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.10 / 15.00];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[catalyst.net.nz:s=default];
	ASN(0.00)[asn:55850, ipnet:115.69.160.0/19, country:NZ];
	FREEMAIL_CC(0.00)[vger.kernel.org,hvoigt.net,ikke.info,gmail.com];
	MIME_TRACE(0.00)[0:+]

> On Wed, Jun 20, 2018 at 1:55 PM Rafael Ascens=C3=A3o <rafa.almas@gmail.co=
m> wrote:
> > On Wed, Jun 20, 2018 at 5:39 AM Kevin Daudt <me@ikke.info> wrote:
> > > What this is about that when doing `git add path/` (with trailing /),
> >
> > This is what I was referring to. If you search for 'Fake Submodules',
> > you'll see that some people were/are intentionally using this instead of
> > subtrees or submodules. Unfortunately the original article [1] seems to
> > be dead, but searching url in the mailing list archives leads to some
> > additional discussion on the subject [2,3].
>
> Abusing a long standing bug does not make it a feature. I'm not
> opposed to having a new option to keep that behavior, but it should
> not be the default. If you use it that way, you're on your own.

Was such an option ever worked on?

(I.e. a way to git-add some sub-directory 'foo' which contains another
repository, and have git-add act as if foo/.git didn't exist -- simply
adding the (other) contents of foo to the containing repo's index.)

I haven't spotted anything in the git-add man page for v2.34, nor in the
release notes for subsequent git versions.

The old behaviour was a genuinely useful ability which I've used a great
in the past, and if there's any convenient way to achieve the same thing
nowadays, I've failed to find it.  (One can temporarily move the nested
.git directory elsewhere, run git-add, and then move the .git directory
back again; but that's frustratingly cumbersome by comparison).

If I haven't missed some existing solution, could a new git-add option
for restoring this ability be implemented?


-Phil


> > [1]:http://debuggable.com/posts/git-fake-submodules:4b563ee4-f3cc-4061-=
967e-0e48cbdd56cb
> > [2]:https://public-inbox.org/git/xmqqy47o6q71.fsf@gitster.mtv.corp.goog=
le.com/
> > [3]:https://public-inbox.org/git/CAGZ79kZofg3jS+g0weTdco+PGo_p-_Hd-NScZ=
=3Dq2UfB7tF2GPA@mail.gmail.com/
