Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DAC7D096
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842400; cv=none; b=SXhjwKdFW3wglx1lE5qorEM4cV+VpUPuI6UeZ92Sjhbnp3cnWzINWisJd2lead/GslN9a0H4ouG4fk2Cl3B+wserB2BfrowaGlFTZwS0UwG+PS8TXAe+RldHFSJ5JPSJPq4qaw99hW4wt8hlkxp7TlbSG+yT2MMq4KDFwGAXN/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842400; c=relaxed/simple;
	bh=/78u0XWqzIOW8ILBJud5yseCVIveKtGquwJOwJRMSTo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=m4bao5XpQNqEDyI8VgyD9a/kslkU1ZoG3aEEhCbe4h/sbxqKhSpen4m80znZWVqgAjrrOSLoSR3aHWMnEOCWynpO/cvN+DK/Wcu3lRwEhCge4/Z1wvSyH98KfPQUS3LTj31ReknbHNFZ59qNWRCNGkcC1M1Z+IE/cMxJ0qdR6PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=FsIdwjzG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w0Tny09i; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="FsIdwjzG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w0Tny09i"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 0715E1C00101;
	Tue, 19 Mar 2024 05:59:56 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 19 Mar 2024 05:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1710842396; x=1710928796; bh=L+WWcAV/BlvTSmQVXCkMSAZvMEgmX6a7
	chKJgAsHsMM=; b=FsIdwjzGziHwfomRM+cqWwBGfZ6EtDC9+Epki6YxipMe/aXv
	muVPJJJOyqh9L1mlHbcTzQtOBdUy0zupK+l7XyfLYlJg6fmV98so9HDMnn1WvP9r
	DoD0u/R6EV9EdDT5zr5gMqBZRFbFdvkWkpO5YejFesdF0biKgF217N0qSYxRCPvR
	f2A3HpkjXHY+5MBOCroT5lWoSNAVC4Icbb2xTbwQ1X0m7e+4ZJO81RL4gqsIkULz
	ZmsNcPog0cAuHJ3pTDAj9qK3HaWLnJiBcQO8AtMF+tj+HDgzYp4I2AwOxs03NiWm
	O0xHpz3lWxHDn+4+n0E1UfuK2jLiT6Zn4DjzFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1710842396; x=
	1710928796; bh=L+WWcAV/BlvTSmQVXCkMSAZvMEgmX6a7chKJgAsHsMM=; b=w
	0Tny09ir+vIxBPlvWpGcXCoHAO+6SInRK2thRTTz2D3XelJ9suikMpLJB+YWd9dr
	w1d1vVU16r6c8vQ6ud2EdD97eD3NL4VdjII0crS9ZxzUnqswP7aEPpbqBD6GUpi1
	samxhcQXuhALn9kmRBFRtac119z/0gnTnXyq7G/qzTw0PE+54IXGDsFMt/39Buyy
	11jbo9vzxXtAKcpvzapweedxMp9EbUIXBtsV01S9UedpePK3LUlGI6bZYJhoL+wk
	iPMlZHHnOhxMExBrS5qLEdX4FlgcuAul9LbBQRuW4gRGX4l2e+3c5OjQ1XebFeCP
	uw3npYmRvGhxRIXTHQCQg==
X-ME-Sender: <xms:HGL5ZUOj9pCowFeY4jE4d6tAppZEo3J5ondd7LYIk7wmRpjhK4ofI3E>
    <xme:HGL5Za_RazNQt6AifFfQM5D1G8NjPPJLvengYovwFWnmGjO3FM_GYxOtS1LMZEEE1
    qh2cAIJkzlCzg_kZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeelgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtgfesth
    hqredtreerjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    dvveehiedufeehffdvteeuveekhefhleeigfektdeifeduteeuheeufeetffefudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:HGL5ZbTZ_8mKyRXHugCQjsmYxjIzzDR2s_amf7PmtCG2onZWpbeRyQ>
    <xmx:HGL5ZcvVWu5_kAHEcLZKrCVdkiU1eKejE6anX205AkmFwnu_DuYsMA>
    <xmx:HGL5ZcctKXYrAf1iAu-uLu9GFDeWnp14mP0KbM-YKBLgVxbv1MjmKA>
    <xmx:HGL5ZQ3kA5VJysJQcvAISyJenv_4mMXHQqBdhRcdBkCaq-2BKOo4fQ>
    <xmx:HGL5ZdqMS8LhhObAXGaOzG2mtUC8llWuxshTZrLZfk2VaCwVU2LjYfPJRKQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4253115A0092; Tue, 19 Mar 2024 05:59:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aad45109-0a3b-45bd-b9d0-5d289d5e6b9d@app.fastmail.com>
In-Reply-To: <20240319095212.42332-2-hanyang.tony@bytedance.com>
References: <20240319095212.42332-1-hanyang.tony@bytedance.com>
 <20240319095212.42332-2-hanyang.tony@bytedance.com>
Date: Tue, 19 Mar 2024 10:59:25 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Han Young" <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] quote: quote space
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024, at 10:52, Han Young wrote:
> `git_header_name()` in apply.c uses space as separator between the
> preimage and postimage pathname, filename with space in them normally
> won't cause apply to fail because `git_header_name()` isn't using
> simple split. However, if the pathname has a directory whose name
> ending with space will lead to `skip_tree_prefix()` mistake the path as
> an absolute path, and git am fails with
>
> 	error: git diff header lacks filename information when removing 1
> leading pathname component
>
> The simplest fix to this edge case is to quote every path with space,
> even if the space is not at directory name end.

Missing signoff? See SubmittingPatches section =E2=80=9Csign-off=E2=80=9D.

Also the commit message should be flowed to 72 columns. See
`.editorconfig`. (My client has flowed this reply automatically but=20
that=E2=80=99s not what the original email looks like.)

> ---
>  quote.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/quote.c b/quote.c
> index 3c05194496..ecbbaed061 100644
> --- a/quote.c
> +++ b/quote.c
> @@ -222,7 +222,7 @@ static signed char const cq_lookup[256] =3D {
>  	/* 0x00 */   1,   1,   1,   1,   1,   1,   1, 'a',
>  	/* 0x08 */ 'b', 't', 'n', 'v', 'f', 'r',   1,   1,
>  	/* 0x10 */ X16(1),
> -	/* 0x20 */  -1,  -1, '"',  -1,  -1,  -1,  -1,  -1,
> +	/* 0x20 */  1,  -1, '"',  -1,  -1,  -1,  -1,  -1,
>  	/* 0x28 */ X16(-1), X16(-1), X16(-1),
>  	/* 0x58 */  -1,  -1,  -1,  -1,'\\',  -1,  -1,  -1,
>  	/* 0x60 */ X16(-1), X8(-1),
> --
> 2.44.0

--=20
Kristoffer Haugsbakk

