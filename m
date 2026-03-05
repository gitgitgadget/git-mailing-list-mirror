Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B6C3E0C65
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730702; cv=none; b=nBCixWAZ4DgTw8saqko39DhaiQHN13aqC1g6te3xLFvACjxigS1JySgv+EsE5OVOyVXDVu4QNR7W1Izyyd+zE/gqL1HzuKSrRClOU5aYiiJslAivpTm/u0MH6WPDOJXMseXz/iE9gqqHnlzpxl6634VcndHFU+N8tYyinvAs+CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730702; c=relaxed/simple;
	bh=ALReAcLQAnCw4wDOGhSxojg3eBMBsV74TKNtLwuhe0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/Q7LKzKREZI+HhGpW96ISO8Kvp3tRJFU6dFiGnYwack2vtLy1oIXpFgsP9sLkRZyCKKHivUheMuYW9aqGHbAwVFAchUU44A0VUzXDnU+YE4IqfXwGSLRWvJtvQPsqy8QEOGjmAMTpzzmQEs+wTkv62aBNbXfuX9xdDUicqMlkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zdg7lbFB; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zdg7lbFB"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6759a5576f5so5830503eaf.2
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 09:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772730700; x=1773335500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rKDoPN+HRlDzMYIifOey/U921ff9nWZuzwqAs7crX1E=;
        b=Zdg7lbFBuOHnZW1p0rpd+kuY6K0F9/VJPyJTcvw1ASBpIUyvnQJvAJrEFHB88BjtXj
         diE7NE5MKUjjqPrOJUpcJ0hYXjnz64XsjnK5Fa3Iy/aQtdK3Rq6wblDF2fGnKZC/+Sbr
         nlp3CiGH4i9w7jIa4n9UqS1jndJkwauXcPJ9v0rK0mR0p4DSe2LZ+ZzJVmqaIpv+2iHW
         gcKMeAB7IKIZo59hY1sWQPB/FUCQZzPZT4cyBBzRP0aPs+q1SnD4XvJoRiONKm/TyfQS
         YfEjaBY9+89xXu+1LQzj5T6TstcgIyTV39TtLWYiWZJ0NNShObmr2jrhOGIEOQwxBVSG
         7JYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772730700; x=1773335500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKDoPN+HRlDzMYIifOey/U921ff9nWZuzwqAs7crX1E=;
        b=vtQFWEWq/gddwLh3Euhk3vjmdQl7M3rb3flUZ07dNvjd5d9P51Jk4vKlpUBLqW+I2c
         A94YejaTN+B4WbKAA5i+6wfcQh2+CUiPpaBKtj9v0qRcoNm3EEssBpDewxahtt7wPUAV
         5FkB6NsUoRmRxKqsa0AKuRbehJp/VXlhnvpdKJH9ZVXfDv1Yfy2MLGrG8FGbmde2PfSS
         CScLTFREGtzh9pVswhkDF/rRuY54SqB3WhRp8SElV00BaVL906T7EyfcS7OVO1E1SKox
         inbQ4EJ9R5smyBX/QP70r00aizYEQuHzSP6+rNTK/7cUwO2STXMe7jcISLO0voejxnbI
         wjEQ==
X-Gm-Message-State: AOJu0YzHr9sOM6KV8nF5sq6lwogluLrRIleicVvfA4hONkmyYPbJ8r21
	+gXMngEHk0IVRTQLhoHkyhU5BI91B8nvPRlF+FnAxRT7oyfOaX3IDBEyHmQedw==
X-Gm-Gg: ATEYQzyY4QRUSyEO6kw5C1VVIRsnMIOVtHQxc6efi8qLQAf0XWlL9ilCLPknul+Jx4b
	cFTt9S/EejNA0B2DSS++AqYQP4/3xlnnLAsLHBuO7ybIfTf90NkPEdog0so2oA7WC72jLAOwK5W
	zgzwFkzUo7um4/1M0Jacg9x0qKZauzbLBIXOt4BBXuQop48bb4AKOkM4TYliwOSWoA5C0gi74oX
	I6rz8o6qdg4UvM6P8dJx5TlFtAclN/N9V4NJfUzt+ABitC3Zwm+Ffyh7RwRQV7j5Ci4KLJEd/qF
	LjHxBpdMN8Rbs0O8gOhahdZceBkTGzhKtTGKc0fKWzpyyfM5FPFfJmuQQRSlbghMsC3vMODg/YU
	vxunRQyQCZV0fi4ouvNI++2VrXlmGSn2mCPAAsIWKVwhZkjAUis6D7BrCAfQpxS+IYfhxRtyhoh
	K0dFflCiqYwrRDHLjM
X-Received: by 2002:a05:6820:2912:b0:677:fc0b:d7 with SMTP id 006d021491bc7-67b99ceae97mr226504eaf.59.1772730700261;
        Thu, 05 Mar 2026 09:11:40 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2d85297sm15032681eaf.11.2026.03.05.09.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 09:11:39 -0800 (PST)
Date: Thu, 5 Mar 2026 11:11:39 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/17] odb/source: make `close()` function pluggable
Message-ID: <aam432ZZOigjUiAx@denethor>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-8-253bac1db598@pks.im>
 <aaidbdpkpH7tfn9x@denethor>
 <aamD3Xm1_E5zMdj1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aamD3Xm1_E5zMdj1@pks.im>

On 26/03/05 02:23PM, Patrick Steinhardt wrote:
> On Wed, Mar 04, 2026 at 03:03:26PM -0600, Justin Tobler wrote:
> > On 26/02/23 05:17PM, Patrick Steinhardt wrote:
> > > Introduce a new callback function in `struct odb_source` to make the
> > > function pluggable.
> > > 
> > > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > > ---
> > [snip]
> > > +/*
> > > + * Close the object database source without releasing he underlying data. The
> > > + * source can still be used going forward, but it first needs to be reopened.
> > > + * This can be useful to reduce resource usage.
> > > + */
> > > +static inline void odb_source_close(struct odb_source *source)
> > > +{
> > > +	source->close(source);
> > > +}
> > 
> > Just to be safe, should we BUG()/ASSERT() in case the provide source is
> > NULL? Or do we expect the calling pattern to always provide an actual
> > source?
> 
> We don't do that for any of the other wrappers either, so I'm not quite
> sure why closing would be special. If this was the free function I might
> agree, but otherwise I don't quite see the value.

Fair, I noticed that we did it in the free function, so I was wondering
if we wanted to apply it to the other functions as well. But thinking
about it some more, there is proabably no/little value.

-Justin
