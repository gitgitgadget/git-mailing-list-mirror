X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Vincent Ladeuil <v.ladeuil@alplog.fr>
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 12:52:05 +0200
Message-ID: <877iyne4dm.fsf@alplog.fr>
References: <45357CC3.4040507@utoronto.ca>
	<20061021130111.GL75501@over-yonder.net> <453F2FF8.2080903@op5.se>
	<200610251146.06116.jnareb@gmail.com>
	<a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>
	<87slhcz8zh.wl%cworth@cworth.org>
	<a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
	<7vu01ro20b.fsf@assigned-by-dhcp.cox.net>
	<a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
	<20061026101038.GA13310@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 10:52:26 +0000 (UTC)
Cc: James Henstridge <james@jamesh.id.au>,
	Junio C Hamano <junkio@cox.net>,
	bazaar-ng@lists.canonical.com,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061026101038.GA13310@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 26 Oct 2006 06:10:38 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 26 Oct 2006 10:52:05.0385 (UTC) FILETIME=[C68EB790:01C6F8EC]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30184>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd2qP-0007Ci-4B for gcvg-git@gmane.org; Thu, 26 Oct
 2006 12:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423241AbWJZKwM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 06:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423233AbWJZKwM
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 06:52:12 -0400
Received: from mailhost.altair-tech.com ([217.167.26.75]:55250 "HELO
 srv-mail.altest.fr") by vger.kernel.org with SMTP id S1423241AbWJZKwK (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 06:52:10 -0400
Received: from dune.altest.fr ([10.0.0.145]) by srv-mail.altest.fr with
 Microsoft SMTPSVC(6.0.3790.1830); Thu, 26 Oct 2006 12:52:05 +0200
Received: by dune.altest.fr (Postfix, from userid 1000) id 59E6B2BB2; Thu, 26
 Oct 2006 12:52:05 +0200 (CEST)
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

>>>>> "Jeff" == Jeff King <peff@peff.net> writes:

    Jeff> On Thu, Oct 26, 2006 at 05:57:20PM +0800, James Henstridge wrote:
    >> >If you two have the same commit that is a guarantee that you two
    >> >have identical trees.  The reverse is not true as logic 101
    >> >would teach ;-).
    >> 
    >> That was the point I was trying to make.  Carl asserted that in git
    >> you could tell if you had the same tree as someone else based on
    >> revision IDs, which doesn't seem to be the case all the time.

    Jeff> If you have the same revision (commit IDs), you have
    Jeff> the same tree (at the same time, by the same committer,
    Jeff> etc).

    Jeff> If you have a different revision (commit), you may or
    Jeff> may not have the same tree. You can then check the tree
    Jeff> id, which will either be the same (you have the same
    Jeff> tree) or differ (you don't).

    Jeff> Thus, in the converse, if you have the same tree, you
    Jeff> _will_ have the same tree id. You may or may not have
    Jeff> the same commit id.

Ok, so git make a distinction between the commit (code created by
someone) and the tree (code only).

Commits are defined by their parents.

Trees are defined by their content only ?

If that's the case, how do you proceed ? 

Calculate a sha1 representing the content (or the content of the
diff from parent) of all the files and dirs in the tree ?  Or
from the sha1s of the files and dirs themselves recursively based
on sha1s of the files and dirs they contain ?

I ask because the later seems to provide some nice effects
similar to what makes BDD
(http://en.wikipedia.org/wiki/Binary_decision_diagram) so
efficient: you can compare graphs of any complexity or size in
O(1) by just comparing their signatures.

    Vincent


