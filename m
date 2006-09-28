From: Sean <seanlkml@sympatico.ca>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 22:04:04 -0400
Message-ID: <BAYC1-PASMTP06CEC55B088A0817EB52CBAE1B0@CEZ.ICE>
References: <7vzmck7pis.fsf@assigned-by-dhcp.cox.net>
	<20060928014811.19568.qmail@web51005.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 28 04:04:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSlG5-0002dg-NT
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 04:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965194AbWI1CEK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 22:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbWI1CEK
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 22:04:10 -0400
Received: from bayc1-pasmtp06.bayc1.hotmail.com ([65.54.191.166]:9526 "EHLO
	BAYC1-PASMTP06.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S965194AbWI1CEH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 22:04:07 -0400
X-Originating-IP: [65.94.249.130]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.94.249.130]) by BAYC1-PASMTP06.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 27 Sep 2006 19:07:04 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GSlFt-0007aE-Gc; Wed, 27 Sep 2006 22:04:05 -0400
To: Matthew L Foster <mfoster167@yahoo.com>
Message-Id: <20060927220404.8e216945.seanlkml@sympatico.ca>
In-Reply-To: <20060928014811.19568.qmail@web51005.mail.yahoo.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.3; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 28 Sep 2006 02:07:05.0203 (UTC) FILETIME=[CB6B6430:01C6E2A2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Sep 2006 18:48:11 -0700 (PDT)
Matthew L Foster <mfoster167@yahoo.com> wrote:

> I actually understand that and agree. All I've been saying is it (git or gitweb.cgi) should prefer
> the local timestamp rather than any "remote" timestamps for no other reason than to minimize the
> possibility of timestamps being grossly inaccurate.

But any local time stamp would be a _lie_.  The time stamp in the commit records
when it was actually created.  And as Junio has pointed out, hundreds of commits
will typically arrive in a repo at the exact same time.  Your suggestion would
have them all showing the exact same time.  That's not helpful, and it loses
important factual information.

You'd lose the information of when that commit was actually _in truth_ created.
The vast majority of the time, everyone has their clock set to a reasonable
value and this all just works.  In the rare case when someone has their clock
set seriously out of whack, Git accurately records and reports that fact too.

Really.. this just isn't a problem.  Everything in Git continues to work
exactly as it should.   It may be interesting to see when a commit arrived
locally, but it shouldn't be a substitute for the _real_ accurate time
recorded in each commit that tells us when it was _really_, _in fact_,
_in truth_ created.

Sean
