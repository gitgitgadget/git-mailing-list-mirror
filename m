Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED28430FF08
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781528310; cv=none; b=AL1jRgNlSke2b4PTlsXko6QWHvWsfO8pT9jsTMjHmn7PbYyLiJdwJQh2u6MBTg4nNbHk48jPg/RygOv1kD+6gXBx5UaSG+SHssdTxv+QXAVD1HW1v+1byp1DOjuspRizCcfmJXgA3eSaJtvym4N9slwFs+JqA86pEJP3bA6Lz/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781528310; c=relaxed/simple;
	bh=3cQv0VPH2m8yfumuRZeX2jvtB7osv+JW/nyy6CFb3m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nC/j7viLDuJLepPHOp4Joqj844v5vzIJc0rx7zwzX+D7bDmL6Mdd7CZmfGl51zd783JKsM9A2NLHmsg/qn0u/ehcsj8mGEcQy3kh/D/F1m60OX/qBgFfg60lDbgdXnWQs01wIBP7q39Mc2OTrDhqf7zlUiV1+BWRwcqX5b7uF0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X6mJIs04; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aHLNyqIB; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X6mJIs04";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aHLNyqIB"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2D34F14000A2;
	Mon, 15 Jun 2026 08:58:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 15 Jun 2026 08:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781528308; x=1781614708; bh=1D/K+rqspq
	/lkbi3oXFYyYh3bAxajBZNObmdDJ7KIRQ=; b=X6mJIs04VOBtcMFiXZ4TM23OzB
	BxgSc1OahPBcPCI9KWEbbCDh2XIU0R71tf94RxE/em9JU4tVFfduU3sJpktAScm+
	KqkfAqLkWS7JccZFnMbzX+IEVzjMFK30lb1dDa5fwKEHlpOck7Hf0uye1bvIGdbW
	RJ2M7UZaIcq096UcpbM6ZsTSsC2gw6jtfQN5PU7yq8rwu91pevMJKTYNjeGeG536
	aGX5hW//XDBKWc9s+lWWnEyLRYt/S5LUSI3GeeOV2uG1B7DquD2qZAmyfQg0ngDH
	gO4Y1L8H0EJWTDglmNvvY1IuSr7/OogGipTtSKvmZ9UvFUxxqd3NFtX7iJIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781528308; x=1781614708; bh=1D/K+rqspq/lkbi3oXFYyYh3bAxajBZNObm
	dDJ7KIRQ=; b=aHLNyqIBH9GiE6vUETrAylaM543vdf0OJSg4a+pe46j6EdLPcLX
	xmQVbkeSKnJIgGqHBHj9af7Tvn8QNfyiGOGLX3QvcUjHZ8TlYhr5+RPKiIyIVr+T
	6UFSx91L2ypoJbZy8X35z2FMxo9s4PBKl7hfayzCB86Gv2KEdpL7i122Esf6YtNZ
	43ZBzKD60snz259aekd2Y8KD2aDdetoEBE/2EQw1XrGb6j0+Sm2OL7LEpldhRkvM
	AKmM1MWm2t6kdljx1HvFtKRm90uE14pDB9ZhQDBBtm7dMjjLaCvfUksiJMEW4utG
	omZgiAcwVG3d4hHA1fvKU/LV44nIQO0CofQ==
X-ME-Sender: <xms:9PYvalGcM8vWOpA9mD-sfxZBaObgqsHlusO3inpQFRHoRa9E6tjl2Q>
    <xme:9PYvavQJo0leylydg4_8Z31m0VhNsCT4uKfCzAjUSRCa1XY4lv0mP3ORoKQQAVlZ0
    L11eRKtPmpaTXt9roN-FHqtHMUofvzwl6dsJS_xEuDauIMrxDl7>
X-ME-Received: <xmr:9PYvarakzBuX3G1acHQwfC1wnm2ewm8kLJ5yFykDV5_InPWCNOJohbmZj7pORKqoUm-2xA0WkpRO9dz7mGlklV2DNuRz5TkiFhigblxyvA>
X-ME-Proxy-Cause: dmFkZTFXCHa6aC1+76eJv8S5WHCc4n6pfBal6OzmidYCIsw9cHVnS6ghOUb+jb+q/eAejJ
    7Rs80nBbSXjddWHXPVOt/PLVFeH6xfXf/KZaZQY79jeIWLrLnQzxmU6fUjVNUzEpyjNOKa
    VTBCphTY1Nb2m3TGa/YY79ACurNDWebXwnhMw77bvtOMNihceaV0uhGrerZUZAOCFDxeru
    ClOqKGE8VHJDsiLNeasKqO+2uxwwwWTUwsvZNPUQ81TcoUSquQpWMuFcXtDpy/5mTaN8hR
    e7XwwIaCW7Xaeq2bWHJteWvc0I2gx/P/4rNIeMh69ylj6NKkzT/ydiyX7OFy+APTH0e/Km
    RqJcamVS5QqHUyM6LEtCWSiA0QfWlsrcVuw+jON5Wv0Hai9Wt3g06kwdXwGk61g9xdrqxq
    8ZpFlx8GCFXgIEaXhVkUiAi7CjCBncsyanNm/5yrL38+FNXxyGZTu0akr+Qcj/eQ2fx1jF
    xQa11PZBqG18DaGoA33bt6kdGWH03hG1zTdYcSN0nf6Qj5rYXBQprp4b9cKlPGkF/EK5WH
    bi91BYWnZ/kjRQdcR18xT4nkUukiXXb4bMmf5f/O/a6S1Cl6LgeqlcJPAyTjzuthN14I/V
    fqOANnvrXUzXVJK/ulOYeUppRDDCrz4GzT0J80hYZHmc7X7588tVUXXKNSuw
X-ME-Proxy: <xmx:9PYvaq1bh2_MPkgYpUO_Q_wFkN_QyEqrk8YqRH7Gbcm-S4_3rRoS_Q>
    <xmx:9PYvaupygmtk7KeGIB-9RpnbQHOc68aMUfOe-gJ3k-z01qP2Vclgpg>
    <xmx:9PYvapMQTU3snlLtCXzzOaQ-NIroglLGKbkr8ACUfzTcDHcnINLrhQ>
    <xmx:9PYvanpZ3luL6XmFtcXK2lkCcWKwZu7bh87CUGUoJIit_paAhiNL6w>
    <xmx:9PYvahbt13ly1nMNuMn1Cfg9lQxG9vBfv61Uv3D2xGAxiVefySKWdMx5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 08:58:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5a5e5f44 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 12:58:26 +0000 (UTC)
Date: Mon, 15 Jun 2026 14:58:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Tuomas Ahola <taahol@utu.fi>, Weijie Yuan <wy@wyuan.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v3 3/3] b4: introduce configuration for the Git project
Message-ID: <ai_273yFlPQXuMDp@pks.im>
References: <20260608-pks-b4-v3-0-f5e497d10c56@pks.im>
 <20260608-pks-b4-v3-3-f5e497d10c56@pks.im>
 <CAOLa=ZQxA52p+9DcZZ=gVTqZ66ETQvZRQYjZNFjzdbsPwTW2iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQxA52p+9DcZZ=gVTqZ66ETQvZRQYjZNFjzdbsPwTW2iQ@mail.gmail.com>

On Wed, Jun 10, 2026 at 07:13:33AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > We're about to extend our documentation to recommend b4 for sending
> 
> Nit: This is in the past now

True, will fix.

Patrick
