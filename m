From: Jeff King <peff@peff.net>
Subject: [PATCH 0/5] git.git .mailmap cleanups
Date: Wed, 12 Dec 2012 06:30:36 -0500
Message-ID: <20121212113036.GB19625@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 12:30:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TikWf-0002Jq-Ag
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 12:30:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546Ab2LLLal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 06:30:41 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42793 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711Ab2LLLak (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 06:30:40 -0500
Received: (qmail 22960 invoked by uid 107); 12 Dec 2012 11:31:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Dec 2012 06:31:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Dec 2012 06:30:36 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211340>

I noticed a few obvious problems in the output of "git shortlog -nse" on
git.git. So I wrote an analysis script to find more, and of course there
were lots.

This series tries to clean up the low-hanging fruit. The first two
commits fix multiple names matching a single email. Hopefully not too
contentious, but I'll cc all involved parties to confirm. The second has
a different root cause, so I've broken it out into its own commit.

  [1/5]: .mailmap: match up some obvious names/emails
  [2/5]: .mailmap: fix broken entry for Martin Langhoff

Next up are multiple emails which match a single name. There are over a
hundred of these, and they are much less obvious to fix. They really
need individuals to post patches to fix their own identities (and some
may not want fixing at all, if they used different emails to have
meaningful different identities).

So I've left these untouched except for:

  [3/5]: .mailmap: normalize emails for Jeff King

I am allowed to fix my own. :)

  [4/5]: .mailmap: normalize emails for Linus Torvalds

As the benevolent dictator, Linus has underlings to fix such things for
him.

Also, his entry was the original reason I started looking at the data.
He fares quite poorly in "shortlog -nse" because his commits are
scattered across many addresses.

  [5/5]: contrib: update stats/mailmap script

This replaces the current mailmap script in contrib, which has a bug and
lacks some of the features of my new script.

-Peff
