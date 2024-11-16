Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A5C184E
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 00:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731716118; cv=none; b=BweIWtdYG5+BAE0J46drhKK8PU+Won+3sXWQUlde3Tq4CKk02mu2hXkLBZGR1UCit8EMFCilvpYo16P0wUYsmCT8JVjRX1XAZsuhIdZMu4xgC0+uenqTPqS1gFeO603bB5maMs6kpwDi4b8iWJ6124vkDueMK3VgZxQucJbQE4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731716118; c=relaxed/simple;
	bh=XhtK3kTvfBoimJyg3iTTELSWWqmTSqw54rXY6iiJJ8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HSNpjYt2AOW39EVamIZJY6kdE+TltnbYvRa1AgJgwKFvzI8gw9VFZtzo/suw1YUbRHI5R7bVNRNcudKNM4sQdJtDD7ZmAY8y05I+t42myuVP0G5RtvEgkmyYnTx+UMfz/DFTUSEXc/9FwgW07JILjvSD+XFTln/nyHTSBSI0Rbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TkL02++j; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TkL02++j"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 4A7DD114019A;
	Fri, 15 Nov 2024 19:15:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 15 Nov 2024 19:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731716115; x=1731802515; bh=XhtK3kTvfBoimJyg3iTTELSWWqmTSqw54rX
	Y6iiJJ8Y=; b=TkL02++jI8aqwhLMMwb5eFHaONoe2afxIFW0pLHIg2aYSsQzBdi
	6cffKhYRU1boMpNEsPE/TF+b/Q7SGNGdc74hNDW8DlF0i6vU1H9bTVC64tAWROLE
	UK8l4y2cbeS2k8iumU8SZ/jIv2NjudGGldmDhy8lAnOUbH0m/jZABiqPZXQNm2Ts
	lg9gxFhcMn7gvaNxFC390RKnmA2HMQOTjN/FCMrsjWdzwYquZOXmXj06iBtS86Q/
	JB90052vqsIRbdjfPPIiUV2D8cy48bH27pOs0O4hmjoSrOrs+T81f2/YDABt7Pk+
	pK73SLzTr7lF0rCtnraBAhFBRX4gXZC8aHA==
X-ME-Sender: <xms:EuQ3ZzJ4shsukRiv4qkOy2D8xD1xUk9ouSXl8qTDUPD0mE1t-QYdlw>
    <xme:EuQ3Z3I1CJX2YCseJvEpPsNU9sHH0I4P7hYFuVRkMXH9QMrksx8YLDil1Rd-Pidja
    gBHozV4urQTzeuv1g>
X-ME-Received: <xmr:EuQ3Z7uF--zqxYETgozWvS_EuuyKbXwWZRpIHzQLGFM5C6o4Nt7LdTHPJsm53pruRrnlYOF8CuilSe3lM_-YJZ5sycTP1FEWyAck>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdehgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvghrug
    hinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruh
    hkpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepjhhohhgrnhhn
    vghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepfhgvrhguihhnrghnugihrdgsvghntggvsehtthhkrdgvlhhtvg
    drhhhupdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EuQ3Z8ZehZjiVyhmTkZMOolgdncogeKoqbS1w1GJ54bHiRu3ntSYAA>
    <xmx:EuQ3Z6YCuxJo9cpD7KG4UXnMdBo1c3tX2iyfNAuy28aZ5D0RUj9MuA>
    <xmx:EuQ3ZwDh7-Nkwzx9AS41OYdMxOrUmHRZz59JtfO-opYRYVClUQ5SWQ>
    <xmx:EuQ3Z4Ze5m9guO9XPgrMLfleMgf4xHYstG2KBYN55ieAfAhZhOBDaQ>
    <xmx:E-Q3Zwm9ZxNiTnKJ1FaF3ZSvdxPW96tiI7AJPR4zGeDAZ7DzYqSJzdm_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 19:15:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>
Cc: <git@vger.kernel.org>,  <phillip.wood@dunelm.org.uk>,  =?utf-8?Q?Ren?=
 =?utf-8?Q?=C3=A9?= Scharfe
 <l.s.r@web.de>,  "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
  <karthik.188@gmail.com>,  "Taylor Blau" <me@ttaylorr.com>,
  <ferdinandy.bence@ttk.elte.hu>
Subject: Re: [PATCH v12 4/8] remote set-head: better output for --auto
In-Reply-To: <D5N4B2SSZAG4.1O5CERCP825X2@ferdinandy.com> (Bence Ferdinandy's
	message of "Fri, 15 Nov 2024 23:49:33 +0100")
References: <20241022194710.3743691-1-bence@ferdinandy.com>
	<20241023153736.257733-1-bence@ferdinandy.com>
	<20241023153736.257733-5-bence@ferdinandy.com>
	<xmqqcyix11w8.fsf@gitster.g>
	<D5N4B2SSZAG4.1O5CERCP825X2@ferdinandy.com>
Date: Sat, 16 Nov 2024 09:15:12 +0900
Message-ID: <xmqqo72gyqy7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Bence Ferdinandy" <bence@ferdinandy.com> writes:

> Good point, and yes, that is what happens. (Although I'm not quite sure how
> valid that state is where a remote's HEAD is not a branch).

Not often when you cloned from a publishing repository, but if you
cloned from a repository for your own work with an worktree, the
HEAD at such an origin repository may have been detached, so it
would be sensible (I think "git clone" historically guesses over
eagerly to hide the detached HEAD state of the other side, though)
if the clone's remote-tracking HEAD reflects it, I would think.

> ... So maybe if we put "Not a symbolic reference." in the referent
> (which should be an invalid symref), the caller could check for that and then
> should be able to distinguish this special case?

Yuck.

Are we limited by the narrow interface that only passes "referent",
or are you in the position that allows you to extend the interface
to "do it right"?
