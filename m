From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCHv5 2/4] Add infrastructure for ref namespaces
Date: Fri, 3 Jun 2011 16:43:57 -0700
Message-ID: <20110603234357.GA2170@leaf>
References: <1307136593-16306-1-git-send-email-jamey@minilop.net>
 <1307136593-16306-3-git-send-email-jamey@minilop.net>
 <7vd3iua4bm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 01:44:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSe2N-0004BC-AK
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 01:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462Ab1FCXoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 19:44:14 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:47788 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753331Ab1FCXoN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 19:44:13 -0400
X-Originating-IP: 217.70.178.134
Received: from mfilter4-d.gandi.net (mfilter4-d.gandi.net [217.70.178.134])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 43BDF172081;
	Sat,  4 Jun 2011 01:44:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at #File managed by puppet, do not edit
	locally
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter4-d.gandi.net (mfilter4-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id oXTGG0AUXATn; Sat,  4 Jun 2011 01:44:10 +0200 (CEST)
X-Originating-IP: 131.252.242.54
Received: from leaf (host-242-54.pubnet.pdx.edu [131.252.242.54])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id EC6CD172079;
	Sat,  4 Jun 2011 01:43:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vd3iua4bm.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175041>

On Fri, Jun 03, 2011 at 04:22:05PM -0700, Junio C Hamano wrote:
> Jamey Sharp <jamey@minilop.net> writes:
> 
> > Note that namespaces which include a / will expand to a hierarchy of
> > namespaces; for example, GIT_NAMESPACE=foo/bar will store refs under
> > refs/namespaces/foo/refs/namespaces/bar/.  This makes GIT_NAMESPACE
> > behave hierarchically, and avoids ambiguity with namespaces such as
> > foo/refs/heads.
> 
> I would have expected that this explanation would be improved after you
> having to answer my question on the list.  Otherwise it was a wasted
> effort, for both me (asking) and you (answering).

Just missed it when re-spinning the series.  Will re-send with an
updated commit message for that patch.

> > This adds the infrastructure for ref namespaces: handling the
> > GIT_NAMESPACE environment variable and --namespace option, and iterating
> > over refs in a namespace.  Subsequent commits use this infrastructure to
> > implement the user-visible support for ref namespaces.
> >
> > Commit by Josh Triplett and Jamey Sharp.
> 
> Also please drop that "Commit by ...".  We can read Sign-off.

Signed-off-by doesn't quite have the right meaning, since normally a
chain of signoffs just indicates the chain of review, not necessarily
authorship.  We brought this up at one point previously[1], and Jonathan
Nieder pointed to previous discussions about this, with the apparent
conclusion to use another pseudo-header to indicate co-authorship.
(Also why we originally put it in the same paragraph as the
signed-off-by.)  Documentation/SubmittingPatches also mentions the
possibility of adding extra pseudo-headers similar to Signed-off-by, as
appropriate.

We really did write these patches (and commit messages) sitting right
next to each other and switching off with the same keyboard. :)

- Josh Triplett and Jamey Sharp

[1] http://bugs.debian.org/451880
