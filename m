From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/3] bisect: use a detached HEAD to bisect
Date: Fri, 23 May 2008 08:27:51 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805230823330.3081@woody.linux-foundation.org>
References: <20080523012857.acce6457.chriscool@tuxfamily.org> <7v3ao9twfa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 17:30:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzZDM-0006o6-5p
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 17:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbYEWP3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 11:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbYEWP3A
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 11:29:00 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56113 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752414AbYEWP27 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 May 2008 11:28:59 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4NFRqH7010560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 23 May 2008 08:27:53 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4NFRpuO028487;
	Fri, 23 May 2008 08:27:51 -0700
In-Reply-To: <7v3ao9twfa.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.91 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82716>



On Thu, 22 May 2008, Junio C Hamano wrote:
> 
> One potential worry/downside is "bisect visualize".  Because <bisect>
> branch was used for bisection, the _current_ commit has always been
> indicated with a label.  HEAD would not get any special label in gitk,
> would it?

This is a general problem in gitk. 

It's worse than not showing a label, btw. If it doesn't realize what the 
HEAD is (and it won't), it also doesn't show the fake "uncommitted 
changes" commit(s).

Test by doing something like

	git checkout HEAD^
	echo "Dummy change" >> Makefile
	gitk

and note the lack of both pointer to detached head and the lack of notice 
about local uncommitted changes.

Paul?

		Linus
