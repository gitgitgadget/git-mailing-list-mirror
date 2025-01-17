Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC181993B1
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 18:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737137382; cv=none; b=p3aFxIlcqjmAu2WWzQFHtDmtlAul2/B4LVUa0dr6/1tY2ADKfVnPPsnOctJbpNV3FqRRQwkyV2euYeTqSAKYqn1yxAu+W2GsibKZPCJC4DSNVKkaGXpCkvoBBZS1kBPswScKBRJvrzIBxKvjrPE8o/kMEVouvHF6Kpsl1T2WMOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737137382; c=relaxed/simple;
	bh=PNvS7tqdqilnpG9jbsf//g4K/S5U3CQSG4N3aeXwM5o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WkjIkb9asmYUA8jvopk0DvLEVMu5MkaZjNlJFE7A7C6xbEbljgCg22v24372spqhuvA+Ox5JsSfG4W+1GNNPen6HwH3MuYVIEkVwSR95OWcpO4iEDXFxEzH1aOWeuVHbcH8tujak6RaimohxENwzUP/P0mpmVjDxIxzu1BQ+QWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D4+qB6dP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YAI/n00F; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D4+qB6dP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YAI/n00F"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 2FB4A138006B;
	Fri, 17 Jan 2025 13:09:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 17 Jan 2025 13:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737137379; x=1737223779; bh=vs23yUn9Vw
	FBsnLb3Ye0DT9au3MGBGM0vavRbaG0rY8=; b=D4+qB6dPVN4GFyOXoKud1vp45f
	k38eyuHf693zUiSe7NO+Ur1QCFl4dZcLGWnjK9V8xNOTQpE3jRmeE41PsSgv8L1G
	C4YlI49LQVTDdrFcQehhyczVahT9SR94Ab4RmAnL3FetHOVS59gN+/SKtvqK8uYv
	EPIUnfM9Env3MW2f0JRV7G5oAiyVQv5UxYv2IcG22uYtBojOQM5Ezjas8WRZs47v
	iQpFUW/LaSaQG6KsmErVU646QuIztzh/nqWWlPAeRwKcGVAX8HffZP4B9Bb7p9Xh
	aBT3plhAOZl2Tb61iJb6adHGs7/ck0QQaz+grGKrvIi2E1eiNa7HvZ9nkJ2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737137379; x=1737223779; bh=vs23yUn9VwFBsnLb3Ye0DT9au3MGBGM0vav
	RbaG0rY8=; b=YAI/n00Fyhh4SqhSKsIAWYmNO1uhGivFMvPRWJ7A35HhpTDAKxe
	WeIw7hpBj3luYW475EZPKm33Qwz1SNuqDvt3TzNhFhBn3/gA6dBJzjQo12EDfk6b
	Rew2KSm55dUn5L/Wdpj4MFEizSUwFGZa9svEY6V6tkCsZvov4vxswRRC5y37B+CI
	mswZAtbn/0nRAj0PCEr9i6VDt9upSReBKFxYcAEn/QGNLteT4v2o2qeAyFyA7WP9
	S4zS5AuZ3BMD+yLCbC9roUkU3CloTqw3x67bRRT7NLh9aZTF2CR018q0CZq2aH8i
	aVvm3j5GZrpfdZbyqMod4LYKhaGTi0VESOA==
X-ME-Sender: <xms:4pyKZ2jw9Yz-uI47CjMYAyvi66y7BLZOHJ1ODcMC4J05a7_FGGiudg>
    <xme:4pyKZ3DoihKxbWYNWH7voCQcPUhINfIOHnaDBWu6PAzTG9R2EVu_24vWKR6W1HO-G
    Ge4RIWXzfIi1NtFnQ>
X-ME-Received: <xmr:4pyKZ-HvmRDZ8ZvtN03-ycJTSv2qNuzplomsCoIW3HTx52IKj69MxoybXN2xKkFIAgbZntwV6VgEMryXfOF1s6_XljExT0TtT1Au>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvg
    htpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:4pyKZ_S0XuXzrjPXP3s6Mekhix650EjuN5rUPf0Iy8cI-876WnjP4A>
    <xmx:4pyKZzwIGmU05i1S4myt8vSqkW7rUECr1oUS-Hd5PxlCfQvB93_Tdg>
    <xmx:4pyKZ94Fso9U-5GAuTvVVSQHNc8k7tDDe6IwS_QugE065keAz30Ccw>
    <xmx:4pyKZwyFV38bH72y_tJRTeOllVQojsYC5UY-THTnXhOVrD4c42cH_Q>
    <xmx:45yKZz8JVriK2CPq_zfKByBEnd0mPVjAfDoNXPU2pLqAsWjBGB8YrzaW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 13:09:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] gitcli: document that command line trumps config and
 env
In-Reply-To: <Z4nDW2FQ-MdWbW5P@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 17 Jan 2025 02:41:31 +0000")
References: <pull.1878.git.git.1737066042014.gitgitgadget@gmail.com>
	<xmqqy0zanzdw.fsf@gitster.g> <xmqqfrlinuys.fsf@gitster.g>
	<xmqqzfjqmbza.fsf@gitster.g>
	<Z4nDW2FQ-MdWbW5P@tapette.crustytoothpaste.net>
Date: Fri, 17 Jan 2025 10:09:37 -0800
Message-ID: <xmqqtt9xl3by.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This is useful not only for end users, but also new contributors who
> might want to implement a feature or authors of other tools which
> interact with Git, who will be able to write tooling that behaves in a
> similar way on the first go-around.

OK, thanks.  Let's merge it down to 'next', then.
