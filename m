X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH 4/10] Add current branch in PS1 support to
 git-completion.bash.
Date: Mon, 27 Nov 2006 12:26:53 -0500
Message-ID: <BAYC1-PASMTP109DA8BB360DD64E76B7B0AEE60@CEZ.ICE>
References: <de7beb117fb963e68e1085b773593be326ffd495.1164616814.git.spearce@spearce.org>
	<20061127084128.GD19745@spearce.org>
	<20061127103111.4835bffc.seanlkml@sympatico.ca>
	<20061127165122.GB6616@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 27 Nov 2006 17:27:31 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.74]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061127122653.3e801d7a.seanlkml@sympatico.ca>
In-Reply-To: <20061127165122.GB6616@spearce.org>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 27 Nov 2006 17:31:01.0265 (UTC) FILETIME=[CEAC2810:01C71249]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GokFv-0003ds-SI for gcvg-git@gmane.org; Mon, 27 Nov
 2006 18:27:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758458AbWK0R04 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 12:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758459AbWK0R04
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 12:26:56 -0500
Received: from bayc1-pasmtp10.bayc1.hotmail.com ([65.54.191.170]:42475 "EHLO
 BAYC1-PASMTP10.bayc1.hotmail.com") by vger.kernel.org with ESMTP id
 S1758456AbWK0R0z (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006
 12:26:55 -0500
Received: from linux1.attic.local ([65.93.43.74]) by
 BAYC1-PASMTP10.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Mon, 27 Nov 2006 09:31:01 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GojJk-0006rd-BD; Mon, 27 Nov 2006 11:26:52 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Mon, 27 Nov 2006 11:51:23 -0500
Shawn Pearce <spearce@spearce.org> wrote:

> I actually started with the name __git_current_branch but changed
> my mind on that and went with __git_ps1.
> 
> My rationale at the time was probably not correct (it was early this
> morning) but I figured that the current branch name is "master"
> while __git_ps1 prints " (master)".  Therefore __git_ps1 is not
> really printing the current branch, its printing the current branch
> and other stuff.  So I went with a name which implied its purpose.

Ahh, I had missed that, it makes some sense.  Although it goes a bit
against the commit message that the user is free to construct whatever
PS1 format they like (ie. they're stuck with parenthesis around the
branch name).

Just thinking out loud, what about allowing __git_ps1 to take a
format string of its own?  It could parse options like  "(\b)"
to mean git branch surrounded by parenthesis.  But you could
also do "[\b]" or "!\b" if you preferred.

Then adding additional options would be easy, like "\r" for
repo relative path etc... and the user really could create just
about any git prompt they wanted.  Of course, if __git_ps1
sees it's not in a git directory, it would always return an
empty string.

But that's maybe all too complicated to be worthwhile.  It's
something that could be considered for the git --show-ps1 option
though.

