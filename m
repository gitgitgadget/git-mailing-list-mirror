Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DD81E3796
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 23:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733268743; cv=none; b=biXM2tC70qylAH5JF0cqydpF6PlrSGiqGjhFOQRB4E3Q+wGsIYA04Fh6jFVNSUE2qXB9lhh2x00fYEtRp1WvX6zd6DEH67wg4MN5mPDcHLox8znWOdNYs99O5ffGkN/4dHlrZRjEqBY5vDaos5rZB2Ol8tjQLZk5+PVpDFEEzHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733268743; c=relaxed/simple;
	bh=M0yTl5ZZW4jQ/2+4NjogG2PRn9TeQB7BXedy+184eWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wzt0UJX4A+NS+0xeLqrx6nRDOs3qAlv0g25HwC6aHM3N8597JNoitJwKCI4rhGEdRAwVy04yaLa6LTaofPp4u32IvMFGN+D3Avq6yZODc6qGodLPo//A00TQl1AltVzCv7x4l7Ve5QigeItMMOe5w162y8PzB/CQFCIzX4VJdS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QJjVE3SB; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QJjVE3SB"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5F7A71140119;
	Tue,  3 Dec 2024 18:32:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 03 Dec 2024 18:32:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733268740; x=1733355140; bh=O+G9OVqA58UR0hjZB8/roNsmrE7mqChjsu2
	e6sRqv0Y=; b=QJjVE3SBH5b8gce1zcJsHv4hdWp3ugxqooaH2S6+Chg94j2z7EL
	5sydBSxD5N8Fn9+k6AWv34XmsALER/iRr+pUCH2/hMLZMLQx+qunqX3SEbuj6h8u
	ScGJbvrTv56KA9v7MaNPnTcxx/jZcIReZoHZ53T7i4IhZhVOo9WDoEM2Bu5HIAWW
	MD5ExTfhpbaCBp6XFb2+jMGgfA4ZlVIV+4YUtfZJP2vcsM+g6Jhgq6EVeVC2PaNJ
	2qJmMq3WisrGbHMoCRRlrOdghm6zsXeCjTDrdIXk7bDq+7OZRUrB3vg/p8dS6TXL
	hSURrOml43QUqE+9EbN7PAAufT2VNDWdyYg==
X-ME-Sender: <xms:BJVPZ69lER2JgtjFfFlKJWrIJpSluZns4UTsKDchqMJp99zg1ZUpYg>
    <xme:BJVPZ6uhDcmQPuL9ny-SrIaykNH14G6LjL1-Rp0DSn9-Uu9E7JoIDft2L8qIYdhBE
    OHyFpKaO1E2TQUUYg>
X-ME-Received: <xmr:BJVPZwDQESWGmK1U_BPQzxS7ZG2e4ZEPMasX1lbKGUSR6LSVXZ20FNqJ3bcIZgOmLHcF7kO_Wecvq6R9c-Bkuziw34gUg2lERVTE3eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeggddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhshhdrsghruhhnth
    honhesphhrohhtohhnrdhmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:BJVPZyf8WM6psC5O63mAVhIEh8mzs8ql1OuySBv2lUGw5QKo-EZFNw>
    <xmx:BJVPZ_MqplA60Aw-4fsLEup06P9wnRKHIDW_Ofg9JdSL0rHbgBXTxg>
    <xmx:BJVPZ8k3QXSIaQ_SZbbCJ-I83Zz6igluPWvqfvVMHuyN2f0YwIDrLg>
    <xmx:BJVPZxvozEXkAYqOA04nbpYduKHAPXVIzPnT6Vp3CfTXSPyiUdtnbQ>
    <xmx:BJVPZ4ptw0pACNJYO2My8toEX4VWIslG0bLIH65YVrhC2fC5BGxRyE2g>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 18:32:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Brunton <josh.brunton@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] Proposal to add a delimiter between unrelated history in
 git-log --graph --oneline
In-Reply-To: <FNUesYPDfyA16MXr4g9q7vW9OQ6bfbUK1umvVjONQNgEsQJZV5sIvRX9MlHfRILe4-hhINNy59uNjywL4abyJT43JVYjXU0ofUGWKQo0lFA=@proton.me>
	(Josh Brunton's message of "Tue, 03 Dec 2024 17:29:46 +0000")
References: <FNUesYPDfyA16MXr4g9q7vW9OQ6bfbUK1umvVjONQNgEsQJZV5sIvRX9MlHfRILe4-hhINNy59uNjywL4abyJT43JVYjXU0ofUGWKQo0lFA=@proton.me>
Date: Wed, 04 Dec 2024 08:32:18 +0900
Message-ID: <xmqqfrn49wcd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Brunton <josh.brunton@proton.me> writes:

> There is a clear disconnect between commits dec7d4c 7260dff, showing that
> they represent 2 unrelated histories. However, passing --oneline as well produces
> the following output:
> * e5698bf (main2) History 2 - Add SECURITY.md
> * 7260dff History 2 - Add .gitattributes
> * dec7d4c (HEAD -> main) History 1 - Add README.md
> * 3f25318 History 1 - Add gitignore
> ...
> I therefore suggest that a separator line (perhaps a blank line) might be
> added between unrelated histories which would otherwise seem related in --oneline
> --graph.

Please do not do this.

If you find this a good way to separate two lines of histories:

> *   15177d2 (HEAD -> main) Merge branch 'main2'
> |\
> | * e5698bf (main2) History 2 - Add SECURITY.md
> | * 7260dff History 2 - Add .gitattributes
> * dec7d4c History 1 - Add README.md
> * 3f25318 History 1 - Add gitignore

then something like

  | * e5698bf (main2) History 2 - Add SECURITY.md
  | * 7260dff History 2 - Add .gitattributes
  * dec7d4c History 1 - Add README.md
  * 3f25318 History 1 - Add gitignore

would be much better than

  * e5698bf (main2) History 2 - Add SECURITY.md
  * 7260dff History 2 - Add .gitattributes

  * dec7d4c History 1 - Add README.md
  * 3f25318 History 1 - Add gitignore

that wastes valuable vertical screen estate.

I do not deeply care if the '|' part gets blanked out until two
histories are merged, iow, 

    * e5698bf (main2) History 2 - Add SECURITY.md
    * 7260dff History 2 - Add .gitattributes
  * dec7d4c History 1 - Add README.md
  * 3f25318 History 1 - Add gitignore

is fine as well.
