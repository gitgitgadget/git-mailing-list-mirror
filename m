Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714CC1362
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 00:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731630693; cv=none; b=CBL7O/t4PhRIEK6i5PSMG5vUw4RllOucTyz6c515Qi/dhjr2XYzUo96X0t93QG5iIyssxwttKTXK3thqW3PAD1edD/kunEISDYGHRo/T5dTXh6yOzTMUZntVJXsHXemgGnV21pwNf8jp9CRTWIUOjjLOgbPTXeS5olWJtVHoC6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731630693; c=relaxed/simple;
	bh=LX+ulHywryMBuTWynqZDFE0UB39M9pF/pzNG5uRQ98g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sryXFpOkoB24yZUT/bAuRC0TyW3U3B2NfbRO3L0nLfwWp/ra5SS6ONrUwnrYOaf9tXgZsSo3q7PAV4jd6R1X7gbUoQGTbH1Ll40C8nSj/qhWeraSSsV5ITbNE++cItoeEHglTCQV0cSFUwn4l8RW75yeGdNEgyOe/bkchP9/Tlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cl0yYixY; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cl0yYixY"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8004711400FA;
	Thu, 14 Nov 2024 19:31:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 14 Nov 2024 19:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731630690; x=1731717090; bh=aUccdmEvEIOdBpdICcTE1beKU+MJgREzHg7
	W3gXAEEE=; b=cl0yYixYZTFLjRQaZLu8eSrKr4KhnBuSxY/CS0RbuDLDAskC+zs
	0D/cNYX4AoTu0UPOjOK20SaF4SeVOr+Or3tMvKz/PEBAAZHr8HyXGlSquEKczVYA
	C8572EtRAOiiR3hqQ83fmfOzeua1/ThGgMNw7X5rZXcnXoPquFAlrm1nxQg/JRo6
	ydZYw4x7yS/3fVDM14HDtmAqm0EzAgd653QteM18iuu/995gareNpz8WWVeMZsiy
	wbdTKoCM1kZ8ltYu7V0o5KMRnP+E3zzOUPqobRTrMQVZOyjt77V9yQAsZ0dGDYL9
	474XGzljNqE89qv9ypfPpgJB0iaGCSQ07tQ==
X-ME-Sender: <xms:YpY2Z1Zv25ifD5YeyFrI-ZN0lmZWMvZHh1DwSaz3TkdJqD_cfdB1AA>
    <xme:YpY2Z8bHs7od6UPoJv8fO3c5WnMdiTCo_QEQslLzrMoxZKF71gUOSHc0EfNoomDrn
    Lz1wI-Sup6mtCRptQ>
X-ME-Received: <xmr:YpY2Z39L8Nl3cZ8bKseDI2AI00XmeY5swKM3BSzG8reNPnVTx1G3VPsS1apAF0x3AR7ekSdHXBRiKUZlR8se-L1YXon3vHPdj_0T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:YpY2ZzqrG68YuRQaLfDseaIrzSImee_oEMDCjR0CvO_CjaeQd04kYA>
    <xmx:YpY2ZwrIWczg9iHu5XBssmnRkB8_bG0a6rGnpIWdEXDUh1KDpw8Kkw>
    <xmx:YpY2Z5TEEUKhbirx1Jf3ncRgkPQv2HwY-qfXJ9NBJwlq1ZGplijNiQ>
    <xmx:YpY2Z4o8Oxsb62-Ji3oAvYVp8AQjTQsJE4ALZffu-DtEKek3djIe9Q>
    <xmx:YpY2Z5kSIBgf8DiAz0yNexI6q0n80ElQGXzkB6aMmOomrUlIy_cATbWn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 19:31:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] fast-import: avoid making replace refs point to themselves
In-Reply-To: <pull.1824.git.1731610074707.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Thu, 14 Nov 2024 18:47:54
	+0000")
References: <pull.1824.git.1731610074707.gitgitgadget@gmail.com>
Date: Fri, 15 Nov 2024 09:31:28 +0900
Message-ID: <xmqqzfm149sv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Most git commands that you try to run in such a repository with a
> self-pointing replace object will result in an error:
>
>     $ git log
>     fatal: replace depth too high for object fb92ebc654641b310e7d0360d0a5a49316fd7264

After reading up to this point, with "Most git commands", I was
afraid that you were going to say "... but I found this command that
fails to stop gracefully, and instead infinitely spin".

If that is not a case, then I am happy ;-) but in that case probably
"Most" -> "All" is warranted.

> Avoid such problems by deleting replace refs that will simply end up
> pointing to themselves at the end of our writing.  Warn the users when
> we do so, unless they specify --quiet.

This may need a bit of rephrasing.

Even when they specify "--quiet", you'd refrain from creating a
self-referencing replace entry, which makes sense, but it was not
clear with only the above description.  I had to read the patch text
to find it out.

Is it reasonable to expect that a self referencing replace entry is
the most common thing to happen, or loops with more than one
elements are equally plausible to happen but the self-referencing
one is singled out by this patch because it is trivial to notice,
unlike other forms of equally problematic loops?

> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 76d5c20f141..51c8228cb7b 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -179,6 +179,7 @@ static unsigned long branch_load_count;
>  static int failure;
>  static FILE *pack_edges;
>  static unsigned int show_stats = 1;
> +static unsigned int quiet;
>  static int global_argc;
>  static const char **global_argv;
>  static const char *global_prefix;
> @@ -1602,7 +1603,19 @@ static int update_branch(struct branch *b)
>  	struct ref_transaction *transaction;
>  	struct object_id old_oid;
>  	struct strbuf err = STRBUF_INIT;
> -
> +	static const char *replace_prefix = "refs/replace/";
> +
> +	if (starts_with(b->name, replace_prefix) &&

Curious how the "diff" machinery decided to represent the hunk like
this, instead of say

>  	struct strbuf err = STRBUF_INIT;
> +	static const char *replace_prefix = "refs/replace/";
> 
> +	if (starts_with(b->name, replace_prefix) &&

Of course that has nothing to do with this patch or its review.

> +	    !strcmp(b->name + strlen(replace_prefix),
> +		    oid_to_hex(&b->oid))) {
> +		if (!quiet)
> +			warning("Dropping %s since it would point to "
> +				"itself (i.e. to %s)",
> +				b->name, oid_to_hex(&b->oid));
> +		refs_delete_ref(get_main_ref_store(the_repository),
> +				NULL, b->name, NULL, 0);
> +		return 0;

I am not sure if a warning is even warranted.  If you decide to
replace an object A with the same object A, the result ought to be a
no-op.  I wonder if it is makes more sense to

 (1) do this unconditionally and silently, and
 (2) when we prepare the replace_map, ignore self-referencing ones.

instead.  If (2) makes sense entirely depends on the answer of an
earlier question (i.e. "is there a reason why self-reference is more
common than general loop?").

Thanks.
