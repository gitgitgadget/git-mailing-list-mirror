X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: Push and remote refs
Date: Sun, 5 Nov 2006 16:06:07 -0500
Message-ID: <20061105210607.GA28320@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0611051333210.9789@iabervon.org> <7vhcxdu1ln.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 21:06:25 +0000 (UTC)
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vhcxdu1ln.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30983>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgpC4-0007K7-3V for gcvg-git@gmane.org; Sun, 05 Nov
 2006 22:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161311AbWKEVGL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 16:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965889AbWKEVGL
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 16:06:11 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:56514
 "HELO peff.net") by vger.kernel.org with SMTP id S965888AbWKEVGK (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 16:06:10 -0500
Received: (qmail 13722 invoked from network); 5 Nov 2006 16:05:13 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 5 Nov 2006 16:05:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Nov
 2006 16:06:07 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Sun, Nov 05, 2006 at 11:37:08AM -0800, Junio C Hamano wrote:

> I recall discussing this exact behaviour with Pasky when he
> added it to Cogito.  I think we concluded that it is a very
> sensible thing to pretend we fetched immediately after we
> successfully pushed and got the same thing back, and there is no
> risk of data loss or user confusion, as long as we catch failure
> from the push and refrain from doing this update, which Cogito
> did implement correctly when we discussed this.

Is it possible for hooks on the receiving side to change the tip commit
in some way? For example, the 'update' hook could do some markup on the
commit message or contents, creating a new commit and using it instead
of the pushed one; in this case, the sending side ends up with an
incorrect (and unrelated) SHA1. Is this simply too insane to worry
about?

