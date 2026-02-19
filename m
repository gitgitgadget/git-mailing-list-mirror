Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA512FD689
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771530614; cv=none; b=OjFDruectQsYB1kwqhAyLxIjsdfgLmXgC4Hwr8Jgv4cucT3vMgVtXkUJIIfQeJ6xpe6Ry9Scy5h1woyS9tBHajI0gyshWJUVXNMUO18YFg9r6TBaP6LbqJbN8jW+hhojInLUvaNkR/qn6Vab70J1RNii26fm7BzkR6ludfbCWtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771530614; c=relaxed/simple;
	bh=kUU4FePNMgftl6tAmgR6Yp+91sukHIgvY2CpXAcq9js=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p9svjaYxvpzE+npDBvuhDZEii2Kyc+I2qmMEhj0QG8DPFhtiZzCytif/JtE8xBKeik1aWbsfGsdHXzmW6PMyqpx20xEcX0ASSOP2wT2oqtWgIJ1RcgEBFMJoAKAT1IMsD3900OG5waFQyGBXR3JIFo/RUsolE6FzlNL3wXwrSF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AUko+rEA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kZO2cYNp; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AUko+rEA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kZO2cYNp"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 618C91400166;
	Thu, 19 Feb 2026 14:50:12 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 19 Feb 2026 14:50:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771530612; x=1771617012; bh=6pgB/BaIEz
	/uuTxo1dh98UamcgJQPILlQFjFh/Pmwd8=; b=AUko+rEA7ld+eofdh3ytwT6qA1
	KozebNqVqnF7/jtKGtweJvlFcvVtGEATJko2gtLlX1IuqJde9mKjrWi4HOgEqmGJ
	Q6P9D9AASB21KaUPml/UnJCey1/ZKzSp0e+WHMeFG+yEuhwg1XLiLTdGNLE8rZP/
	u21ImT/2zZ+GXS4p/6lLhcm2HJVYegEegORFqm07StHcRYqmte5y0xZ6j+nDLd+3
	7995NvmlNJv3KqWrZW0CEQ31f/1Zt2nicKKA1k3cIgp178ArOLJV3N0JJijGbuUq
	2Qe2FrgPyIwXTAEAwPW1BvYdbpLl+l+5FZ2Bvei91VjXGKFJX5cEfM92tumg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771530612; x=1771617012; bh=6pgB/BaIEz/uuTxo1dh98UamcgJQPILlQFj
	Fh/Pmwd8=; b=kZO2cYNpJYZt6N5ffk5xG/My1OgPqpbNDhfeyJWkdpR+OZ/Pi+W
	kv2u06g3ShoKJ39RX4Kz8WCcPS128C9Jlm6+0us3Ea7xDDh1LZ+hROgPXvVh/vJ6
	H5PLSyPEhCJpNyAUbDmth40W/UpsZfNXXAScPdRHmPqgkq3eNczh65xVJZ9fjbHi
	QCgTSjN667F69qWCoVmCCqiSyhl6mU2cHAMTBUNuLftLQdKkcWzwqkrTYzdzwNhg
	i5Hq8pNezeUF6Axxf7JQwEUIJcX963Ppken67EacCoJEAdTnIVP9Pd/iL+LnPg/a
	yDEhPPrqLB9e4OLRg0HO3VZUrBhDgEUE34Q==
X-ME-Sender: <xms:dGmXaemDK2XDp4gMYaAXgpg2pJ-dfJlVGGaL5sE6EnbLdig62Lnmaw>
    <xme:dGmXac1ABTgfR9ulO7zLrp8dTbUVpDcwIRElJFr3DC0adl_9YpOzN3WZWzShVg84U
    nVHjj19LeeYlRtfsY91dNeM_JvVBZCoXcF4mg9-L_vbWedZdgMcIog>
X-ME-Received: <xmr:dGmXaRrTWoP8CXYe6VO0HgVxWgQk3yhcU0fB7GjtXLsMApQmVOxeg4iQl-8bURcj5zgG7kuJhJeR7FR__4tuBkl_7NnVgfblrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeigeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuggvvhgvshhhihhguhhrghgrohhnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehvugihvgesghhithhhuhgsrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:dGmXaRdMbYhh9MDtOWUF4tzmMfzfN5ASZeyh6NJwRUwgih2SkVx_2w>
    <xmx:dGmXaYpFWw1yEJhBfypeMk7UZOEk9ZNmAZN61I1-4Bf5U-7rieFQTg>
    <xmx:dGmXaaHlJMafdEEdFvYq0BW5zRRGM7cv6Qg4SXoY4rXEEvqOF6HQ3A>
    <xmx:dGmXaQt_W1oScIp6Hm-okOoJzsaazU71hKUQcAD5xj-OzgUnUoCFjg>
    <xmx:dGmXacIp8pzkQbX-j5SsINhoie3t2b5r7i6Tv6d-tjfTsQdvs-FK1Gf1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 14:50:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Cc: git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] t1006: fix %(rest) test for object names with whitespace
In-Reply-To: <20260219152407.12160-1-deveshigurgaon@gmail.com> (Deveshi
	Dwivedi's message of "Thu, 19 Feb 2026 15:24:07 +0000")
References: <20260219152407.12160-1-deveshigurgaon@gmail.com>
Date: Thu, 19 Feb 2026 11:50:10 -0800
Message-ID: <xmqqikbs4iod.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Deveshi Dwivedi <deveshigurgaon@gmail.com> writes:

> The '--batch-check with %(rest)' test in run_tests() used
> $object_name directly as input to git cat-file. When the
> object name contained whitespace (e.g., "HEAD:path with spaces"),
> this led to ambiguity between the object name and the %(rest)
> placeholder.
>
> As a result, git cat-file could not reliably determine where
> the object name ended and %(rest) began.
>
> Fix this by using the resolved object ID (OID) instead of the
> raw object name as input. OIDs are hexadecimal strings and
> never contain whitespace, making the split unambiguous. This
> also removes the need for the existing FIXME comment and the
> test_expect_failure workaround.
>
> Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>
> ---
>  t/t1006-cat-file.sh | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)

I am not sure if this particular FIXME has much value, but ...

> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 0eee3bb878..cac88acf65 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -194,18 +194,11 @@ $content"
>  	test_cmp expect actual
>      '
>  
> -    # FIXME: %(rest) is incompatible with object names that include whitespace,
> -    # e.g. HEAD:path/to/a/file with spaces. Use the resolved OID as input to
> -    # test this instead of the raw object name.
> -    if echo "$object_name" | grep -q " "; then
> -	test_rest=test_expect_failure
> -    else
> -	test_rest=test_expect_success
> -    fi
> -
> -    $test_rest '--batch-check with %(rest)' '
> +    # Use the resolved OID so %(rest) parsing is independent of whitespace
> +    # in object names (e.g. HEAD:path with spaces).
> +    test_expect_success '--batch-check with %(rest)' '
>  	echo "$type this is some extra content" >expect &&
> -	echo "$object_name    this is some extra content" |
> +	echo "$oid    this is some extra content" |

... I somehow doubt that this is what 9fd38038 (t1006: update
'run_tests' to test generic object specifiers, 2025-06-02) meant by
that comment.

I would have understood if the fix were more like

	test_expect_success '--batch-check with %(rest)' '
                case "$object_name" in
                ?*" "?* | ?*"       "?*) # has space or tab
                        token_to_test=$oid
                        ;;
                *)
                        token_to_test=$object_name
                        ;;
                esac &&
                echo "$type this is some extra content" >expect &&
		echo "$token_to_test this is some extra content" |
		git cat-file --batch-check="%(objecttype) %(rest) >actual &&
		test_cmp expect actual
	'

i.e., when testing the object with non-problemtic name, use that
name, but otherwise, use the resolved name to avoid breakage.  That
is because the whole point of 9fd38038, as I understand it from the
earlier part of the change (see "git show 9fd38038") was to test the
use of name as much as possible.

>  		git cat-file --batch-check="%(objecttype) %(rest)" >actual &&
>  	test_cmp expect actual
>      '
