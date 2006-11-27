X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: git-PS1 bash prompt setting
Date: Mon, 27 Nov 2006 12:38:30 -0500
Message-ID: <BAYC1-PASMTP0709A31FDE4B0DBA4174E9AEE60@CEZ.ICE>
References: <BAYC1-PASMTP037FDA6C6465F0541AC613AEE90@CEZ.ICE>
	<Pine.LNX.4.63.0611261524130.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	<20061126094212.fde8cce7.seanlkml@sympatico.ca>
	<20061127065400.GA19174@spearce.org>
	<20061127075650.81a5a850.seanlkml@sympatico.ca>
	<20061127170249.GC6616@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 27 Nov 2006 17:38:55 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.74]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061127123830.e8285b77.seanlkml@sympatico.ca>
In-Reply-To: <20061127170249.GC6616@spearce.org>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 27 Nov 2006 17:44:59.0859 (UTC) FILETIME=[C2837230:01C7124B]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GokRA-0006Td-CB for gcvg-git@gmane.org; Mon, 27 Nov
 2006 18:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758438AbWK0Rid (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 12:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758339AbWK0Rid
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 12:38:33 -0500
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:53320 "EHLO
 BAYC1-PASMTP07.CEZ.ICE") by vger.kernel.org with ESMTP id S1756058AbWK0Rid
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 12:38:33 -0500
Received: from linux1.attic.local ([65.93.43.74]) by BAYC1-PASMTP07.CEZ.ICE
 over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); Mon, 27 Nov
 2006 09:44:59 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GojUz-0006tF-FH; Mon, 27 Nov 2006 11:38:29 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Mon, 27 Nov 2006 12:02:49 -0500
Shawn Pearce <spearce@spearce.org> wrote:

> When I originally coded the first version of __git_ps1 I was using
> it on a Cygwin system, where the fork+exec of the external script
> can take a little while.  The time to fork+exec two programs (script
> and then git) is huge compared to just fork+exec of git by itself,
> so I coded it as a function.  On the other hand my Mac OS X system
> doesn't even blink at either implementation.

For sure, that's probably the reason that it was suggested to be
included as a built-in, it would reduce the overhead.

> I'm not sure that's worth implementing in the core code.
> Most shells that will let you invoke a command as part of their
> prompt generation will also let you use builtin functions and do
> some basic string manipulation (e.g. like I do above with bash).
> At which point it is say 5 lines of shell (nicely formatted) to
> craft a prompt string vs. 15-20 lines of C to parse the option,
> read HEAD, and craft a prompt string.

Well, as per my previous message, it might be a little more worthwhile
if it did things like parse an additional format string which let
you reference config variables and relative directory etc.
It would give a lot of flexibility as to what someone wanted to
use as their PS1 when inside a git repo.
 
> If someone else contributes a --show-ps1 option that is useable as
> a replacement for my __git_ps1 I'll gladly jump on board and change
> to using it, but I just don't see a reason to write it myself.

Yeah.. __git_ps1 could just call "git --show-ps1" if it ever comes
into existence ;o)

