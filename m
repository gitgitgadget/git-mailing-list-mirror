From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Remove tab character from conflicted files list part of the merge message
Date: Wed, 14 Mar 2007 02:26:15 -0700
Message-ID: <7vslc8ch1k.fsf@assigned-by-dhcp.cox.net>
References: <200703131309.43767.andyparkins@gmail.com>
	<Pine.LNX.4.63.0703131539430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 14 10:26:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRPkT-0005hL-MV
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 10:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030779AbXCNJ0R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 05:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030790AbXCNJ0R
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 05:26:17 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:55408 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030779AbXCNJ0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 05:26:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314092616.DGDR748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 05:26:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aZSF1W00H1kojtg0000000; Wed, 14 Mar 2007 05:26:15 -0400
In-Reply-To: <Pine.LNX.4.63.0703131539430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 13 Mar 2007 15:42:03 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42190>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 13 Mar 2007, Andy Parkins wrote:
> ...
>> Was appearing in the log display as
>> 
>> Conflicts:
>>         file.c
>>      * Chose upstream version over mine, but integrated my small typo fix.
>> 
>> Which isn't how I'd intended at all.
>> 
>> The fix is of course - no tabs.  Tabs for formatting is always going to 
>> cause trouble, so this patch swaps the tab for spaces.
>
> And of course the next guy will have the reverse problem, because he typed 
> <TAB><SPACE> instead of <SPACE>*5. What do you tell _him_ after "fixing" 
> this issue? "Do as _I_ do"?

Actually, tabs are for indent and everybody knows that.  In
Andy's example, I think the bug is in typing spaces before the
explanatory message "* Chose upstream...".  An obvious fix is to
type a tab instead.

Non-email pretty formats give 4-space margin at the left, and it
indeed is annoying if you drew ascii art in the commit message
and later discover you mistakenly used tab when you meant
spaces.

Having said that, I do not have a strong feeling either way.  If
I have to choose, I would probably replace the TAB with two
spaces, if only to match merge.summary output:

        Merge branch 'blah'

        * blah:
          third commit on blah topic
          second commit on blah topic
          first commit on blah topic

        Conflicts:

          blah.c
          xyzzy.h
