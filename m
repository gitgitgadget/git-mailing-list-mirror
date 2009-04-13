From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-branch - allow deleting a fully specified
	branch-name
Date: Mon, 13 Apr 2009 04:56:22 -0400
Message-ID: <20090413085622.GC9846@coredump.intra.peff.net>
References: <1239323335-4684-1-git-send-email-mlevedahl@gmail.com> <200904092119.10520.mlevedahl@gmail.com> <7vbpr519jq.fsf@gitster.siamese.dyndns.org> <200904111301.31250.mlevedahl@gmail.com> <20090412072056.GA25837@coredump.intra.peff.net> <7v7i1qb7sw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 10:58:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtHzI-00049l-CY
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 10:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbZDMI4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 04:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbZDMI4Y
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 04:56:24 -0400
Received: from peff.net ([208.65.91.99]:59800 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623AbZDMI4X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 04:56:23 -0400
Received: (qmail 30957 invoked by uid 107); 13 Apr 2009 08:56:26 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.0.130)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 13 Apr 2009 04:56:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Apr 2009 04:56:22 -0400
Content-Disposition: inline
In-Reply-To: <7v7i1qb7sw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116420>

On Sun, Apr 12, 2009 at 01:22:23AM -0700, Junio C Hamano wrote:

> > And I can see why you might think of it that way, because that is what
> > the synopsis in git-checkout(1) says. :) But it is really:
> >
> >   git checkout -b <branch> <commit>
> >
> > I'm not sure if changing that synopsis would really help, or if it is
> > a bit too subtle.
> 
> I think in many places we used to be stricter in terminology (e.g. when we
> only need tree-ish we used to write tree-ish) but during the "usability
> and approachiablility drive" people updated doc with "most of the time the
> command takes commit, so we say commit".

Yeah, I think this is one of the fundamental usability debates of git.
On one hand, if you assume that the user learns about the object types,
the DAG, and refs, then all of this is very straightforward to explain.
The price you pay is a steep learning curve. On the other, you can get
95% of what you need done without ever being exposed to the technical
details, so I can see why people push for learning materials that gloss
over it.

> I think "the apporachable part" aka "synopsis" should be kept the way it
> is, but we should clarify in the description when the most general form is
> different from the white lie we feed to newbies.

Hmm. I tried something in this direction, but I actually think it ended
up more confusing.

I think it would be better in the synopsis to split this into two use
cases:

  git checkout [<branch>]
  git checkout -b <new_branch> [<start_point>]

And then explain them as separate definitions.

-Peff
