Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6D85C8FB
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 07:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9562 invoked by uid 109); 12 Jan 2024 07:03:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 12 Jan 2024 07:03:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14972 invoked by uid 111); 12 Jan 2024 07:03:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 12 Jan 2024 02:03:59 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 12 Jan 2024 02:03:56 -0500
From: Jeff King <peff@peff.net>
To: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 2/2] t5541: remove lockfile creation
Message-ID: <20240112070356.GE618729@coredump.intra.peff.net>
References: <pull.1634.git.1704912750.gitgitgadget@gmail.com>
 <pull.1634.v2.git.1705004670.gitgitgadget@gmail.com>
 <f953a668c6a7e0a57adcee77ceee2d578970065e.1705004670.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f953a668c6a7e0a57adcee77ceee2d578970065e.1705004670.git.gitgitgadget@gmail.com>

On Thu, Jan 11, 2024 at 08:24:30PM +0000, Justin Tobler via GitGitGadget wrote:

> -	# the new branch should not have been created upstream
> -	test_must_fail git -C "$d" show-ref --verify refs/heads/atomic &&
> -
> -	# upstream should still reflect atomic2, the last thing we pushed
> -	# successfully
> -	git rev-parse atomic2 >expected &&
> -	# ...to other.
> -	git -C "$d" rev-parse refs/heads/other >actual &&
> -	test_cmp expected actual &&
> -
> -	# the new branch should not have been created upstream
> +	# The atomic and other branches should be created upstream.
>  	test_must_fail git -C "$d" show-ref --verify refs/heads/atomic &&
> +	test_must_fail git -C "$d" show-ref --verify refs/heads/other &&

This last comment should say "should not be created", I think?

Other than that, both patches look good to me.

-Peff
