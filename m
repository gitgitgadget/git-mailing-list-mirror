Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C466B187FE4
	for <git@vger.kernel.org>; Sun, 25 May 2025 20:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748206025; cv=none; b=P1W5BqtfFzNV6BpfvLahTe6qbSl9+Z68VDWAkurKUfqr20/SyO/2f21sQ3hHSQHXDr4cssnThOvmTdBlIKr5/yeRidF8mXQLtMqHUrvtkjmWqZrSgAfX/A3kU+2/gRO/w+pJDy3mj48VBnFN/DNxnjR3EAIu9kUY3QzzwlfsunI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748206025; c=relaxed/simple;
	bh=w3GyFBP40Utdwog+5pxrs9sX9uiCJeJ+LgTB4fJqEGA=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LAG/BBB1UnITNfkj4eouEImX5EoDr1Vyi3cWHTSpCmZHKPdFsGTiYHyTmp3JuVSXxa2604wc+qwL6xU36oe29extDoOjI3k8MllEgKbV7qEVtFMdWQr4U1EYq2PGVEDmZScSRLIJWdxBxsTwhS/WuEohTJZoDGp3m0Z89oqSNxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=ijO659Ky; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PT9HFZWF; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="ijO659Ky";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PT9HFZWF"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id A783111400DB;
	Sun, 25 May 2025 16:47:01 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-09.internal (MEProxy); Sun, 25 May 2025 16:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748206021;
	 x=1748292421; bh=KC9oMlvbc0gwX0xARetdoZ/3FOVgfvdqK/iqLWkmR/g=; b=
	ijO659Kyt01XCWpc7293zkEWFXXWxtqKdCyuysf2AND96sv/hfA63krdCTJNKmHG
	1r74xzevWcipE+a2v3aFGLvmZDQIbKTsS4Pw8s0szi6PDBpzrppRWgH9pwvbI1JL
	b6V90kLn5ZTUZOx1yKs4jXVKDJTbZ/96ii+z8oabIKhBel6pVGSy/sab6XW9OD+d
	m4psL8WQhawSkzJqNcsWNq2RuXC6DJt9N2REaXRThrE1cdULtG0wEpN451mNapBd
	f7J8fROgW6ysKcChrAlDF6PGTT645DeQ7HMnveDtJW5YuqvqnhycSmBLErFNkA8A
	hW+hFbmy8zZTB9K7/cMJyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1748206021; x=1748292421; bh=K
	C9oMlvbc0gwX0xARetdoZ/3FOVgfvdqK/iqLWkmR/g=; b=PT9HFZWFDW7qDq+ZI
	L6VAYNMEtUowyzdMapj3f7Ciy62YpV1wg0i7/d35uNNTxx3LukmSiENNt99sSuV9
	TSWYGtonTWJLdS6eePcDDggY+iPG5EaB5tX4rtU2TOn5v0Xxm24swb1fpHhv0AGt
	r4V6Qw8MN+JSRiEVgPhx+GTLDq8tck6eGyMLWRDxH4rrDPeVHiu14uDJQP0ZiNgG
	s9UrBUETCP3vb8CpO2EyVmo5wODgYOYMsAWFz3JfWu6KJEtSjQrkBv5MbTQGJiaj
	JJADas6FJ2NxIhtMu4WKoYiiwWHixxXa/SAoNMUUpm6wLV5OrFs2wQfIx6gwVa7T
	DPc0g==
X-ME-Sender: <xms:xIEzaM1lmX7bvWMXk1rvvLmQV9NEWrGPfJt_9mVf08iah2TdrMQPVyo>
    <xme:xIEzaHGiuJ9oWbcpDDijiSb0AiDdP8TaOZS5DRU__SDklLtu0rWd88c7Fea8ZCUSr
    -leQSBnipBZV5odmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduheeiudculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhep
    fdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgsh
    gsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeeuffehteefleeggfefheekjeek
    vedtveeulefhueetjeetjeehkedtfefgieeghfenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghm
    vgdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xIEzaE4IG5krK4KhdDyTbj_81YXaaXvGOSM1ntG0Appm7KuDgO6qwg>
    <xmx:xIEzaF0JxAoZZsW6K0Fm2r2tOokbMlxnimwakFKjBPsXIeSmtlVl3g>
    <xmx:xIEzaPFO4TlXwz-c6uik6g3MGnXY_R5CD2664RckDiZa86JC1KjPfg>
    <xmx:xIEzaO--7VZWUXGPLtz8k8yO7T-zhHYIsiA31O-SaajEslBOu2aJEw>
    <xmx:xYEzaHNlUWl6m4I5BgSnFxq-_mqvNti11XR7cJf-uCUCfS9ah8-KhsEK>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D3FF23020064; Sun, 25 May 2025 16:47:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Taf9fec3ba48f0e1f
Date: Sun, 25 May 2025 22:46:35 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Message-Id: <a3c252cf-dec3-4b2c-828e-f25e48853585@app.fastmail.com>
In-Reply-To: 
 <c59ae2c0c7c8420ec1c5bedb87f28c7f5b573a60.1748122397.git.code@khaugsbakk.name>
References: 
 <c59ae2c0c7c8420ec1c5bedb87f28c7f5b573a60.1748122397.git.code@khaugsbakk.name>
Subject: Re: [PATCH] notes: remove trailing whitespace from editor template
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, May 24, 2025, at 23:35, kristofferhaugsbakk@fastmail.com wrote:
> +	test_commit --signoff 23rd &&
> +	GIT_EDITOR="cat >actual" git notes add &&
> +	test_grep ! " $" actual
> +'
> +
>  test_done

Or alternatively I could assert on the whole template:

```
test_expect_success 'git notes add editor template' '
	test_commit --signoff 23rd &&
	cat <<-EOF >expect &&

	#
	# Write/edit the notes for the following object:
	#
	$(git show --stat --no-notes 23rd |
		    git stripspace |
		    git stripspace --comment-lines)
	EOF
	GIT_EDITOR="cat >actual" git notes add &&
	test_cmp expect actual
'
```

-- 
Kristoffer

