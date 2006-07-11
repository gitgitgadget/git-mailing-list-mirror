From: Junio C Hamano <junkio@cox.net>
Subject: Re: Items not covered by repository-layout.txt
Date: Mon, 10 Jul 2006 17:23:21 -0700
Message-ID: <7vlkr16lc6.fsf@assigned-by-dhcp.cox.net>
References: <e8ue98$o7t$1@sea.gmane.org>
	<7v1wstb12x.fsf@assigned-by-dhcp.cox.net> <e8uhjg$5o1$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 02:23:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0629-00006h-Fm
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 02:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWGKAXX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 20:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWGKAXW
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 20:23:22 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:10148 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751333AbWGKAXW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 20:23:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060711002321.ELCC22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Jul 2006 20:23:21 -0400
To: jnareb@gmail.com
In-Reply-To: <e8uhjg$5o1$1@sea.gmane.org> (Jakub Narebski's message of "Mon,
	10 Jul 2006 23:42:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23673>

Jakub Narebski <jnareb@gmail.com> writes:

> Could you then tell me what is the format of FETCH_HEAD and what other *_HEADs 
> can be seen in $GIT_DIR (MERGE_HEAD?)?

Which essentially is that you are telling me to do that, but I
am a bit busy this week.

If you can use the source to figure them out, that would be
great; otherwise this can wait or others can chime in.

For FETCH_HEAD fmt-merge-msg and git-pull would be helpful.
The general format is, one entry per line:

	object name <TAB> merge-marker <TAB> notes

where merge-marker is either empty (for commits to be merged by
git-pull that called git-fetch) or not-for-merge, and notes is a
human readable comment that describes where that object came
from.  Note that this is read both by humans _AND_ machine;
fmt-merge-msg relies on how it is stated.

Others "git grep -e _HEAD -- '*.sh'" perhaps.

	ORIG_HEAD - used to keep the value of HEAD before we do
                    anything we might regret

	MERGE_HEAD - one or more commit object names that are
                    being merged into the current branch during
                    a merge.

	MERGE_MSG - generated message for an automerge.
