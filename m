X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git bug? + question
Date: Fri, 3 Nov 2006 08:48:57 +0100
Message-ID: <20061103074857.GA15972@diana.vm.bytemark.co.uk>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com> <7v4pthmew1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 07:49:49 +0000 (UTC)
Cc: Miles Bader <miles@gnu.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v4pthmew1.fsf@assigned-by-dhcp.cox.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30792>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gftnz-0000Ii-91 for gcvg-git@gmane.org; Fri, 03 Nov
 2006 08:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753183AbWKCHtG convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006 02:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753184AbWKCHtG
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 02:49:06 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:12044 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1753183AbWKCHtD
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 02:49:03 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1GftnN-0004Dh-00; Fri, 03 Nov 2006 07:48:57 +0000
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 2006-11-02 18:40:30 -0800, Junio C Hamano wrote:

> which is efficient (guaranteed to do only one fetch from remote) and
> convenient.

Hmm, this is interesting. 99% of the time, I use "git fetch", followed
by "git pull . remotes/origin/foo" (often having run gitk in between
the two in order to see what's coming). I like to know what I'm
pulling (yes, I know how to undo a bad pull, but still ...).

> And I also would need to have per-branch configuration to merge from
> ". remotes/origin/$b" without re-fetching while on a non-master
> branch $b, for the above to work.

This is a good point. The "remotes/$repo/$branch" names are quite a
mouthful to type, so default pull sources would be a definite
improvement. (It would also be an improvement for the case when the
user is susceptible to the human factor.) Simply defaulting to pull
from the branch that this branch was cloned from should do the trick
(but the pull source should of course be editable).

> I still need to remember to process "master" first, so all things
> considered, this is a regression in usability for my workflow.

Where does this constraint come from?

> But that is probably a minor inconvenience to a minority.  Most
> of the world follow others' repositories that have a single
> primary head, and defaulting to use separate-remote would help
> them a lot.

I can attest that separate remotes is a usability win also when using
several branches from more than one remote source. It's actually
possible to infer from the branch name (remotes/$repo/$branch) which
branch from which repository is being tracked.

As an aside, in case of several remote repositories, "git fetch --all"
would be handy.

--=20
Karl Hasselstr=F6m, kha@treskal.com
