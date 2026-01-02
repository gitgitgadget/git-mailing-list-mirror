Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A79B2248B4
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767347516; cv=none; b=bNPna80YsYxqzazf185ynxAVuqdMuvy1pjGFum/noA431GLepq/2zJ1smuxM352Sl/0B4ksV7D3KhJE74Z9rkBNwt7cSV1S47vdWAaV8Vs14t1J/Ux8EjFkoOcxtM7pM6Zj2/exMRNsGsK7IeQNe9IlUbS2Lo0xlMCjzJVJ53cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767347516; c=relaxed/simple;
	bh=k7BtTS6/RsZYSmsLPZrC7iu96n8LIrYEAeXx0wVfygs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ggUjqN41wzXGM9bz/L8C5xgyWqAF1il6jcnBmEgqF+xQ6nb3eNpdz3zUKj7At53AmIgnqA8Gok77RO0oraqcFCDm7iEuZLyH3wA1yY89Ze0sz8RtCalBOQhlpAr8eVnEe4cwFAOfi2ZEgri9D9Ut0CBPSfUx44dbUG/Ou9A2c5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=5nxfQOnM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fmSOZ8ex; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="5nxfQOnM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fmSOZ8ex"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B44E1D00077;
	Fri,  2 Jan 2026 04:51:53 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 02 Jan 2026 04:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1767347513; x=1767433913; bh=orvx1eqBvr9YRN1xA0+sMXINDeNuM08Y
	NaKrWGVgfdk=; b=5nxfQOnM/Y40dBU1dAAdou2ns9pwAVoIXUMtMqicKc9x2/So
	0ITZtmegFdS+BZVUL0EAfEUiRKbfR+lxU0nfEmw7/XkORESMM/aa9G0/pkolyU6D
	l76GPVD1Oxq7EK2zRG4UCAMmXnBdQ6YGSocEvTs2OQCzKHiboTXAzq5NQPYItCPb
	ESpP2F64ZoNHHZT2svCIz9D+qmLJR3N4kIu+PBlmmPAGL+26KIYPmciNrF0ZRNPD
	G91NTxJoaSnXAFOmUmDcXORUsYhmzOw6sj+1X7/2kmaTM+M2Bzd7AUVxLzGzP7/W
	LkWv362/AQJYxA0KpJVEl6B0MCC4ul4QKIWFUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767347513; x=
	1767433913; bh=orvx1eqBvr9YRN1xA0+sMXINDeNuM08YNaKrWGVgfdk=; b=f
	mSOZ8exA9/uAkfbmz0kW29/y9OROptWBeIsThrMX9dbX2JnGjQUjLewK7C9+QyXp
	nLMMlBu1YfCxrgC9DTHhxxraohrUyNuZVQjZwE1T7FNoY4qE/eOP2jNq1gZP5tta
	/5yDEtCNdEqy3lvGqfb2tqiwbLxw5zbP4brqH8KN8n97aPfcw7YC3yEtVFkUF8re
	Z3fFu05vNxTJ2Qc/32Yd7JZpkt2dTzBuQv2Hn7ycTr5G5CsJfjSaiBBnHekJoMb/
	gDSjxZbkpVf7RoH1pfxK8Z+yBkUfIMzwraAPXcjVbYenQo1bYkqpIwl7YOHNVbcR
	pAOQ4vjJePuuyPlxGYm6Q==
X-ME-Sender: <xms:OJVXaUd1yA3Syh5PMvmvvKud3D0W8jsnzlgkKI408cBKyhP-nH0Y4oQ>
    <xme:OJVXaRCNuoLSb6893sH5vzqOjivSL6vkRarjowKjB6aXxVkjjgdwrdXySAZfZWOle
    m5DyTiegTcoIN4rrJYADiDvXZSvuNO2endpxFbwvFgShR2fetLBTTY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekkeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeefteeghfegfeevleeguddvkeetheeiveffudej
    lefgudffffejleffffeludekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepkhhrihhsthhofhhf
    vghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrh
    hishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihr
    vghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnh
    grfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:OJVXad-fVNRXEt0DfEwhJHTe12UYTnaM3yTEUZBWosH7uThQwFmehw>
    <xmx:OJVXacqKbsKRzbemNbF9VjTe8e0gQpJAG-9iysUJMzGBKRdJXCxgWw>
    <xmx:OJVXaaAKA0ZETSwsJPJfXE_fQZUvPCvdJAhl3b51vrKP0nRX2iEiQA>
    <xmx:OJVXaWxKJRXeeOdlZGx-YaAxdIYEls5LzqrKStXFfpSpYKt5ZXwB4w>
    <xmx:OZVXabpfuLp4b7jdEqLiGv9hLihKShnfI4HPNX6qGMQHaWb1kAobwuxk>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 94F3A1EA0066; Fri,  2 Jan 2026 04:51:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ADZQXSRHJVtR
Date: Fri, 02 Jan 2026 10:51:31 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Elijah Newren" <newren@gmail.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "Christian Couder" <christian.couder@gmail.com>,
 "Siddharth Asthana" <siddharthasthana31@gmail.com>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Message-Id: <3dfe9f23-cf54-4162-a90d-69ef9788d6b9@app.fastmail.com>
In-Reply-To: 
 <CABPp-BEJV1XG62_hn_OiZ9q9S3jsyTP0VdOEzS4pME2rrkKFrg@mail.gmail.com>
References: <CV_replay_die_descr.13f@msgid.xyz>
 <V2_CV_replay_die_descr.17b@msgid.xyz> <V2_dead_replay_code.17c@msgid.xyz>
 <CABPp-BEJV1XG62_hn_OiZ9q9S3jsyTP0VdOEzS4pME2rrkKFrg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] replay: remove dead code and rearrange
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025, at 23:50, Elijah Newren wrote:
> On Tue, Dec 30, 2025 at 7:03=E2=80=AFAM <kristofferhaugsbakk@fastmail.=
com> wrote:
>>[snip]
>> -static void determine_replay_mode(struct repository *repo,
>> -                                 struct rev_cmdline_info *cmd_info,
>> -                                 const char *onto_name,
>> -                                 char **advance_name,
>> -                                 struct commit **onto,
>> -                                 struct strset **update_refs)
>> +static void populate_for_onto_or_advance_mode(struct repository *rep=
o,
>> +                                             struct rev_cmdline_info=
 *cmd_info,
>> +                                             const char *onto_name,
>> +                                             char **advance_name,
>> +                                             struct commit **onto,
>> +                                             struct strset **update_=
refs)
>
> Renaming makes sense, but the new name is quite the mouthful, and it
> feels slightly odd because "onto" is both a command line flag and a
> variable -- and the variable value is used regardless of which command
> line flag is used.  Since the variable is used either way, there's a
> risk someone might be confused by this function name.  Maybe just
> setup_replay_mode() ?  Or maybe others have other suggestions?

Yeah, it is a mouthful.

I can use `set_up_replay_mode`.

>>[snip]
>
> Looks fine otherwise.

Thanks for reviewing this round!
