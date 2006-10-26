X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Rationale for the "Never commit to the right side of a Pull line" rule
Date: Thu, 26 Oct 2006 19:26:03 +0200
Message-ID: <20061026172603.GA21256@diana.vm.bytemark.co.uk>
References: <ehqp1u$j4$1@sea.gmane.org> <Pine.LNX.4.64.0610261003590.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 26 Oct 2006 17:27:14 +0000 (UTC)
Cc: Jerome Lovy <t2a2e9z8ncbs9qg@brefemail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610261003590.3962@g5.osdl.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30247>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd90P-0003xg-Lw for gcvg-git@gmane.org; Thu, 26 Oct
 2006 19:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423690AbWJZR0V convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006 13:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423692AbWJZR0V
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 13:26:21 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:42769 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1423690AbWJZR0T
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 13:26:19 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1Gd8zT-00066w-00; Thu, 26 Oct 2006 18:26:03 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 2006-10-26 10:11:50 -0700, Linus Torvalds wrote:

> But it's a good rule in general, just because it makes a certain
> common workflow explicit. In fact, we really probably should start
> to always use the "refs/remote/origin/HEAD" kind of syntax by
> default, where you can't even _switch_ to the branch maintained in
> the remote repository, because it's not a real branch locally.

Seconded. I really like having remote branches in their own namespace
where I can't confuse them with my local branches by mistake -- and
that the branches of different remotes end up in different separate
namespaces.

> So normally you should consider the "origin" branch to be a pointer
> to WHAT YOU FETCHED LAST - and that implies that you shouldn't
> commit to it, because then it loses that meaning (now it's "what you
> fetched last and then committed your own work on top of", which is
> something totally different).

Defaulting to --use-separate-remotes would mean not having to explain
this to every single confused new user. :-)

It feels like the right thing to do, because it reduces the amount of
things a user has to know about git internals. Until you get to the
level where you can do brain surgery on your repo, the remotes/
branches will really _be_ your local read-only mirror of remote
branches, and you don't have to be aware of the possibility that they
could get out of sync because of local commits.

--=20
Karl Hasselstr=F6m, kha@treskal.com
