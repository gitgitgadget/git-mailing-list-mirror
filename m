From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch: really allow running in a bare
 repository
Date: Tue, 3 Feb 2009 21:46:43 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902032145250.9822@pacific.mpi-cbg.de>
References: <cover.1233684552u.git.johannes.schindelin@gmx.de>  <alpine.DEB.1.00.0902031910001.9822@pacific.mpi-cbg.de> <431341160902031131s63f34665ne9db25d8a4d1f0f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Eric Kidd <emk.lists@randomhacks.net>
X-From: git-owner@vger.kernel.org Tue Feb 03 21:48:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUSBM-0007uj-Ed
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 21:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbZBCUqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 15:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbZBCUqQ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 15:46:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:41124 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750845AbZBCUqP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 15:46:15 -0500
Received: (qmail invoked by alias); 03 Feb 2009 20:46:10 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp041) with SMTP; 03 Feb 2009 21:46:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+JrZkdmb2JhXv8c7yDpiuuNMBEMgzpDV5o2AFDh1
	nE9rZrdhNCLAoH
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <431341160902031131s63f34665ne9db25d8a4d1f0f9@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108249>

Hi,

On Tue, 3 Feb 2009, Eric Kidd wrote:

> On Tue, Feb 3, 2009 at 1:10 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > When checking if running in a bare repository, the work tree has to be
> > reset, otherwise we will be checking the temporary state, which is
> > always non-bare.
> 
> Just a few minutes after you posted this patch, I posted a
> nearly-identical fix for the same issue:
> 
>   http://marc.info/?l=git&m=123368695831812&w=2
> 
> (My patch includes a test case, too, but it's not very important.)

So clearly yours is superior.

> This raises another interesting question: Why doesn't 'git
> filter-branch' actually check whether subcommands succeed?

That's unintentional; AFAIR there was a "set -e" in cg-admin-rewritehist 
that I tried to do away with by introducing explicit '&&' conjunctions 
where needed.

So all those unchecked subcommands are bugs.

Thanks,
Dscho
