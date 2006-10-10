From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Mon, 09 Oct 2006 22:10:27 -0700
Message-ID: <7vy7ro7o3g.fsf@assigned-by-dhcp.cox.net>
References: <20061007141043.16912.73982.stgit@rover>
	<20061007184418.64881.qmail@web31812.mail.mud.yahoo.com>
	<eg8tpu$drj$1@sea.gmane.org> <20061007191246.GF20017@pasky.or.cz>
	<20061009205551.GO20017@pasky.or.cz>
	<7vslhx9k6c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 07:10:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GX9sw-0002nQ-HO
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 07:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWJJFKa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 01:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbWJJFKa
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 01:10:30 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:30090 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S964971AbWJJFK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 01:10:28 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061010051028.GTWH12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Oct 2006 01:10:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YVAW1V00u1kojtg0000000
	Tue, 10 Oct 2006 01:10:31 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <7vslhx9k6c.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 09 Oct 2006 15:52:11 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28601>

Junio C Hamano <junkio@cox.net> writes:

> Petr Baudis <pasky@suse.cz> writes:
>
>> This is the count of actions invoked from the tree, commit and
>> commitdiff view (using the referer information):
>>
>>     blame  blob   total requests containing 'a='
>> #2  1      18     264
>> #1  31     23     399
>> #0  4      6      50
>>
>> The disparation between #2 and #1,#0 is quite apparent. If we want more
>> exact results, I will let #0 accumulate data for a week and then revert
>> the removal of the links and start another sample.
>
> I am not sure -- you are certainly counting me looking at your
> blame output while working on the slimmed down blame output (you
> may remember that I noted that while your output gives names and
> dates for each line which is busier I kind of liked it in one of
> my previous messages), and we talked about gitweb blame lot
> recently on the list so that might have spurred people's
> curiosity.

Having said that, I agree to the point you are trying to make
here.  It was a mistake to remove blob/tree links from the view
that lists pathnames.

If we did not have any obviously clickable links on the right
hand side it might have been a different story, but when given
UNIXy permission bits, pathname and blame/history/raw links,
nobody would think of clicking on the pathname itself to grab
its contents.  The blame link would give you the same
information (and a bit more) and people would just go there
without much thinking.

It probably is wise to resurrect those "redundant" links.
