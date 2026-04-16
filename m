Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF0930EF9A
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 17:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776359885; cv=none; b=htC5yYILmGY8gnprN+hceZKJLpK4HdRSzCjEqqfcKZt9mB/Rk0I4oDDSfL/7IWNaU67IYcd/X1y6YGb2ZdtTeZ0+lKI/zy7GAQRNMBu+/NqSo6TWzLN3djnlfL7uSOyEgytYv+OkttIukbs8omX5f3PnWE/8s47CvrR7KXPgkGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776359885; c=relaxed/simple;
	bh=p6V6lmtfnO4NsGkxE4VT8+q/qNweDinrzeoqtQGPpww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xr69zZPYXTPtqiuxmA8vyEKRbKbud+yPFxG2UwcP163eyTIKi+RvAhPyvcEoh/lFSduJVlWQNBNr9bJ3zGgrnNmeVfIS6/wRO9nZWxiMHBeJb4525WgcrDLzkU4BkP8cP8yT5ade5R09bE/81glSfcBMdkmJ1TylsjT9Y/HzVvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KJEBBJBp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mNmLGvIV; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KJEBBJBp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mNmLGvIV"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 9FF5E1D0028C;
	Thu, 16 Apr 2026 13:18:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 16 Apr 2026 13:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776359883; x=1776446283; bh=r+0fW/grha
	/zPQC1wMO4h1BcW6F/oPmCAVsy+LOVgVE=; b=KJEBBJBpDV6Mw9XJ5A1re3EFQT
	TxnWD2lKOAiHFxS9LbQst4aV/ZIIGHGTSXuehm+iT/5AoK4bfgf8ofyf9WDkMtub
	gNpyO6WabddzleCHJoNev6Fn8gYCzp9puxQxxsOx/fiieFP4IAmtrzFOARxp/1VI
	rYvD5cALMjJmhl8qP89Afh33bnW7ZZK4v5nSmkVBqtF/tyrTrMoD/+r0KrhljtRm
	SOAFNh226oJhBjNWESNMXf5r6g8wtYnCjF96oIHZeTkBCaJzH7q7eUMkuF/X7A/U
	Mx0I37apLYiufrLn/qVMbf8wVM6IPJFAAsxrrmPrECkxAk2jAkBzay/41tlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776359883; x=1776446283; bh=r+0fW/grha/zPQC1wMO4h1BcW6F/oPmCAVs
	y+LOVgVE=; b=mNmLGvIVFDsP7QvCwSxRsaFukKP6n/+HFTZvsRr0uWqoPRsmVp1
	GRSulyXXObod+v7LfzB3AxTlffUyyxhmCstTjUth64iQq0LefvaMa3p8VHLSP1TT
	hxQtS4B3ZHjPBFgZf60KsOsVALZa+g7F2/f9bmR61XxTFbg92SMemRQJNywLYZeM
	ufUF6ZUj3hFPljjj2+zQ6Q25vHBUITPyIWRX1Icaxyx7ETACmynnf/13eaPADlpE
	MELZgvepSADtWamnDdthfOXaoMc1Srx3ZW4iSZNznRGtw4b5FSvUvrkb4mifO+MT
	cTvpIg3Wk2DwBnaIFqTYlaG/jkKvzME7wSA==
X-ME-Sender: <xms:yxnhaWwm-wQDG605MXDh1akT9gHymhh4zOIsVTrrx3e9cCpcrkPJkQ>
    <xme:yxnhaZtb1oiGtE6wDYaIZaNF3LxbGBIrGgzJPCpy1w8bmIv-PNip-sHSCbOnfBVoF
    T4x2WHllmoINSOPCkO24JhNpx4E_nDuDU2Le1EebmIrR_X1bcWDQA>
X-ME-Received: <xmr:yxnhaVtL9OolPGNhNqYbpa-ToHb5Hldu6ZhzIqd7-SvxaEOY-yvHIUwplcsN174JnNna-M9-TojvlslDamLMi9-hDJB3-aT3gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjeehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepveeikedttdehgfdvgffhkedvhedtud
    ekgeeivddvhffhueffueefveejleehgeelnecuffhomhgrihhnpehgihhtqdhstghmrdgt
    ohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjuhhsthdufedrtdekud
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:yxnhaWNbZtATj2utjA0xeMi7lwfuq59NgMNoz2SJdouBoHDAiG9jzQ>
    <xmx:yxnhab1WVTV2ZqXFEjCxmuR_ImneTSKt7YKxALrgBQvHxZGxVh6SjA>
    <xmx:yxnhaaM9EUhY158WVbxMyUQBLh4naFQj_SE3FSm9BorwwaDkTqHC9g>
    <xmx:yxnhaT26zsYVkjjzm8rsx6Z_UoWMvABapDz9uYyp7h_whtFwUcJfTg>
    <xmx:yxnhaZt1tXEY5DIM_8-VuLFrsPnO0bEwflszBjrDxgdYOch7PiSZrqpu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 13:18:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Chester <just13.0818@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: I still heavily use git whatchanged after more than 10 years
In-Reply-To: <CAHvvhRS9VJgyAdivR6J1Hz14jSuBJOj8Bpdu+g4fV45LRSeS8A@mail.gmail.com>
	(Chester's message of "Fri, 17 Apr 2026 01:06:40 +0800")
References: <CAHvvhRS9VJgyAdivR6J1Hz14jSuBJOj8Bpdu+g4fV45LRSeS8A@mail.gmail.com>
Date: Thu, 16 Apr 2026 10:18:00 -0700
Message-ID: <xmqqtsta259z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chester <just13.0818@gmail.com> writes:

> Dear Git developers,
>
> I saw the message that git whatchanged is now nominated for removal
> and requires the --i-still-use-this flag.

You should have seen:

    $ git whatchanged
    'git whatchanged' is nominated for removal.

    hint: You can replace 'git whatchanged <opts>' with:
    hint:	git log <opts> --raw --no-merges
    hint: Or make an alias:
    hint:	git config set --global alias.whatchanged 'log --raw --no-merges'

    If you still use this command, here's what you can do:

    - read https://git-scm.com/docs/BreakingChanges.html
    - check if anyone has discussed this on the mailing
      list and if they came up with something that can
      help you: https://lore.kernel.org/git/?q=git%20whatchanged
    - send an email to <git@vger.kernel.org> to let us
      know that you still use this command and were unable
      to determine a suitable replacement

    fatal: refusing to run without --i-still-use-this

> I understand that it can be replaced with git log --raw --no-merges,
> but after so many years, git whatchanged just feels more natural and
> quicker to type for my use case.

You are asked to send a message to this list whene you were unable
to determine a suitable replacement, but it is hard to believe that
is the case with your use case.

The "alias" hint above seems to give exactly the suitable
replacement to help folks who cannot adjust due to the muscle
memory.

