Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33CD3A1686
	for <git@vger.kernel.org>; Sun,  3 May 2026 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777834346; cv=none; b=WdDmIxc9RjTGJWiGvc4klUOpAsvlzf9vWpphaWJTcZondRU+hx3lYko9XgA8USxQiiPhsAWHGlWwowq9eOUXUxHWmFkUnOhseznxs7tm6aL2onaFUXb//7y/wE/cUf4RoTEwdypPS+VGJKY0vbRa/U7l2dWzAPFqFQkJ94nxUOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777834346; c=relaxed/simple;
	bh=KafOMWByAgrlwPRVtv3+HjyXBiefFUvCdAVAdCZSF7k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NbtyUVO5apxhM5rpuGMNt/W13fESEn09a+DgJW7GpOFE2QqlsLIm78UQjxT/yVyc6DUWu0sOEMS6kamXBJIuaX8r85rxVdfir4R/hf1nfzPvisUlc+oC5ASNcVlKqhYIU17a4PifeXzGZxbAaGl9lgDg0VQ9thOqHlexJKY/7Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=SxLV+zR6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o+kJ7DPI; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="SxLV+zR6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o+kJ7DPI"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id F1FE01D000A1;
	Sun,  3 May 2026 14:52:22 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-06.internal (MEProxy); Sun, 03 May 2026 14:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1777834342; x=1777920742; bh=pAeGuF2cJgyM0cjsAdZAJ6C3svj+fKdC
	vm/OJCSDy6k=; b=SxLV+zR6OnXDhJwYnK4g2ovvsnBwlFhyjMib25eDvxGtl5fE
	j/bbzBv342fkVtVd8FymekRi14J6OL1KWXXbkQ4uQUgvZZGAXpSKujx/vMeQ7HjN
	HmiykFN1yNWTeymMKT4zQodV3lX/f/Olp7uSWpBMpwmhAkkTIuHz/E2ON5GEnG6R
	E6G84l5AmE+Ian9jJe2Yb4M3xYsey2eb7V51s0KzjIox2NcCur7Jh+3PTZs/oRK5
	lhxQue6cH1F01KP/r2da4a9wO+Li73NG+Kj62vugIycYuMI7MJfp/GzOQu5UMtFS
	vkdhLV4wBnIDU4bnufZFm4bWTyhRN8Hb7Knb5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777834342; x=
	1777920742; bh=pAeGuF2cJgyM0cjsAdZAJ6C3svj+fKdCvm/OJCSDy6k=; b=o
	+kJ7DPIe/FqTv3cdIFF6+ctRWxLs2LBXTdKeTRcu/CP/8fzO4vXb+v0O/E712ueC
	fTySESE8rzeSNZdHQdSSXExim3XTts47g5fExN5ALyD97F2DVixF7bf/wv1aPGwU
	d43r5I+V45r/KXfi/fU+0eN/RoctQK9gZDLiUbxv9+8m+I3ElmBhmRfXldzzwv/l
	lQHLCNBD83L6RW4X3eU8PuK85mVniGzRqbSnrqssKGnA4VSH2p8c+fapy6D8DsLo
	qiRs/bTw4X6qlsBr5K1XQBgnlNlkBBpUg5NvLqM3dDIkptKQ3un4Fo349hELVCDp
	+j0fMLxhXimW4+FAPcUAw==
X-ME-Sender: <xms:Zpn3aRuY6OFzZodoXashoeNDNF4k8F_W0yUJlG03Z4UQzuPKW2SODCo>
    <xme:Zpn3aVTZI6dG_CKg2crVmIkCVEgDW8jEg1JSZyWqZfs6BU8WoO4bf9EQlBwjC6rfw
    Jmtb7DRUw2y8qFl5f6SvuLjChv2FZxbKfz7SK9QnRGM84OmBXrsBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelieejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeefteeghfegfeevleeguddvkeetheeiveffudej
    lefgudffffejleffffeludekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgv
    shdrphhluhhsrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:Zpn3aVSU13yeo4_B1w-Nv91anZ-wDtmyapOTj8Goqy26KubSyqyGxQ>
    <xmx:Zpn3ae4gD3eopJzwKcHZJ-8LHv7np8PEAFVdkLevW-s88pyR2aBoPg>
    <xmx:Zpn3aSzjQXZvSiHzFfLsYhRdXip5UogeT26x0Vx185EmXMEhFPsrJA>
    <xmx:Zpn3aVQC5oPJZOjxcKgcbXZUsYJFNhyP-tWrP88rJO3tlyK2_CgKNQ>
    <xmx:Zpn3aX9muPXuZBM7rSOwGTYlqwjuHYxU8l7EYLj_zj5lqKOi17d7rN1a>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1F92FC4006E; Sun,  3 May 2026 14:52:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AHDyktfZDWSB
Date: Sun, 03 May 2026 20:52:00 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Ramsay Jones" <ramsay@ramsayjones.plus.com>
Cc: "GIT Mailing-list" <git@vger.kernel.org>,
 "Junio C Hamano" <gitster@pobox.com>
Message-Id: <66710fd7-23bb-4b1f-852a-f61ea1f188e0@app.fastmail.com>
In-Reply-To: <e74a8fd8-0617-46a8-8bef-a454d51a99c1@ramsayjones.plus.com>
References: <e74a8fd8-0617-46a8-8bef-a454d51a99c1@ramsayjones.plus.com>
Subject: Re: [PATCH] name-rev: fix an 'may be used uninitialized' error
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, May 3, 2026, at 17:16, Ramsay Jones wrote:
> Today's seen branch fails to build (with DEVELOPER=3D1), like so:
>
>       CC builtin/name-rev.o
>   builtin/name-rev.c: In function =E2=80=98cmd_format_rev=E2=80=99:
>   builtin/name-rev.c:885:28: error: =E2=80=98commit=E2=80=99 may be us=
ed uninitialized
> [-Werror=3Dmaybe-uninitialized]
>     885 |                         if (!commit) {
>         |                            ^
>   builtin/name-rev.c:867:40: note: =E2=80=98commit=E2=80=99 was declar=
ed here
>     867 |                         struct commit *commit;
>         |                                        ^~~~~~
>   cc1: all warnings being treated as errors
>   make: *** [Makefile:2932: builtin/name-rev.o] Error 1
>
> This can be fixed in several ways; initialise the 'commit' variable to
> NULL (on line 867), initialise 'commit' to NULL on the line before the
> conditional on line 883, or (as I chose here) initialise the 'commit'
> variable in an else arm of the conditional.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Kristoffer,
>
> I wrote this patch yesterday, just before I had to go out, and didn't
> get around to sending it to the list. Today, the problem has gone
> away ... (along with the 'kh/name-rev-custom-format' branch)!
>
> Assuming you will be sending a new version soon, ... could you please
> squash this (or similar) into the patch corresponding to commit 590385=
5b1c
> ("format-rev: introduce builtin for on-demand pretty formatting", 2026=
-04-29).
>
> Note that I don't think this particular fix is better than any other, =
it
> was just that my cursor was on that line in vim ... :)
>
> ATB,
> Ramsay Jones

I=E2=80=99ll incorporate it. Thank you!

>
>  builtin/name-rev.c | 2 ++
>  1 file changed, 2 insertions(+)
>
>[snip]
