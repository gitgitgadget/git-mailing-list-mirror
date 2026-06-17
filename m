Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32CE3BBFDB
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681219; cv=none; b=nGJDrBr3XEVmC1dDpOVscagdR8RlMmbF4gN7TAkJwQvx9btHDzeFLPCwFl4hrlxgzZiJqwYNikDiEHAnBSOluIRAPWDyIFknfWCBeIlLRDPIjJTJPKiTzf1appqHraKkNVu8gc5dygXEW/2TocZGm4o7fZuWFqY6CCPGYs3eyIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681219; c=relaxed/simple;
	bh=AZzjkKUH8MVU0/4JkwnSjIIb82zFNGCaQMNVr+VFu8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnhFOWzWTQaSpniC1GoDNH8aDIwjxPgQDevACLjXluJ5ZIilerClGcBq0rsJntwSFE+Q0vHV/YUZAVa/urXRS9VP9eKmyAASgyKZpwM4QwRIdUsR1TNjqnCDHw8qAAgEPDX48V8b2RGIul414MXnYdMFxM0WCk/L0MyIwMWZ7tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J8sSbVvI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fI6x2UDa; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J8sSbVvI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fI6x2UDa"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0A1447A0115;
	Wed, 17 Jun 2026 03:26:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 17 Jun 2026 03:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781681215; x=1781767615; bh=T5HCi/0DrY
	Iej+0vj4kkiqxw/1cF69BfGzInOLdMp4c=; b=J8sSbVvIbBxLsPu6YRi8vAqh56
	9JMdgORU5gH+3WghlONqCKI2pA30QocOAniN3fRHo9ZDtVthpPCg2MpAU1yRIwbH
	kSxk4+pXETko+y3mvOVIrT/WluA2E5S7UHJHb62IGZgblx5IyTZDwnH/4jiptxt1
	UfDRVaXejzk2D0O+Y66c3IAPcef225DCcOWWwO3V3s+CleL690gg9PjtoOkecQkI
	n878MtKBpQIiZSv1QCak/bSCXW0hMJQzH8QmXRZYNI+TZq9dXiNB2oFjm5yIS+kq
	fkErnfa/VIj2OxFalKs7eqrInnOImhUuh/HdG1o4mcLGgW3+TWw8pbZaPzTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781681215; x=1781767615; bh=T5HCi/0DrYIej+0vj4kkiqxw/1cF69BfGzI
	nOLdMp4c=; b=fI6x2UDa49EbT9IDKFQKQ5EZ1hudhxv24jUBBWINM7LnE8V225a
	ayy00LEHcdwetwwJu6NwYm2ZP0Hr9VFpxf0m4BXs7DjvP2keC1QlDqZEK2E7Gn3C
	49rnl9hz8dCQTgYyFCp/HhFO30l3vU89eyQPZ1tc8NPBdocvsx4ChEeVQckAv1lJ
	fWNxPAKEC+FI9kvI/YSSPIlykPNNu3UW8CXhY/aHYuYOTVE1v1SVPExevFUmdEVF
	H5lC/n9Qa9mJWz7SQYxn4LI9F/jb8e5IQauSooS38YG/03ExrnzleUhCmS4XiEdS
	xDgvWAf6msh39/gNogQ0XXv5SI4nGfSIgmw==
X-ME-Sender: <xms:P0wyanCwYZcKtxV9AmM-jafNf2JWbSywFe-PRySH9LY2ok5R78RiMQ>
    <xme:P0wyak-3LrL6GmB3k3dl5wOFE1Ef71T43GfzPLumOjhdLkYK3tm-Nnl3tdQGpKZB3
    FDBIATd1ipyAzjfWeEeo2XwHvEjeZ2C6Vz28Y_9bgnL6EAyJCfX0w>
X-ME-Received: <xmr:P0wyav8O54n37LXMIFsJN_dMxuJ_TmQrW-Xb_Cc6VDeb9Mx3NmgH49s8ooD3QY8-dghuXKtcDgcbSrWl_g2f-AcGWMJPp_Sq1a64HB0>
X-ME-Proxy-Cause: dmFkZTEPLD2SF6xYUFeRtAFTim6HsMtEo1f+fNo6Y+1JBgBkdV049cu+2n4OR9KUoDWa1T
    /oVaq5o0R0pOr+Bhows6n16/vbcQJ3qnZPk35lUQKNc1THLq2FSsAFW8p7aiiO2Jwth20z
    Xbmit0m90Oq7v9OYtqMxWf3u3/qwjxz9rnrBnh+e9UtOqevoTdhaLHg9KeDjoedD2VZpZq
    Pyqz0c7BhLuFL7oZ7upO78K6diM4i3e2rGHXOswAX6pADgw5B9p8nRZH06EOfjrZN+uPL7
    iIiApyFKRATGJNwP7MRtqPVzI/ctubHMn9fbv3KxQxESaq5HvP3l7p+ViJP2Elq3ZVY4As
    ugkoFy6SwusW8yAfRXS/VtTnsQTSJJfcqIwx9bdSGtz9alFD0TBoAj7fe9gL+vUhu9zirN
    MFAsMwDQ/Z3p3lZ8Z2JcBtdS790/PWdoxOu57t5nt3IEN+J/q8D78PKrItvlANwc/Xa8Xv
    /vJnIo+qN2hTIPVYMcUZ0z9ZLVznZj2lcjFYZfbDJiUuVzhawxerXriPEvv7DPy8vjMtNk
    O8ws0WQ05tWh063SC5RAWnWiEb57ywhRdicE1RjDnPhskx03mStrQcqnrv4ZN/4LXdPu8w
    iobqhe93QhyJeKPHzoWoGmOlTl7uOPJaK1IxOOrqVeNFwQSlS6z4aBTyWI+g
X-ME-Proxy: <xmx:P0wyajcAuSwlWAQoObP98cNeojtXCmoViYKkMLFb2CjZDbn0oSpF0w>
    <xmx:P0wyagH9C5AAEeqPCJ26gtEREHOjUcQlh1omYaaCyMVdRsKNp_zwNQ>
    <xmx:P0wyapcg5z_aKYYq5y9K7_GTDeFwk_edkehVW8SRmWp0aWIruUlo_Q>
    <xmx:P0wyaiGUt0e5M8CZrrv6hyZE-kvxh72XqQ2SCgs76J6IBh6_EuxpZA>
    <xmx:P0wyaoYsJe0Arjyni5mhcyslxX29g_QFwhrTUw3TPkPLdUksQs0eAovu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 03:26:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 41195445 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 07:26:54 +0000 (UTC)
Date: Wed, 17 Jun 2026 09:26:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 17/17] odb/source-packed: drop pointer to "files"
 parent source
Message-ID: <ajJMO65fqU0e-Ez5@pks.im>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
 <20260609-pks-odb-source-packed-v2-17-839089132c8b@pks.im>
 <ajHRkrsvNtcBMFx2@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajHRkrsvNtcBMFx2@denethor>

On Tue, Jun 16, 2026 at 05:51:43PM -0500, Justin Tobler wrote:
> On 26/06/09 10:51AM, Patrick Steinhardt wrote:
> > @@ -626,7 +625,7 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
> >  		report_garbage(PACKDIR_FILE_GARBAGE, full_name);
> >  }
> >  
> > -static void prepare_packed_git_one(struct odb_source *source)
> > +static void prepare_packed_git_one(struct odb_source_packed *source)
> 
> At first I was a bit confused to see this change here, but IIUC
> previously this function was passed the "base" source of the "files"
> ODB. Now that we have a proper "packed" source we can use that directly
> instead.

Yes, exactly.

Thanks for your review!

Patrick
