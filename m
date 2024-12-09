Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F4319E97A
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 23:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733786814; cv=none; b=oY5oiiuRIOE5Snj9fv5JetDm+3dxyC+A5463ZCL3guZ/bGm+ykuMfOZsXJ1kSDCS5OFSkPI0D1mWVrDKYX8vONOvyoMLsNbUjM4+N+2fX6wx1ssZIhtHpKv65uOl5f7UyD2ORcwqKNU+gR5phYqqmeSX8Cc5GeOZN5mhycHXirU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733786814; c=relaxed/simple;
	bh=PQZO3BdwrfA4cCtXsyMZgRxsPa/RMpiF1Isl5izvJ+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eyYiJ3In43mfzF1KxyfT6D8ldZ87FSsoaAQcE9uc+jFHABDC6MFtRCf11D4mffTx3w7pz/Vwwp2FJoC/oWyOJU980Ri8c/F/VUnmtpv5RCwn8JULPNyeF6cZZ1IvFxW4dojOZ29PwDynHLGBM6kmrlKYPGn8RjqAtbmWflLzRNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P/BC+xJs; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P/BC+xJs"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DD050114011A;
	Mon,  9 Dec 2024 18:26:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 09 Dec 2024 18:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733786810; x=1733873210; bh=NrJ4WepOzm+gxdl7TYUwBBfCpKxsZFbtrh2
	LR4dGjRY=; b=P/BC+xJs09p+JB+J+GbsbPY2L1Up7L+EjXXCh6+eACxuZMknktT
	GDvIU5VZezeXVbjSxysjXWCrmEYGF7zG/0ikljAFZeSqY4ERahGV/HbzQkJXnmdf
	VAlsNPXtOsjdwxdyF48+3HuFqKZeYE+e1BZuEHJUFv5Yhd4Y4ZnLNCY/ZIlDIZ2r
	Zw5zMfMw+/gIXvVN15fXY80ciLMyxkBlBk7QUYL3um9AXJY32ct//lfzrBdT7LqW
	CUSOmWZACh3btsL6V4y5K7I/U0uy89Lc8fQ507v59Z0dWGQu8RLBJROq9rveoP8y
	xbEywmNqiAnQh4mbkNbxwBEewZQ5NuqqSxA==
X-ME-Sender: <xms:unxXZ3QKGr-X6_Z9iwXIX0B4ZsCZENmhUZuWqtX4aXF6_V40so6-DQ>
    <xme:unxXZ4zHYEauhIee2bgt2lZLHtN6i_KAFIqWmFLP1gPAsyNTSwNRTZfY7Ev878pBe
    70WeR6dQrZ7NCYxJA>
X-ME-Received: <xmr:unxXZ80W7T5JYichFeXAV42z-uupNcUR2iMyUdyej-Tm53ljsfdHPmttbUYn-9pFRxPPg8bWAhW5E1cLUKJoVrcF-pPQ4FC2PWF2foo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeejgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeevteev
    veeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtoheprhhohigvlhgurghrtdesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghvrghrrggsse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhi
    nhesghhmgidruggvpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtoh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:unxXZ3BPTt2W7aABKdd71O3dEubgaLVYZbHPC0KesILRCpxOCWiEcA>
    <xmx:unxXZwg3Oi38RM5Xennavdcka5VsoaHUEG7hsUKpyv_rZcl8ohdMEw>
    <xmx:unxXZ7o6gbs7FOmfYnOW9BTlZaAo1Ut_Xhrl5fkZCEFChiMeAoDt3w>
    <xmx:unxXZ7iu3tJG31sMDGeMAY9quERMgdaGcTRms_TtCL0eX8BR_TkdyQ>
    <xmx:unxXZ7X0rqEHx3HhUxPJ5uITGs0k0an4wI8mofH8LMhzsFC-5UUF4CbW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Dec 2024 18:26:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Roy Eldar <royeldar0@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/8] git-submodule.sh: improve parsing of options
In-Reply-To: <20241209165009.40653-1-royeldar0@gmail.com> (Roy Eldar's message
	of "Mon, 9 Dec 2024 18:50:01 +0200")
References: <20241207135201.2536-1-royeldar0@gmail.com>
	<20241209165009.40653-1-royeldar0@gmail.com>
Date: Tue, 10 Dec 2024 08:26:49 +0900
Message-ID: <xmqq1pygo2ti.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Roy Eldar <royeldar0@gmail.com> writes:

> When we run "git submodule", the script parses the various options and
> then invokes "git-submodule--helper". Unlike most builtin git commands
> which parse short/long options using parse-options.c, the parsing of
> arguments is completely done within git-submodule.sh; therefore, there
> are some inconsistencies with the rest of the commands, in particular
> the parsing of option arguments given to various options.
>
> Improve the handling of option arguments for both long & short options;
> for example, passing flags such as "--branch=master" or "-j8" now works.
>
> Changes since v1:
>
> - Make variable values always contain the option name.
> - Rename a couple of variables in order to improve consistency.

After reading this, it was confusing to see [1/8] still doing "1 or
empty" boolean, only to be further modified in [7/8].  We prefer to
see a single series stumbling in the middle and changing the course.

Just a tangent.

While a simple wrapper script is generally easier to debug and read
if $verbose variable's value is "--verbose" or "", there is a case
where following this pattern is not a good idea.  If an option we
are eventually going to give to the underlying command takes a
value, the value can contain whitespace, and the option and its
value need to be passed as two separate arguments, it is less error
prone to use the "variable only contains the value" approach.

Imagine that submodule--helper takes a "--foo" option with a greeting
message like "hello world" in such a way.  We'd want to trigger it
this way:

	git submodule--helper --foo "hello world"

as we are assuming that for some reason we need to pass them as two
words, and

	git submodule--helper --foo="hello world"

is not an option.  In such a case, a wrapper script that takes such
an optional parameter in $foo is easier to write like so

	# parse
	foo=
	while ...
	do
                case "$opt" in
                --foo=*)	foo="${1#--foo=}" ;;
                --foo)		foo=${2?"--foo without value"};	shift ;;
		...
		esac
		shift
	done

	# interpolate
	git submodule--helper ${foo:+--foo "$foo"}

in order to avoid the value given to the option split at $IFS
whitespace.  With foo='--foo="hello world"', passing it to the
underlying command would involve use of eval and becomes error
prone.

I am assuming (but I don't use "git submodule" very often, so my
assumption may be way off) that there is no such variable we need to
pass, but if not, we may need to reconsider and use the "variable has
only value of the option" for at least some of them.





> Link to v1:
>
> https://lore.kernel.org/git/20241207135201.2536-1-royeldar0@gmail.com
>
> Roy Eldar (8):
>   git-submodule.sh: make some variables boolean
>   git-submodule.sh: improve parsing of some long options
>   git-submodule.sh: improve parsing of short options
>   git-submodule.sh: get rid of isnumber
>   git-submodule.sh: get rid of unused variable
>   git-submodule.sh: add some comments
>   git-submodule.sh: improve variables readability
>   git-submodule.sh: rename some variables
>
>  git-submodule.sh | 214 +++++++++++++++++++++++------------------------
>  1 file changed, 104 insertions(+), 110 deletions(-)
