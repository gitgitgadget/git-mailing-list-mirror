From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Add Author and Documentation sections to
 git-for-each-ref.txt
Date: Thu, 10 Mar 2011 17:37:32 -0500
Message-ID: <20110310223732.GE15828@sigill.intra.peff.net>
References: <1299590170-30799-1-git-send-email-alcosholik@gmail.com>
 <1299590170-30799-3-git-send-email-alcosholik@gmail.com>
 <4D773570.4010803@drmicha.warpmail.net>
 <7voc5k9hfy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Alexei Sholik <alcosholik@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 23:37:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxoUL-00019n-CG
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 23:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425Ab1CJWhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 17:37:33 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39885
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750Ab1CJWhc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 17:37:32 -0500
Received: (qmail 31868 invoked by uid 107); 10 Mar 2011 22:38:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Mar 2011 17:38:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Mar 2011 17:37:32 -0500
Content-Disposition: inline
In-Reply-To: <7voc5k9hfy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168860>

On Wed, Mar 09, 2011 at 12:17:53PM -0800, Junio C Hamano wrote:

> As the project and the community grew, and also as the internal machinery
> infrastructure got more modularized, I think ownership at the individual
> command level has become almost meaningless concept.
> 
> Same reasoning applies to the "Documented by".  I think it's time for
> these two sections to go from most (if not all) pages.

Yeah, I would just as soon drop Author and Documented-by fields in all
manpages. We could replace them with a single "Credits" in git(1). It
can either mention nobody, very few people (like Linus as the originator
and Junio as the long-time maintainer), or the top N (for N < 20 or so)
people in shortlog. And then mention that you can run shortlog yourself.

I would probably do something like this:

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 0c32d45..4323843 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -745,16 +745,10 @@ unmerged version of a file when a merge is in progress.
 
 Authors
 -------
-* git's founding father is Linus Torvalds <torvalds@osdl.org>.
-* The current git nurse is Junio C Hamano <gitster@pobox.com>.
-* The git potty was written by Andreas Ericsson <ae@op5.se>.
-* General upbringing is handled by the git-list <git@vger.kernel.org>.
-
-Documentation
---------------
-The documentation for git suite was started by David Greaves
-<david@dgreaves.com>, and later enhanced greatly by the
-contributors on the git-list <git@vger.kernel.org>.
+Git was started by Linus Torvalds, and is currently maintained by Junio
+C Hamano. Numerous contributions have come from the git mailing list
+<git@vger.kernel.org>. For a complete list of contributors, see
+linkgit:git-shortlog[1] and linkgit:git-blame[1].
 
 Reporting Bugs
 --------------

And then a follow-on patch to drop the Authors section from all of the
other pages.

-Peff
