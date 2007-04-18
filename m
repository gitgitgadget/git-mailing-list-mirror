From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] Custom low-level merge driver support.
Date: Wed, 18 Apr 2007 08:56:25 -0700
Message-ID: <7vps61isly.fsf@assigned-by-dhcp.cox.net>
References: <11768880622402-git-send-email-junkio@cox.net>
	<Pine.LNX.4.64.0704181247410.12094@racer.site>
	<20070418153445.GC12888@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 17:56:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeCWT-0006kU-SS
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 17:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046AbXDRP41 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 11:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754030AbXDRP41
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 11:56:27 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:61186 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046AbXDRP40 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 11:56:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070418155627.DUWY1257.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Apr 2007 11:56:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ofwR1W0151kojtg0000000; Wed, 18 Apr 2007 11:56:26 -0400
In-Reply-To: <20070418153445.GC12888@admingilde.org> (Martin Waitz's message
	of "Wed, 18 Apr 2007 17:34:45 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44902>

Martin Waitz <tali@admingilde.org> writes:

> On Wed, Apr 18, 2007 at 12:48:48PM +0200, Johannes Schindelin wrote:
>> On Wed, 18 Apr 2007, Junio C Hamano wrote:
>> 
>> > 	[merge]
>> > 		driver = ancient merge %A %O %B
>> 
>> Why not do something like
>> 
>> 	[merge.driver]
>> 		ancient = merge %A %O %B
>
> or
>
> [merge "ancient"]
> 	driver = merge %A %O %B

Actually, I've considered the latter.

Johannes's goes against the usual three-level configuration
variable naming rules.  If you have 'user definable' part in the
name, that should be at the second level.

Which yours does.

The only reason I did not do it your way was because we would
need to have three lines per driver (one [merge "foo"] section
per driver, a "driver" line, and a blank line for readability
after that), which at the time I wrote it felt a bit wasteful,
and it was late.  But I think I like yours much better.

It probably is trivial to change the rule before it hits 'next'.
