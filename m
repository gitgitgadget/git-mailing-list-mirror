From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: svn to git, N-squared?
Date: 12 Jun 2006 09:18:12 -0700
Message-ID: <86irn6wdob.fsf@blue.stonehenge.com>
References: <9e4733910606111902l709c71ccyf45070d55112739e@mail.gmail.com>
	<Pine.LNX.4.64.0606112028010.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 12 18:18:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fpp7J-0005ai-G4
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 18:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbWFLQSP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 12:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbWFLQSO
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 12:18:14 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:46263 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1752079AbWFLQSO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 12:18:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id B9B218F2AB;
	Mon, 12 Jun 2006 09:18:13 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 10244-01-5; Mon, 12 Jun 2006 09:18:13 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 10BA78F2BB; Mon, 12 Jun 2006 09:18:13 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
x-mayan-date: Long count = 12.19.13.6.16; tzolkin = 12 Cib; haab = 9 Zotz
In-Reply-To: <Pine.LNX.4.64.0606112028010.5498@g5.osdl.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21711>

>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:

Linus> This sounds like _exactly_ what happens if you don't repack
Linus> occasionally.  Expecially if you are using a filesystem without hashed
Linus> filename lookup, but it's true to some degree even with that - the
Linus> filesystem tends to end up spending tons of time in kernel space,
Linus> trying to find a place to put new objects.

I'm using git-svn to do a similar thing with a 11K-commit history.  It's now 4
days running, and yes, I'm repacking and deleting empty dirs every 200-300
commits, but I'm only up to commit 4000 or so.  At this rate, I *may* finish
by sometime next week. :(

However, I notice one thing that can't be good: .git/git-svn/revs has one file
per revision.  Yes, I'll end up with 11000 files in a single directory.  Ugh.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
