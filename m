From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-rev-parse(1) questions
Date: Mon, 30 Apr 2007 13:20:35 -0700
Message-ID: <7vejm1d370.fsf@assigned-by-dhcp.cox.net>
References: <mz0pwwi3.fsf@cante.net>
	<alpine.LFD.0.98.0704301138320.3419@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 30 22:21:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HicMk-00032B-Nt
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 22:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946763AbXD3UUu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 16:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946760AbXD3UUt
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 16:20:49 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:45189 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946757AbXD3UUg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 16:20:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070430202036.MXLN13903.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Mon, 30 Apr 2007 16:20:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id tYLb1W00T1kojtg0000000; Mon, 30 Apr 2007 16:20:36 -0400
In-Reply-To: <alpine.LFD.0.98.0704301138320.3419@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 30 Apr 2007 11:49:06 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45877>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 30 Apr 2007, Jari Aalto wrote:
>> ...
>>     * A colon, optionally followed by a stage number (0 to 3) and a
>>       colon, followed by a path; this names a blob object in the index
>>       at the given path. Missing stage number (and the colon that
>>       follows it) names an stage 0 entry.
>
> You'd never use this unless you're working with a unmerged tree entry, and 
> then you can use it for things like
>
> 	git diff :1:my-path :2:their-path
>
> if you want to look at the differences between the two blobs that are 
> unmerged, and come from different branches (":1:my-path" comes from the 
> branch you were merging things into,and the ":2:their-path" comes from the 
> branch you were merging from).
>
> That can be useful in the extremely rare case...

A small correction. :1:path comes from the common ancestor,
:2:mine comes from the branch you are on and merging into, and
:3:theirs is what the other branch you were merging from has.

People can see how rarely this is used interactively; even
original authors of git can get it wrong ;-).
