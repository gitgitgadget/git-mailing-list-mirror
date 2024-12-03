Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6276F8460
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 23:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733267363; cv=none; b=HI4/VpXY/UZlJhGy1fIFER284l6qPb+2U8+AFstuPzmXfu7AMNY4x9pYdSMXmfMIz+DVQ0pnQ4QvA77p2Q1xCYDokTdn/nNImdGUecxT/0RUMtPh503IedpneB4bA3eZWjmGIfrdq1sP/BJ2HdWLgj/ilGTgTP8p8eFAMEDF67s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733267363; c=relaxed/simple;
	bh=DQNuCXsF1Ite0MpbXWTsnrYonFUBzFvtXeiPtHKM74I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DovOU5HD4Zz2Im86OoThyhqIYb3CIjhEyu6oA/0h3UZwCeMUesxWKBarCCyis0OcgddPhMUF0Kkw0GkSgdeOoNqea6BawNinz7OJ8Cpabr1L8g6lR2KsqNtdLiTbD6QYRsK445SFSlz/67CGSdpmFgVwB//JJn8+C1FcMwuUMoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XdmbWOW6; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XdmbWOW6"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 666B11140106;
	Tue,  3 Dec 2024 18:09:20 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 03 Dec 2024 18:09:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733267360; x=1733353760; bh=HDUm6zBYg7Dq7G16jLma5TmDEjojqoP8WMw
	/e3v3O1c=; b=XdmbWOW6PuNVTRzoT8AzJ51Oz2qRbm3V/28lk9pn8mP6V5xBezy
	SE5qvaaUmqo7U+B5QgjsJrB1+kYlL47Iyuni7DKVluUZToWnjszPJmD/Xadp0ozN
	kne7jclQ3+/tqc+ng8JIILG6uxmk9cxlcV1G+WTLrGRyvrFxflM1B6XMG1+/QD3g
	HT7vnFrYABn6FhmjP8KghZohXgoTPN4dqAjs9ogbpoeVtyaBoxoRz8zc8/FdZLtR
	UxldQ8m/Hbe3iqUlhtRxYGT7q37aBXf6Wden/MUE4doeiPOoGIaPLZmI56oK06Wi
	mvF0LB9/rRmQBZWfMLiUgFeU0ATQqKuq/0Q==
X-ME-Sender: <xms:oI9PZ5_TMNI0Lgj__ySuXwJL5tV2vSFJepoLZAx0n4iyG8OHMBg-ag>
    <xme:oI9PZ9sQdZ2_5kZhPETbuMikVPJckGHM0srJFqIaug9_RiecP4cT7bAV9QFKGEZxT
    LFWcdqAgWIqwZHz_A>
X-ME-Received: <xmr:oI9PZ3BHQaOB9-tcFFPJP57KtZjb2NLQ-dHSaFB2j5u4n0j5ZPIaODfngD9kLrik5o6KPGqpjKz1zWaE57KZPfQSSXvwJTV_ahtksMo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeggddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:oI9PZ9d2HWlZrFW8ur8S2-K_qc7SrStUEfsfzw0d-kQtkP0BNJvJrQ>
    <xmx:oI9PZ-OHyHY8l5mhVVTQHLc0yJ5IQS-j3ablVY83CV0gJssPPjCcIA>
    <xmx:oI9PZ_lpol0Yso9rSOw5cxHRI-pWcJoPvU1TlDkLOjzdZ2FIRYavBQ>
    <xmx:oI9PZ4tmhtvUwhVW1KGRsdkv6_Icq7T7DWSLMcDu2QiST4jfLDpKXw>
    <xmx:oI9PZ13g0Q_wK4V_uWNMzkkvuUnCdUt5zmNmd1O8F4NrBGjQSI9JONu0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 18:09:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2024, #01; Tue, 3)
In-Reply-To: <Z07auxNCcysPovdo@pks.im> (Patrick Steinhardt's message of "Tue,
	3 Dec 2024 11:17:41 +0100")
References: <xmqqed2pcled.fsf@gitster.g> <Z07auxNCcysPovdo@pks.im>
Date: Wed, 04 Dec 2024 08:09:18 +0900
Message-ID: <xmqq34j4bbz5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> * ps/send-pack-unhide-error-in-atomic-push (2024-11-15) 6 commits
>>  - push: not send push-options to server with --dry-run
>>  - push: only ignore finish_connect() for dry-run mode
>>  - t5543: atomic push reports exit code failure
>>  - t5504: modernize test by moving heredocs into test bodies
>>  - push: fix the behavior of the Done message for porcelain
>>  - t5548: new test cases for push --porcelain and --dry-run
>> 
>>  "git push --atomic --porcelain" used to ignore failures from the
>>  other side, losing the error status from the child process, which
>>  has been corrected.
>> 
>>  Probably needs a redesign.
>>  cf. <Z0Q0wfSTk_cUXH0F@pks.im>
>>  source: <cover.1731603991.git.zhiyou.jx@alibaba-inc.com>
>
> I wonder whether we want to roll with the first version that I have sent
> instead of using v2 from Jiang.

That's a thought.  Let's go back to the series and take a look.

Thanks.
