From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] xdiff-interface.c: strip newline (and cr) from line
 before pattern matching
Date: Wed, 1 Oct 2008 22:05:05 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810012204280.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <mJtumbyBuR0sRaFjwb6O5_D_ps0fVfz6APTAAjYMixV0MvzP8nEZRw@cipher.nrlssc.navy.mil> <o5dqpNECJusQHKCTvRWiIqN2ZJ7w-fyC-0vM99FajJIgLsOwP3RNug@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonathan del Strother <maillist@steelskies.com>,
	Git Mailing List <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Oct 01 22:00:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl7re-0000AW-4N
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 22:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843AbYJAT6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 15:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753914AbYJAT6x
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 15:58:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:58443 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753680AbYJAT6w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 15:58:52 -0400
Received: (qmail invoked by alias); 01 Oct 2008 19:58:49 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp063) with SMTP; 01 Oct 2008 21:58:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+wlhtvbKewulVay5qd+g8VjrZZnLfTMb0AF9sDaP
	a54id1Z3qptckt
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <o5dqpNECJusQHKCTvRWiIqN2ZJ7w-fyC-0vM99FajJIgLsOwP3RNug@cipher.nrlssc.navy.mil>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97261>

Hi,

On Wed, 1 Oct 2008, Brandon Casey wrote:

> POSIX doth sayeth:
> 
>    "In the regular expression processing described in IEEE Std 1003.1-2001,
>     the <newline> is regarded as an ordinary character and both a period and
>     a non-matching list can match one. ... Those utilities (like grep) that
>     do not allow <newline>s to match are responsible for eliminating any
>     <newline> from strings before matching against the RE."
> 
> Thus far git has not been removing the trailing newline from strings matched
> against regular expression patterns. This has the effect that (quoting
> Jonathan del Strother) "... a line containing just 'FUNCNAME' (terminated by
> a newline) will be matched by the pattern '^(FUNCNAME.$)' but not
> '^(FUNCNAME$)'", and more simply not '^FUNCNAME$'.

Personally, I find the second paragraph pretty convincing.  Which is good, 
because the first fails to do that.

Ciao,
Dscho
