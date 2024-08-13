Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4C83BBFB
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723532060; cv=none; b=MGPajo9WYP3UXr5mEB4VRfetK0e2DS04FhMQyOx0ZBuH0opnqTmogCYjvBvX+/YeYIhvU40Z6RhNqzQvWIzgstRICinO6qfXJqa3eHl5vD+gHny7BKrF97JXv9UkeNiY54ESN7uDp2+tV4iZ7qSQTkoPjzziIQMnr7XVhePdC90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723532060; c=relaxed/simple;
	bh=c6ofTcinPKoyWriOyG4nTwjF+aG5R6CzdBf9wHYMb40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6K5plD4VXJjrfutwp9Cy+uG0leBwIulf1h/cizia9Q9G6KQI+8ZGNqVoNy8gVkf9o0anReGdRqLfIECmumYvk9nnfNB1M4OX5QAz/HSKVo43nB1pt2aeApb/gX+6zVRu6vQNyIxCP9IQhbTNofrlEyNVWe2VRLCcDTDxMYlmI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JqMsGeM3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vDqJuFAV; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JqMsGeM3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vDqJuFAV"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 139BD1151BD9;
	Tue, 13 Aug 2024 02:54:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 13 Aug 2024 02:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723532056; x=1723618456; bh=VlchXIwsL1
	9lhpIKUiKflMZyp6evLsODoeDkoSPWSPU=; b=JqMsGeM3VjJ1hqxCMPWAIivI68
	9Sh0KlT36jh8mJI8pVzkgWMsRnRMeNicvvYrTviM+d1YdlG4cfmH/88lelDSU5Ih
	O118vonlXOZLIRx7gFfLz0n2XMyVRV2mjBzl8u7SzH6XsSdtuyA3IJkzQtU+i7o4
	7QDpTMva/XL3p8PaszwLoQ4zcW9PEglPu1y4zVEA0Nq5vgkPCVBAxUwVTI0FMBEu
	/eJJB/CI+BYZpmh+QG2zWqyo0uDbEnZnZIiighTjb8CovdsKwx5Z8ybmGCKMLXc5
	Ps0V8pcGU073VOyf4EpuDl+h6mjTCB7a+vpi5qZoWh7vUAhwAmKeCDqlVmGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723532056; x=1723618456; bh=VlchXIwsL19lhpIKUiKflMZyp6ev
	LsODoeDkoSPWSPU=; b=vDqJuFAVvEntIxqSMubuu47+zHU62CC0b2NmxSqvqY/b
	0tHIhwnT8JIa/EmcsYoz6//K1ivQCmGlX4RCw2MBhxFKON4UvI7DvbDS8itYbtmD
	KeLgvg3M3gn+sqqvT7Ux174lVoHIqtYVLxVtE/N3C3XqEJTvRQH5hXhly588FwLf
	eKne+KQJKh0XmxTn+3p1gr6ZWmmXRWYWly6DDti/mZAhzPePZKI5218TTkEALihE
	qNYCe9DpKPsvPGKHRxlq1xwrYydxo6a/xMCcE58Dhga9XkY9+gQ2jmS8mI2sDWYT
	ex7Aw1XrtbcYMYMtykCU+9j1sxsdG4VtmwIOUFiSiw==
X-ME-Sender: <xms:FwO7ZqAsb9u98c1qJuT6Mxj7KiGSvkZklSjekTqgJ_GmbJuEkomiEw>
    <xme:FwO7Zkjc43u49eKAH7-AT9dc93yr9OGtqj5wajmOMgsHuu0PHJ1zck1DVyVrvLr0y
    AEsSX2tiRsFYAZw8A>
X-ME-Received: <xmr:FwO7ZtnSrfFhth8TtW8hNUfwTW1MQ7c1KpRzeyqFw-SyS2waJlzuqXjgkWqMTAw3rdeWxi6qJPftJkxWrbFEH7RMz1r06Bvo4tq3ObokOd4Dfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:FwO7ZowoYeXqJg4KTuRNpsJEFhYuAJ-EWA0DlbpX8ZeXZtjJYQxq0w>
    <xmx:FwO7ZvTPH_q3pq70df_Q_Uj1EgaN8ff8ZrM7wxUrRy7jZxPT4n8Dcw>
    <xmx:FwO7ZjZfN-KgSD6qV5jB17M8VzS6Xv2QH5vmLgJKpTiMPW0QgP_VcQ>
    <xmx:FwO7ZoSfgx2_8vxKa8ArC0kkpYvX7_d2fZ7y1eIxwzBTP_LxMU9RQw>
    <xmx:GAO7ZtMaEO3VCK2J1L6ho5-mWdkMJ2X7AdLbVW_KguzLns7qakIcMvkS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 02:54:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e92820e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 06:53:57 +0000 (UTC)
Date: Tue, 13 Aug 2024 08:54:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, James Liu <james@jamesliu.io>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 08/22] config: fix leaking comment character config
Message-ID: <ZrsDFB1FzMvesTBH@tanuki>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
 <8fbd72a1002d1a285847c62b5524041927a7b4d4.1723121979.git.ps@pks.im>
 <xmqq34nfhrb9.fsf@gitster.g>
 <Zrm9ix5aN_g76Qxq@tanuki>
 <xmqqbk1x1nyi.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbk1x1nyi.fsf@gitster.g>

On Mon, Aug 12, 2024 at 01:32:53PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Thu, Aug 08, 2024 at 10:12:26AM -0700, Junio C Hamano wrote:
> >> Patrick Steinhardt <ps@pks.im> writes:
> >> 
> >> > diff --git a/config.c b/config.c
> >> > index 6421894614..cb78b652ee 100644
> >> > --- a/config.c
> >> > +++ b/config.c
> >> > @@ -1596,7 +1596,9 @@ static int git_default_core_config(const char *var, const char *value,
> >> >  		else if (value[0]) {
> >> >  			if (strchr(value, '\n'))
> >> >  				return error(_("%s cannot contain newline"), var);
> >> > -			comment_line_str = xstrdup(value);
> >> > +			free(comment_line_str_allocated);
> >> > +			comment_line_str = comment_line_str_allocated =
> >> > +				xstrdup(value);
> >> 
> >> If you are to follow the _to_free pattern, you do not have to
> >> allocate here, no?  We borrow the value in the configset and point
> >> at it via comment_line_str, and clear comment_line_str_to_free
> >> because there is nothing to free now.  I.e.
> >> 
> >> 			comment_line_str = value;
> >> 			FREE_AND_NULL(comment_line_str_allocated);
> >
> > Only if it is guaranteed that the configuration will never be re-read,
> > which would end up discarding memory owned by the old string. Which
> > should be the case already, but to the best of my knowledge we do not
> > document the expected lifetime of config strings anywhere.
> 
> Then let's mark it as #leftoverbits to document it.  Many other code
> paths depend on it.

Okay.

> >> I still think the approach taken by the previous iteration was
> >> simpler and much less error prone, though.
> >
> > I personally prefer this iteration.
> 
> If so, then let's fully take advantage of the fact that you have a
> to-free variable dedicated for the comment_line_str variable.

Can do.

> I still think it is a maintenance burden to keep them always in sync
> (which is another thing the developers have to remember---when they
> are updating _this_ particular variable, an extra rule applies and
> they need to take care of this _allocated thing associated with it),
> and the first approach, by not forcing all the other assignment code
> paths to worry about it, simplifies the mental model for developers
> greatly (i.e. we know we do not own the initial value, but
> everything else we allocate thus we free everything but the initial
> value), in exchange for a slightly wasteful allocation.
> 
> The approach in the second patch is worse in two counds compared to
> the original.  It does wasteful allocation (which we do not have
> to---the fix was shown above).  It also burdens the developers to
> know that they have to manually manage the _allocated half of the
> two-variable pair.

Well, the developer has to manage the allocation in both versions of
this patch series. In the first iteration it just wasn't as bad because
I didn't bother to adjust all sites where we set up the comment string.
So I was just about to convert it back to the first iteration, but then
again saw that we now have to carry this ugly construct everywhere:

    if (comment_line_str != comment_line_str_default)
        free((char *) comment_line_str);
    comme_line_str = xstrdup(value);

vs

    free(comment_line_str_to_free);
    comment_line_str = comment_line_str_to_free = xstrdup(value);

I certainly think that the maintenance headache of the first version is
higher than having to maintain both variables. The worst that can happen
for the second version is that we leak memory because we don't update
the `_to_free` string. The worst that can happen in the above code
snippet is that one isn't aware of the condition of when the string
needs to be freed and then unconditionally frees it, leading to a
segfault.

But as said, ultimately I think neither of these versions is great.

Patrick
