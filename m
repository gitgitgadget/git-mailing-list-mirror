Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793172903;
	b=fmSJMx98QN/KJWS24EHdP3b567Ak2RQucQ8fafqVvZFDKuYZV0gYD8ipXtY3+rrSG429
	 nrAj0gUPbHm/zK9wNVW9iVtLye8JPa1PQl4rOz8+6j0VEjNViQs+p9RGw0/cr6wf848CO
	 Mrjhq9CdKVkbubYxnh5Mklgj/mzTIqrZyilhXN6/xfe9pOUYG4ETaFYDWQVMNyk1jzCRK
	 wBzU9Dji6po2mGJCeXpaa0Kk8D6+lflAXxopOlTuYONu9Y8G8dujekXa9ZAjNZohINcNy
	 4oIp1ghRae1SsDcwIkyVhMDwgcy1e2D2EBZyGYW1EkpjAG/ocQflJk3nZHp6/BwBjeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793172903;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=xNDdGixs30gcs1i51/ZErV1Yb+1RfgkC32dR+PgQmoE=;
	b=nwU5RsA0syzZ+PbgQYlshYL+AA6mtKMiS2OHaxx1x++WT1CW2JJdt39kXoaOgU3vi1U6
	 XwPohfXyuthGyHs7PM2gx30dOpDtDj1ENnQWvUaGnL47iZv256z4pdtMUO774K5Y1GdqP
	 y24uPJOHDpw6QiWr4NQTSlQFwySpsGJZRMmqYfKe0CBoBzCx7vZhyNcXwH0eAVGJZW0gl
	 Nq63Oq2lgfx6M/GRXVaaJbVTrOQpzi3X9bzec4gcrVeE43SiwpkBZ4y9CpmkgMKSCgWI6
	 0PfuNyM8/FIz4q6wi7+CfZjWgcN/+LMc1bHh7CVqX5Nd12b84NmzOW/uGVIfsXDUD5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=sSVivlm2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=TpIaKIYU;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA2E606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 07:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACA2E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=sSVivlm2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=TpIaKIYU
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E6AB77A01A8
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 03:35:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 28 Oct 2026 03:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793172900;
	 x=1793259300; bh=xNDdGixs30gcs1i51/ZErV1Yb+1RfgkC32dR+PgQmoE=; b=
	sSVivlm2MswHo6DWvgVaReFG8zhSOpbkeORgB9pvn7R5JpeTPZ4cvyzSfGiUyest
	PM6pdt9pMrX8OZI9/FObbJtplmjP1nxdEkI+gtn+JDrS29d6DquusVCQiy/iBa4/
	/M0dRv3v0/fs6UkshvS6Da5YH9R7PaPWc71vvE/WX1ARJ/87IX2CpO4RF3u6zUHF
	hsljcXrZcqJfPPtr9MyNHdS7SMiw95vI4J+61Y2Ru1nFSkr3y9c1F/D9/Ti2HWQg
	8VImUHtIF6lDRvbyb3WnvyeiPJtF5lbt7R01ZvT6y1fP9no3+dEVih5FZ5ruxGCo
	XRSW1QHCUvmSOp3le9ZCiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793172900; x=
	1793259300; bh=xNDdGixs30gcs1i51/ZErV1Yb+1RfgkC32dR+PgQmoE=; b=T
	pIaKIYUQn1c2asPQ0HaTvDyjm3QT2tpWCwAtcSaNqPgAi8fc7SsAL1hjCNOrFQKa
	P48K7sBJANaZ65vO/jAKQ+ZDZwAIy6PSt2/0JygcmOMmjnLOjg1/oo/1Vg44HkFk
	9f5q+zeAX2VEPqd/AqvJuDA8JY2+SIZ2YgG2fNw4ALSkjchLf9sYDViyIdi3/rUA
	tm2GD9z7T+v4CEVpzEaGr94o3t9rk0qiJKlQDGWtvJ1JQCDZsjwz08k+bsDN91Qu
	3Qk+3sPapBzZlevnSAIAGz4wGtmSZ9e9HN3CSKwO8uApXDn+VT2Ke2+VCiKR+6Cm
	UVLLsH/Jops/xgfFaCMZg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793172900; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:k+I9SO/um+pFqAbpH3Vb/gL5ww8Q2tpxezNIrkWUcGi5LYp
	QLz7p9ALwVswiA/hqD6+3pAKUV6rUbRpOtZBdQWlpFLc60VBT/2KU/34hVp6uIze
	teXsetSNdhfR2ZEvcPq5Pz/Kx3o21wmEABiS6rC4ssoyyV6qk4cNnj5vkyjAFB4b
	2uzoXDzweEIWkJou5igykU7HUdkbhjjTMWrwUyWklqlXzqG384wGlwV93dOmhRN7
	MHvofP0ZPD8Ib+mu99qIIPVeBFwYKSpbzsPOuotRjPP5WxJVo95WsL9hu2Q/1wgh
	57I9Zxox6RyylH3ZQv7YAMQsmTJlkidiGe/9JXA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:zsTgoCUww6Wr+P+VhyNOe0VDrARXRvOe6p7thtqGyuc=:RZ/unoqOfKO1zhakSePu0lifclmdDHM9U6JQmhlrPtY=;
X-ME-Sender: <xms:pKXhalxpiKYdz-4cWO-IzFTYCVJUPG1WfZ-K9b3SounvIUh09smMfA>
    <xme:pKXhasREvMJMB71Cfe-Gi4WvZOn0l1h2K-m6GLytvn9ns5_qzrVXvpFyEnp3q1z5D
    ZuaTCgfc3RvYEJ_7WW6jlm78oEO2sZcYYaumTiKoWYo3Regp6GlxKU>
X-ME-Received: <xmr:pKXhakVti9rH_vT0jC30Oa8RzP86KNK0g8OTmc8tKNTbMsoGzUlf6w>
X-ME-Proxy-Cause: dmFkZTGeNaWO1aBrgvQjYe8aXpzg8+0n0J9tguJT223e94V1yytR+iI4T0Q4Pricylj7MX
    stuPchskJbV8gxM5WUHdSJMDGVSyllf19pKFTyUeY6nOWhq3qVXOaJOuzIvt7Wi/LIAUNo
    K65VTl7GHpHpOj/6jbzyk0tFjcr/1aakFcyc8//KHxqdozYFXU1BpcuckNIE/kWD2YxCpK
    uRdEGXfYHSATJ7QeEmX4NVJilYlVecqUvzRS01pOE3rAmEA26EGv9ONdUDX7ScP/WoHR/M
    8Wwc7LfzKKPyYcQUpbj0KVtnJp9ALxx7WuvWF9JLBzh4CSUl8mh5btcmT9cVRYQtk/bbit
    i9UbXBOqOwUr4eiQL7B+xWiKBEqO4logqF0l/PlU1QrROS1gyMfaBLVTmVqpJeLAVIMlvQ
    ZlILukugG7YF1kghKcyajyaKwhIygOefMGw39VCKTcRD8TfJ5jE2h2q6PV2KseYpyT+VDR
    V1OmqkrA5C4vi2JYc+z6LGmzn4JGo5bC0quWsVXG34OW6EZi8jVXgQ4YAEZ6TrFpZOQr6X
    gzD4oxC6GO+AGLDO6/XYRm8Wp6vPuhasch06ug0Pu1yLQ0EY8jF4Gra+Qmj++WW2qg1WYW
    5AO1nQeH+VDF5k6WzZHAf6iKKh6DE+Bwur132yKmD6OBL4cUWFj87f7UYtxA
X-ME-Proxy: <xmx:pKXhamaSRbxgO-gY9wZK5iQOlpVaBw9IHSHl6zLjjOKNBJBYSPPjeg>
    <xmx:pKXhai0vcMICCuPMBV5h-ySk4E2ogInknaV7b54WAN6SRhp-qzb9hA>
    <xmx:pKXhagjSOGYkv5h_ndFW0nyFWtJMSFKrXMVhhitF-mpnfbq4rFLq4g>
    <xmx:pKXhauawL6peSkshOzqLakSQ69L3T7w13v4GOi-1X0d-NqIKEmzFQQ>
    <xmx:pKXhagr0LbqNwYRv1vNnUgmAGwDRHv90omdixLF_CHh6sfmX1HAq3O5B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 03:34:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 56d63be6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Oct 2026 07:34:58 +0000 (UTC)
Date: Wed, 28 Oct 2026 08:34:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] Makefile: let ccache cache objects built with the
 precompiled header
Message-ID: <auGln4usFADtcUPB@pks.im>
References: <pull.2464.git.git.1793104847288.gitgitgadget@gmail.com>
 <579C36BA-1418-4E15-9CA7-70C752A69FCE@gmail.com>
 <CAHwyqnX3sR9YxfK3NtPxVgmTfzfbgXX2bzPKzGGAbfC9k1iF4A@mail.gmail.com>
 <CALnO6CDpsQtAX0rHr9Cuot08K4j_6WMpiPOKA38sjDbWB-wj7A@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CDpsQtAX0rHr9Cuot08K4j_6WMpiPOKA38sjDbWB-wj7A@mail.gmail.com>

On Tue, Oct 27, 2026 at 05:57:38PM -0400, D. Ben Knoble wrote:
> On Tue, Oct 27, 2026 at 4:00 PM Harald Nordgren
> <haraldnordgren@gmail.com> wrote:
> >
> > > And, what about Meson?
> >
> > I think it's not touched by this? My goal is just to speed up my local builds.
> 
> Yeah, it'd generally be nice to keep the 2 on par though ;)
> 
> I don't know enough about our pch infra, though, so I'll bow out from
> here. Just thought maybe we should make Meson do the same?

As Meson auto-detects ccache I'd think that stuff like this should
rather be handled in Meson itself. I e.g. found [1], which feels like
the right direction to me.

But if somebody wants to implement this in our instructions meanwhile I
won't complain.

Patrick

[1]: https://github.com/mesonbuild/meson/issues/14662
