Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CFD3F0ABE
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 17:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151533; cv=none; b=QgahooKZtCgtjVSdMk6/SMs4K1ZgA1l+4Z7a8PjyhzKQMGJTYCG4jJko/m56xlEH4m/m0ppyTtM67eS7zl+wO8RYDGmxGkao3u3N8JAFbYIJN0STh00jjTcI34n2+UCBkEihGUQ24oB+6RqCbKK7cJ0iD4yJHOfdbWpFvyCZKnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151533; c=relaxed/simple;
	bh=Cnhbj24J7M351rzxan5LVrgIp0GqNv6VniOhBcsoCcE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jAc0xDra+J/J+OAYSgBWkhJAz4HUkhpQ9rQFmCZfGG0OZKMOzFUYNK3pag6Iy9UihVif7g1HgH9C2QwavPAS+MXJeFCppGQ3IYVY8T1NRkbM/HNXsC9UF3GrFsD56TiGW7VLh7sNkF3bMhnaklfL461et0ZVaiJYgg2Q5BSvT6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UrECKPGD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eX/+baok; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UrECKPGD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eX/+baok"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 31A807A016E;
	Thu,  2 Apr 2026 13:38:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 02 Apr 2026 13:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775151529; x=1775237929; bh=Qhp66V4BgQ
	RZx0LnRB1DDxIdDbA4ed5hLEK5eWtE/84=; b=UrECKPGDT4csfYwTL5baVeu3Sp
	Jv5bvWvUMEGb6JqaajioTzjhw4V4qSoy6MrNCS/whZDOHM1nDIoFwpxEkvA2sw0K
	x3gKSY7pGNTRNc0OoCtYGXQy/ERassrj3E+36qvl1bWnklCjstTKPxbcrrcABQJp
	PYiqIfBDfLo/d2x1LGffZ3UqA6BCS9VhaEBu18P+6HvcvEZ/jM2TyFs2z87lEEI8
	H8Ms1Mr2HD+rs9+c77K6vOpjIkaAzyNPpzycmt7HYO1YUu5dCegEwo5bq86o5kNQ
	X6/KpxotkmYTV0Db8aS0fU4jyTW4G2WezaFATEznPWKh+WqZ8IlPkewDgG9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775151529; x=1775237929; bh=Qhp66V4BgQRZx0LnRB1DDxIdDbA4ed5hLEK
	5eWtE/84=; b=eX/+baokTtEvI2E6pdlID7w2WNBozXuZC9mrJZ0BiGnhjZsW4j6
	OFVdZ4zv6JoGpQ7JPOWvh0YChFlnlwdyzi5y/E3S+p2r+OCObilHumekGUX7qmUi
	IAcSN3In6G5QhFAZC33hoX8ZnTaxW8yT5E6q1LBAkmUAWPS3HxMkOLxnchWEf5UE
	diCc3es1Xmu1Y86UAxxycozThO+nofLE3V6mODMwvIfVQ7/yHHvPf7gy7a48NZnJ
	Tk8D2MwK3Oanl27Qj5no9yDm8UF9PRNUsymixZZ8wwvhICGYgLjBosWZMsyu0wMc
	2meMkGfEzUnKBljG+kOnp9Zvfpz8ZTdw29Q==
X-ME-Sender: <xms:qKnOaSMcrBqdArZkyrqfEjw3OHKFn9tAR45oAqyrXyNyLyHpBzoBxg>
    <xme:qKnOaX1TAGKj8Rc3P6DQL1tCHMnNYa73dI3FW7obtjvLv7EtSVlWN4UWk3P76VVyE
    LI7RIsddh3PIu119njiLT0_wfLXrdw-MwU-S58WeBr_PuBmvrmqLA>
X-ME-Received: <xmr:qKnOaRltdAW1AouYyM3xyo3Tb4KVZ3xbX6wCMgqYGhZ0Nn56U6s6HOyhgQW8jRYLcFPoH6h6yiY69Z914SmFgIlAOLyFk5p35A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    thholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehjrgihvghshhgurghgrgelle
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qKnOaeUTRLPiDeh76maJ1T7wWH80Qklo4wRxNm7zKmE283kVhedBZw>
    <xmx:qKnOaXvzDaDVohdmxpQ4uNmaTdeYC3hqC46b3hCDPkhkviUI2LBzig>
    <xmx:qKnOaRaHEdKb0ntQCjN6V8WfNXaL1YhOH6tbDE-Ht1Eal6SrKiUkTA>
    <xmx:qKnOaWWQVSOJOy27CizIjDEBP64O-KJr_R0qkPXJrHHSNtDre3EsfA>
    <xmx:qanOaVlmx3efWu9_NKcj8oo4JFv3oaTAUkbAOmVdz7-X9arDdeA88gAq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 13:38:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Jayesh Daga
 <jayeshdaga99@gmail.com>
Subject: Re: [PATCH] repo: add paths.toplevel to repo info
In-Reply-To: <pull.2264.git.git.1775150062407.gitgitgadget@gmail.com> (Jayesh
	Daga via GitGitGadget's message of "Thu, 02 Apr 2026 17:14:22 +0000")
References: <pull.2264.git.git.1775150062407.gitgitgadget@gmail.com>
Date: Thu, 02 Apr 2026 10:38:47 -0700
Message-ID: <xmqqpl4hqn2w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static int get_paths_toplevel(struct repository *repo, struct strbuf *buf)
> +{
> +    const char *wt = repo_get_work_tree(repo);
> +
> +    if (!wt)
> +	return -1; /* match existing error style */
> +
> +    strbuf_addstr(buf, wt);
> +    return 0;
> +}

Funny indentation.  In our C codebase, one level of indent is one
horizontal tab "\t".

> @@ -87,6 +98,7 @@ static const struct repo_info_field repo_info_field[] = {
>  	{ "layout.bare", get_layout_bare },
>  	{ "layout.shallow", get_layout_shallow },
>  	{ "object.format", get_object_format },
> +	{ "paths.toplevel", get_paths_toplevel },
>  	{ "references.format", get_references_format },

Instead of adding yet another one as people think of it, can we
first take an inventory of what is available from the kitchen-sink
options of "git rev-parse" and make a list, to be compared with what
is available in repo_info_field[]?  Add that correspondence table in
a comment before the definition of this array, and it is perfectly
OK if the right hand side on many rows say "missing", like

    /*
     * rev-parse --<opt>	repo info <field>
     *
     * is-bare-repository	layout.bare
     * is-shallow-repository    layout.shallow
     * show-cdup		<missing>
     * show-prefix              <missing>
     * show-object-format       object.format
     * show-ref-format          references.format
     * ... more ...
     */

There can be two classes of <missing>, ones that we want to have but
haven't been implemented eyt, and others that we do not think we
need.

Also, we may not want to limit the existing sources of information
to "rev-parse", in which case lines of such a correspondence table
may need to be grouped by where each piece of information is found
elsewhere.

>  };
>  
> diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
> index 39bb77dda0..470e06e8c2 100755
> --- a/t/t1900-repo-info.sh
> +++ b/t/t1900-repo-info.sh
> @@ -155,4 +155,20 @@ test_expect_success 'git repo info -h shows only repo info usage' '
>  	test_grep ! "git repo structure" actual
>  '
>  
> +test_expect_success 'repo info paths.toplevel' '
> +    git repo info paths.toplevel >actual &&
> +    echo "paths.toplevel=$(git rev-parse --show-toplevel)" >expected &&
> +    test_cmp expected actual
> +'
> +
> +test_expect_success 'repo info paths.toplevel (bare repo)' '
> +    git init --bare bare.git &&
> +    (
> +	cd bare.git &&
> +	git repo info paths.toplevel >actual &&
> +	echo "paths.toplevel=" >expected &&
> +	test_cmp expected actual
> +    )
> +'
> +
>  test_done
>
> base-commit: 256554692df0685b45e60778b08802b720880c50
