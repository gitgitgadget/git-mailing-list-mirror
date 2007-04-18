From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 22:04:37 -0700
Message-ID: <7vlkgqjmsa.fsf@assigned-by-dhcp.cox.net>
References: <200704171041.46176.andyparkins@gmail.com> <"200704171803.58940.a
	n dyparkins"@gmail.com> <200704172012.31280.andyparkins@gmail.com>
	<alpine.LFD.0.98.0704171530220.4504@xanadu.home>
	<Pine.LNX.4.63.0704171244450.1696@qynat.qvtvafvgr.pbz>
	<alpine.LFD.0.98.0704171624190.4504@xanadu.home>
	<Pine.LNX.4.63.0704171302200.1696@qynat.qvtvafvgr.pbz>
	<alpine.LFD.0.98.0704171708360.4504@xanadu.home>
	<7vy7kqlj5r.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704172154160.4504@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Lang <david.lang@digitalinsight.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 07:04:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He2LS-0001os-DV
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 07:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbXDRFEj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 01:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbXDRFEj
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 01:04:39 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:37041 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212AbXDRFEi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 01:04:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070418050438.SRIS1257.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 18 Apr 2007 01:04:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id oV4d1W00C1kojtg0000000; Wed, 18 Apr 2007 01:04:37 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44862>

Nicolas Pitre <nico@cam.org> writes:

> On Tue, 17 Apr 2007, Junio C Hamano wrote:
>
>> You have to be careful, though.  Depending on what kind of
>> transformation you implement with the external tools, you would
>> end up having to slow down everything we would do.
>
> So what?  
>
> We provide a rope with proper caveat emptor.  Up to others to hang 
> themselves with it if they so desire.  It is not our problem anymore.

I sort-of find it hard to believe hearing this from somebody who
muttered something about importance of perception a few days ago.

>> I suspect that you would have to play safe and say "when
>> external tools are involved, we need to disable the existing
>> content SHA-1 based optimization for all paths that ask for
>> them" to keep your sanity.
>
> Maybe.  If that is what's really needed then so be it.  People who 
> really want to do strange things will have the flexibility to do so, but 
> they'll have to pay the price in loss of performance.

Not just that.  We end up having to pay the price of maintaining
hooks to let them do crazy things.
