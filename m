X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH/RFC] Convenient support of remote branches in git-checkout
Date: Tue, 7 Nov 2006 07:54:00 +0100
Message-ID: <20061107065400.GA25737@diana.vm.bytemark.co.uk>
References: <200611070026.16425.Josef.Weidendorfer@gmx.de> <7vd580azbb.fsf@assigned-by-dhcp.cox.net> <200611070225.24956.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 7 Nov 2006 06:54:25 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611070225.24956.Josef.Weidendorfer@gmx.de>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31045>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhKqg-0005Ns-Ts for gcvg-git@gmane.org; Tue, 07 Nov
 2006 07:54:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751641AbWKGGyP convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006 01:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752332AbWKGGyP
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 01:54:15 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:52742 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1751641AbWKGGyO
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 01:54:14 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1GhKqQ-0006np-00; Tue, 07 Nov 2006 06:54:02 +0000
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

On 2006-11-07 02:25:24 +0100, Josef Weidendorfer wrote:

> On Tuesday 07 November 2006 01:13, Junio C Hamano wrote:
>
> > Then "git checkout origin/next" would always mean "I want to
> > switch to the branch I use to hack on the branch 'next' Junio
> > has". Do it once and you will get exactly my tip, hack on it,
> > switch out of it and then do it again and you won't lose your
> > previous work but just switch to that branch.
>
> Ah, now I understand your thinking. I admit it has a compelling
> elegance.

I agree. The name is slightly longer than necessary in the common case
of only one remote repository, but the reduction of newbie confusion
will be worth it. (Non-newbies know how to give the branch any name
they want.)

> However. Would it not be confusing for newbies (and not only for
> them) to first reference the remote branch with "origin/next", and
> afterwards, you get your own development branch by using the exactly
> same name?

Not necessarily. As long as they know that there are two kinds of
branches, remote and local, it should be perfectly obvious. You check
out and modify your local copy of a remote branch, and occasionally
pull updates from the remote branch. If there is no local branch
corresponding to a certain remote branch, git will make one for you.

> IMHO this kind of aliasing is awkward. When you want to start
> another topic branch on the remote branch, or want to reference the
> remote branch for diffs, you have to explicitly specify
> "remotes/origin/next", making for more typing.

Having more than one local branch for a remote branch is advanced
enough that the user should know how to create branches with any name
they choose.

But I do agree that calling it "origin/next" the first time you
branch, and "remotes/origin/next" subsequent times, is nonintuitive.
However, this could be solved by the following message being printed
the first time:

  $ git checkout origin/next
  No local branch "origin/next" exists. Creating new local branch
  "origin/next" off of remote branch "remotes/origin/next".

--=20
Karl Hasselstr=F6m, kha@treskal.com
