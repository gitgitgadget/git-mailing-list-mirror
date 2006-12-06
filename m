X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 06 Dec 2006 14:14:31 -0800
Message-ID: <7vmz60y8mw.fsf@assigned-by-dhcp.cox.net>
References: <7vvekoyb79.fsf@assigned-by-dhcp.cox.net>
	<el7dsn$9a6$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 22:14:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <el7dsn$9a6$1@sea.gmane.org> (Jakub Narebski's message of "Wed,
	06 Dec 2006 22:51:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33529>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs52C-00010Q-LA for gcvg-git@gmane.org; Wed, 06 Dec
 2006 23:14:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937717AbWLFWOd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 17:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937722AbWLFWOd
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 17:14:33 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:41880 "EHLO
 fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937717AbWLFWOc (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 17:14:32 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061206221432.THFU9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Wed, 6
 Dec 2006 17:14:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vaEh1V00r1kojtg0000000; Wed, 06 Dec 2006
 17:14:42 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

>> * jc/3way (Wed Nov 29 18:53:13 2006 -0800)
>>  + git-merge: preserve and merge local changes when doing fast forward
>> 
>>  This allows you to run a 'git merge' (or 'git pull') that
>>  results in a fast-forward merge that updates a path your
>>  working tree has modified locally; it merges your local changes
>>  into the updated version, in the same way the branch switching
>>  'git checkout -m' works.  It has been in next for some time and
>>  unless we hear somebody scream I think it is Ok to merge to
>>  'master'.
>
> Very nice. Less suprises for CVS users (with "update then commit"
> mentality/habits).

This only makes "update; edit; update; commit" to work.  "edit;
commit; edit; commit; edit; update; commit" would not work,
because you would be faced to resolving the conflicts upon the
last update while your working tree is already contaminated with
your own changes (it can be done and experienced people have
done so, but you are talking about "CVS users" here).

We'd be much better off to encourage users to shake "update then
commit" habit, especially if they are on a slow link.

>> * jc/web (Wed Nov 8 14:54:09 2006 -0800)
>>  - gitweb: steal loadavg throttle from kernel.org
>
> Is having loadavg in gitweb, and not configured in server good idea?

Have you looked at the code to see what it does?

>> * lh/branch-rename (Thu Nov 30 03:16:56 2006 +0100)
>>  + git-branch: let caller specify logmsg
>>  + rename_ref: use lstat(2) when testing for symlink
>>  + git-branch: add options and tests for branch renaming
>> 
>>  I do not rename branches myself and do not see a need for this
>>  nor I have tested it in real-world setting.  The code seemed
>>  clean and may be 'master' material.
>
> I'd like to have this, but it MUST work well with reflogs for me.

Then test it and fix breakage if any please.
