Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75E45672
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 00:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733876083; cv=none; b=rSrNNXHjpSdjRBoYkwJVwVTUbHs4zGyGvD0/CRMmlGYrsDhPgstQX4MtoKJ633Nnhu4bo57yTN3f2Ovqx8WpNAK0yE4/BHsqLpoE8GckfDkoogPfL9YRvvpm/mrYU0qrXX/2Zk8Ees7WOXdmIbF23tRgMwnp0yhywx1/CxwekEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733876083; c=relaxed/simple;
	bh=2ggnaREaVEt/HZ0xf+A4HHe+WeOpIAmXA3q+WnGsIUg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MhDKZUpXbjR5Hy7XYkovSvsTBznTYhjZ3whZXeqYI7pAu3DH1h6SyFamD3PT2o0wC9CBXtE4ArAck9Ow0KO9Vm83Ifz+HpvZ34D/Y7UKxS1OK/daJTSY+4vSfRRfTWBnn/gQllCMcQ3MqZht25R7Pe265j3ArY1/bAW6SbDMCjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k9xfpYiU; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k9xfpYiU"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id D07411383E9E;
	Tue, 10 Dec 2024 19:14:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 10 Dec 2024 19:14:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733876079; x=1733962479; bh=CdqmD2qfzn5Z1SAV4xta0lr/a/p6wx980y8
	54YyEWXo=; b=k9xfpYiUeatVzcIlqswnDvsTWOnp8gBrqKd8O78/UdGn0YL5SML
	gsZCaYCXldwg7/o3mKyxlwDgCglowxca87VBzgUa3a5FMYfldPT2X935h84BOy1e
	h2vmZbZ298TWfvwVzyGsgYnxIVp2Owlz74HjEpzoh0wotDtoP8Az3io+JqzilKUI
	bEScuhxVluKZ8zORd5nQzy8BM2hK615tVUOXn+jrZ3epT2WEv0DsFF9x9Wj49mT/
	rjVwFofgKtyh2rz/JCRIwN6SbCXMNZ3N0+0s4hABJNPLPWvoEL2WgGI9R3Il/TwI
	AljMbq62Ja7gPsvU0AUFC2U7BBkxY6zpNRQ==
X-ME-Sender: <xms:b9lYZ4cjeuti70_n1dh1xy6vmQHqOP97w1v_eiAxW8Y4Tt6w1HO-cg>
    <xme:b9lYZ6OGVhnmlS6bdUvLMgTE0UvIm30slOWP4Jha7c5cI6VjhvzpGyGFX3OctxjBf
    9i5TxyQNnFy42Q80A>
X-ME-Received: <xmr:b9lYZ5gdcvYwmbX8eVuJ8yU2VbSPcOY8V5l3vWGu6Vzg1SriUgN8Pd2NX9npl0cXy3TuLScoQKmRB_LJ2RRymLOnNM1XzkLDJfXnV2k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeelgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrohihvghluggrrhdtse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehjoh
    hhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehsuhhn
    shhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:b9lYZ9-VMNJls-l-X5CVumNFfZmhNxmxJVrRGXtfRzdn15HXUQiLPg>
    <xmx:b9lYZ0vuLe0TK1AiXplrNCS49rnZfMM5EyF7eKOqkEDLuHxVqGOTqA>
    <xmx:b9lYZ0F0sHj6Z69JN0mqyh8gBlv7y-zZTScoLPJxL-MoJuGlQ0Qk6Q>
    <xmx:b9lYZzN3HeiAUSzxBPwV6mAhChR4HsbW-fPXg3M85AEh4WjHrgAsgg>
    <xmx:b9lYZ4h44yKx5sOU0SX6On2PbWvEfDncpkd6CVtYIIrPiva8VtOB5AKX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Dec 2024 19:14:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Roy Eldar <royeldar0@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 6/7] git-submodule.sh: improve variables readability
In-Reply-To: <20241210184442.10723-7-royeldar0@gmail.com> (Roy Eldar's message
	of "Tue, 10 Dec 2024 20:44:41 +0200")
References: <20241209165009.40653-1-royeldar0@gmail.com>
	<20241210184442.10723-1-royeldar0@gmail.com>
	<20241210184442.10723-7-royeldar0@gmail.com>
Date: Wed, 11 Dec 2024 09:14:37 +0900
Message-ID: <xmqq8qsnjcsy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Roy Eldar <royeldar0@gmail.com> writes:

> +		-b* | --branch*)
> +			branch="$1"

Once another option like "--branches-only" will be caught by this
case arm.  Do not omit "=" in the pattern.

> @@ -142,14 +142,14 @@ cmd_add()
>  	fi
>  
>  	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper add \
> -		${quiet:+--quiet} \
> -		${force:+--force} \
> -		${progress:+"--progress"} \
> -		${branch:+--branch "$branch"} \
> -		${reference_path:+--reference "$reference_path"} \
> +		$quiet \
> +		$force \
> +		$progress \
> +		${branch:+"$branch"} \
> +		${reference:+"$reference"} \
>  		${ref_format:+"$ref_format"} \
> -		${dissociate:+--dissociate} \
> -		${custom_name:+--name "$custom_name"} \
> +		$dissociate \
> +		${custom_name:+"$custom_name"} \
>  		${depth:+"$depth"} \
>  		-- \
>  		"$@"

Looking good.
