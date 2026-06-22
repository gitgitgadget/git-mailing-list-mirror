Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DC6382398
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782114734; cv=none; b=hXwx/nwo6kzBQYYO3b4NUOm9Vn7JYw5Am5zr4lsIFPROQ2VXM4iLXVDAnK0NdU94vXpGQVx5Zmtjs7fJxv87h9uC8WKKWbDGZkO0RO9j6aS+F76r8JeHWoWIaLzayJ8GIYzuuNdoORkWqfM88eW7Z15qK+9uGkSkym1luoAkNGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782114734; c=relaxed/simple;
	bh=fmTFRbDyI9IdUP+uCCDyN1ak/r6EM24avEjNs5aHtqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8HhChdfV24EU04KRdEB+QqrCAayMbS9N4lIZXOry4aB040sqBJRZE+CkmeLYukfEAmT/1u2TdbvK5TV92/Pp9UdcmgVBKhpAbSxDYO+JAt59Bo5fdl2iRSNZNBAwrbqKkqc2jiH9RIx2kcl3Akh3FvslxFGHBbNA0QK5ts99w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NwAXjd2U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZX1b9mPA; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NwAXjd2U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZX1b9mPA"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 796811D0007A;
	Mon, 22 Jun 2026 03:52:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 22 Jun 2026 03:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782114731; x=1782201131; bh=fvdUqjlMb5
	2eOjlNYcy/PlhAf7T4Zw01q8eitwUsWOQ=; b=NwAXjd2U89BcyZozO/HVmzMA/k
	xTNFN5R+ISKV4WtaSbYuUJ0EGgF93s5dTrj9efRPLVXBbQwIUQq1H+O54xHD/p41
	55YVHzGFWXissVwQQ5+szMSatlV1ek/vTfGEz3T99Mn82boMNGK1zOLpR0KEDm4t
	oeqI/IegeNp6p3RqmnnuCoa8Ifxax+frFLWf0syB7py4UCdPOr2gcYTDt4n1lpRV
	bqdQ87+xImXNhq0BXhOKt6R5sRrbi3OZdTOKb+rRG85658VK/PiQlSWtX2xd6KA7
	zcPvjiRA6f/7vzUDv/buUAztj8MnCi2prh9bBugy36aEzr/S7p2KbSjlR02w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782114731; x=1782201131; bh=fvdUqjlMb52eOjlNYcy/PlhAf7T4Zw01q8e
	itwUsWOQ=; b=ZX1b9mPAVHSN9yPkVqVjhxEsVVRZccPaiU0uDMny5QvC2Mkxuzi
	OFySkCZWamyqPROHpoACxYFhVPU8nT7ypb0ez6ox+tszxA5qUW+SynHUbMk0ToK2
	PxwtNZSTfrN8Pcj6aTOAWR+lG6OZf9/LFIBFjUxwYj3xwkW4h+agxOEF3Pp5Pq79
	pv6o6aBgRMi03LF3EJbUAydhIEXP7pJgStQkSTz5Rh62Sz9bgQGyCSwpFv7XqPjv
	t36cump0iWwBOKWa3FPtCcF94ZVVdHF/fUmerNZB896IAEgjm0cpw9dGpWKIZK+h
	g/U5HgK5X+WEVYJ2ghKiFXArvs6yRVnucmQ==
X-ME-Sender: <xms:quk4alvAU1WH2NP6z2uLbrbye5Ttdow52QuXuWwzOG4fO27eP1dtXA>
    <xme:quk4akdI8ql4i6TRRlJCY0Kx491BQk9llM8gT0dopPjH96TAOBK6KC8iRhRuAUu_n
    NLa8PlDHz4cXXKRIAq_SIddk7H4fcZuzpKgJCfd6V2eW0qOg7zTbw>
X-ME-Received: <xmr:quk4amaG1XDC7CPnCsmsqJuHl6GGFTDtOWJJ6KReC4cZDVw52t1TsPq7QtHWDq_3qJpFOcYN_Kc3DfAiSDut1De2PgK37ljEEmmMdzxLVw>
X-ME-Proxy-Cause: dmFkZTFgJC0Ek74RDMZEwniJFbDeHRTPVMVNCE6OA5tgwMS3stHdasuKDdSuyvPL85OnW2
    B7KZSD5BQfnZRc5GPg/qLB0LkdDu4ZB7MoKe08knWASWCuWxfRku+cAaVfY5B4qNZFAR9K
    OkC9WHUDsHOgtqt9p/ZYG/CqYX+Pel0x/bSjjixPH7USFSv2dHaU8/pBqi9hUq2ThsGSV8
    xJay++yZTjG2x6AP4m+Nj6Q3IxEGaCzu2+Q7jni46TRKZbp0dsslyX+os9fo2zu11HmLR9
    iFfQA7suBWk79NOlNHxRsLHrak+XPWgXB3ChRk62PYyuzTW98cfsU5WN6rMCagGBK7pZdY
    7AbvDHNt4iJgb+dGbIkokc53sBcoCK+936PCSAZ5g8sr59osPgZAHfqrOj+d1jxMQMJtEw
    Jxna4HO8H1zZhQLSXthc0iZHtrJXVHi4wyqqx+EiN0sOh+yUUqO/rDdEjGldTf7vdsbB8L
    lFLICdKAa8r25xzQZNFQUMZY9h8j2Ouvl3rz4lJj2kPVCJwEZQLsu6YPuAxdyaPYei2pEA
    TDcJ6QE12RixQ/heiJYU9iumc037cGdi0xjZyBc8GOp1/9JxO0hMX8UKoymDuaI9P//49N
    wtzZuLBUi/KIkq57VeESZLR+MrZAvRBh6RfLOgeeiDf9iUwiICt6FIcu5BSg
X-ME-Proxy: <xmx:quk4anUmjGPoT8rwJjc0QwiVEE-uoTNgjIlkWQXsfR-JShvGHaOSsA>
    <xmx:q-k4aoj72yAWkhPKVtEB-52kyHdWiMymU7n9tnKpEAA_1IX7f_hdaQ>
    <xmx:q-k4alU0nhCxTTYnjH7LPXk9cEW5uQlykfUIFxVbkwfl0n6jT7a1qA>
    <xmx:q-k4avNYUQYrAhm7A3ZTMq-KvqjDjJmdANCjOJwEPYhHjzGk1jxbTQ>
    <xmx:q-k4ahEYzxLIaxYQ4By-09Ciyc79B_cui6TuwNtgrJo1s5uUlxCw5d8o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 03:52:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5915b375 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 07:52:07 +0000 (UTC)
Date: Mon, 22 Jun 2026 09:52:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2026, #07)
Message-ID: <ajjpoEDt9Q_uv-LY@pks.im>
References: <xmqqldcahu6q.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldcahu6q.fsf@gitster.g>

On Fri, Jun 19, 2026 at 06:33:33PM -0700, Junio C Hamano wrote:
> * ps/gitlab-ci-windows (2026-06-15) 1 commit
>  - gitlab-ci: migrate Windows builds away from Chocolatey
> 
>  Wean the Windows builds in GitLab CI procedure away from
>  (unfortunately unreliable) Chocolatey to install dependencies.
> 
>  Will merge to 'next'?
>  cf. <ajL1677NQShTO6tD@denethor>
>  source: <20260615-b4-pks-gitlab-ci-drop-chocolatey-v1-1-51a6e7d5e388@pks.im>

Yeah, this topic is ready, and I'm very much looking forward to this
fix. This flake has been extremely annoying over the last couple weeks.
Might even be a candidate to also merge to `master` before the release,
if you feel comfortable with that.

Thanks!

Patrick
