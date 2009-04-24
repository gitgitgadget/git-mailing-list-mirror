From: Jeff King <peff@peff.net>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 10:18:47 -0400
Message-ID: <20090424141847.GD10761@coredump.intra.peff.net>
References: <m24owgqy0j.fsf@boostpro.com> <20090423175717.GA30198@fieldses.org> <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com> <20090423201636.GD3056@coredump.intra.peff.net> <b4087cc50904231345x2613308eh640e50f4a2680890@mail.gmail.com> <B873CD38-2CFE-4138-8A77-8957FA3DB81C@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Witten <mfwitten@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 16:21:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxMH1-0001F0-BM
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 16:21:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759955AbZDXOSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 10:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759342AbZDXOSz
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 10:18:55 -0400
Received: from peff.net ([208.65.91.99]:43856 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756619AbZDXOSy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 10:18:54 -0400
Received: (qmail 28749 invoked by uid 107); 24 Apr 2009 14:19:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 24 Apr 2009 10:19:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Apr 2009 10:18:47 -0400
Content-Disposition: inline
In-Reply-To: <B873CD38-2CFE-4138-8A77-8957FA3DB81C@boostpro.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117441>

On Thu, Apr 23, 2009 at 05:31:13PM -0400, David Abrahams wrote:

>> I think the main problem, then, is that the tools have a UI that is
>> somewhere in the middle.
>
> Well, "the UI" (how many do we really have for Git?) is spread across the 
> spectrum.  The git command-line alone lets you do incredibly low-level 
> things that "nobody should ever do" and some really high-level things that 
> are everyone's bread-and-butter.  There's no obvious distinction.

I think this is a bit better than it used to be. Plumbing commands are
mostly hidden outside of the user's PATH. Unfortunately there are still
some warts, like the fact that users may be referred to "git help
rev-parse" to learn about how revisions are specified. But they have to
wade through the information on the "rev-parse" command, which is
something that most users will never need to know or care about.

A lot of that is historical baggage. The original git was not a VCS but
rather a _toolkit_ for building a VCS. So the natural place for talking
about parsing revisions was rev-parse, because that was the only way to
access the revision parsing code. :)

I think a lot of documentation like the "specifying revisions" section
of rev-parse might benefit from being split into its own "concept"
section, like gitrevisions(7). And commands which allow specifying
revisions (at least the major ones, like log, diff, etc) should
reference it (but not include it directly, as we do with some
documentation snippets -- the point is to make the user aware that they
are learning a separate concept that can be applied in multiple places,
and to give that concept a name).

-Peff
