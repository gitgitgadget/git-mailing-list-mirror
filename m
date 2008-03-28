From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG?] git-archive ignores remote .gitattributes (was:
 .git/info/attributes not cloned)
Date: Fri, 28 Mar 2008 13:22:53 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803281321260.18259@racer.site>
References: <47EB0FAE.5000102@rea-group.com> <20080327033341.GB5417@coredump.intra.peff.net> <47EB213F.1020503@rea-group.com> <20080327042925.GA6426@coredump.intra.peff.net> <47EB271F.1050307@rea-group.com> <20080327045342.GC6426@coredump.intra.peff.net>
 <47EC7DD1.3060102@rea-group.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Toby Corkindale <toby.corkindale@rea-group.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 13:23:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfDcP-0002Oj-6H
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 13:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbYC1MWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 08:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753205AbYC1MWz
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 08:22:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:59710 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753348AbYC1MWy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 08:22:54 -0400
Received: (qmail invoked by alias); 28 Mar 2008 12:22:52 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp026) with SMTP; 28 Mar 2008 13:22:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/1cHELq0r1XIbixWDu2yxAe27XNmZXXlsxh2vIMY
	PyRjxXlBNI7Qme
X-X-Sender: gene099@racer.site
In-Reply-To: <47EC7DD1.3060102@rea-group.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78398>

Hi,

On Fri, 28 Mar 2008, Toby Corkindale wrote:

> I submit that this is a bug, or at least undesirable behaviour:
> 
> "git-archive --remote=/some/repo" will ignore /some/repo/.gitattributes, 
> but check /some/repo/info/attributes.
> 
> I think the problem is in the loop that looks for .gitattributes, which 
> seems to do so by taking the current path and iterating down through it?

The problem is that "git archive --remote" operates on the remote 
repository as if it were bare.  Which in many cases is true.

So I'd submit that this is not the usage .gitattributes is meant for, and 
that you should clone the thing if you want to generate archives heeding 
the .gitattributes.

Ciao,
Dscho
