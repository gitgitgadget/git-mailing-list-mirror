From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] git rm: Support for removing submodules
Date: Thu, 17 Jul 2008 00:41:57 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807170038430.4318@eeepc-johanness>
References: <20080716190753.19772.93357.stgit@localhost> <20080716191134.19772.85003.stgit@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jul 17 00:42:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJFhR-0003Ss-0Q
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 00:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbYGPWlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 18:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbYGPWlS
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 18:41:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:56649 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751306AbYGPWlR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 18:41:17 -0400
Received: (qmail invoked by alias); 16 Jul 2008 22:41:15 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp029) with SMTP; 17 Jul 2008 00:41:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+yC94DptCyYwPj8cCSdcRSivWV4c37G7QjIkczD1
	SHwd2ahuBXCyU+
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080716191134.19772.85003.stgit@localhost>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88775>

Hi,

On Wed, 16 Jul 2008, Petr Baudis wrote:

> This patch adds support for removing submodules to 'git rm', including 
> removing the appropriate sections from the .gitmodules file to reflect 
> this

I have no time to look at the whole series, or even at the patch, but I 
have concerns.  Do you really remove the whole directory?  Because if you 
do, you remove more than what can be possibly reconstructed from the 
object store.

That is much more dangerous than what "git rm" does.

For example, you can have local branches, remote settings, untracked 
files, etc. in the subdirectory.  And that cannot be recovered once 
deleted.

I wonder if it really makes sense to integrate that into git-rm, and not 
git-submodule, if only to introduce another level of consideration for the 
user before committing what is potentially a big mistake.

Ciao,
Dscho
