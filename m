Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A4A189BAB
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723117878; cv=none; b=B1o3IpxuvOK2Z/D6vq3GgIsN0v0DKYftEWymBTj3UafZd5rXPB3q6sp1gr3aJn6K/MiCAyR7Onuav7ZFGU8LTX/HRbDvfbX88qrsvuUJ8Ij0+T/BIMdpXlLjPrmURtt8IK2pqcB8luibmb/dyJN4hec5WdBHewu0gSd4de5AZ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723117878; c=relaxed/simple;
	bh=neAMWQRu8Qf3nK/SmGeXCve/cQxvC7vo9kWfEAnOhlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ym7ABITRKSGKcOJ57a0n0bM/XfMSVOJUcljCxo52+bFSYU9s3dRY30+YtyHau3IGe1gNVhv+7ECWp1zdsL2LTX+T+lOZuFtRAx4WCXzkix8K0H6hwp3DWQQEKF69nftevCDAv/sRGjsWz+PwADHVrwrJfIa1fkCPULncF/Pncfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=OULXE9AL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OULXE9AL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A16C32782;
	Thu,  8 Aug 2024 11:51:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OULXE9AL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1723117875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HgRhkjjSLktaz8yTYrjZQA0JP8U5iY64Une7qOSmCPE=;
	b=OULXE9ALAYuqNGPbNOH0/phADt9llfNBEkdRVATSD61MTh+LAta392mVllmx4RHsmBe2w9
	hjprPv+EFhed2l4fix0GgMtICpkp5pnF/3rzwRmNSffmbipEF+MqOMcSjexehXRKmDnrEB
	e7EOBrTCcAkH7iCi0XhGWFnixlVjft8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id da4a4e00 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 11:51:15 +0000 (UTC)
Date: Thu, 8 Aug 2024 20:51:09 +0900
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, calvinwan@google.com, spectral@google.com,
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 0/6] [RFC] Introduce cgit-rs, a Rust wrapper around
 libgit.a
Message-ID: <ZrSxLU-7rmlvdTHC@zx2c4.com>
References: <cover.1723054623.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723054623.git.steadmon@google.com>

Hi,

Cgit maintainer here...

On Wed, Aug 07, 2024 at 11:21:25AM -0700, Josh Steadmon wrote:
> * bikeshedding on the name (yes, really). There is an active, unrelated
>   CGit project [4] that we only recently became aware of. We originally
>   took the name "cgit" because at $DAYJOB we sometimes refer to git.git
>   as "cgit" to distinguish it from jgit [5].

Indeed, please find something else. Cgit is a real project, used by
many, such as git.kernel.org, and it'll turn into a real hassle for both
of us if there's ambiguity and confusion.

What about libgit-rs? Or even libgit3, where the rustness of it is
simply an implementation detail, so the name won't feel dated 15 years
from now when everything is written in Rust anyway and -rs is so 2020s?

Jason
