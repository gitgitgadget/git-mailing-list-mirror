Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404448;
	b=U5YAPjl7uqJ7RFCnx3jJaRHfu0qX5ZFikawoHa+2gEeb38GoQufqoL/04P5hw1As+3cz
	 6UbMc2UzfVohOywtyd7+ybX51nxLsYxPC6mMQlsdS981O4oJ2DrB0HD3iSoRVpu9enAQl
	 Te94/JLBbSPXr6O95kEDvQ7KeZGHYFOcJlmzNc7Rk8tirwZkX8chItWOZ8fDB6K7R4aY1
	 QtufpJ7kUIqMJEgvteJv2YLH+UURmueVlQ2zaqA2Vg37Fygql+SK8UuATCUX01H5g9yqi
	 liWoCpLvuA5HJzzE0VjIP/ICNXyI6iek0wp2wRzPCb2djJiSlG64UwHVfvOoWflMq3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404448;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QZ/kxv6y21rLpkEy/PDMopZb0OEFWa7lKaEQp3wzl6I=;
	b=BUKKECIrYXLtEr5lwMF/beCXEMkQLaHp2fGWExLmXwOEKzU07kXehjFUML6PC2OfJqDR
	 DvpfuaV2pKVOkAIVaZ6VcujP5mh3Cl+cKKvQ2rMc5TLzvMhFgVyYeN/qF3dnhU5m4JJhb
	 y1K4Zm53ZNJJCUymySZz70g0GCPgNLHNA2TOECntkioaUvYoylPkZ4zhPHgBVDKpfO9ts
	 ACUE9cjFagiQimSDbblcoHKWunkatQCRcSKPyQbg8JqC2e62GZLvgysNhlyLdPxlyBqPv
	 65Pa5NzjuxA1zN2qXd5UlKtEkoLR51WYl809DNXfCI2NMA4nG3K4kW2T84jMg6fxGeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=nxX7rwP9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="KMcavq/V";
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAAF606A31C
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 13:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DAAF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=nxX7rwP9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KMcavq/V
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A80931D0017E
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 08:40:47 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 11 Nov 2026 08:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794404447; x=1794490847; bh=QZ/kxv6y21
	rLpkEy/PDMopZb0OEFWa7lKaEQp3wzl6I=; b=nxX7rwP97nFdlblWQfzvTHLkTv
	qiC6CHXgHzHhfpCZHtggzlU4jvs4L4Y9kkLvENfJeRngVpkEAbS1DLrvAMKf9FCI
	kwUFj2TpkAr/F1lTLzNyzrvpV2S4zURsPEmDAuzwwyWOBIjD59oiRia5XT929LK2
	TgXfbV8vZkBmsupmhgPDOq1tUk9vfHS+VA9uo2kwO35r3oCXz2SfIbQuuNVywgVN
	obBzYFYZ2kx8JmoBMZiLXPKr4z4wEEt9lVfTzrl1Y0FxmVqGTyiAkKj6i8Vk5nyz
	1PDA+TsonZiN6pLevV1Lm2w8d8h4PHFSaH/EPhUz4CJIQODNZ31ZGZIXovQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794404447; x=1794490847; bh=QZ/kxv6y21rLpkEy/PDMopZb0OEFWa7lKaE
	Qp3wzl6I=; b=KMcavq/VFxNT1bxzePJPrzJQLF7Q4UsAFk6Q8LIrgXf1BIxhzOa
	yYc2k0TjfFVjCzPLz40FvhXA/EnalF3Ly8oeZ3PTQDqskaY6p+Q9ZQecaOwTPCqL
	oqZAfKAwDPdbxL/4OD7GFePoFYSKM/Fu8aL2xGjryKHTson4mLuNpzuSWuDN6h3N
	BRCDBmsUoZ8r9cIlcnibMy/iVjeft07E2bH/BGun4BKnkU1nqaFu2B9THhbJXloa
	TDrr1YcwgeGxEPIipGrphrwndzioQLeHyIec9gnhKriuCP1Bx+u1wTNiglUcGICR
	vYj4SByz8ZP6HlM2Qz8nDfU1O3A2jpko4PA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794404447; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:qIZtinRkKP8iDLvEFBGYgO5GFxmnE39OD1U/ooTcwJqhO8x
	0uQH1STPHG0t59xwxu3CyvhOSBwPygTJSEVrpcglnMQPeCx5Zfu07/8bIkpG5Ore
	yHpi8uVNYGyCPmEf+bhqoPPC5/05sfu3aEKGdnsZdUba1wTgdBYa9v9r/86ERMer
	a6SM/DC5uVfE068Xlsaj6hVvJ41yE9ErHLhxP/lRCyHvtQG46Kc2+vLoLK1xwrIf
	CA7cJxFhGvqz85Ge64RVwR0S3FUdjOJhrA39Zql3ZtPZepRa0iNppQcjxkYp0n5O
	fgOtOoA65Kr/15iwT00CIO1RfBCKA7EfPmKrIDQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:qOCPS/itTMl/dJqwJY8/E2udLRAiGGytAA4+Fg2MzAo=:HvsbsFkpZH0sabB+Lk3XjJB188e4+5UYjVuKq/Kipl4=;
X-ME-Sender: <xms:X3D0aoUaG9r9Wq_g01xOuRJ-tCKTaMJGkcG7cHtmwi1wgsQoY5WSzg>
    <xme:X3D0ailojdgyCbruh1dCU11en7ks3Rb6cFSrWZX0BxQQqPGiAiElkBdY-JoYTcWMd
    v5l1Anmk5n0NJfMQR4EWvok1JO5aqa0TtrrRXTxm3YpBwA23SDwVzE>
X-ME-Received: <xmr:X3D0aqAl3wdTeqRlehv-LPjzIr0Tb-lzCeqPyjrXP3hmk3xORsSzQZkSuHlXVmxE-_aKlA>
X-ME-Proxy-Cause: dmFkZTEiwoLOlpwBOK62i37tKO98qGO65RGavbuMfi9S4rZlZ+FWZk7YzNg3xiVe4FBWOe
    JyszsbS+tey47rasezNlf07tfgECOzw3+MHyhubS/4/REAAuSYI4b6S4rZ8sOl0afK/pfO
    ieo+BIkoeWiroSwVQDRtmIueISmqy4p7ZCGb0PJFuYYlrH9aUSSX7gwNbHcgRY/ltVO3up
    rG2TUyu5w8HbEwz4K4BouKy4DVNsvbBYSMOG/e+tKlcpQ1zpvLhPv26gRf3km7gUxNaXlD
    iPYBSWwkh3k8JtFvCABcODe2TJPj7cdjX80SJd3El9zAAvr3nnDKMG4ZIhImCbUkBSFBaH
    c4CNbvbKv+N8sHOwG2G6Ylr7FGSJgAxqCbD1Mexao+ShgE2yYWWiXyOXNuNZXMo4J5BmUG
    6YtKAmCzzfkcfteTkD74ti7p6oJrnjdwkDt7SJdc9z5Ds+SgCZKCFFaJcBtL6WNx5OklI1
    HYtuH7BjzTs/HvqY4dM/sH6omealjfYgiOerBE0HRAjzh9e+lp1ykMuYL4CehNCtgZnnBM
    rfa/iN3YpEitT3ek/ARF/0cemaGS7/gTpDKsOXkZ0KzpvqyFyFAWXrWuJCwRnuU33jH4sb
    CzLnCjwztyMmiq1r2mIe6fWIO9C+XhX1sCgPlOLdLcG2BLz6dJtuvYhL5++A
X-ME-Proxy: <xmx:X3D0aicOK20Oj7xljKHEh69FOK2boEf9kQexsloIQfoz93Ymqqy4WQ>
    <xmx:X3D0alKOxvECalczHuQtoIWp4o4S-fN6C0A7reQBBpApfX-lVx_uQA>
    <xmx:X3D0alcwmEKykWGvzNIvJTq9r_UjYNpmCpojrHQKdELNzlZkYyxlBA>
    <xmx:X3D0as1xA_QA9feScQtZK-_b2seyg1a24nBrREEmXtkhFTpFNremNw>
    <xmx:X3D0atF1qa5n2QKot5QYvTIprNZsQzZiHQpn8KzlFxfBR7QHCvMJx-0o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 08:40:46 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cc38305d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 13:40:45 +0000 (UTC)
Date: Wed, 11 Nov 2026 14:40:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/6] odb/source-loose: deduplicate logic to mmap objects
Message-ID: <avRwW_Jy2lsNih89@pks.im>
References: <20261102-pks-odb-loose-cleanups-v1-0-fbbc86c29693@pks.im>
 <20261102-pks-odb-loose-cleanups-v1-4-fbbc86c29693@pks.im>
 <9794ae30-d6a4-478a-aa25-88f8d9e02810@gmail.com>
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
In-Reply-To: <9794ae30-d6a4-478a-aa25-88f8d9e02810@gmail.com>

On Tue, Nov 10, 2026 at 07:45:58PM +0530, Kaartic Sivaraam wrote:
> On 11/2/26 16:50, Patrick Steinhardt wrote:
> > diff --git a/odb/source-loose.c b/odb/source-loose.c
> > index a90268e200a..5cd679e802c 100644
> > --- a/odb/source-loose.c
> > +++ b/odb/source-loose.c
> > @@ -544,28 +544,11 @@ static void *odb_source_loose_map_object(struct odb_source_loose *loose,
> >   					 const struct object_id *oid,
> >   					 unsigned long *size)
> >   {
> > -	const char *p;
> > -	int fd = open_loose_object(loose, oid, &p);
> > -	void *map = NULL;
> > -	struct stat st;
> > -
> > +	const char *path;
> > +	int fd = open_loose_object(loose, oid, &path);
> >   	if (fd < 0)
> >   		return NULL;
> > -
> > -	if (!fstat(fd, &st)) {
> > -		*size = xsize_t(st.st_size);
> > -		if (!*size) {
> > -			/* mmap() is forbidden on empty files */
> > -			error(_("object file %s is empty"), p);
> > -			goto out;
> > -		}
> > -
> > -		map = xmmap(NULL, *size, PROT_READ, MAP_PRIVATE, fd, 0);
> > -	}
> > -
> > -out:
> > -	close(fd);
> > -	return map;
> > +	return map_fd(fd, path, size);
> 
> I just noticed that map_fd could follow the goto pattern followed above and
> avoid the redundant close() call. Something like:
> 
> diff --git a/odb/source-loose.c b/odb/source-loose.c
> index 737d583f03..4ace94084f 100644
> --- a/odb/source-loose.c
> +++ b/odb/source-loose.c
> @@ -532,11 +532,12 @@ static void *map_fd(int fd, const char *path, unsigned
> long *size)
>  		if (!*size) {
>  			/* mmap() is forbidden on empty files */
>  			error(_("object file %s is empty"), path);
> -			close(fd);
> -			return NULL;
> +			goto out;
>  		}
>  		map = xmmap(NULL, *size, PROT_READ, MAP_PRIVATE, fd, 0);
>  	}
> +
> +out:
>  	close(fd);
>  	return map;
>  }
> 
> Of course, this isn't really a show-stopper for this patch. Just another
> relevant cleanup I noticed.

True, but I'll skip this one as I don't otherwise touch `map_fd()`.

Patrick
