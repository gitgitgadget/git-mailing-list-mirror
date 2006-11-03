X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git bug? + question
Date: Fri, 3 Nov 2006 15:29:45 -0500
Message-ID: <20061103202945.GA7585@spearce.org>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com> <7v4pthmew1.fsf@assigned-by-dhcp.cox.net> <20061102224549.499610d1.seanlkml@sympatico.ca> <20061103081232.GB15972@diana.vm.bytemark.co.uk> <20061103042540.192bbd18.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 20:30:27 +0000 (UTC)
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Junio C Hamano <junkio@cox.net>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061103042540.192bbd18.seanlkml@sympatico.ca>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30881>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg5fo-0003B0-Cd for gcvg-git@gmane.org; Fri, 03 Nov
 2006 21:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932084AbWKCU3x convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006 15:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753524AbWKCU3x
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 15:29:53 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:61587 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1753509AbWKCU3w
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006
 15:29:52 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gg5g1-000672-F7; Fri, 03 Nov 2006 15:30:09 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 5FEBD20E491; Fri,  3 Nov 2006 15:29:45 -0500 (EST)
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

Sean <seanlkml@sympatico.ca> wrote:
> On Fri, 3 Nov 2006 09:12:32 +0100
> Karl Hasselstr=F6m <kha@treskal.com> wrote:
>=20
> > I would rather see the default pull source of a branch being
> > determined by which branch it was branched off of. But this should
> > mean the same thing in this case. We'd just have to have the heuris=
tic
> > that default pulls from a remotes/*/* branch causes a fetch, while =
a
> > default pull from a local branch does not.
>=20
> Well, when you create a branch a branch.<branch>.merge entry could be
> automatically made so that a merge from the proper place happens.

Yes, definately.  For most people I know that use Git the branch
they branched off of is the one they need to pull in on a regular
basis to keep their topic branch current.  They rarely pull other
branches in.

> But in the absence of any config merge entries, it would be nice to
> default to the same branch name from the remote namespace.  This
> removes the need to create merge entries for the initial clone.
> Of course, currently you have to create branch.<branch>.merge
> entries by hand.

Nack.  I'd rather see the entries added/removed from .git/config when
the branch is created/deleted, just like the ref and the reflog are
created/deleted.  It makes behavior more consistent for the user
and it is mostly self documenting...

	"why is branch FOO pulling FOO by default?  ahhh, its in
	.git/config after git branch FOO FOO."

Same goes for git-clone.  The branch.master.merge=3Dorigin/master
entry should be in .git/config file after the clone is complete.

--=20
