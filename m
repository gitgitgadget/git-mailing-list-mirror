Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B5335943
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 01:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772761735; cv=none; b=EIDDZdi/vOeygzsnZb7yO6u6oGfs2yPNoB3D39IHxiTbb1268d3y/RaaVHxGeSOzFi1rNNo6izKqA3jaiqA1NS0pxEB/9++WuOREtgJCJxuYg7Ug5Z+tDTktLfJnR2T/aZa4OXZ7cde2a4CXpCmbAswhErA7EVwS0e3VG0d6RVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772761735; c=relaxed/simple;
	bh=Z06aL6TKbVaoHnKr08aFFWBKcJcpRZ/jdT69hel0G8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHfyzW43kmo4q+eaRJOHZZiqH+FKvTiKKcFIdYkWaH839eY4XX0vbxPGxsTvkhYlnUC6TlJM9bQkC9IS1g+sXX3rMlXMH9edQGHEMp9WZkbMKjYJ1XvIDl/Mbo2v4QPBJQY6dGUPGYaPmEgGzEJ23pyiG3hpXVFrOe+dCJWAMQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlhNm9ai; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlhNm9ai"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-40efc77933fso2510592fac.3
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 17:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772761733; x=1773366533; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DwvI/ZXnjNycecXNakiF13Fi2/2AG0IaH+wlEt25U/U=;
        b=SlhNm9ai/FxxpT/S0zkou41pHYQaVrkKHVjpEqu1YEtsgBq9DbSlGtDHDhbku0FGZN
         LQ5fRvf3PQ9YTPwAVCjhu8k4O4oIDUPqH3EJptPz3MKxFqk5EfzQ5ofIDx1QQHEES66r
         ULxpzEEcjJrFHLgtpKhrL+gzBp/gOSpnoRutlpEAUgjkcCibSYISxTyJYfipmmE6nYBn
         u3C2xP2JnnKy1oD0Ct91oGxhweZOChfUNTk3MJJDw9bsArz0/hGsjuxpM2/QXsX9Zq2M
         Ov1ZfyDbthvYcQqu6O7tYdeEWJw2q9uBJnRn2BSVPreU4z0mdJLJBt8YZHmLt6SU4JHU
         Dp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772761733; x=1773366533;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DwvI/ZXnjNycecXNakiF13Fi2/2AG0IaH+wlEt25U/U=;
        b=G982saz01LVFgKH1wrMqob2GD95Swpja+u1PxkEZMNU2q+WxGnAh/ro/YUjSpIdonq
         6rYRFf3bGbunMyeNa37vwRIdbDcNsTsU988tTWijVMc4a0uJoNsuRbGSn0gnpdzLywMA
         14Iq4nBnxZ2v+qbo9uxdR6j7Mk6QczRvJ5/ADesccB92wVxVCCTJ4HCk/A0zmXN4o+4Q
         hLvGkbAjYiULIboXR1q+SFbqGyBVjVeaDsQXkO6aeKc2zkxXhvgzO1dAeHCAxj0QSBxe
         LBbew+E/F+VvLnn8sBLLCpoULP0nfQ5IxpIc4EVRKEo1yx9gy8VHawPLy+tTjuAln7o+
         tTdg==
X-Gm-Message-State: AOJu0Yw1yolDAJVahVLiodqzCXc2G2pcCn/hB5kvcrQIvVLNDy6AtM9B
	8JOpiB3NmWB0jGmfU766B/AOBSzM5eCqyjH91vACHlsavaqVCmcj4hrqlKraLg==
X-Gm-Gg: ATEYQzwO8eHAMSxowXhy0c+D9P3mhA9kHyB8cvUciwcOw/uSuOZfh/ss8zzGZ2fA9Dp
	PdmDo2bG8EQF/yK2Ymb33L/hKIIMIMDbh4VpMbJ4WkY0LtfBZWVO6SdDMkJ1mgdl6deQZXtuhXN
	G+lPHKR7+PwiKokzII2BRVff0vm2Dxd62Xm5yjy7j3Nsgicatb3zAUyBcDqlqfKtyvNqDqEhJzF
	i4FTho83DM5C7YFDcBm6TGXvvI8Y8QoRV0dPFI/etGeH4CJLDLCNPRry2HCZwNaZNgF1mJ7FtIn
	gar1uggf1+Cyko2vi6yc+OdUCKUWPWEOpFO4Ssn4fpgzLNUcuYZWNqYQwV9Td2/35hBuW6qx+iU
	1fjlZiu2S3N7Ja7U9i43KU02UQxtzGcRPbiVADR/2ZX/xQsVMSO9iV/miorY2sewS6Gcq3ShOpw
	hQdB7u9D0pIgsbW652
X-Received: by 2002:a05:6870:d3c3:b0:403:f7ad:ad7c with SMTP id 586e51a60fabf-416e44f3916mr375651fac.54.1772761732874;
        Thu, 05 Mar 2026 17:48:52 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e688d5cdsm167614fac.20.2026.03.05.17.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 17:48:52 -0800 (PST)
Date: Thu, 5 Mar 2026 19:48:49 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] Documentation: extend guidance for submitting patches
Message-ID: <aaowCeEMjpztZpti@denethor>
References: <20260305193836.973122-1-jltobler@gmail.com>
 <be9cbba2-883a-4ef8-838e-0941b75eee6f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be9cbba2-883a-4ef8-838e-0941b75eee6f@app.fastmail.com>

On 26/03/05 11:27PM, Kristoffer Haugsbakk wrote:
> On Thu, Mar 5, 2026, at 20:38, Justin Tobler wrote:
> > +It is also a good idea to check whether your topic has been discussed
> > +previously on the mailing list,
> 
> This is at the start of the document. “The mailing list” footnote
> (git-ml) does not get mentioned until line 535.
> 
> Although there is the initial mention of `MyFirstContribution` which
> prominently features the address at the start.

We also mention "the list" several times in the surround bullet points
prior to the footnote too. If we think it matters I can move the
footnote up.

> > or whether similar work is already in
> > +progress.  Prior discussions may contain useful context, design
> > +considerations, or earlier attempts at solving the same problem. Being
> > +aware of such discussions can help you avoid duplicating work and may
> > +allow you to coordinate with other contributors working in the same
> > +area.
> > +
> 
> This seems useful to cite. It seems less useful for people who go to the
> effort of reading this file themselves. They presumably care enough to
> try to get the procedural steps correct. It’s difficult to imagine that
> they either think that their idea has to be unique or that there isn’t a
> history.

Ya, I agree that most folks who feel inclined to read this document
proactively would likely also lookup previous/on-going mailing list
discussions. I do think this would be useful though to include so we can
point contributors this direction when needed.

Thanks,
-Justin
