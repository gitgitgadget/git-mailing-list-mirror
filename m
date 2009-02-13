From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] log: make --abbrev-commit's ellipsis configurable
Date: Fri, 13 Feb 2009 14:20:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902131418230.10279@pacific.mpi-cbg.de>
References: <1234529920-9694-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Cc: git@vger.kernel.org,
	=?ISO-8859-15?Q?Adeodato_Sim=F3?= <dato@net.com.org.es>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Feb 13 14:22:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXxzC-0004gY-No
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 14:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbZBMNUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 08:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753026AbZBMNUM
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 08:20:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:54787 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752630AbZBMNUL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 08:20:11 -0500
Received: (qmail invoked by alias); 13 Feb 2009 13:20:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp022) with SMTP; 13 Feb 2009 14:20:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19wV/xzUvpwV0paEybua2oYMcp0DOMfrXwMGUTQwg
	BJpoof6yvtIf5x
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1234529920-9694-1-git-send-email-trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109746>

Hi,

On Fri, 13 Feb 2009, Thomas Rast wrote:

> 'git log --abbrev-commit' adds an ellipsis to all commit names that
> were abbreviated.  This is annoying if you want to cut&paste the sha1
> from the terminal, since selecting by word will pick up '...' too.
> (And this cannot be fixed by making '.' a non-word character; in other
> instances, such as the '123457..abcdef0' from git-fetch, it's part of
> the expression.)
> 
> So we introduce a new variable format.abbrevEllipsis that defaults to
> true (previous behaviour).  If disabled, the formatting routines for
> log/show/whatchanged do not append an ellipsis.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>[...]
>
>  Documentation/config.txt |    6 ++++++
>  builtin-log.c            |    4 ++++
>  log-tree.c               |   19 ++++++++++++++-----
>  log-tree.h               |    3 +++
>  pretty.c                 |    6 ++----

I am slightly worried that you overshoot here, as log-tree.c has plumbing 
users, too, no?

How about making this an option, and passing it in rev_opts instead?  This 
option could then be defaulted to in git-log, when the user said 
--abbrev-commit.

Ciao,
Dscho
