X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Bug in merge-recursive in virtual commit corner case
Date: Thu, 07 Dec 2006 22:01:52 -0800
Message-ID: <7vd56vorhr.fsf@assigned-by-dhcp.cox.net>
References: <20061207083531.GA22701@spearce.org>
	<Pine.LNX.4.63.0612071636030.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<20061207192401.GB12143@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 06:02:05 +0000 (UTC)
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061207192401.GB12143@spearce.org> (Shawn Pearce's message of
	"Thu, 7 Dec 2006 14:24:01 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33659>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsYo5-00006T-Ex for gcvg-git@gmane.org; Fri, 08 Dec
 2006 07:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424713AbWLHGBz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 01:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424724AbWLHGBz
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 01:01:55 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:52890 "EHLO
 fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1424722AbWLHGBy (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 01:01:54 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061208060153.FPAP3525.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Fri, 8
 Dec 2006 01:01:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id w6231V0141kojtg0000000; Fri, 08 Dec 2006
 01:02:04 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> Although Junio mentioned he recently saw something like this in
> git.git when he merged in your xdl_merge() code.  I wonder if its
> the same issue.

No, that is not related at all.  My initial attempt (which is
not in any commit that survives til today) used hash_sha1_file()
on the result from xdl_merge() where I should have used
write_sha1_file(), and I saw the same "oh, the required object
is not there" errors from everywhere.

