X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 16:48:31 +0100
Message-ID: <87psbnjsts.fsf@wine.dyndns.org>
References: <ejdcg5$4fl$1@sea.gmane.org>
	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>
	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>
	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<20061116011411.GB10512@thunk.org>
	<7vd57of2cv.fsf@assigned-by-dhcp.cox.net>
	<8764dflj5o.fsf@wine.dyndns.org> <20061116140141.GZ7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 15:49:40 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Theodore Tso <tytso@mit.edu>,
	git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061116140141.GZ7201@pasky.or.cz> (Petr Baudis's message of "Thu\, 16 Nov 2006 15\:01\:41 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31591>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkjUO-0001Vw-4A for gcvg-git@gmane.org; Thu, 16 Nov
 2006 16:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424205AbWKPPs7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 10:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424206AbWKPPs7
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 10:48:59 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:63372 "EHLO
 mail.codeweavers.com") by vger.kernel.org with ESMTP id S1424205AbWKPPs6
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 10:48:58 -0500
Received: from adsl-84-227-189-80.adslplus.ch ([84.227.189.80]
 helo=wine.dyndns.org) by mail.codeweavers.com with esmtpsa
 (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1GkjTd-0007uf-8w; Thu, 16
 Nov 2006 09:48:33 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000) id 1FD4910A151; Thu,
 16 Nov 2006 16:48:31 +0100 (CET)
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> How do those developers submit their changes? Do they push? If they do,
> git-rebase can be saving one merge at most, and the merge is actually a
> good thing (someone should write some nice standalone writeup about
> that).

No, they use git-format-patch and mail them in.

> If they don't have push access and maintain their patches locally until
> they get accepted, perhaps it would be far simpler for them to use
> StGIT?

For regular developers, sure. But regular developers will need to
properly understand the git model anyway, and then they will able to
make sense even of the standard git commands ;-)  The problem is that
there isn't a smooth progression to that point.

At first, a user will simply want to download and build the code, and
for that git-pull works great, it's a one-stop command to update their
tree.

Then after a while the user will fix a bug here and there, and at that
point git-rebase is IMO the best tool, it's reasonably easy to use,
doesn't require learning other commands, and once the patch is
accepted upstream it nicely gets the tree back to the state that the
user is familiar with.

The problem is that rebase doesn't work with pull, so the user needs
to un-learn git-pull and start using git-fetch; it's to avoid this
that we recommend using git-fetch from the start, which is unfortunate
since it makes things harder for beginners.

-- 
Alexandre Julliard
