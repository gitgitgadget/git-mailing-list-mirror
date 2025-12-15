Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DFE145355
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765800319; cv=none; b=BdSlwcLzqooiT2IwaDcEGjU8Tja4z77jeoWGWvYze/9YA71TefkMxeTxDYZXTNP1TsXZAGzlVVc71N3knDOuKtPHqkGiW2Plzv1fGRyrWyR9LRFsCZt+DDK4xDSAvSr3tderJgAWR2aA/8nIYYgmKWW/WYuCZoAMf1NNmxeuvyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765800319; c=relaxed/simple;
	bh=5+KY3Zjdi83X9OP8UThIQjrTQ+KM63ZGmdnv2YVfDdI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Tveo65rNq8SogoqP23jRQOH/OVHkjXFfaiAbUkMiyAWBhAhnYGPF7DpWTJawGJSS7iFooWtBi2RmcD1Blo4k4p2jkyXStEiEUrZCxFxM3cjQiCwAPrP0y1FFxJlpFAnvP5CTeiCKW6BhRL3ZlhBxuG1D/r4KDV77k9ebkxWcQa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cSHqgx7+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T+Djt9hB; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cSHqgx7+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T+Djt9hB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7063F1D0001A;
	Mon, 15 Dec 2025 07:05:16 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 15 Dec 2025 07:05:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765800316;
	 x=1765886716; bh=RlSwPkScfp8OTRUXMhBvIO8rAHtC31z2reBFMhMV6j0=; b=
	cSHqgx7+T5dHEPlz2tXreNM0ZQDrp61O34iOJb2XpgrvkE5WahGdDjEZVmFC/dBG
	wkgM6E+G7rBfETt1AJCEAoeCaHM+AW2WKOwcZIjSJi10lWvDg9CvGIZpXmZuUYmX
	2CuEhDiV3N2gpuhJv+4JJT4OYG5OhmgtrUvdCP8kue5brWJl8eS8O2ocdtANkyVp
	T5/y3VNf/TMpsBtmOgnYOxZulYmgshUccx5pvD53Ki3Lah+6QNT5Nz8XIZNe5fg5
	TnKGipKT0d3W7MR2UY3KqxF/9EqCEhw45dZz3Lb3EUq2kny5vA6UlYnQ5m6TMTZZ
	gqJGQYPjaWjigq1YiaLRfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765800316; x=
	1765886716; bh=RlSwPkScfp8OTRUXMhBvIO8rAHtC31z2reBFMhMV6j0=; b=T
	+Djt9hBgYkwrYPfQOj5pe0e/Z3ez9V7INW4KnecpNrOs0S/qXy8HBexWmhtq6TRK
	HZz4VeTbOHElgJ+TE/ijqsabcg68tbPQFzQWqTJP1OFbwb+bQxBRv9oSrHYgWxJy
	BHeNqAAYnDBxYgIJ7ib2CwOMBn9ewj8WNNVLT3lNj3+lpkVGMjilm7LS7i2FaBTP
	KM288wl+BmHU44G5AyXOWXi9zbbrpaQreSaitw/89fiAbAsNKIJhf+AudFz2pB/6
	rZeytfWVA5/k2MQ09BqtPDGC8IqNdC74wXTZ4kSiUWerlsQuiqLluN2+aD6YOS2e
	u5YNcaEkWj+4Xqz431fiw==
X-ME-Sender: <xms:fPk_aeKxHi-OSTqKVYZyEdjoEVkWQ96bfZTeCDh4LQayzUpCBPbyWZU>
    <xme:fPk_aQ-dyXcIKx8ZjQbarJQKTDPEmuE94JDEVUcg1wOqSldHB902NexY5_ohhp_77
    Kj9gOwBE7Arlg2726CK3N4FnEnJceUkCitD_doOUG2ib2HyHzumVVI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefieejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghl
    mhdrohhrghdruhhkpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfeduse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvg
X-ME-Proxy: <xmx:fPk_aSwWZKAalgnR75556gAryqYuFui6fHyWJ969TQU5w8cKYopwjg>
    <xmx:fPk_aZtGrx2bZGpG4xjQdLjKjbYfXaW9bcGndv0qPVdUqG-LVdaqbg>
    <xmx:fPk_aX1l3yWfbF-oJUJ3Bd9enlnflfKFRTV1wB3aHahh-Wsq16vpfg>
    <xmx:fPk_ac9qteW0NNbwyIeV-JhpC6tSJdoM1O8xthRz-YksmkpLpmbXOA>
    <xmx:fPk_aVgd1GV1KuQcmait4zxPKS_v0H3GdVa6DT2QGNe5UcOAuqilKj-6>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 29D181EA0066; Mon, 15 Dec 2025 07:05:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aqd9KhJDS4aJ
Date: Mon, 15 Dec 2025 13:04:54 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Cc: "Siddharth Asthana" <siddharthasthana31@gmail.com>
Message-Id: <a395825a-a9e9-4cde-bf2d-f9b72de9212d@app.fastmail.com>
In-Reply-To: <a017e50f-7c8f-461f-8627-2fd1445d29f6@gmail.com>
References: <3d83161b-ec34-404a-bb0e-bf4da7ac1db5@app.fastmail.com>
 <9db2b913-b5d6-4617-b079-b4612eaa2b97@web.de>
 <a017e50f-7c8f-461f-8627-2fd1445d29f6@gmail.com>
Subject: Re: [PATCH] replay: move onto NULL check before first use
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025, at 11:10, Phillip Wood wrote:
> On 11/12/2025 17:56, Ren=C3=A9 Scharfe wrote:
>> cmd_replay() aborts if the pointer "onto" is NULL after argument
>> parsing, e.g. when specifying a non-existing commit with --onto.
>> 15cd4ef1f4 (replay: make atomic ref updates the default behavior,
>> 2025-11-06) added code that dereferences this pointer before the chec=
k.
>> Switch their places to avoid a segmentation fault.
>
> This fixes the regression nicely. There is a preexisting bug that we
> treat an invalid --onto argument the same as a missing argument but th=
at
> can be fixed separately.

I have a commit cooking (locally) which makes the command die when it
cannot find commit-ish for `--onto` or `--advance` (whitespace mangled
diff):

```
diff --git a/builtin/replay.c b/builtin/replay.c
index 507b909df7d..72d62aa34a6 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -39,7 +39,7 @@ static struct commit *peel_committish(struct repositor=
y *repo, const char *name)
 	struct object_id oid;

 	if (repo_get_oid(repo, name, &oid))
-		return NULL;
+		die(_("'%s' is not a valid commit-ish"), name);
 	obj =3D parse_object(repo, &oid);
 	return (struct commit *)repo_peel_to_type(repo, name, 0, obj,
 						  OBJ_COMMIT);
```

Instead of dieing like this:

    Replaying down to root commit is not supported yet!

I hope that doesn=E2=80=99t cause any leak issues when I test it later.
