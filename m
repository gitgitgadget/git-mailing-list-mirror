From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT vs Other: Need argument
Date: Mon, 23 Apr 2007 15:23:38 -0700
Message-ID: <7vps5ud91x.fsf@assigned-by-dhcp.cox.net>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
	<20070417104520.GB4946@moonlight.home>
	<8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
	<200704171818.28256.andyparkins@gmail.com>
	<20070417173007.GV2229@spearce.org> <462521C7.2050103@softax.com.pl>
	<Pine.LNX.4.64.0704181130150.12094@racer.site>
	<alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
	<Pine.LNX.4.64.0704191118050.8822@racer.site>
	<alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org>
	<4627ABBB.8060709@softax.com.pl>
	<alpine.LFD.0.98.0704191341370.9964@woody.linux-foundation.org>
	<877is29b1l.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 00:23:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg6wi-0006Iw-8M
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 00:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754312AbXDWWXl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 18:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754362AbXDWWXk
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 18:23:40 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:65107 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754315AbXDWWXk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 18:23:40 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070423222339.LTAO1257.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Apr 2007 18:23:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id qmPd1W00j1kojtg0000000; Mon, 23 Apr 2007 18:23:38 -0400
In-Reply-To: <877is29b1l.wl%cworth@cworth.org> (Carl Worth's message of "Mon,
	23 Apr 2007 11:54:14 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45371>

Carl Worth <cworth@cworth.org> writes:

> When I raised this recently, Junio suggested something like the
> following:
>
> 	git config --global branch.autosetupmerge true	[*]
> 	git clone <URL>
> 	git checkout -b <branch> origin/<branch>
> 	git pull
>
> I haven't gotten around to replying to that message yet, but the
> thrust of my reply would be that that does actually work, but it's not
> even close to the ease with which one can track the default branch as
> Linus described:
>
>>    None of the above are ever really needed for that case, and I think all
>>    you really want to learn is:
>>
>> 	git clone
>> 	git pull
>
> So, currently, all non-default branches have a sort of second-class
> status from the point of view of users that just want to track
> them.

It is true that non default ones are second class status.
That's why they are not "default" ;-).

The autosetup configuration needs to be done once for the user
(not tied to any project), so you are talking about difference
between:

	git clone
        git pull
        git pull
        git pull
        git pull
        git pull
	...

vs

	git clone
        git checkout -b next origin/next
        git pull
        git pull
        git pull
        git pull
        git pull
	...

'git clone' step in both are done only once per project's
working tree, 'git checkout -b' step is done once for the
particular branch you are interested in, and after that you will
doing 'git pull' every day or every minute.  I do not think one
extra step is a big enough deal to make second class citizens
scream about inequality.
