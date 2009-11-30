From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: equal-tree-merges as way to make rebases fast-forward-able
Date: Mon, 30 Nov 2009 18:19:31 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911301815390.4985@pacific.mpi-cbg.de>
References: <cover.1259524136.git.brlink@debian.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Bernhard R. Link" <brlink@debian.org>
X-From: git-owner@vger.kernel.org Mon Nov 30 18:15:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF9qY-0000j4-Oz
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 18:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbZK3RPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 12:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753265AbZK3RPU
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 12:15:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:49045 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753207AbZK3RPT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 12:15:19 -0500
Received: (qmail invoked by alias); 30 Nov 2009 17:15:19 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp060) with SMTP; 30 Nov 2009 18:15:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/4TG1P8iL4xBcBQWynX5bFOT1FVMUNhA3UA6g7hp
	zXmVXcxNWn9jer
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1259524136.git.brlink@debian.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134120>

Hi,

On Mon, 30 Nov 2009, Bernhard R. Link wrote:

> The itch this idea is supposed to scratch is the problem that a rebase 
> or a amended commit is no longer a fast-forward, so cannot be easily 
> pulled.

Actually, I did something like this without any new tool:

	git rebase origin/master
	git merge -s ours master@{1}

The effect is that there is a merge commit which really merges the old 
state.

OTOH I can see that there is merit in trying to avoid to _require_ the 
whole history of the rebased branch.  But then, would it not be more in 
line with Git's ideas if there was a tool trying to identify, say, 
from the commit message which commits in HEAD...MERGE_HEAD are 
supposed to be identical?

Ciao,
Dscho
