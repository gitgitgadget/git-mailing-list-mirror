Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004035;
	b=Fl53fKOKwtNeTS//nDTXLD6LTfHoik9sdEbZmq4HCCRXqPfdEyzNNSDhUIXNXxe6krYG
	 W/ZuzdSCk+87c1/g1F0J767wnxoXmxkhgIYor/oKuWPVy24ofRE+7r5OMVHa2CAN+OkHO
	 ZnUFXPRVT0Jz5zaKYWCHMjV576O//73lj+c2N27X58B7CdHTF5bKeuk8jdAVJdbbKI4bG
	 3dXxLiMkBmxdLQN0FGqegVRxf4xf/b9QDuWgq/0WhbFN9lPTaK4jxPzy7Z1U4VwEwIpvn
	 diLNxzUtMQze/EIZeogxL3m1+aT0X59xBmNFK8KGKv/1n6hlG+Rf9myT72e0RcniJ7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004035;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8Ylek59gAuX5a0egbHVvH/v677zsFBBTsiWKNzq3/cM=;
	b=3zXB/DbWUJdNS11Q85SrzN7tQcYnm5pGP1XWJ+fKAtYw2X8/9xviWNEACBfAMs8J3MAe
	 VtrP0it/wuY5Ijq1w/7npwPLNWcrcEic6r/gu4C7hKnuzGQrL493Ki31dzwThtgbIAWTN
	 OC+a01BeRHpauJI/Lilcv4A1YGByyHz0hoVmK64XEwHT2UihgWx8+60SDgcLGNU4vC5qp
	 jsuxcgJ6ZruHzsztYSB10SRk4YLRNONb3cbEx5VBJWOAaWrwZDljC92G2X0Apy4D8TMhv
	 KQk/msBh5NXZYg5FMYol1BCf9gmkPfr711enoOIF2lVlK4r6MZEekHF6T1LeEgFy6jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Fleub4aI;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=TE8O5uZp;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F35606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30F35606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Fleub4aI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=TE8O5uZp
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 7438B1D000B4
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 04:40:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 26 Oct 2026 04:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793004034; x=1793090434; bh=8Ylek59gAu
	X5a0egbHVvH/v677zsFBBTsiWKNzq3/cM=; b=Fleub4aIn3jmkIjODQmjkM4Bzb
	YLEUz5YeCa/INsrS35xVnUUt5qKjxl5M55cCXnLa3yujn3lNWdaQm5Koy/k/m9XS
	YoualnUa8BPEFMp8J+WIFJToEYe9fN3bYH0M4EHu9yM8DrldcP2dpPWeRZG4k7lP
	qO5Dsx1d28Nmj0wl5xUw7ora2wqEw7XmXXQwulPNEimzTjbF+QtknYQOdkwG7wvL
	Ib+W8BY5XNnwSetXqzngreOB0RxgumR52s8ei7iPG06OA4nk7CNRwczHWURtUr1B
	ogCGIltl9bzTHYc1Lb8hKVaftdLFzRTLCpBwkbcOc1w4KppbeqXsw+ncaosA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793004034; x=1793090434; bh=8Ylek59gAuX5a0egbHVvH/v677zsFBBTsiW
	KNzq3/cM=; b=TE8O5uZpepVOxAsr48aJQk3yOJvf49Z3X3RVPEN927u2kqBfkO6
	mUn5Fbn0/9qauQPmRzjftwgBIb6SnZ98VJBf03ICo/ePTGwL0UI19MUAWFDQV//P
	poXmnT/X0CKJHwZAGARjnRxENOH0GJkiP5iOgVNhe0rA+KpzPE8OMqviPOnUzVjZ
	u0NY4JjEFcnnh2iUg5C6o8buwZqdMItJSAVx6yUmwwox/2e7KEYSLR3r3ZWA17fq
	xrOXYeVVmRNCMsyYT+KWrW5zVnlG4C1HlgGi8HLmK4MRnsDQkKt/obMEJXN5YpBD
	v+c1kAjwpgGm1OXzBGMSI+jcydgUws2yhpQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793004034; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:JNR1VUxC6/Y7i1jkZHLZVS3nlbqSI6b0wH5M/BTw2Nf5WuN
	cNcdF1Wat7rOfi+Fk3cvKX59OfIeZhKuSkrWawGkVJxVsed2ORgbP9jDmQktOVjD
	OZBumqWvSQdNk6vI2yLxuJuW+nXw1/k8jl/thcNAuRNhPvIvOPJNhRrIMfO3yQF+
	MrFgXFOZVLS1+q0QHMiHrm9EYhCd0BaaEnhCgiHAq6j91dwXQbtGIjFtobFma0dB
	axKDA3laSm+H7Kldewcv3Y/yUB47WfOjmgPXVXXfXqqxzR3Lk9HgiXUByRoFowmL
	m8Pt9cy3My0b90DGJLWwFUFW2YNRkNHsmCfYtog==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Y8vn9gp5yo5sRsMK6sjoyVFy/Q9EMNUk696uqMqMyCk=:mHDuOfyjSjGyZeAEFljh/VV3z8BTajegVsE6mTQV3mc=;
X-ME-Sender: <xms:AhLfan09l5v58pNkplCfOx4UumWRKkCl397vOGsNStDTm6AvHra2tA>
    <xme:AhLfasEbcw572kjoQf5DxcYdnNbAyDuae0Noaia2Iz95zyxHPoXkDPUZyVXuTZRbm
    rNYAOaztMWPzrWOIwzNK0kaRkv6ImxntzMvKU8bsUMIHFw4PfykPB8>
X-ME-Received: <xmr:AhLfalgtJ7okHDBdwqinACcwH4KVKEIyepnUMO-8yR0zAF_sKLu2cw>
X-ME-Proxy-Cause: dmFkZTEiHq6gK6IHg/zwOduqLhAMIS4H/CMebzxT9AS3tO63OoX0yA0HmgRjBNd1g/gv6c
    kDVwQBtfip7aNu94zOVyqjt5SO1V6Im8cZ6Q14owYmg8+z5Z3WgST0RTt4KtX49t/Yb0QI
    VcDI5NDRqEzU0aK2mSOjgX5hx0NoWJKznhr2xzc9rnLWkPLoP9avgssOCTXHTwr9n9t8BY
    tMCT9r8M8Bg7Qnwz8oHJKfSHl9JPEJEHrGMEkgV85lezWN0duNtDMFSimNRRhCzmrJaEQI
    2IbAiT89yuQ8XMVtwUWwvA7GBGnnjDe+rPbh0Iv/wkvo4nNekOa9gRbszDhpbJZcYqPRhG
    zuV0gL0uUqo7Vx1QQ2HSOoc/up7JKj35izHtIi/oRItfq5CV+aCShcTnvmDHVPH3jchXix
    m7Trv976kpJ1hXc0Y/DjZZacrFM3/UAHRdv08OSVayxisEUeOZbT/3nZOHv9NPa5Xt8RuD
    tQQ0t5IDpjeKPyxWG1pxEF6H4IYAKJwyzbwPVpVq/CIjD74gE0A/XE5XrI+89M5oqUwEQI
    tvrnnpFcR3QU5zHXi0c48uvYxEY2FlUxqZeTNlmm8V/EHv8DanXWEidfeCvJhAMuDxbboF
    JkdKQU92541fkQQkbDMUDIARxr/kVjDLJpgVKOSpjV5aHSDEl1LuWXAQc5CQ
X-ME-Proxy: <xmx:AhLfan-nZbqWOvOiElDWsOqsZQSzsvE27OuEHtW9eqeqonVxRnvEdg>
    <xmx:AhLfasronibgtEMwBI9fz8A6hY7uDMjugsnHNd2seLxTb7ebh-xxMQ>
    <xmx:AhLfam-FnprVdiAJu1MQaCGBae9s3VblAwG0o3RN3YmkBBeSRF84Iw>
    <xmx:AhLfagU9SWGi0e4LOM42wo0x-J0q20bSGW9F2f9wWtWaDQLPL3ZopA>
    <xmx:AhLfajPOEW1xU2WwM0EFVb2uLp80o2Q28qkdBESJEzFMaqGNmQWeJ2io>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 04:40:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fc7e4e88 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 08:40:32 +0000 (UTC)
Date: Mon, 26 Oct 2026 09:40:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC/PATCH] config: honor file permission bits
Message-ID: <at8R_QThIEedVbO8@pks.im>
References: <xmqqbj8p7okv.fsf@gitster.g>
 <atsZX6exgGJkNQQQ@pks.im>
 <xmqq8q3obh7u.fsf@gitster.g>
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
In-Reply-To: <xmqq8q3obh7u.fsf@gitster.g>

On Fri, Oct 23, 2026 at 07:54:13AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > What I wonder is what makes our config file so special compared to
> > everything else that uses lockfiles. Or put differently: if we think
> > it's important to honor permissions bits (which I think is sensible),
> > shouldn't we do that in a central location like in "lockfile.c" so that
> > all users of this interface behave the same?
> 
> The $HOME/.gitconfig file and its XDG counterparts are the only
> out-of-tree files that suffer from this issue, and being outside the
> repository is what makes them special.  Theoretically, /etc/gitconfig
> on a multi-user system could have the same issue, but the containing
> directory would typically be read-only for regular users, which makes
> the issue irrelevant there.

That explanation makes sense to me. Probably something to put into the
commit message :)

Thanks!

Patrick
