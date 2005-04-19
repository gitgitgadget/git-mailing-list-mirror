From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Change "pull" to _only_ download, and "git update"=pull+merge?
Date: Mon, 18 Apr 2005 22:13:59 -0400
Message-ID: <42646967.9030903@dwheeler.com>
References: <20050416233305.GO19099@pasky.ji.cz> <Pine.LNX.4.21.0504161951160.30848-100000@iabervon.org> <20050419011206.GT5554@pasky.ji.cz>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 04:08:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNiA1-0003xe-TT
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 04:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVDSCMQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 22:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVDSCMQ
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 22:12:16 -0400
Received: from cujo.runbox.com ([193.71.199.138]:48037 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261186AbVDSCMM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 22:12:12 -0400
Received: from [10.9.9.16] (helo=lassie.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DNiDj-0001ED-B6; Tue, 19 Apr 2005 04:12:11 +0200
Received: from [70.17.101.238] (helo=[192.168.2.73])
	by lassie.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DNiDi-0001bB-Q4; Tue, 19 Apr 2005 04:12:11 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050419011206.GT5554@pasky.ji.cz>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a minor UI thing, but what the heck. I propose
changing "pull" to ONLY download, and "update" to pull AND merge.
Whenever you want to update, just say "git update", end of story.

Why? It seems oddly inconsistent that "pull" sometimes merges
in changes, but at other times it doesn't.  If I normally
track someone, but temporarily don't want to (I'm in the middle
of lots of changes but I _do_ want to see what's going on),
I have to "untrack", pull, and then "retrack" again (remembering who
I once tracked, which may be more of a trick over time).
Maybe more important, that is more annoying when you're
trying to "just pull data" from a script; I need to
do the untrack, pull, & retrack shuffle just to download data.

I propose that there be two subcommands, "pull" and "update"
(now that "update" isn't a reserved word again).
A "git pull" ONLY downloads; a "git update" pulls AND merges.
That means each command does exactly one thing, very simple &
clean to explain.  Also, some tools (such as subversion) already
use "update" as meaning this (auto download & merge from the
given repository), so the terminology would make sense for some.

I'd be happy to send in a patch to do that.  The coding is trivial,
but it means a UI change in one of the most common commands
(use "update" instead of "pull" in the typical case).
I could add a "reminder" message after pulling, to let people
adjust to the new commands for a little while.

--- David A. Wheeler
