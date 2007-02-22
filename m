From: Bill Lear <rael@zopyra.com>
Subject: Re: How to say HEAD~"all the way back - 1"
Date: Thu, 22 Feb 2007 14:24:21 -0600
Message-ID: <17885.64501.15547.465411@lisa.zopyra.com>
References: <17885.60477.53356.123095@lisa.zopyra.com>
	<7vodnmdk8y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 22 21:24:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKKUr-0000iL-VT
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 21:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbXBVUYd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 15:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbXBVUYd
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 15:24:33 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60348 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842AbXBVUYc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 15:24:32 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1MKOQ225886;
	Thu, 22 Feb 2007 14:24:26 -0600
In-Reply-To: <7vodnmdk8y.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40379>

On Thursday, February 22, 2007 at 12:12:45 (-0800) Junio C Hamano writes:
>Bill Lear <rael@zopyra.com> writes:
>
>> Git "indexing" of commits has a way to "go back":
>>
>> % git diff HEAD~3
>>
>> Can I say "all the way back", or "all the way back - 1" somehow?
>
>Sorry, there is no such shorthand, but you could obviously say:
>
>	$ git rev-list --parents HEAD | grep -v ' '
>
>A way to find the root commit seems to be one of the things
>people new to git want at least once, once they start futzing
>with the tool.  But I suspect that is only because they need
>that information to see how the tool works (say "what different
>output would I get out of 'git show $commit' for root and other
>commits?"), and not because they need that information for any
>real life use.
>
>Really, what useful purpose does it serve for you to find out
>the root commit, OTHER THAN being able to say "the development
>history of this project starts at this commit"?

Just today, I got a bug report from one of our developers.
The git update hook we had in place before the conversion
to 1.5 had this:

chmod -R ug+w $GIT_DIR

to avoid problems when people used 'git ssh://...", due to
different umasks (yeah, a hack).

So, moving to 1.5, I updated our script (and, had been updating it for
quite some time, so many revisions, maybe 20 or so), and well,
now when people use ssh, they leave behind directories others
can't read (as git now allows push through "git://", we'll be
weaning people off of ssh soon).

So, I wanted to say "give me the first version of this, so I
can cut-n-paste the chmod command, since I can't remember if it
was chmod, or chown, or some combination ...", and thus the desire
to to:

% git log -p HEAD~"All the way back" update

or something similar.


Bill
