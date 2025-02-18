Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231CC26A089
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 17:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739900991; cv=none; b=N1cCR6HH+N7IyyWVZ6sYvBSv9f6WPup0C+xwTxcFBY6m84xQ1OjAGFN2LwYSUMUCLM+cVMBkwQY/md2zzOY+8P1kqSOm15o0hf1jDpDTURFfBKrPls5NuiqV49urzbtYCE98pnx/ZWmyMuG5fyTe1Xdwr3NBQUgruMkW68TZ9hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739900991; c=relaxed/simple;
	bh=I48vQCrFkomhVRMQvyt8cpcgjdlR1opMSO2Tgj3Ldu4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DOparwvX4sKSY2A+RX8nvXxLyg9ZrjCOtD4JQOpAXyVrUF12bQi5tuZJMDk+YlDbygdp4b8f7MNzvyLDiopd+RhkUjpviDPrDtIvB2f9xTsVew6jp6QlzUnTkGOR0KxoqnOZ4KFh3nMfPZlizcPUhCOq7mikhNkRrSzkXCnqc6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PwZ+ujyc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vkU6Xgf1; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PwZ+ujyc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vkU6Xgf1"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 16C99114017A;
	Tue, 18 Feb 2025 12:49:48 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 18 Feb 2025 12:49:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739900988; x=1739987388; bh=ptY7dqQNN9
	Gv8wvtC/NXn4ihtf36qUEdszrFqhXKsUY=; b=PwZ+ujycxCjsTmfUHle+ZGkgyS
	ac2d8ZPsbwX07hmV1Pe33cis3IZuNS42r5Y4sqZeRyzX1sz6taaIzhxPUZsK9dsP
	qqKSRRx1QGIenpT6helV1k4LYEy57ul2UmJoW3hfLFDA7STlk8qH7kkteKwjyPlf
	oKn23V3c3LQq8UXlFrQa/HaIjUo8V0G5g8IUGRhP/9tO6+6+xsoeIHaKY+7qlzs7
	CtIVKDgCz/1970z/z9wdWaelgbRr3nCgetEavLuF4oIPSmN68qKGaox829qwB6Ds
	68Pf3Pd6FFS0bCjm2OFSKkqcqnQiXwqj/lcofHmtu0y9j3wzrHncFveazxSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739900988; x=1739987388; bh=ptY7dqQNN9Gv8wvtC/NXn4ihtf36qUEdszr
	FqhXKsUY=; b=vkU6Xgf14YP5/dQqDx+dBDcwugaJpeq+Uy9rHV3Olk3Nmg1Hhk2
	P6pSjIXDLFKVcVDupwr0xQhltPKeRLfxYIY8TNJzgJ+UYMZLbLJMhGr9EAFQQdGm
	yx62MR9KvsJs5BCREfNLFuMlgXJ9AGGoQT35J3COA/Id8QWsBCrfZtfSNd0BEjhA
	FGZRttMFlLFGycthoZ10xkmQKGlfflJ/KN7ZgZfUQW2ZXlTo5fzWpasJU0YQhfCA
	BxoeMjr1Ab2nWIi176E00I/cCxs3eYTZ2g1ZjtnPOiBPIPh4oCjj4aKtH7jYYQ+v
	o3KDivqU+E34R5yIz24XnDbYf2C/l7rvf9A==
X-ME-Sender: <xms:O8i0Z7cOSIb3iEhBHQ4neHL1tNeBjiarLPP_mJI50eWIqBXxeQ2BoA>
    <xme:O8i0ZxPKkHSPXnNTozoBzDxZZM33fM_YoYG4nPniAu1mGZVmyUbAHd09M9jquQKHS
    D-6ev0omo70K4IFYA>
X-ME-Received: <xmr:O8i0Z0h0F3JECeDSHGdvXjGYd4lvWvIS_lRl_y7T7LUz27AEh9f1IOpPiNO5gBeXxpU6lZb2bSrJ7YO00A2jHb3SYT0zUP_2dKpeCSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjvghllhihrdiihh
    grohdrgedvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfi
    hrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:O8i0Z8-euI3gH2L2WFPbZGpX0ruH-HwKmgMCRT48OC0yTzye42J99A>
    <xmx:O8i0Z3tcYVsLrkzIryI_3DtPDnwi89QdzDehtgaN5nWA77H9LoJi6Q>
    <xmx:O8i0Z7F-1c2rNfNY7xZQh1P9UB59Ofpkrpf_7F7WmUqut3efIT8vlQ>
    <xmx:O8i0Z-OIgy_GkqQlYiaCTUJKH3xB5Y2BT-w3kVcdS8tCvDUWXHA-cg>
    <xmx:PMi0Z9UGPiCMeMPJNVNRIhx7pUQGdGwkzqwCB3mS--ncWLTTB0mdANO6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 12:49:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Zejun Zhao <jelly.zhao.42@gmail.com>
Cc: ps@pks.im,  git@vger.kernel.org,  newren@gmail.com
Subject: Re: [GSOC][PATCH] apply: address -Wsign-comparison warnings
In-Reply-To: <20250216071202.61372-1-jelly.zhao.42@gmail.com> (Zejun Zhao's
	message of "Sun, 16 Feb 2025 07:12:02 +0000")
References: <Z62MTZXQD3Wa47Jz@pks.im>
	<20250216071202.61372-1-jelly.zhao.42@gmail.com>
Date: Tue, 18 Feb 2025 09:49:46 -0800
Message-ID: <xmqqpljfxhvp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zejun Zhao <jelly.zhao.42@gmail.com> writes:

> On Thu, Feb 13 2025 07:08:13 +0100, Patrick Steinhardt wrote,
>> > @@ -2706,7 +2707,7 @@ static int find_pos(struct apply_state *state,
>> >  {
>> >  	int i;
>> >  	unsigned long backwards, forwards, current;
>> > -	int backwards_lno, forwards_lno, current_lno;
>> > +	size_t backwards_lno, forwards_lno, current_lno;
>> >  
>> >  	/*
>> >  	 * When running with --allow-overlap, it is possible that a hunk is
>> 
>> These are a bit curious, as they store `line`, which is itself an `int`
>> parameter. As far as I understand, the only caller is also only ever
>> passing a positive integer here.
>
> They do store an `int` parameter, which is `line`. However, we cannot change 
> `line` to unsigned since it can temporarily store an negative value before 
> the assignments to these `*_lno` happen.

Correct.  Doesn't it mean that a change that makes these line-number
variables to size_t is wrong?  Of course the change is not made to
break the code but may be to please some code paths in other parts
of the system that wants these line-number variables that are
currently "int" to compare or assign without range-checking with
"size_t" quantity or variable, but then shouldn't we fix these
places, not the types of these line-number variables that use the
platform natural integers?

THanks.
