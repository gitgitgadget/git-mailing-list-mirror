Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9F0199C3
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2D9123
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 06:49:17 -0700 (PDT)
Received: (qmail 31750 invoked by uid 109); 4 Nov 2023 13:49:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Nov 2023 13:49:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1714 invoked by uid 111); 4 Nov 2023 13:49:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Nov 2023 09:49:16 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 4 Nov 2023 09:49:15 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: rsbecker@nexbridge.com, Git List <git@vger.kernel.org>
Subject: Re: Request for Help - Too many perl arguments as of 2.43.0-rc0
Message-ID: <20231104134915.GA1492953@coredump.intra.peff.net>
References: <00a101da0e88$778cd3b0$66a67b10$@nexbridge.com>
 <CAPig+cTzWCpmksJm-0M1MfUSeYpWbgMaFNHRSOtAhCsNQigV-g@mail.gmail.com>
 <00c301da0e9d$0d2cb8e0$27862aa0$@nexbridge.com>
 <CAPig+cRG3VWgnwOPWvbW9boUooa6sD9d667wbSUe4_RkcR60vg@mail.gmail.com>
 <00c401da0ea1$b61899c0$2249cd40$@nexbridge.com>
 <CAPig+cQpxRQnhffR8EWWRhqJPmOeOuCE3qsuMcnDyuMLLbTH8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQpxRQnhffR8EWWRhqJPmOeOuCE3qsuMcnDyuMLLbTH8Q@mail.gmail.com>

On Sat, Nov 04, 2023 at 02:36:48AM -0400, Eric Sunshine wrote:

> I don't see an urgent need for it. Unlike the actual tests themselves
> run by `make test` which may catch platform-specific problems in Git
> itself, the purpose of the "linting" checks is not to catch
> platform-specific problems, but rather to help test authors by
> identifying mistakes in the tests which might make them fragile. So,
> disabling linting on a particular platform isn't going to cause `make
> test` to miss some important Git problem specific to that platform.

Hmm. With compilation, we split the audience of "developers" vs "people
who just want to build the program", and we crank up the number and
severity of warning checks for the former. We could do the same here for
tests. I.e., turn off test linting by default and re-enable it for
DEVELOPER=1.

OTOH, this is the first time I think I've seen the linting cause a
problem (whereas unexpected compile warnings are much more likely, as we
are depending on the system compiler's behavior).

So consider it an idle thought for discussion, and not necessarily a
proposal. ;)

-Peff
