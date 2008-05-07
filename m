From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: git-checkout sometimes silently fails
Date: Tue, 6 May 2008 17:43:48 -0700
Message-ID: <20080506174348.8d99fe4e.akpm@linux-foundation.org>
References: <20080506122256.04ca7d77.akpm@linux-foundation.org>
	<20080506215049.GC4647@steel.home>
	<20080506171052.340d643e.akpm@linux-foundation.org>
	<7v4p9bge4q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 07 02:45:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtXmx-0005G4-9g
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 02:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757353AbYEGAok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 20:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754057AbYEGAoj
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 20:44:39 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34090 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757332AbYEGAoh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2008 20:44:37 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m470hnlW023185
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 6 May 2008 17:43:51 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m470hmYg003216;
	Tue, 6 May 2008 17:43:49 -0700
In-Reply-To: <7v4p9bge4q.fsf@gitster.siamese.dyndns.org>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-2.778 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81394>

On Tue, 06 May 2008 17:19:01 -0700 Junio C Hamano <gitster@pobox.com> wrote:

> Andrew Morton <akpm@linux-foundation.org> writes:
> 
> > y:/usr/src/git26> git-branch -av | grep '^\*'
> > * master               5717922 Merge branch 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jwessel/linux-2.6-kgdb
> > y:/usr/src/git26> git-checkout linux-next    
> > Switched to branch "linux-next"
> > y:/usr/src/git26> git-branch -av | grep '^\*'
> > * linux-next           5717922 Merge branch 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jwessel/linux-2.6-kgdb
> 
> So your two local branches 'master' and 'linux-next' both point at the
> same commit, 5717922.
> 
> "git checkout <branchname>" is to check out the local branch name.  You
> expect "git checkout master" and then "git checkout linux-next" to check
> out two different commits because linux-next _should_ have been updated to
> the latest from sfr repository.  But it appears to me that that is not the
> case.

I did a git-fetch of linux-next yesterday.

> Perhaps "git fetch linux-next" hasn't been run, before "git checkout" was
> attempted?

I reran `git-fetch linux-next' and that downlaoded a heap of stuff (perhaps
necause linux-next rebases every time?) and after this, `git-checkout
linux-next' gives me what I expect.

But how come I couldn't check out yesterday's linux-next?
