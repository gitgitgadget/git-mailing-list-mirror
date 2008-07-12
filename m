From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make rebase--interactive use OPTIONS_SPEC
Date: Sat, 12 Jul 2008 18:31:24 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807121830270.8950@racer>
References: <1215877700-17080-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807121728180.8950@racer> <1215877700-17080-1-git-send-email-s-beyer@gmx.net> <20080712172729.GE7572@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jul 12 19:32:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHixK-0002Dx-Or
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 19:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbYGLRbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 13:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752502AbYGLRbZ
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 13:31:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:55663 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752478AbYGLRbY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 13:31:24 -0400
Received: (qmail invoked by alias); 12 Jul 2008 17:31:22 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp039) with SMTP; 12 Jul 2008 19:31:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19pLkYu0bxpJuAKbBFd2dhifh9inDMrXwTBwJ7EvB
	GVh/wUiePNqOCJ
X-X-Sender: gene099@racer
In-Reply-To: <20080712172729.GE7572@leksak.fem-net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88258>

Hi,

On Sat, 12 Jul 2008, Stephan Beyer wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > +	--onto)
> > > +		shift
> > > +		ONTO=$(git rev-parse --verify "$1") ||
> > > +			die "Does not point to a valid commit: $1"
> > 
> > Didn't you have some check earlier that "--onto" can only be used when 
> > starting a rebase?
> 
> Yes, and I still have. is_standalone does that:
> 
> # check if no other options are set
> is_standalone () {
> 	test $# -eq 2 -a "$2" = '--' &&
> 	test -z "$ONTO" &&
> 	test -z "$PRESERVE_MERGES" &&
> 	test -z "$STRATEGY" &&
> 	test -z "$VERBOSE"
> }
> 
> which is called on --continue/--abort/--skip before the saved options 
> are loaded again.

Ah, sorry.  I managed to misunderstand "is_standalone".  Again.  (I had 
the same problem during the first round, but forgot to mention that, I 
guess).

Ciao,
Dscho
