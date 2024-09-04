Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92100145FE8
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 07:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434695; cv=none; b=FzNDF346AnUzqzEZ9wQm3itzt6gkM0DsyJ3tYbw2Y1xbDN4bxuW+VfwNy9Xema59wrzOMkA6KVWtAY+yEREBqBwNdikCeocr3h4gUbDao/QUQaDoiAJWo7659ECBaMCqdgeIHv371v/ezmtClfMC8bMPnViPtoz24Gu0MgvE904=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434695; c=relaxed/simple;
	bh=+Zf1SoSuXkRmQkBewlUbH2jtdqa/wM+VKCaFgSW1bEM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ste8yiabNmZc24twbR5m49QyVNJG8FJbwt3j7Xf6yQu60hXsAvpI38ftfaCwfqR95dHOSZlK9f8NQngqluqVE6IXAUUM1KS0zPvPViojwRAPNqAqXzmDmIrYgqWwc04uHufOUe7luxPjNrOKtJtpe9q5LiAs2BUlzEUxMlR/GMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=2UhpmujX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iqgC/q2W; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="2UhpmujX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iqgC/q2W"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 93CF81380305;
	Wed,  4 Sep 2024 03:24:51 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-04.internal (MEProxy); Wed, 04 Sep 2024 03:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1725434691; x=1725521091; bh=GYvyzF8pLJ41vrphsKF9UgMi9zS2mcaa
	ZQSwx/+9pmo=; b=2UhpmujXK/HUSPYzwGnG69JYvb/+sGCsYHZ4JtOla+rfkJZD
	daakNQz6F3K1bwqtj5aG0f2bjb2/NKOAKODymWFDXr5ylXO3m0uINORFfaVodt39
	OqfmlI0TTUMClo11QThJX3bkKAXTvzDygTXdscbtCTVo/eRDCOPaY/jVW1nDU8JB
	zD0iBmUhVh4G47yzVLhUcwP3SATlUcMy0bShQ/zmf4vKIkJNOyD+aBqMJDASCkBz
	lhbnbhcG3fCFRgAY8OkCSKyznBw+tJ9tSz3tweOgdUkyd7iHj+KyoAfcMtAm0wmI
	FBT8HoUjuUD5srBLh6rf7dznb6O8jXy43p8NTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725434691; x=
	1725521091; bh=GYvyzF8pLJ41vrphsKF9UgMi9zS2mcaaZQSwx/+9pmo=; b=i
	qgC/q2WBlhE6tqLwI8EXadqY+/XXrcd3wLPSnkBCSiBBUsUpYmF+kce0h6VqwY2V
	7+YxHVZK3NwmkVHWhptJA+vSixfeVvNq2KHd3XVv9olvd/1iyBXZidW1xvWjAHYd
	pRYg84vcTBwzWrla3Qc0cUJlblfa0A8PInyvK4N6jxYiWkM5gEY+jfcgBmLjaasQ
	mGlntJoSe1EhtLmD06T9PCuo0R04YUpawDYUOvMiiCJP8NqNKoPC7Dq9k0IiYGfA
	Ykt7W8uTQDfAj8thh8B2uohZ0rsSUznW5DXhHVU++BE2Dd7F7f+WeAbO6F/MUuAC
	+Hh7AZJJjNQrKkLKIxq9Q==
X-ME-Sender: <xms:QwvYZl9y7jMhW3Ma2lCSf4H_6QR4eE3_A7h2yJEQHGrF4L9qw1967pY>
    <xme:QwvYZpso0nBV_aWDmBCPeKhE3wbeV7oCiaLlT72ydnYSR7AHZA-e1usrytRFlDIsE
    Y3OD-JkFGwuPmM5zQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehiedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghr
    ucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqne
    cuggftrfgrthhtvghrnhepfeetgefhgeefveelgeduvdekteehieevffdujeelgfduffff
    jeelffffledukeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggprhgtphhtthho
    peefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehmihhkvgesfiefrdhorhhg
X-ME-Proxy: <xmx:QwvYZjDkOqpJD97CJK0tYOne-yDxTPtC9FT1rQoTQ9wAe_remsne8g>
    <xmx:QwvYZpe0OaUTpAJhsLlLpWcGuH7kkydFBhPQHam5Td_EoUemi4xFZg>
    <xmx:QwvYZqNSSdvcSh-3B1XEPdtUDNxBkJR6TyM7fuIID47UyZBJVKO4OQ>
    <xmx:QwvYZrk9oUc82FZTvzEvrDHlIfQecWfUT0y3wqM5hXStK4dwrAUtNg>
    <xmx:QwvYZjbxILppO_lL4cHLhv_0-a40yNCXnIEk-f6qrmRXudcEcaFb8Gpc>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4CFD1780067; Wed,  4 Sep 2024 03:24:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 04 Sep 2024 09:24:30 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, sideshowbarker <mike@w3.org>
Message-Id: <5cab62b7-d2ab-4395-83f8-0b34562d3568@app.fastmail.com>
In-Reply-To: <xmqq7cbsh16d.fsf@gitster.g>
References: <Zp89ntYaeFUumaTO@w3.org> <xmqq7cbsh16d.fsf@gitster.g>
Subject: Re: Problem: git Notes not discoverable (+proposed solutions)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024, at 23:34, Junio C Hamano wrote:
> sideshowbarker <mike@w3.org> writes:
>
>> ## Problem description
>>
>> When a project has added git Notes for its commits, git by default do=
esn=E2=80=99t
>> automatically fetch the Notes; so, the Notes aren=E2=80=99t automatic=
ally discoverable
>> to contributors who are using =E2=80=9Cgit log=E2=80=9D to read the p=
roject commit logs =E2=80=94 and
>> especially not discoverable to new contributors, or =E2=80=9Ccasual=E2=
=80=9D users of the logs.
>>
>> A user will see the Notes only if they _already_ know what git Notes =
are, and
>> know that the project uses Notes, and the user knows how to get them.
>>
>> But the reality is: most users do not even know what git Notes are, a=
nd don=E2=80=99t
>> know how to get them if they exist. So most people end up never seein=
g them.
>
> And even if they did, they wouldn't know how to use them, so not
> much is lost here.

The given example is about them appearing in the Git log. If the notes
are autofetched and there are notes in the default namespace (`commits`)
then they will see them in the log. In turn they are using them (seeing
them) without having to do anything themselves.

> Quite honestly, a project that uses notes in such a way that it is
> essential to understand/utilize the history should reexamine its use
> of notes and try to see if they can make its commits more useful
> without relying on notes, I would think.

The two examples seem to be about adding Notes in bulk to established
projects. Maybe this information would have been part of the commit
message if they had the necessary foresight.

(Or maybe not: I wouldn=E2=80=99t add all relevant GitHub metadata to th=
e commit
messages)

>> As far as what the change would be: I realize this has been brought up
>> before =E2=80=94 but it seems the obvious solutions are to =E2=80=9Cj=
ust=E2=80=9D change git so:
>>
>> - Proposed solution #1: git auto-fetches all Notes when a repo is fir=
st cloned,
>>   and then auto re-fetches them again for every =E2=80=9Cgit fetch=E2=
=80=9D or=E2=80=9Cgit pull=E2=80=9D.
>>
>>   I think that auto-fetching-of-Notes would ideally be the _default_ =
git
>>   behavior =E2=80=94 but short of that, at least a new [notes] _optio=
n_ for enabling
>>   that behavior would help. That would seem somewhat more =E2=80=9Cap=
proachable=E2=80=9D to
>>   than =E2=80=9Cgit config --add remote.origin.fetch '+refs/notes/*:r=
efs/notes/*'=E2=80=9D.
>>
>> - Proposed solution #2: git checks if a clone lacks Notes vs remote, =
and emits:
>>
>>   > Your clone is behind the origin remote by N notes. To fetch the n=
otes
>>   > from the origin remote, run =E2=80=9Cgit fetch origin 'refs/notes=
/*:refs/notes/*'=E2=80=9D
>>
>> Either way, I=E2=80=99d be very willing to put work myself into writi=
ng up a patch.
>
> A much more light-weight alternative would be to add an example to
> the tutorial to tweak the "remote.origin.fetch" refspec so that it
> will also fetch notes.
>
> But stepping back a bit, none of the above (including your two) may
> practically be workable unless you limit the source of the notes to
> the upstream, or something.  If you add notes yourself after you
> clone, and the upstream makes different changes to its notes,
> reconciling the diverged history of the notes tree would not be so
> pleasant.  As a mechanism for the only publisher to publish
> auxiliary pieces of information to cloners, notes is a very useful
> mechanism, but for such a use case to be effective, the project
> participants must understand when they are supposed to use the notes
> read-only.

The proposal seems very in line with downstream participants who don=E2=80=
=99t
know how to use Git Notes. The downstream participants don=E2=80=99t hav=
e to do
anything: the default note just appears in their logs because it is
auto-fetched. Their only concern is whether the notes are informative or
noisy. They don=E2=80=99t have to care what Notes are.

The participants don=E2=80=99t have to know how to use Notes (read-only)=
: they
are just there.

Then if they get curious and make notes themselves in the same
namespace? That=E2=80=99s their own fault.

I don=E2=80=99t need a printer and my own pins to read a bulletin board.
