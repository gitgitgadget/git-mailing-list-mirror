Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5315156CF
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730401270; cv=none; b=EWcpyhOp9rhcBMPYuayj3kpb7HstQ4J7oToCGLnq8xtnd3dxUkjs6JsborTZmbp3hIyvepfzKp7diBN5j6NRphFoRovWt3SDad1CE2ppnXlemnHfXp9QIAK9posQY08U1p51Frm14k3ygoB9UqfUpkdMigYJalvt5SNwesVgxis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730401270; c=relaxed/simple;
	bh=P8NKLwx54Z92rhgzifnqFBtbJ1bAxyLE3H/Zjl9rDuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XavCC3BcRE9ldwqsofuNPbXGNCOpFCFjfjEFdHjtkz+1QZAbitbtKwAxJA/hD2UbX82ULPIjY08UlbD6ETab/1panxAPpZ5jxORLaw+amA5IXY1RixePxCd+V+aWPzUP7fdoN5sZhO9goRA22Uh53jwzeqgjlynq5/3sOnBYsVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=cN11svK5; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="cN11svK5"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e330b7752cso16855397b3.1
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 12:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730401268; x=1731006068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P8NKLwx54Z92rhgzifnqFBtbJ1bAxyLE3H/Zjl9rDuE=;
        b=cN11svK5TJepPoYh5qxhhKqYaXGxxek3XVbtlL8n0CnJ88tgW5Owl3caqCPj/IEum5
         FN0vcN2xdK0KDEnaIbmH+CWIR7J/AshnPkekB8DFAf5ymRVmdIliCqp72jYQmwHnkaXk
         wEgsNW15x4A+BDch11b1nqxrZ9WpGVm/e50XXajh1MneaRPGGjSAuDhEQDBztL82ZicA
         1NHobDMua8G+uJARW+ehAQCLbAmJUf4aicKIcw+ZuGGHJxhfdUknzf0/+0o2IxxJuzbG
         5+tThRGj0EyxpvkyH7+rUBU8BNTe4MowmM2eKYLNP7nGMjgkesx2WjYjJGuxdVQjmM0T
         a2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730401268; x=1731006068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8NKLwx54Z92rhgzifnqFBtbJ1bAxyLE3H/Zjl9rDuE=;
        b=wXijKJcqRq+3sgPdtoTFuB3pcRmDHuZaTGfIdl1uwIzv+qGPAnoGZVd52lAjz0h846
         mtn1e/sPmLk25fcVsSY/30jxiNWNe402rhOiynowFGPKGekoM7PFMgcAb81dcBFF9G9R
         wKoTNh5HyAywP5/rkZyDwLSvQc07GhaYUkoNX5/gLhoC5jzYPV0BF0uHgZi2yRshobLS
         SmlzMo4v7YMotzHD/a4rJACZGvSMd0Di7UW85TIx7bgsTt/IoO48NdYpuJmwWkP01RPJ
         G7uV4suzMsIYcwvz3B+AFh30yMLQ4GYMP4cwwFM5RqnBryg4R+DUGD1v3oAWAcxg8cWP
         IPGg==
X-Forwarded-Encrypted: i=1; AJvYcCVYt0aWJ4RGem34ZivEohZiK4dtrkTkPh4D3nqI7NtHsUX5x6ei8/GjB+r62HJN6abCttQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLmr0K7Df2U1E13QUCp+c+zzVb0CTPGf+Xumrh57jXw+e0Xmgp
	0JsWRJoWzNpslaT9DJG9LPVY6Ov6XorWQtrzIYo8Beotf7hgS3yeTOypuj4VX7Q=
X-Google-Smtp-Source: AGHT+IExDWOdLQFozMSgZe4p9skgduYcLvA5a1fogGjoz4M2mtThq0SvCbvJ53D0zdTYJnTYvfoFUQ==
X-Received: by 2002:a05:690c:740a:b0:6db:da0e:d166 with SMTP id 00721157ae682-6ea55893852mr31388517b3.12.1730401267881;
        Thu, 31 Oct 2024 12:01:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55c8576bsm3698817b3.124.2024.10.31.12.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 12:01:07 -0700 (PDT)
Date: Thu, 31 Oct 2024 15:01:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, git@vger.kernel.org,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [BUG] "git describe --match" performance
Message-ID: <ZyPT8lsloCG4QLai@nand.local>
References: <20241030044322.b5n3ji2n6gaeo5u6@treble.attlocal.net>
 <20241031114731.GA608553@coredump.intra.peff.net>
 <20241031151000.svsa7d2ogcdz7hf6@jpoimboe>
 <20241031153143.GA2275115@coredump.intra.peff.net>
 <20241031162522.3qcolxhgxe4g2zmu@jpoimboe>
 <20241031170526.GA2277590@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241031170526.GA2277590@coredump.intra.peff.net>

On Thu, Oct 31, 2024 at 01:05:26PM -0400, Jeff King wrote:
> I think we talked long ago about computing commit-graphs over the
> grafted state, and then using those graphs as long as the graft state
> remained the same. But I don't think we ever implemented anything.
>
> Another possibility (that I don't recall we've ever discussed) is
> partially using commit graphs. Some commit properties, like generation
> numbers, depend on other commits. So a graft at the bottom of history is
> going to rewrite the generations for all of the descendants. But we
> could still use the graph information to load the parents and trees of
> all of the non-grafted commits. Those are still valid even in a grafted
> situation, and that's what's providing most of the speed up in this case
> (without it, we're literally zlib inflating each commit we traverse in
> order to find its parents, versus an integer lookup via the
> commit-graph).
>
> That might not be _too_ hard to implement. In theory, anyway. :)

Adding Stolee (CC'd), our resident commit-graph expert, to see if they
have any thoughts.

Thanks,
Taylor
