Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B3837E2FF
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 21:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775598837; cv=none; b=DjDkvnf+t2n7pcaIYcbPPZ6g6lnZz8quFDPOl7T9jWEQcUKyogIR3U27s8kVnpO1Pe8zzWFbQ7HPHUfPYa1bQlmjfVy2h/dHVo0qEIA7U6kJV1gkgNqHp8jnMk2MJo6cxUPDW4tnTWAgvIrYwUX/7ebjLg2pmWoGvuefTCHZwao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775598837; c=relaxed/simple;
	bh=XHPmaUotBiyNtSlE9iiCrjUXxh+k2UgAz8ZLieOhyD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dFxtXlr9rLLVlHTYHvw+itpS9nYlSxPVigP+hw3SZeDRgQmka3KF/ug32+B+lIZp0hfhNYDmi4wbrhQI8LrbFPGryx8LBMdwUAVb4eJ3q3Gx5kdluOS9L7ToUt2UUtrLJ0tlNrxyjCvqmXgCgWCJVmHkVm2ih4fsSRRElmSCNSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uBEjblE2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uGoSbvbW; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uBEjblE2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uGoSbvbW"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 00441EC03F4;
	Tue,  7 Apr 2026 17:53:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 07 Apr 2026 17:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775598835; x=1775685235; bh=6wDvx/ua9/
	0BY1a6SpEnRxpuF5ulutVPIZhZKDuzQMY=; b=uBEjblE27tJvGShOSRREZP6L0D
	9jKJu/HhGiJWsKQv5rzdP9Zeq5nU907hK5tRR40Iwd+BfgC5VvHRKLB8EHJpz6MG
	ACfEHiwWbtF+1dGA3/hf1H/hquqBEBh4kvql4jpw0iq9+ng0J/SLTZGYChgdyiSO
	RnbKRyfPntnz6sibIlqKjLkOI/7YWsZq7zGosfnOF8cbIN8USxVB7jzmVXZDaTvu
	WpX5ymQlZz6D8YN+OUMEyPm53okFa2ejVLLJ74qASlVxGG2geJp74Xba1+9p3e/6
	t3RhqX7a3yk8CbHc6PxaUb1rbzkka8ItsKYIYKNjTmQSPAa4GRw9Nbhpvg1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775598835; x=1775685235; bh=6wDvx/ua9/0BY1a6SpEnRxpuF5ulutVPIZh
	ZKDuzQMY=; b=uGoSbvbWkxUjYMbAYK0Bte2pYJLftnTQle4GaKD6Z0IZgMX65mN
	Z3myo3KneSQUr3or9rr+lfCSdr6QkcwtQynM1vQmYKMTJxPSUFSjLPc3dD51t0cu
	MNtYXx7du/Ab1ro9NJL68rMTN7IKtYX6DYQYS/izdqEglZWyUguWDCv+g1mF27MS
	BYAbpX1+nj0lahqn9lsRIBdh26YIO2azWeAaCU6djCnV1yGGFLAXrVJi4JYcPJ7a
	wbZ6B3uXwDLGbiFZ5vjou1iE1YizD9wAm+LJfJcjg59tAQQnCEC3rbOcCDkwbV9Q
	r1vHsHRJ3mdBtoXdlk5BaoCf1CT/W13O8Lw==
X-ME-Sender: <xms:83zVaTlXAx6DE0wAvTpwwwXXDIX0PldhabjENIokYfT_eHa63MRS8g>
    <xme:83zVafSzGOeQJtp5DiQnfRXyPEBFYj61kKBw7K58VDbcPzuQeNz1BHEInXsTXn8fm
    9hAEHadq1JF_ryo1N5QzahQQKtMuDyjH4uSZmFrz2rPnJii9m5aRA>
X-ME-Received: <xmr:83zVaaFGD_iL6o_ga9d1yavarCJmfs9b0WDm3t49aRjxF9fbO9CeeOFskxJthu8CJd7gGNPOKXvWWjjXtgqJIPXU0pSjk8sPeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvudektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheplh
    hutggrrdhsthgvfhgrnhhirdhgvgdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:83zVacGH13i23z3lBxh9gW7Gn8B5S-oPTy-FXRxI4ZgBhwFfgpsguA>
    <xmx:83zVaQRS2Coq5Va_cgkTzJSfVdLMPHYWTKt4KoY1rCqf6AM2cLZZXA>
    <xmx:83zVaVL6grm76ZzOtTDTfD-RbEAR0QgeV43HGNavKGhEV8m7Iq-ygA>
    <xmx:83zVaTZFEIhCgpTt0yqwcBh_2yFajA4rermI6Q9FwW-_ZbD9isHQHg>
    <xmx:83zVadBePBCK0RVX5MEdWOdLGuaXKALuieqH77mL0Bb9-GeXhnVBvVDg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 17:53:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  peff@peff.net,
  luca.stefani.ge1@gmail.com
Subject: Re: [PATCH] object-file: avoid ODB transaction when not writing
 objects
In-Reply-To: <xmqqo6ju31wx.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	07 Apr 2026 14:18:06 -0700")
References: <20260407201730.2526914-1-jltobler@gmail.com>
	<xmqqo6ju31wx.fsf@gitster.g>
Date: Tue, 07 Apr 2026 14:53:54 -0700
Message-ID: <xmqqfr563099.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> I'd appreciate it if you can give your eyeballs to the attached to
> see if that is how you would fixed the bug in the original context
> of v2.52 track.  If everything looks OK, then there is no need to
> spend time backporting on your side.  We have everything necessary.

Another thing.  Your jt/odb-transaction-write topic (in 'seen')
already addresses this issue, so we may merge this single patch down
to 'next' and 'master' first, but the merge that brings in the topic
can just supersede this patch, perhaps keeping the test added to
t1517.

Do I understand correctly?  The t1517 part of the patch, when
applied to 'seen', does indicate that the problem is not there.


