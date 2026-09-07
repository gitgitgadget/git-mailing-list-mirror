Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656C23AC0C3
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792481; cv=none; b=l1JjouXaZvHbiiuH6n/gaBNHcslyztWdqzu7l+Yc3QO4J8xFwGPO1nlY9EGNRDZy0ljZNxtbFi/6cmQD4TXw9rNMVAf2V/TWnd7b932xKRFsYGPQ+1oaalI5ZoCY4lUK/KqIrXhDmbzwWdAFn+u3CyJGhElVuayk5ZzXKAwRhbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792481; c=relaxed/simple;
	bh=OpOciAB0SfhW4CgbTGJXyUWeFXU5GUWLYfgTPVvIUSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8Li/1Se8ZzVudAm7AV6bjvbbwJ8b9fQE8EAl0t3BSBnGbAP+zFZvgUijk0HrRwRyCGNE+6k7W3WJFR0v4x60T0BrPsva/oBVTxIaAb+McZih/WYm3ksIoi+U7Zrcgv6YMTyuFe+hkg62Ih1DB6yjRPm2NnS2T+sF5tFA5DXWrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=xzxQf4OA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uv+rrPxI; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xzxQf4OA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uv+rrPxI"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6A5757A0086;
	Mon,  7 Sep 2026 10:47:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 07 Sep 2026 10:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788792478; x=1788878878; bh=aAAh6q5tBi
	25OVbh+hUMTpiQ146Htt9vb2KOBJh7w0A=; b=xzxQf4OA7gG9unu4OAhDLoTijO
	O2yX0X+JBSCeP4Iu+JTQivrAg85kX5YsAmx2dZ/F/aCPvaJS9iKpywosLE57OQt3
	aHOcyP4wW9W0RUpPjhfKA/ofvpbkgSdLhJweoVgEWcvA5PePzC3uhihsaO0yEH3h
	5PE5AfC1DJ+gCFy1gOnS26gl5vC7NC2653OMBAjsFLO3u5rCZSvUytpm19zRABzl
	NXaqXH25/C0YOLA6+zYb3GrEqnn6YKtorXlamNj64soD+8t8S4AVzGtdsjRaDl32
	sfYNqxNIkM6eAn1NBTIaSm0js+JP7PV1CoEHlZl+rc7I+vA1ja3gbM/nkYWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788792478; x=1788878878; bh=aAAh6q5tBi25OVbh+hUMTpiQ146Htt9vb2K
	OBJh7w0A=; b=Uv+rrPxIx3PO6Y7q0HkOxNrddpSEbimdS85mHYvpZa6z6T+o3ju
	Hw72e8ALCJ5L1htzYFgXqsBqSDrls957JEYpF+Po0t3ug0lbPULAqOLwGf+aqEpA
	aXns6NAk35KaMBnSZ3XW+1z5J0vsySelkjL8KLjqkibwY7/n6GQpKjR5GuGD9wj0
	FMZyGRDB3Y71pYuXzHLpI6ER1BKhIVTCNc9GlmacucgAajjT+uwqi9na3y/3BteR
	vz55ItvgeIa2WdOAjxU8lp0xRfO5Diy3CTThZZiDxUA0THGZR2XMBrUng9JW8yXL
	t1DAs8RP6E6crQYqewOCqvOFcdt7OsH6rgw==
X-ME-Sender: <xms:nc6eanQtWfTxY3Nj3gQ6bLYSf9eShgaFKtIrWRQLXRKzYEDHpP3-Dg>
    <xme:nc6eaiECrIs_SeRJBTIXiX4brg5ckacqiKD5gIYrDB_YpgZl-ykIkUR3sn5dbtySI
    NcuUbJtLY4nEXD2OKNW2fe8MhHLRVGElVL4GghNs0eKn3lOaoIaOm6b>
X-ME-Received: <xmr:nc6eakFdCP1yqpGodDHylvi5KTQzvBoqpYNvL8ZxsB0TRDs36L3OeQ>
X-ME-Proxy-Cause: dmFkZTG0DnD7BQ/jfif7UNQTIC/Ys+JyOnWxXeKGguyPRq9ttoaksyVi11sSK6KA3FcQK1
    Vtbbx9Fn2U+ay07MblZv6sF1ebzlKt1oPEqCpYjec/DtlvRyalzQARMHMvlCMU4I0NzZ3v
    4Ye++gorGx0ag59m+rbOmVkE5HYqVH8hjdoCyqFRBhvG+ikXGh0SNJTlDK9+Jlw5SCEP0V
    aMq067699sbvLripEfdjc6BRVHaRcG1jq4hYyocb4b2aGvErZsS/oBhybbBRShw28jtZtK
    CcxZW6rMSiHUS4M9JuLCzpPb6s3HQcriQnqbuC7d+zgYCf58S1mkwq+7o2/3XQxQlU58SQ
    tGlUW0+URTbPil2h7ha8i3v6133b4eDACba5dV+Nn9Chsk6dp+boqlD+YIvqiNaeHDEbO4
    QF0qI6QJPvY+7KWSJo4nCpBbnqHwiSKU1QiwW/qAkW9NDLujr4oYlBhQ+V37YI1j7h60uQ
    cfpHORSoH4f/SnyG0NEmyl/MHYB/l/jmb2AzWeoYTjYUJr8QNRn2RmpMXHwmod2c3WM45U
    Q9X+JRAWSDW3SvCyARSNyBo7zQQvh6FPZdcZDI/SNA1s/QRAOeWktQ2KVsQFaTGjr5uXHZ
    ATxr7P3fYHTBhu8bhu4bmu71egE+bNRNMi7bqBaXA/U2ArKTNnIo8QD8ubWQ
X-ME-Proxy: <xmx:nc6eaoQ5dCU6gCXsAeNnWQHFpjpLPQzIWwgpP2sxND2Lfe-Rs69TWQ>
    <xmx:nc6eatKL4eloMo-cozDTz5fk-zYXaSP_3w50asuwDOHj3o5SCilWCw>
    <xmx:nc6earY4DTmULuZSP7LHDHzNubcDqcIFk4AFw7-FO0ixs2QOLHY9Bw>
    <xmx:nc6ean-FoDIjurv9U4xQESb7LDTae9Iq16tv2kksvkl-N0VbUeKUHA>
    <xmx:ns6eavXC79TB7pnhwVpCGkTa_ONppUNJxCgnF7vBg-ppr-zBNz8ZQG1a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 10:47:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 77235430 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 14:47:53 +0000 (UTC)
Date: Mon, 7 Sep 2026 16:47:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH v2 1/3] config: add git_config_append_parameter()
Message-ID: <ap7Ol5baYwXTn6R_@pks.im>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v2.git.1788537086.gitgitgadget@gmail.com>
 <ef8087e80db18c511e31dd9c7dd6ea3d57dd543c.1788537086.git.gitgitgadget@gmail.com>
 <ap5yT0sOtLQQa4AY@pks.im>
 <b395ea0d-37aa-471a-a70a-6b2c278ad64e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b395ea0d-37aa-471a-a70a-6b2c278ad64e@gmail.com>

On Mon, Sep 07, 2026 at 02:24:34PM +0100, Phillip Wood wrote:
> On 07/09/2026 09:14, Patrick Steinhardt wrote:
> > On Fri, Sep 04, 2026 at 03:51:24PM +0000, Thomas Bachem via GitGitGadget wrote:
> > > From: Thomas Bachem <mail@thomasbachem.com>
> > > 
> > > diff --git a/config.c b/config.c
> > > index d9019e7e6c..e0bb29b53d 100644
> > > --- a/config.c
> > > +++ b/config.c
> > > @@ -450,18 +450,24 @@ static int git_config_include(const char *var, const char *value,
> > >   	return ret;
> > >   }
> > > +void git_config_append_parameter(struct strbuf *env, const char *key,
> > 
> > Nit: callling this `env` assumes a bit too much about what this buffer
> > is going to be used for. I'd have called it just `buf`.
> 
> Are we ever likely to use this outside of GIT_CONFIG_PARAMETERS? If not then
> I think env is a good name because it hints at where this function is used.
> Isn't the whole point of this function to allow us to append settings an
> environment variable?

Potentially, even though this function doesn't really require that at
all. So it may or may not be used outside this current use case.

Anway, as I've said it's only a nit, so I won't insist on a change here.

Patrick
