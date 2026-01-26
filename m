Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346442C0266
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769458311; cv=none; b=JPliz3nRv2Q1m9PydiexEJqZ9aklv9ILrGFhZSMPHacxhciBG/T/n0sQhtilgoQ/ZaL6sbGHMoylOc1XgTsqzCsIOLM/T+reSO6sSTm0MQ8BC7ucCJ0oSWmDkarCVjulSS6o//7ftAEfu9euyte9u5D4SUPn2ujzySc3rVqt0mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769458311; c=relaxed/simple;
	bh=N86EPNtILh4IUWjj/pU97NYvxBgRmAkmShlSKs2dTXU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IlXojI/7dmND/qu/+iduRti2AHn/4+PgB5VQIJSvH6yUXDeX0z3KEsEqLfT4MHrfS0dklXqmK0CKLkv9kLBsP642jouhOWopZGwaSFJ9ILa6HBfUUKoZLWnIur4ZvfrSQ995vJL9LviETuW5+dADQw+JYKHOYox8mMZVa6kexFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ThSJIUaQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LNhDwOmp; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ThSJIUaQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LNhDwOmp"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ED4A67A009C;
	Mon, 26 Jan 2026 15:11:47 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 26 Jan 2026 15:11:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769458307; x=1769544707; bh=HOjcSKlrBH
	yN4skmSTa0443hImyQb+5Z2PCfuUBUSEw=; b=ThSJIUaQRZcNeX9fIKHVRNlP30
	YEBd1TsSsVRP6cEBOWPiv6UnwieZNU6aa/Nw20FlGO23sf97Oqo1vAPqJR3HR6a/
	qtEzTN3vOxchTEWVinVGiHWR0dKCVdiLxkYpOmOYe55Aq6oSmC0TrmXC2hQSWs/F
	/iB7FkLVcWKexx8bl6y9xZeU22/ckt217bzTsxFwaxurQHp97H2FtQJh4vyOJSb2
	AXZzn9hl9Ga8ejFVWKwfFMGgiV7jWomLEC5NjAkG6D/jibXiqkkkaEeU+PI0N4Ol
	nEaOFpaoGXlyGLhURDe9V/ZXhNIfhZ8UhjKap4z/7yZSHdSoq/HByShWURFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769458307; x=1769544707; bh=HOjcSKlrBHyN4skmSTa0443hImyQb+5Z2PC
	fuUBUSEw=; b=LNhDwOmpStsgvmi/cMnVrwNnWnRivHvXLlepX21RC8vVg90KBNk
	zqJyddKLeXOxnJbN9TY+YacPEvT+mzY6Me2B2HsX7OTbHzIBDTF3huicz4Zuf99k
	fzJR8I03QJFb3Fz1uIf1kAM6hssKTn+XFr6rzbJVU+/HRZmz8pZTMNuHUzPTSH+O
	wSjiLMGAhnHOMG9Z23MlrSGUsYCmoULe1ZPO0oE4NjOHGebiZ0RbddW6GWhHoYKt
	EyMHaIm597Yl2NXNz0eENvhWfKTOrdTI7eq3dKjda0O0wlrO6AXtnPckGQzAzeUT
	jfAupTQaQFc0xFEcDzUozpGxZOpBsPiU95A==
X-ME-Sender: <xms:g8p3aWlsh-lvsSdQBOFqzM5wk9lriJdxkn-99jJI6EOVIZBBbDJIjg>
    <xme:g8p3aRjATBD7E-KvnFeaCRo26YKMPmTVhVIFdprl4083HvLCiPUK7p6yU_25V0T9c
    y7UvkTSMV1YT-efQluxcKWhI3JFo3WbPtw-tslNzFsBkH3AKQ-XHA>
X-ME-Received: <xmr:g8p3aee0JhRui2kmU0l-s4P_teUGjIQoIzi01zJexcqdldamHHhhQ0zOcp-I-GCqSa7Nv0spdpxtvSlq4io-Z61xHHKxa5jeY2fcqcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheekheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghmihhshhhhhhgrrggrrgesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:g8p3aRgA5FX8oxku579txEC_trRFRfG8Ak1fuY9kyBCt0lgHszQ4HA>
    <xmx:g8p3aWxpv7bu9SScw3tBMXKrX8SWa3lHgdzpQQMhRP2F4jzT__a7ng>
    <xmx:g8p3adMJ9y7AwJwyOW9ovd2Ye4-gcjX8g5zJFPpDjA-4FZ9hYiswYA>
    <xmx:g8p3aXU3jwjr7JR5RrSLUAsaJ-61fepGsaK0M9cDXZVpscWjLsnBnw>
    <xmx:g8p3aVUeqEimyQDi0yNzwCjQ38TiggMzQ9vvpvRAq-HuzemUaP57FHUg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 15:11:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Amisha Chhajed <amishhhaaaa@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] string-list: add string_list_sort_u() that
 mimics "sort -u"
In-Reply-To: <20260126185604.90089-2-amishhhaaaa@gmail.com> (Amisha Chhajed's
	message of "Tue, 27 Jan 2026 00:26:04 +0530")
References: <20260122171523.94234-1-amishhhaaaa@gmail.com>
	<20260126185604.90089-1-amishhhaaaa@gmail.com>
	<20260126185604.90089-2-amishhhaaaa@gmail.com>
Date: Mon, 26 Jan 2026 12:11:46 -0800
Message-ID: <xmqq1pjci16l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amisha Chhajed <amishhhaaaa@gmail.com> writes:

> Many callsites of string_list_remove_duplicates() call it
> immdediately after calling string_list_sort(), understandably
> as the former requires string-list to be sorted, it is clear
> that these places are sorting only to remove duplicates and
> for no other reason.
>
> Introduce a helper function string_list_sort_u that combines
> these two calls that often appear together, to simplify
> these callsites. Replace the current calls of those methods with
> string_list_sort_u().

After this, only two callers of string_list_remove_duplicates()
remain in the codebase.

The one in builtin/fetch.c::cmd_fetch() smells somewhat fishy.  It
prepares a string_list "list", populates it with for_each_remote()
by appending remotes found in the configuration when asked to do
"--all", or append named ones with "--multiple", and then calls
"remove duplicates" without sorting the resulting list first.

 - A test should be able to demonstrate that the call to
   string_list_remove_duplicates() is not operating on a sorted
   string list.

 - Once a breakage is demonstrated, we need to devise a fix.
   Sorting the string list before removing would certainly fix the
   duplicates removal, but it will change the order in which the
   remotes are consulted.  I think it is currently "whatever order
   these remotes appear in your configuration file(s)", but that
   does not mean it is a random order.  It is very likely that they
   are in the order the user has learned to expect the remotes are
   to be consulted, so "sort and then dedup" might appear as a
   regression in behaviour.  I dunno.

The one in builtin/help.c::list_config_help() is somewhat fishy as
well.  I didn't read it too carefully, but it walks over keys which
is in sorted string_list, and sometimes pushes the key intact to
keys_uniq, and some other times munges the key and pushes the result
to keys_uniq.  I do not know if presence of these these munged keys
in the keys_uniq string list breaks the sortedness of keys_uniq.
If keys_uniq is *not* sorted, then running "remove duplicates" would
be broken, of course.  Again, a test should be able to demonstrate
if this is the case, and we should fix it as well if it is broken.

Thanks.

