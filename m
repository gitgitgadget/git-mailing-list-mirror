X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: prune/prune-packed
Date: Fri, 27 Oct 2006 14:55:13 -0700
Message-ID: <7vy7r1ctku.fsf@assigned-by-dhcp.cox.net>
References: <20061022035919.GA4420@fieldses.org>
	<7vy7r954k7.fsf@assigned-by-dhcp.cox.net>
	<20061022231422.GA9375@fieldses.org>
	<20061023005336.GA12932@fieldses.org> <453C1A35.70504@gmail.com>
	<7vvembzp6y.fsf@assigned-by-dhcp.cox.net>
	<1161983997.2426.422.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 21:55:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <1161983997.2426.422.camel@cashmere.sps.mot.com> (Jon Loeliger's
	message of "Fri, 27 Oct 2006 16:19:57 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30350>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdZfc-0007fW-4b for gcvg-git@gmane.org; Fri, 27 Oct
 2006 23:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750705AbWJ0VzQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 17:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWJ0VzQ
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 17:55:16 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:665 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1750705AbWJ0VzO
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 17:55:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061027215514.SHQT28934.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Fri, 27
 Oct 2006 17:55:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id fZuv1V00S1kojtg0000000 Fri, 27 Oct 2006
 17:54:56 -0400
To: Jon Loeliger <jdl@freescale.com>
Sender: git-owner@vger.kernel.org

Jon Loeliger <jdl@freescale.com> writes:

> On Sun, 2006-10-22 at 22:27, Junio C Hamano wrote:
>
>> Sorry, but you are right and Linus is more right.  How about
>> doing FRSX.
>> 
>> diff --git a/pager.c b/pager.c
>> index 8bd33a1..4587fbb 100644
>> --- a/pager.c
>> +++ b/pager.c
>> @@ -50,7 +50,7 @@ void setup_pager(void)
>>  	close(fd[0]);
>>  	close(fd[1]);
>>  
>> -	setenv("LESS", "FRS", 0);
>> +	setenv("LESS", "FRSX", 0);
>>  	run_pager(pager);
>>  	die("unable to execute pager '%s'", pager);
>>  	exit(255);
>
> I'm a little confused by all this because I
> set the LESS environment variable by myself
> already.  And I use the value that I like.
> Why change it or override the user's settings
> like this?  Or did I miss something?

This is about "if user does not set it, use this default".

