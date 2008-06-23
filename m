From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 11:36:50 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806231133190.2926@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <20080623082223.GA12130@artemis.madism.org> <alpine.DEB.1.00.0806231312130.6440@racer> <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org> <20080623164917.GA25474@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org> <20080623171505.GB27265@sigill.intra.peff.net> <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <20080623181517.GA28527@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 20:39:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAqwQ-0003Yt-2y
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 20:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755944AbYFWShz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 14:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755982AbYFWShy
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 14:37:54 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33462 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755706AbYFWShy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2008 14:37:54 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NIapFk026957
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jun 2008 11:36:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NIao2U010302;
	Mon, 23 Jun 2008 11:36:50 -0700
In-Reply-To: <20080623181517.GA28527@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.845 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85900>



On Mon, 23 Jun 2008, Jeff King wrote:
> 
> There is already a discussion underway about the proper solution.

No there isn't, not any I have seen.

The recursion discussion has been going on for ages. Nothing happened, 
because people claimed it was too complex. And it doesn't solve all the 
_other_ issues where the current behaviour is just painful.

That said, I don't care how this gets fixed. If you want to fix it some 
other way, fine. Just _do_ it, dammit. And make the interface easier to 
use for incremental changes of existing code.

Because no, I don't care about builtin-blame.c in particular either. But I 
*do* care about the fact that currently it's sometimes a total *bitch* to 
convert the trivial ad-hoc argument parsing to use parse_options(). It 
takes effort and thinking.

And I seriously doubt that recursive or anything else will help that. But 
I _guarantee_ that an incremental mode will make it much much easier to do 
partial conversions of all the easy cases. And _that_ is what I care 
about.

		Linus
