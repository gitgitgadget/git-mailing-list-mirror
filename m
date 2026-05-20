Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AC7375F88
	for <git@vger.kernel.org>; Wed, 20 May 2026 07:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261078; cv=none; b=KoCXuoyQvZX2CLV5CZUFCk4Po23L8JJpUt5D0sV9M9YLE20aye+sElTxUsDrY8i44CFFjnFuQGfQDQhB8P1ZHYRjk+UiOp++mCWexeWW6k8FyngSuvLaPGxWKJ/sn+XE6dQqyNXGzus9ER983xRhw0iOlBo8mJQW3WQ4jgAek+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261078; c=relaxed/simple;
	bh=fn/PwDaoRbXn4317I3ylTn0iJMVD1wKwPyt/nk2mUWY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=j/VZ4ybtRtkjAr2tqxUhjFktf0B3DACLgIirbRSwW0nuP8XmDDSi5DzArBqW7GEkkzAGzU0378y7a1likqdMNqc0EZ2399uzKv70rRTl3ezl/ZJ28AMNEh4grKzmtBo0Klz6nRRsNIQSvzlPsgFmbsO82jHB7rxuNOUVkpSKqs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=H8miFI90; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kkeIV4iT; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="H8miFI90";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kkeIV4iT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7AC97140003A;
	Wed, 20 May 2026 03:11:15 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 20 May 2026 03:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779261075;
	 x=1779347475; bh=5/o7QjiksXigv8G7jKh49883+xn/6Ti/sx8M2YjsqPw=; b=
	H8miFI90zwRqGJFy1DSvHUlJCUfvk2D/qhMkpk58MFm2Fue8r31iYjrSlQeB8VBy
	qTWOubm4Bo94A2emci2Sw6XBz4IseEcioYryKb1+ApVwpnuyzAeaHrMMO6yArKWq
	9Nz1XbiMiMwzz/ecpI97mMoOrpjBFB8DjwflhWXZtH/ZFZl+rHRIOBeW9KlygDEx
	OlfC2Q/Bf+oz0ztCMz9u5OuhbIw4ungiIiyuyVFNf19mPqFz2SsF+BHTKNWVoBtN
	cxpfPacSxjw4wEYGLL5CJAV+nEdsmY/x/44ApIViJsqtL6PpJzNxHi9PyyOvGPbu
	uwxmDiXdVBDkMjEBlvU9NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779261075; x=
	1779347475; bh=5/o7QjiksXigv8G7jKh49883+xn/6Ti/sx8M2YjsqPw=; b=k
	keIV4iTOCu6Zip3YlqJQK79u/oePv4WrnN3cx420NuHBx1r+11egWOPbhWkKEFhf
	dZnxWgB0kqku7REBUkzroD2i3P6GJj+ZAwesNMscRpCOa8V/TunAFYKW8TUU+KRw
	og2EKkflB4qkyoNCsapK6D+3NpRGsa9Wqn39N3VO51HxwtfnXkiVt8Qbpe8QGNka
	ClXu5oAkU3dRCGnFJVSaEOQSB3QSAcXIse0C7E2vSIZyS+TdrMW12/fAWYXfSdaf
	5/TKdNDDHljbtnv8tI93Wa2G97WTIdRq4+egQ8dPAElYaMLktJPtMzB17ZneZTZ0
	PyIvC5M6CwhKMjQ8AY1KQ==
X-ME-Sender: <xms:k14Nah4RhqjGNjCIxvnmVKRjdZB42Qj92qtcBa-BbOfW0oGSD9pM75A>
    <xme:k14NapsRrduCR8BD_pnOhFv7OLE0kKt6txzqMSOOagsm4JSyQYdX8Aq70jai2DXX3
    h7HDycpLWIxT5c8JnkE-8hgpY_tyzSVJQ-vGqzaN_Ox_YyeIxVDow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeefleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:k14Nauin9AzIZxotGbhB110gjUGnelhmWS725iYVhicycRjm87zXAw>
    <xmx:k14Nas37BSZzbE6f5HnGQnRgcLpO0VBlZPiimHMQfVrPTIvZmayi3w>
    <xmx:k14NagiaAyW2xTeJjylQ1FR6YaPWyyMC7tF4IoVIi9pTpPM9fbOxHw>
    <xmx:k14NakcT4jyBYgyi5tyGaFVe4ey1J89R_KrVMjql60ITsDLwbytRPg>
    <xmx:k14Nahsv3WmDEV1BwNjLXOEHAzUnGRPYc3RV5qKeuPvxdkknmbuCHrHX>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 48C6A3020073; Wed, 20 May 2026 03:11:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: APJPVL9XindV
Date: Wed, 20 May 2026 09:10:54 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Derrick Stolee" <stolee@gmail.com>, git@vger.kernel.org,
 "Oswald Buddenhagen" <oswald.buddenhagen@gmx.de>
Message-Id: <344cc7d8-4ab3-40f4-9564-80e5888c5bc9@app.fastmail.com>
In-Reply-To: <xmqq8q9qwxrr.fsf@gitster.g>
References: <V2_caveat_commit-graph.68b@msgid.xyz>
 <V3_caveat_commit-graph.6b6@msgid.xyz>
 <39f029d7-0c12-4a79-a701-04abf82cfde8@gmail.com>
 <7eae7ad5-5b09-4069-aafe-571f3e345b83@app.fastmail.com>
 <xmqq8q9qwxrr.fsf@gitster.g>
Subject: Re: [PATCH v3] doc: add caveat about turning off commit-graph
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026, at 03:16, Junio C Hamano wrote:
>>>[snip]
>>
>> It=E2=80=99s certainly not necessary, yeah. :)
>>
>> I am basing this on a recollection of someone quoting this from
>> SubmittingPatches:
>>
>>     Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:`=
 and
>>     `Tested-by:` lines as necessary to credit people who helped your
>>     patch, and "cc:" them when sending such a final version for inclu=
sion.
>>
>> They said that this was outdated since Junio does it himself. But then
>> Junio replied and said that it=E2=80=99s good/better if the contribut=
or does it.
>
> I used to say "let me do this to skip one extra roundtrip" but I
> stopped saying so.  Perhaps I should be a bit more explicit and stop
> being silently nice to contributors who do not follow the guidelines
> to the letter in order to unconfuse you and your friends.  It
> actually is a tempting thought.

I am personally okay with adding these trailers and think it=E2=80=99s n=
ice to
document such review/ack/etc. interactions.

Just considering this part in isolation, I imagine that you not filling
in missing acks etc. will lead to less such trailers because (1) most
contributors don=E2=80=99t seem to follow up with such updates if the on=
ly
change is the trailers section, and (2) most people here (culturally)
don=E2=80=99t add explicit trailer lines in their replies (e.g. an =E2=80=
=9CLGTM=E2=80=9D is
clearly an ack, but not explicit).

>>     Well, this is another instance that I may be trying to be too
>>     helpful and over extending myself, which does not make the process
>>     scale well (the other one being the "one final resend after the
>>     list reached a consensus").
>>
>>     If the authors collect Acks and Reviewed-by's and resend after the
>>     list reached the concensus, it may take one extra iteration, but I
>>     no longer have to keep track of these trailers myself, which coul=
dOn Mon, May 11, 2026, at 03:16, Junio C Hamano wrote:
>>>[snip]
>>
>> It=E2=80=99s certainly not necessary, yeah. :)
>>
>> I am basing this on a recollection of someone quoting this from
>> SubmittingPatches:
>>
>>     Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:`=
 and
>>     `Tested-by:` lines as necessary to credit people who helped your
>>     patch, and "cc:" them when sending such a final version for inclu=
sion.
>>
>> They said that this was outdated since Junio does it himself. But then
>> Junio replied and said that it=E2=80=99s good/better if the contribut=
or does it.
>
> I used to say "let me do this to skip one extra roundtrip" but I
> stopped saying so.  Perhaps I should be a bit more explicit and stop
> being silently nice to contributors who do not follow the guidelines
> to the letter in order to unconfuse you and your friends.  It
> actually is a tempting thought.

I am personally okay with adding these trailers and think it=E2=80=99s n=
ice to
document such review/ack/etc. interactions.

Just considering this part in isolation, I imagine that you not filling
in missing acks etc. will lead to less such trailers because (1) most
contributors don=E2=80=99t seem to follow up with such updates if the on=
ly
change is the trailers section, and (2) most people here (culturally)
don=E2=80=99t add explicit trailer lines in their replies (e.g. an =E2=80=
=9CLGTM=E2=80=9D is
clearly an ack, but not explicit).

>>     Well, this is another instance that I may be trying to be too
>>     helpful and over extending myself, which does not make the process
>>     scale well (the other one being the "one final resend after the
>>     list reached a consensus").
>>
>>     If the authors collect Acks and Reviewed-by's and resend after the
>>     list reached the concensus, it may take one extra iteration, but I
>>     no longer have to keep track of these trailers myself, which could
>>     be a big win.
>>
>>     So, I dunno.
>>
>> In conclusion for now: I dunno. :)
>
> I do not know either, but if we agree that everybody should do so
> themselves and I should refrain from applying the ones that lack
> Acks, I can adjust.  There will be lot of unapplied patches left on
> the mailing list initially until the contributors adjust their
> behaviour, but in the long run it may be beneficial?

Okay, if the proposal is to *not* e.g. graduate series to `next` that
haven=E2=80=99t applied the acks etc. then I understand how it will like=
ly lead
to some stalls until people adjust.

To be clear, I imagine this is how it would play out:

=E2=80=A2 The series in itself is ready for `next` and has no unapplied =
acks
  etc.: it graduates to `next`
=E2=80=A2 The series in itself is ready for `next` but has unapplied ack=
s etc.:
  it does not graduate to `next` since the contributor should send a new
  version with the trailer changes

***

There is also the paragraph previous to the trailer one:

    After the list reached a consensus that it is a good idea to apply t=
he
    patch, re-send it with "To:" set to the maintainer{current-maintaine=
r}
    and "cc:" the list{git-ml} for inclusion.  This is especially releva=
nt
    when the maintainer did not heavily participate in the discussion and
    instead left the review to trusted others.

    Do not forget to add trailers such as `Acked-by:`, [...]

And I have only managed to follow that part maybe, probably one single t=
ime.

>>     be a big win.
>>
>>     So, I dunno.
>>
>> In conclusion for now: I dunno. :)
>
> I do not know either, but if we agree that everybody should do so
> themselves and I should refrain from applying the ones that lack
> Acks, I can adjust.  There will be lot of unapplied patches left on
> the mailing list initially until the contributors adjust their
> behaviour, but in the long run it may be beneficial?

Okay, if the proposal is to *not* e.g. graduate series to `next` that
haven=E2=80=99t applied the acks etc. then I understand how it will like=
ly lead
to some stalls until people adjust.

To be clear, I imagine this is how it would play out:

=E2=80=A2 The series in itself is ready for `next` and has no unapplied =
acks
  etc.: it graduates to `next`
=E2=80=A2 The series in itself is ready for `next` but has unapplied ack=
s etc.:
  it does not graduate to `next` since the contributor should send a new
  version with the trailer changes

***

There is also the paragraph previous to the trailer one:

    After the list reached a consensus that it is a good idea to apply t=
he
    patch, re-send it with "To:" set to the maintainer{current-maintaine=
r}
    and "cc:" the list{git-ml} for inclusion.  This is especially releva=
nt
    when the maintainer did not heavily participate in the discussion and
    instead left the review to trusted others.

    Do not forget to add trailers such as `Acked-by:`, [...]

And I have only managed to follow that part maybe, probably one single t=
ime.
