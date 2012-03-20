From: Jeff King <peff@peff.net>
Subject: Re: git rev-list -S ?
Date: Tue, 20 Mar 2012 18:00:32 -0400
Message-ID: <20120320220032.GA29233@sigill.intra.peff.net>
References: <4F68CDA4.6060109@ira.uka.de>
 <7vaa3b570l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Holger Hellmuth <hellmuth@ira.uka.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 23:00:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA76f-0008TB-3e
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 23:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755813Ab2CTWAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 18:00:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54699
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755525Ab2CTWAf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 18:00:35 -0400
Received: (qmail 14848 invoked by uid 107); 20 Mar 2012 22:00:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 20 Mar 2012 18:00:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Mar 2012 18:00:32 -0400
Content-Disposition: inline
In-Reply-To: <7vaa3b570l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193544>

On Tue, Mar 20, 2012 at 01:53:14PM -0700, Junio C Hamano wrote:

> |    $ git log -S'it drives an external
> |   an external' master Documentation/RelNotes
> 
> is a way to find commits that introduced and then removed the block of
> text to files in the named directory, starting at the tip of 'master'.
> 
> Most of the "ultimate tracking tool" dream has already been realized in
> "git blame" except one major part.  Once you find where the blame lies,
> the tool _could_ help the user to find where these blamed lines came from
> more than it currently does.  Were they typed anew?  Were similar lines
> removed by the commit from other files?  Often people run "blame" on a
> line range they are interested in, find the commits that were blamed, look
> at "git show $the_found_commit" to see if they can find similar lines in
> deleted parts of other files and then finally run blame again on the
> deleted line range of these other files starting from the parent commit of
> the found commit to do this (and this needs to be repeated).  A good GUI
> should be able to help this process quite a lot, if backed by a good logic
> to detect "similar" code blocks.

Related to this is the line-level history browser project. The idea was
basically to get a log-like view (i.e., reverse chronological commits)
of a chunk of code, tracing the ancestry of a particular chunk of lines.

This was done by Bo Yang as a GSoC project in 2010, but the code still
hasn't been merged. As I recall, it mostly works, but there are perhaps
some corner cases or ugly parts of the code still to be re-worked.
Thomas Rast was cleaning it up some, and could say more on the current
state.

-Peff
