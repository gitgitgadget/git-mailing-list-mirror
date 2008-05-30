From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-log vs git-rev-list
Date: Fri, 30 May 2008 10:25:47 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805301021310.3141@woody.linux-foundation.org>
References: <20080530165641.GG18781@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri May 30 19:26:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K28NJ-0007I5-OJ
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 19:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbYE3RZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 13:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbYE3RZy
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 13:25:54 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57977 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752653AbYE3RZx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 May 2008 13:25:53 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4UHPmv2006351
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 May 2008 10:25:50 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4UHPlNK003155;
	Fri, 30 May 2008 10:25:48 -0700
In-Reply-To: <20080530165641.GG18781@machine.or.cz>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.397 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83317>



On Fri, 30 May 2008, Petr Baudis wrote:
> 
>   * git log --pretty=format is actually sane and does not pollute the
> output with spurious 'commit' lines

Why would you want to use "git-rev-list" at all?

The common case for git-rev-list is for things that git log simply won't 
do, ie things like "git rev-list --all --objects" that is a nonsensical 
operation to do on "git log".

So if you use "--pretty" or anything like that, you generally shouldn't 
use rev-list. Sure, it works, but it works for mainly historical reasons.

>   I think that having two commands that by now do essentially the same
> thing, but slightly differently, is rather messy UI. Thus, I'm wondering
> if it would be worthwhile to make rev-list a thin git-log wrapper and
> start phasing it out?

It already is. It's already phased out in the sense that I don't see why 
you complain. If you don't like it, don't use it. It has legacy reasons 
for existing, and it does *some* things that are simply not sensible at 
all for "git log" (ie the non-commit things).

>   Yes, git-rev-list is supposed to be a plumbing thing, but from my
> porcelain, I actually have to use git-log anyway [..]

So why do you care?

No, git-rev-list is *not* the same as "git log". 

Yes, git rev-list can do a lot of the same things, for historical reasons.

Yes, they share most of the code. No, they're not the same.

			Linus
