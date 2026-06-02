Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A023D2F3C3E
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780416580; cv=none; b=Oz3VrzfO+eZXMwYdSMvucToyupibRwyzVAmSG/dEWDiQd/GVDy8mfWE5nu4q/8NWVi9xBgJ/I1uwmQnykB7okThNuDVzKMWmXCGai8mikctlrJFptcb1X4mf+cPJChzwRb1bC63mkxBQKDHtlYrZ0ZTgYmWDYnf9UnXosSugtzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780416580; c=relaxed/simple;
	bh=YhVXF0MDn+xTqTxwyoHnJwEr1N7mAA+C+EdfkDSSCV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzuE2uPlVmstFmM4fmzcxwera7jmOMeHkAwLO0CkxqTgIPUeJ+N2aLF1immrp9Zoeht7IIucoKv9WicOVs55i27RSnNErV12Q+i5CnlJP3ZIrgSefWT795b7F2QYqOluzu0WwtxVuqALyhy1vcAwf3QHfH47lp7GO9ZlMI4V9r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=MI49eQ+x; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="MI49eQ+x"
Date: Wed, 3 Jun 2026 00:09:16 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1780416576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YhVXF0MDn+xTqTxwyoHnJwEr1N7mAA+C+EdfkDSSCV4=;
	b=MI49eQ+x0b4QuFnsGQlep9/6vpiUd0RsH518pWprAStXJJIO9Hz7yvZvVeF9Oy5EgkjeYi
	/otiZ8DQ9rr5zQZCp+1OQMXh/5oFraO9im4/jE5qFHkfVOMrRcJ4qD5s4rDY6QD1Ji9dzV
	azS3VpJSOP4VQMGwIearTUEPx75pPKnip6AidAn/a7VvsPoFxrMBU7/4ZRmsDqRc5+W9W/
	v2URQeQGf+uAin5hWIZo7AKeQwqYhAff3U3/p84Vm/yS4Yh4DhmZS6r2mxiff89+48wsGy
	e13ZXNkKy6eoGA/rnstmtqToTXHSxPDPboJLtr3opLYrqNSLAPj26c4J6OcFPg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Documentation/MyFirstContribution: recommend the use
 of b4
Message-ID: <ah8ALHMDVA2Gzz10@wyuan.org>
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
 <20260602-pks-b4-v1-2-a7ae5a49e9cf@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-pks-b4-v1-2-a7ae5a49e9cf@pks.im>
X-Migadu-Flow: FLOW_OUT

Hi Patrick and Junio,

Just so happens that I just submitted my first patch. At this point, I
may or should be the target audience for this document.

I personally watched Patrick's videos with Scott Chacon[1] first, and I
reviewed them many times until I could do those "manual" git operations.

> +Contributors are encouraged to use `b4`, which automates much of the
> +bookkeeping that is otherwise done by hand.

So for statement like this and with my personal experience, I would say
b4 is a more suitable option for senior contributors, as they already
know, for example, what Message-ID and range-diffs are. But apparently,
whose who use forges may not know.

Back to the patch, I think regarding b4 as a more advanced contribution
way for those who had contributed via mailing lists for more than one
time is a better expression or formulation. Here I mean "b4 prep", other
usage like "b4 mbox" and "b4 am" are of course more basic, and be
mentioned as tips when interacting with Git mailing list.

A bit too wordy, in conclusion: Suggest that new contributors master
classic git operations first. When they are familiar with those process,
b4 might be a good option.

Thanks!
--
[1] https://www.youtube.com/watch?v=mjYac9SwIK0&t=1s (Part 1)
