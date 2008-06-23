From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 10:21:47 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806231019170.2926@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <20080623082223.GA12130@artemis.madism.org> <alpine.DEB.1.00.0806231312130.6440@racer> <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org>
 <alpine.DEB.1.00.0806231756340.6440@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 23 19:23:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KApl8-0000jW-Uf
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 19:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754476AbYFWRWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 13:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759985AbYFWRWY
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 13:22:24 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36462 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754476AbYFWRWX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2008 13:22:23 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NHLlFq018710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jun 2008 10:21:49 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NHLlol007267;
	Mon, 23 Jun 2008 10:21:47 -0700
In-Reply-To: <alpine.DEB.1.00.0806231756340.6440@racer>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.845 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85890>



On Mon, 23 Jun 2008, Johannes Schindelin wrote:
> 
> > Look at cmd_apply() in builtin-apply.c. Notice how it currently 
> > absolutely CANNOT sanely be turned into using "parse_options()", not 
> > because it needs any "recursive" handling, but simply because it wants 
> > to do *incremental* handling.
> 
> That is a totally independent issue from the one I discussed, namely sane 
> handling of the diff (and rev) options.

No it is not.

YOU THINK it is "independent" just because YOUR SOLUTION can do only one 
case.

And I say: my solution handles both cases, so it's not "independent" any 
more.

See? 

(And yes, I can handle even the --help cases. It's actually not that hard 
to just remember all the different option structs you've seen, and handle 
all of that totally independently internally in parse_options(). You don't 
need recursion, you just need a trivial list of options.)

		Linus
