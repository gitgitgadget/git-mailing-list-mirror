Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EF03DCDA0
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 05:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790660594; cv=none; b=GAb8qnJXwBQqQO3C1dSXaJL2G6ho+jSncHHPP2IJXa2k/mCnHSLLD2uhOjwjwqw5tijh4tZlhEnwx3QXp3WAt9nSMN9pJP78yvxTiEHQ/ylD2t959KyAGisCRh9AWpz1RT6u6Ni+FTrOgIcSAuvufbjD9hk/GXyTR14DT/bTHms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790660594; c=relaxed/simple;
	bh=hKysaxgLmrSbhCxgQNLEb32t4RRAPMq10YuC5LKQZbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nH/75VP/rfZAxg7w7iPwXczMhl4+5tvhIUb4WsjFvu5H6LR67zAkvYgpWd/2BPiuE0CLtddjVhF5lifKaB/PX4fMGebX0zbZbPbu6HcJcA1Xtp9ZAsi00NzVbdMbLdO7MUFemKk4L83y01I5mQUOSc04YzxBC3OC/bH8cjARe6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kuOvRvQj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FjDcKM9F; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kuOvRvQj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FjDcKM9F"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 754697A0064;
	Tue, 29 Sep 2026 01:43:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 29 Sep 2026 01:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790660590; x=1790746990; bh=5HO1HUV2Hs
	tRAhz7loFG7rGglfueCvXxMILk/YS0x4c=; b=kuOvRvQjhU8B38Gahda0XG2WrG
	ot54C0CeeZYKqc4AHANnk8ZrP0wnvznpUegMmFU7nanyKToOYdqq8lijYBAI7Xpg
	Mw01Ng95ZlORCfX9SJH6WF5AFG2hmaFOKAaYnBteJ1Al4b1uUNcVKosbvCDsL3b1
	PhAUTxGj+vK4l6u2gIExAVj4l5NHF3gsdOtbvSSbfCDXejdp78UCROiyk7x6WPR8
	eX2nlTsKIoEtnC25LmsQ03lj24FZ7pep/xitKUudoqGRiPE1tk4V7k+CUC3LHEn/
	e17IqCwOe5Ghszt7Ew1NVURC7Zo08m6louQAPYsXsMAyHH9t0rrVjYqjwatQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790660590; x=1790746990; bh=5HO1HUV2HstRAhz7loFG7rGglfueCvXxMIL
	k/YS0x4c=; b=FjDcKM9FPKBkztD5g2xHZpL4hc1AkqKHof1oE2SpM8xy8HmIc2e
	UWOGZr6C+1DSApCDcmHsSsLzyKLlbwN00ES+BMG7IhbCqT9voIF0I/hn3FB9+CjJ
	dVgX6Mw5qPcZPNY8335cvTWi7u6OGEYduYgRwflCStqjaTRsKUnIIfmz8+Gv6nqG
	mAAA5CfJb75lTh0HPhN5okdF0I/oTSIbWoIApq8ouG9J1V+pomHaDvI0RpP0YITZ
	qP1USX8p7+4Vp16KG/tRq1ZNmfl6L5c1dSgp1dyd/b/g7rPGKj1pyi8J5mvI0iBu
	S4LjiH8nRWNTot2+dK0VLgYUnwJZ7Km0Q3Q==
X-ME-Sender: <xms:7k-7ardbJgHKmalALWEc09Crar_51WFj-17HAGzYTcWU-uLRDf_AMA>
    <xme:7k-7anMWAws1INBr7f3nmkx_QMPvMZIRqjKGYuYX4u4d313VSRc716gZ1gXaFk4Cu
    JFmcX7fVr50611HjhQzVnxO77pcCo_XGAaX7LENzcapb2dukfwL8WdI>
X-ME-Received: <xmr:7k-7aiLXyBadLg2FiGQJnLtFfbck7g9o37eLVajuGATnccB3hyNiyw>
X-ME-Proxy-Cause: dmFkZTGTpCStGAvrVLmsEx/khNIzJSSQY3TTELskqN7ytEdABu1js1Pyd1e9MVuHCRIQmm
    WNO2OHagiClPsammtDraMjn+2IkC50XPnl7EuzwwINshCXuloLgn5QmvRtrr3/GRdIKDco
    cz+TmyKTOSHnVjqUvz4BI+KdZFK3RxB6hMDQwRnVhB7R5Ir9rsMkD8fzQS/9pJmFyuXtSv
    4dht2bbg+giVVnKnpo+cMz8lsP2z+ifxFSVA5DU7AyHuZwzA8+UMh2vBEn/pmz9wdrIq8f
    MoovdQXjO3uNkq28VHhjaJhpOlW50aBnzQW6r5vC5RPYS48u/2V4lymKpD6wcyZ0m9c7A4
    MGNgt1HdQO2wSFlBSoS70hVnuyiZzm9VxeesdS45fkqEahFqFo2oQgosmr8ncd2riAkarR
    a0Cv0RJsBadSbL9kUWAmV79OMzDBsYULF2eJx7ScLM1vOgTjTitj872cHf+gi58AOs+f0q
    Pl+MzLA+c9XQo95FCtOLzVFFaHP/HumEncfSGAjBSjRupumeWnRqEhNlSaJg6wT9rl77dM
    GKquVCfTuUPAdGQeXlfm8BjRvUEHf2by2Wv4EOak2Pt5Al34A9WXKHVnw5sbj7RelYMdGk
    JPIKHRNeU9nF814Ud7aS7yhZkl86PrJBbUEjTN9Z8GdQ0lCowyrnKrP1bnOQ
X-ME-Proxy: <xmx:7k-7aoFu_hvtcZfnNLsWycJ8Pjmd86EM8S69TGCY0QWebc4CXCHe_Q>
    <xmx:7k-7aqRwTynTlCC0NgyrUOnUktrriR4eAOzx4WbUVCCllL8davUdCA>
    <xmx:7k-7akE5zqI6Z-w0cxPbO7Vh8pCAztaYMWytGK9Xw1G2M7CerXURDg>
    <xmx:7k-7am95v5onCsbpHMYde2hIgwQTpC_rH_XCraltYVkxbx3wQLynPA>
    <xmx:7k-7ak-mzd9LJUdbWF9GCEtEhA7g0JQnnC49hvJIi2IgV0xPzBJT8ARX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 01:43:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8296f069 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 29 Sep 2026 05:43:07 +0000 (UTC)
Date: Tue, 29 Sep 2026 07:42:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] http: handle curl stripping creds from effective url
Message-ID: <artP42iEIYeQxh4C@pks.im>
References: <20260928040149.GA498186@coredump.intra.peff.net>
 <arplE8-5jD-rZiyu@pks.im>
 <20260928193644.GA1075764@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928193644.GA1075764@coredump.intra.peff.net>

On Mon, Sep 28, 2026 at 03:36:44PM -0400, Jeff King wrote:
> On Mon, Sep 28, 2026 at 03:01:07PM +0200, Patrick Steinhardt wrote:
[snip]
> > > I've used curl's curl_url() interface to do the stripping here, mostly
> > > because its behavior should match the stripping it does internally. And
> > > also, though we have code to parse a URL, we don't have any to
> > > reconstruct it, making a single string comparison hard.
> > > 
> > > One alternative would be to parse with url_parse() or similar, and
> > > compare the individual fields (skipping username/password). I think that
> > > would probably also work in practice, but it seemed to me that the
> > > simplest change would be sticking with string comparisons.
> > 
> > It still feels rather roundabout to compare URLs only to figure out
> > whether we have been redirected. I wondered whether there is maybe a
> > more direct way to get that info, and there indeed is
> > CURLINFO_REDIRECT_COUNT, which allows us to retrieve the number of
> > redirects that have happened.
> > 
> > Is that interface maybe a more direct way to get what we're after?
> 
> Hmm, interesting. We need to grab the effective URL anyway in order to
> actually do the base-url update. But in theory we could replace the "did
> we redirect at all" early return with a check of the redirect count. And
> indeed, the patch looks much cleaner (see below).
> 
> But sadly, it doesn't work! Curl reports that we did 1 redirect for the
> initial request. I think it is counting the extra request it does for
> the auth (we get a 401, then it auto-retries with the password to get a
> 200).
> 
> So we really do need to do our string-based check for "did the URL
> meaningfully change", and all of the annoying cred-stripping that comes
> with it.
> 
> Too bad, because your solution looks much nicer. ;)

Oh, well, that really is too bad indeed. Anyway, let's go with your
first version in that case. Thanks!

Patrick
