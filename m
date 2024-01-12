Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987E45B5DB
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 08:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 10082 invoked by uid 109); 12 Jan 2024 08:03:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 12 Jan 2024 08:03:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15427 invoked by uid 111); 12 Jan 2024 08:03:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 12 Jan 2024 03:03:21 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 12 Jan 2024 03:03:18 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 1/2] t1401: generalize reference locking
Message-ID: <20240112080318.GA620715@coredump.intra.peff.net>
References: <pull.1634.git.1704912750.gitgitgadget@gmail.com>
 <cb78b549e5e826ffef39c55bd726164e6b7bb755.1704912750.git.gitgitgadget@gmail.com>
 <20240111071329.GC48154@coredump.intra.peff.net>
 <ZZ_MPK2huH2j6CGd@tanuki>
 <20240112070142.GD618729@coredump.intra.peff.net>
 <ZaDuEufXOnwH7hT4@framework>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZaDuEufXOnwH7hT4@framework>

On Fri, Jan 12, 2024 at 08:45:22AM +0100, Patrick Steinhardt wrote:

> > The obvious quick fix is to sprinkle more error() into the reftable
> > code. But in the longer term, I think the right direction is that the
> > ref code should accept an error strbuf or similar mechanism to propagate
> > human-readable error test to the caller.
> 
> Agreed, I think it's good that the reftable library itself does not
> print error messages. In this particular case we are already able to
> provide a proper error message due to the error code that the library
> returns. But there are certainly going to be other cases where it might
> make sense to pass in an error strbuf.

Oh, if there is an error code you can use already, that is even better. :)

Thanks for taking care of this case.

-Peff
