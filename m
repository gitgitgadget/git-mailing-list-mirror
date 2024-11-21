Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60521DC05D
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 23:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732230675; cv=none; b=SM6OfCYdZjYgobx4fyYcMZQZkEjB3mejjbHsTPdEsYjKucDdldTE1f+r+9ttAQFsKjvYOcIj7a2khtAyhnnNROHYdKC6jqEsTJE54m7Ud+t7eIFIvRtxI/RprBdlBbnlOWYfRna+oCw4DeIH1GLyPSkaietfdUTI6+tICgieUgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732230675; c=relaxed/simple;
	bh=OYWaA0mAH537DQUTqTnDSKoGmrrZK3tw1KpWVu+DrJY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=goLrJV1pVC6UtByqgKR3yDf9ACXJoUrPf84VSrtX60sxbyWpyn/DdulUs8aPIU1soqdqHgxYAQqTRY+nYYJlcaYHR4DedG5Lm3qlOwc+bn7vm22jVGuX49ZmZT14J8ZqdDPDScG2PLJPsQaFUOmWtwGOolsmIIH+eV4c0yNPJrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aOj+rVLJ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aOj+rVLJ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 02F04254008B;
	Thu, 21 Nov 2024 18:11:11 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 21 Nov 2024 18:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732230671; x=1732317071; bh=Mk1jrpKmtSsE+YeyErW1MLoU5jL58FBR+3N
	YmRFIVcg=; b=aOj+rVLJn6+RVDGGl6cu/gMY8hteIBN9tsLOjgtgOVQgdYH0M4o
	XPWObOaiUvQ1Asmm/7pBtbSFxvPR0K/DNEB/UZUBfQbPwByOtxZZelOkKZ0NiY8j
	qgwWo3s7K2nLl8LM1rmKxmQnB3HGC6d1qcenXwwkiF1ozyvRvA5kCf1sNl1RsDPH
	q+zYxW7YdmMWEcAtvLLFIaS/qPK5BYTf2s9KfMhPqXg7udeUGO7tAxsr3xmNtsaX
	I5o6al4doNfw/bGk1lBK57ARlrlvlG0ZCYyZ92TrdzccXSIcDz4e2OCt8v6mKc69
	iNoaZ0TC8/Q8488iHFqZetq32/q54jT7s6Q==
X-ME-Sender: <xms:D74_Z3BqioT2ufRNby0CIsGBXbZi_NnwJ4dcPu16y3Tb-5wzE863eQ>
    <xme:D74_Z9gNxlFvXaie39uaLcU71IEvqiBQa77P5FeKpKI4XvJ0aLLYWRzJv9522baYm
    1epFuspJf2YgK6Ezg>
X-ME-Received: <xmr:D74_ZylNRMxj_qAVTCdV8PI3Woxc_kXz7NbshKgl662hxmaIA5AU8AUw1TN8wFVX-o08iFB58PidCI42Et-51NXIdfPd0rDBaZc->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeejgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:D74_Z5wcF0shCCL0eN1vvV_8siYpmuSrwIWwW0lanHqR-svRizWztQ>
    <xmx:D74_Z8Qan6CO8HFiNLsL-xBZSsuUnu7P9qjS-ykF0C_Dniwn4Dzxtg>
    <xmx:D74_Z8YZYXsj-1QiA2oTXNm5iH43vtHRp1LQjtJ3PSUhC1pFtVImrA>
    <xmx:D74_Z9Rupa6R20ciQJZNuz9tZhotkBSsxMjsWlE6U33tkFjWV8n2fg>
    <xmx:D74_ZyeyzM-a5g3Vvoo2G7FEaxMD9J4B0E92CkLIRRm4PSF6pdYAD-mI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Nov 2024 18:11:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2024, #07; Wed, 20)
In-Reply-To: <10282b43-4b1c-4e8d-a2cd-2aa725622e90@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 21 Nov 2024 16:31:48 +0100")
References: <xmqqo72ai929.fsf@gitster.g>
	<a340dfc9-bc3a-40d2-a8ec-fc47c00d1305@app.fastmail.com>
	<xmqq5xogg2to.fsf@gitster.g>
	<10282b43-4b1c-4e8d-a2cd-2aa725622e90@app.fastmail.com>
Date: Fri, 22 Nov 2024 08:11:09 +0900
Message-ID: <xmqqy11cdvxu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> The patch got an Ack from Christian.[1] The patch submitter is supposed to add
> trailers like `Acked-by` in subsequent versions according to SubmittingPatches.
> But this one went straight from proposal to `next` as far as I could see.

Straight is a relative term.

You could have said "ah, thanks for an ack, here is a resend" before
I queued, provided if Christian sent his ack quicly enough.  Or if
Christian ack'ed before I queued the patch (and provided if I saw
it), I may have added it while queuing.  But the thing is, people
work in parallel and in different timezones, especially for a
trivially correct and good patch, things may not move sufficiently
slowly to allow that to happen.  And it obviously is a good thing to
allow trivially correct and good changes faster to 'next' with least
amount of bureaucracy ;-)

So I wouldn't worry much about missing Ack here or there, especially
for something that is simple and non-controversial.

One thing you can do to stop the train is to send a note saying "oh,
please hold and do not merge this to 'next' yet, since I have second
thoughts", before the merge happens, but you obviously have the same
problem that the world around you are also moving ;-).

Thanks.
