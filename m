X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-explain
Date: Tue, 5 Dec 2006 02:26:22 -0500
Message-ID: <20061205072622.GA21839@coredump.intra.peff.net>
References: <200612031701.15594.alan@chandlerfamily.org.uk> <Pine.LNX.4.64.0612031024480.3476@woody.osdl.org> <7v1wngwws6.fsf@assigned-by-dhcp.cox.net> <7vwt57j94c.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612042253250.2630@xanadu.home> <20061205035721.GA26735@fieldses.org> <7v1wnekh6a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 07:26:47 +0000 (UTC)
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v1wnekh6a.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33311>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrUhK-0004gI-CH for gcvg-git@gmane.org; Tue, 05 Dec
 2006 08:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759037AbWLEH01 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 02:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937376AbWLEH00
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 02:26:26 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:52427
 "HELO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id
 S1759755AbWLEH00 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 02:26:26 -0500
Received: (qmail 32352 invoked from network); 5 Dec 2006 02:26:24 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 5 Dec 2006 02:26:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Dec
 2006 02:26:22 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Mon, Dec 04, 2006 at 10:09:17PM -0800, Junio C Hamano wrote:

> Should I take these responses to mean that you two are negative
> about the approach of spending extra cycles to commands that can
> leave the working tree in a "in the middle of doing something"
> state to help having a unified command to explain what the
> situation is and suggest the user possible exits, or are you
> saying that it might be a good idea but "git explain" is a bad
> name?

It seems like the point of this command is to show some state
information which would otherwise be hard to see. I think of 'git
status' as the way to look at the repository state. Perhaps we should
enhance the output of 'git status' to note things such as failed merges,
whether we're bisecting, in the middle of applying a patch series, etc.
There could be an optional verbosity switch to give "full explanations"
including recommended ways to deal with the situation.

> Hardwiring the recommended workflow in the tools would reduce
> chances of mistakes, but it could rob the flexibility from them
> if we are not careful and forget to take into account some
> useful combination of tools when adding such safety valves.

As long as the safety valves don't come up _routinely_ in certain
workflows, it seems OK to bypass them with a '-f' force switch. I
suspect the best way to figure out if such workflows are in use is to
put in the safety valves and see who complains; otherwise we're stuck
with brainstorming workflows and deciding whether they make sense.

