From: Junio C Hamano <junkio@cox.net>
Subject: Re: suggestions for gitweb
Date: Sat, 12 May 2007 15:39:25 -0700
Message-ID: <7v8xbtwtsy.fsf@assigned-by-dhcp.cox.net>
References: <20070512205529.GS14859@MichaelsNB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Niedermayer <michaelni@gmx.at>
X-From: git-owner@vger.kernel.org Sun May 13 00:39:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hn0FR-0006Aa-GA
	for gcvg-git@gmane.org; Sun, 13 May 2007 00:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbXELWj1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 18:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752342AbXELWj1
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 18:39:27 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:42100 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbXELWj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 18:39:26 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070512223926.YGZZ22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 12 May 2007 18:39:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id yNfR1W0051kojtg0000000; Sat, 12 May 2007 18:39:25 -0400
cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20070512205529.GS14859@MichaelsNB> (Michael Niedermayer's
	message of "Sat, 12 May 2007 22:55:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47101>

Michael Niedermayer <michaelni@gmx.at> writes:

> * gitweb uses many terms which are new to a non git user, and while
>   devlopers who work on ffmpeg will very likely very quickly have
>   figured out the meaning of all of them. i think simple users who just
>   want to browse the ffmpeg code will have their problems, so i belive 
>   a small help text linked to from all pages which contains a short
>   definition of all the git(web) specific terms would be very helpfull
>   something like
>     blob        - file      at a specific revission/date
>     tree        - directory at a specific revission/date
>     (short) log - project wide commit log
>     history     - short log equivalent for a file or directory

Coming fron non-CVS camp, I think changing this to non-git terms
is very harmful than educating users who are migrating from
other systems.

> * The color of adjacent blame "hunks" is so similar that its
>   indistinguishable on my notebook TFT when iam looking at it from slightly
>   above

This is more or less intentional to make the difference not too
distracting.  I thought it was controlled via css which
something you can use browser side tricks to suite your taste?

> * The blame page shows the SHA1 for each hunk and IMHO thats the last thing
>   i would want to see first, id be much more interrested in by whom and
>   when a given change was done, iam wondering in which case the SHA1 would
>   be usefull? copy-paste onto your command line git tools but then why
>   use gitweb at all, 'git blame' would make more sense IMHO and a simple
>   click would reveal the sha1 with more info anyway ...

They serve no purpose other than showing something to click on,
and allow you to hover over (some people argued in the past
that they recognize certain commit object names, but honestly I
would not believe them).  However, I do not think there are much
better alternatives.  Try coming up with a different "label"
string that is of uniform length across commits, and does not
chew up too much screen real estate.

> * i either cant find the long history for a file or there is none ("history"
>   is like "short log" and "log" is not file specific) a "long history" link
>   in addition to "history" would be nice

Probably.

> * on the history page there are "blob", "commitdiff" and "diff to current"
>   the obvious missing one is "diff to previous" which would be the diff to
>   the previous blob of this file

Isn't that commitdiff, or commitdiff on that page does not limit
the diff to the blob?

> * the history/log pages could contain some statistics for the commits like
>   the number of files changed and lines added/removed

Probably.

The three last items should be relatively easy, if somebody is
interested.  Pasky, Jakub, what do you think?
