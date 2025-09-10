Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA0321CC43
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512441; cv=none; b=C9WTtY8cZTEaxDWLlZGe3HfmzhOYtM+8DTsKbrv8lPvXN0INmy0k/Dbx4EproO9TfvAeFoT89X6stpNBKD8g7TtqUU5NuqH8uI+8Al2wOvDBlo/o3LrNyh0ROMhzjm4VPPxEI/LVD/w8FtfDGjOBOAC0sCX4Etv19GRa38w2a2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512441; c=relaxed/simple;
	bh=VM1nxhN6bJZr9AyxTDaEDFzDoNs31QtK3a2iGQsTyGA=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nupNg/gjVb6hMw37U5VotaMEMH9yMbr0Ai71RNrSjN7cv8exymI+GFHiGziFA/QxyuN2UiHus0/0G4CV+xGpSaswNeEnSEG9Z3UUYaj49Et7i9WBRYWu7YnPNQBaxHvPUOeXOzkidJpT2gUhioFMvzoHc10rPeUVep08kW4ZnSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kI/E+3Po; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JhzEVNy0; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kI/E+3Po";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JhzEVNy0"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CA1157A0032;
	Wed, 10 Sep 2025 09:53:57 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 10 Sep 2025 09:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757512437;
	 x=1757598837; bh=lOIxiKf0RY9Jl3ar8DkRI0uUWiZKfTZn0L2MZqHyoCY=; b=
	kI/E+3PoG+L7Dbc4mpJ1Tf2J0ZG6pi82IrNyNEOVFH44p41LM20R+nPglVCykIhj
	3VbB6YGMoaY3REIkncwL7OZTbYY9mZboDmzT0lNDQgTmE6vPdRF4ABVIh4EgFMqW
	twtqa4JlKm08JL+dYjZ4ORbEWwTS3ak70CczRp7sC0rELhW0ZAW/bH3cxIOpiEpM
	YSeXcd9Ae/Bt5jzXOxYInpYXl7YpDtbHf/1LMS7SPg0sIPN06ZRpSduaW7WedgU6
	qPiNJzctALwqOsApdwTG33dXkotb0SS0uE2OiMr9OcoaREat8nky1afVIkmMBk10
	NfgfcXex1bv9p9WWbZS+NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757512437; x=1757598837; bh=l
	OIxiKf0RY9Jl3ar8DkRI0uUWiZKfTZn0L2MZqHyoCY=; b=JhzEVNy0KFqYlbuos
	UU8ocN6LWBzldDV5lf2LJUof0m5kFyB1l4j5P52p/ms48zbpfeGjHNDfxceB40Qb
	AMxqNMVtmiCNgQsXyFYCDPzlWdHtj5SjCD2VpZwqfTlXbLHCJsPivjdp9aEfh4si
	CGhSYn2u4BtQzH0WqkFGU1RRnjNeQ6Ju3D1kX+9M3hAiSv3J9cGq1kGG/OjoW7yr
	KgbiZphDeY+TXsZxXZ+ElGX0bXTTfmX4GE3lQy43LBC0f78IE/82cScdA+8azNlR
	KT59cX7x+DedHYUKWGkVrwNORtVJeFjoIH9tupQvRT6t5CsGFjM5lRUPa6aD7y4N
	LalSw==
X-ME-Sender: <xms:9YLBaGel-dkpwqf7tCl_XTmIGfewKRRmqT2fqWt9xVD8MOpNWvbUtj4>
    <xme:9YLBaAMT0C5Ma1k1_pSfSWlMYE1p9fKf8355c-gOUV0Kk-545yjAf91wNtCklUtEY
    nogDBULpeMSN-8GAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthhqredtre
    dtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeffieeftefgheekgeeitedujefgveehvdevieelfeeiiedttedtgfdu
    hfejiefggfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsegtuggvshgrihdrihhnpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9YLBaGgyx4lBM899ZwOxA04lIYy_oU1IReAWxbWG-xaJbMSKFwH9UQ>
    <xmx:9YLBaP9jwDKxdGgenLpF9J2dZSDoS8D9lcmsvraRF2ZQ9JKKYANTYw>
    <xmx:9YLBaACZbWTT2LTpkpFXUM7hk5YhaIN7joQL29-u1_T-y02z1i4s4A>
    <xmx:9YLBaMLXtCHiGZwsdQwsXArq1KAB-NNeqRnp9LTMhOz21xNMBNcV0g>
    <xmx:9YLBaJgGJfIIkcRdvHTXMuL2Fj5V0uy6r-32Us4mBATrScvpNUk-X_kE>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6A35D1EA0068; Wed, 10 Sep 2025 09:53:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AtTCzMQMOxGB
Date: Wed, 10 Sep 2025 15:53:37 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Chirayu Desai" <git@cdesai.in>, git@vger.kernel.org
Message-Id: <0908c4a2-f934-4f13-a25b-696803260ab3@app.fastmail.com>
In-Reply-To: <b32a369f-87c9-41f6-b1cb-81273945dc17@app.fastmail.com>
References: <b32a369f-87c9-41f6-b1cb-81273945dc17@app.fastmail.com>
Subject: Re: Using command nominated for removal: whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Chirayu

Hi

On Wed, Sep 10, 2025, at 15:38, Chirayu Desai wrote:
> Hello,
>
> Hope this email finds you well!
>
> 'git whatchanged' is nominated for removal.
>
> I still use this command. I usually run 'git whatchanged -1' and 'git
> whatchanged <commit>' to quickly see what files have changed in a
> particular commit.

You can replace it with `git log`:

=E2=80=A2 Given: `git whatchanged <opts>`
=E2=80=A2 Replace with: `git log <opts> --no-merges --raw`

... with some minor output caveats about empty commits (commits with
no changes).[1]

=F0=9F=94=97 1: https://lore.kernel.org/git/20250825085428.GA367101@core=
dump.intra.peff.net/

> ... I usually run 'git whatchanged -1'

`git show --raw` should give a similar output.  Although `git show`
(with diff) or `git show --stat` are nicer in my opinion.

> I guess there might be some alias I could setup to achieve the same -
> it's more that this command has become a muscle memory at this point so
> I kept hitting the removal message, and here I am.

You can set up an alias, although not the exact alias `whatchanged` since
core commands cannot be aliased (or shadowed I guess).

An alias like `watchanged` would work.

--=20
Kristoffer Haugsbakk
