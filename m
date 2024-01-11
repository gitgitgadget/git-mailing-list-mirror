Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EDD20E0
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 05:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="DE4lvJww"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1704951232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EOB4Qkyr0BvuMiQSrPW57Gd7r5ofXum+gOiQv1qzhwk=;
	b=DE4lvJww0H8DLcXDYAkqxmxYsJ/8mL1MDso0lOOMnKje9Cw9Owt+69LH4YVcztrpUW8BgN
	aXvSGKgDDz88vHL06PFIbt69aUwHs9aGN/Yl66aonnOLtuy6dQlKUsGzV4ftuCiShl1ILx
	X/QelBuM8oP2Z9uzNkcbioSvgAqPrSDA4I33JtlENdXdfvWBLFAUXq7ovS0zHAMlCA73Wm
	M9tZ7Oql7D1R3ljoT3dGSaDlcZTTDr5p1w1LWEHHk5i6r/9XiMnCoSUUsv1DBQ5WPuutif
	rsVnRIT7OXiV1qLAmUJApiSVt+6gaWhgPy6Bq1d0NcKFyloHtaRWHzuzrNSKDw==
Date: Thu, 11 Jan 2024 06:33:50 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Elijah Newren <newren@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [DISCUSS] Introducing Rust into the Git project
In-Reply-To: <CABPp-BFOmwV-xBtjvtenb6RFz9wx2VWVpTeho0k=D8wsCCVwqQ@mail.gmail.com>
References: <ZZ77NQkSuiRxRDwt@nand.local>
 <CABPp-BFOmwV-xBtjvtenb6RFz9wx2VWVpTeho0k=D8wsCCVwqQ@mail.gmail.com>
Message-ID: <14951ce7e4ec61712e5455b836dd625c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-11 01:12, Elijah Newren wrote:
> Another alternative (as discussed at Git Merge when we were last
> talking about Rust[8]), is requiring all Rust code to be optional for
> now.  If we choose to go that route, I think that means that (a) for
> existing components, we have both a Rust and a C implementation
> available, and (b) for new components (e.g. new top-level commands
> like git-replay), they can be Rust-only and those compiling without
> Rust just don't get them.

To me, this sounds like a horrible option, which is exactly what
I earlier referred to as introducing fragmentation.
