From: Andreas Krey <a.krey@gmx.de>
Subject: Re: Consistency question
Date: Wed, 15 Jan 2014 14:45:08 +0100
Message-ID: <20140115134508.GE7102@inner.h.apk.li>
References: <8761pl8raj.fsf@fencepost.gnu.org> <20140115111330.GH14335@sigill.intra.peff.net> <871u098ocy.fsf@fencepost.gnu.org> <20140115124434.GA27030@inner.h.apk.li> <87ppnt7635.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jan 15 14:45:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3Qmo-0004nU-75
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 14:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbaAONpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 08:45:25 -0500
Received: from continuum.iocl.org ([217.140.74.2]:55676 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbaAONpT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 08:45:19 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id s0FDj8V29672;
	Wed, 15 Jan 2014 14:45:08 +0100
Content-Disposition: inline
In-Reply-To: <87ppnt7635.fsf@fencepost.gnu.org>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240470>

On Wed, 15 Jan 2014 14:00:30 +0000, David Kastrup wrote:
> Andreas Krey <a.krey@gmx.de> writes:
...
> > Hmm, how about traversing from all the start commits downwards
> > simultaneously, noting which start you say each commit from, and stopping
> > when you have a commit carrying all start labels?
> 
> It means that when the start commits are at considerably different
> depth, you'll traverse much more material than necessary.

But it has the advantage that you don't need to traverse the DAG
to the root when the differences are small - the runtimes are roughly
proportional to the difference between the commits.

> Also you need labels.

Yes, I assume that that (marking commits) is not a cost factor.

> > I don't quite see how the same size plus lockstep works out (but the
> > 'same size' part is possibly the same as my 'concurrent traversal').
> 
> It just equalizes the depth before starting, so you don't need labels:
> any common ancestor is reached at the same time by its descendants.
> 
> Of course, I conveniently forgot merge commits.

I finally noticed but forgot to mention in the last post.

Merges also mean that there is not necessarily a unique common
ancestor between commits.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
