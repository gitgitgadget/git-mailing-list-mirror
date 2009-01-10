From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] make diff --color-words customizable
Date: Sat, 10 Jan 2009 12:45:31 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901101239550.30769@pacific.mpi-cbg.de>
References: <87wsd48wam.fsf@iki.fi> <1231549039-5236-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0901101146230.30769@pacific.mpi-cbg.de> <200901101225.10719.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jan 10 12:46:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLcI9-0004R7-G2
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 12:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051AbZAJLou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 06:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752753AbZAJLou
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 06:44:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:53332 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752200AbZAJLot (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 06:44:49 -0500
Received: (qmail invoked by alias); 10 Jan 2009 11:44:47 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 10 Jan 2009 12:44:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19bbHovGl9bTEovK9EYk/gFhtpexTcG09P2ptXNWF
	L7DMb9QA7aqeqQ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200901101225.10719.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105097>

Hi,

On Sat, 10 Jan 2009, Thomas Rast wrote:

> Johannes Schindelin wrote:
> > BTW I did not really think about the issue you raised about the newlines, 
> > as I seemed to remember that the idea was to substitute all non-word 
> > characters with newlines, so that the offsets in the substituted text are 
> > the same as in the original text.
> 
> Ok, so here's a very simple example: Suppose you have the word regex
> 'x+|y+' and compare these two lines:
> 
> A: xxyyxy
> B: xyxyy

Ah, I see.

> > So I still find your patch way too large
> 
> I can't think of a simpler way to do it, and yours unfortunately doesn't 
> work.

Well, the thing I tried to hint at: it is not good to have a monster 
patch, as nobody will review it.

In your case, I imagine it would be much easier to get reviewers if you 
had

	patch 1/4 refactor color-words to allow for 0-character word 
		boundaries
	patch 2/4 allow regular expressions to define what makes a word
	patch 3/4 add option to specify word boundary regexps via
		attributes
	patch 4/4 test word boundary regexps

And I admit that I documented the code lousily, but that does not mean 
that you should repeat that mistake.

Ciao,
Dscho
