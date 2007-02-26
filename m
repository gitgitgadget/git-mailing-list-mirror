From: Junio C Hamano <junkio@cox.net>
Subject: Re: Unresolved issues
Date: Sun, 25 Feb 2007 19:39:08 -0800
Message-ID: <7vtzx9oaeb.fsf@assigned-by-dhcp.cox.net>
References: <7virdx1e58.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702260112160.12555@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sbejar@gmail.com
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Feb 26 04:39:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLWht-0002hc-Vl
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 04:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933745AbXBZDjK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 22:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933746AbXBZDjK
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 22:39:10 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:60704 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933745AbXBZDjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 22:39:09 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070226033908.WSWP2670.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Feb 2007 22:39:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id U3f71W00T1kojtg0000000; Sun, 25 Feb 2007 22:39:08 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40608>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> On Mon, 19 Feb 2007, Junio C Hamano wrote:
>
>> * "git fetch" between repositories with hundreds of refs.
>>
>> 	$gmane/39330
>>
>>  There are partial rewrite of the most expensive parts of git-fetch in
>>  C parked in 'pu'.  It might be good enough for public consumption
>>  without going the whole nine yards.  I dunno.  I am not very keen on
>>  rewriting all of "git fetch" in C right now, as people seem to be
>>  still interested in touching it (including "git bundle" topic).
>
> The current changes in jc/fetch take things from "unusable" to "a bit
> slow", which I think could quite easily be considered a separate task
> from "a bit slow" to "something that even Linus would consider
> reasonable".  So my opinion would be to get the current improvements
> in so that they can be combined with the other good work happening in
> this area, and wait for things to settle before going the last mile
> (after all anyone converting from Subversion or CVS probably won't
> find 30s to be slow anyway ... ;)).

I was kind of waiting for dust from Santi's code shuffling to
settle down, because the series moderately conflicts with it.  I
wanted to take Santi's patch first as it was supposed to be a
clean-up without any functionality changes, although it was kind
of painful to really make sure there is no regression.

If what jc/fetch topic tries to do helps real users, let's merge
it in 'next' first, as Santi's change is not supposed to bring
any improvements by itself even when it proves regression-free.

In the short term, this means we have to ask Santi to rebase his
patch instead of the other way around as I planned first, which
is a bit unfortunate.
