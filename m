Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CD91E2834
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 12:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403689; cv=none; b=FwHhpA3Mk9zQGVS4WEo/9Skicte5hGpD1Omxu1VKYK2L+MIAWfQDtm6oElZ8dWS2H7cedcqkcA2Kc4xiPYXUKn2l+wUAAB5wgwPd8Rk8v4uGT8FwSpO0a+jei8fsiKmwG9wV3HDon8e3BDIROQztsdVF/WFUx4EVWAWIwBg8pDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403689; c=relaxed/simple;
	bh=su0HtEZsosA8Rr/9nwTbGR4/WkupjYVsf31NkBjNQaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6oLKJZ1XO2YR8XBalyu4PwWCKE9QM20jJQHT3MwuhBnyi0aCMRPqxXvnvr4Hf9Y8AVI1JrRQVlN5dS5iFbTNRyFfRU46Nd1DJsV8PALi+o8pEhPGrVsX7Ndgi4N8/4a4v3xrvOSRenm3NPTaXPOFEXZ5EAAjO/SJnW5xezFqHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=okejnkE4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TYtKQ8uk; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="okejnkE4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TYtKQ8uk"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 16B4F1D0007A;
	Tue,  2 Jun 2026 08:34:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 02 Jun 2026 08:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780403686; x=1780490086; bh=rQ5CrphJHA
	XMi+ashMiIADlsiafozjJME6T6FR37xn4=; b=okejnkE4meHAEFHREu9qzWAEjo
	B4Y4uQXnN1+Da3WvMs6ZmYAauXto4kxJPX1jAaqMv5DjTS5fJ9/QZK2mReJM9heg
	HkrvcVu/dugBJMHli9nVY0t19Ri5MXkXQAwZ6QO5uxqdwTW63OHl/7kaAwLCVswh
	EJ7zuq6yrz91ZCyHxakDDbwGlAa74mFD7RdZO5fN7kvK0VfmDIfwFouhe/H6j+H6
	lLZ0jFVrO8Mh2h0Euj9t3d3PekpyQHbE1CMopIyajVnLdnVzdWxXOCQ6uhJtR5Mu
	nhj78OzS68akPuyOym7hV34KEHEK0/NRK2qqr4MVAyUhYhrXBHwJA5exWUiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780403686; x=1780490086; bh=rQ5CrphJHAXMi+ashMiIADlsiafozjJME6T
	6FR37xn4=; b=TYtKQ8ukn8zFubw1f2aQUXxXuMSXesNBObLgnaTEEPS589dcUEA
	K8Nr3Ub6SJ6X6B7JdYnubp9zwqlaqgxtfg2dyNX1VjHVqbpXbUvOcM6ylvgr5VwN
	LP+3M7N8BQrvvIv/c8zm8n6r9ytoWapcwm2uutYY8ig2C/ll7M64+ZkgTCV60VL1
	I1flySnJOv4iQgp7rFlFw380fwSQyFvBYQcpXvRVY/jsOsaivq/xD59pGLkbfIPN
	tVXD9kMyeJZErBwS+U0Z2ROPSb6t1LB6n8Fbjz0gQVmkMA1usPOKq0aPcWP9HPlP
	rBmzhNpDW9OKoPo1hxHWO4o2NLfsd+vdhBw==
X-ME-Sender: <xms:5s0easj8t-fE4WMRzf1N2VVBjpXi7rryMOlbd8ESPGrz6RUpCWTRjA>
    <xme:5s0eai1f8keIRhAvWH4gCF8P2Tws9nj_ZjrwPu_yqikRG-yiXeA2w6etrm0Aco4IM
    nA0rLH35B4ozdyISNRxxkb9_ky7ie1p7CpRUhihVQ0w1cc1FstmZg>
X-ME-Received: <xmr:5s0eaugpctSTVD9BMVDgNikft18t1BJA_Bd4NW9BFplyAPn4fn-SByAPeZy4sewiTHwYy4GSARMPNHPIiCB1PXS8Tq1Jaud6aD-DUxnknw>
X-ME-Proxy-Cause: dmFkZTF+YNcjZsoyG3EwJ+F6yk4hRKmAHugNq3ZxGbHWmo2CoiP6nlorVlLhHiJlmmLjA3
    VVZP9PYFsjJjbWWYRVgUqI++LwJqu6+zqglyIn7sCQXYKcFBg5h1NLXKdWSN6bZS9STX51
    tqnIu1rdV1fVjAgDlUQUddyA2nEpC5+IhdlJ5NBMpSoOTB0uyjYI1rzLXF/JQ0gpwaOvK8
    UTar1+Qc1/SSoVpeN5h4fnpM2TBSD1pn2Kn45V/to5imElB6cMdggJEQ0SNXF9WuLGlWxd
    XXMVL/Tmc5Yi4L81QWfPLJsPRCCbig5Z6j2ay+XTwPXBOdNpoXUfxAJHmdBoKFVQRZZ0HF
    IpMbbufmqRJnuJZ0suGH+gksIrsQYqyxi9mxsz2hUT0VU/5M+xKqF6GFhzPmE7k3cLiNLW
    74ZzNhZFcSUp4GOgkdfg1AeK8KbQgvmrbYqd4iznHDWFl6bUBdHMg384MzimIIrjaj7XHO
    i6Y/cX+VVIWkmVGShJUeXIjPxCjXLrGqyp1b5/Ml5dbiizvD5nUn3O8HRoJcg4cok53104
    LRFtee14fUiGAuv6c0A5wSK9tVheh0lp0DKmCeMuGaVpVzH+SgMS/oIZuI6BkqtUC9IAg4
    Cr38XonACTaf/AUzbaDT7h+POpm3J6zpgNJYkw3DIOUZ0di+V5eDzjVNGt+g
X-ME-Proxy: <xmx:5s0eaqeVuCZ1Bh_sLQMNujq40kqExnM3U_ZCnAL-zSQTGMoHnj6bOg>
    <xmx:5s0eapnV6qLw0l6AQx9Tsv3n_WWsTQlXRv0kchw1MyatJQHgt7FxCg>
    <xmx:5s0eartOHQxNqfR69oZJj282g8Bv4fVxDH9nlBRZEm_zxx56ZLjq_A>
    <xmx:5s0ean8ard6iB2zxEjbu76aFzZEfjTmCCLS3BIbjuBYOoRNv5oZd9A>
    <xmx:5s0eaoL19GcE45l8T9oMBTq9mvlqjIrdTG1R7DvYloylSOzFVb7RUxh9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 08:34:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fd3a5814 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Jun 2026 12:34:43 +0000 (UTC)
Date: Tue, 2 Jun 2026 14:34:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] builtin/init-db: deprecate alias for git-init(1)
Message-ID: <ah7N4CeYM4rozerD@pks.im>
References: <20260601-pks-deprecate-git-init-db-v1-0-ea3e6eebe674@pks.im>
 <20260601-pks-deprecate-git-init-db-v1-2-ea3e6eebe674@pks.im>
 <276a92ac-b2cb-4a89-96d0-9071ab6200be@app.fastmail.com>
 <ah12uk7IFxS92OR1@pks.im>
 <042e66b5-122b-4c86-a9a9-f75f763666a7@gmail.com>
 <ah2VL-ftCQelNoOc@pks.im>
 <2e266786-4ccd-4300-9b53-6f13fbaa2933@app.fastmail.com>
 <xmqqcxy93nph.fsf@gitster.g>
 <ah58IJ8DgSZYRjMM@pks.im>
 <455fc75a-444f-4760-a22f-54a2ec29618b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455fc75a-444f-4760-a22f-54a2ec29618b@app.fastmail.com>

On Tue, Jun 02, 2026 at 09:54:02AM +0200, Kristoffer Haugsbakk wrote:
> On Tue, Jun 2, 2026, at 08:45, Patrick Steinhardt wrote:
> > On Tue, Jun 02, 2026 at 07:22:50AM +0900, Junio C Hamano wrote:
> >> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
> >>>[snip]
> >> Or just leave it without deprecation.  It does not cost much to keep
> >> "init-db", and because we expanded what "git database" means in
> >> later versions of Git since its invention, the name still makes
> >> sense.  Thank Linus for not naming it "init-odb"---that might have
> >> been a valid excuse to rename it because it does not cover the ref
> >> database and config database and others.
> >
> > I wouldn't mind that outcome much, either. What triggered this series is
> > that I'm always annoyed that it's "builtin/init-db.c" instead of
> > "builtin/init.c", and the same for `cmd_init_db()`. But I intentionally
> > constructed the series in a way that the first commit can be picked
> > as-is, so that we can adjust our code to the modern world while not
> > doing the deprecation dance.
> >
> > So I'd be equally happy if we just drop the second commit in this
> > series.
> 
> Could it be worthwhile to mark it as soft deprecated? In the sense that
> it is a legacy alias that is not planned for removal?

The question is how such a soft deprecation would look like. Would it be
a warning, only, but other than that it behaves just as before? Should
we mark it as `DEPRECATED` in "git.c"? Both of those?

Patrick
