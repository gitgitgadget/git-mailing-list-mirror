From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] core/softirq for v2.6.27
Date: Mon, 14 Jul 2008 10:11:10 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807140948220.3305@woody.linux-foundation.org>
References: <20080714144243.GA21079@elte.hu> <20080714092215.0efd7fa3.akpm@linux-foundation.org> <20080714163141.GA21068@elte.hu> <20080714094422.e7ae255a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 19:13:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIRbm-0007PS-IT
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 19:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620AbYGNRMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 13:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753085AbYGNRMG
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 13:12:06 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47521 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753243AbYGNRMF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jul 2008 13:12:05 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6EHBBrk024471
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 14 Jul 2008 10:11:12 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6EHBAbv018267;
	Mon, 14 Jul 2008 10:11:10 -0700
In-Reply-To: <20080714094422.e7ae255a.akpm@linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.9 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88436>



On Mon, 14 Jul 2008, Andrew Morton wrote:
> 
> This was a git-shortlog feature request ;)

Heh. You should cc git or Junio if so.

The way shortlog is done (very different from regular logs, due to the 
whole organize-by-name etc thing) that is sadly pretty ugly to do: we 
don't support the pretty-formats etc. And the way things are done, adding 
support for the generic "--pretty=xyz" (including custom formats) would be 
pretty painful.

So it would have to be a total special-case.

Junio, git people - what Andrew is asking for is for git shortlog to show 
the commit ID (in shortened form) at the end:

> > It would be nice if these short-form summaries were to include the
> > commit IDs.  eg:
> > 
> > Carlos R. Mafra (1):
> >       Remove argument from open_softirq which is always NULL (962cf36)

and I do think it would be nice. I've had some other things I would find 
shortlog format additions useful for (size of patch etc), so if it could 
be somehow generalized that would be wonderful.

As it is, that is one ugly function that only takes the one-liner thing - 
at least partly because of how it traditionally worked (as a a filter over 
the log messages, rather than as a "git shortlog xyz..abc" kind of 
stand-alone thing).

		Linus
