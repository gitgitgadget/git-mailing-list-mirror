X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Push and remote refs
Date: Sun, 05 Nov 2006 11:37:08 -0800
Message-ID: <7vhcxdu1ln.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611051333210.9789@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 19:37:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611051333210.9789@iabervon.org> (Daniel
	Barkalow's message of "Sun, 5 Nov 2006 13:50:11 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30982>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ggnnv-00086E-DR for gcvg-git@gmane.org; Sun, 05 Nov
 2006 20:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161683AbWKEThL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 14:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161682AbWKEThL
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 14:37:11 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:65215 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S1161684AbWKEThK
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 14:37:10 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061105193709.TLQE6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Sun, 5
 Nov 2006 14:37:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id j7dE1V00G1kojtg0000000 Sun, 05 Nov 2006
 14:37:14 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
Sender: git-owner@vger.kernel.org

Daniel Barkalow <barkalow@iabervon.org> writes:

> Usually, I use the same computer to do this multiple times in a row, and 
> it's a bit inconvenient that, after pushing local "for-mainline" to remote 
> "master", I have to fetch remote "master" to local "mainline". It would be 
> nice if git would update local tracking of remote refs when it pushes to 
> those remote refs.

I recall discussing this exact behaviour with Pasky when he
added it to Cogito.  I think we concluded that it is a very
sensible thing to pretend we fetched immediately after we
successfully pushed and got the same thing back, and there is no
risk of data loss or user confusion, as long as we catch failure
from the push and refrain from doing this update, which Cogito
did implement correctly when we discussed this.


