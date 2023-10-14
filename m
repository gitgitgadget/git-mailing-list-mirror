Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E5E1803B
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="LFhqSZ3c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aWc6cRP/"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C620A1
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 11:14:37 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 09A3E32009DD;
	Sat, 14 Oct 2023 14:14:33 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Sat, 14 Oct 2023 14:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1697307273; x=
	1697393673; bh=YkFQ5BSG4LYy4eQEYjC4JS8xV3Ju+38uwzZ/I9nHFFo=; b=L
	FhqSZ3cuDvb9bnKCyxTT/5USGSTl30smvLK1DgRaALZcjqK359troqB6pODYNqEt
	n9H7tXm88GWKuT3tGjLbB7F4osrVKeuFo/UFw/m5Ru39DH9iEMCirrGP53ErLpDt
	+kSnkjSMLBc8OywCb3jO8dug4UwuPf6HYwC2fLHbWzZ5cZAcYwMZTUZiyBQJqvxb
	5ddYt9ujzC9bFyfzQkSA2ItfY5PoDH1e8sMtMtJ0HioXKLtmQ8jnESspXkQoDVgY
	kCMM7Yc5/pWxZnH4lUng+a5fByFKG6Uu6VewUDjPBSe5V4iWK6sX7dKPz+LQ8a1E
	OgfVCYGPBThWBSFzdhaUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697307273; x=1697393673; bh=YkFQ5BSG4LYy4
	eQEYjC4JS8xV3Ju+38uwzZ/I9nHFFo=; b=aWc6cRP/o0WFt7fNykYeevprKI9tf
	t6rYfrgpOP+l+S/efvpb6LyU7oHj3lxhmDz3mDc2lGvo7adzhM0I7UoFjkcJr1E0
	HAUh8QpgdDwcl8GsTRYnODwbE0/U9Kl4c/M4Uvz8kPzn3jzC5M85wX4FB4Y9G5a0
	vrPl5kcRH97WeQ6VWe4y7c2BHlSeV8Wu2+zJdVoNmzlQrYuHIOA43f07i3i6yKgY
	WZYt75KizL9o7BsTipJEvxaReR1wd1jTJz1LeTQ2yhdUMjP/KhmSJrNehrv4Z8Cd
	Mu6lAWZjGXCejVf7qvcwnrxsev4a40by+eJR9enrfZuMDmfypeiXnyJTQ==
X-ME-Sender: <xms:idoqZVNjFySbNPCr981Sq6Is_rfPCCZIHAllSq3jzJl8XnbcAMM_4TY>
    <xme:idoqZX_4qzOIHTMO6_36ZN82-FTrzgmC9xIyWWdezqap92AeF9O-d2kGvSup5-eVp
    SQrijPLO0y0hLmizw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieehgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    dtkedtjeeiffelteffheeiheeufffgheelueeftdejkeeufffgiefhgeekffffueenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:idoqZURA76_tJy472wknaRiPv7O2MyPoB2hwZcD3WLcmyYwiTvFulA>
    <xmx:idoqZRvhLlg1siTO4GIFXXYNTWSJqTrp3g9akVaf4xlemnkYgzQyiw>
    <xmx:idoqZdfeW9UAPhKpOv_F0N0iml6iZWeBX62MujIGoBLnhhOnTbm0Vg>
    <xmx:idoqZTocobPcPGbJ_fiS82dPe5oyyiL8hTAYLoOP3LFQP4XJFE6iYg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 10C8A15A0091; Sat, 14 Oct 2023 14:14:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2d8eca81-0415-43bf-b3c4-f1163713422b@app.fastmail.com>
In-Reply-To: 
 <CAKFQ_Q_P4HvCMHsg4=6ycb8r44qprhRCGSmLQf7B3_-zy28_oQ@mail.gmail.com>
References: 
 <CAKFQ_Q_P4HvCMHsg4=6ycb8r44qprhRCGSmLQf7B3_-zy28_oQ@mail.gmail.com>
Date: Sat, 14 Oct 2023 20:12:04 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "ks1322 ks1322" <ks1322@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Bug: git grep --no-index 123 /dev/stdin crashes with SIGABRT
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi ks1322 

On Sat, Oct 14, 2023, at 17:42, ks1322 ks1322 wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> `git grep --no-index 123 /dev/stdin` outside of git repository
>
> What did you expect to happen? (Expected behavior)
> Ability to grep input from stdin
>
> What happened instead? (Actual behavior)
> `git grep` crashed with SIGABRT
>
> $ git grep --no-index 123 /dev/stdin
> BUG: environment.c:215: git environment hasn't been setup
> Aborted (core dumped)
>
> What's different between what you expected and what actually happened?
> Crash, no grep result

It looks like `setup.c:verify_filename` fails to deny paths that are not
transitive children (or whatever the term) of the directory that git(1) is
running in:

    $ git -C ~/IdeaProjects/ grep --no-index dfddf ~
    BUG: environment.c:213: git environment hasn't been setup
    Aborted (core dumped)

So `builtin/grep.c` goes past that check, into
`pathspec.c:init_pathspec_item` and dies at line 472 since that function
assumes that we are in a Git repository.

-- 
Kristoffer Haugsbakk
