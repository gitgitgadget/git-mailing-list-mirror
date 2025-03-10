Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0119B1DE3BA
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 20:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640400; cv=none; b=s2iWR+jzGNDUFOI6qO4nPe4fc49YtDqYKCHs5LGuMDIB4M1akQ/O+jCu+MZdprz/fqgWklUoH67yCQjN4ks9Vfe8nvaNLqjr/izI7jENVWt9AptPaNdXX/geQcpoTwbRArK1iFEfc5/YdEJAfZOqrHgCWqv+IRiReuG7hhWHxZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640400; c=relaxed/simple;
	bh=6Gb76nxMGvbEh7/VPey+c4rcRE44jfIHo+HXLm5fxZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HQErqOCmDDwbtWlQu0fHa7kwIfApChVV6EsKzxpwHo1cc80MxskFZks58Fnho4wxOYK9+zCVobFMABv6q5F5rhIR6yupUBVl2d/KUGO2TOh6lALcBPcp0ii++fPqOevDOBmOvQ68+/EZtX9vMcUCBGtg+JDqgLKlhEnMlX/aW0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oY4s2wbq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CvJ0PLN4; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oY4s2wbq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CvJ0PLN4"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 043B52540256;
	Mon, 10 Mar 2025 16:59:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 10 Mar 2025 16:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741640397; x=1741726797; bh=9ywYDgJGtu
	0AllprVLKANkXvweL+FoWcLZrOIXUj/KE=; b=oY4s2wbqlFBoCVG2EYEZ3XEqGD
	e/PGlGVMxTXgevD4nbdhC3rgufm3Hlz26VSG/5frsXV3vfkhq9gakZ/qkPkegPaZ
	nw/1LXOycFgCxbUc/5VWN1bfZ2TAN6ADeVdth71didF/PIV6jrFwIDg+x1vkA5Lq
	/eywc9hykZquHsVcL+mOUQpTscYMAAWVjyFUWPOdxPPtS3sZYz7u2lLIx+X5qUWY
	X9zh0sjPtyzV6v+BwB0yjjfbZIPtgvwDZRPAKop7q1gtHEivasZscfjHiQ1BraGa
	tM3uMRfpt8UtcN6L62livPmEwUyeJHV9SOgEekdlWVrcpv2Xp4AY6vSuO9Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741640397; x=1741726797; bh=9ywYDgJGtu0AllprVLKANkXvweL+FoWcLZr
	OIXUj/KE=; b=CvJ0PLN4F5FojHMwK/v+DI3c6KsPTuPhE0F2Z+a2C85Iee3NGwH
	A6G9VGHJMXfqGPjtuVBL/K1OhUZBgGkRlT1lmPq5ls6RbIXSG/2O7OOs0WkfbKzt
	pg1bi/J9PG/JsNiYIqw4I92CO5B0LVK5zsyoaUuYfh96Az82CSmVZPFYGL0lQ14A
	dhlxma6RflmQrY06Z2nhH1hF/iLcjoeEWAsy8FJLOH0EJDdLe/VFm0T2q2lp0SRj
	jHamksHR42QE8dhf8zr/fpnk0iJihzb7bbCb9fSZSJRru/C8jiLBt5vsIiCUy230
	cZgZhaJLffqbdHQ9ZhDZejyCCUKt5Sfu1ew==
X-ME-Sender: <xms:zVLPZ74Dug-OV3XgvNi8uMTadJvgyy6DTs67b8-Za0GtOsQsBdFARQ>
    <xme:zVLPZw5orlBztSwpiP7joXb_XxuxzMTdPKviiZjTmgA-B9Q2-I0Dmg15G6PQK7T5R
    jiRY_ld2TN5QMh72w>
X-ME-Received: <xmr:zVLPZyc6BxSDowqSpkjd3Q3t_yxtM79cgf9l0bvtrtTyfRzUUkyn21Fnic6KGEQhjLfsYC6UmrMZir_z2h2sGgFCVekZFtUZYQpz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:zVLPZ8I4KrjHe9OukhRx5CfQaQ2x-lzr-dyNJVzvmc0KigkYK85Mng>
    <xmx:zVLPZ_I6FCSkjLSsLSbYB3B1msMrF4axf2aKMcumJ2vPXLfYPhzZIQ>
    <xmx:zVLPZ1whkT3FmX7L9lKw2ZyTOkzLiu2JxTigbh6kfWLvPyuk_hpVrA>
    <xmx:zVLPZ7JtMZasHjeQcH-fiq3FxYdtXFbSr3iMaL3kRCNHNozaJvu1nA>
    <xmx:zVLPZ1juOWJ5humdR6rsPdzRf0ASx_qiN1puG0qXdaBYdE4Y2VJ7_xD_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 16:59:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  christian.couder@gmail.com
Subject: Re: [PATCH 3/4] rev-list: support delimiting objects with NUL bytes
In-Reply-To: <20250310192829.661692-4-jltobler@gmail.com> (Justin Tobler's
	message of "Mon, 10 Mar 2025 14:28:28 -0500")
References: <20250310192829.661692-1-jltobler@gmail.com>
	<20250310192829.661692-4-jltobler@gmail.com>
Date: Mon, 10 Mar 2025 13:59:55 -0700
Message-ID: <xmqqmsds61pw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> +-z::
> +	Instead of being newline-delimited, each outputted object is delimited
> +	with two NUL bytes in the following form:
> ++
> +-----------------------------------------------------------------------
> +<OID> NUL NUL
> +-----------------------------------------------------------------------
> ++
> +When the `--objects` option is also present, available object name information
> +is printed in the following form without any truncation for object names
> +containing newline characters:
> ++
> +-----------------------------------------------------------------------
> +<OID> [NUL <object-name>] NUL NUL
> +-----------------------------------------------------------------------
> ++
> +This option is only compatible with `--objects`.
>  endif::git-rev-list[]

As I said, I do not think we strongly want double-NUL and would
prefer to do away with a single NUL if possible.

> +static int nul_delim;
>  static int show_disk_usage;
>  static off_t total_disk_usage;
>  static int human_readable;
>  
> +static void print_object_term(int nul_delim)
> +{
> +	char line_sep = '\n';
> +
> +	if (nul_delim)
> +		line_sep = '\0';
> +
> +	putchar(line_sep);
> +	if (nul_delim)
> +		putchar(line_sep);
> +}

This looks, to put it mildly, strange.  The concept of the line
delimiter byte (which can take any single byte) is wider than having
a NUL as the line delimiter byte.  Why would we even want both?

IOW, wouldn't it make more sense to have line_delim as the global
(or per-invocation parameter to this function) and have
print_object_term() just use it?  If you want to make it behave
differently only when line-delimter is NUL (which I do not
recommend), you can switch on the value of line_delimiter being NUL.
So I do not see a merit in having two separate variables (except for
confusing future readers).

