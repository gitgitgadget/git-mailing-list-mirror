From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: files are disappearing in git
Date: Wed, 23 Nov 2005 09:20:28 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511230917130.13959@g5.osdl.org>
References: <20051123142303.GJ22568@schottelius.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 23 18:22:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeyIP-0007Yj-Qw
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 18:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbVKWRUf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 12:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVKWRUf
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 12:20:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61117 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751214AbVKWRUe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2005 12:20:34 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jANHKTnO030105
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 23 Nov 2005 09:20:30 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jANHKSCS012841;
	Wed, 23 Nov 2005 09:20:29 -0800
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
In-Reply-To: <20051123142303.GJ22568@schottelius.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.56__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12638>



On Wed, 23 Nov 2005, Nico -telmich- Schottelius wrote:
> 
> I've the problem that some files (a directory with 3 files) is simply 'away':
> 
> - We added it once
> - In current tree it's away
> - pasky aided me in irc to find the commit where it is gone with git bisect
> --> very nice tool
> - the commit, after which the directory was gone did NOT modify this directory
> - though the directory is gone
> 
> What should I do know to find out what's the reason git 'forgot' that directory?

I bet somebody just messed up the index before that commit. So the commit 
probably _did_ modify the directory, though some incorrect patching or 
some scripting bug.

If you can guess at all what went on at around that commit (what else 
happened there?) that might help. Was it a merge? If those three files 
existed in the base commit of the merge but not in one of the branches, 
then the merge would have assumed that the branch just deleted it.

Is the tree public so that we can look at it and perhaps make a guess from 
what happened around it?

		Linus
