From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: pull into dirty working tree
Date: Wed, 13 Jun 2007 17:07:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706131702020.4059@racer.site>
References: <18031.64456.948230.375333@lisa.zopyra.com>
 <Pine.LNX.4.64.0706131559210.4059@racer.site> <200706131640.22588.andyparkins@gmail.com>
 <18032.5016.716192.939675@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 18:10:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyVQg-0007RQ-Pr
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 18:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758200AbXFMQKm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 12:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758174AbXFMQKm
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 12:10:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:49888 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758103AbXFMQKl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 12:10:41 -0400
Received: (qmail invoked by alias); 13 Jun 2007 16:10:39 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp046) with SMTP; 13 Jun 2007 18:10:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+qI1RPKq6qf2nZQJalnUuwpt8yq1BQRTYn1McitG
	kFVs0+SjwBGX7G
X-X-Sender: gene099@racer.site
In-Reply-To: <18032.5016.716192.939675@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50085>

Hi,

On Wed, 13 Jun 2007, Bill Lear wrote:

> I wonder, also, if there could be a way to alert users that their 
> working tree is dirty before all the git pull blather comes out, scaring 
> their poor little souls?

Well, it's their fault, isn't it?

>  So, instead of this:
> 
> % git pull
> remote: Generating pack...
> remote: Done counting 122 objects.
> remote: Result has 90 objects.
> remote: Deltifying 90 objects.
> remote:  100% (90/90) done
> Unpacking 90 objects
> remote: Total 90 (delta 59), reused 41 (delta 10)
>  100% (90/90) done
> * refs/remotes/origin/master: fast forward to branch 'master' of
> git://source/sc
>   old..new: 171b65f..0be3472
> * refs/remotes/origin/v1.0: fast forward to branch 'v1.0' of
> git://source/sc
>   old..new: a9de9dd..efa3a73
> Updating 717d9f6..0be3472
> src/fs/testsuite/fs.tst/gettest: needs update
> src/nl/EocCompiler.cc: needs update
> src/nl/EocCompiler.hh: needs update
> src/nl/Nl.cc: needs update
> fatal: Entry 'src/netlist/EocCompiler.cc' not uptodate. Cannot merge.

Sorry, this is the first time Git can realize that the dirty working 
directory conflicts with the changes about to be applied.

For example, I run "git pull" very often with a modified Makefile. If the 
merge would not touch the Makefile, it would succeed. No need to do 
anything fancy.

If you do have to shut the (otherwise useful) messages up, you can always 
have an alias (using the advanced technique illustrated in another post in 
this thread).

> % git pull
> Sorry, I can't pull, as you have a dirty working tree.  Please commit
> your changes or move your files before you pull.  These are the
> files that are preventing this:
> 
>     src/fs/testsuite/fs.tst/gettest
>     src/nl/EocCompiler.cc
>     src/nl/EocCompiler.hh
>     src/nl/Nl.cc

As far as I can see, gettest is not responsible, so this would be wrong.

Ciao,
Dscho
