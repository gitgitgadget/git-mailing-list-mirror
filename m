From: Jeff King <peff@peff.net>
Subject: Re: confusion over the new branch and merge config
Date: Sat, 23 Dec 2006 01:28:01 -0500
Message-ID: <20061223062801.GA5415@segfault.peff.net>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home> <7vd56cam66.fsf@assigned-by-dhcp.cox.net> <20061223051210.GA29814@segfault.peff.net> <7vbqlvuoi4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 07:28:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy0Mi-0004ZA-68
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 07:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475AbWLWG2E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 01:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752416AbWLWG2D
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 01:28:03 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3387 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752475AbWLWG2D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 01:28:03 -0500
Received: (qmail 5891 invoked by uid 1000); 23 Dec 2006 01:28:01 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbqlvuoi4.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35276>

On Fri, Dec 22, 2006 at 10:15:15PM -0800, Junio C Hamano wrote:

> Only *if* you store it in that tracking branch.  The name the
> other party gives _do_ matter to you anyway, because you have to
> _know_ it to fetch.  What it does NOT matter is if you use a
> tracking branch, or if you do, which local tracking branch you
> use to track it.

No, their names _don't_ matter to most users. With the new remote layout
and wildcards, I'll never even see 'refs/heads/next' when I clone
git.git; I'll only talk about 'origin/next'.  The local tracking branch
matters much more to me, because it's the thing I'll use to interact
with git. I don't say 'git-checkout -b topic origin refs/heads/master';
I say 'git-checkout -b topic origin/next'.

Yes, my proposed syntax means you have to have a tracking branch. But
does it really make sense for people to put entries in their config
file, but not have a tracking branch? What do people use non-tracking
branch pulls for, anyway? I would assume for one-off pulls of
infrequently used repositories, in which case they're always saying
"git-pull git://path/to/repo foo:bar". My point being that if we can
improve the usefulness of the config file, it's probably not worth
worrying about people combining branch.*.merge config entries with
non-tracking-branch pulls, since they're extremely unlikely to be used
together.

Does anyone out there use non-tracking-branch pulls? If so, can you
describe your use case?

-Peff
