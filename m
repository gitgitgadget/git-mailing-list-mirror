X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: git bug? + question
Date: Thu, 2 Nov 2006 22:45:49 -0500
Message-ID: <BAYC1-PASMTP041E1FB36F85221E4E1FB4AEFE0@CEZ.ICE>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com>
	<7v4pthmew1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 03:46:24 +0000 (UTC)
Cc: Miles Bader <miles@gnu.org>, git@vger.kernel.org,
	Karl =?ISO-8859-1?B?SGFzc2Vsc3Ry9m0=?= <kha@treskal.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061102224549.499610d1.seanlkml@sympatico.ca>
In-Reply-To: <7v4pthmew1.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 03 Nov 2006 03:45:51.0255 (UTC) FILETIME=[8E7E2A70:01C6FEFA]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfq0U-0001I0-J2 for gcvg-git@gmane.org; Fri, 03 Nov
 2006 04:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753006AbWKCDpw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 22:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753028AbWKCDpw
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 22:45:52 -0500
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:55038 "EHLO
 BAYC1-PASMTP04.bayc1.hotmail.com") by vger.kernel.org with ESMTP id
 S1753006AbWKCDpv (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006
 22:45:51 -0500
Received: from linux1.attic.local ([65.93.43.81]) by
 BAYC1-PASMTP04.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Thu, 2 Nov 2006 19:45:50 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1Gfp40-0003a1-TS; Thu, 02 Nov 2006 21:45:48 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Thu, 02 Nov 2006 18:40:30 -0800
Junio C Hamano <junkio@cox.net> wrote:

> which is efficient (guaranteed to do only one fetch from remote)
> and convenient.  Also I have Push: mapping set up on my
> main machine to do master:origin, next:next, maint:maint, and
> +pu:pu so that I can replace the first "git pull" on the
> secondary machine with "git push secondary" on my main machine.

One thing that would make separate-remotes nicer to work with
is to have an automatic mapping between any local branch and
one of the same name in remotes.

So for instance, if you have a local branch named pu checked
out and you pull from origin, remotes/origin/pu would be merged
after the fetch unless a manual mapping was defined in the
remotes or config file.

Maybe even going as far as automatically creating a local branch
for each remote branch on clone is worth considering.

On a peripherally related topic, someone on the xorg list was
complaining that after the initial clone, there is no easy way
to track branches that get added/deleted from the remote repo.
It would be nice if pull had an option to automatically add
and remove remote branches from the remotes/<remote>/xxx
namespace.

