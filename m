From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 10:32:21 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <20080623082223.GA12130@artemis.madism.org> <alpine.DEB.1.00.0806231312130.6440@racer> <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org> <20080623164917.GA25474@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org> <20080623171505.GB27265@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 19:34:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KApvs-0004RV-Nz
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 19:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760193AbYFWRdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 13:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760185AbYFWRdZ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 13:33:25 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50759 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754685AbYFWRdY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2008 13:33:24 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NHWLmu019568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jun 2008 10:32:22 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NHWLEQ007673;
	Mon, 23 Jun 2008 10:32:21 -0700
In-Reply-To: <20080623171505.GB27265@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.845 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85893>



On Mon, 23 Jun 2008, Jeff King wrote:
> 
> How can that be correct, if you don't know whether "-b" takes an
> argument?

Did you read my post or not?

If you have that case, then use STOP_ON_UNKNOWN.

> That is the only thing that makes sense to me, since the command line
> has to be parsed left-to-right (because the syntactic function of an
> element relies on the semantics of the element to its left).

Umm. Helloo, reality.. There are actually very few options that take a 
flag for their arguments. In particular, the option parsing we really 
_care_ about (revision parsing - see builtin-blame.c which is exactly 
where I wanted to convert things) very much DOES NOT.

And that CONTINUE_ON_UNKNOWN behaviour is not some kind of theoretical 
flag. It's the flag that builtin-blame.c *wants*. It's the flag that 
describes hat builtin-blame.c does right now in the current git master 
branch.

Try just looking at the code!

So I'm really not interested in arguing about "theoretical issues", when 
we have a real-life *practical* issue to solve.

Solve builtin-blame.c for me. I sent out a patch yesterday, but in the 
description of that patch I also described exactly why I want 
CONTINUE_ON_UNKNOWN.

So can we please stop the clusterfuck now?

		Linus
