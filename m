Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C9B317163
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775582880; cv=none; b=WOWandn1nmBgdwffcAoh5B74Rqj8+zRby8GhziU1k9BqrXCol9LdAVkAUzTCFMaQPbkLCvEMfVNpX8XoGMXj0avf4Ty3sRijuuj6izxOuzyeqepaXJYqokVYC5zzekF14RCUzClG5qCNIaUgRsdoMjIRewiBtMj4bjSaAOg6IbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775582880; c=relaxed/simple;
	bh=VyR4oeO5uSqKUPGpKP873dfXT3FGUbKapy0K1+fPsaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qTnc7NYOtpfYiPMHSdQTpiZ0xcjIm8I6keOFzHRF1ab4e560A6PPoblw8aAcfmlM4Ep4Jb8WavzJi/sWSMFRrWQ7DCeDP+ovX3ShxSN2Jb4ofBakMsWy1sqCI1a9dAaH8kk5h93eRZzhePoEYFZ5WsaS+H++R9nE6qblq73I/k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=agjkzwFb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WYpOH11S; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="agjkzwFb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WYpOH11S"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6D90414002E9;
	Tue,  7 Apr 2026 13:27:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 07 Apr 2026 13:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775582878; x=1775669278; bh=4Rg+j9AE7P
	TLEqef+HOqMdYCfcsGoFmWmqfBkD0+bYw=; b=agjkzwFbhpklFR2SmsAj/RfGmX
	nV3RDNyI9oUDvHtS0pkQHD0BWsFKckhxWOa5bjUZqfwO7K6V1MZmTTF8mRcYMgkI
	cIdloQ34wTee4ia68dxSNRh27m9VCb4LS79Opwfm4NQaAr1QWbkBLsP3pNlq+Mg+
	5N5O9ROTInLxbeIQCVwR1PY4GBVC+8/FDmRQn3ybnwgj3LMWyL7m+SR7TrMLpRyg
	dFnCA+IwuPWTlh7CezwioxDoIsTqTbsd0GFigtnlKERBAgNdvNmcc+eHax7B6uPU
	KGfHl+U7D0+5hjgwtHBd9AyLnynJKhKU7LPdOTrllKATqA/xgCJqLiUWk5HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775582878; x=1775669278; bh=4Rg+j9AE7PTLEqef+HOqMdYCfcsGoFmWmqf
	BkD0+bYw=; b=WYpOH11SHl92aKr3NHfjE2f1Y7nVsCNpJJjK44SLPdnV2TdGp1h
	SJ7mOdb5g3W2HKIInnak5hVTFUJZDrLPce6RQsZue9ujBxSKrgUZHzF1O925mBnz
	iqV1z3iMzDJn8s9CPhrd5WvtMMsWGY5bpKtutYRAwujpCfQDQP6UGH4JbDtncF/7
	1NXHksyTnrj1l4/N5ql73yBmZyxJzLpPpiThwNHZxIYO7m7GN9AO9jgnS4L5+YCV
	MoMlXhHEWNCyOQYsf2OXMO78343ScIxVfWaMZ4RpWwbN3b5fVCjkoemnM6ijA5l9
	XloMZ2UfGeVlOxyJMMpUOI8wciDgdsPalHw==
X-ME-Sender: <xms:nj7VaSyyRdVtJNdkt86WGEZtr8fkMf6D7XgqHQBJy-A72azUAoT8nQ>
    <xme:nj7VadVfuWMkr7Z9_MiFD8r82rvylNnjvReWlb-Dvu11ZrqZwjxtOL7E18FQILlSR
    jBr-9VZxzCZeUKuPkvrd3M8GzmeUBooCM5V2_qclLMkrM2-PRkeng>
X-ME-Received: <xmr:nj7Vaajp76O17fE-PQo4AueIaVPMQjBQRNNdeAis-lqUtRPwI5BvluIKGYTQAbl0N9l2hIAHauPmu1ctv1F-mpcLBTgpbIXXlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvuddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstghooh
    hlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:nj7VaVCK3OStnItDRN9C0gt4FfQWJ3MwcnPtWaY44_NkixJlTYZONg>
    <xmx:nj7VaYtSKaBecWoWQ_gR9teBnYOC-NQRklyr62QToFAGhRDTQU5Lfw>
    <xmx:nj7VaRcFndQmlVB-14SdK9S4W2nqgQgsl8erhUw8wyXJFg6PpFuP4g>
    <xmx:nj7VaV8lZb-z_yE9FTEGOt1eEn8V0j7fB3L_qsOmlCfDhXg-Pnu9Hg>
    <xmx:nj7VaaTRrX6R2hWWSDiGU_S-D96NSVOiWMg7_MUEUBMEZRo5QAg90sg7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 13:27:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Karthik Nayak <karthik.188@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 03/10] promisor-remote: clarify that a remote is ignored
In-Reply-To: <20260407115243.358642-4-christian.couder@gmail.com> (Christian
	Couder's message of "Tue, 7 Apr 2026 13:52:36 +0200")
References: <20260402070613.85934-1-christian.couder@gmail.com>
	<20260407115243.358642-1-christian.couder@gmail.com>
	<20260407115243.358642-4-christian.couder@gmail.com>
Date: Tue, 07 Apr 2026 10:27:56 -0700
Message-ID: <xmqqbjfu65pf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> In should_accept_remote() and parse_one_advertised_remote(), when a
> remote is ignored, we tell users why it is ignored in a warning, but we
> don't tell them that the remote is actually ignored.
>
> Let's clarify that, so users have a better idea of what's actually
> happening.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  promisor-remote.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

I agree that it makes sense to add the final disposition to the
message.  It would be even better to rephrase so that it, the most
important part of the message, comes first.  E.g.,

>
> diff --git a/promisor-remote.c b/promisor-remote.c
> index 6c935f855a..8e062ec160 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -670,15 +670,16 @@ static int should_accept_remote(enum accept_promisor accept,
>  		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
>  
>  	if (!remote_url || !*remote_url) {
> -		warning(_("no or empty URL advertised for remote '%s'"), remote_name);
> +		warning(_("no or empty URL advertised for remote '%s', "
> +			  "ignoring this remote"), remote_name);

I would find it easier to understand if it is phrased this way.

		warning(_("ignoring remote '%s' that advertises no usable URL"),
			remote_name);

i.e., conclusion first, the reason for the conclusion next.

Thanks.
