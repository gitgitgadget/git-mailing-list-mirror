Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE9920322
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758055703; cv=none; b=Wg4YrQUiZ6d8T4jQ3+JzY12Viq42sBm64pKgVbq83Y/RqqbVMIguKTXwyNAm32V5vsTjvrMUrdZH7hn7C0pCnG4egV+L4zKkeME8/shKCF/2pH8iVhY0+TOCNX44Br4lokCeEyXPlld8dZWUK0xIqC2/6FfSkhJFMPb3E31z01A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758055703; c=relaxed/simple;
	bh=N+nJ4Uk/IHS0EK3COxA5lmKEk5UgrvUbksc934DlZN4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=B32Xe80DppOaFc+uIe/Mgxr5F9QiSDZmITvvGZ0fzU5uQvw8scfkQA666z53gvjR7DRJ5JVaIc43xhbjg3rLTi1qVvME+AmqQd4pHgE5MGIC4XQSKUhanpCYZy7VqAavozam6eqDtmSRye0P0yH0xRL88Qvhb7iz758WZbfIZWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=nCIEENH8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hEVTtQcM; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="nCIEENH8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hEVTtQcM"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id DCDD7EC0241;
	Tue, 16 Sep 2025 16:48:19 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 16 Sep 2025 16:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1758055699; x=1758142099; bh=X3W+u3a9x/Y4fneBYCaQEfpEtUBAQESn
	DpE77KwRgqI=; b=nCIEENH8i8Bv7cxwcg5BGWNppr3/FQvGlwp5jqaxUg+0xeg7
	n9STpQeNqtayx7yE9hSbQNrLxCITAlkzpK9LtJpUhNsBXP4EPNYpxX5E4z1QaUJ9
	nZ7V4/uQSRYyyL87SjxZn8djST58YpjU7yBoDsAsoMS3/3vctfY0vgRa9wrOc7AQ
	JOwjPYX5gOi2qVG0JsI1OpVBN4VFWDrkmkqU9z5nQcYIphlxRUfLiTmc1xq+aDeU
	oxEk/iT2sQdqiAb/DcLyFSEHcRRJ1sTuWhUjrryb7uKH1HXSe0TNVrrc8focLJll
	OWULOrM0WsnkF6P7UolVO6F2TulxpJKaR/NszA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758055699; x=
	1758142099; bh=X3W+u3a9x/Y4fneBYCaQEfpEtUBAQESnDpE77KwRgqI=; b=h
	EVTtQcM4HGnBd9u9l9BnzoIs/y+E/OWVOJ2KSppW3qnyEsLwEC9cyccE2T5VujZr
	2Ysfbt41gaJCl7gRZzi8TkFwZv/4h9mE7CylBK15LynhSSQriQcoWohCV4+4MBfB
	ggPCoTgotBTdKbydmFMcp+bf8R09a8BOKGRC13n+xeeS6wa3NopL7rE2ZHBHXVl+
	DswIo/JBwnUPjFpOre7/fsBfv92wWSbdX9049Blo2KX4AQdDTH9ZhuQpaXWFrbVv
	zAaghPlQH89PIRTia0JrXveygjQEGNP2SH+IDvWdPCtPBFQ2ianLhMJPSUXSmDeO
	kMEDs2fi238jl6WTtY2lA==
X-ME-Sender: <xms:E83JaEeeeS9tP-Z3mho8iJIe7t9fnq19FC8hAjBFgpQjYIYjz2MT7e8>
    <xme:E83JaGNKZj7WfRnGZRtj2r3JS0M93VglaijXzKdqFVut7Tx1REo9tDOo6MROND9qb
    FIhQEQjplFEf5hj-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegudehjecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:E83JaA691E-n2ODnj_gcfVCb6gVc2JRkoJTxTOQAtFn_nEwOLMWLNg>
    <xmx:E83JaCrizPLf0BCZwnNmMiObV8ukftd_1ZHq2qne1v-RAvfYjW4hMg>
    <xmx:E83JaLkmVu5GN7uADglAQUTMqBWBnpt1S21VUw8GVbJhFAK0OUNc_w>
    <xmx:E83JaGMpDRAsio3gqvQQgEPr5Pupk1EHaXKnzvzSiDkV44eLxC7oZw>
    <xmx:E83JaG4G9eWL9Uvs5t1L1DKAw9T5mLTf5y9gM5bl1ilNLXbpdpHENziL>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 499BB1EA0068; Tue, 16 Sep 2025 16:48:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AlY6N3eOzH-Z
Date: Tue, 16 Sep 2025 22:47:58 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "Eric Sunshine" <sunshine@sunshineco.com>,
 "Jeff King" <peff@peff.net>, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <e4fc3b83-15ca-4844-92c6-1f41169161ed@app.fastmail.com>
In-Reply-To: <xmqqy0qffrri.fsf@gitster.g>
References: <cover.1757446619.git.code@khaugsbakk.name>
 <cover.1757879060.git.code@khaugsbakk.name> <xmqqy0qffrri.fsf@gitster.g>
Subject: Re: [PATCH v5 0/8] you-still-use-that??: improve breaking changes
 troubleshooting
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025, at 21:19, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> =C2=A7 Changes in v5
>>
>> Fix the leak that Peff found (with Peff=E2=80=99s suggestion).  Also =
fix (with
>> Peff=E2=80=99s help) a regression where you were able to get into an =
infinite
>> alias loop specifically when using deprecated builtin names.
>
> When merged to 'seen' and run with WITH_BREAKING_CHANGES=3DYesPlease,
> looping alias test would chage the behaviour, and the test needs to
> be prepared for it, I think.  Here is how t0014 fails
>
> expecting success of 0014.4 'looping aliases - deprecated builtins':
>         test_config alias.whatchanged pack-redundant &&
>         test_config alias.pack-redundant whatchanged &&
>         cat >expect <<-EOF &&
>         ${SQ}whatchanged${SQ} is aliased to ${SQ}pack-redundant${SQ}
>         ${SQ}pack-redundant${SQ} is aliased to ${SQ}whatchanged${SQ}
>         ${SQ}whatchanged${SQ} is aliased to ${SQ}pack-redundant${SQ}
>         fatal: alias loop detected: expansion of ${SQ}whatchanged${SQ}
> does not terminate:
>           whatchanged <=3D=3D
>           pack-redundant =3D=3D>
>         EOF
>         test_must_fail git whatchanged -h 2>actual &&
>         test_cmp expect actual
>
> --- expect      2025-09-15 19:16:26.340366359 +0000
> +++ actual      2025-09-15 19:16:26.360366313 +0000
> @@ -1,6 +1 @@
> -'whatchanged' is aliased to 'pack-redundant'
> -'pack-redundant' is aliased to 'whatchanged'
> -'whatchanged' is aliased to 'pack-redundant'
> -fatal: alias loop detected: expansion of 'whatchanged' does not termi=
nate:
> -  whatchanged <=3D=3D
> -  pack-redundant =3D=3D>
> +fatal: cannot handle whatchanged as a builtin
> not ok 4 - looping aliases - deprecated builtins

Thanks.  This is (maybe you surmise or know already but) a
problem when on the branch itself as well.  I did some compiling
`WITH_BREAKING_CHANGES=3DYesPlease` and it seems that 07572f220a8
(whatchanged: remove when built with WITH_BREAKING_CHANGES, 2025-05-12)
made it a hard error to call `whatchanged` after its death:

    $ ./bin-wrappers/git whatchanged
    fatal: cannot handle whatchanged as a builtin

This seems fine, although I would have expected it to say something more
neutral like =E2=80=9Ccommand not found=E2=80=9D.

What I don=E2=80=99t understand though is this:

    $ ./bin-wrappers/git -c alias.whatchanged=3Dstatus whatchanged
    fatal: cannot handle whatchanged as a builtin

People have been saying that people can at least alias `whatchanged` to
`log <something>` and then it will work after the removal.  But now that
it has been removed (according to the commit message) its spirit lives
on and prevents reusing the name?

Am I missing something here?
