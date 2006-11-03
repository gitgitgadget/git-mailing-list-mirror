X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git bug? + question
Date: Fri, 3 Nov 2006 09:12:32 +0100
Message-ID: <20061103081232.GB15972@diana.vm.bytemark.co.uk>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com> <7v4pthmew1.fsf@assigned-by-dhcp.cox.net> <20061102224549.499610d1.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 08:12:53 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061102224549.499610d1.seanlkml@sympatico.ca>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30793>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfuAQ-000536-Cl for gcvg-git@gmane.org; Fri, 03 Nov
 2006 09:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750944AbWKCIMn convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006 03:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWKCIMn
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 03:12:43 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:22796 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1750944AbWKCIMm
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 03:12:42 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1GfuAC-0004Gv-00; Fri, 03 Nov 2006 08:12:32 +0000
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

On 2006-11-02 22:45:49 -0500, Sean wrote:

> One thing that would make separate-remotes nicer to work with is to
> have an automatic mapping between any local branch and one of the
> same name in remotes.
>
> So for instance, if you have a local branch named pu checked out and
> you pull from origin, remotes/origin/pu would be merged after the
> fetch unless a manual mapping was defined in the remotes or config
> file.

I would rather see the default pull source of a branch being
determined by which branch it was branched off of. But this should
mean the same thing in this case. We'd just have to have the heuristic
that default pulls from a remotes/*/* branch causes a fetch, while a
default pull from a local branch does not.

> Maybe even going as far as automatically creating a local branch for
> each remote branch on clone is worth considering.

Yes, maybe. It should make for a good default for beginners, at least.

> On a peripherally related topic, someone on the xorg list was
> complaining that after the initial clone, there is no easy way to
> track branches that get added/deleted from the remote repo. It would
> be nice if pull had an option to automatically add and remove remote
> branches from the remotes/<remote>/xxx namespace.

That would definitely be useful. But I want it in fetch, not pull. :-)
Well, I suppose it could be in both.

Hmm, I think my dislike of remote pulls can be summed up as: I find it
convoluted to have a command that will fetch multiple remote branches,
then merge just one of them into my current branch. (I have no problem
with pull when the branches to pull are specified explicitly, since in
that case they are all merged.) With explicitly specified default pull
sources it would get better, since then I would know that the correct
branch would be merged, but I still don't quite like it.

--=20
Karl Hasselstr=F6m, kha@treskal.com
