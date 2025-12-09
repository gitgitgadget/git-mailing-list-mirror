Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90B84315F
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765303458; cv=none; b=jY3lIRJO4g4mB5VcyI5MU8M75G7zYRWLajJpAGj5jhO1cy6Fh5JqsH/I/eYsvU/LPh4uwFaDJPI2ylM2PmqvQL5aojfC2YF7ogDTdEQoJtXbJQ54rmvSXWrURCrbWL8MKvUR6Wz9i8OV0/iOZjK/IGGKpYYWtTRAbGqVjnvZX2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765303458; c=relaxed/simple;
	bh=tzp0EYzXUB9aEbbuJO2uEMPIszXt1a96t0PkL4QgIyE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=H/i9rdv/Md39o7LyNGCiZYv2EB05m1D5kG83OcrtMTgP1q9O+AJJpR681FoICgfl+VS0BdW5Qy/utmwcI+yIMZPAnzuMpFyb8K7wzvrzeHI176ods59TnmOjOp2itJ8qdoDp+Q6eEVf3IZXWxhNBc2jUublM+vCFXqNY6bqs3ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=pa86uIdc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n++9rIve; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="pa86uIdc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n++9rIve"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DD58E14001E5;
	Tue,  9 Dec 2025 13:04:14 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 09 Dec 2025 13:04:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1765303454; x=1765389854; bh=+KBcpZ+ImVYl9a8oFs+OZF3fzEE4TBbK
	AIQczYQN7Os=; b=pa86uIdc3XZ/vLeWVNZUcHP/to+in23ApBHurRyGE28kFTUt
	zafOvB3bMGiAS80lGgI5Wmxb5Q6VNpmF7udNdhyMZBC7y1TT4izEXdcK2Rq46ZTj
	5geIwiFEfQtSg9R8TcLIFfMFrpHHfYsPTeDd2rTumaSTKwKiJZ/iz3Q5Lf5SWAZT
	6iBIMaIDmcu0xRd5qwRQKmwqzDKdpjvSJ4fn55DFQr3f2iQ7NB52bNqJDTfXmbEW
	wC68aozp0K3nYZleEJ0FGIEXAeVp+PXi2ugAmZo48Q/jd6af5FrRSYHz9avk7PPg
	wNg5NG75MqvWos+j6DDVQq+8JpLKQZ0PmaN1Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765303454; x=
	1765389854; bh=+KBcpZ+ImVYl9a8oFs+OZF3fzEE4TBbKAIQczYQN7Os=; b=n
	++9rIve+CfjgUp7gYUtkXPUsUiGuGrdTDk0YjpnLnVmhXpQcYBDMLNdTy0Uwcw35
	szLF6foScSl3otezMLjMU0Kzq9eLnRJnbZX/jXTEGnFdLUARBdZURKCyh+DgP2NA
	m/4iUlw203i5o3N/C2qtfbXHxXadsFpKdz1BFRHjjqdZqb1SikGZ9eLsEOFh+3xN
	Rp7rsGZ+8QPf9NGWTWiHxAczgFOweWLOOmTuF98bAqQ86pBrg8kleTiuDDi3b6rT
	/yo9GozufZGm9tOuv4jmVbV2sENE/PcZ87M0dWPcrZDLa7q/oJRR7G0sdoM0nDp6
	9NvLn0bSOFANGkOi1NHPQ==
X-ME-Sender: <xms:nWQ4aXp8EcElKCjn0AqrIliIAp7H_Apbioo2vGtWpEi03_Va2x_YtLQ>
    <xme:nWQ4acdvTlInOS3Z1tMHK_5o8SZNR1UDvHNwC6B3K8QJxZNysSO9lP7sPED3czbps
    xXYUcwUTegJKz9C0hwqQxEDkzb0yGAHDNKmMu_MPoO_YnFJsfHLg84>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeefteeghfegfeevleeguddvkeetheeiveffudej
    lefgudffffejleffffeludekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepkhhrihhsthhofhhf
    vghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrh
    hishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihr
    vghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnh
    grfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:nWQ4afqzXYzYBZucDMSfrlEWYJRBhiZj1oqe4gYyXTFLbwxhNLAkRg>
    <xmx:nWQ4aVo7yIr9iKKIOxlR2Sr8597neJAm-Zcd0C8RMkiLagW3xXc8-g>
    <xmx:nWQ4aeZxT0KyMyvCmRvUiUDt00Wt2Cn_CYjQWI9ey8B9zXqYgWi7bg>
    <xmx:nWQ4aT8D5EJHor5WUxwnVIPM6dLVGn5U4zFxLIRftaLXaCOJKKu1Qg>
    <xmx:nmQ4ae2p_pfW9GO3PpfE07sZnZk-UyAwFwyyUDcG6hqwiQmvIds375mI>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C44991EA0066; Tue,  9 Dec 2025 13:04:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_-Iu8LU1e_w
Date: Tue, 09 Dec 2025 19:03:51 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Christian Couder" <christian.couder@gmail.com>,
 "Elijah Newren" <newren@gmail.com>,
 "Siddharth Asthana" <siddharthasthana31@gmail.com>,
 "Toon Claes" <toon@iotcl.com>
Message-Id: <202f7015-1e7f-493e-bd82-474e5cefdf01@app.fastmail.com>
In-Reply-To: <7d0201aa-905c-4da2-932d-47666c923875@gmail.com>
References: <CV_replay_conflict.101@msgid.xyz> <xmqq1pl6lzt6.fsf@gitster.g>
 <d2a72ba5-ac7c-490f-9f2c-6cf849e65180@app.fastmail.com>
 <7d0201aa-905c-4da2-932d-47666c923875@gmail.com>
Subject: Re: [PATCH 0/3] doc: replay: improvements like "mention no output on
 conflicts"
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025, at 17:00, Phillip Wood wrote:
> On 08/12/2025 07:28, Kristoffer Haugsbakk wrote:
>> On Sun, Dec 7, 2025, at 22:58, Junio C Hamano wrote:
>>> kristofferhaugsbakk@fastmail.com writes:
>>>> [snip]
>>>
>>> The second one looked a bit sketchy, but that was the phrase used by
>>> the log message for c4611130 (replay: add --contained to rebase
>>> contained branches, 2023-11-24).
>>
>> How should `--contained` be documented?
>
> Maybe something like
>
>      Update all branches whose head commits are replayed. Requires
>      --onto.

Thanks for the suggestion, and nice catch with the `--onto`. Very
personally I don=E2=80=99t like involving =E2=80=9Chead=E2=80=9D termino=
logy. Both because of
personal biases[1] as well as introducing =E2=80=9Chead=E2=80=9D as a no=
un in the doc
(now it just talks about `refs/heads/`).

I will discuss the current phrasing =E2=80=9CAdvance all branches contai=
ned in
<revision-range>=E2=80=9D in my next email.

=E2=80=A0 1: I like the school-of-terminology that says that branches ar=
e just a
     particular ref namespace that point to a commit; a branch points to=
 a
     commit, that=E2=80=99s it, that=E2=80=99s all a branch is. Contrast=
 with the
     =E2=80=9Cbranch=E2=80=9D gitglossary(7) which says that

         A "branch" is a line of development. The most recent commit on
         a branch is referred to as the tip of that branch. ...

     This is both more involved and causes pedagogical headaches as
     people start wrestling with where a branch =E2=80=9Cbegins=E2=80=9D=
 (it is a =E2=80=9Cline
     of development=E2=80=9D after all) in the face of inevitable moves =
of the
     branch where it started (but the =E2=80=9Cbranch where it started=E2=
=80=9D is of
     course immaterial; it=E2=80=99s the commit that that other branch p=
ointed
     at *at* the time that matters ...) ...
