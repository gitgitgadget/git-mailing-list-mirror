Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BD8221F11
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872833; cv=none; b=kUPVe0WJt55HzvsuqPUf1RNqvZuUImy4B3I+s9gCy/tC2nxlK7xwzvh5XyrIJF+ZjOt2jjZBc8fzY1G7lj7dLKymLdNhogaZrkNY0uv7C2rpbn0bKOH16CLyqBXXq04kJfb042zwCOhwCvIaya8ge4iV31CRi9zb9deD8QVcB38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872833; c=relaxed/simple;
	bh=el2LyYQ7z7hrwY1A1inWvAugNbhjg+tIcZ2Oe/QK2Zc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tfBWijOWEZAMuDd6KKECm96Jp8pGupYR4/6EC4CyPt1mToP4FW9Vm7myg1dxioX0dgXDwrdCu8ED5t/Y0m8r6FOkJ35yRSD2USPjYPs+VvwkrG5ZPF8lsD+6P5XGbbju204Hc5AWvWcwJy9wGohU9S7SZX99befSlWKsKLVFjf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=VHZZozs2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JQylw0LF; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="VHZZozs2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JQylw0LF"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3CFF311401BE;
	Mon,  2 Jun 2025 10:00:30 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 02 Jun 2025 10:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1748872830; x=1748959230; bh=XFfgPla63EG5MTNBO/Vboe7teCTzFkXn
	0SwRigW4aj4=; b=VHZZozs2itDukTpUvU/SeXLfUNibDj/dzZco30xj8lQQ8RdC
	7cwReYccVNWZMJvB60jHH4RtCLJ6VYMuJyHCpGZUbOOzNKUuIzKcqe44iV4Y9Kl9
	FTgxMwh/IoHTRUxR1HyoBewHF/pkxOJjSqtqxe2tdD5gM/LiBOw90zmYhLLWLUvg
	0FouZqqXptad0CX3hadK1z7ppENwZ6NBF0vdmlHNcWJpGascPrPG15eGc0PF+Qhq
	jkS+9kufmMDR76sTfa5TcFlcJYJAsRFVoRPwM01dTJON8VK1svvA+qHKAL8o6/4q
	1vTIcaJB3OmgvK484ueVkEp0c0cbYECsDclVPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748872830; x=
	1748959230; bh=XFfgPla63EG5MTNBO/Vboe7teCTzFkXn0SwRigW4aj4=; b=J
	Qylw0LFmle04jyqhw1jkkRXf76L3sMGuBd3xVuT8CKw+uqDQiPb4wrb4ZF6cCHg+
	RFoAMsbmuIeXokac5kl+P3/IH6sTueueiMNwJhEWMzN/HxaI4PwzNQE4eiOD9kyw
	mDXQnYVfkCHMfPkmm9V5OOHOQ+cabYQCOczQVcAFEwYh+F9Yo6wzec1DhxMG3JN5
	U3s2gTh4LOoKnoCc3erfueym+hY3I0VM2Zuv0khDBlDrzeEWgzvB4WQjTebmdYlP
	MIVo2XgqNPZJVFXPCyazgtEYfqKrkcFfp07YDb9aVZWz96x+TT0c9piJF4BDoEd/
	ow85pnBDZfGhaTtmR6Syg==
X-ME-Sender: <xms:fa49aHb4QUQezMA3GV8azEbafXeHHb4fwdDsuk3nMsk0Qh6gvVwLD2w>
    <xme:fa49aGbqDv76gQAar_bE8p6gLgWKrTDw-P4XLs5QxIm1Zx7Y7YTN-YFtzVWVK6eUg
    KbBOmklTTTV7xfVJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjeekheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruh
    hgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffr
    rghtthgvrhhnpefggfeuteekjedutefffedtgfetveelledtheffhfegueduieeuhfekhe
    ffueefhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkh
    drnhgrmhgvpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhih
    hllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhi
    rghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhshhhi
    nhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fa49aJ_JWRRu7WXl_kGCGj6b2yiPBbu0yR-hPIXTS3BvviYTn7pbpg>
    <xmx:fa49aNoe11qWc7W5GQThAX1dwCIGqh0mY1ImtlmFC6o8-yDWznMaRg>
    <xmx:fa49aCrDi6z9Ca59osXbMwdbNv6xTymMrpo1wIrEeSwkdpf2qW3dYg>
    <xmx:fa49aDRxeOBklDr-jdM7qJS2EZDHPpAtttPBGlvSJxlg8pDOG_BULw>
    <xmx:fq49aJMz2yJx8s1Nj89dV9RXruc0RAJPUMr5tkVMSMq_Xdw7LgLN-f7y>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3E19B1EA0060; Mon,  2 Jun 2025 10:00:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tc27db594e61395fb
Date: Mon, 02 Jun 2025 15:59:01 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>, "Karthik Nayak" <karthik.188@gmail.com>,
 "Eric Sunshine" <sunshine@sunshineco.com>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>
Message-Id: <21461585-273f-46a9-a750-6ae7b414fcdc@app.fastmail.com>
In-Reply-To: <aD2nPXIXugVXfIpg@ArchLinux>
References: <aD2mhOlwl1LSYnpe@ArchLinux> <aD2nPXIXugVXfIpg@ArchLinux>
Subject: Re: [PATCH v2 1/1] fsck: ignore missing "refs" directory for linked worktrees
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025, at 15:29, shejialuo wrote:
> "git refs verify" doesn't work if there are worktrees created on Git
> v2.43.0 or older versions. These versions don't automatically create t=
he
> "refs" directory, causing the error:
>
>     error: cannot open directory .git/worktrees/<worktree name>/refs:
>     No such file or directory

Good.

> Since 8f4c00de95 (builtin/worktree: create refdb via ref backend,
> 2024-01-08), we automatically create the "refs" directory for new
> worktrees. And in 7c78d819e6 (ref: support multiple worktrees check for
> refs, 2024-11-20), we assume that all linked worktrees have this
> directory and would wrongly report an error to the user, thus
> introducing compatibility issue.

Okay, you don=E2=80=99t mention c1cf918d3ad (builtin/fsck: add `git refs=
 verify`
child process, 2025-02-28) in the commit message because of your reply:

> > Because we would call "git refs verify" subprocess in "git-fsck(1)"
> > in this release cycle, I just want to fix this problem before the
> > release.  Thus, it won't affect the users.

https://lore.kernel.org/git/a2a50127-6ab9-4d8a-abcc-b1a741df293e@app.fas=
tmail.com/T/#m01231abb77735b0f480743e0d2adecc172e1f170

Which I just mention here for completeness and my own memory.  ;)

All good.

> Check for ENOENT errno before reporting directory access errors for
> linked worktrees to maintain backward compatibility.
>
> Reported-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> [snip]
> +test_expect_success 'no refs directory of worktree should not cause p=
roblems' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit initial &&
> +		git worktree add --detach ./worktree &&
> +
> +		cd worktree &&

Now in this version you change-directory into `worktree`.  You would
need a new subshell for that (test style).  But I don=E2=80=99t see the =
need to
chdir in the first place?

> +		worktree_refdir=3D"$(git rev-parse --git-dir)/refs" &&
> +		# Simulate old directory layout
> +		rmdir "$worktree_refdir" &&
> +		git refs verify 2>err &&
> +		test_must_be_empty err
> +	)
> +'
> +
>  test_expect_success 'ref name check should work for multiple worktree=
s' '
>  	test_when_finished "rm -rf repo" &&
>  	git init repo &&
> --
> 2.49.0

The test passes for me.  Also when applying only the test (and not the
fix) the test fails as expected.  Good.
