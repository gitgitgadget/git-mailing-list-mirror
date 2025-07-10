Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF4B23770D
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752138885; cv=none; b=VZwWAYj45oErdx3ohKonOuy94ZQUi9Ea8KHKVSY1UAX1XyFrufq2TnFmHfjaL1qDxtWYY3fkd6pGkuKi1UaSifS0fNlDsofn1jvF3HSESlFfDvV5PQ1SJTC8utklWXce//bOsBohlg9B7/sGmaDu2/PGonp4X1Vhnd46MQ81khQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752138885; c=relaxed/simple;
	bh=2fRkkDCzMYFKMMybXQgQyhoo5UKSqP5r3x7ZK3EXqGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5TUD7awK8NGcUjJcjlbWsppYJ/L0TfCCtaqkYIgr08aAOZhOfg3mO7+K0ZurLCMM8SuHntigHkktu3zRj8m33maRnZ6eUdByCryV65PBk6gOiygzUA2qY1po0m6NC8l0kT8dbnNWkLoWCwcPuF7CdlQYRA/9QZrTdRTJvI0nrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KjBpQyxt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kj0hUOt8; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KjBpQyxt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kj0hUOt8"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BF30214001DE;
	Thu, 10 Jul 2025 05:14:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 10 Jul 2025 05:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752138881; x=1752225281; bh=uppdt1M0Dg
	k63LZgeP+bKvPe36KVPvHQgk4WFl43uvw=; b=KjBpQyxt6u9LiyvObHfwWzRjDN
	gBFsc5PuR1hPpkRAZYaY0DrC7fmdCyJ1ozYk421JwPpOhxHOfjLV+oUc9hCFEk99
	oGBj0HyPPZ0gASVyMSnu3+hTd/1zPe7QsHnQcgFiIx5202tWL+b9ptGNBvBzObjy
	gp7IAsVfu8FxrRJvQJdHDpHzIp9D5yCENE8rf4Ui/vE3wOeLgG8vvZj6A0IJ+zRl
	j2En0ggyOEtCLnx/2TMF7YXFdthdsba1IfLRpliBUiJomzLtpHCYqPNJOYgYVV7+
	QtiEa2UMg44cKIYj8uPmSeqcNGt41rXGDJ6D8sHgZptGK0lZwvOe4XMIOkjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752138881; x=1752225281; bh=uppdt1M0Dgk63LZgeP+bKvPe36KVPvHQgk4
	WFl43uvw=; b=Kj0hUOt8NNksNqHJ6b7yHVKGR+teEqVC6RMBTDx5UP1lE8mNLTv
	Pa+GPrnv4/5WFF87yLxKFY9xvE7QD59wBlAnbnsq4m8OKEnPsa5z4Y9WvFxs7TKj
	buQSdEkZ2ahlSjpJzIy/91LjTOZzJNw71OJeU9yEeBZqSkkZkC8SjxtBNPLyTadX
	mrevyfJ+t6z1wm581Ix/LGYGv9Nl6DZt42FW/UR+CF65a1tIsXsV8SuP3GSYJ9GD
	mN4RwbfYPtl9gDRGSmWQ3QL7gT0Pla5RnGetu+mwl/2VCx8v/PQ6tnqZrLznyzZt
	sjGb3XHZshdECAS0RczjPPjNhKvS/MmRHvg==
X-ME-Sender: <xms:gYRvaIKBZGgv54vkMQjtqmlLQf4fd8Q0CJOSthv34eOEjlBxdDtKkw>
    <xme:gYRvaIXmRhPlPcCR2Aqz3VTQpFWctbqjLELrhMczVzUkGoj5jTQLHHNX1eeNuZRZq
    -iQtZC3bn8TrjdqQw>
X-ME-Received: <xmr:gYRvaKjtwegcdKBrhdExK8irmzfl1r9GDXhY4V2B_t2zRcPKPyOLCwq3j-k_MdHuLwglx7Aen1IBTixAjmzhopQbnO_wDQuLnqARa1hduLf7fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsthgrnhhhuhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:gYRvaD-evQZFrHdfBOeAk44WptS7OrT6R8Wl1no16q5kAWxOSyNiDA>
    <xmx:gYRvaEDmlFwJuAeweTNI_VoasPWeD2Z4ClxPPOZvuqb0tKng3n38gA>
    <xmx:gYRvaAI82NAJcvk11h9W0lzbBr2u0OXhRDmMyS6iMbY5cHcuqhDUYg>
    <xmx:gYRvaHlQpfG7OlXeFSZy2aJ1scQ9lMXo27J4qCXGh3f2eQ5tScLE0A>
    <xmx:gYRvaHbWYZP5wqA7v9pBpLQpmwxOuo5JZ1UQJGogOZtL4vKr_FEPJzwD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 05:14:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f7d74dc7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 10 Jul 2025 09:14:40 +0000 (UTC)
Date: Thu, 10 Jul 2025 11:14:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Stan Hu <stanhu@gmail.com>
Subject: Re: [PATCH RESEND] sane-ctype: fix compiler error on Amazon Linux 2
Message-ID: <aG-EfIfyXxmS_x22@pks.im>
References: <20250710-pks-ctype-v1-1-1db7e7568ea2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-pks-ctype-v1-1-1db7e7568ea2@pks.im>

On Thu, Jul 10, 2025 at 11:12:40AM +0200, Patrick Steinhardt wrote:
> Compiling Git fails on Amazon Linux 2 when using GCC 7.3.1 with the
> following compiler error:
> 
>     In file included from compat/posix.h:449:0,
>                      from git-compat-util.h:26,
>                      from daemon.c:3:
>     compat/../sane-ctype.h:29:60: error: expected expression before ']' token
>      #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
>                                                                 ^
>     compat/../sane-ctype.h:29:72: error: expected ')' before '!=' token
>      #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
>                                                                             ^
>     compat/../sane-ctype.h:29:60: error: expected expression before ']' token
>      #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
>                                                                 ^
>     ... lots of similar lines ...
> 
>     compat/../sane-ctype.h:45:50: error: expected declaration specifiers or '...' before numeric constant
>      #define toupper(x) sane_case((unsigned char)(x), 0)
>                                                       ^
>     /usr/include/ctype.h:142:12: error: expected identifier or '(' before 'int'
>      extern int isascii (int __c) __THROW;
>                 ^
>     compat/../sane-ctype.h:30:26: error: expected ')' before '&' token
>      #define isascii(x) (((x) & ~0x7f) == 0)
>                               ^
>     compat/../sane-ctype.h:30:35: error: expected ')' before '==' token
>      #define isascii(x) (((x) & ~0x7f) == 0)
>                                        ^
>     In file included from /usr/include/features.h:423:0,
>                      from /usr/include/unistd.h:25,
>                      from compat/posix.h:90,
>                      from git-compat-util.h:26,
>                      from daemon.c:3:
>     compat/../sane-ctype.h:44:30: error: expected declaration specifiers or '...' before '(' token
>      #define tolower(x) sane_case((unsigned char)(x), 0x20)
>                                   ^
>     compat/../sane-ctype.h:44:50: error: expected declaration specifiers or '...' before numeric constant
>      #define tolower(x) sane_case((unsigned char)(x), 0x20)
>                                                       ^
>     compat/../sane-ctype.h:45:30: error: expected declaration specifiers or '...' before '(' token
>      #define toupper(x) sane_case((unsigned char)(x), 0)
>                                   ^
>     compat/../sane-ctype.h:45:50: error: expected declaration specifiers or '...' before numeric constant
>      #define toupper(x) sane_case((unsigned char)(x), 0)
>                                                       ^
> 
> This error bisect back to 75a044f748 (git-compat-util.h: split out
> POSIX-emulating bits, 2025-02-18), where lots of bits got split out of
> "git-compat-util.h" into a new "compat/posix.h" header.
> 
> The compiler error isn't immediately obvious, doubly so because the
> actual errors are ~3x as long as the above snippet. But what happens
> here is that we transitively include <ctype.h> after we have included
> our own "sane-ctype.h" header. Consequently, the function declarations
> that exist in <ctype.h> for isascii(3p) et al will be mangled by our
> macros of the same type. The result is of course completely broken.
> 
> It's unclear why this issue only happens on Amazon Linux 2. My guess is
> that it's either specific to the compiler version or specific to the
> glibc version. We don't explicitly include <ctypes.h> anywhere, but it's
> being transitively included. So chances are that later versions of the
> toolchain reorganized their headers so

Hrmpf, what's going on here? Both this email and the first one at [1]
are getting truncated... I'll debug.

Patrick

[1]: <20250710-pks-ctype-v1-1-c668b308d628@pks.im>
