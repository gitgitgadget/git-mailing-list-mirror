Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281037;
	b=UUrsAjs01nnp918rcA26c7JZ5eNqrDinnJIOqxNFLV/27u2H3/EbGaRhnhhJgSYIPlUI
	 7W6VZeojJw+Zxo4ZlmeK3wt8u9ko/pjrXOXhqnDtARWmISn06JOPn74WQoVS5F7osKTDt
	 wBZ0Se7H1j94oyd7k5HTtk4VWdpC8Wt+3qwLQu9tsosKAgqhoDuv85sHjpKAAkBmmAQFg
	 lgDd3VtbWWVui10xxnHdVQ6Ox6L94Jvp1EKwu/TB+JAWcDcBj0uB7rw2D8G/mSgvA6lRC
	 Rl3zaBZWMTLQzzcTJUONS2BzhjCMD1bm+dyMczSQKFyySm0vcl6OSFKFQ/G7D3p76lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281037;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3MTdya3RtoyW2IOHCt7nb6aEUwcT58T70QhoHoXEsD8=;
	b=1As5XjjEqTvzh2uinlpzV1miT6KjZg8ILJ14vU9YEIJfrmjcYzvdj/rus6L/u1uRHKmy
	 7RqZmUdxFITf42edOBeVB08nyiaaTTwVrBrkD2R8AsosJvCXblNP7MATF1PuNElCkPPm+
	 +DlXc10YrgrS+WedYq2TyCAz0b6ZjM0tMJvBDsRDSI5bIDIXlScBzm2ZMWuIubHz2Dna7
	 1RNRzE5+4i3Y37TKrxUc9Ga6UJLNbvgbG9VbcDfl5QLg0WugHh0ADn7ejfoYInDb2HOo2
	 SQXqkvb3Ryh5D9vYRZkY6gvgyO/3+0xhaJN5b8BAQfIrD9DE6R/ikiNFVZwId+TwxUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=oia5Q662;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=lCHjBHm9;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC2B606A33C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 13:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EC2B606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=oia5Q662;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=lCHjBHm9
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 930357A00E9
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 09:37:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 29 Oct 2026 09:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793281036; x=1793367436; bh=3MTdya3Rto
	yW2IOHCt7nb6aEUwcT58T70QhoHoXEsD8=; b=oia5Q662/KB4WfLdMA0sCcKjYy
	SpaPqSd5wFGffcn6XSPAv0gLiXiHWAez4NoDiDViICKFXL00XSCROtnvPs2dj+Al
	Upc9+DK46fo78xWxHn8nU9A++mOnPkai9RKbo3X61bw/2Gg/wclXcP27aEWmXy/L
	f0QpmTUwqDX/4K19W470hHVXuEp05mcMZyoYjpQ1fS0F803cgM6j0olq+QT2onkM
	do/Oq1u+jG4JvECySJ7IC4NUJJP8ys0LNzB/3EuZRHfMjOD+oJjwxQWGeu7bQeXM
	QHZ3/weDkvCsMb4ouMbVqz4sQcdH5SO+XfhoqrCgoPiCgRU/Jhd9bicsz5NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793281036; x=1793367436; bh=3MTdya3RtoyW2IOHCt7nb6aEUwcT58T70Qh
	oHoXEsD8=; b=lCHjBHm9Csjuceyicn590R9TZNd8p4VnMU2JKuCXGnIYQOGWGV0
	ZBBHmajVWTJne5qKziNJ+ptmDTud408CrJxWJIAYt2RUXAIuaYJNbhA6qmrkwR9/
	B4CQiAdRuFaJ+eDvk0FUkxxgFPegbb+EU7esNORIfAy6MxUDRd1Jjxln4wH+C2qj
	aBJMoLnb+up6XkUXB5k/rjZLi6Bc7gi/Q5ceG/GtCwRIKkJxJMfFfS6h0yoqbtah
	3XbmlOIZsfg3IPuNLLqjddbwT3nv92TGSMo2jjwfTuG9ZfTgDsI7HaCnFX9QPDTV
	IZDRSGvS8q5QuUjgIRlEph2m3wB841CovgQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793281036; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:j4jjbQcrEm9lL9GXkBakaD6fvlbrZCiiSxB3a5H8QsKmPSe
	ITy990wNEfRtK0n9rM7S34/CxcaZB/M+f4MFZFWon9VTa35dzg8p3f58nic2gmAS
	L4t1rDcdk8PmoQiAWNBKRGIcNwEU789zUgwmAhltfL+xQzWyJx0sL+SbHhxq+YAW
	N453HOo1l+Sx61u92vy9SIqfriCYdd+Dv9V2E66AHJg8TR0SHqXNQwbq/MH0jbQ3
	1TrArF/gPFLl31/JL3HNDux7vh8QXsHoRCCTSQumhvheuasbzskw1Syq6bEwuXGY
	bhXj1Hz2Skj4a9HIwajVKSGOiCPTt7IvLJ9rg0Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:rwJVQgdmQ6y48yf6wzMtlxiA/MGgb0r0ljf8NIB+X6U=:SFxd0H3vGB7hPXANvpmYMxyJcmD90ATyg+hH4z8gxIM=;
X-ME-Sender: <xms:DEzjatVGXz7vNz2zO14HQNLQNp9HrQPpEdQrwi8Qe9obx8bnW2DMKg>
    <xme:DEzjav2KXilJi9EXJSTm3ClMHY62MVHb-ZF7kXa7SjloXHLNeHoZFaUyJFkW2p5FW
    q6mLm-JrVT1UAizQiJaHk8WusiOs7cIUUHtAaSJgMw_uj5E_kymDMo>
X-ME-Received: <xmr:DEzjarpXoAAOagCd2XiytM7F9zhIcZk-oXuTTj1kGlWxVh2vvlniLA>
X-ME-Proxy-Cause: dmFkZTF8R2v4wPDHTWNH5Ll3t5umSe0PaAL74J5fwD4X/pmhJDDxVrguq1G1NfbgtbPLPs
    KXH60HikjoPZ4FSVOStiujf9kjPakwjwwsX32XeghxZlmTaffeT4zVGQtjgupX/JbvKSu+
    4KXYDIJ09XoGxYKXtovNjHq4rLr6M0oYe42F8YvyaNzPhsHpuhdolEAyEIppvbWwoL7vO1
    wCVJXS6F6BnT9iuZHHCSJoqkb0WxTMyM4Ohxz9h7R9ABtTJkohEtEWOPXl4tF6adfY2xDT
    2Txz94VQbT7lhez2ZKqOJhjJ1wiB5xt5uk0C3rxpKR02HwL8RrEgx5LqOjx6i6JEEZ0Dq1
    0k2eBSrKA0+ng9szPQgXeMnE3LUHSD0+UXS7jy1lI+WCz3xZTYzAafeZ3D8ow0pluC0plb
    PU1cb9/NfZZ1bIWo8Dm4mKMswjtleBuDWZUpm6rhVcnnbUWofh6fPNSLyi1cFyFRmEqqhm
    hTd4wIlrfor4NkniUm8tbIF3CS/EWt6ChFE78uIf4TUfVaywt8iTWJhjY8g+MFCQSg+jpb
    Jk7XVgpvPVf8T4+6FF5NhjGX61prdRmn9dxRzsig2ZTSeeQ2Q7ibeTzM8+1oLEVMQZGzhd
    A8cTX4p0PFjZiwfc8g+XiUHBL6Dgrgoip9kB6uZuQb0fEalxnswqlBAmYKFw
X-ME-Proxy: <xmx:DEzjamXkPQ0epOhi9_4efsFqg0IYdk-cY20HltArwk0nVjxKp0_Zbg>
    <xmx:DEzjambRXalkyF7ZynoJHL9H-z4kggi2U1PoIriqnrr11Tu2GCl8WQ>
    <xmx:DEzjajcsaTfX09dUuSuWcc5ARaL_j1JcJ1vKJrYoSuUu3osNGueaMg>
    <xmx:DEzjag2ZD_6tKYaiWMJt9Ig4LXe1fopSQAfPPmaAyfcQyfgw4G3rKw>
    <xmx:DEzjaoUb341M3yETrfG-CU1RdEfHdMW-V7c6EnMsjZbD4ylktEyqu82o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 09:37:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c8d0b6ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 13:37:12 +0000 (UTC)
Date: Thu, 29 Oct 2026 14:37:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com, karthik.188@gmail.com
Subject: Re: [Outreachy PATCH v2] bundle-uri: stop using the_repository
Message-ID: <auNMBpm4WY1sGUIG@pks.im>
References: <auM3DGcWTL5OdRnD@pks.im>
 <20261029131325.79176-1-okhuomonajayi54@gmail.com>
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
In-Reply-To: <20261029131325.79176-1-okhuomonajayi54@gmail.com>

On Thu, Oct 29, 2026 at 02:13:25PM +0100, Okhuomon Ajayi wrote:
> Changes since v1:
> - Also pass the repository to find_temp_filename() and
>   copy_uri_to_file(), and drop USE_THE_REPOSITORY_VARIABLE,
>   as suggested by Patrick.
> 
> Thanks, Patrick, for the suggestion and the diff, and Karthik
> for the review.

Thanks, the diff looks as expected.

Patrick
