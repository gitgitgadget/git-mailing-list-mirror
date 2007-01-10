From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all entries
Date: Wed, 10 Jan 2007 10:06:39 -0800
Message-ID: <7v3b6ibvtc.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com>
	<Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com>
	<7v8xgileza.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
	<20070107163112.GA9336@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 10 19:07:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4hrP-0001dw-7P
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 19:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbXAJSGw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 13:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbXAJSGw
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 13:06:52 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:50960 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965011AbXAJSGv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 13:06:51 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070110180649.KSHW25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Wed, 10 Jan 2007 13:06:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9W5y1W00U1kojtg0000000; Wed, 10 Jan 2007 13:05:59 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20070107163112.GA9336@steel.home> (Alex Riesen's message of
	"Sun, 7 Jan 2007 17:31:12 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36519>

fork0@t-online.de (Alex Riesen) writes:

> Alex Riesen, Fri, Jan 05, 2007 12:22:39 +0100:
>> >So let's step back a bit.
>> 
>> Excellent analysis, thanks! I suspect heavily it will work as is.
>> Now, if only someone could find time to code it up...
>> 
>
> I'm sorry for asking (because I'm partly guilty in the mess the
> merge-recursive is), but could you accept at least the patch which
> started the thread? It's not as if it breaks something, or giving
> wrong ideas, or anything. It's incomplete, but so long noone seem to
> be able to find the time to finish the job, the patch will improve the
> state of affairs a bit, will it not?

I'm hacking on this right now.
