Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC5E22306
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78CFE4
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 12:10:02 -0700 (PDT)
Received: (qmail 20318 invoked by uid 109); 31 Oct 2023 19:10:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 31 Oct 2023 19:10:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24511 invoked by uid 111); 31 Oct 2023 19:10:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Oct 2023 15:10:01 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 31 Oct 2023 15:09:59 -0400
From: Jeff King <peff@peff.net>
To: Jeremy Hetzler <jeremyhetzler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [bug] 2.39.0: error in help for ls-remote
Message-ID: <20231031190959.GA875658@coredump.intra.peff.net>
References: <CAOh4nmk2KZBTuW9qn_ZgDY3yLRZ6NgGOWuBMLRRm1sU=pdmRoQ@mail.gmail.com>
 <CAOh4nmm9fTm8fa=1Hyi8t3R-VMnf30-0xe0vcst57dvY-FrL+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOh4nmm9fTm8fa=1Hyi8t3R-VMnf30-0xe0vcst57dvY-FrL+w@mail.gmail.com>

On Tue, Oct 31, 2023 at 02:11:23PM -0400, Jeremy Hetzler wrote:

> The short help for ls-remote advertises that '-h' is short for '--heads':
> [...]
> However, 'git ls-remote -h' instead prints the help. So perhaps the
> help message should be revised.

It does work as documented with an argument, like:

  git ls-remote -h <remote>

Yes, this is somewhat weird, but is a balance between consistency and
backwards compatibility. See:

  https://lore.kernel.org/git/YU4QxcORBBR01iV8@coredump.intra.peff.net/

as a starting point for past discussions.

The manpage (or "--help") describes the behavior correctly; it may be
that the "-h" output could do so as well, but it's sometimes hard to
communicate such subtleties in such a terse format. So there may be room
for a patch to make things more clear there, but I think it may be
difficult to do well.

-Peff
