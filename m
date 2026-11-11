Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404453;
	b=HOJWXEBjNsNJwquqBSW2vsugE9J3ZqIwi6A97wE3R1WH+sz8d0JLNFGSh8OWeqfFQoio
	 Wv+D1FIbiWI5eKETYFZ27QPgJzBhOMUpafXUz0ysZ/pBJyOGMLatmbDNoNxTBCuqjVQkh
	 O3cwd6n9NGWQsVbkA7dUbFXoSFeSPns1kgoZVASeT2KcokGDUHkNDbJ8YSbG8xD+3+Mzs
	 z12TeHcJ4TH2DaMh28PugucSQnLXinGQT6hGQ8J7bzluE6thzCqgAq6+XFfcGqAeuyt0e
	 Tojuxj4AXAzrKDI34Y2+8QPD6Ib/3F0aEll/HnL3fphxRhEtQDemlZLQacaTn5xUqNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404453;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/ChzQEx6jUf8d1LkYfYLIuEFALuVc+X0Qs6E6m7Gz5c=;
	b=WRbqCRlFDgqHJaaLPTZ0T7vN0HRrdcKvmw4wdlYItc98gx49eO60v04RIcxPPhXq10Th
	 ZYeTWgQ3qSHPtNc4vE1EqSQ3fLJF7tZcN4ooIgRPhttTwl0MRxI4O5vjYVbxEYTN44lZN
	 wjONVKIIcObIxB4NBA7znjm0vKuVDYD5FsFQGE7XVi9uLpGGOhwV8dhCDPM9YJUVSymf9
	 O2eKKuE0O4wHuNVeD5cONlD/mjSTfqvWVfE49po/V1iGeDLlCCxyI6g09Yv+WaF0zXsHI
	 Q+GPrCs+8Ro7/hwTI14U9jhcvblaVWiieAc/xLpToDljASZcY933ZBv8LIkU6PHB4RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ImvQQ2Tu;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="I+R/t24Z";
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB823606A321
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 13:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB823606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ImvQQ2Tu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=I+R/t24Z
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1138E1D001EF
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 08:40:52 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 11 Nov 2026 08:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794404451; x=1794490851; bh=/ChzQEx6jU
	f8d1LkYfYLIuEFALuVc+X0Qs6E6m7Gz5c=; b=ImvQQ2TuN9HmrEBhoQJECTSea0
	ZI0dgloYwRmSfzSNt4E6aAJvYSqtNTxoHF17qwTmTX0EqgMmJrmH2REPswALuYN1
	H/hPaannJmVcX15oJngsbK5td8+nmKCIjQ2BA59E8aXZai1dvWdxS/6BiXChcL5U
	ghcnw+6fSHgsobxsQz2aXw8jviqqosL+U7P5WJ9fdTSyR33Nr6UEbHNXNRQiLlO1
	ABBqR++6xJl3uzWVkGmykd5hNgZe7pzHBtFIaKp0AN3ghakOl5hoZsLvepXeT4cL
	24rKb1MXSI0zYMj36YzyLQEYKG4eiZMW/epChxedcxMrZjPiHR+9NW8i/UMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794404451; x=1794490851; bh=/ChzQEx6jUf8d1LkYfYLIuEFALuVc+X0Qs6
	E6m7Gz5c=; b=I+R/t24ZQz1q3uFB1eZ0+kPlc9Bis338R6W0go8qogIaWYiN66A
	jPpF0jQsE+b9JPKl/BainsJl96eiFF3XhlCE1i6xBUDiDLSK0dbAOjkpiQvA7iw8
	qqmiJZ35dQFUz3MwAs5DF9Ifiqv8UWqVk6Mu9uWY9zW7rb0fFl47GlnkPVLP++5f
	DoEbJwl2E+e9fPnrZZh8v78OM4Mpfc6vOJmOjhwqu7BGABUQp/wpcaWgP1gHKcJS
	tuGtUPXE5Pqj/TZDBo2ibf/DuS6t/ATnxYtxt8g9vOuTyLpoM3JwiGyNvBZVyrLw
	TUrVWff+Y01WrXTRolCWWNT0MPKYKlxvvew==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794404451; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Joao2gP25otsu7sTtB1FnM9RyHdjIjM7Y2dbe/qbIonnlNM
	UWSBqoDe7N7cDJDCkQeQ+xzHdJBmcScjgxAgTwhE8ephQLYL6b4es/zM8OoRhVYi
	HXPz0va8iHdCEMJPo632oes4IjDqu3KPIZNZskIoYrEYdCbCPcjAb2hsJeRAIx08
	DALLuxYah3MA36t4il0z5HY4n3+EleX0bPqVkwarv4nxTmE330hLbR1q0NZih5vh
	WRXw/sn4aCwnBbjg0JjzmY3TXy9JVMDuGVfnMEW08WO9aiFu5gxI3xm6hlBAD0LV
	3NfIM73S4G84fbKAJPtTm+s1dRbRpW9uiIAc4aw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:6c3GCmzSIcQ7D4k3tcVWgwWxCXlTjo8s18h2QyKYHJk=:oNaP47Q3jcp0X2OIWRbrCjmh5VwR3cX09Aibxe0VPUg=;
X-ME-Sender: <xms:Y3D0aj3e9Kh3PpThgZy8YFJRxEWnhih-DWjmOSEvkXHXGKi7x9R5uA>
    <xme:Y3D0aoENvY6zl_NW0nc7yqrts-ytEhDavlJApranwB4kmiiCQqjf7KL6TnvHgvx4v
    kO8DyGBqtJzebUCV_KyR4J5IJHaW9llkNZjeCwYfJEAJNrPin9Eko8>
X-ME-Received: <xmr:Y3D0ahic1SVGYEiwYyX8ymrK9o1NYzLh9Mx22XxKAmJSV6-Vh7q_F6hxBsKOMBInvSTDag>
X-ME-Proxy-Cause: dmFkZTEiwoLOlpwBOK62i37tKO98qGO65RGavbuMfi9S4rZlZ+FWZk7YzNg3xiVe4FBWOe
    JyszsbS+tey47rasezNlf07tfgECOzw3+MHyhubS/4/REAAuSYI4b6S4rZ8sOl0afK/pfO
    ieo+BIkoeWiroSwVQDRtmIueISmqy4p7ZCGb0PJFuYYlrH9aUSSX7gwNbHcgRY/ltVO3up
    rG2TUyu5w8HbEwz4K4BouKy4DVNsvbBYSMOG/e+tKlcpQ1zpvLhPv26gRf3km7gUxNaXlD
    iPYBSWwkh3k8JtFvCABcODe2TJPj7cdjX80SJd3El9zAAvr3nnDKMG4ZIhImCbUkBSFBbt
    K8XjmX/QHl2vOBwDZdltzu7sV+kEQ1+lcJQt6bpP6XaIt+2CDPReC7cR7nrq6gT1VyACYb
    8gt0noUr4qeFETalWtkYSVcW86Mfs+aRkIgBM+cXBWH+Yun9IKNSGGDA1u7EqzgO8UrJ41
    nz9MBeugkbVgqmLHup90OijX1jnlbv5QzeABxy0W+bqr77tAI9xC8le6YTLkwlK/pEqwla
    ovy55wULmL7cBMdI3n4iDYGgOqRWXsh5bKXuHD+sDVpx3ECLb+cyJxx/wY4Bpih1U2DpoD
    +nwHFtXQUT+nDrTIhyeHPd0egpYZvulwbiuq+vsaUkhxjGHfKzMaq/Ab4tAw
X-ME-Proxy: <xmx:Y3D0aj9PK-S0eU9evokzBz1hj1fqmDRr-Lb7-17C660Q7JmaJXRZsw>
    <xmx:Y3D0aorVfakK-tJr50f660tohgk1ILcfDWW1iQkUaH4jN4sWIQlr_g>
    <xmx:Y3D0ai_TPV0jju5ReEudA42xdAs5V-x65RYdnZmcoqTZvvf5jP88CQ>
    <xmx:Y3D0asXX94vJtfGjKfIRMS8ggtLoDqHOPPl6xq1kghslIX-v9x5MUg>
    <xmx:Y3D0agm1JkDW9NMfa66jks4NeOwVQw1p2afbOwIBcFTrqwoUr1OAq6uS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 08:40:51 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eae8e0c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 13:40:50 +0000 (UTC)
Date: Wed, 11 Nov 2026 14:40:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/6] object-file: stop including "odb/source-loose.h"
Message-ID: <avRwYEihewG0GWdd@pks.im>
References: <20261102-pks-odb-loose-cleanups-v1-0-fbbc86c29693@pks.im>
 <20261102-pks-odb-loose-cleanups-v1-5-fbbc86c29693@pks.im>
 <24939fc5-53aa-45b6-9e4c-249c5989b42b@gmail.com>
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
In-Reply-To: <24939fc5-53aa-45b6-9e4c-249c5989b42b@gmail.com>

On Tue, Nov 10, 2026 at 09:43:09PM +0530, Kaartic Sivaraam wrote:
> On 11/2/26 16:50, Patrick Steinhardt wrote:
> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index ca3a891dfbc..e53c69af31f 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -34,6 +34,7 @@
> >   #include "object-file.h"
> 
> I think we can lose "object-file.h" in this one. The code seems to compile
> fine without it.

Only after step 6 though, because we implicitly depend on "git-zlib.h"
:)

> > diff --git a/http-walker.c b/http-walker.c
> > index 4f50dd9b8d0..13730a27847 100644
> > --- a/http-walker.c
> > +++ b/http-walker.c
> > @@ -11,6 +11,7 @@
> >   #include "packfile.h"
> >   #include "object-file.h"
> >   #include "odb.h"
> > +#include "odb/source-loose.h"
> 
> Ah ha. Looks like I was a bit premature. The http-walker.c change I proposed
> in 2/6 actually belongs here.

Yup, indeed.

> > diff --git a/object-file.h b/object-file.h
> > index 83d3f38a540..746356ceb51 100644
> > --- a/object-file.h
> > +++ b/object-file.h
> > @@ -4,7 +4,7 @@
> >   #include "git-zlib.h"
> >   #include "object.h"
> >   #include "odb.h"
> > -#include "odb/source-loose.h"
> > +#include "odb/streaming.h"
> 
> Do we really need odb/streaming.h? Code seems to compile and tests are happy
> even without it?

If it does then only by chance, as we do use `struct odb_stream` in this
header.

Patrick
