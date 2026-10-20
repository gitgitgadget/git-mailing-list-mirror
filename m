Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486218;
	b=TUrRx1xmmh28ELoRKPUHs6ArsAIobS0908DcosQo3fTxOVm0ZMeOn/AKfi1jU9FQgL97
	 1sCtZQ/0Q8j+HDGs6jRnxq9eKYl77xBrJySqfAHgldvz7zagHLpbGj01jeVWqoatotl+V
	 lSWhBM26VsOpH5R1VwCsXMiVhaAgSaW8kwZ/rJ/zc75LjAv7yas+rg6s4eOVIUzhj/b3H
	 3r6FBHEbGc4JSNV+3xFwz6CheJu44bR3i9cDighaawrb4y7cq6HtcotJNho+VEqbrdLYl
	 MAKryqhORK5rXUtzIOJQTVcgUWGDFIQvmF9AKaCuIgUv6rNOu6Nwi1j2fmDYgfwMl5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486218;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rGt6BSU/c7J0scCQBwodE5xjXwktSrsu2N9n+1V6nh8=;
	b=PJjrXyUybtDnYHZCXQff1VtnBGtu9awNSShl+ubVJw/gHS7S2Z/zeeg85gxhgFMAjFPZ
	 uefgt1u8uXkGZq0qa1UfptY3o8KLG6ji88xEpB+GZu7iEWtQlA+GEhlkVqxEwUgk5tFC4
	 uEoOkti8z4p5LksH6P1Natz+U3Uf7vbE+HtB06KromYoiLjz3ZlHsn67sGjIJ4QPSPtO4
	 efG678lm4DjQA4Pg1Er1D2ZVLW6VhLhJ9gSWsFDdmY/yxgjSZJGX7f+Vtug7Eu7SDvplr
	 JPt5JwPH9DRo6qccQ60DRPPoVKiaueFZ5mjLqCqY5Usf6OL+shpc9aEMzwN8j+PBT5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=BU5IhPhu;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Ueffws0l;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A212E606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 08:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A212E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=BU5IhPhu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Ueffws0l
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D627FEC00C9
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 04:50:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 20 Oct 2026 04:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792486216; x=1792572616; bh=rGt6BSU/c7
	J0scCQBwodE5xjXwktSrsu2N9n+1V6nh8=; b=BU5IhPhuqG82Xol1zXMhTPISov
	NpG2EIxJyjxzvLi5BtUzxD+8ZFzYH1+MwJN90f3mVnUa+P1hIqvdXfimxpWFwHcX
	I+iHbnrc1EGtyQVFqzv5KeeWMvuU9nsk7gGcsq8QT3Jgci2+AuZkCb/VnL/PM7/a
	puzPEIlRBSo2BpwdGqEbPDuN2c98HVXO4XCUSEZvUiQZOdFcbmfK99GiZa5EVYVn
	VhZX/YeTDpHf6bcQfKStAGI5hShwd9+KU8qPTGCJYChl/a39Rq9+oMVNvXypjec8
	Rmfoe6xjILxtZLK/C83GPDmKg5wAKOr0yXK49BgB8OxF66ZSoKSKE14Zak2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792486216; x=1792572616; bh=rGt6BSU/c7J0scCQBwodE5xjXwktSrsu2N9
	n+1V6nh8=; b=Ueffws0lN0MQDmeq1UKAJaYsvB8tWzQP2Xwzv+cL6E7yI85km5y
	ZMiR0oG7YAJESvl03loGHvSv2f1a96fF4bgmvPvjxxJk6BZDcmd37W8S41ySb6iB
	+eOBgVVhq20gEO+ITcG7RtFH4Xu96Wd6Ma42GmZ6t0VDtMIR3ZZFoDkUGweXsS9z
	8BL6m57bdYlmwuUJLuqVmSKUKPX04wsD21GBKGemW5GLe7Yqo82ZlC2sxJGc2DJK
	ZpJPVSn462j/dxXgzN5OiZBmZzK9WdzW9Cd9e9tCW3dtjGte8d6IUs3X7CKOrqXD
	qA8TTsZEBti3a5hlXgVSZrIEjU2sTEgKznQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792486216; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:LTsshcLazZumdVIfb9h9FXFW1EysNIIQPpCwABM0fcoIu3E
	Q1dXEv5I2qyAy1JUNPHKvNbbsMGZQPra181ipe/5Uvl1+GQUfIT0OVHW21r+b8VM
	gYIcEVZaLe5wFln1aJcawTL6/glUCNqlkOdJqjPqvItOzEh1ajcrulgxmKY02I1f
	LenjpXob+m2i2IDCKD8PNfzWh1zvetDqpj1uXmDFxzlDRO5cRTDI6BmDyfIGRLI9
	/yJ+tTwedGVlc3PoyJNE2KKR+PTkBZJtbr1BL8+7F20t68cvs6eaAsVcy7g+zv1s
	jljp+H0eQN7yvR0ZUOHhqS1Ivi2kaZK+444ZnfA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:3xn1OxAHQCIgl9y4fakrAP6h/XOfcugVF1ICgw+Hgyk=:ltt+sd3/7T+zEor/MF075hl11cKn2IZyGWneEeUOvus=;
X-ME-Sender: <xms:SCvXasOjWOJr59opgTS3ZoTOgyU9vfXjux_95fdcRiI6CxnCwhq5Cg>
    <xme:SCvXao-LNu3iZ7qhKBBBWO04l37gWCzMxSoTT76gETF9fTi_PMV3hEhBxgLg3HXme
    hzSkclNW7VopuGbFMuLsErQ4n775o_H1OTM5fMu7mg6z91udx08zA>
X-ME-Received: <xmr:SCvXag7cuN-CeA17niYBlfln85uxHiKUtvEWF9dVjbLUOYqIv5DL6x7NQsg-YE1SVOru8g>
X-ME-Proxy-Cause: dmFkZTE4XQ1v/Rr1pHUzEfSx8TspZmlwRfaMEvERo2uqOH2w8HhYI1XifvKfsmqkiJdO0A
    HaH5UbkOFX5GanYPHoPzlMi42xWN5Mp/vhP/fsT9dZurZh+dYhtXz3Ya04O2n+TULZoIEo
    7qS3l1eLOr5KxAPuvnVgs/T+rvI0L9/PrPGT6PzYX1PExazjCP91n6Gy0Phr84WsqTCT6f
    GF7u+3s9mRIoFUpOSTZrC+WsI5nKMFGRe0rJmZY0im+q0CuA4jLlO3Bxj8Fb3SPY8wtNd6
    KxMHxlOtpIiszvEpNZElU7igzLW04DJnL5AcYgcXq5bRsTc9MqW6PoIG6zfoc0tRV4Y2iH
    zXZFMeeS36j9ypydT/hXAhWSjkYU5F57gkT/cnh4vOvVjmpIzL34qb+ZbJPrhKasEhSk/o
    XUwA5FGeTsIAyXeym6nQoLJvrs2B+CTIs/VIGLrZmkKEFLp2zkV8o+r99bNT7uOwY4L2g3
    njH5P76I7CWH9YynOHtrALHoKYJrfvlIFyhaugYGD9Cr2vS8KT67EiJtTOtWBmjmRqpJjc
    7bg5ugbjZZPDflCq3fqsxKJEjKryjU+1Do76u3RijnOHGcI5xkywJoaTg3vHSuoBoL51PU
    2JfNFrapbqNGo8mTh4iW1u7Kyk6sibAixtz9gevw0+tU5CAv1Ca/A+ma1vcQ
X-ME-Proxy: <xmx:SCvXav2OLIALvkA7m28SzqlvCRfWz_JIx-4VlAehb-5S1KYbvmz4ow>
    <xmx:SCvXanCtcrxsJBsYIlRfVcid9CGWFKyA7ksB5qG5dwLTB9jrvsYAbQ>
    <xmx:SCvXah1kfuVfU98AAkBNs9rzNMKwnnux5MTPWzC7_txyeltG8vwcBA>
    <xmx:SCvXahthE5HcWFGGv_CTz2b238nRKrsx-odI7FN8aubgUb29Cvcscg>
    <xmx:SCvXau_i3MpyB4FdYmo4AzGn55dM0gND4PCAKDaJqrconj1-u3dAZwAT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 04:50:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4ec2a6fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Oct 2026 08:50:15 +0000 (UTC)
Date: Tue, 20 Oct 2026 10:50:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/7] builtin: expose the object storage format
Message-ID: <atcrRWX2-S9374Sy@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
 <20261019-b4-pks-odb-extension-v1-4-143a5963b77f@pks.im>
 <CAOLa=ZQ1E5sg05++KCXgbM9+=4=vFeCHU-5iMbNEGRuS-8+aPg@mail.gmail.com>
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
In-Reply-To: <CAOLa=ZQ1E5sg05++KCXgbM9+=4=vFeCHU-5iMbNEGRuS-8+aPg@mail.gmail.com>

On Mon, Oct 19, 2026 at 02:40:31PM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> > index cb8c1e7292..d2dc9b7a69 100644
> > --- a/Documentation/git-repo.adoc
> > +++ b/Documentation/git-repo.adoc
> > @@ -105,6 +105,12 @@ values that they return:
> >  `object.format`::
> >  	The object format (hash algorithm) used in the repository.
> >
> > +`objects.storageFormat`::
> > +	The object storage format used in the repository, as configured via
> > +	`extensions.objectStorage`. The valid values are:
> > ++
> 
> The nuance between `object` above and `objects` here is too little and
> can be confusing. But there's nothing we can really do here.

Yeah, I'm not a fan of this, either. It used to be even worse than that,
because we had "references.format" which was giving us information about
the backend that our refs use. And that's why I recently sent the patch
series to rename "ref format" to "ref storage format", so that we can
avoid this conflict here.

It's still not perfect to have both "object.format" and
"objects.storageFormat". I was wondering whether we also want to rename
"object.format" to "objects.format" to at least have the prefix match.
But I shied away from that.

> > diff --git a/builtin/repo.c b/builtin/repo.c
> > index 84e012f83f..da11a56ede 100644
> > --- a/builtin/repo.c
> > +++ b/builtin/repo.c
> > @@ -128,11 +129,20 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
> >  	return 0;
> >  }
> >
> > +static int get_object_storage_format(struct repository *repo, struct strbuf *buf)
> > +{
> > +	strbuf_addstr(buf, repo->object_storage_format ?
> > +		      repo->object_storage_format :
> > +		      odb_source_type_to_name(ODB_SOURCE_FILES));
> > +	return 0;
> > +}
> 
> Is there a reason why `repo->object_storage_format` won't be set, I
> don't like the fact that we have to expose the default object storage
> format outside the repository and odb subsystem.

Hmm, not really, and I agree that this creates some awkwardness. I'll
have a look at whether I can fix that.

Patrick
