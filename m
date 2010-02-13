From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git-svn: support fetch with autocrlf on
Date: Sun, 14 Feb 2010 00:55:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002140054300.20986@pacific.mpi-cbg.de>
References: <1265997155-3592-1-git-send-email-kusmabite@gmail.com> <1265997155-3592-2-git-send-email-kusmabite@gmail.com> <20100213122532.GA31653@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Erik Faye-Lund <kusmabite@googlemail.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Feb 14 00:51:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgRlL-0007Qt-N8
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 00:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758059Ab0BMXs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 18:48:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:51706 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753220Ab0BMXs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 18:48:56 -0500
Received: (qmail invoked by alias); 13 Feb 2010 23:48:54 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 14 Feb 2010 00:48:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18BwTVn/VkBFeDGDkpeQXLhU2ColNoHCbxo34eTSb
	aAD9Ox/C57kFEo
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20100213122532.GA31653@dcvr.yhbt.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57999999999999996
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139868>

Hi,

On Sat, 13 Feb 2010, Eric Wong wrote:

> Erik Faye-Lund <kusmabite@googlemail.com> wrote:
> > If I enable core.autocrlf and perform a "git svn rebase" that fetches
> > a change containing CRLFs, the git-svn meta-data gets corrupted.
> > 
> > Commit d3c9634e worked around this by setting core.autocrlf to "false" 
> > in the per-repo config when initing the clone. However if the config 
> > variable was changed, the breakage would still occur. This made it 
> > painful to work with git-svn on repos with mostly checked in LFs on 
> > Windows.
> > 
> > This patch tries to fix the same problem while allowing core.autocrlf 
> > to be enabled, by disabling filters when when hashing.
> > 
> > git-svn is currently the only call-site for hash_and_insert_object 
> > (apart from the test-suite), so changing it should be safe.
> > 
> > Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> > ---
> > 
> > With this patch applied, I guess we can also revert d3c9634e. I didn't
> > do this in this series, because I'm lazy and selfish and thus only
> > changed the code I needed to get what I wanted to work ;)
> > 
> > I've been running git-svn with these patches with core.autocrlf enabled
> > since December, and never seen the breakage that I saw before d3c9634e.
> 
> Hi Erik,
> 
> How does reverting d3c9634e affect dcommit?  I've never dealt with (or
> even looked at) autocrlf, so I'll put my trust in you and Dscho with
> anything related to it.

I have no idea how reverting said commit affects dcommit, and I do not 
have the time to check, sorry!

Ciao,
Dscho
