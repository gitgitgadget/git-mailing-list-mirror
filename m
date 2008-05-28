From: Nikolaus Schulz <microschulz@web.de>
Subject: Re: git-svn {show,create}-ignore chokes upon subdirs
Date: Wed, 28 May 2008 11:16:33 +0200
Message-ID: <20080528091633.GA3919@penelope.zusammrottung.local>
References: <20080527162002.GA21855@penelope.zusammrottung.local> <483D190F.4030101@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 19:25:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1lsi-00080o-P7
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 19:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209AbYE2RYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 13:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752935AbYE2RYq
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 13:24:46 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:35916 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861AbYE2RYp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 13:24:45 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 14264E17CD9A
	for <git@vger.kernel.org>; Thu, 29 May 2008 19:22:55 +0200 (CEST)
Received: from [83.125.40.75] (helo=tunichtgut.zusammrottung.local)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1K1lq2-0004WJ-00
	for git@vger.kernel.org; Thu, 29 May 2008 19:22:54 +0200
Received: from penelope.zusammrottung.local ([192.168.178.202])
	by tunichtgut.zusammrottung.local with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nikolaus@penelope.zusammrottung.local>)
	id 1K1lq0-0002uS-RG
	for git@vger.kernel.org; Thu, 29 May 2008 19:22:52 +0200
Received: from nikolaus by penelope.zusammrottung.local with local (Exim 4.63)
	(envelope-from <nikolaus@penelope.zusammrottung.local>)
	id 1K1Hlq-00017A-1B
	for git@vger.kernel.org; Wed, 28 May 2008 11:16:34 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <483D190F.4030101@vilain.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Sender: microschulz@web.de
X-Provags-ID: V01U2FsdGVkX18IVAOGuLDCPv+3SsZ9LAjCV8R2WMkdsEPuHak4
	E6pgiXGQxTYCUmSGRVZJrQsx1BIi+BPrymFLGd9EEkqbvN2VrU
	4b+/Pl6Fw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83222>

On Wed, May 28, 2008 at 08:34:23PM +1200, Sam Vilain wrote:
> >  git-svn init -s http://svn.red-bean.com/repos/producingoss producingoss-git-svn
> >  cd producingoss-git-svn
> >  git-svn fetch
> >  git-svn create-ignore 
> > 
> > the last command prints this: 
> > 
> >  HTTP Path Not Found: PROPFIND request failed on '/repos/producingoss/!svn/bc/1465/ca': '/repos/producingoss/!svn/bc/1465/ca' path not found at /home/nikolaus/nfs/nsbp/git/git/git-svn line 1897

[...]

> It helps to include the breaking change's details in the message in
> reports like this.  Here it is:
> 
> From: Benoit Sigoure <tsuna@lrde.epita.fr>
> Subject: git-svn: add a generic tree traversal to fetch SVN properties
> 
>     * git-svn.perl (&traverse_ignore): Remove.
>     (&prop_walk): New.
>     (&cmd_show_ignore): Use prop_walk.
> 
> [ew: This will ease the implementation of the `create-ignore',
>      `propget', and `proplist' commands]
> 
> Signed-off-by: Benoit Sigoure <tsuna@lrde.epita.fr>
> Acked-by: Eric Wong <normalperson@yhbt.net>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

Thanks, I thought it could be considered chatter. :-)

It looks like the patch from Christian Engwer posted here yesterday[1] is a fix
for the described problem. 

> As a side note, "svn:mergeinfo" is rapidly becoming an 'interesting'
> property and should probably be added to the list.  

That's interesting, I wasn't aware they're finally tackling merge
tracking. 

Nikolaus

[1] see Gerrit Pape's message "[PATCH] git-svn fails in prop_walk if
    $self->{path} is not empty"
                                                                                   
