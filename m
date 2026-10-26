Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999844;
	b=Or0WplciveIB31FnpMxRN5syoCnia3SsfJ4aXkO7tZMlLrrsl3CGHaNe99OIKO5j1LQ+
	 tnJGc/XN208GufOIKTLBAh+TZJOa/WvkPmV1l50gUo9+HloOi0ATAHDSNgcG+qUqnzafy
	 c0aYWMcwf2AtH6+DA7dn5Fk+3evEDoLQiK8rCEkbBi39aq7cPhgf2TBDiocsoTw0cHgFD
	 CflaAYt19ndBdeHQmH1zOLWMFjjq82ZJuocfrDDghfbtbS7AO8T8jl3Fnnx7duy36O/Em
	 wDg7ZPPUF56j4Sg6bt/5xBg0nkDs0L9RFYxhYzLEaBN0da2Jf+Z7snkydT0qpp4b6Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999844;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=r6CDXbDQi/vT/oUAurjr3J5ExnNPr4gLwTex6zDxKWs=;
	b=rio6Z+C3K8PEVTzgRmfsSrVWvG1xD2AMGMULNN03/da4i3fWlFWYPsTevhxU+9VmnyEN
	 RjMKkEkb+UtyZKmciM9xJr40xJDu2KmZBdtk2MGWVoVBU6i7EhdZFROApnOmTi3jC9fJq
	 y4z9h7CQF8vWmvmsQl+MFHUL6pm2ZNnOWE+ASWiHNoBivF1iKZ5M+7a53U2Mymu8m6+EN
	 DlAhia2fJmt7Fg5INb+OOa1e/BP0KuhNaLKNFuUbrRLuwcRN31XFDU74wcs5aLrC1zXHC
	 VcEOcatcOdFcthVuQUwFDORE/aFdHV8/XwMkYUg344x0LqTh9z2bJI7/GJOKQpHQfqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=rF1IYWo1;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=p5u9oQtq;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D5E606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 07:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59D5E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=rF1IYWo1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=p5u9oQtq
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9BF657A01D1
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 03:30:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 26 Oct 2026 03:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792999843; x=1793086243; bh=r6CDXbDQi/
	vT/oUAurjr3J5ExnNPr4gLwTex6zDxKWs=; b=rF1IYWo1HFnxsxcrEDK+m+H25p
	AM1+dEev0HUnFbm34cUFIWpGlU0jCOGp3leEgrlaBF8ptZjyLfdiXgnigy0IjBf7
	xlgP986wthEOJZfKbhCz1DOIcD5F5UY1Q03Up5ekS0jaa2XDbasy/q5Vy3R3VBq5
	6r7/vrq6sXWzdXs9Nnm73OCIUiWCH5NatC5DjGwOmTauZy7N/5j77DStSAy0/u0D
	9rmez4xtaOgQ6C01llhg7tuH74UYKIIqlYpHkF5Y+QzxNhSKd1fg9MXwUNA3qL79
	czmgVrwpQ3RSCv8RM8bkJFge3JL4fu3HMqomXKRT5CG7STdlZIJ0yRCKvO/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792999843; x=1793086243; bh=r6CDXbDQi/vT/oUAurjr3J5ExnNPr4gLwTe
	x6zDxKWs=; b=p5u9oQtqmceQ+GmcaIL57gicWdB2cUJTywF+C7kZe4KbeOPL7cK
	1yxERDTJ361RkoWkTTZB1ujzqyuaEx3Z/GQlVT82x+Nzx0yyjZ9J1owP85+8Y8dh
	RVjMPUP2kKkUz9UDeI0Z9OMQDgLPMDBL/ffu2baox3o4zU1HI7pUNMwHKLrcwdcB
	K/qI5th1JtVyfPPV6tKlz1MVmJh31BBlmdWxK5Aa5+Sc/HUCuZCrKmMOxk5Df4+v
	GZRcJIF51a9OHte/qLwr3VU/JR94UtAq27fZiUBuL+FjgosAsK/i0EZoguhMckvf
	jP9GMKppqSTRmWtqW/UjeqzMofa1agBfBtA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792999843; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:EGtlsAaL/EJJ5+0a9v9IBoDL1PBExp2JNSab/ZVY9AGoknQ
	u/KyBhMNuMRh3bfknSC2YlSFIaLlDbm13qdpL8lms2KI3Oxl7o3Jz9k6chonCIXw
	4OxEGzzQcmeP5gxYeEv/sUOc64Z4d+KQjj+FlYCriBMSoBmn1zqzft/Fiw8LbFhP
	E9GP96yBAEhGUL6f31sGalg2PwuEwnPHix4Kq/t3cwWomYX76S3TS7kpntfAKupc
	/ai6zHmD2DEpYVXCDKCKAsoKpck2zBz9fW6GyQsK+2x49mx2Z0WS+VxCEhC+Vz7b
	0JZEXmxruYnAZFv6TStTao/aEp1KyNKJTf5I4Sg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:VjoUMbooWwc0a8QDjM2q/B+DQEPqxxkKxj24EV7akz0=:8hyd0Xm/mutr+/pVF0SPLIFV38htJGUjZuJgXbH5a6o=;
X-ME-Sender: <xms:owHfamryxVIF3pFveU7XPToZ-fyVNqeRYklGRfYCJYgXuGHr1jOskw>
    <xme:owHfaroz-t7kpyr0YsoG_CzQbR1kU9AcSyD5YTp8j999vamcHCwAjJ89riU5QvCKi
    n43-KM0btJOg3cqdmTgLUd7brRfCz8PU_vu-Y-HRfwDKzMBDYMoJ08>
X-ME-Received: <xmr:owHfagMwYyQxOCywZGljxfV21aHf4CacmdL4hHvzyswNq7VxdeO4ow>
X-ME-Proxy-Cause: dmFkZTGL2M0pSxoffzeQytxU6DB6L0f8Ey4MXP5fDzrULjQ5c6jfzd84SdmJGaxLTIcBKD
    GoUHZYKz6qX7wawTQPeQwjuy+gkwTimnX7fSz1GnZOTb7jrmzxsjqgPP0XN8mLNF4XjOsQ
    V094lbShT0IgCxiSpLYKjI6XOA09ti5/lXYybyQMVPT3CnRXaxbdmoF40INVjJmkkx08+V
    83T2e/QpJHaZx7GIA0rjX7SOMbTx6oc9ETuXGRqkEPu1Ny+GWokybPELTK//1ZGR1VlJhc
    USjhUov8r8yHCb9GirPeL3XyFIv+bSYpGX/mGXzr5EOJCy0tCBwRb4jA5dufW0tRzWemdT
    Pqeut3GCY88wWSqVtLtLGhVLDWhuBjx7z6639LhKiV9Zcs/pRAxsM2k2zN0AQkw5VIgSty
    pKixIT8wyP83o8MLdIohRch8hXLa1qHTjChSnJklmfbEGqE20r8F+KHTjnTb1PhOnISkj4
    x13UuTg/3Tod3TUAyspRk1mzJnpeAqesSwaxzHJnciV1ykI3wG9dP6DoaaQL3YUkPYOuV1
    z6kR4EemkbPlIiPjcaqcydC21b8PIyc+xzvEI3nc9+HcwvzhgHWgspH+1/rDQnwHHQBAb6
    5/hJwllB9OhQnb4I2eAxQ+vqsOCNSUUiVEdsg+qEacPx3YMQeq75ODf4slWg
X-ME-Proxy: <xmx:owHfakwxQlF4whqrZDVfh6BPT3etq0CU1xpH2bDK-kaw93FWYb8sug>
    <xmx:owHfaht7yhiZzXmBcrT5_FT8n39D6X4jyVqpq3RuY4Hvx1aoHZKBJA>
    <xmx:owHfal76Sq6I1bDn_Fa7Qvogg3qM_zjuNUad9vQHpQB4p7SdFzxn_Q>
    <xmx:owHfaoQhcG3miKquzlWTD_qcVkPRcQdWf2yFI2fBHemIGB1EQVSYTg>
    <xmx:owHfaqgyY8EY_TnPT-xivgyeI5rkT1b3kLvuXj5Tv49eO6C__0MRAD5Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 03:30:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f89bd624 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 07:30:41 +0000 (UTC)
Date: Mon, 26 Oct 2026 08:30:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Joie Joie <soniqjjj@gmail.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>, christian.couder@gmail.com,
	git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] repo: zero-initialize configuration values
Message-ID: <at8BnkKqRSa0fUoO@pks.im>
References: <pull.2271.git.1792522587065.gitgitgadget@gmail.com>
 <pull.2271.v2.git.1792662432.gitgitgadget@gmail.com>
 <df93a2a86cae7d342270c0ee67a1c0d41ada202e.1792662432.git.gitgitgadget@gmail.com>
 <atnz1HFcA8q8IuE_@pks.im>
 <CAH=d44czyUb3Kam8oEfdqY0ROO4636XN5NuuQ0gn+wHUe9xETw@mail.gmail.com>
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
In-Reply-To: <CAH=d44czyUb3Kam8oEfdqY0ROO4636XN5NuuQ0gn+wHUe9xETw@mail.gmail.com>

Hi Joy,

On Fri, Oct 23, 2026 at 01:00:48PM +0100, Joie Joie wrote:
> Hi Patrick,
> 
> Thanks for the review and the suggested wording. I'll add an
> explanation to the commit message and remove the now-unnecessary
> comment.
> 
> I'll include both changes in the next version of the series.

Thanks.

One note though: we don't top-post over here, but instead write our
replies below the parts that we're replying to (like I do here).

Patrick
