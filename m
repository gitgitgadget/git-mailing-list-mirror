Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EB7430EC
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 20:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="Iqk2+b7T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IPp/ApH1"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0F46FAC
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 13:14:26 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id AB2643200930;
	Tue, 17 Oct 2023 16:14:25 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 17 Oct 2023 16:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1697573665; x=
	1697660065; bh=BQ3Sey2Vmu7iPnqtzLaT9LjBGVOX0X9fXn68xOh0Pgk=; b=I
	qk2+b7TBdKeI7KZLw5lH8n41bFO1e1QpXxfuOPsGRApjPO61Vn7U4dmQA70TpawG
	AiX33Qxd7pvoeo80TkXaIt/v3bld3lC8TJvfYUChJkJRb2zeasXfNOebC80FdUnw
	EYQwk8gYQZVwc3+OXrDClL1/vVydx+aHN4wQynPR6VsAV3jkAHhqlLh2M/9xfpbO
	Z9gQafmtjR7cRBdwzjITBOvtqL8Y17aOxMjPfnk1ev8i3yDd0E+dIqBHpTkMw/sF
	LboInIooipq7sY2BhJUz5pRBbo2YwpJcsRvVaFOSY3LYdD0Cznrk0mLuKmU24OR/
	Tn9Ufurx6+zhXFQS46wPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697573665; x=1697660065; bh=BQ3Sey2Vmu7iP
	nqtzLaT9LjBGVOX0X9fXn68xOh0Pgk=; b=IPp/ApH1dTyaaCojv3exm8xufCSNi
	0SBhCjzTub//AOujE3w4h30IIzaTZg3/ZVUXfohEGngN4n67CYxf76o5qHSppYN+
	WHnQaTo8KpdlAV+YAViCaQ9Z69nfm0gsG4XBLdpQ4f44QLkQ2wFgH2m1CK3Vdh7h
	M1oVhCYD859SVkSlruNtO+SgYLvOhxnqPb/nmiIRbGdqV38OIhZDOmu2A63DD0e1
	9y8lEljokZ1PTesJSTEzPyxHQI2tukzWfMIiON2Kt3Hq7DVYvxFUCKWn4lshzbPM
	JpAPxIDM+re6WDQ+85FrGQncvQ5gqzYq8ozP4jzKnkCtgtQuoDjZ87RDg==
X-ME-Sender: <xms:IesuZfQUe0rjLR05QI0btRN7yFVVzXiMMh1PHPO3hWSzwBB0h29fMbE>
    <xme:IesuZQxAIXx5vEX-Ffy_jXybHEaVr4-oYQW4n1XHUrGYLv0bjhT5Tq3EUu7fDIpf_
    B9sprLES86tYPm1zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    dtkedtjeeiffelteffheeiheeufffgheelueeftdejkeeufffgiefhgeekffffueenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:IesuZU1lIyRQFv9qUI4iEL5zen3BTiYyBG6TaFtlwxG637SScgbFIg>
    <xmx:IesuZfC79J2Xwae2mXcKG0iBR6gBTVNYHEXiZtGeFUlxcELMUslUiA>
    <xmx:IesuZYhpkb_2jjXddzvhy1nJzGaiXVscZmke4iW1ZQF39m72J1Fv_w>
    <xmx:IesuZQL_6EMIjq_0Jlh9PFEbCbXK4rsEELjCbyeWoqmDXGfcCRoWHQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id EB4C815A0091; Tue, 17 Oct 2023 16:14:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8cd788dc-7d16-4cfd-9f70-7889dcaa7199@app.fastmail.com>
In-Reply-To: <xmqqbkcxhvf9.fsf@gitster.g>
References: <cover.1697319294.git.code@khaugsbakk.name>
 <xmqqbkcxhvf9.fsf@gitster.g>
Date: Tue, 17 Oct 2023 22:14:03 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH 0/8] t7900: untangle test dependencies
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On Tue, Oct 17, 2023, at 21:59, Junio C Hamano wrote:
> It is kind-of surprising that with only 8 patches you can reach such
> a state, but ...
>
>> # The tests that used to depend on each other should still pass
>> # when run together
>> ./t7900-maintenance.sh --quiet --run=setup,30,31 &&
>
> ... this puzzles me.  What does it mean for tests to "depend on each
> other"?  Does this mean running #31 with or without running #30 runs
> under different condition and potentially run different things?

What I mean is that some preceding test has a side-effect that a test
depends on. Or that the test depends on some test *not* having done
something; patch 9/8 changes `maintenance.auto config option` to delete
and init the repository since it depends on the preceding tests *not*
having run `git maintenance register`, since that turns off the default
`true` value of `maintenance.auto`.

(Maybe those last meta-tests with combining tests like number 30 and 31
was a bit silly.)

> One might argue that, in an ideal world, our tests should work when
> any non-setup tests are omitted (so, instead of $i above, you'll
> have an arbitrary subsequence of 1..42 and your tests still pass),
> and it may be a worthy goal, but at the same time, it may be a bit
> impractical, as setting things up is costly, but what you can do in
> the common "setup" will be very small.  Or you'll have so much
> "recovering from damage" in test_when_finished for each test that
> makes such untangling of dependencies too costly.

I don't know what the policy is. :) My motivation was that I was working
on something else which seemed to break the suite, then I tried to reduce
the tests that were run to get rid of the noise (`--verbose`), but then it
got confusing because I didn't know if I had really broken some tests
myself or if more tests would start failing by only running a subset of
them.

That last patch 9/8 deals with what I discovered when I added two tests
before `maintenance.auto config option`; the test started failing, which
made me think that my changes might have some side-effect on what the test
is testing. But it was just an invisible dependency on `git maintenance
register` *not* having been run in the whole suite up until that point.

Cheers
