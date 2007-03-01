From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: defaults for where to merge from
Date: Thu, 1 Mar 2007 02:25:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703010221000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <es450f$d58$1@sea.gmane.org>  <200702281522.14965.andyparkins@gmail.com>
  <Pine.LNX.4.64.0702281526270.15314@reaper.quantumfyre.co.uk> 
 <Pine.LNX.4.63.0702281643200.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <81b0412b0702281045u2e511ebfie14a7b718531f8c4@mail.gmail.com> 
 <45E5DE8A.2080101@lu.unisi.ch> <81b0412b0702281607l6f9b1cadg9f3a84b06b9acd7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Paolo Bonzini <bonzini@gnu.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 02:25:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMa38-0002HS-NY
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 02:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932902AbXCABZh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 20:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932910AbXCABZh
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 20:25:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:59942 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932902AbXCABZg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 20:25:36 -0500
Received: (qmail invoked by alias); 01 Mar 2007 01:25:35 -0000
X-Provags-ID: V01U2FsdGVkX1+Q1w8++veQ3zrxixSgBHlYlmpTT/k0xEWB7jjmF1
	pMig==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <81b0412b0702281607l6f9b1cadg9f3a84b06b9acd7d@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41029>

Hi,

On Thu, 1 Mar 2007, Alex Riesen wrote:

> Well, I find it unobvious for pull to magically starting merging.

Pull is _all_ about merging.

> Perhaps I'm using branch configuration in .git/config for too long, and 
> actually expect nothing to be merged if there is no appropriate branch 
> configuration.

It is not possible that you use that feature you described for too long, 
since it was not there in 1.4.x. There, whenever you said "git pull", it 
would try to blindly pull the default branch of the remote "origin", which 
might have been correct for the default branch (i.e. the branch 
automatically set up by git-clone), but not necessarily for the other 
branches.

And I want to stress a very important point: this automatic setting of the 
default remote and branch-to-merge should be _only_ triggered when 
branching from refs in $GIT_DIR/refs/remotes. Even if you _do_ branch them 
from scripts, I doubt that you'll break _anything_, except of course when 
the scripts are buggy to begin with.

There is a good chance that some user wants to merge something 
different, but in that case you have to specify what to merge _anyway_.

However, with the proposed behaviour, more new users would get less "Huh?" 
experiences.

Ciao,
Dscho
