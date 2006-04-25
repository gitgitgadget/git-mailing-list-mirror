From: sean <seanlkml@sympatico.ca>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
 other commit links ideas)
Date: Tue, 25 Apr 2006 04:57:52 -0400
Message-ID: <BAYC1-PASMTP116C6B217F25F2ADAF0C67AEBF0@CEZ.ICE>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
	<e2kgga$d7q$1@sea.gmane.org>
	<7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>
	<e2kjul$ntq$1@sea.gmane.org>
	<20060425043436.2ff53318.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Apr 25 11:02:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYJR4-0001ur-1T
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 11:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWDYJCP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 05:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWDYJCO
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 05:02:14 -0400
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:57290 "EHLO
	BAYC1-PASMTP11.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S932154AbWDYJCO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 05:02:14 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP11.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 25 Apr 2006 02:06:20 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 4C6CC644C28;
	Tue, 25 Apr 2006 05:02:10 -0400 (EDT)
To: jnareb@gmail.com, git@vger.kernel.org
Message-Id: <20060425045752.0c6fbc21.seanlkml@sympatico.ca>
In-Reply-To: <20060425043436.2ff53318.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 25 Apr 2006 09:06:20.0796 (UTC) FILETIME=[84E143C0:01C66847]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 25 Apr 2006 04:34:36 -0400
sean <seanlkml@sympatico.ca> wrote:

> If you're cherry-picking from a disposable branch, then you don't want to 
> include a link to it in your new commit.  Once you include the link, the 
> source commit should be protected from pruning just like any other piece 
> of history.  Otherwise there's no way for fsck-objects to know if a missing 
> object means corruption or not.  So you need a way at commit time to
> request the explicit linkage.

Actually this implies that anyone pulling just this branch would potentially
also end up pulling large portions of other branches too.   So maybe making
them optional is The Right Thing.  In which case, we'd just have to accept 
these as weaker than the parentage links and fsck-objects et. al. would have 
to tolerate such missing commits.

So now that i've clearly come down in favor of both sides of this argument,
i'll leave the decision to smarter people than me.

Sean
