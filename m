Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EDB1FCF65
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 19:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537393; cv=none; b=M/GTxphup1wtuA4PTDkWDpmnAZygP/4JOZUglsuRPkCB8Xs2x5URHaQOTna6SYJOTzBl+l4MZzsej1VppxviSTUmqVj1lNmkWIPqxK9T6nZva/HWdNeBTxrpwbY6ULShQrbe3Xs8Q/p2Mo8M8I0S1OnfVoz5UvokdqlYGFea4sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537393; c=relaxed/simple;
	bh=3ELWmzqLCfS4qdQgCtrHznusHn8jqWkr//7cUn+u8zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHEwTbxaZg9o/kqFLmkxJ2Dxdj0DX3crb1RUpcbpo2NosSjvefs/+Y2t4nAlErOK5Q/9pDxZ5yLJ8/7XxAzmudQfmTVZg3vXs2+Vm22qaRo3mfXnO5JRL+EG4AfnrgmVOlGG9RKihcMbIf3YmHmL7dTiqU+1D/NfJqXL9JDOyjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fpZBRriq; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fpZBRriq"
Received: (qmail 19305 invoked by uid 109); 21 Oct 2024 19:03:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=3ELWmzqLCfS4qdQgCtrHznusHn8jqWkr//7cUn+u8zU=; b=fpZBRriqSlargzNA0s/4pxQbO9w7TcnQLMkX2RALIGWWVw+yztliTg1rfB7TMyhT3VKjxJD5Yr7yaGhHzZh7QLFCIzuUcCA3x0ldSmVkM9L7pAM6NtdmYaGD2JOHrek+uXBXV0PmBNptrw+02ZpAuZw+T6ho75ltcm8jvLnF8fS1hb4abX+OwGgZEuL/conUWIl/3i8cLOwTsWDa4IlvmRhrMmaHGpUbqRyPg7thpyPS7aGPNpO8xrR8l6jB11Gl8CGKoV8XYnE+3Rd81d089AQ7Ht9OblHb1rBqF+zzmV+e06oCsAAbrJx9L6zw+HFgYGcVgyc9ltRSmKFWb8pr8A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Oct 2024 19:03:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31697 invoked by uid 111); 21 Oct 2024 19:03:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Oct 2024 15:03:09 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 21 Oct 2024 15:03:09 -0400
From: Jeff King <peff@peff.net>
To: Piotr Szlazak <piotr.szlazak@gmail.com>
Cc: Piotr Szlazak via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] doc: document how uploadpack.allowAnySHA1InWant
 impact other allow options
Message-ID: <20241021190309.GC1219228@coredump.intra.peff.net>
References: <pull.1814.git.git.1729112794671.gitgitgadget@gmail.com>
 <pull.1814.v2.git.git.1729355997353.gitgitgadget@gmail.com>
 <72184384-07ff-4f74-91d7-280ca78407b5@gmail.com>
 <fd5fab45-1363-41c8-915a-5578a35d219d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd5fab45-1363-41c8-915a-5578a35d219d@gmail.com>

On Mon, Oct 21, 2024 at 07:55:06AM +0200, Piotr Szlazak wrote:

> On the second look code changes will be needed, as at the moment final
> result will differ between:
> [uploadpack]
>         allowTipSHA1InWant = true
>         allowReachableSHA1InWant = true
>         allowAnySHAInWant = false
> 
> and:
> 
> [uploadpack]
>         allowAnySHAInWant = false
>         allowTipSHA1InWant = true
>         allowReachableSHA1InWant = true

I'd expect them to differ. The config is read in order with a "last one
wins" rule. The thing that the documentation should be making clear is
that the three overlap in what they are affecting, and so "last one" is
not just a single key, but these three inter-related keys.

-Peff
