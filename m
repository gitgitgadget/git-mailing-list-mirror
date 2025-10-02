Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74297125A9
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 17:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425311; cv=none; b=MQWcqh2XtGywDD0czCsGKvMQUyQAXfe5isjNoD92N7rQoTNm28ncxBydoJBUXbLyosUblfZZtyiA94AIUIV0c2wZhrpjuC5a8BuAEv3AhNhQDHCfPuSrpBRkRvoaoF/VbRxjmKln7cbE8q1Up6cFiOB8TKS5t/TFyAst9ZGMPek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425311; c=relaxed/simple;
	bh=4qeVeMm7TZ9xtxCMEci3tY+kNT7OFqH4L2RlnZpGYD8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=S4nfODXT/+LQUlvTnrsk/L7hSWMp/jHJHg9PREMxWLca6WZ5MEfUimhoqnTBiBA7VQPsreAAr1glKOSgV6aQFFpB8kT+YwmXQuTlZpBwAOiYZ8o5zOhbZ5T+vM+lkWRxyz2eU3eJVZiZSnaPQOdjRa4o5khN4PDQ1k0d/fb51LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=hrLdUCQI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hRbfmwtC; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="hrLdUCQI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hRbfmwtC"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 351EA7A01E3;
	Thu,  2 Oct 2025 13:15:07 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 02 Oct 2025 13:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1759425307; x=1759511707; bh=NHM6RTPWlpeZtyD9tdT9VqE9boM8p2Iq
	cu8SR4tp0hc=; b=hrLdUCQIi1p0AzZXarviG2NfissiuTmzEHVYNoMrxe3VowPl
	Vj5ncrZvytEMcmdWe3+BGw7M/YV+h/GixOyXmN+3V+eDMyL1JrqdW3r7nsEXecN9
	nCesEYxC+QOcFOjQSHDO5LcrffilTyLs2t0FfACW5AKIibVVdzUvQXEXRnkXK8R3
	v08llJQWufQjbumSe+XpW/HkTS0vz2chWFoNXb9Mb9bFt7HtXKAskZ/6vu5voH+i
	LjDqS+2Z4RkaLh93ozTdTO71fPlekk2avKG4IEj+fVBWABwmvM5okuqMOuK0+E4W
	+fiftF3vn/HeqeLE49FCWofLi4zyjfs44nGROQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759425307; x=
	1759511707; bh=NHM6RTPWlpeZtyD9tdT9VqE9boM8p2Iqcu8SR4tp0hc=; b=h
	RbfmwtCxqhk6f+x5x4NC+eUSG7gZkDYRbajh+1HqAyQDyTnUNy8TtWa66UdFW4ZN
	NzdCGjKGm2Ht0uSlRLL4T9cHN/MkQsNr2hqu9vCuHdNDlV5H1M3dpAktVP8git6x
	sGH8MupL1pgu7ZxzHkixGDwsTZfwmP4RRrzV7/dHZqRkzt2qlSVutVXgtMbm/FUS
	oma0ixr4yJe9OZp0KW98P4LW0/ZQi0/Tpp1Skou+yraX1amNTtlHKS2+3VCA3pze
	MoVpcihcc+YutaaqTxBGS1gDEBn+u6Gp4x+Xr7BAR372Q4DfZXr2SWRt0Daicstq
	SrRfqFo+pwtX+qWqG8kPA==
X-ME-Sender: <xms:GrPeaAAmuT6okXlEGawrbtR15WRrjhP2izOpjWcHrIiB882NMrm3f4M>
    <xme:GrPeaNUBiPCHEJEH-1SucUZQSB5uFpBxd8agGTk6_887M0guHDHaG9VK4kNpP9ZRD
    thVUZ1ZXNRZqBZC4LKds6o1zb2P7kX2fGFisD59KNxonOFyR2y5EvM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekieehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeefteeghfegfeevleeguddvkeetheeiveffudej
    lefgudffffejleffffeludekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghr
    tghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsth
    hirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgv
    rhesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgt
    phhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehrhigsrghkrd
    grrdhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgr
    nhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhih
    hnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:GrPeaAkzFI6WyOXvM5N6KmDPIv1pJ92O_QxD-A2WVk2XmB2L7MBRXg>
    <xmx:GrPeaBYObrFXVZAjla_Rh2VLk38ozdeDFrzui8I0JKh1dkLzWiB1uA>
    <xmx:GrPeaN5ZVsOAhZ1si-M5UWEjNOeunkbxTIXNChuGI7CAAMGcLO2qXQ>
    <xmx:GrPeaDCJKEjwjthrC3O0Y-P5i6z7FUwjyVHOB4hnaf0d41KpcdpYGQ>
    <xmx:G7PeaGMfoB-0iwgJil7i-OS7-IJlO-plspZizo1dBhE-P0wS0wVa-Dbw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3E44D1EA006B; Thu,  2 Oct 2025 13:15:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AzP7wyaVJMbJ
Date: Thu, 02 Oct 2025 19:14:44 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Siddharth Asthana" <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Christian Couder" <christian.couder@gmail.com>,
 "Patrick Steinhardt" <ps@pks.im>, "Elijah Newren" <newren@gmail.com>,
 "Andrei Rybak" <rybak.a.v@gmail.com>,
 "Karthik Nayak" <karthik.188@gmail.com>,
 "Justin Tobler" <jltobler@gmail.com>, "Toon Claes" <toon@iotcl.com>,
 "John Cai" <johncai86@gmail.com>,
 "Johannes Schindelin" <johannes.schindelin@gmx.de>
Message-Id: <f0abdc27-6850-4b9d-b4eb-a1c92f731142@app.fastmail.com>
In-Reply-To: <20250926230838.35870-1-siddharthasthana31@gmail.com>
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com>
Subject: Re: [PATCH v2 0/1] replay: make atomic ref updates the default behavior
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025, at 01:08, Siddharth Asthana wrote:
> This is v2 of the git-replay atomic updates series.
>
> Based on the extensive community feedback from v1, I've completely red=
esigned
> the approach. Instead of adding new --update-refs options, this versio=
n makes
> atomic ref updates the default behavior of git replay.
>
> Why this change makes sense:
> - git replay is explicitly marked as EXPERIMENTAL with behavior changes
> expected
> - The command is primarily used server-side where atomic transactions
> are crucial
> - Current pipeline approach (git replay | git update-ref --stdin)
> creates
>   coordination complexity and lacks atomic guarantees by default
> - Patrick Steinhardt noted performance issues with individual ref
> updates
>   in reftable backend
> - Elijah Newren and Junio Hamano endorsed making the better behavior
> default
>
>[snip]

On the topic of changing experimental commands: I really like the
git-for-each-ref(1) (git-FER) output format design.  It just outputs ref=
s and
related data.  It=E2=80=99s not a command for =E2=80=9Cbulk delete refs=E2=
=80=9D or =E2=80=9Ccheck for
merge conflicts between these refs and upstream (git-merge-tree(1)=E2=80=
=9D=E2=80=94it
just supports all of that through `--format` and its atoms.

And for this command it seems to, at the core, output a mapping from old
to new commits.

Now, I=E2=80=99ve thought that a =E2=80=9Cclient-side=E2=80=9D[1] in-mem=
ory rebase-like command
would need to support outputting data for the `post-rewrite` hook.  And
is that not straightforward if you can use `--format` with `from` and
`to` atoms?  (I ask because I have never called hooks with git-hook(1).)

I just think that (naively maybe) a `--format` command like git-FER with
all the quoting modes might be a good fit for this command.  Then you
can compose all the steps you need yourself:

1. Call the exact git-update-ref(1) `--batch`/`--stdin` or whatever mode
   you need
2. Write a message to each reflog if you want
3. Call the `post-rewrite` hook

=E2=80=A0 1: c.f. server-side which I get the impression only wants to d=
o cheap
     rebases

--=20
Kristoffer
