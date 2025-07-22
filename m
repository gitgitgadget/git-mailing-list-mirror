Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACE62236FC
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 08:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172224; cv=none; b=SAlrsDVEes0QLjYw+RUc25HmKCxpXxkHKIBzvVzCJTQk2pZhBLliqON+F6Sy1j4P+oaPZylKGnEYaOFJmEg2/ESFX/ksieMlR3PBGMVwgOxZM59I3klz0m6h5PQZAonM2hJVVeBerB9uiEyejFIEPTAWPMJpr4Fa+2S59ALTKRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172224; c=relaxed/simple;
	bh=pHPkNmbTjISoDEapw6qaX4Cv6Ve4H4G0/u2v+BoPq10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idVwtA5L/VvEEDYTJBfwiUUvgu/lW6KQZbuE07O5Kau72cp4W8qu7x3obt65vJm0w50i3KCMS4R4EMMpAaavXWTZ4uZRlh/EcAXbWnEXkX6o1+f4vUMFFEU3L9/fnKVadh5v+V6+WfuJpruIRwx/dZTG3zNNO3CbWgnbdfCvvCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=f5Y6naI+; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="f5Y6naI+"
Received: (qmail 26868 invoked by uid 109); 22 Jul 2025 08:17:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=pHPkNmbTjISoDEapw6qaX4Cv6Ve4H4G0/u2v+BoPq10=; b=f5Y6naI+mP5BrfNF2swWLqeMQijQoT/UWk2qUwF1hQOHp/9++xQQ58BAyUWnJNKdCjvXRujybZGNBMc+VtQGIHZTuF1aYxCjRsiIfqoQlFyvTbMegsGE/PtyumkKA5FTFy04XJt+edQdM+17PvePxLF4AkL8EVJJcqzUGrukDgzAj6GY6WJ4Xo5P6AsZZvdBFdXL7X7X0Q3V+pUQOfQMhitDzRrv6wkRmhM1srM40bQnweCu+kbtaB+WJoqfvNW3XxLEtiXesZgkeI1Tia0p7tUmWOEeiCzckFFvjPx+vbVihLGYlkYfb2JSuwxf6dqH7EYksoLLH9o5QVUM3pYszQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Jul 2025 08:17:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26446 invoked by uid 111); 22 Jul 2025 08:17:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Jul 2025 04:17:05 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 22 Jul 2025 04:16:59 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] rev-list: update a NEEDSWORK comment
Message-ID: <20250722081659.GA862006@coredump.intra.peff.net>
References: <xmqqa551127o.fsf@gitster.g>
 <xmqqecu9w4a5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqecu9w4a5.fsf@gitster.g>

On Mon, Jul 21, 2025 at 03:46:42PM -0700, Junio C Hamano wrote:

> The comment was poorly phrased and it wasn't clear what it wanted to
> say.  Strongly discourage this broken pattern to be copied and
> pasted to other code paths.

Thanks, I was much less confused after your re-wording.

-Peff
