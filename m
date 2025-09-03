Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774602BF00D
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 21:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756935761; cv=none; b=Andtcg7PRoAEEqH/w3jxTS0+txaT01H45rHk9WMv4BQa+OLJvhns0r9NWsbnuJtKYnWoo1ZbTsPMfTN7WrBkGiLKBVKta5ubkwomfj21aY9WVTtOKeq+PFMl4WfduHyR06T2Pqy84Jha26UELrP07pLlH6pS/As6nsVFqxikqIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756935761; c=relaxed/simple;
	bh=jAUBXnc0GQs4ePNG89k4aYEjlpCIj/UyDQdN5YBgUys=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=j0e1bX3nABkZimcYmrJ5Fd3rVGOE6h8BIH6mgfxUnTc1bxm3F3X45AD0AGBh9TRFGuZpw+QWTrylrIRyPBCKLbkQCK1dXiiUN08yLzKMN+97o3bUiy1+zgh2KULJyLmYFkZDMSyTLEV8b4MZG3Y10qZ8AQ7FHpenMq49mU6Ln/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=OneiM204; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AhyFjuWM; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="OneiM204";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AhyFjuWM"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7F9837A0031;
	Wed,  3 Sep 2025 17:42:38 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 03 Sep 2025 17:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756935758;
	 x=1757022158; bh=EIagsWorGpBNtU3H3JWe8ibRtt5DPSrNRm+3h9wquVA=; b=
	OneiM204OVfDqzZOAtThCowQ2XS8mWufXTSDMIRGw7lmzS+c58UEcTlXCaYRA26Z
	pvPse2xYbwpr3XXE4N7UjTVrpyRxPbDNnDyT7qwKlvH34sUk7yEQuBc4j8n7eL2S
	p8pBjRsUZ/Z4mF9pKZYqrJwAFeN0RwjzVX8TyfWvzo6xNFcOxkdTqmiAFxKFWLyE
	0xo3h7T6YSrIEb5cj1VYCqaClicyKLFgu7EcdPqloy6XXFsxtw0T9Ss1qXwdHxi6
	HXfYy05uluV/nBpmHfpreUs+oMAFyqx0c98xic8Nb6rGr3F2zFteMgp6IWPKEUxr
	sMNBRHRy46Qc+rJBghTWJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756935758; x=
	1757022158; bh=EIagsWorGpBNtU3H3JWe8ibRtt5DPSrNRm+3h9wquVA=; b=A
	hyFjuWMGHECMpcF6fx8wjpQQWb4lJWW5O2w58J+LoV3KgZZhAr31C/wCBqb5c675
	FXRDn/E6JyhjuLiveXaLwprsi3lvzLCFsTIye+nNTaIgLILie4ISUrt0J4o0uZ5e
	sUIfLR9cFJb30cJoewnEvu1OiVXHhm45KeeUUW4Cm0Gtkvq1k9FySyqUARSQoUxV
	xHUwcm8Yn8ryr6qdqj5HkSbiBAdFSICbABSJJtnKXiMY0+THPw0FP+/lgGnj15wI
	wUUxv7yBBMGbpQe0ZAywHwBFgz8rgLQSscSNaZyei2JASC9YfelBNMRxHdu2Pyg4
	0fFM5OxY3zbHJQW24NNBQ==
X-ME-Sender: <xms:Tra4aLmD6NadrA2bFHtVihqUft2CHhULRB2DdfSAS01jPIOtsYx8QIA>
    <xme:Tra4aO1n2osaht1XVbiU8wmw6zwAQ79Mf0h-VmTOH5PeieCZEu9w_lB5MltbRMMHq
    9fQELAU_ISmqNUQOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephedugfevgfefgfff
    vdfhffdvveevgeehhedutedvgfeuffejveejudegveefvdefnecuffhomhgrihhnpehkvg
    hrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtg
    homhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgv
    tghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Tra4aAufhE7xffPvyfnuSELl5lx3oE9QHppMOyMxBmEr8OyXAyhYBw>
    <xmx:Tra4aG7PwGqUWDy1mr-50IMCZV-SJPJa9txaYKdXn5aqHN28HmzaeQ>
    <xmx:Tra4aLVzc5q25IhXw6ndEDFLuPDsPYgdE2CCRBled4laiuEinF8Nfg>
    <xmx:Tra4aI_146Vt5kG4xLphRyuyRA3PZlUYKn8VC4wr2Jg03ZjfpvqhWQ>
    <xmx:Tra4aE1MoiUgx8tnB6ei-V77jtFn2TGrA6Yi4RlDjag8al1-9XIuyesn>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0DC9B1EA0068; Wed,  3 Sep 2025 17:42:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMHZM2JIZMZV
Date: Wed, 03 Sep 2025 23:41:49 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Eric Sunshine" <sunshine@sunshineco.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Kristoffer Haugsbakk" <code@khaugsbakk.name>, git@vger.kernel.org
Message-Id: <f7f5ba15-c475-414f-9377-0f9c630a8796@app.fastmail.com>
In-Reply-To: 
 <CAPig+cQdwr-a_B++=2+q4mV8oZ7VLTYEQ9wnVP84jFYkTHFtHw@mail.gmail.com>
References: <cover.1756311355.git.code@khaugsbakk.name>
 <e81023edb2d78d2be0ecffc071f2c5316b0c7a32.1756311355.git.code@khaugsbakk.name>
 <9611573e-fb0b-49d5-933a-50d8e0603701@app.fastmail.com>
 <CAPig+cRgBXX+b=P31VjQ6Dd4mciFvaUJ4T1oeOGjk7mwV-9KMw@mail.gmail.com>
 <xmqq349czcl8.fsf@gitster.g>
 <CAPig+cQkVP57n_FE6dJ0uxvai-J7usxKFp8gzfEbPY=Ytsd6=Q@mail.gmail.com>
 <CAPig+cSL=-gD5+WomF7-hYjVJ_PH0m+0i8g3F=E_U3k=QNHr8Q@mail.gmail.com>
 <15bb8d07-675b-4ccd-8345-ab5861319faf@app.fastmail.com>
 <CAPig+cQdwr-a_B++=2+q4mV8oZ7VLTYEQ9wnVP84jFYkTHFtHw@mail.gmail.com>
Subject: Re: [PATCH 1/4] usage: help the user help themselves
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025, at 23:21, Eric Sunshine wrote:
>> I've seen  "troubleshooting" questions from git users
>> who got one of those long and well-described Hints
>> like e.g. detached head and default git init branch
>> when either the msg already spelled eveything out
>> or the msg was purely informational.
>
> I didn't spell it out above, but what I had in mind was something very
> simple... not at all ong and detailed; for instance:
>
>    For interactive use, define a Git alias `git whatchanged`
>    which runs `git log --raw --no-merges`.

But that won=E2=80=99t work since git-whatchanged(1) is a builtin and yo=
u cannot
use an alias to shadow a builtin.  Now you can suggest minor variations
like `whatchange`.  But then people will go back to talking about their
finger memory.[1][2][3]

You would need Peff=E2=80=99s:

https://lore.kernel.org/git/20250830022718.GB567900@coredump.intra.peff.=
net/

> I wonder if we should loosen the "aliases cannot override builtins" ru=
le
> for deprecated commands. Perhaps something like the patch below.

=E2=80=A0 1: If people are adamant about a command staying exactly as it=
 is for
    interactive use, I don=E2=80=99t imagine their tolerance for a sligh=
tly
    different invocation will be much higher.
=E2=80=A0 2: And I wonder about the audience who has been using a comman=
d which
    was deprecated for twelve years who also need to be reminded about
    aliases.
=E2=80=A0 3: But there is one `whatchange` conversion: https://lore.kern=
el.org/git/CAAn3O_2iHVt5TctvwLLSXm5Nw2wS8e9Xk0is1=3Dk=3D-qRS=3DgHVMQ@mai=
l.gmail.com/

--=20
Kristoffer Haugsbakk
