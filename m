Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406A17081F
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 07:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731481996; cv=none; b=dUZIr5v5UdoY8dgH6tgnDXLyOJJs0VVguYIEYgD6dy4DikeaSl0vz7x3wrpXNoFR96glGSs7XPZWdxSF11shqtUYQq/IoSdPMSwSLzRFMjKRbj3VOkPp3OjyD1i9XBa6BkNee7T8L1lOy+1pf60Qg0iICcOCqiitiBWcDynORgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731481996; c=relaxed/simple;
	bh=MAtuCE1XGvuYGFTQJ7B8Um/DyU4NWioiLb+jw9z3Wx4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pJmh68zI8Xym+b6PcsEi3yAr8f2PRqva3Y0yOnJvCo3Y06vzZdGDWu1ZJzMhpDjiAKOZasWMw9Y8j4X0t1gBJn3VbZlBFLrI7op5X+4aK+RfQ6FU7jQv7nA/ARa8QbTjgPWdqiYnvuRJbe0o4LJAGtesRZWGXPwqKiSot8gVnMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=luAYACOQ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="luAYACOQ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 3DA8713800DC;
	Wed, 13 Nov 2024 02:13:13 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 13 Nov 2024 02:13:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731481993; x=1731568393; bh=xLyhBXygtCJxwgCK93mOQAowWbmNcnJc5VV
	rrw7nGVk=; b=luAYACOQbF9pJ6SB1e1XkPy4N0Z7b8QOooal3Ba4jEM2Madq0LM
	9ZZdT5G9L86SD2769eq/NxdXVGbHEdVbVT7LzbvAX3ka4+x02jF7trPrSHGCssEx
	y4M0M8gqpjCORYGe3YN1a/W5/gUvpJhhiPl+jFYfmM0WugC8MizEjtYFlwFJBlVs
	gxKyfysYPhLeRZJk6efpiCiXdFnhxA5RbOHzDhp1HFPQOBSdcHEMYJk9OV3/fyFj
	NqQahlCBkw8/ftKvLV+lgE72WxoyOCfV3sWCBEzPgxF1BJxH9lcyICzewXmcPI+T
	fv/8EnyZfAl9SHZnDO3mnj0scYLsc5esD1g==
X-ME-Sender: <xms:iFE0Z9_L49Bufey2YtdUFR-Xf9djmbxEKXZ85Bk-Zj-uK2rCjkmv8Q>
    <xme:iFE0ZxtEsjUynhKYY8IrJqhjOiSLHjgnLqpSJvuGUQpiOn-vZ__xs1V_-fM7iE7zZ
    z8-unGnY-GhLafABw>
X-ME-Received: <xmr:iFE0Z7CZWzAwrikywga90h54YhWOclOA3K3Syv2-TvMjCG4yEJxdze0X2MsG8YW9KnVKRUKU9qYlnQumSzUMeMo6E8UK9LGtXLx3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudelgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohho
    ugduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhi
    hjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:iFE0Zxf8N3bPHcsYghX9Z4WaWv8JlwcLDNA8ldJyKS982zXyy5eO4A>
    <xmx:iFE0ZyPEyjU0P78zhT8TXdU9xzY4RMm3hOMQSDJXlDn7kCyGey5_cA>
    <xmx:iFE0ZzmRt74gWLwu0QwVF-crRIr8bA0FLhPq_CcE6gvA2hOF8YGemg>
    <xmx:iFE0Z8ucy-GN4YXpLC48SNvcewRU-q7Pc8yDL3FcJgDT6Syq5_E8dQ>
    <xmx:iVE0ZzGlRs4WKzL06k9KwM8xSLUhSUxI5HGRc51ROjBkugKMDBb7Zq4L>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 02:13:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eli Schwartz <eschwartz@gentoo.org>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Ramsay Jones <ramsay@ramsayjones.plus.com>,
  Taylor Blau <me@ttaylorr.com>,  David Aguilar <davvid@gmail.com>,  Jeff
 King <peff@peff.net>
Subject: Re: [PATCH RFC v6 01/19] Makefile: use common template for
 GIT-BUILD-OPTIONS
In-Reply-To: <20241112-pks-meson-v6-1-648b30996827@pks.im> (Patrick
	Steinhardt's message of "Tue, 12 Nov 2024 18:02:44 +0100")
References: <20241112-pks-meson-v6-0-648b30996827@pks.im>
	<20241112-pks-meson-v6-1-648b30996827@pks.im>
Date: Wed, 13 Nov 2024 16:13:11 +0900
Message-ID: <xmqqbjyj1u9k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Note that this change requires us to move around the setup of
> TEST_OUTPUT_DIRECTORY in "test-lib.sh" such that it comes after sourcing
> the "GIT-BUILD-OPTIONS" file. This is the only instance I could find
> where we rely on ordering on variables.

Doesn't this change break those who use the TEST_OUTPUT_DIRECTORY
environment variable as a mechanism to override where the ouput is
sent?  E.g.,

    $ cd t && TEST_OUTPUT_DIRECTORY=/else/where sh t1000-read-tree-m-3way.sh

They do not necessarily want their output directory affected by the
value that was in TEST_OUTPUT_DIRECTORY when $(MAKE) was run the
last time.

...
> -if test -z "$TEST_OUTPUT_DIRECTORY"
> -then
> -	# Similarly, override this to store the test-results subdir
> -	# elsewhere
> -	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
> -fi
>  GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"
>  if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
>  then
> @@ -100,6 +94,13 @@ fi
>  . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
>  export PERL_PATH SHELL_PATH
>  
> +if test -z "$TEST_OUTPUT_DIRECTORY"
> +then
> +	# Similarly, override this to store the test-results subdir
> +	# elsewhere
> +	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
> +fi
