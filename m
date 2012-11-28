From: Jeff King <peff@peff.net>
Subject: Re: Python extension commands in git - request for policy change
Date: Tue, 27 Nov 2012 20:39:43 -0500
Message-ID: <20121128013943.GA23776@sigill.intra.peff.net>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
 <50B1F684.5020805@alum.mit.edu>
 <CAMP44s0WYiV3hTE7u28_Wd59FkGfu3o_psS0gocpnibzN4--Fg@mail.gmail.com>
 <20121127143510.GA15831@google.com>
 <CAMP44s10krOPD73dL0Ancie=kussk89jK7V5adR3hw=a73CVWw@mail.gmail.com>
 <20121128005128.GB23224@sigill.intra.peff.net>
 <CAMP44s0FiNRbFHbTtZJiWLDRQmy0VZ_FNGxE40eZrXwCFJ5P7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Magnus =?utf-8?B?QsOkY2s=?= <baeck@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 02:40:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdWd7-0001vs-Be
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 02:40:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755445Ab2K1Bjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 20:39:46 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58829 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754552Ab2K1Bjq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 20:39:46 -0500
Received: (qmail 32129 invoked by uid 107); 28 Nov 2012 01:40:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Nov 2012 20:40:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Nov 2012 20:39:43 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s0FiNRbFHbTtZJiWLDRQmy0VZ_FNGxE40eZrXwCFJ5P7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210659>

On Wed, Nov 28, 2012 at 02:22:09AM +0100, Felipe Contreras wrote:

> Sure, you will argue that we don't see the *real* issues, because they
> were fixed preemptively, but the fact of the matter is that we will
> never know. All we know is the reality we can observe, and the reality
> is that we hit very few *real* issues outside the test system (feel
> free to provide evidence to the contrary).

I think reports of breakage in the test scripts are relevant, because
they are indicative that people _do_ run platforms that care about these
issues, and if we were to write a lot of shell scripts, we would run
across them more frequently. But the fact of the matter is that we don't
write a lot of non-test shell scripts these days, which is part of the
reason limiting your search to the last 2 years did not turn up many
fixes outside the tests.

There was a big push in 2006 and 2007 to port some of the hairier
scripts to C. Try:

  git log --no-renames --diff-filter=D \
          --diff-filter=D --format='%ad %s' --date=short \
          -- 'git-*.sh'

A lot of it was motivated by portability and decent performance for
common commands under Windows.

Anyway, there is not much point in debating the exact level of pain that
shell portability causes us. Even if you accept that there is some, it
is clearly not a major problem for the project.

-Peff
