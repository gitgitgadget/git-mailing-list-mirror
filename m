Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505747;
	b=AoObTf3yyUanuxNgYJcLhoAEA7ynkm7CdAoMCJ+tg0Y7ZAdSTBGRxXsYoDeKq+3cLfx6
	 ROpMA726TxcGcLfNkMctXKVLQCwdP2buWeNVNM1kLrSo6HRgoKM//dlJSWVozMW4RgVJV
	 vAgm3egSFhS5rR2va5As4rueTawaX+6R97XvLndNzNzS8j8HGBoDDZ0y8CPa43YVBGUfV
	 GOvkkT9wksenp43Z6/Oy4DhMfkU9Yqh888enwG17Plrt9CKBpvxCAJUfKHqrJ3tmn20N6
	 kaQrGWWToqlGTAVWgpzmEd1Z+oR4DMDIlhtvZZNR91otEpIRAtnmRELhQXymtBh1mew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505747;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NSfXFWf8JcC4Wl/PGk3pRnyx6Lzz5fGMZTDQWiSG+nY=;
	b=Vy2p0OBOJVAD6SCb6HldIWv2RaAjEkW75YcOL+0E+0FXl+en9pjOi4EfaHb7ppUdJ8DL
	 7Bpdf94Jim3swyLTwXsNBlbCjEAZIHT61qMnw4976dbV1Vta3NwiAs3isIEhld8pyeykp
	 Q/+f5SDOAxKwXCayayR+e1YqxqEVfTVtG3Fvt6/t3wNKMYK02jFs9xe4lGTjsOwEtKJgd
	 kk3gM3Pqc7ai1isgAqwxUOKn/alL13dGaDrvGLjd4TEV3kMT1eJWG2FQLs6VgAmA4osOz
	 Wa/oklZYNlDrd/qDB0isSkmzcchCq9EudGLuyT/W2iAzJ8XUlULE+cRwdogJnWTl2lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=F0HcMVzh;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=VFCuHF7S;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D7F606A31A
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 14:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53D7F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=F0HcMVzh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=VFCuHF7S
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 7E4F61D0009D
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 10:15:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 20 Oct 2026 10:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792505745; x=1792592145; bh=NSfXFWf8Jc
	C4Wl/PGk3pRnyx6Lzz5fGMZTDQWiSG+nY=; b=F0HcMVzhwPWVj5XUtCNEg7XvZP
	G7nPZAElF3qRWZ+oNAZ2gkTfVNSMoqkFn5gnXHlCrSsnMPmhJ5VVzLoD7tMC1ER1
	qeR6IaHkk2ZwtqXGOHsKYCo9epgWfANffITIDiiN3bE3yWbEZqWuwsO393i+USvf
	5zkx1xDUM18EWYxCFn42OE05O2EjAIpixpfhSepNAQFjpFDROR+XfW8fCZgQWKkx
	mNA+NnxXntjhnftHJfSz0DUZXXFTBGkh4b7sPSb3f5KNHaf5PDXxb+M2mmChoX0+
	+wcirEncwGufBOThGFl3hSCYUjjkzO5odxAgmhrJnD9Y69Hl9ryZNbWO6Few==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792505745; x=1792592145; bh=NSfXFWf8JcC4Wl/PGk3pRnyx6Lzz5fGMZTD
	QWiSG+nY=; b=VFCuHF7SxwgDiy+NPBej4l+DfBJHMxTlDk31pGiG34bak5noZYm
	5gmv9Zyad7R/FheQFWiuQyliuVjOI9gvj5HxzRajoJE/d2u9E2jQSANQIzaYst84
	N0TQz29OInW2Zz7gns295+hw9tYoI2M7iRWOYdiQsMM8pF7+EApB4G/Lmo4ifgrs
	NFN8d7ntfnnVpC9W+z6tO5crI7CXQRal7a6O3rfDod5W+n/hIDK3UV/7dRGtRfLB
	ct1YM+zboQhYBqwGj84ITalXYq9ypWN1MmUJz3PQpnk1N83BpyJZyyOSHIyJOZZv
	1DJDV/YuB4xqg6rHpUj2apQi80TZOUlUcCw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792505745; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Q2/4n/m0BUkkxO/eDbs/+ZrdqJ5zvOWEu6Zgeks36rS71Z6
	2r4u98NPXTW/X0gOt8neVxfz+TbAwb8vaLwpDdDn0e1zoPiCuw/xmfW6Ad99BJR6
	uHpkxIGvZJJrEgMSIFaXmT7C2xe58hNjPU7DYptXJIzUuo0lfgRcwZQhvJNgk9u8
	sY30nvWYldRTHT4027QqGf3hLA4H1o3uTh66txzeI3dQDo1a1PdE+8ND84c+dTK2
	+CzKg1fCOBzQDNv5EGCqG5IB1b88j1CfGBSqmyWqrGcn5Tm0JCYHLg2Vtm0d9nbk
	IHEWIx5eboEOE+WFmaBL3QlZ5hrsw08uwt4ELwQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:tzs80SXqbU1EENyke4zovkSeEMTfGQourAqVoBLtOA4=:i1I5d9r+KpwAUf8zgVYfGrmp3QkOPNiNia/aWXdaWLs=;
X-ME-Sender: <xms:kXfXaiGh3Sj1IvxFyxzSI6r7U9fZ24-zMyA_ZVD4unrTTgr3LOts-w>
    <xme:kXfXapXgIIa1yiMoAjc841ES8kEfwSNhG6Ivwkt2bAVwQtFewKgT6MCmF8YZPUh0q
    v0zP8ldsIL9tz9O3Pp-VWx2xdG15HNmaRqC9JuWx3W_CGfSVOM9BBY>
X-ME-Received: <xmr:kXfXapxzahkTiNjXIp5_dNO_t7fGyD_STj8o0X7cJlONfcZhZGwJivzO2OUyMb4xW4NOnQ>
X-ME-Proxy-Cause: dmFkZTFyoEgsLILxG4REaOy9kOrWO2uINkgNP9HziUDgz5FI/qhl4Ck+/QzIkPdKUA/hsW
    o5HnzGgQOUFE+mpLke/bkrMGuecMhel+nx0lN4spw/9sznrWA8cWmtEBL8a3MeGrYOzu49
    goaiLISWWADprNxefoPPQ/AsaMNwxjb9w1Fsu3LTln+Yu5UEZt2YzfhiIIFB63pgcRlVOS
    ScjdS046RStuXNL1Zk8nG46LKc9Z0wVYd9VKyxV/1a+EWWgqnp7TJC35Pqf13R+gMPnU3x
    9V4INNcuc6zoiZervCD2FQfPXzT7idi1fsbLSurlCFInUjRwGbEO3iYweQZJYdTV9wmfPc
    z6+siU4kZM5x1DGePYBt+o38rXAo3g+B/gDzx4h2QXepCRj3UBRyb5MrHsoVKPgUkAqNM1
    hdSPW7pNcEy9Nz5pBRcjyCb3PjW9PtF/pffEECF5jg8032hQR5BE2zJ0rMdknYTQ5r/8NK
    FG6YKbN6OSpFch3x7sXCyPevNMHmlPbYnF0jTuMzXgfgTvu3i0FYuQMYYNTYd//9VQ3rmS
    ijq94YTI03sHSrqk1kJFoJdbwdqaCQGkNFPMFFauQIODkCjG7MJaBbwNBmGT1chguRh+Xl
    IqRzxQGiw/nTy56Qqsrj8mpZJWtOIVT83DKNleq80GZgQqvHQ4rXMBVvAGxw
X-ME-Proxy: <xmx:kXfXanOq23l08Lg2y16C_bhZWN92nMEWCco3GwC1F7Vfub-2s3RxWQ>
    <xmx:kXfXaq5idQOQUrfSvQiB-Oj2XFiqvLFFlxlvvJ4mrMoFjUTCvpZW3g>
    <xmx:kXfXaoNDo2kaP0OO6G-G6smgHkwO8ZQRIURsoZbVL-Q5jJxbNIUTBg>
    <xmx:kXfXaokjhFtvJ7mTNjln6arELeYS0oWzQRXOcUY7nGumSiWGbcgauQ>
    <xmx:kXfXai0Gukrw6__qkCUSmb9mu923ZpOVxbRs9fzwiDsyYLJQ4pWBpZI3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 10:15:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f795762f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Oct 2026 14:15:41 +0000 (UTC)
Date: Tue, 20 Oct 2026 16:15:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] object-file: fix ".keep" lockfile ownership in
 ODB transactions
Message-ID: <atd3ioVos5paeT6b@pks.im>
References: <20261016213716.593278-1-jltobler@gmail.com>
 <20261020132900.1208343-1-jltobler@gmail.com>
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
In-Reply-To: <20261020132900.1208343-1-jltobler@gmail.com>

On Tue, Oct 20, 2026 at 08:28:56AM -0500, Justin Tobler wrote:
> Changes since V2:
>   - In `write_pack_lockfile()` the error is now explicitly assigned to
>     `ret`.
>   - Removed an added newline that was not needed.

The changes in `write_pack_lockfile()` aren't quite in line with what I
suggested, but I'm not sure whteher it'd really need a reroll just to
fix that. Everything else looks good to me, thanks!

Patrick
