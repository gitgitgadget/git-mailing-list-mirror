Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316F22EDD7D
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123722; cv=none; b=fMg7bzsOhcYTgPkdfajhk0m7zvfDgJObaewMcYdEWSWuPVh0iCYL5Tc/iJcuRayio9h8+oTPUxEqZuskyVLyVTggWLKv6Xd04UHrW6kQ95ElDA57l4+JyCoLTY3kEnihIjbZuAtEqwVQfUxWI4fwNVTnuLmzj7FiAm/yxm3UlKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123722; c=relaxed/simple;
	bh=PJWwmwHgw4bA1wer61Tg+JkAxIJrl9ptrBDAS0VLhrg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=C3dzTYc+wInVl2gxsmeY9O8tExDeG8k3mA3DCUG9PpiP7zdqRZfT41YvIE9x0zH3rFxRC9391/8Ud2gW2AxJ8F6JAZ+h1xFoia7ColwhZuDvU8QmGlE3rJfNtAhvYrOLzKg90n0Z3tvAd15t1EyJHBppmr3BkLesy9TmExlKczA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=BD3kHfIJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GDS2vCl/; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="BD3kHfIJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GDS2vCl/"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3F6511400128;
	Wed, 17 Sep 2025 11:41:59 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 17 Sep 2025 11:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1758123719; x=1758210119; bh=fJWc5AJizkmgMMRbYtmb9Tv7g0fxJgx3
	mRFtnaaYs50=; b=BD3kHfIJxV2CphJrbY/vauTs6tbvSkoAVCB1uhnEvf7FPkuk
	1wqDGOHZd6oDj6NADwDatanfca2ulwfZKOitBwRUTxmUcm3tJxwDgifNW1stOqn0
	0smvQzJm6Oo02BqnafEmyu3npHaVFRBtEe62IKONQ5KHQBTqYyTFdbMKoSe7NS8W
	PENp64xHXjNRGi6Um6ndO5/fSVSpn1QzZH9HQKzUeydJTCT6A0SCc76pLQEfDRf5
	WnW+IwG5rbxKG3vv9VfT7J3OcV8nBd3jgWwY7dVGzHMW6nezL4nAhqVqeCuB5oPP
	nTPA7F91XbloW6A2BhK67Ch4rkk463KfksWAvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758123719; x=
	1758210119; bh=fJWc5AJizkmgMMRbYtmb9Tv7g0fxJgx3mRFtnaaYs50=; b=G
	DS2vCl/7cRN65L73SPG7EEkYjqnenA6q5fF32JOvQ4J4VhL4v9+kYlVOPrkH3A+6
	wJUkiB5gVWa7hROUKfvFAJAFrsbcMFOgr81f3WPLcWS4Cz2eZdROfc+m3Co1aVMe
	RCoVvKjOjyM59WbYXzXS751xvlqcUnTQCiNs6vtqNr004MyWbQNfR5TFx8X4+5zM
	iqahlacBNy6Sf0bhseD3z6z2En4pVSGfbBRi/YX3fiuBlJDZcSV+Iw9L5NGvU1jL
	/F1Lsr+XNg7ZmhV6qmsiS4iYUs6AUTKaQVLW+b0gR2iSBSH0ytprNrxp+qIBTgGZ
	2UP8IcDBvfxYb7Fp7g3gw==
X-ME-Sender: <xms:xtbKaIJTgvvwmjWCx9qc_DJpXbzJN1XvBvBQI1xTTs-EgMDOAHcsU8k>
    <xme:xtbKaIJ2Ui1i5AATbkIOyqvDwYGs4fJtJSCFhJKEsgJgW3a4ARBmPsKwDRp0iBhOc
    4l7VlSliM_MtDs-Zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfeekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeefteeghfegfeevleeguddvkeetheeiveffudej
    lefgudffffejleffffeludekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsuhhnshhhihhnvges
    shhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:xtbKaCmoqvm_1Qpf_JConrKwg1BjR3He3iwG4oJuDQOa1cRaWgtr0A>
    <xmx:xtbKaKk-AJv83sPDmV9avuT9p9es4ZZPJ_U6fKTPvas_WDTZH6Dbgw>
    <xmx:xtbKaMyiYhjfNGnqshZJCRipCfZpmzddv9NBINk3KZ7uAB91-YE7Ng>
    <xmx:xtbKaHoPWwpQvnS9exgyUK9n0MZO9w1IRM27IKinl6blFtHwErgxcg>
    <xmx:x9bKaCfEKXGcz_NqyAOx0LIwBbBJgkSKrUBLEQxZHI9P8T6RImoOWrRb>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B0C321EA0068; Wed, 17 Sep 2025 11:41:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AlY6N3eOzH-Z
Date: Wed, 17 Sep 2025 17:41:18 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Jeff King" <peff@peff.net>
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org, "Eric Sunshine" <sunshine@sunshineco.com>,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <8673bb92-6bc5-47b8-bef8-bd59669f095f@app.fastmail.com>
In-Reply-To: <20250916232446.GA1189675@coredump.intra.peff.net>
References: <cover.1757446619.git.code@khaugsbakk.name>
 <cover.1757879060.git.code@khaugsbakk.name> <xmqqy0qffrri.fsf@gitster.g>
 <e4fc3b83-15ca-4844-92c6-1f41169161ed@app.fastmail.com>
 <20250916232446.GA1189675@coredump.intra.peff.net>
Subject: Re: [PATCH v5 0/8] you-still-use-that??: improve breaking changes
 troubleshooting
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025, at 01:24, Jeff King wrote:
> On Tue, Sep 16, 2025 at 10:47:58PM +0200, Kristoffer Haugsbakk wrote:
>
>> Thanks.  This is (maybe you surmise or know already but) a
>> problem when on the branch itself as well.  I did some compiling
>> `WITH_BREAKING_CHANGES=3DYesPlease` and it seems that 07572f220a8
>> (whatchanged: remove when built with WITH_BREAKING_CHANGES, 2025-05-1=
2)
>> made it a hard error to call `whatchanged` after its death:
>>
>>     $ ./bin-wrappers/git whatchanged
>>     fatal: cannot handle whatchanged as a builtin
>>
>> This seems fine, although I would have expected it to say something m=
ore
>> neutral like =E2=80=9Ccommand not found=E2=80=9D.
>
> I think the breaking-changes code for whatchanged did not update the
> Makefile appropriately. If I build with that flag:
>
>   [make sure it is not here]
>   $ rm git-whatchanged
>
>   [now build]
>   $ make WITH_BREAKING_CHANGES=3DYesPlease
>     [...]
>     BUILTIN git-whatchanged
>     SUBDIR templates
>
>   $ ls -l git-whatchanged
>   -rwxrwxr-x 140 peff peff 12104368 Sep 16 19:15 git-whatchanged*
>
> So we have linked it in the usual way we do for builtins, so that
> git-whatchanged would "work". But of course since it is not in the
> builtin table, it does not:
>
>   $ ./git-whatchanged
>   fatal: cannot handle whatchanged as a builtin
>
> And then because it exists in the exec-path, "git whatchanged" thinks
> that it can run the dashed form, so it produces the same message.
>
> We probably need this:
>
> diff --git a/Makefile b/Makefile
> index e11340c1ae..9311da5bb1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -883,7 +883,9 @@ BUILT_INS +=3D git-stage$X
>  BUILT_INS +=3D git-status$X
>  BUILT_INS +=3D git-switch$X
>  BUILT_INS +=3D git-version$X
> +ifndef WITH_BREAKING_CHANGES
>  BUILT_INS +=3D git-whatchanged$X
> +endif
>
>  # what 'all' will build but not install in gitexecdir
>  OTHER_PROGRAMS +=3D git$X
>
> but annoyingly an old build will leave git-whatchanged in place and
> cause the same confusion. And git-status won't even notice that it's
> leftover because .gitignore mentions it. But we can't drop it from
> .gitignore until the non-breaking-changes builds go away entirely. Yuc=
k.
>
>> What I don=E2=80=99t understand though is this:
>>
>>     $ ./bin-wrappers/git -c alias.whatchanged=3Dstatus whatchanged
>>     fatal: cannot handle whatchanged as a builtin
>>
>> People have been saying that people can at least alias `whatchanged` =
to
>> `log <something>` and then it will work after the removal.  But now t=
hat
>> it has been removed (according to the commit message) its spirit lives
>> on and prevents reusing the name?
>
> I'd have thought the alias took precedence over the stale executable
> file. But it can't, because "whatchanged" is no longer marked as
> deprecated in the builtin list. Because it's not in the builtin list at
> all! So it is just a "normal" non-deprecated external command from the
> perspective of git.c, and you are not allowed to override it.
>
> So I think the alias code is working as expected, but the stale file is
> causing the same confusion as above. Deleting it makes everything work.

That=E2=80=99s great, I think I understand.  It is my understanding that=
 the
change to `Makefile` is needed for the test to not break when
`WITH_BREAKING_CHANGES` is active.  Well I tried now with a *make* after

    git fsck -d -x -f

And it fails the same way.  So I=E2=80=99ll just steal this change... (a=
s well)
and include it in preparations for the others.

(Thanks so much!)

-----

Draft of the commit message:

-----

Makefile: don=E2=80=99t add whatchanged after it has been removed

07572f220a8 (whatchanged: remove when built with WITH_BREAKING_CHANGES,
2025-05-12) set up the removal of git-whatchanged(1) when
`WITH_BREAKING_CHANGES` is active.  Part of that work was removing it
from `commands` in `git.c`.  But the the Makefile still lists it as a
builtin .  That leaves it in the limbo of being linked but not being
callable; you get the generic error about not being able to call it as
a *builtin*:

    $ git whatchanged
    fatal: cannot handle whatchanged as a builtin

instead of the expected:

    $ git whatchanged
    git: 'whatchanged' is not a git command. See 'git --help'.
