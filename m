X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Adjust t5510 to put remotes in config
Date: Mon, 18 Dec 2006 23:28:33 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612182325550.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0612171545390.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v7iwox59i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 18 Dec 2006 22:28:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v7iwox59i.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34748>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwQyN-0006it-1k for gcvg-git@gmane.org; Mon, 18 Dec
 2006 23:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754700AbWLRW2g (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 17:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754701AbWLRW2g
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 17:28:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:38181 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1754700AbWLRW2f
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006 17:28:35 -0500
Received: (qmail invoked by alias); 18 Dec 2006 22:28:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp032) with SMTP; 18 Dec 2006 23:28:34 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Mon, 18 Dec 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Since .git/remotes/ is no longer created by default, t5510 failed.
> 
> Does not reproduce for me.

I just checked out a fresh copy of 'next'. It still fails. The culprit is 
61dde8f91672ab362f3cfd3af8d6d09d448d4ffe, which removes the line

		mkdir -p "$GIT_DIR/remotes" &&

which is line 372 in the parent of that commit.

> > While at it, convert the tests to use the config way of specifying
> > remotes instead of creating a file in .git/remotes/.
> 
> I think adding tests to use config is good, but I'd rather see
> the test scripts to test not _only_ config but both.

Okay. How about fixing the first hunk as proposed, and the second by 
'mkdir .git/remotes'?

Ciao,
Dscho
