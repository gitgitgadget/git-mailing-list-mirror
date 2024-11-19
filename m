Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A671422B8
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 03:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731986978; cv=none; b=hFlaGKHy8LxMvuqnR72bxwn/9CuinKXXHYrKp3ZVG7lhsZHnzsROyfZqqGvFXtGLZTKR/4mDLpBH2tuEw0HmeFGtAmBjck3QuyDZYDwrczuWpULEKGcKwWBt6YT8d4aVZyn2R5uL7yr5vW/YXks07OZ8cBnIdBIjbP02IHxyFsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731986978; c=relaxed/simple;
	bh=+nHKcWmx6ccZRqMnRf47NrP1yFljbyWPfckFjgYTjwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EAFpiLI/CZBJDUG8bqV0Rwk/Z6Yuh8Sb7iovnh3ZvveLa/aSCUjKruYAd59qK1pDXEoEsy11xan2Wu4uNK3TonTRePqJat6BhZzesx7JDsz65vHlDPpJKoJ9ZEk//f84j49B+ZfQY3fLvH2JLuI+UL+ATxNOrt1w1vS4QsOevw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AFJJH0gj; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AFJJH0gj"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1E2FF25401BE;
	Mon, 18 Nov 2024 22:29:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 18 Nov 2024 22:29:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731986974; x=1732073374; bh=HPg4RcsfQqiH+gTwkyFyFpyHoxEvObY63xX
	1xhU1OkI=; b=AFJJH0gj+lP4VcOug/EYBgZJF6ROCdAF9Zt2T6mn5hHcBJgiskD
	12MA8DonORwWcQNXspY4geMngm9ns8RTBwlylu5P5mU+G4XuyvRtg6YQw+467kfO
	JiX971kDv5PjQmjkdXxUzSOPu7PV4iqhch65xtLDPd6aOZ8lusdSoXlfpGiaHik0
	vb+bsxcfFbH5QbfEWHl/bGDrQRHujP+KFeQPTsLivyregc0eVg2j9r9B2FyKmZCm
	P7VXUz6+Ptj+/302HhNuSz9PJrID7kBwNX+PARto01zdJybtViy7N9PNQ+Dsilsr
	lAbcq8OjCNPcD94+2T3xN9FRxYggyeuZJeQ==
X-ME-Sender: <xms:HgY8Z1uRtUTof27U034g76s8QBDwSQ8SHz-nrqlfZGA_Rt3nmiz7qQ>
    <xme:HgY8Z-fBwJOH6MMhe1WQufWB5ciPXVDHbSwpQ0Zr1IlCpVudh7Igno9yi77_nqQhw
    0IgdcMM3bhit9JvVA>
X-ME-Received: <xmr:HgY8Z4xxnCGXalrL9-buRJFowXk9LcHTr0LwCscY3H2Pds1-8AvVKUzuIckgvw90NHrGanjoEI7vYuRk3SsjJdWwX0wMRxxaWnZq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedugdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HgY8Z8OMkzcPUrP6LL_a3al4BBwsEnnsN14hokUzFxUo9b-V2DVsTw>
    <xmx:HgY8Z1_lUVS6tkFJoqAlBuwT8B70sCBrvWh9XZXAnVB6SsmymhUOgw>
    <xmx:HgY8Z8WfbNGJ6sJfQ14t9esTgYsnhM0EJWoGQ9WxqT1vTpkt4iONww>
    <xmx:HgY8Z2eWBFUEENRRfKzW0Hxhw3jwszqtqc_dBD1Om7vrvly2pMSEIw>
    <xmx:HgY8Z4nS2_ExNci2Ja9cyG9tw7fywi0ntet4s3LJxnuRLZPGVCS6CgrD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 22:29:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org,  peff@peff.net,  stolee@gmail.com
Subject: Re: [PATCH] index-pack: teach --promisor to require --stdin
In-Reply-To: <20241118190210.772105-1-jonathantanmy@google.com> (Jonathan
	Tan's message of "Mon, 18 Nov 2024 11:02:06 -0800")
References: <20241116032352.GA1782794@coredump.intra.peff.net>
	<20241118190210.772105-1-jonathantanmy@google.com>
Date: Tue, 19 Nov 2024 12:29:33 +0900
Message-ID: <xmqq1pz7gaua.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Tan <jonathantanmy@google.com> writes:

> Currently,
>
>  - Running "index-pack --promisor" outside a repo segfaults.
>  - It may be confusing to a user that running "index-pack --promisor"
>    within a repo may make changes to the repo's object DB, especially
>    since the packs indexed by the index-pack invocation may not even be
>    related to the repo.
>
> As discussed in [1], teaching --promisor to require --stdin and forbid a
> packfile name solves both these problems. This combination of arguments
> requires a repo (since we are writing the resulting .pack and .idx to
> it) and it is clear that the files are related to the repo.

Makes sense.

> This change requires the change to t5300 by 1f52cdfacb (index-pack:
> document and test the --promisor option, 2022-03-09) to be undone.
> (--promisor is already tested indirectly, so we don't need the explicit
> test here any more.)

OK.

> This is on jt/repack-local-promisor.
> diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
> index 4be09e58e7..ac96935d73 100644
> --- a/Documentation/git-index-pack.txt
> +++ b/Documentation/git-index-pack.txt
> @@ -144,6 +144,8 @@ Also, if there are objects in the given pack that references non-promisor
>  objects (in the repo), repacks those non-promisor objects into a promisor
>  pack. This avoids a situation in which a repo has non-promisor objects that are
>  accessible through promisor objects.
> ++
> +Requires --stdin, and requires <pack-file> to not be specified.
>  
>  NOTES
>  -----
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 08b340552f..c46b6e4061 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1970,6 +1970,10 @@ int cmd_index_pack(int argc,
>  		usage(index_pack_usage);
>  	if (fix_thin_pack && !from_stdin)
>  		die(_("the option '%s' requires '%s'"), "--fix-thin", "--stdin");
> +	if (promisor_msg && !from_stdin)
> +		die(_("the option '%s' requires '%s'"), "--promisor", "--stdin");
> +	if (promisor_msg && pack_name)
> +		die(_("--promisor cannot be used with a pack name"));
>  	if (from_stdin && !startup_info->have_repository)
>  		die(_("--stdin requires a git repository"));

OK.  Thanks, will queue.
