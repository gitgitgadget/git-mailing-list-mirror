X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-cvsimport: add suport for CVS pserver method HTTP/1.x proxying
Date: Thu, 23 Nov 2006 18:54:32 -0800
Message-ID: <7vvel5ftav.fsf@assigned-by-dhcp.cox.net>
References: <11642344172790-git-send-email-iarenuno@eteo.mondragon.edu>
	<7v64d5keke.fsf@assigned-by-dhcp.cox.net>
	<45661C36.9010101@catalyst.net.nz>
	<7vlkm1ix7b.fsf@assigned-by-dhcp.cox.net>
	<46a038f90611231552x3e33eec4w7863ce6a1da5781b@mail.gmail.com>
	<20061124014205.GA19515@sigio.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 03:02:50 +0000 (UTC)
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061124014205.GA19515@sigio.intra.peff.net> (Jeff King's
	message of "Thu, 23 Nov 2006 20:42:05 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32186>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnRD5-0007ci-Qe for gcvg-git@gmane.org; Fri, 24 Nov
 2006 03:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757509AbWKXCye (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 21:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757578AbWKXCye
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 21:54:34 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:55937 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1757509AbWKXCyd
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 21:54:33 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061124025433.SEKX5575.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Thu, 23
 Nov 2006 21:54:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qSug1V00Z1kojtg0000000; Thu, 23 Nov 2006
 21:54:41 -0500
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Nov 24, 2006 at 12:52:13PM +1300, Martin Langhoff wrote:
>
>> You are right. It should be something along the lines of
>> 
>>  # discard headers until first blank line
>>  while (<$s> ne '') {
>>      # nothing
>>  }
>> 
>> that is, assuming we can just ignore headers happily.
>
> That code won't work; the value of a blank line will actually be "\n"
> (or "\r\n").

Good point.  For an HTTP proxy the kosher line termination would
indeed be "\r\n".
