From: Tait <git.git@t41t.com>
Subject: Re: [PATCH] git send-email: edit recipient addresses with the --compose flag
Date: Tue, 11 Nov 2008 14:14:21 -0800
Message-ID: <20081111221421.GJ7408@ece.pdx.edu>
References: <1226235588-2997-1-git-send-email-ian.hilt@gmx.com> <alpine.LFD.2.00.0811091344480.20499@sys-0.hiltweb.site> <20081111014919.GI7408@ece.pdx.edu> <200811111230.28076.fg@one2team.com> <alpine.LFD.2.00.0811111542230.24205@sys-0.hiltweb.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ian Hilt <ian.hilt@gmx.com>, Francis Galiegue <fg@one2team.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 11 23:15:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L01Wb-0004JZ-Jl
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 23:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbYKKWOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 17:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbYKKWOi
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 17:14:38 -0500
Received: from rcpt.cat.pdx.edu ([131.252.208.107]:51780 "EHLO
	rcpt.cat.pdx.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbYKKWOh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 17:14:37 -0500
Received: from nemo.ece.pdx.edu (root@nemo.ece.pdx.edu [131.252.209.162])
	by rcpt.cat.pdx.edu (8.14.2/8.14.2/Debian-2build1) with ESMTP id mABMEO0p013777
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Nov 2008 14:14:25 -0800
Received: from nemo.ece.pdx.edu (tait@localhost [127.0.0.1])
	by nemo.ece.pdx.edu (8.13.6/8.13.1) with ESMTP id mABMENbt024632;
	Tue, 11 Nov 2008 14:14:24 -0800 (PST)
Received: (from tait@localhost)
	by nemo.ece.pdx.edu (8.13.6/8.12.6/Submit) id mABMEL59024631;
	Tue, 11 Nov 2008 14:14:21 -0800 (PST)
X-Authentication-Warning: nemo.ece.pdx.edu: tait set sender to git.git@t41t.com using -f
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811111542230.24205@sys-0.hiltweb.site>
User-Agent: Mutt/1.5.7i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (rcpt.cat.pdx.edu [131.252.208.107]); Tue, 11 Nov 2008 14:14:26 -0800 (PST)
X-Spam-Status: No, score=0.0 required=6.0 tests=none autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on rcpt.cat.pdx.edu
X-Virus-Scanned: ClamAV 0.92.1/8611/Tue Nov 11 11:42:18 2008 on rcpt.cat.pdx.edu
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100688>

> > > > > > +	if ($c_file =~ /^To:\s*+(.+)\s*\nCc:/ism) {
> > > > >
> > > > > Greedy operators are only supported with perl 5.10 or more... I think
> > > > > it's a bad idea to use them...
> > > >
> > > > The problem here was that a space should follow the field, but it may
> > > > not.  The user may unwarily backup over it.  "\s*" would match this
> > > > case.
> > > >
> > > > But if there is a space, it is included in the "(.+)".
> > >
> > > Not in any version of Perl to which I have access.
> > >
> > 
> > And if you see a space in (.+), your regex engine is buggy anyway.
> 
> So what does this script produce on your systems?
> 
> --8<--
> #!/usr/bin/perl -Tw
> use strict;
> my $ws = "To: \nCc:";
> 
> $ws =~ /^To:\s*(.+)\s*\nCc:/ism;
> 
> if ($1 eq ' ') {
> 	print "\$1 is equal to a space.\n";
> }
> -->8--

It does match a space in that case. I misunderstood the problem this was 
trying to solve. (Sorry for the confusion.)
