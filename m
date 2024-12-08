Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2291876
	for <git@vger.kernel.org>; Sun,  8 Dec 2024 00:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733616127; cv=none; b=hDP3jFUAkdEik1GO0N3X1rO0ElRwJivfScTgvC8YpSubrWSDTWWEF38uQkJxdqnqtHDQpt7cr9Tr4gmAqdLib3QN/zpHe5Uuue6gIUYSWV07hmv+rHWBzTLbRGQS5eWsdL2IiGwCVmHjVVpC5Yzjvd3Alg2WeZGzt2UXe34RJM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733616127; c=relaxed/simple;
	bh=ABJmnS9WETnxIiPRVXQ4c8Z8u6Z1DBx762GkDrGDDtY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=crPjLTRtZOW+ENYyv+UXZV7X7Va/rAsnVPvnAJP1feYWRL6szP4cgtcK7C72rcJ5bsAvn1YvXFyuZvD+ORsEAR/Jdg4B/8wXajSCs24ypWxpCBMpPLflUQo9DZfPr/+ZCMlQQHctUDx8nVUFrMOSXDYxpoCfwvkhyr0fFTT+jyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xa1kfs8U; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xa1kfs8U"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ADD5B2540122;
	Sat,  7 Dec 2024 19:02:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sat, 07 Dec 2024 19:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733616123; x=1733702523; bh=2YhEkzTsWBhGwirxgOx06fHDfaTXbjMGNe3
	jcmFZEOw=; b=xa1kfs8UjrND6BtXi6tpoqHgzxC0EorJf+WlyQXpb3vdP0cXYGi
	fyzTsCLyTRq9NTIagn3IV+G//SXIesJJrJNGbxyAZvBXXL6gdfNBZ7yIkL9j1rxi
	9cL6U7bykjmHS++oXSiPe7AK0WuUyf38dVHguai19YO4vq5RiEpAEKtq2NcVw//s
	M2P8haAEqDaOsCzf7RWZzrU8n77Qm/L8PgESpUBMQ52o6MS418dwYphgoNGorSe1
	gk/ydtSNjB9tpLi7CplCXOsH0v9k7ivVoLp/dredl7IKwXYXpKOvciwd68r5+kcR
	24Q9fCDiHinFcxVvu81v3fU3tC9BTFkHbEA==
X-ME-Sender: <xms:--FUZzXQwDEqpqG1QbLrqS7F_i3Soedz89BFANhfd1SbEoNq-40Wkw>
    <xme:--FUZ7lg-phbg1d8-df2dLu_-T5p7-Hcg-v3tC7rDQZVJEeSElvdm19p7b6KQuFP7
    lJzdAD_tICtpCYpgw>
X-ME-Received: <xmr:--FUZ_a8baWIBDayMn3dxqIy7MoY3pgsGs-N8fHy-XGr0_9OYW2XAIfxlmMLyjqwMR_Jma7bg5aL4BdvKv_azC-Ly4tyt5cKjoWhVpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjedvgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrohihvghluggrrhdtse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehjoh
    hhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:--FUZ-XkKdOvmKjKEFywVg0TWLAEvnQJN87MCtIje3Cz5ptoGbkNfg>
    <xmx:--FUZ9n322EIasOd_hCWKW-5uhSYlL2G06GTjiLYvHKeuLuFm1KILQ>
    <xmx:--FUZ7cZSHa5M0FzjfgR0S6Px2-3UyBg_0buH2g1lwqslNyal0Y2qw>
    <xmx:--FUZ3HuHv2TqiP0dHI9NS0-zGXVOzmEo2LPLerGnRBCLVQHfS6bBw>
    <xmx:--FUZwtRrpjSaw-uaqUykHvhNAsy8PEdkzDV8FJReyWSHGmw3mLng_uq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Dec 2024 19:02:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Roy Eldar <royeldar0@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] git-submodule.sh: improve parsing of short options
In-Reply-To: <20241207135201.2536-4-royeldar0@gmail.com> (Roy Eldar's message
	of "Sat, 7 Dec 2024 15:52:01 +0200")
References: <20241207135201.2536-1-royeldar0@gmail.com>
	<20241207135201.2536-4-royeldar0@gmail.com>
Date: Sun, 08 Dec 2024 09:02:00 +0900
Message-ID: <xmqqr06jrqiv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Roy Eldar <royeldar0@gmail.com> writes:

> Some command-line options have a short form which takes an argument; for
> example, "--jobs" has the form "-j", and it takes a numerical argument.
>
> When parsing short options, support the case where there is no space
> between the flag and the option argument, in order to improve
> consistency with the rest of the builtin git commands.
>
> Signed-off-by: Roy Eldar <royeldar0@gmail.com>
> ---
>  git-submodule.sh | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index a47d2a89f3..fc85458fb1 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -77,6 +77,9 @@ cmd_add()
>  			branch=$2
>  			shift
>  			;;
> +		-b*)
> +			branch="${1#-b}"
> +			;;
>  		--branch=*)
>  			branch="${1#--branch=}"
>  			;;

OK, so we used to take "--branch foo" and assign 'foo' to $branch,
"--branch=foo" now does the same, and then we have "-b foo" doing
the same with this step.

> @@ -352,6 +355,9 @@ cmd_update()
>  			jobs="--jobs=$2"
>  			shift
>  			;;
> +		-j*)
> +			jobs="--jobs=${1#-j}"
> +			;;
>  		--jobs=*)
>  			jobs=$1
>  			;;

This is a bit curious.  If you stick the principle in 1/3, this
should assign "4", not "--jobs=4", to variable $jobs upon seeing
"-j4", and that would be consistent with how the $branch gets its
value above.

As I said in the devil's advocate section in my review for 1/3, I
often find the value of the variable spelling out the option name
as well as the option value (i.e., force="--force", not force=1;
branch="--branch=foo", not branch=foo; jobs=--jobs=4, not jobs=4)
easier to debug and drive other programs using these variables, so I
do not mind jobs=--jobs=4 at all, but if we want to be consistent in
the other direction, this would probably want to be modified in the
name of consistency?

Other than that, all three patches looked sane to me.

Thanks.


	
