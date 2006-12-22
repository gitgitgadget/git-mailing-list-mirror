From: Nicolas Vilz <niv@iaglans.de>
Subject: Re: git-svn throwing assertion on old svn tracking branch
Date: Fri, 22 Dec 2006 02:35:10 +0100
Message-ID: <20061222013510.GA9595@hermes>
References: <20061220235551.GA2974@hermes.lan.home.vilz.de> <20061221010520.GB3901@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 02:35:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxZJo-0008AV-2v
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 02:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945906AbWLVBe5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 20:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945907AbWLVBe5
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 20:34:57 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:4478 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1945906AbWLVBe5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Dec 2006 20:34:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 8BFB63F5D;
	Fri, 22 Dec 2006 02:34:54 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at vsectoor.geht-ab-wie-schnitzel.de
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TA9KK1FjWvj5; Fri, 22 Dec 2006 02:34:30 +0100 (CET)
Received: from localhost (dslb-088-066-037-196.pools.arcor-ip.net [88.66.37.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 2C9543EDC;
	Fri, 22 Dec 2006 02:34:28 +0100 (CET)
To: Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <20061221010520.GB3901@localdomain>
X-message-flag: Please send plain text messages only. Thank you.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35114>

On Wed, Dec 20, 2006 at 05:05:20PM -0800, Eric Wong wrote:
> Nicolas Vilz <niv@iaglans.de> wrote:
> > hello guys,
> > 
> > it has been a while, i tried git in conjunction with svn... i got a nice
> > history, when working with it. This Work is now a year old.
> > 
> > Now I wanted to get on working and got following error message while
> > fetching from one specific svn tracking branch:
> > 
> > $ git-svn fetch -i svn_master
> > perl: subversion/libsvn_subr/path.c:343: svn_path_remove_component: 
> > Assertion `is_canonical(path->data, path->len)' failed.
> > Aborted
> 
> I don't recall seeing that error before.
> 
> Are you using the command-line client or the perl SVN libraries?  If
> you're using the command-line client, you may want to try:
> rm -rf .git/svn/svn_master/tree && git-svn rebuild -i svn_master
> 
> > I checked the svn working copy, it is uptodate now (although i had to
> > search for it, i havent been using this repository for one year...)
> 
> Does the directory you're tracking the the repository still
> exist?  If it disappeared, git-svn could have some issues with it
> (regardless of command-line or SVN libraries).

The repository i am tracking does still exist. both, the tree and the
repository are on the same revision-number, so i am a bit clueless.

I tried a fresh fetch of this repository, it worked. so it shouldn't be
a client-server version mismatch..

I also tried 

rm -rf .git/svn/svn_master/tree && git-svn rebuild -i svn_master

this had no effect to git-svn fetch -i svn_master... i get the very same
error message...

I didn't alter there anything, so i think, fetching works, but if
nothing is there to fetch, there is the initial error message...

beneath there is svn, version 1.4.2 (r22196) ... on that repository is
Subversion version 1.1.4 (r13838).


Nicolas Vilz
