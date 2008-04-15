From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [GIT PULL] sh updates for 2.6.25
Date: Wed, 16 Apr 2008 03:30:23 +0900
Message-ID: <20080415183023.GA23098@linux-sh.org>
References: <20080415172333.GA29489@linux-sh.org> <alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-sh@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-sh-owner@vger.kernel.org Tue Apr 15 20:38:53 2008
connect(): Connection refused
Return-path: <linux-sh-owner@vger.kernel.org>
Envelope-to: glps-linuxsh-dev@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlpwZ-0005E5-8z
	for glps-linuxsh-dev@gmane.org; Tue, 15 Apr 2008 20:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbYDOSbG (ORCPT <rfc822;glps-linuxsh-dev@m.gmane.org>);
	Tue, 15 Apr 2008 14:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752658AbYDOSbF
	(ORCPT <rfc822;linux-sh-outgoing>); Tue, 15 Apr 2008 14:31:05 -0400
Received: from mta23.gyao.ne.jp ([125.63.38.249]:35434 "EHLO mx.gate01.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751842AbYDOSbE (ORCPT <rfc822;linux-sh@vger.kernel.org>);
	Tue, 15 Apr 2008 14:31:04 -0400
Received: from [124.34.33.190] (helo=master.linux-sh.org)
	by smtp31.isp.us-com.jp with esmtp (Mail 4.41)
	id 1Jlpvj-0001Bn-CV; Wed, 16 Apr 2008 03:30:55 +0900
Received: from localhost (unknown [127.0.0.1])
	by master.linux-sh.org (Postfix) with ESMTP id 2626963754;
	Tue, 15 Apr 2008 18:30:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at linux-sh.org
Received: from master.linux-sh.org ([127.0.0.1])
	by localhost (master.linux-sh.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qaIYUg168s2R; Wed, 16 Apr 2008 03:30:23 +0900 (JST)
Received: by master.linux-sh.org (Postfix, from userid 500)
	id 9C3B663758; Wed, 16 Apr 2008 03:30:23 +0900 (JST)
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-sh@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-sh-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79617>

On Tue, Apr 15, 2008 at 11:01:36AM -0700, Linus Torvalds wrote:
> On Wed, 16 Apr 2008, Paul Mundt wrote:
> >
> > Please pull from:
> > 
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6.25.git
> 
> Paul, your git tree is odd. Not quite corrupt, but it doesn't really 
> follow the rules either.
> 
> In particular, it has empty lines at the top of those commits, and I 
> wonder how you created them. 
> 
> Doing things like "git log" will ignore the spurious empty lines, but they 
> can be seen with things like "git cat-file", eg
> 
> 	git cat-file commit fd785d6b18b930b76ad5076eed6e9af43195b281 
> 
> and I wonder if you used a buggy version of git, or whether you perhaps 
> have some scripts that import these commits from the outside and uses some 
> low-level commands that can generate these kinds of subtly bogus commits.

It was a combination of mbox munging and git-am, I checked with git log
and thought things were ok, but I wasn't aware that it stripped out empty
lines. cat-file shows that it was just the 2 patches from Andrew that had
this particular problem. I had stripped out the subject and thought the
first line would be used for the merge summary, but it looks like git-am
simply wrote out an empty line and inserted one after that before the
rest of the summary.

I've pushed out updated patches that have this corrected, so please pull
again.
