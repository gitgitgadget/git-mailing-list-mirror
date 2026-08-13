Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F337441619
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611385; cv=none; b=O1SkIES+G9diW5ZfMHPN/bUQDoge6DBD0piB3C+Ot6SJLySkSm/aY14q250ZQTMVRiZpFjO4vWOss0My+638DJjl7LGC5ILtJCVxMUJzl/ro8qeuBHvMTNWpALPOrHohc8oRDp7cX0v/H+rqyBYIgpInlNet9t2l/4tOH/4rLss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611385; c=relaxed/simple;
	bh=LJ9n4A5jdji3VHuDBuTSjQhtdFrvLG2QiuGF5ZEMOng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0jAybv++RZdYqyg5jmgIlEiKJFPCUKKxQd/qb07o+HCgWr+EIFTy1cQZiWU96VisuuCRVdo5lnRmGDkyJ8R1luw8ZhOb82iya20QQc6LmyeIuwH+rbAdIZrT7aOKZuVpiCk7gnM8HSwkxFaeDXH53It67/1xH87FD9v3blqRyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GkOpynMB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RNj4jmV1; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GkOpynMB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RNj4jmV1"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 728411D000F8;
	Thu, 13 Aug 2026 04:56:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 13 Aug 2026 04:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786611383; x=1786697783; bh=oTjYNJaNvp
	z9qoYGk4mu/z1IC5lPt9/nTYonGW4k1vs=; b=GkOpynMBEAhApOKGeKbGRNg1mv
	2zyv5SRe7LYan1hTXY9mLSNAqdjkfH2UPZ/3yvDG8UXxNQdwmMmcyOrn+1rkUDuP
	UkHQywmEH0DT1V9AFzKcffMGOy3Hzvws133q5nObEuLr9XYw1Bo8hV2jKq3HiUUx
	3Omqeab3QFxpmo6OWxkr0RcRZ5e9xUuJ/gwrwQPVUfJ/6+h3uyBM/eb6f1wr3KoP
	3b5lgDQZ1BrmkwXOehZPoq6XnYQ+xnrBXle7+7wcy5cg0ZbyCxYyks1ZngNTMh5s
	8olVxuuxcykv0diAhkeL7un6pWhOUKL8OCiVrww/CiMVkk/dAnOi0JuEKhcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786611383; x=1786697783; bh=oTjYNJaNvpz9qoYGk4mu/z1IC5lPt9/nTYo
	nGW4k1vs=; b=RNj4jmV1fCMRKS1Jc/M19ww/ZefOJI6ACLR4iXvX8jvUtCSOnLl
	q8nlbfycNCIaH9Si5uYiLkJ5RNRPy2QUlAREuOdp6eYaniLO8B5Py5gcoXkoS89Q
	a5wjG+5bsSEzfCNEoYJSmz8UzuJ9bpe7BoI/TB3kYmBMG0ka11jhjW5HFKk0taZh
	kviWaPK4moBwub7yFOb+xyShcED1NGrNxdpKOFv2Y6lDXIE3tjseXYAayXs5xxRx
	RyfUXdRWYHzxBTrXb6AnwvtVD/qv+cvsjQvdd8qxmBPrafQqPwuDKdoyyza43pud
	KAR+QF4BVZhz8Sfi6fRjeeEYRoAY/df/khQ==
X-ME-Sender: <xms:t4Z9aomApJ0ba9LOE-fpfIKkNlytYTKLI0VnOXqX197mEi_kEEwWGQ>
    <xme:t4Z9avTHo-jZtUMLpw8VnDBAl9J9ZbZOdGpRvvWKNarYUBNi-mKnjID1BcMaSfE5k
    9UKwPi8y16dN4DOA1KoGFfUA8cVaTatEF2ifL15kTQUcRjyYLBYIw>
X-ME-Received: <xmr:t4Z9akBjz1T0FfuyYwqCN0pdSIaMRDnG3oeLcsmeWQz-FNgM6ITqTAKN5ySbX5hHFhk071wzb1Pv7vifxx_5UswCmDT_7EjxRKWYufE2bNn2>
X-ME-Proxy-Cause: dmFkZTGewXri+WCTYzrciI6h7WZ8sjeVrxW1x14YOYZFDaCSpixLnaNzdnAbldngzIHy+s
    Hisva6FrH5NULms/uHTkOvYNG8W5Uf3bFWM41zrIPQBe9svegwAwOQnUbOZV81a/8PuNib
    GlIsSjoZHOK5XQLe9BPuKJbItbZIPd3YFVf0rYIXsJK9FhJfJ2HZNZviqoZfydvr5Hczml
    fZFBBjfIY0RPlJlfKIhMGEW09kxnSE/cElghFNhzuK47zCCxXLcX7YgGPv7j+FmW5KZe5u
    V2dXeCAD4cte4fFe7Xh/lwE2poj+WpqOFF9mtNC3xHFJl7gEvIYEIX6acN1VdKxwZrBpif
    zEiag0QK5UO/79S8rz1CFZhHTLmWNa+lydnFEhAmupuvQroCz1UpoJwOlgcpQRKgJikAyD
    6va6rPxwIFy+NN/6UABKQEFHVzEjCVJGtupWXs+eeDTBgeaDUIeFkh9R1IaA/dB9gsDsoZ
    ALs1MB2VNT1RhMq8sFPM4t/+Rl5EzR+y7/OJPan16N+ZeKZqPPGuZ7+9lA4u1F4xm8PnqZ
    QJIA9IxEkvAA/923BQoVPKZhL5ymZ6Ti+GN4FtvzyXKKPccJuBus6w7TWTA9oUt/6Dt5jB
    LZIxPwg/xun/t1PgDCUl6sLbe7REHVCDedNqbpgyhmQ28U+zKIYDI1rVxZTg
X-ME-Proxy: <xmx:t4Z9auRFQ1eFb5Sxav5gwLiCWkceSFy0_i_UIQuCGs_5QbJPcU0amg>
    <xmx:t4Z9aqoVASmzoi4qet1HADLknpbwxjoVscPO_bFVXSQVN9sDbBwI1Q>
    <xmx:t4Z9aox2Nt5wAvwSHwnizdqWoMEekZg4fnMTXCzZDIEujjgeYOlJ_Q>
    <xmx:t4Z9anJLlaqfNPVZga9BWGIqrgjHQEHFUyUZyhk4P1Y2m7QE8iOo6g>
    <xmx:t4Z9ajRr61lKUH_HAfG6Icn1iwLXDm0yGxNkbXD96vjinyI7o3X4p30->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 04:56:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0019a6c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Aug 2026 08:56:20 +0000 (UTC)
Date: Thu, 13 Aug 2026 10:56:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 0/4] odb: eagerly load alternates
Message-ID: <an2Gsf0LzYRKkQkZ@pks.im>
References: <20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im>
 <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
 <xmqqy0ebxsap.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0ebxsap.fsf@gitster.g>

On Wed, Aug 12, 2026 at 08:38:38AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The series is built on top of 010afd3166 (The 12th batch, 2026-08-07)
> > with ps/odb-make-creation-pluggable at e927cfeb21 (odb: make creation of
> > on-disk structures pluggable, 2026-08-07) merged into it.
> 
> It is not a clean merge, though.  Please double check the
> synthesized base when I push the integration results out later
> today.  d296c52baa (Merge branch 'ps/odb-make-creation-pluggable'
> into ps/odb-eagerly-load-alternates, 2026-08-12) will be the merge,
> unless I notice and fix a mismerge in it before I push it out.

Hm. I'm probably missing something, but your merge is a bit curious as
you merge the dependency into the feature branch instead of making it
the base of it. If I do the following:

    # Switch to the master commit.
    $ git switch --detach 010afd3166
    # Merge the dependnecy.
    $ git merge e927cfeb21

Then the only merge conflict I get is in "odb/source-files.c". This is a
trivial merge conflict though, as it only impacts included headers. And
then the rest of this series applies on top of that merge base without
any further issues.

Am I missing something?

Thanks!

Patrick
