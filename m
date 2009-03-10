From: Jeff King <peff@peff.net>
Subject: Re: import files w/ history
Date: Tue, 10 Mar 2009 14:03:53 -0400
Message-ID: <20090310180353.GC26351@sigill.intra.peff.net>
References: <slrngqqa4l.1t4t.csaba-ml@beastie.creo.hu> <20090303130046.GA7867@coredump.intra.peff.net> <slrngr299k.1t4t.csaba-ml@beastie.creo.hu> <20090308001021.GA26167@coredump.intra.peff.net> <slrngr99ei.1t4t.csaba-ml@beastie.creo.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Csaba Henk <csaba-ml@creo.hu>
X-From: git-owner@vger.kernel.org Tue Mar 10 19:06:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh6KW-00086v-Pd
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 19:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbZCJSD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 14:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbZCJSD5
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 14:03:57 -0400
Received: from peff.net ([208.65.91.99]:43086 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752249AbZCJSD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 14:03:56 -0400
Received: (qmail 12868 invoked by uid 107); 10 Mar 2009 18:03:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 10 Mar 2009 14:03:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Mar 2009 14:03:53 -0400
Content-Disposition: inline
In-Reply-To: <slrngr99ei.1t4t.csaba-ml@beastie.creo.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112838>

On Mon, Mar 09, 2009 at 05:15:16AM +0000, Csaba Henk wrote:

> But I still had a hard time with it... Finally I realized that if I do
> filtering this way, I have to start filtering from the topmost commit
> which affects the given file.
> 
> If I just start from origin/HEAD (assuming that it's on a commit which
> does not affect the file), then it won't be found as a key of the mapping
> created by git-filter-branch (as it's ignored because rev-listing was
> narrowed down to the file), and therefore filter-branch finally punts
> with "WARNING: Ref '<sha1>' is unchanged". I don't know if it's an
> intended behaviour, or something which could/should be improved, or at
> least documented... seems to be some sort of POLS violation to me (at
> least I was surprised :) ).

I think passing path limiters to filter-branch is just something that
nobody ever really tried before. I think the solutions are, in order of
decreasing easiness and increasing difficulty:

  1. document the problem in Documentation/git-filter-branch.txt

  2. create a failing test for it in the test suite

  3. fix the failing test. ;)

Do you want to try a patch for one (or more!) of those?

-Peff
