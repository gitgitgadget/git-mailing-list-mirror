X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-svn bug?
Date: Wed, 15 Nov 2006 13:43:30 -0800
Message-ID: <7vejs4jshp.fsf@assigned-by-dhcp.cox.net>
References: <op.ti2svo0ozidtg1@rygel.lnxi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 21:43:54 +0000 (UTC)
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <op.ti2svo0ozidtg1@rygel.lnxi.com> (Troy Telford's message of
	"Wed, 15 Nov 2006 14:05:37 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31506>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkSXu-0007a2-L0 for gcvg-git@gmane.org; Wed, 15 Nov
 2006 22:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161748AbWKOVnr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 16:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161749AbWKOVnr
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 16:43:47 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:25014 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1161748AbWKOVnq
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 16:43:46 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115214346.CAWP5575.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Wed, 15
 Nov 2006 16:43:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id n9js1V00E1kojtg0000000; Wed, 15 Nov 2006
 16:43:52 -0500
To: "Troy Telford" <ttelford.groups@gmail.com>
Sender: git-owner@vger.kernel.org

"Troy Telford" <ttelford.groups@gmail.com> writes:

> (using git 1.4.4, svn 1.3.1 on a SLES 10 box)
> fatal: Not a valid object name 92e2e0c50bbbacb0a3426b2c0f8b3e043eb4830a~1
> 32768 at /usr/lib/perl5/5.8.8/Memoize.pm line 269
>...
> I couldn't find an object named
> "92e2e0c50bbbacb0a3426b2c0f8b3e043eb4830a~1" in .git/

Troy, do you have object 92e2e0c5?  Is it a root commit (i.e. a
commit that does not have a parent)? 

The only place that mentions ~1 in git-svn seems to be inside
dcommit but it seems that it unconditionally appends ~1 to the
rev.  I do not know how the code guarantees it does not go down
to the root commit.

Eric, any clues?
