Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA98D43AB5
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 22:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711145855; cv=none; b=tzOc8wtPj8/RJvDqMqg8CWSZ5MJh/PgyE23X88zgWDh6/BjR7e80Gqp/SZoWPynJCOYI1wQe7fVhNJdzqpmUh3z9dM598IHjHyVcGkx1eLYKbemJjSaOWd/gl+urdDjqJvyuhao725IKBYDf3jV/CMKkT5lnQ3tXXdXTF2MSVco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711145855; c=relaxed/simple;
	bh=Y5NJBvBN4Ts1Jrz8PFTSKNFvQpSBMnumqOkx/ZmeXV4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=d/W193Ee1dzDY5pojusibWs0CjOlfxBU3wc2G0l0g/dx63CKPbyHoF3AhMv+TV29dS/qvpHoopBTc5sFGdjer2RiOjh9nrP8cDxf2AdpCbX9SfNEtcjEAf4aZPtVzbB7v1Me9s6bqEWiV96gaPRQlrOcAqyOYwxAlmlt+qzskYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=AeoQAKt5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sOVf2BA4; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="AeoQAKt5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sOVf2BA4"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id E794E5C004F;
	Fri, 22 Mar 2024 18:17:31 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 22 Mar 2024 18:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1711145851; x=1711232251; bh=5HOcmKRuHfbesEJy/+6MXG+/q/Qrk9mk
	b2eeyfbxCh8=; b=AeoQAKt5u4PGvvml30BKJ4P3aRzUSXh+hpBuPcyu8oA4pTZn
	jncmmUFaSf5ua9qhPzrn3AI2laq4VsnPo8koxrMk3GRuNn6kzTinZqYUrc62eK4X
	I6ZpEsZGgthkpoQf3kIUTMbzEaiYQoJnGT6tChlVpYerjKSgjeCHiBGf+44IQjKp
	5LtM2nehx2o7J6Py2LVi2GVvXs/0ZFfCMrsvzvimnoBBwErQtvVceRN++QdR0MMd
	5LHVOdJsWGxOUkwSusEzjHwtUCHrW1AI53EviHcic06MMug7d/soZrYreSV1mpIU
	OdXPVroiatZghmlNYWgO7siMdFBstWWjfl1NxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711145851; x=
	1711232251; bh=5HOcmKRuHfbesEJy/+6MXG+/q/Qrk9mkb2eeyfbxCh8=; b=s
	OVf2BA4ltCqfTH5hrFUcdWY4XVsMMJ4EkCmNmE0RE3w0AoJzxbNOpVxfolDz2ile
	jBdRn2GxCK/HvKIVScqtIyY/mS9gwsHDx7u99qM36AVgOnIcIcuiFkLsceTZvVJ6
	prWULpf8ulIyxNCrwPDhcQEmx/TSBiyJIy7TjH5A3y/zJm6G1h6CBeS2zNWI2Bmc
	8W1CACe3tw4VhRjlinJ9s6H49MQYzypCcuJCCXuQac9tgU8WWbYPuLO0+aU/6j5I
	GhgJ7ZmOt5EcVmCmE3HUrjxAt5gceof043I+xKBN138pxvEUOiGyajCAv649FX23
	/ds8EsyaBPKsANIYN1dAA==
X-ME-Sender: <xms:ewP-ZULw6VpmZ_Xm9SI6R4HSRMhJeNnwCydRuLHyMcUHQNwlvwcw04U>
    <xme:ewP-ZUK0ROTj53bAweskjwMYwlGWrWSo8BAwiW6Ke0GORDW3ml9w-8vXdnwYKwE4h
    zMt8-fy44Y_5WRuoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtvddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgfgse
    htqhertderreejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhk
    fdcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnh
    epvdevheeiudefheffvdetueevkeehhfeliefgkedtieefudetueehueeftefffedunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvse
    hkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:ewP-ZUtkbEtv22ax2pao4-Z5xVH65hTuSFcXs4FMxmsth_TP5mGYbg>
    <xmx:ewP-ZRaCSUNkw3pWN8SEkXFsHWNCWF1vDZ2pVAOuaGbo_uU0fKI6ew>
    <xmx:ewP-Zbbrt-1tc5WyikNXagnLyGjnUgjoMuauOhiY3fdaTq1UF4EDVw>
    <xmx:ewP-ZdB8wxUto43jXioqCPRyAzEMVSXs7-LQFu61wVxn62YZyqQeDQ>
    <xmx:ewP-Zal5NLiW1N2qoPW0H9RatLrB_71M2smezRQcyUEJTpejMHtsOA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A063415A0092; Fri, 22 Mar 2024 18:17:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fe89de4a-44aa-4d2a-8bb5-742a0bb4a7e0@app.fastmail.com>
In-Reply-To: <20240322095951.GA529578@coredump.intra.peff.net>
References: <cover.1709841147.git.code@khaugsbakk.name>
 <cover.1710873210.git.code@khaugsbakk.name>
 <9a7102b708e4afe78447e48e4baf5b6d66ca50d1.1710873210.git.code@khaugsbakk.name>
 <20240319212940.GE1159535@coredump.intra.peff.net>
 <20240320002555.GB903718@coredump.intra.peff.net>
 <20240322095951.GA529578@coredump.intra.peff.net>
Date: Fri, 22 Mar 2024 23:16:59 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Jeff King" <peff@peff.net>
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 7/6] format-patch: fix leak of empty header string
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024, at 10:59, Jeff King wrote:
> On Tue, Mar 19, 2024 at 08:25:55PM -0400, Jeff King wrote:
>
>>   [1/6]: shortlog: stop setting pp.print_email_subject
>>   [2/6]: pretty: split oneline and email subject printing
>>   [3/6]: pretty: drop print_email_subject flag
>>   [4/6]: log: do not set up extra_headers for non-email formats
>>   [5/6]: format-patch: return an allocated string from log_write_emai=
l_headers()
>>   [6/6]: format-patch: simplify after-subject MIME header handling
>
> These patches introduce a small leak into format-patch. I didn't notice
> before because the "leaks" CI jobs were broken due to sanitizer proble=
ms
> in the base image (which now seem fixed?).
>
> Here's a fix that can go on top of jk/pretty-subject-cleanup. That top=
ic
> is not in 'next' yet, so I could also re-roll. The issue was subtle
> enough that a separate commit is not such a bad thing, but I'm happy to
> squash it in if we'd prefer.
>
> -- >8 --
> Subject: [PATCH] format-patch: fix leak of empty header string
>
> The log_write_email_headers() function recently learned to return the
> "extra_headers_p" variable to the caller as an allocated string. We
> start by copying rev_info.extra_headers into a strbuf, and then detach
> the strbuf at the end of the function. If there are no extra headers, =
we
> leave the strbuf empty. Likewise, if there are no headers to return, we
> pass back NULL.
>
> This misses a corner case which can cause a leak. The "do we have any
> headers to copy" check is done by looking for a NULL opt->extra_header=
s.
> But the "do we have a non-empty string to return" check is done by
> checking the length of the strbuf. That means if opt->extra_headers is
> the empty string, we'll "copy" it into the strbuf, triggering an
> allocation, but then leak the buffer when we return NULL from the
> function.
>
> We can solve this in one of two ways:
>
>   1. Rather than checking headers->len at the end, we could check
>      headers->alloc to see if we allocated anything. That retains the
>      original behavior before the recent change, where an empty
>      extra_headers string is "passed through" to the caller. In practi=
ce
>      this doesn't matter, though (the code which eventually looks at t=
he
>      result treats NULL or the empty string the same).
>
>   2. Only bother copying a non-empty string into the strbuf. This has
>      the added bonus of avoiding a pointless allocation.
>
>      Arguably strbuf_addstr() could do this optimization itself, though
>      it may be slightly dangerous to do so (some existing callers may
>      not get a fresh allocation when they expect to). In theory callers
>      are all supposed to use strbuf_detach() in such a case, but there=
's
>      no guarantee that this is the case.
>
> This patch uses option 2. Without it, building with SANITIZE=3Dleak sh=
ows
> many errors in t4021 and elsewhere.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  log-tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/log-tree.c b/log-tree.c
> index eb2e841046..59eeaef1f7 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -480,7 +480,7 @@ void log_write_email_headers(struct rev_info *opt,
> struct commit *commit,
>
>  	*need_8bit_cte_p =3D 0; /* unknown */
>
> -	if (opt->extra_headers)
> +	if (opt->extra_headers && *opt->extra_headers)
>  		strbuf_addstr(&headers, opt->extra_headers);
>
>  	fprintf(opt->diffopt.file, "From %s Mon Sep 17 00:00:00 2001\n", nam=
e);
> --
> 2.44.0.682.g01e1dab148

I was wondering if the new empty-string check now makes the condition
look non-obvious. I mean given that

=E2=80=A2 You explain how headers-to-copy-check and have-non-empty-strin=
g are
  not the same
=E2=80=A2 You explain how strbuf_addstr() could do this itself (which ma=
kes
  sense) but how it could be risky

The condition looks bare without a comment. But the empty-string check
of course makes sense without this context. And it could also be read as
an optimization (and not a leak fix).

And maybe most people just `git log -S'*opt->extra_headers'` if they
have questions in their head. So no information is really missing.

--=20
Kristoffer Haugsbakk

