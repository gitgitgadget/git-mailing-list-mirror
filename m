From: Eli Barzilay <eli@barzilay.org>
Subject: Re: rebase --continue confusion
Date: Sun, 6 Jun 2010 18:32:58 -0400
Message-ID: <19468.8730.59682.76355@winooski.ccs.neu.edu>
References: <4C01B855.7080409@gmail.com>
	<m3bpbo1f3f.fsf@winooski.ccs.neu.edu>
	<20100606221853.GG6993@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 07 00:33:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLOOu-0007pu-Qj
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 00:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395Ab0FFWc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 18:32:59 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:53185 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717Ab0FFWc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 18:32:59 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1OLOOo-0003Y4-2F; Sun, 06 Jun 2010 18:32:58 -0400
In-Reply-To: <20100606221853.GG6993@coredump.intra.peff.net>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148559>

On Jun  6, Jeff King wrote:
> On Sun, Jun 06, 2010 at 09:10:44AM -0400, Eli Barzilay wrote:
> 
> > There are a number of these things that I asked about recently.
> > Here's another similarly one:
> > 
> >   $ git add foo
> >   $ git status -s
> >   M  foo
> >   $ git commit --amend foo
> >   # On branch master
> >   # No changes
> >   $ git status -s
> >   M  foo
> 
> I'm confused. Is there some context for when you are issuing these
> commands?  Because the "git commit --amend foo" should actually
> commit foo, and does for me.

Heh, in that case it was more effective than I thought...  My point in
the previous posts was also about missing information (in that case,
make `git add' tell you when adding it canceled previously added
changes, and also make `git status' tell you if you're in the middle
of a merge or rebase and in a clean state).

In any case, here's the prelude to the above:

  $ mkdir t; cd t; git init
  $ echo foo > foo; git add foo; git commit -m foo
  $ echo bar > foo; git commit -o foo -m bar
  $ echo foo > foo

(And as cooked as it seems, I posted it because I actually ran into it
this morning.)

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
