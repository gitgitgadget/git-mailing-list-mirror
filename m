X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] mimic unpack-objects when --stdin is used with index-pack
Date: Thu, 26 Oct 2006 00:55:03 -0700
Message-ID: <7vmz7jqzoo.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610252330320.12418@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 07:59:51 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0610252330320.12418@xanadu.home> (Nicolas Pitre's
	message of "Wed, 25 Oct 2006 23:31:53 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30147>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd09O-0003hO-RM for gcvg-git@gmane.org; Thu, 26 Oct
 2006 09:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752032AbWJZH7V (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 03:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034AbWJZH7V
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 03:59:21 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:19452 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1752032AbWJZH7V
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 03:59:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061026075503.FWCH18180.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Thu, 26
 Oct 2006 03:55:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id evum1V02G1kojtg0000000 Thu, 26 Oct 2006
 03:54:46 -0400
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> It appears that git-unpack-objects writes the last part of the input
> buffer to stdout after the pack has been parsed.  This looks a bit
> suspicious since the last fill() might have filled the buffer up to
> the 4096 byte limit and more data might still be pending on stdin,
> but since this is about being a drop-in replacement for unpack-objects
> let's simply duplicate the same behavior for now.

This seems to break t5300 when applied on top of everything
else.  The other two numbered patches are Ok.
