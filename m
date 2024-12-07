Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061481E4BE
	for <git@vger.kernel.org>; Sat,  7 Dec 2024 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733586723; cv=none; b=bY8tTUL1U6HJrMKVb9+WBTdxEzyXD6ZS0/MVJGr7yPwNsIcJO0DdEJPagrNS19pNo5me44UYI9xmNep5DwhWUGcGCNt4+JNaQ4MR8mOU9NFgH+SOsXz8vWSolyBp9Qtx38Iww/NntD1xbbl68sJfIxeLQSpwM2x/165ZBgNz3Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733586723; c=relaxed/simple;
	bh=BboNVas8rvChE8Yi4pbEmeEqavP7ihBc94Q7/uG3MDw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sOFaKhvKUEo12KF55dJpEe5tk/z690a5cxBLG+raJvBO5RsyJb4/qOq5BclMDTPK7C4XAxHc1bxog/z0whcs47R65gi97/0rswfaWqsiE915kmgLww2SzgPQHbpmyxzVJhOsCcMA5Rf89e2vsf9AG6Dz8QQoHKPvHPfrhwRZrY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=IkzFEfes; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W4748tVV; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="IkzFEfes";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W4748tVV"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 08E4011400CE;
	Sat,  7 Dec 2024 10:52:00 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 07 Dec 2024 10:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733586720;
	 x=1733673120; bh=OHQvZ+lbxushHQwv104WHJaMrry5ipOEZWWjx1qkLdc=; b=
	IkzFEfesKPp+Sg09KXpTHUF6XkynnrA6Zwzvc74nd4/AduKpONKD3gKIVE0XzSnI
	dlY27RQRJUjr98bccY7nR9ZcqLWbTlOt2jEQaqlNgidlHuzqCbvXmtBS3E26tMbl
	zw1gGJcECDPn8z3+f6X7Q57qg4SOoTV2GDXQtKegV8h6d5kmPXkcMuC90cUwx4ZL
	objQ1c6Zw5U2ByeBIhWMYpB+KvFlyCogYLlpLf3KJCGZzEu/NLxPPNRdZTAHN3Zo
	QtrSiNbnjpBFqNsLO1mIAKzrToSdAstr2Xfd4UVriwTGDrrde6SpXDiWi902ELma
	tEKvkwyrXDBlBse0OkG96w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733586720; x=
	1733673120; bh=OHQvZ+lbxushHQwv104WHJaMrry5ipOEZWWjx1qkLdc=; b=W
	4748tVVqaIdCuG67aFJBe9oMUNKK2c18MGQcw/UoHz1LKAnTavob457W27zkJeyr
	ZOX7Jis/FW/g3CehpgkuGrJWoIx8By2t4cfLTE8K2WzB+daEfjHAWacNv5cmSsWz
	zTlxcxCsDaKRNGhehhsOgSzUuRSihS7PSfZckNJnJXR8hDpsYzfYyesjK7pYy2VL
	YvVgdyWd3Gp+zM4XCb3b4N0EcEWZLhwblB/XC4gWhxmue00a/NJUJeUvYivoeaeb
	T3FdnQgr5UcIEZrI6OzdbvobS/ycYYRzHflKJiCmcVO0wU4UAvLfasVzjNP40MZV
	4Ml+NbcVBbgTPPOyjRjEw==
X-ME-Sender: <xms:H29UZ93wVcYnhLvov4uPcDTinPGHfxaf6pVPhwQ-Oqlgv7-ZVWEtOyM>
    <xme:H29UZ0E4sKLcW5Y543-bjPaNNkC12VLi6MZhl6uNMqHlK3OurfvfWRfzBG-eon061
    UZcmzS52dAyO04TIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjedugdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigfefke
    dugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspg
    hrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghl
    vghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopegrrghrnhhisehvrghlohhhrghirdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:H29UZ96x3sjlAaU65u27wCdF5tQOe_8y_CmKg_cfNJmdJNLWU2tT4A>
    <xmx:H29UZ62bKlz3TlliHkg8GAVlozvLCfgLAmWkINPonV_FLa-GYl-KHw>
    <xmx:H29UZwF7wUt5xoO5YCeTUVPyxIZEax-ov8ZPdSOnH1d9tWWQOC6nzQ>
    <xmx:H29UZ7_httk5ws_6B7oDEPLkeeQm_3pqsYGAUge6s3JM9pla0SHIgQ>
    <xmx:IG9UZ1PNEyIEkwY4KQepvTPcqmEfPLobibxokgRwho1RJgRhLFa2FyhF>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 75130780068; Sat,  7 Dec 2024 10:51:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 07 Dec 2024 16:51:39 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Aarni Koskela" <aarni@valohai.com>, "Jeff King" <peff@peff.net>,
 "Junio C Hamano" <gitster@pobox.com>, "Justin Tobler" <jltobler@gmail.com>
Message-Id: <3ef4f213-a49e-4d72-8f45-00a5fa030852@app.fastmail.com>
In-Reply-To: 
 <20241206-pks-rev-parse-fix-reversed-list-v3-1-d934c17db168@pks.im>
References: 
 <20241206-pks-rev-parse-fix-reversed-list-v1-1-95a96564a4d7@pks.im>
 <20241206-pks-rev-parse-fix-reversed-list-v3-1-d934c17db168@pks.im>
Subject: Re: [PATCH v3] object-name: fix reversed ordering with ":/<PATTERN>" revisions
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Just bringing up this nitpick in case you decide to make a v4 based on
Justin=E2=80=99s reply in this thread.

On Fri, Dec 6, 2024, at 16:45, Patrick Steinhardt wrote:
> Recently it was reported [1] that "look for the youngest reachable
> commit with log message that match the given pattern" syntax (e.g.
> ':/<PATTERN>') started to return results in reverse recency order. This

This isn=E2=80=99t =E2=80=9Ce.g. ':/<PATTERN>'=E2=80=9D any more since y=
ou are not listing
examples.  =E2=80=9Ci.e.=E2=80=9D perhaps?

But it=E2=80=99s clear what you mean from the context anyway.
