Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793173295;
	b=DTtI7qHqLmG96A79nuxjf8G/uSRTbFi5mKB7bRUM8kezz1RJ0//O4s47kMAiksZUE2/9
	 LphzcBJiSnsbkkUj4MXWRsM4sSdHVWvoXDQtN3XLWOGKhe07nCRSjqI5LY123pvLLB80S
	 YOWnjOxY75QgBbk6jh146kI0QWsLHQEgBH32DIuwU6xzfAm1paK2jVwQm0ejCh9RU7ka+
	 g4RHCS0P0D1vYN/OVFJg0vWYw1k+Hi+/WRSl8XIO8WQY0DBLNzcKtrk71FnaYDvz4nGOD
	 UAthGsLrY2+dCPjXUsMA3svm7Uq22T3ZSf571NPI3uJV2UO2E5xj6PuqEqq/DkxwMtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793173295;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ASAaaGslpHCJStb63hpWvoai98Vp8emAC3uEF7bJcS8=;
	b=d/Z4IOlX/9w/ZCLUjOy+e0nFwvEJzd/duSdz47+kHGCdDaTfKNx8ZjiLrPZwq3kIBeN6
	 Py98zKaq6q6UBdu9+WMqVVWlHOKT/wRF6Igh6eVX2vzeNjS69QWZlRsKyuyYyhKLc6C4+
	 jUQwXJ1TGsJE2izMbd/31sxCqa5jcwZRUISHpw/E+vm/BFdBqoA3SV1nOX2zOY5+bfbxK
	 Ckm/fF8Staz00cjNLnxR133eRV2pWmXNJ9pADtkqRGiVSi0I3DdA9VH3BilaE6xw+ZLKa
	 eWhvtk+mP/Qa+IxxLEbRDKRbzpmX/yQXhPALY1uS6tkUvi9zbsFSIXleeioXecFrRcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=SgCGE0Tb;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qbQhsN+M;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C3C606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 07:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11C3C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=SgCGE0Tb;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qbQhsN+M
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 518EF7A01A8
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 03:41:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 28 Oct 2026 03:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793173292; x=1793259692; bh=ASAaaGslpH
	CJStb63hpWvoai98Vp8emAC3uEF7bJcS8=; b=SgCGE0TbrlF990N/IHiqybE07W
	CRghSn9O2wBexYQdHHGeu7DpQ5a6erx5NzmkjhHxK4d9z7rOJMmep02odcpSyeIg
	LfXoe896PHIfoDAB+q4ci2EmBW7ZNO4Gah12JYycwUlAFQ8oCjyU7Z/rpwzJrWkK
	tZmfPK6zTQcZokfSYaLiRy38wyrNfqEZ1WwBbCC52Lbd/votiT1azNCEYHJGHGqh
	rBTd/Cpy6YUQ77r1FWK5QPs4zAD2GWCl+Imud/FBRS0/REernUgmymNRLtsMtOBb
	6yOldWXd66s0jf8fScMA6oH72i+hkwZssPk1MJt28WoYSHf5urlh1CF2v4mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793173292; x=1793259692; bh=ASAaaGslpHCJStb63hpWvoai98Vp8emAC3u
	EF7bJcS8=; b=qbQhsN+M0tl6bSfhoURP9Bzt1jpdbu1LBhViXrVKAe/FmJKQnOr
	c4g+poR3GU6SsxbxgQU/6lzhrYoRyhXLj9uVNuIb9nUWvHANGnwALHnDK8MMjVLj
	omi2d0whNW7UnblfzHnNh/Zol5E0zZBf2ee0qvfuO3NRvbTmR6c9pAJsCPxtm0Yq
	0YBQkWXZ/ljoBadt8cCd4YmeptJOCYClaovdcyuCUTxjyFei+x3FQc0R8cFgpdQf
	HBws44mE4yOinwp9psQIG7d1/8b8Zca3lpXpHCnl6KJb8DbcUh8tcCz0H2+p0pBG
	TbKTGcHZEgqHcHi3Ttv/3DVRMIr5wnj5y9Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793173292; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Yk7TAkTrevL4ForbWyx8aD6jISg9i3vJjaNJS4WR6REuNNB
	e9IaoZegJz/nYvivyu2wUNhwjrzJk/dE/74ZGV53zkJGx4XgiE8X58aTsCqNWoMc
	fqhSKvK7Qul134R/P1zBt2oMz9MVuGE1LMdxQX9R5OrSFr5NR1XINMH69t8FsgA7
	a5A69bKM7eK5nD8NeVtlRxvVICQ2buFytdnUrQLkzJUtPKHUuEbNmoEyq08KLDab
	VP9VOQUVp8gPSX2Rnn0w8oxxWSJN4ANW29TzOdwu6iFcznY371BmShvd1aHrK/Sr
	aXh0UjvMfi7e0AgMFw0cRtQtJuAH2EDqmobNwxA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:tUe84QT9eXstCKihtWFLg8WMUyvhV2z0my1il04r0O4=:0oE9seCGEZ2a/tnznE085Tdv8AUpspzZh2Z1G1Vu8k8=;
X-ME-Sender: <xms:LKfhahohBz0BMy0WQpWLcHhG4aUAkCTKAYckFhcbDtt-ax7gYuAnjQ>
    <xme:LKfhaqha645LpWVUnpa3TcpL1Gnm5YptOLxIcSLH26hq6SrFoV32tD1cmT44JinNx
    CEeNnKmgc7Eyje4lEOVvDPBInacTyycebwVlqIDlRbzR_kU9rWMglk>
X-ME-Received: <xmr:LKfhamgcmzMKxZxFKkcsFjZjl_Ip5R8yt48QqOj8MtSR2v36N9LAZg>
X-ME-Proxy-Cause: dmFkZTFVGQfHR+syN53u+F3U4e5WX0VyyHZyCtWT0X0EP2K26zQZ1h/sxXIbSwpt2wjfva
    nGF37sxUX3MsKTkerUsMgqaZlemjjeRYq3ZjnQMevK9hJ7kPMk5tFOqS3MF9rp/I9KceKh
    ZPy744i+wJ7GHePF9s/FwmczuQFTItm5ge8+B0ww/XQHHeO8ZbRyURhUXItT7QszXzvxwW
    G/a6T2IpZ4oXI0ncpibsy2uld8lP6EBJ4GZ6NoazsEcYJ6gKF2tuuI9HIvAbRx7hu+tzdZ
    j36nSRQJBdFVGQCKHcQIrFGtVq2czrueK3ch0xPySXQ3B8OMUfjm7UBo7a9nykITcrgoEw
    aTullE0RYZC4DEnIu0HbtMTeTw7Aqg0h/4F3miY///lvmdgi5Afc0OO8b1b43e4p5me6xQ
    yEGtuF+JrcCorgI0mfFnkSFiiS1HKUI9ojOicpkqGqLFrnaEJ78t9YLMiwN0ZyqOzKjXNY
    +1wPaPL6N884GtpgTOtPfdZqwygi2ieV6uRMnzpDeQSBzr8WxP+zm/N4Q3mIe3HOUzK2WT
    ZLwWDZnkcsbSCwLSU3BJF4T3nRaxA/WpNh1Q00eCqUJBhzylyJNB/l+HY583DTHT02wgnc
    plUIz73/bgI+JxGu8k58697gyM5bmlsPBTj8h2U7abEwbzKdXyohRDrusZnQ
X-ME-Proxy: <xmx:LKfhaoiyEToWhIA0dz4qOKhJdwB0u7dV6Ufa_PTFBWda4WvFsvuRZQ>
    <xmx:LKfhauLwZFp0mw1FHMRDHLxCsZPBn1cuC5EbFbJRO9gQV82i2DrBjQ>
    <xmx:LKfhavH1uT12gtkaY0yPpCLnaKFgtXAxPULLXQE1fcqrBN9-6R9TKg>
    <xmx:LKfhaqSFiWmJVJ1uTpZuNNNyJ_jaGfZ3Tr4V-QIxQmTGmIsucQOe9w>
    <xmx:LKfhapBvLS7OO86phpOaeweBchaJoK4XkpLHfZGrgrrYrOUg-itCd3e9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 03:41:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 69ea64b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Oct 2026 07:41:30 +0000 (UTC)
Date: Wed, 28 Oct 2026 08:41:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH 8/8] t/test-lib: make feature-testbed job more accessible
Message-ID: <auGnJ_cb5vQgo0We@pks.im>
References: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
 <20261027-b4-pks-ci-test-vars-consolidation-v1-8-f28edf79bd6c@pks.im>
 <1da30fde-75bf-469f-80e1-ce90cd29c84d@gmail.com>
 <xmqq4ie6j1vw.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4ie6j1vw.fsf@gitster.g>

On Tue, Oct 27, 2026 at 01:59:31PM -0700, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > That all sounds sensible, the commit message could maybe flag that the 
> > "feature-testbed" also sets OPENSSL_SHA1_UNSAFE which 
> > "--feature-testbed" does not because it is only concerned with GIT_TEST_*.
> >
> >> diff --git a/t/test-lib.sh b/t/test-lib.sh
> >> index de566309861..8863bcac930 100644
> >> --- a/t/test-lib.sh
> >> +++ b/t/test-lib.sh
> >> @@ -202,6 +202,14 @@ finalize_test_case_output () { :; }
> >>   finalize_test_leak_output () { :; }
> >>   finalize_test_output () { :; }
> >>   
> >> +set_default_env () {
> >> +	if eval "test -z \"\${$1+set}\""
> >
> > This made me scratch my head for a couple of minutes, but I think it is 
> > correct
> >
> > 	set_default_env ABC 1
> >
> > evaluates
> >
> > 	test -z "${ABC+set}"
> >
> > to see if $ABC is unset.
> >
> > Thanks
> >
> > Phillip
> >> +	then
> >> +		eval "$1=\$2"
> 
> This one may want to quote the right hand side to be more widely
> portable, i.e., eval "$1=\"\$2\"" or something along that line.
> POSIX Bourne shell does not require the right hand side 
> 
>     VARIABLE=$VAR
> 
> to be quoted, but CodingGuidelines has observed some buggy shells.
> It may be better to be extra clear than sorry.

Fair. I've queued this change locally for now, but will wait for the
discussion to figure out whether I'll keep this change in the first
place.

Thanks!

Patrick
