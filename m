Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792702799;
	b=SbFqvXpMXxDO7Yt2OOkX6lB4DxuxO8nuhF15pQLRcRwb33G0OX11rgM6BXCfAlH9198X
	 G5dGqpFcGBZaFIhsGsYq9hvaGhQqVFfMbNvZeqkAwQPlhn+Eub/XM/mHqheJ2FW49Damj
	 +toOvaYgTjDVpL35+WL4z8yrkH19GDjih6ymENV6Mmju2L1fe+DGsvicYwUdO6JPkABHC
	 3utbDAqoYOTMsGgga1rr7OO26Q9J48CJnjFFCCgLDLw/3WT8D4vHVxtiIZRoSWy9EsaI2
	 kQpFJJMHdop4jioaLnQHYNF6C3sqVROTn6dSA6LUWaGyMDd+hx+yaDrpm/w6+ztxWOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702799;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Tqd3jPrRl/tsfC8gePEOpd6fGpmbcpa7xU/jyq5xZ0I=;
	b=G3eTFwiZktEIA+AlsP3J6Y5xG4bCJ0OLp3KR0EriYRmWXQp11Jw0jTyL1qfKgIFyx6xA
	 eRFk/90shKUkP1ccPMgFXbAQgWloj1HOS+QU8bfkBfB/P/sb5PV0l9ueZEK3rAYF1Ua1/
	 mXxfNpxxl/MSaqNmvnVy6liZeiA+scYRZwLCu/kJ3UpR9ssRa2xd9iH8J1t0LlEMmJdMV
	 gNYSDfiSc5IyJb7YngbpuWt76HjKkwNOGc7vFZhfRKUZm8k9aoBItZJlnE/9ggZo6UtTy
	 7FQBSfO6Bn1AF8NGgAFDukzGJMAQvVCWirJirsZBDpUCCEAo9fXsJdiGmLLaFhFabOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=OydZewVj;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=rV+zUcHv;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D91606A31A
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 20:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32D91606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=OydZewVj;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=rV+zUcHv
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7EC717A013A
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 16:59:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 22 Oct 2026 16:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792702798; x=1792789198; bh=Tqd3jPrRl/
	tsfC8gePEOpd6fGpmbcpa7xU/jyq5xZ0I=; b=OydZewVjfkIyUix3vlyPWU2JLV
	41lwyPFprSFfxStmU9qv/rVPv4/ud9ckl+RmFabX/B36jDJkJZdvEEIuxGJRGAMN
	v6IzMDmSJH6wtRZ/lbByezeAm+4QcrntTPooLo0BQajKaDvxOmnIpVWk9M3UP3EI
	fHyWw4XKLEQCzcRc1s3Cg9YtW90+vzVl37RC5XnkEFQ2Nk3Z0RNBv3+MKQZW7sll
	RBb/Ri6GgOwI2BSEpypRVKjIu9pejUrOSAy4C1ToKlxO4TIumvsMkbRM4Zf/gaaz
	nn3ATOHR+LbTJLQx/VJaICC+HiVGBY3lZA7WhsrVMpciXTNmiEy/V+2g6ZzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792702798; x=1792789198; bh=Tqd3jPrRl/tsfC8gePEOpd6fGpmbcpa7xU/
	jyq5xZ0I=; b=rV+zUcHvd6q1gqbp8PRAZ1OLkGB1W+Xq95lZ2DXcTVg7NxBNe76
	4feNXLcCTnxGFIjgIsDhaYLSZ/kqkFCe0C0IMHibEUUwZcKRd8tTVv6fYTKHZho0
	ppyvhKK4zseyB1idrwOCheeSnWoVob9tizMZNvMqx1W5PfQ8qOvut0411YD7/5lf
	bfn0bc4mJvnG92Krw8ThsUyCappKD1nU0kSHJeYU7SH8BDK6Nujtjal+AaLYyOYQ
	K+silJOSpWuzY58nf+yirury1KPgjkOYgMg2126SjulbP3aMuwkCfRVn9Fi0cS+Y
	X/1qWJScaXpBiCFUcJOVAbQk4f6ODZ8CVbw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792702798; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:LvmG0idljwMjY9pXE0Yq7hadXuULhOJ7iJQz+lt6Y+3mJCP
	gWeIrszFYy7uFqxF9VGyX2mIO4LDgHsYKTDBSHfT9OKZSVG+hlthy7XNkOdXS3yO
	xWD+OrzE2N+cRFk4e1DXevW3pwTcS1quqZnwEbB3yk+TcTR0B3y9JyXnPmjM758n
	RwZyBxxquK2u0ZL+9hF+E1wfbAJ2Mc0EjnJ8noC7QC7DUjYTIiekxKcj/Yb6CKVM
	f7CLkVcyeNlZbQIYqTbSXta2wN1hAP75eoXrTRV55GZx1QqZthEoO+qsa/eUZ/d0
	8+6rl+FH1ThDffqRnBzEUE+NfKzVGP6hA8GvlwQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:lJsCerfAg9rpRy1Rbia8ZK8IZW9MBE5AV8gqEDFa9pw=:2DakGmGQndB8kHjVZP9V1iARmZ6VmaIshoUQa3SNJK4=;
X-ME-Sender: <xms:TnnaauO63B2H_UfcpJor9vjfQxFBxzl4Ip1OXOxxVarYlVwTxTRUhA>
    <xme:Tnnaai8kuwKpgiqjhEis676cjWn0YS4cHXRJt_xHtb-f1e1M7wAvgQPwEiYyFDm3h
    8LkO1uuJ80pYVp6jBe6aLZPwz2KBGhbMktesMCDW3rfPwwtRAyd1dxF>
X-ME-Received: <xmr:Tnnaai6YzZ1b3y_mjTj0uoyLAAmmfhxmUpUi8FRYKGfzliKzdqbNyhxg27cQnZiZlGt2k5kOIi1Ul5s5WqWNQ5v6XPEDS34RNZj4>
X-ME-Proxy-Cause: dmFkZTGTaLtNrI1dDhLLURpV5BQ6rk8iL2YRB9bW2Xep/yfoMXX4m7eRjuiGzq3uPPGUR7
    kstQiYkTHg/k318zdTykIBoQIwPacJBFot3SR/mQSJ+VK/hv6uwdyH/OUKOT7mKOmFbJIg
    O7IeoYE0FPT5sBWayRgsLCL7fE9YMRn4M3VBUBgDPCzzcPdYlXImaxf3fkpOuV0kx1AFAO
    7PFxRQ9ZcAEqaQQk3uWDenJid95lGo/XLJ5HhmkpPYKM62pr02H9aUE58sFYBxTXEVfvvH
    /kgx1Bc2P4Fxn7gKN6NQkXYOpu8OiWb3sgAyCznH2GOUjsGpvF7mvBYtt+IQWL76Z67XFQ
    6JiaIzkfIZzgYZ/8TxYfmO1axBszSH91Lb2eeZdJPKROzB5pwRzMkdR5Vik45xgLQljpS/
    p9joDr0LrhlJA+4Q0DRD9HgW8ssi/AUi6RthLj8zdRRrCCzD1vI+eG7Wd+eXvgXmps1lNv
    IWoaFis0GoBU7IgKzrFCzdNk8/QhhvBAaOyTHiGnuhliUv7ElfkdTa0zgh25z7mjgCUn6Y
    7TO2TzSQRxcLfpwsH+NbCtEo9SD3drwPLOM6ScCwrlM3elYQbOcQNFxyszmiGBHY/eG5Qr
    wjmxyDSLdWfF5kmhdxzq/z9UCdljEUmn1JF3H8hda2kwlnUxbDPHc/PefppQ
X-ME-Proxy: <xmx:Tnnaap1ohT2BEJD62dHyPi4JeKpIOnZVGrgiFnqViY3Wz5SmCMGoGQ>
    <xmx:TnnaapAWTY4WtPrDcivTv5jeDOzTQgl0D3vx1UqnRlgxIpnOuMUm7A>
    <xmx:Tnnaar3mbyObou9dDv6dvIbuD7_xy0xqfSc5ca6u4WlihqK7HIgUEg>
    <xmx:Tnnaaju_wxcEu2qVCTqXHnhvCSRyT3SWEiKIlkjzUwp6LZ2z2cOmDw>
    <xmx:Tnnaapn2TxPuqIKeC9DlXKy3O7rS91d828lDc5e5PIWvxa_jU7xhVfOm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 16:59:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [RFC/PATCH] config: honor file permission bits
In-Reply-To: <xmqqbj8p7okv.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	19 Oct 2026 07:27:28 -0700")
References: <xmqqbj8p7okv.fsf@gitster.g>
Date: Thu, 22 Oct 2026 13:59:57 -0700
Message-ID: <xmqqpkx1e9iq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Because our updates to an existing file almost never makes
> modifications in place, and instead create a new "lockfile",
> propagate the permission bits from the original, copy the contents
> from the original file while tweaking the contents as needed, and
> then finally rename the lockfile to replace the original file, you
> cannot "protect" your .global configuration file from accidental
> clobbering by doing something like this:
>
> 	$ chmod a-w $HOME/.gitconfig
>
> Of course, if you make your $HOME directory unwritable, it may
> protect your .gitconfig from getting updated, but that goes totally
> against the intuition and is not how you would protect a regular
> file from getting overwritten.
>
> Teach the configuration file writing machinery to inspect the
> permission bits of the original with access(2) and refrain from
> doing the usual "write a lockfile and replace the original with it"
> dance ourselves when we shouldn't be able to write it.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  config.c          | 22 ++++++++++++++++++++++
>  t/t1300-config.sh | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)

Hmph, no responses to this RFC.  I somehow find it hard to believe
that I was the only person who got annoyed by this behaviour [*].

[Footnote]

 * I was very tempted to write "unexpected behaviour", but I know
   what happens in the code path, so it is not unexpected at least
   to me.

