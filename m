Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D851A289
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 21:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="CuPpszU7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lnzpjydP"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD0212A
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 14:02:28 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id A6FC05C01EB;
	Wed, 25 Oct 2023 17:02:27 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 25 Oct 2023 17:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1698267747; x=
	1698354147; bh=VtzZmzsDGOkchIcie0Ai3/IPk8+Zh4IC2QhL6FqX/W0=; b=C
	uPpszU7Wa8IePU7LQJzGq3z/TlqA/V7U7F22qGXdgkF0/CLxLMN2s9dBdYvZN6Bb
	8MFm9DUjGe39E5HxgCAQaTWt6VQvm53+1b9lIrj6YGlVtsd66JfFfh65jo9IqCiC
	nP5PORAQynrkJOX3rXxZxGQ8OqCrLa50MOzvyrrwMYjUJk4yNst78+QdWXYOS9tS
	8RgJ5pb3AT4yeDAxcSBKwloI9GnWIyHXlte8/VGdRNxB77LPNe+VgGZnVtmGPlb+
	xUsfThtWdmYKh5IPgL3GHx69d+mp4CrdY3U8KzCmVzyNkVmcxT44aG9TG7u/RQxk
	0ZlxvABh6uKmTfdDK/wKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698267747; x=1698354147; bh=VtzZmzsDGOkch
	Icie0Ai3/IPk8+Zh4IC2QhL6FqX/W0=; b=lnzpjydPd0hV1usQv0bqB9h0yF36u
	/43FfTlwuTAo5d2YgKW1ORSzC8vr3tQllSskdqULEJLokFklIxW8XWIvI7sc/GQj
	ydyki5SuOn7fBFPq6LoY7jXcKlxep82lOUj4rungNeWH7QkREku8n2OGAp5Z2ImI
	0CfwEim3zmqWYPzs/Mgb9Nhl2SvbRiPtbCeh1G5s9cV52Ep/v9rBWupOnl7zdtgc
	ycbzZYZyNcKYFULD9hsz9QnBzqhoOloj7aMP9FyFikTw7nQyRrjffuepO741Kjzt
	IokbSe8HQYlFRzAlyWhzC+8fu4MQhO1QnPJ0bedyLxs15jVy3j4Vhy7uQ==
X-ME-Sender: <xms:Y4I5ZQbIpH-72qXSvT4N5X2yc-leTFfuFdD-fra8EO1BCZKPdtfQwJs>
    <xme:Y4I5ZbaqXEZI-dekhib4mzKAAqrvrM-D3SGjXOr29_SQgwXer4R1Mq7xKQzonG0J_
    lIvfm_U5iY4e1SIUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledtgdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    eukedvjeffuedugeeuleetueefveehhffghfejtdehleduffefheeivdetleffhfenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:Y4I5Za-L_GHi2qg53QodYYOfDjdtoC4YcjKMxjN2fobZ2DajD9TRbg>
    <xmx:Y4I5ZaofPmr-FQEjIhS952bBTcTm5F0gzrEf7RaaXc7DWGZrKz9jqw>
    <xmx:Y4I5Zbr74eXjnCC_FC9HXxvIcJXvtP2_HSYjQmEpVMrcqx8QoZtu8Q>
    <xmx:Y4I5ZVE-C8Y61dXM8s7FJHmVGv3SbrCi3i49vtl8MJNbbUq8dbdChw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 31B0915A0091; Wed, 25 Oct 2023 17:02:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1f1e89c7-6502-4a01-a99b-df191f1d733b@app.fastmail.com>
In-Reply-To: <3e409165-2468-47be-895e-f3ec86b94730@gmail.com>
References: <3e409165-2468-47be-895e-f3ec86b94730@gmail.com>
Date: Wed, 25 Oct 2023 23:01:14 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: Sheik <sahibzone@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git diagnose in non git directory results in core dump
Content-Type: text/plain

Being worked on: https://lore.kernel.org/git/CAKFQ_Q9WjF9i-Rx2jdCw-adPVQrWNfNKrDY-em8Rpa5RNLXz4A@mail.gmail.com/

-- 
Kristoffer Haugsbakk
