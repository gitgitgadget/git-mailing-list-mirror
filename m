Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5A338F252
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 06:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469579; cv=none; b=QFBJ1K876KJMO+mBeOBHHFq5XlrTwj69w/BaIrjJ7WAoKVG69ZRfM32Un9txt7MffwQGumw3FWMPh+DyhUKhTucvFbgNvnTYcU/OKGFP7hynIFUEuUXEg6q+cAgsy4G17dr3XLWwDwYwQfGV8HGduoMBqf0ayMtk6sKSBowIr94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469579; c=relaxed/simple;
	bh=U6saRb3vuITQ6GEN1YN4DOIRFCwUhvNP5BrQN6X85Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwjhsGVGqrHo9eXj0HXYJKQRHQxkEzKAds5LtcqLQx6+KYwTyIAf+ni+nsvSYYzgPoHdSHoJw9vaOEH7Yrn8vu2f0DfomljGBEdVSTEPmXCI12p1bAmOBuLFq2PywEDlsaV0q7dDJz425ZglSGdcoRrH8jQqeP7JGeT49ftCBks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JxNhmFvh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UGyMU42l; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JxNhmFvh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UGyMU42l"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8916A7A00CB;
	Wed,  3 Jun 2026 02:52:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 03 Jun 2026 02:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780469577; x=1780555977; bh=n1uLwm9vJQ
	Z42Q1gilRyQO8Gi0ijzMR3gU6pU7UJ+qw=; b=JxNhmFvhJ7lw/FOlHh+g/hBCzn
	pVy9na3ZQEnGyvpjKXja8zHkYswlL1LwUbHV/AzseWBKqrFWvgQ6g75FNCR8plKx
	xq+TxfHmPEA9eY3JsOcNI54B/A5IHPO6B3JEr6EGbW23VNUarxogYXIpnkilGsQi
	1ienXOmuNmjm9zj4+ZDXQucqEKQKYYYzrKLBDTNepUkNVzFZNpsPiRi71ZuydQoV
	jULMGpRbXt1b79M5KEq/6Ackw77MZhYqWhl3i414BGmvizzI/tR0cUxFLtWt0z6A
	9zjDQ63iy4/+GhsnZPHB+75lZW0IdkUEm8JMZLTfHY+Nw/nJzhE7ssGN+2Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780469577; x=1780555977; bh=n1uLwm9vJQZ42Q1gilRyQO8Gi0ijzMR3gU6
	pU7UJ+qw=; b=UGyMU42l6kPYX4dpBA0mBY/mByCy+jhoruZcXhlPkXEnv+jeUjv
	qLMtejiYfM453sJuuIuyDefPR3VUm+I7ToQ0WwoeEBCMWs7dP20fhGYjKkDR2mIG
	cjNlnaDyz9EhqXIUjz65x5f4sZxD6wZtafU014d+Nyy95cBL2VmUEKWVe3TJpFai
	kJMV8946RvD1JI9PYtToitMJcmt4DOQtswNlEp44DqLkUamLIoX3kLL6qnCIKLgn
	qax2CLXEoP5agAdpAQVHrH464kvsn2ekPwQ7v8D5HI7NDyLp0i/6qvB50pcxYj35
	dVSrm/JMURihPNaFq//CqjTfTG4mGb6bkYA==
X-ME-Sender: <xms:SM8fanErN5niCYWb-Uf5h7d7uLD8sCRo5pKxmiK7AssXnPSVlevlpA>
    <xme:SM8fasGIe8Cky4QQH6dyK1IKWT6i71hXIT8hZda2yTkQN7jcmun3ms80T3fTVtbtw
    LrN3YewAQs1J3QEaECogEp6eggthLg9cHUhV_D8359H2nx8Xc0fIho>
X-ME-Received: <xmr:SM8fasMbxMtLmpCgOoCHLaokJXu3ej-m_l9a6sY67CfrulNrpRxxLACmHG4-KCXHfibPzxMF0NlIO3fHS5gXRcn4QDV7IDLeB08a-2vCzrm_>
X-ME-Proxy-Cause: dmFkZTET5OL9Xsptbv0MDgR/8xzv+rmteGe02aCu9Z8qOo/ruPjyBzOikHZNOjWWsaOPiz
    CAHr5bz3C/EqTnR7hK1jC1VnaNKEVRAi8JLWfsWPHoXChb0BSFLjwNStO/z8aReO6rytPp
    zdJbN5mjDTm0lGaAdkNrPwJ+46c0pGZLpiic6F/gfoTGgJklSOZOn9YPOAHewGXQNk1R0I
    NDVNkXtqh+e7tXM/KaZWHHnjKjFswUhplEpaxZZKW+qj4SkUYyquCAQpX66GdLEEBFDG2o
    tYsZD+psaIMlEfVIsC1iI7aT+p2Y7c4/NXHzTJImlcNUqzI2o76w4MuUtEoufedZzRCARY
    gXFRF/HgfxGuBGU8HJN1vyYf3JEgtOqdgSYFA2kYf1liddErPJB1wANQS4XL9gVebUOWE6
    AqqSy83js2e13oANvw+O/LqSELuFXR9oK/QmlhSaeMbz+8tyzBu1fwQeI8Byca5dj/sS7v
    QHSgKbaEvH901mIDS3AK3hcmBKzAzcB0buHVHhp1q0v6hl1t7MvRvQx1dXnmokbrR1jSls
    6y0JYcvq3xfYLYbAY/AtcrP5MDvftRXDV0bqzGWkSV7pAHBecbJIX1xi7ppknWh8EXY4O5
    zhcTR03oJzgDC8Wgnmo4vhhC0be6OxXNIaTnKc1MKLlo4AUHvsN2BtA1yHTg
X-ME-Proxy: <xmx:SM8fajGFxq9pBs3vZ1onQBLXY1oYeUliFG_D1VfFmKJO0Vjbadq97g>
    <xmx:SM8farPFL-gArzKauSyJuaTGQpRQZW6BGiEYpO2MPruPlvRPdVMhUg>
    <xmx:SM8fas-_KKYOh-uM2x7UUN9ifvk9JapcvPYUp7mEVybSd-kbuyxy8A>
    <xmx:SM8favSyax4nWwc4HUM2mEvbPPtpLnM-Ek60Xlk7NKD2PwpNigjvVw>
    <xmx:Sc8fajWvXO61OGabdiQcA7atHZJWJbKrwPZ4RnuLixFFoyEKT5D7tdo9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 02:52:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f0d385f3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jun 2026 06:52:52 +0000 (UTC)
Date: Wed, 3 Jun 2026 08:52:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] b4: introduce configuration for the Git project
Message-ID: <ah_PPuX1aVc4CtWb@pks.im>
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
 <20260602-pks-b4-v1-1-a7ae5a49e9cf@pks.im>
 <xmqqldcxvziw.fsf@gitster.g>
 <8dbdb553-9633-46bb-8a51-040d06d0d10e@ramsayjones.plus.com>
 <871peopbvf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871peopbvf.fsf@gitster.g>

On Wed, Jun 03, 2026 at 11:59:48AM +0900, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
> > On 02/06/2026 2:32 pm, Junio C Hamano wrote:
> >> Patrick Steinhardt <ps@pks.im> writes:
> >> 
> >>> We're about to extend our documentation to recommend b4 for sending
> >>> patch series ot the mailing list. Prepare for this by introducing a b4
> >>> configuration so that the tool knows to honor our preferences. For now,
> >>> this configuration does two things:
> >>> ...
> >> (hence making the tree dirty).
> >
> > Hmm, for those of us not in the know, perhaps mention the b4 documentation
> > at 'b4.docs.kernel.org' (which includes how to install b4 ... ;) ).
> 
> Thanks for raising an excellent point.

I already refer to the docs in the second commit. Let me maybe reorder
them so that we first show how it's used before tweaking it.

Patrick
