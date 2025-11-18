Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF460246BA8
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456996; cv=none; b=sd7vvC4sdkH7of3MlGYo2tbUp5Bswkq65Y+6qm6loZD9u2zcWIXvX9wfSRmZdWvzPVHOCJrAYybNfZrtKgbP5q4tDf00V2x57iItU9ekSEEuNnabmXT/R+hVQ/SmrbJ4kgs29G/25m8ctrSkIK78ccYwWJfAtSAa8KwqsZUI/iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456996; c=relaxed/simple;
	bh=+DAYRQRoOU59nl/05dtIuGESM2rfQkP87PmcV9MZ2fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIqGe/wJRMiDssAhrx2L3+ro26xA+HbiWdMY5P5KpBKr7H7Lieod/64P9vMShNG2MoImuZXTfI4XdBsGj7MxBBaSq3IxFYzFomahu87hzJqBsJewqjuGv4etw4nTiLxxuymTibJ0ZJ/uRi/auA+6HsShZ8pf1/CbFRvVXJJUBBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=U+zExZ9I; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="U+zExZ9I"
Received: (qmail 19691 invoked by uid 109); 18 Nov 2025 09:09:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=+DAYRQRoOU59nl/05dtIuGESM2rfQkP87PmcV9MZ2fw=; b=U+zExZ9IdNkrgq9AYdVelvvI9SRhxKzE7RPBQ1soPG1yTv4OQK41cCJSIWlPUOceaww5U37nm5D/iDW4lzoof1bC+HjGFbGwrZm8maoVruk/3HBRZmEW6gqCQ4I++nVD3otbfUaSBOESLkdQRSJGPxEj/KhXsDZ+i0iMlA5LRQTQq4jC5K2hq0mqY5eirhM9LG/TRqIr3NhrT9iv1Jwc3LuvJ3YuJC1lxEFso/VvFcNmwyEyuSS2SY9iwrroUsTlSGcMOrWmZLxoJ7f/5dfRZbPfLbXnRgHj+bpV5F1aARgZQ1jPc75DunnakbJEaBAMuTf7EcxAwUnNj3wdxidkqQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Nov 2025 09:09:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27324 invoked by uid 111); 18 Nov 2025 09:09:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Nov 2025 04:09:57 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Nov 2025 04:09:52 -0500
From: Jeff King <peff@peff.net>
To: kristofferhaugsbakk@fastmail.com
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] doc: commit: link to git-status(1) on all format options
Message-ID: <20251118090952.GA17717@coredump.intra.peff.net>
References: <c4349a03724.1763129061.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4349a03724.1763129061.git.code@khaugsbakk.name>

On Fri, Nov 14, 2025 at 03:04:47PM +0100, kristofferhaugsbakk@fastmail.com wrote:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> `--branch` and `--long` refer to git-status(1) options but they don’t tell us
> what `short-format` and `long-format` are, respectively. And `--null`
> mentions “status” but does not link to the command.
> 
> Refer to git-config(1) on `--branch` like `--short` does.
> 
> `long-format` is the git-status(1) output. So we can just say that
> directly.
> 
> Replace “status” with a `linkgit` on `--null`.

Thanks, these all make sense to me.

>     Cc Peff based on:
>     
>     • f3f47a1e (status: add --long output format option, 2012-10-18) did not
>       • Did not link to git-config(1)
>     link to git-config(1) even though the previous
>     • 7c9f7038 (commit: support alternate status formats, 2009-09-05)
>       • This older commit did
>     
>     I was going to mention these when I was only changing `--long` but the
>     scope expanded to the other two options.

Yeah, I don't think I had a particular reason to link in one commit but
not the other. I can only say given the timestamps that I must have been
young and impetuous.

-Peff
