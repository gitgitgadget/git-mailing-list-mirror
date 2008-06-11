From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Wed, 11 Jun 2008 22:44:17 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806112242370.1783@racer>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 23:46:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Y9C-0003hs-2Y
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 23:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbYFKVpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 17:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbYFKVpc
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 17:45:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:37309 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750894AbYFKVpb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 17:45:31 -0400
Received: (qmail invoked by alias); 11 Jun 2008 21:45:29 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp033) with SMTP; 11 Jun 2008 23:45:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19YarEIbIxYIqfPl20EPe8lfwu0wnIx1X3vfC7tb7
	x+8ruFsn+yCPZ0
X-X-Sender: gene099@racer
In-Reply-To: <20080611213648.GA13362@glandium.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84670>

Hi,

On Wed, 11 Jun 2008, Mike Hommey wrote:

> On Wed, Jun 11, 2008 at 04:29:56PM -0500, Brandon Casey wrote:
> > The stash makes use of git's reflog mechanism, but it is not a reflog 
> > in the traditional sense. Each entry is a state that the user 
> > explicitly requested git to remember. The stash is generally 
> > short-lived, but the user probably expects that a stash will continue 
> > to exist until it is explicitly deleted. So we should not expire stash 
> > entries.
> 
> I wonder if it wouldn't make sense to have git reflog expire not expire 
> stashes *at all*. I mean, you don't necessarily cleanup your repo with 
> git gc, and you may end up killing your stashes with git reflog yourself 
> if you don't use the "magic" --exclude...

FWIW I thought it was one of the clever designs of git-stash that it 
automatically expires together with the other reflogs.  A stash is only a 
temporary thing, that is not even meant to leave the local repository, 
after all.

Ciao,
Dscho
