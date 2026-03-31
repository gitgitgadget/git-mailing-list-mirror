Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBE23AA4E5
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991888; cv=none; b=hV40XIWEWd/Fnsll8SDQ2yVH7vkmtEZnNRKOZIFYA0odRhc5IfrfIFYHr1jVqo8budaLDJgHkgOuPfi1Z4GNI09W4OfyfA0kwNTK2/l2uD5CTrTcZPkdTwjH2yA8XxKr5ueRjapMcxpH7BbL1lAA5zES3mWyj0R7ozRCWIQe8P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991888; c=relaxed/simple;
	bh=vra4MycNKL6lwLnXhZS7XziglbzDppGLBWpVqJ3Nz98=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DhR5Nr3m81Ress1v/tBXamYAXhF9bWcXZoDVBCX/eV53l/4vS+Nz1Aw/rsXSBPDbLembzf03TtKWnqMNiYwncES/SGt8ksPlOgmYhldFqXfiyIZCGfb11fGaNxokW9dp6hSMBOtWqgWAf9AaAIHa71o8ymXAqKAixiBdi7pQ3XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=QZ04/oL+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IeJvzjb1; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="QZ04/oL+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IeJvzjb1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6B89A1400226;
	Tue, 31 Mar 2026 17:18:06 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 31 Mar 2026 17:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1774991886;
	 x=1775078286; bh=98oJfHK36WdQO9dh9f5gYZFsAkwIGvbck2M2o6yJXDo=; b=
	QZ04/oL+bbMwCufXQiMEZPAyFDEbNUUPTq5io1vSqej1pzd8G+BFaMnIbXsMsWF6
	EPe5guqcShHGfI6gETuvFm2eOQEX7wyu5BWZYfbML1karKIj4/cQDXBQFQdlR6Bg
	E8wA8j3Mmd+sqUilMxS7+dakoeq5IBNeUn2ruyZfeunCc8XC/iM9n5yzN2NwdCKG
	zMOct/nSoWItz1EC0irZ6pEmclASc+3hUU+IXYBdSwEZ6m9Icvl7r3YHQ4WQPmCE
	0bnOe+23E5OsIBBmNKt5tab0jh7HWwVDQeSLNm4r2pujO9tQVggbmROFHxn9FFDX
	5wYcoYDnXnKYRmgIVvDw1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774991886; x=
	1775078286; bh=98oJfHK36WdQO9dh9f5gYZFsAkwIGvbck2M2o6yJXDo=; b=I
	eJvzjb17ntqcknm/Ci7IpU99PSHoQxSgVbVgv6qwgOQTY5NDJJtQ3TfJU2XubOKx
	pOUvVT44tUsMfKbmecAIbozPdD3SokyaShneemMlZiLh77kqdT27XASk5i1ngljG
	IzxpgTeAY6HbNr44mKapGMB3ESlOgesBRk8xTfDjMMDI9FG9qPX4auhT5hgeyoYF
	ldUCzG2F9YT4NfJlX9LYjPiySJmwAI+gKiS69OX1JCp8hTJkmaCdJ7g1hsdsqlW6
	ly0Ax+nSHrJmwd1dqVMGZGdmGdyYh+nIj2wiuyjqelHBZfdkug3uaQUfyD/ILRo3
	HHW3Tfzt+dkZoLgwLu9ZQ==
X-ME-Sender: <xms:DjrMaS40u5fFFx_V8plMVw9Pxaz2gx99bqHzX2wN1G8mH3gXAhRPFEA>
    <xme:DjrMaWtfjaXOhqFUA-W4CJjuULh2LmD8YNRNqKFwBt50UBn10d55yspAXHyjC5hGs
    o4CqJEjb_dV77QqNrMEDkJmwxvPHOGPMPqAbLIgw51nAgGwU7aSaNM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeegjefh
    heeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:DjrMaZVbsEkLRE0KIQgoKIqGy0FYmIFMwZMIRZ00jIO1agroTDm-4w>
    <xmx:DjrMaRVghV5GKGu0hiZbKK50wnBsbJZlRChFhEgEu78K_mBB34AWtg>
    <xmx:DjrMaYdC2kaMeBmm7PUtSn0zLtLG7p0Kg4nQVzIzdyR2VapSKev46w>
    <xmx:DjrMaaUeubMq6UZtfMglSTv7HVQolzc8XurG0TFeobEGMMH69_2N_A>
    <xmx:DjrMabM5maRWnCoY2j4GRWjsTVEiyqQ6dBstcQ5Zd7WfNyRi3R1UviZX>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1ECFC1EA006B; Tue, 31 Mar 2026 17:18:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AXwrXeGRuldw
Date: Tue, 31 Mar 2026 23:17:45 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <c93728fa-1d02-4b86-99e8-dcb5d8b74ac0@app.fastmail.com>
In-Reply-To: <xmqq5x6bzox5.fsf@gitster.g>
References: <CV_doc_deprecation_config_--list.54a@msgid.xyz>
 <gitcvs_doc_link.54c@msgid.xyz> <xmqq5x6bzox5.fsf@gitster.g>
Subject: Re: [PATCH 2/3] doc: gitcvs-migration: replace config -l and rephrase
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026, at 23:09, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> diff --git a/Documentation/gitcvs-migration.adoc b/Documentation/gitc=
vs-migration.adoc
>> index 1cd1283d0f8..905d08cd5f9 100644
>> --- a/Documentation/gitcvs-migration.adoc
>> +++ b/Documentation/gitcvs-migration.adoc
>> @@ -49,8 +49,7 @@ them first before running git pull.
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>  The 'pull' command knows where to get updates from because of certain
>>  configuration variables that were set by the first 'git clone'
>> -command; see `git config -l` and the linkgit:git-config[1] man
>> -page for details.
>> +command; see the subcommand `list` in linkgit:git-config[1] for deta=
ils.
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> OK.  In this step, "while at it" change is also sensible, unlike the
> one in [1/3].  It wouldn't have been time-wasting if you sifted the
> patches into "genuinely, move away from -l and to 'list'" changes
> and everything else, as the former we do not have to think, while
> the latter we do.

Okay. That=E2=80=99s great. I am far to the side of separating changes i=
n terms
of personal inclination.

I=E2=80=99ll split the -l/--list change and the While At Its.

Thanks!
