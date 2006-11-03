X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: git bug? + question
Date: Fri, 3 Nov 2006 04:25:40 -0500
Message-ID: <BAYC1-PASMTP0642BEDA27FC7EADD1A9AAAEFE0@CEZ.ICE>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com>
	<7v4pthmew1.fsf@assigned-by-dhcp.cox.net>
	<20061102224549.499610d1.seanlkml@sympatico.ca>
	<20061103081232.GB15972@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 09:26:15 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061103042540.192bbd18.seanlkml@sympatico.ca>
In-Reply-To: <20061103081232.GB15972@diana.vm.bytemark.co.uk>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 03 Nov 2006 09:29:00.0890 (UTC) FILETIME=[7EDF23A0:01C6FF2A]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfvJ4-0003zE-3x for gcvg-git@gmane.org; Fri, 03 Nov
 2006 10:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752492AbWKCJZn convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006 04:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752617AbWKCJZn
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 04:25:43 -0500
Received: from bayc1-pasmtp06.bayc1.hotmail.com ([65.54.191.166]:14203 "EHLO
 BAYC1-PASMTP06.bayc1.hotmail.com") by vger.kernel.org with ESMTP id
 S1752492AbWKCJZm convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>);
 Fri, 3 Nov 2006 04:25:42 -0500
Received: from linux1.attic.local ([65.93.43.81]) by
 BAYC1-PASMTP06.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Fri, 3 Nov 2006 01:29:00 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GfuMt-00040n-W5; Fri, 03 Nov 2006 03:25:40 -0500
To: Karl =?ISO-8859-1?B?SGFzc2Vsc3Ry9m0=?= <kha@treskal.com>
Sender: git-owner@vger.kernel.org

On Fri, 3 Nov 2006 09:12:32 +0100
Karl Hasselstr=F6m <kha@treskal.com> wrote:

> I would rather see the default pull source of a branch being
> determined by which branch it was branched off of. But this should
> mean the same thing in this case. We'd just have to have the heuristi=
c
> that default pulls from a remotes/*/* branch causes a fetch, while a
> default pull from a local branch does not.

Well, when you create a branch a branch.<branch>.merge entry could be
automatically made so that a merge from the proper place happens.
But in the absence of any config merge entries, it would be nice to
default to the same branch name from the remote namespace.  This
removes the need to create merge entries for the initial clone.
Of course, currently you have to create branch.<branch>.merge
entries by hand.

> > On a peripherally related topic, someone on the xorg list was
> > complaining that after the initial clone, there is no easy way to
> > track branches that get added/deleted from the remote repo. It woul=
d
> > be nice if pull had an option to automatically add and remove remot=
e
> > branches from the remotes/<remote>/xxx namespace.
>=20
> That would definitely be useful. But I want it in fetch, not pull. :-=
)
> Well, I suppose it could be in both.

Yes.
=20
> Hmm, I think my dislike of remote pulls can be summed up as: I find i=
t
> convoluted to have a command that will fetch multiple remote branches=
,
> then merge just one of them into my current branch. (I have no proble=
m
> with pull when the branches to pull are specified explicitly, since i=
n
> that case they are all merged.) With explicitly specified default pul=
l
> sources it would get better, since then I would know that the correct
> branch would be merged, but I still don't quite like it.

Yeah.. Although fetching multiple remotes makes more sense as an
optimization, especially when using a separate remotes namespace.
Perhaps the real confusion is created because the only porcelain=20
level merge command current in Git is "git pull .".  A separate
name might make things easier to grasp.

Sean
