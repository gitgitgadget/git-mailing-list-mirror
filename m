Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE88390C99
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334536; cv=none; b=T/VdOHUTQ1jAoJqoQ0lDtO9Xoxjogsd4qDbxOLwLWNFsYd07Kv/wSvgYbFRCqeWTNPBx31BQAOIHSQT6jAGT4HS/guiMVdl9bkgF4I1w/qyABup6DPgMuOJkPUTTZT+0eCNFym+j3fjSZxN9lXejao/VynYjRK3wdpL3f+uUcCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334536; c=relaxed/simple;
	bh=gQ2L+REtgoxlEOiTMpwUXrkk56gcnFJ+hotl7hMoBZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tg5BxxqHYg0FhMBb+dXDBJnkOV3+Q4XWSghCGTJyBqzG44Mtf2ZQbSk9cBuW3sJwN1q2ZIkwGYFgAt0Zi01/XU2+kiiWbymFVdxj2pYJcOuAQgSMS+glDqMxQgNtyA3BrDFL9JSHIHVREs9iNll17YYn5G1tO4k0yt28B270sjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gNVsE6Pv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TGwVRiuB; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gNVsE6Pv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TGwVRiuB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 680A37A011C;
	Thu, 12 Mar 2026 12:55:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 12 Mar 2026 12:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773334534; x=1773420934; bh=1RbwvHUlEr
	1dm4Op4LPGprXffsdoxMejZjzXJjFV+x0=; b=gNVsE6Pvc43EPnaWYyO5HJnUno
	vJAOQTkg7Gvn1O4h7kasTyk7V1+F3+sLcNNOv3Zn00jZ6XuGz6/Ds1WkDh99JaUE
	L/AspWWC+JpeX1TTWTI3r7eNpdw7E9EImkGsoCn08kQSJkJxrokj6SnV+LcXuq2E
	V2h7PkZBqhIN4uCZGIsbosYHAaaArHfxmYcc9z0SglKdRaB0L+ZD0S5OtZC0mIMk
	k3PuC0l+v8LMhG3UbivaQ9YoapcqJKX+duSkW/wPZjV85jklAoc0pUdavNCuLtV6
	4Ia/FpmsZg+T2wr91CT5OBVGD8Qw8WgYyIyEtkjtu8g/Je9eerh5aN869r1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773334534; x=1773420934; bh=1RbwvHUlEr1dm4Op4LPGprXffsdoxMejZjz
	XJjFV+x0=; b=TGwVRiuBkI1Cx8DfayQ1HBwHgOB4CN6ZdW0hn/ZdtgGgO37Mjqr
	w91e5HfnsLupSNTz02vCjhdZQx9+WY+P5C//rkMgF+B36hWiSRKIz9aQLOLeyyCu
	3n49vxmJAGfyk9uf5XhCednquFXeYcR2gY2RyQE4cEoqjvy12+zxDiA7wmHhwPb3
	8Z/R/ZtDRUl1IJqsp3nSwFF9StFAfk0TjqMmS/9YosD2EkJcgysF21TTmeKcGdGi
	gjvy3aIDyq/3iYi17AwEHLQ7E8yIIj7nXTe3VzttyD8A54z+pcCXlnGoK5cQarMW
	WA9fOE7GbvKKY2B+rVBTtXqF1t+KEcA2Psg==
X-ME-Sender: <xms:BvCyab9c6Nb9FFzjvjb0cNg8n5w5zoi9QQhucn-Gwn3aZQpR7HDkMg>
    <xme:BvCyabZYyF1I-zmvRcnKNqDuMys_FlSzZl1DOFIeVcPbnreFg9FabD1Of79i0G4pY
    nCIQ7vxi9gtPcBcrMf0BOEo-_W6JXIjilWtsrUPQ4B_OipBdqM1hw>
X-ME-Received: <xmr:BvCyaS2kjNJZFRznzdrU4sBmVYMUhMya6RnnMtmyiyNyNxn0mogjwXBrlV_6cP2TAnVtmaq-E-InbAnaV5aJHvq3z1V1Ax_1rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhrohhikhesuggvlhgrhigvugdrshhprggtvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvrhhtrdifvghsrghrghesghhoohhglhgv
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:BvCyaebEy0Sv9EnGyPeJZVFzab8ENvpIBpVYm3gh9iRYqxtw4sDi7g>
    <xmx:BvCyaSJJJ7xBIIHwmFD3tc5AT_rT5v4GBLLacsU2Omq68DLqNXF3Mw>
    <xmx:BvCyaVHO9t5261saKHenhEFBQOmAa-KH3zAERWcvrCFFHNilP2vUIA>
    <xmx:BvCyaRsVJyvJ1PUkRwfKKt9n07R4pxg_0gBHzDFz_59VdsFMghByJA>
    <xmx:BvCyaZtwF4R4nG7HR1M1qI0uM26lWUeKFMu9i0VylX1BQd57Sowo1pTn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 12:55:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v8 3/4] format-patch: add "chronological" format for cover
In-Reply-To: <b67f1c9603bac9ea464357c77743e71c27003bd2.1773331753.git.mroik@delayed.space>
	(Mirko Faina's message of "Thu, 12 Mar 2026 17:20:10 +0100")
References: <cover.1772839973.git.mroik@delayed.space>
	<cover.1773331753.git.mroik@delayed.space>
	<b67f1c9603bac9ea464357c77743e71c27003bd2.1773331753.git.mroik@delayed.space>
Date: Thu, 12 Mar 2026 09:55:32 -0700
Message-ID: <xmqq1phpgf7f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> Having a user craft a custom format spec everytime might be a hassle,
> and having a common format that seems reasonable might make reviews
> easier. This patch introduces a new simple preset called "chronological".
>
> Teach make_cover_letter() the "chronological" format.

OK.  The "a fixed 'log:' prefix is still needed for future proofing"
comment from my review on an earlier step of this series still
applies after this step.

> Signed-off-by: Mirko Faina <mroik@delayed.space>
> ---
>  Documentation/git-format-patch.adoc |  2 +-
>  builtin/log.c                       |  3 +++
>  t/t4014-format-patch.sh             | 11 +++++++++++
>  3 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
> index de36b87a85..6364fd1f5a 100644
> --- a/Documentation/git-format-patch.adoc
> +++ b/Documentation/git-format-patch.adoc
> @@ -326,7 +326,7 @@ feeding the result to `git send-email`.
>  	Specify the format in which to generate the commit list of the patch
>  	series. This option is available if the user wants to use an
>  	alternative to the default `shortlog` format. The accepted values for
> -	format-spec are "shortlog" or a format string.
> +	format-spec are "shortlog", "chronological" or a format string.
>  	e.g. `%s (%an)`
>  	If defined, defaults to the `format.commitListFormat` configuration
>  	variable.
> diff --git a/builtin/log.c b/builtin/log.c
> index 4f22012395..12877a0ac2 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -50,6 +50,7 @@
>  #define MAIL_DEFAULT_WRAP 72
>  #define COVER_FROM_AUTO_MAX_SUBJECT_LEN 100
>  #define FORMAT_PATCH_NAME_MAX_DEFAULT 64
> +#define CHRONOLOGICAL "[%(count)/%(total)] %s"
>  
>  static unsigned int force_in_body_from;
>  static int stdout_mboxrd;
> @@ -1420,6 +1421,8 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
>  
>  	if (format == NULL || !strcmp(format, "shortlog"))
>  		generate_shortlog_cover_letter(&log, rev, list, nr);
> +	else if (!strcmp(format, "chronological"))
> +		generate_commit_list_cover(rev->diffopt.file, CHRONOLOGICAL, list, nr);
>  	else
>  		generate_commit_list_cover(rev->diffopt.file, format, list, nr);
>  
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 631669c159..5ec527bce9 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -392,6 +392,17 @@ test_expect_success 'cover letter with subject, author and count' '
>  	test_grep "^\[1/1\] This is a subject (A U Thor)$" patches/0000-cover-letter.patch
>  '
>  
> +test_expect_success 'cover letter chronological' '
> +	test_when_finished "git reset --hard HEAD~1" &&
> +	test_when_finished "rm -rf patches result test_file" &&
> +	touch test_file &&
> +	git add test_file &&
> +	git commit -m "This is a subject" &&
> +	git format-patch --cover-letter \
> +	--cover-letter-format="chronological" -o patches HEAD~1 &&
> +	test_grep "^\[1/1\] This is a subject$" patches/0000-cover-letter.patch
> +'
> +
>  cat > expected <<EOF
