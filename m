Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516E2430F9
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="sZ5BjYRe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ih+i9kcu"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160D992
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 13:20:34 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 5D7CF3200A18;
	Tue, 17 Oct 2023 16:20:33 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 17 Oct 2023 16:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to;
	 s=fm2; t=1697574032; x=1697660432; bh=WCiARTe4vdJknje653milR2it
	IYZP4jV3ZY65QwEX+4=; b=sZ5BjYRey3eQnKzBcUl443MDNg9Gww7zyO9paudqU
	nRqN1EuNgN81OqHNb5oXy/4PgDjHLGZD1yFEZ64RSsZX5AZ+p+AMUYNzBdmNSvmY
	MXrDefYTrwLyOtg8c8AmRfrczvSUx0k0KqTpDV5+P3BpW1+39g+nhAS/RHPgPJK8
	+arwhasu2PxjCbC+elkOmLEorFRcypw5A+twPPfZB7Ww7reTkWTVE/fBluzBkagK
	+yk3IwDHhNsa0lX9Wq04EjQbB24j6ztIEsHMzl82mb5lIdZtoRwye5RJxFsiJNtZ
	2jpYwQZbonOkgwOkWglE6XB5T1fS30heOhAF4Nk8aT8VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1697574032; x=1697660432; bh=WCiARTe4vdJknje653milR2itIYZP4jV3ZY
	65QwEX+4=; b=ih+i9kcuJ/f0zI1/nSZGRLdrXYBpxSm+F/ONII8kI9K2bcFvt9n
	ROH1/2rrZmdbKksfxhKw3+CVciPMgtH+pjryHwau9DCKBq8qVqB4XnnruaaYIY3G
	ttDv7qwl/te4fOLqXiuSa8HzK1cp+R5qGvwjwzljTKv2shKcsgOZzwJ7UXfVyNCg
	rYHlRn12Sq9YtDWcdMCHb8RDXfi7mI/hsT8umEMK4uvOgm7nEqv6jEKDsB9qpO18
	vag/g/KBob5ANsr6UbVleiFv0d/cl9X093Hu24SJ40CygwY4Mtp7JjwsbkzGnpfC
	4UmyhaVLUhMkAO11Z5vDeZM4OtH1mFDMMcQ==
X-ME-Sender: <xms:kOwuZaOaa9sRJ7rs2zspMp8j1wYubkZDYE615oBnoC4GoNj6VL8OcZQ>
    <xme:kOwuZY9l-UlSF6aZs14g_91IM3m0-trRsjNa0O5WG3ZhStVSCy8T-w6rxPaP_0dBT
    MYhbMOCtPzPmqljHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgddugeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgfgse
    htqhertderreejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhk
    fdcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnh
    epvdevheeiudefheffvdetueevkeehhfeliefgkedtieefudetueehueeftefffedunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvse
    hkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:kOwuZRQQoyk_oAdzIx5R3rnqZ4tDnpiYjxM1AWZhP1J2CjzcEz309Q>
    <xmx:kOwuZas8M6oQ_YQwQYI0yQ1vxVe4FOvrhd0nrufEdLuavB9GdRhcGQ>
    <xmx:kOwuZSc7OvTq2rr4m3mZzG-e5bkD9qVsz8dTDW2gWOESXmVN877m3g>
    <xmx:kOwuZambMoy9_diPwJBq2h_kjhnQgCmHmjpFJrS6zvUrs4s9GefnYQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9963215A0092; Tue, 17 Oct 2023 16:20:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <655ca147-c214-41be-919d-023c1b27b311@app.fastmail.com>
In-Reply-To: <xmqqwmvlgg71.fsf@gitster.g>
References: <cover.1697319294.git.code@khaugsbakk.name>
 <e3987cda75e4db72393f85de4bbb71d2ebaa097b.1697319294.git.code@khaugsbakk.name>
 <xmqqwmvlgg71.fsf@gitster.g>
Date: Tue, 17 Oct 2023 22:20:12 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH 2/8] t7900: setup and tear down clones
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023, at 22:13, Junio C Hamano wrote:
> As I already said in my response to the cover letter, while I am
> surprised that the series managed to make each step (and it alone)
> succeed after the set-up (applaud!), I am not sure if it is really
> worth doing.  As the business of test scripts is to test git, and it
> means that we should always assume that we are dealing with a
> potentially broken version of git.  By running so many git
> subcommands in test_when_finished, each of them may be from a buggy
> implementation of git, we cannot be really sure that we are
> resetting the environment to the pristine state.  We should strive
> to do as little as possible in test_when_finished.

I'll have to think more about this part in order to understand the
ramifications. Thanks for the feedback.

> This is even worse; it has to redo much of what the previous test
> did.  Developers cannot be reasonably expected to maintain this
> duplication when we need to change the earlier test.
>
> While I am impressed that "set-up + individual single test" was made
> to work, I am not convinced that the changes that took us to get
> there are reasonable.  The end result looks much less maintainable
> and more wasteful with duplicated steps.
>
> Thanks.

I can rewrite this one=E2=80=94as well as others=E2=80=94to use the `set=
up` keyword in the
original test instead.

But dropping the series is also fine. I am still very new to this test
suite.

Cheers

--=20
Kristoffer Haugsbakk
