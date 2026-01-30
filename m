Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB7A3559C3
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769792082; cv=none; b=Mrbr54izfwFHB4LR4urUC4L8HlRvICVbSMW2U0MfP7wM+Gm9zgI/3FtKDM1ohTKIL406WUpMI4iIbHaERe18UrD5vdCjXZAE2kuuJ1WCy4gT4LuNYVzuAE7XGRAyZMvg0ObQ30eEFtg8oE8L5nCvNvfyCYpC/bKvL1DPa4Xoa6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769792082; c=relaxed/simple;
	bh=euCrcPc0U/J+pg9UYeFdkjX8QElo86ELI3gaDevfodM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=E3aGvMX0Z+UNfv7gsBiTQk88S6tsLk+8cy7xeESihPwRERQeqodL9vpEGjjDPmdEA1G7B6+QlKiLP9/B8mTdDujOYehLBgqU6jD9RkBsPR+LPO7LfOZiblZOXNEpPqNwe1OpfGE8nZK7J7ZVS25cGHf9uQrUEgMvmlMnrbeEtQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=qlZ3YxJr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qWtmcj06; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="qlZ3YxJr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qWtmcj06"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0EF947A0133;
	Fri, 30 Jan 2026 11:54:40 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 30 Jan 2026 11:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769792079;
	 x=1769878479; bh=OJrucrq+B94Rtun/IThb7Xtn4kjOj98pMOH0U7Hc0xs=; b=
	qlZ3YxJrCOu3Rmed2gFhVCnqoh2JVCBZCIgM+3qbyj0vz1ScwlcMqBn/1G/3sNHF
	sYTo5abwbf6tgKdvwbSJvDsMWgb3o+CskjcQ8puPi12xmYBQAqGl1luiquJnKb5G
	8P4ki6tMmsMAloo7+zRj/xsopPo3WrkVaJGnBQh1klZhHuZqb4hyBzTFatMXI7QE
	tJA9DBlhqjMzNalWkDWhtm6oa9g9gmS7J/QdoJWp28WRwejqNQEmRTo6AhkPubIp
	RwcEWXl9Gp5PtnspzZNBVaBhXsP9V5MmtlvUl45PwmGDeTIuHVeXK5RjzonFggbA
	vvEhRLbtWIO+cNC0Q8sIaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769792079; x=
	1769878479; bh=OJrucrq+B94Rtun/IThb7Xtn4kjOj98pMOH0U7Hc0xs=; b=q
	Wtmcj06MAh98TR+TZ03aKhT8oCmS+l0nJ0wkMzG3HbM8RIZUScXej/XC9QUp6/Rc
	q2cHs5hOBwj4tynK6K5TGe/osXwYqTb2wOtHLmL2gm69yLmdkbtISZiQyw82RBBC
	YmDmhOHksJ5UFmNO+l2khioi76lWx4sSQmoAwErKZckpMesEvBTYY6LL99xMNvrs
	LmWq1unqIX7jgoWv0HOB07M5XXen1ITi7TgBQ6JloRe1t7oObV8rLEMOWbdl5rxs
	qwBE//p6CO9q2xmvIh6lEBoIYI3PyrM1RbQBOIbEMoIae8Vthfkk4L/nZmDYig+Q
	M5yRsI3VZWCeYCD1tG8Xg==
X-ME-Sender: <xms:T-J8aRVHHIOzuFa2JsvSYnRoFizEbXpt1ErLFHtg83sL7HsFVn_q96A>
    <xme:T-J8acb10dOkUWz4hBH1sPU3-MG67h-Tf0UtNRE8Ns7iRLluFkd22Qa6Jc-HdJoAh
    j6V9-BmXl3NfD3t5cJAJ3Piil7ghtWTUHzC_zCUXISqXLnasAc9HjE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:T-J8aQS5h8RfNKvThymrSDS_M_jQ_VZQFxTEfrqcvNbfIRZuDnCmCA>
    <xmx:T-J8aVjifY4OxpQpR4b5JrHkJ80ai-raXtmga3WuL8gm4-xKyn4AdA>
    <xmx:T-J8aQ7rdSgQL22hgzGas5CfRABf0dhLw8fbcrN856B5vcEb3g_ijQ>
    <xmx:T-J8aSAq3QptK81W-k30EXXYekzSidpdqsQoxE31ChcErTwHkGeN8A>
    <xmx:T-J8aWRxOoReewu650wgS3ySHZFB5ZlGtb_zu53aL8UQKy4zacona2Z1>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BEB731EA0070; Fri, 30 Jan 2026 11:54:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5dQvCCpYqNV
Date: Fri, 30 Jan 2026 17:54:19 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: gitgitgadget@gmail.com, git@vger.kernel.org
Cc: "Harald Nordgren" <haraldnordgren@gmail.com>
Message-Id: <7b62316f-a30a-4895-808d-baa20be0f3af@app.fastmail.com>
In-Reply-To: <pull.2183.v2.git.git.1769779599196.gitgitgadget@gmail.com>
References: <pull.2183.git.git.1769700352081.gitgitgadget@gmail.com>
 <pull.2183.v2.git.git.1769779599196.gitgitgadget@gmail.com>
Subject: Re: [PATCH v2] revisions: add @{default} shorthand for default branch
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026, at 14:26, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Git already has shorthands like @{upstream} and @{push} to refer to
> tracking branches, but there is no convenient way to refer to the
> default branch of a repository (typically "main" or "master").

I don=E2=80=99t use a lot of different repositories. But for the two I d=
o use I
use `origin`. (Really `o` since I name the regular remote `o`.) Most of
the time I do not need to have the main *branch* as a branch. I am not
working on the main branch. Using the remote-tracking branch directly is
more convenient.

> Users often want to switch to the default branch regardless of its
> name, especially when working across repositories with different
> default branch names. Currently they must either hardcode the branch
> name or query it via configuration, which is cumbersome.

*Query it* sounds like git-config(1). I have found `git var
GIT_DEFAULT_BRANCH` useful for when I want to answer a question
without hardcodig `main` or `master`.

>
> Add a new @{default} shorthand that resolves to the default branch
> as determined by init.defaultBranch (or falls back to "main" or
> "master" depending on Git version). This allows users to write:
>
>   git checkout @{default}
>
> instead of having to know or look up the default branch name.
>
> The implementation follows the same pattern as @{upstream} and @{push},
> using a new branch_get_default() function that queries the default
> branch name and verifies it exists in the repository.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>[snip]
