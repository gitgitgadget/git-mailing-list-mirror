Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A826802
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 02:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732501295; cv=none; b=ePRKR6oolWcJx9Y1+naAQWsP3Hkq7Wl7Mn0VHC82gLfNPAuQiVo4n81IMKUahcTIQNSPWgiY9J/EHKVkfDxC+6M2XsoW0fH2TJuqhHFhVX5XYVbJYlUxPgCUCurT6F7xYTyXy9djzpVkgJl5is5XHh09zLxMzKvL7zPnOotVz2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732501295; c=relaxed/simple;
	bh=KTE9TVJ+D4ItD1gW/RlNncTy12p4h+pO1s5BkLM5VaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PWNy2dNQYeo9BCZRMOxl6btqgdkpCUE9IFd4sIzx20rftZJfvnlCuI5YqCR18ACkwn3C7bXyT7JlRw/hgbRg1Ony1nZHAX/NvNTGTnc3SjQ3eZSNNhvKut3Kjl5VX8cdVOBcTIO7yqyqteSro7iDnZDjwTRBv2MOrlluKwY403o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2CC1Zl9Z; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2CC1Zl9Z"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C512E11400EA;
	Sun, 24 Nov 2024 21:21:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 24 Nov 2024 21:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732501291; x=1732587691; bh=83PEgErtr9k3x4U1CLXlX0fF08WzI9Vx7aC
	jqMkzenI=; b=2CC1Zl9ZLTuzBUq+xN6917P5UrhffyNClxMnzswZSILXdcp3mUb
	CXteCcbKO0eR0FLdI4QBMyOKT+rs6c2LTOGQiYezkkt884bOuLrcmxUQZvAuJtGV
	FIJXuucV3PauKK+EMYlB1Ajg7iI5eIfC+V4rUMyVg3s98Zz/hUhY4dP1fjWz797o
	jIezHEIc6LmyiXlUE8kvukXclPdKzuVT1m2uEiLkTtLoBPaix//6Wsk/yg1RoTSV
	3lm5BlaMt2c58i0FTXApvjYgcaBzHX6ucGth5oPIglY9Ov/9Ux1iV3wG2WhmvJgF
	6wmgI7MH2RjHpybcihaOO3rPOL60cDcpfTw==
X-ME-Sender: <xms:K99DZ4pgeGHSjL8G73LgKzG7DI23fpNSy7fyJ-gNqWNtYnyqSHkgYQ>
    <xme:K99DZ-oyK5qK4mL4y86qVqJsREc9VgAuKTochqg2xgOTCzcQm8LYFlTnXMsTDoA_n
    R_NnzSqylZ3U-00Tg>
X-ME-Received: <xmr:K99DZ9NBO0c1kFzVC7-2BNKF_vqyhKPz1_VGn2ykBg0gdAjCgxhIrMgQRF-SdIgG8F0K-m2W7MT_87LeG-fPNn77O6ofg0_zxrynXc4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhdrmhgsshhtrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhdrrghgrhgvnhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhgvshhslhgvhiguvghnnhhinhhgthhonhesghhmrghilhdrtghomhdprhgt
    phhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepmhgtshhmvddvgeesghhmrghilhdrtghomhdprh
    gtphhtthhopehjghhsrghlsehprhhothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:K99DZ_4Exn7Dq89HKLXBnn8RKOwyDKGRm-e--JINXZ3ENY4pXhHN2A>
    <xmx:K99DZ34YOP2nDAUmDI8ZLSEIM1afrH9lYJfdO61JytbKoCWdju2zBw>
    <xmx:K99DZ_g98o_Io8u9ZnhbZDykNo0iUOVX9a4H9SvBQw1RWCBx-n7Xng>
    <xmx:K99DZx7EDpFfsUiZWckFQ07osjFw9QezmOwfk3U7SBvPvxT0NC_uXw>
    <xmx:K99DZ0zG7aT_FxshpQJJhc7QvFLbX26sQZ1jVJBzUnugDByfBUuZeinx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Nov 2024 21:21:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Matthew Bystrin" <dev.mbstr@gmail.com>
Cc: Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
  <git@vger.kernel.org>,  "Lessley
 Dennington" <lessleydennington@gmail.com>,  =?utf-8?B?w4Z2YXIgQXJuZmo=?=
 =?utf-8?B?w7Zyw7A=?= Bjarmason
 <avarab@gmail.com>,  "Elijah Newren" <newren@gmail.com>,  "Phillip Wood"
 <phillip.wood123@gmail.com>,  "idriss fekir" <mcsm224@gmail.com>,  "Joey
 Salazar" <jgsal@protonmail.com>
Subject: Re: [PATCH] git: fix paginate handling for commands with
 DELAY_PAGER_CONFIG
In-Reply-To: <D5SWT5JKU6S9.2LH8H7ECRZXXM@gmail.com> (Matthew Bystrin's message
	of "Fri, 22 Nov 2024 18:13:01 +0000")
References: <20241120101741.8225-1-dev.mbstr@gmail.com>
	<CAN0heSoryo-DO6WXKqqASJ5nDLqb3PNNiZv1TP=Pq11wsiSM6A@mail.gmail.com>
	<xmqqmshrrxpq.fsf@gitster.g> <D5SWT5JKU6S9.2LH8H7ECRZXXM@gmail.com>
Date: Mon, 25 Nov 2024 11:21:29 +0900
Message-ID: <xmqqa5do834m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Matthew Bystrin" <dev.mbstr@gmail.com> writes:

> The root of the 'problem' is related with editor, not with commands. So maybe it
> is a good way to deal with it in editor code? I've quickly come up with
> something like this:
>
> diff --git a/editor.c b/editor.c
> index 6b9ce81d5f..04a1f71694 100644
> --- a/editor.c
> +++ b/editor.c
> @@ -13,6 +13,7 @@
>  #include "strvec.h"
>  #include "run-command.h"
>  #include "sigchain.h"
> +#include "pager.h"
>  
>  #ifndef DEFAULT_EDITOR
>  #define DEFAULT_EDITOR "vi"
> @@ -60,6 +61,9 @@ const char *git_sequence_editor(void)
>  static int launch_specified_editor(const char *editor, const char *path,
>  				   struct strbuf *buffer, const char *const *env)
>  {
> +	if (pager_in_use())
> +		wait_for_pager();
> +
>  	if (!editor)
>  		return error("Terminal is dumb, but EDITOR unset");
>
> Brief testing shows what it works, but more complex approach may be needed.

I am not sure what you mean by "it works", and I do not really
understand what you meant by "break things" in the original claim in
the proposed commit log message, either.

    Calling commands using editor in terminal with `--paginate` option will
    break things. For example `git --paginate config --edit`.

The last sentence is incomplete and it is unclear which part of what
`git -p config -e' does (or does not do) is considered "breaks
things".

I cannot tell if the simplified change above (which is far nicer
than sprinkling code to tweak use_pager variable everywhere) is
doing the right thing without knowing what definition of "working"
(and hence "breaking") you are using when you report that the above
change "works".

Stepping back a bit, whatever code change your next version
contains, please make sure that the proposed log message that
explains your change tells the readers what you see, and what you
would want to see in the ideal world (with a fix), and what the
differences between these two are, instead of just saying "currently
it breaks, so let's fix it".

Thanks.
