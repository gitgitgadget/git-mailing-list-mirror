Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C3F288CA4
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740479; cv=none; b=uoIjIVNDKFRmYF3ypuVOTMo2SxE5w1G37kbsuoVU6gRg1AwMUnTM80YpQCyeIh2pdrT6cZtWkWveFKF+wI4vXK7zdI81b3fJ8nTf2qEJx0VYjfUd2vOW/OwTnPFG3dVsYc+rLgv0W2rrTRCChOf5BHX3+l5y3cNN0i9SLYIjLow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740479; c=relaxed/simple;
	bh=lbWq7uzdbxdXsGEZNCbTpBgA7UmX/BCCp021kp92KSM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fzf0Dg01PuydxJ14voOPOrlhNGkBLm79HhOAJqh4JojGRP2FZL9ASreiczfCscdvx7vImiJ9p2H1zbdi8YL+eZnUtDoKbz02LKv7bIhkT5Y4RZqWrVkKsa00w8Sv2jpP9E41QI1m2tLA1nKHw24XAVI+ds9+vHo16Afxp6nrDis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gurGwFge; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L5R/9zfO; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gurGwFge";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L5R/9zfO"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C1F2211401FF;
	Thu, 12 Jun 2025 11:01:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 12 Jun 2025 11:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749740474; x=1749826874; bh=VMTx5FcXd1
	0bDuJOBqmLze8tVE8+m7qixvOZhA7Hm/w=; b=gurGwFge0CFB7v8HelrnRGT2kT
	EA3uZStMO2v7HOiPvIEzVU509X+4lffktf7C8xjtQa5URt4PfXyQGB+S5/ICJQt/
	wE5OhgUKlCEM+klZVtBWRK6FyjLe07mkOwNIAACh6GnA0yFDHKOUWhqS+OvuONuz
	qJo8k9+yYMxlygprLZlPG6avpukF2vnJplbGejf2t0G4DqlEQLrJyXMgLRZ+FlkF
	baJCAFtPoUdk25L1VyOkDJhuR9Flvh26+SxwjijVlVOmLOwbU6mBogNCEBTD3Qyn
	B0UTkKDGVlXMi/EMzxDQGrHqxX4S+7OVNDM77+lfC1LIEP5igb+G+6fXDSvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749740474; x=1749826874; bh=VMTx5FcXd10bDuJOBqmLze8tVE8+m7qixvO
	ZhA7Hm/w=; b=L5R/9zfOyP3lWLGblzWXhK0JZ23zHNJbGPFP3lYHZ1gA7ioLntL
	YU87T4eypz/e0gc8HN+8MwhPYkYwOn/IenZjcwkeMftWNpo9kMwEKt6R+DxD1iJ9
	dV4/ny5SK4G6NX/QJsv0WB1WARM07yK0ZW0P8vMXUEl2Fi8CbC+aNoB+9n+mZLOj
	7IEIu4yNr2AwQcl0vr4RZYQNLlyyWeXFkya75Iiur+vKH/LYmk/+WPvwRnHBuAHD
	mAWRJqRoLjGNHcf37nZAjg9dOei85nRuXGt3cOsH7Dy5jvokfp1tQokBRt1Tv0Pm
	Z0i+uQBW/ihPeUUEql5T90dqwDOjMXy+UZg==
X-ME-Sender: <xms:uutKaI9JS7wnKJWMUuButLmPQbEU_WLxePrE1iQ1-rVvjrDBrTl1CQ>
    <xme:uutKaAvo7uno48N3kvbF8iAAdFk39RMsOh6Pv3w8zSFkeCqbqwN4GaxRWyynM-FWp
    NmXh6MzMyKjVIM9PA>
X-ME-Received: <xmr:uutKaOAGt6pwLZ-mS3Zc-QFw5BBKw3oV0-tQpwQl7T3qbw97K9aEq1wcZYTWVFcT-YNAhwn1AhSRX9jUcscjWs1OlZzxMBJ58wYc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduheefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhi
    rhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uutKaIeZfvtQ3yfi2t2fYBGl5iHGbelU7p5mQwtWrqYHymk_7onZ6g>
    <xmx:uutKaNNsjqkDbfBL_iuIbn9lPef_LZvpyxT3-ZY0eBFuYON1WDZu6Q>
    <xmx:uutKaCmE1PQjYkQ2niSYYvhdOXATKIWDffvsJH59isdiUAJ4msZXJA>
    <xmx:uutKaPusogNNnzA0E-PPbL7sCfHFC2zfgnC0VnSr-i1DmYEGw0RNbA>
    <xmx:uutKaA-VWkh5r4bFxmuI8gESSALpLwbRRRL6mgkjluknTmN4hN9Dd5XH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jun 2025 11:01:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,  git@vger.kernel.org,
  ps@pks.im
Subject: Re: [GSoC RFC PATCH 3/5] repo-info: add the field references.format
In-Reply-To: <CAOLa=ZTNpSKoFcfQHDOQNhq-jdFJvGEsXm-rYKrHCZG8CfaqaQ@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 11 Jun 2025 07:59:32 -0500")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250610152117.14826-4-lucasseikioshiro@gmail.com>
	<CAOLa=ZTNpSKoFcfQHDOQNhq-jdFJvGEsXm-rYKrHCZG8CfaqaQ@mail.gmail.com>
Date: Thu, 12 Jun 2025 08:01:11 -0700
Message-ID: <xmqqecvpf1hk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>>  static void repo_info_init(struct repo_info *repo_info,
>>  			   struct repository *repo,
>>  			   char *format,
>> -			   int allow_empty UNUSED,
>> -			   int argc UNUSED,
>> -			   const char **argv UNUSED
>> +			   int allow_empty,
>> +			   int argc,
>> +			   const char **argv
>>  			   ) {
>>
>
> Nit: we wrap to 80 chars generally, so you can put multiple arguments on
> the same line.

Good point.  It is worth pointing out that we also group related
arguments together, and make it easier to later add new things at
the end and still keep related things together, e.g.,

static void repo_info_init(struct repo_info *repo_info,
			   struct repository *repo,
                           int argc, const char **argv,
			   const char *format,
			   int allow_empty)
{

Obviously argc, argv belong to each other, so it is OK to have on
the same line, and unlike repo_info (i.e. the out argument), repo
(i.e. the primary thing that is inspected), format and allow_empty
are something you would want to later extend when you "enrich" the
interface and functionality.  You may even gain "int display_width"
argument to allow line-wrapped output, for example, and you would
have to insert in the middle if you want to keep related things
together, if you had (argc, argv) at the end. 

Also note that {opening and closing braces} around the function body
sits on their own lines.

Why is "format" a string?  Shouldn't the caller do all the argument
parsing and pass an enum or something to this function?  After all,
I presume that allow_empty is set in response to "--allow-empty" or
something that the user gave to the command, and that parsing is done
by the caller before it calls this function, no?  Why not do the
same for the output format?

I'll stop here for now.
