From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Requirements for integrating a new git subcommand
Date: Fri, 23 Nov 2012 10:35:41 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121123153541.GA20097@thyrsus.com>
References: <20121122053012.GA17265@thyrsus.com>
 <alpine.DEB.2.00.1211231022440.1431@ds9.cixit.se>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Nov 23 16:36:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbvJ8-0000nZ-0S
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 16:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242Ab2KWPgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 10:36:31 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:59004
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819Ab2KWPga (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 10:36:30 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id EC63B4065F; Fri, 23 Nov 2012 10:35:41 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1211231022440.1431@ds9.cixit.se>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210259>

Peter Krefting <peter@softwolves.pp.se>:
> I was just about to say that the import direction of this seems to
> fill the same need as contrib/fast-import/import-directories.perl
> that I submitted a few years back.

Yours was the closest in functionality, yes.

> Your version seems only to be able to import a linear history,
> however, my tool does support creating merge commits (basically, the
> history I had to import was very messy and contained a lot of
> snapshot directories having been worked on in parallel).

git-weave can *weave* (import) a sequence with merge commits, as your
tool can.  What it can't do is unravel a nonlinear repo into a tree
sequence that will round-trip through the weave operation.  (Though I
thought of a way I might be able to fix that last night.)
 
> Anyway, my sentiment is that if you can add support for merges in
> you weave tool, then I am very much for removing my old script from
> the repository.

The support is there.  I will take this as direction to (a) add a 
test load demonstrating this, and (b) include the removal of
import-directories.perl in my integration patch.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
