From: Mike Hommey <mh@glandium.org>
Subject: Re: git-filter-branch
Date: Thu, 9 Aug 2007 11:30:51 +0200
Organization: glandium.org
Message-ID: <20070809093051.GA21458@glandium.org>
References: <20070809063453.GA12602@glandium.org> <Pine.LNX.4.64.0708090954550.21857@racer.site> <20070809091550.GB20321@glandium.org> <Pine.LNX.4.64.0708091018340.21857@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 09 11:32:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ4NO-0006an-3P
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 11:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759289AbXHIJbo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 05:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765521AbXHIJbo
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 05:31:44 -0400
Received: from vawad.err.no ([85.19.200.177]:59529 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765789AbXHIJbm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 05:31:42 -0400
Received: from aputeaux-153-1-54-147.w82-124.abo.wanadoo.fr ([82.124.176.147] helo=vaio.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IJ4Mn-0000vd-P0; Thu, 09 Aug 2007 11:31:43 +0200
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1IJ4Lz-0005cK-Fr; Thu, 09 Aug 2007 11:30:51 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708091018340.21857@racer.site>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55438>

On Thu, Aug 09, 2007 at 10:19:20AM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > In the description in the manpage:
> >    Lets you rewrite git revision history by creating a new branch from
> >    your current branch, applying custom filters on each revision.
> >    (...)
> >    The command takes the new branch name as a mandatory argument and the
> >    filters as optional arguments
> > 
> > And in example:
> >    Now, you will get the rewritten history saved in the branch newbranch
> >    (your current branch is left untouched).
> > 
> > I must say this is a feature that would actually be nice to have...
> 
> To compare with the old one?  Use reflogs:
> 
> 	git filter-branch --some-option master
> 	git diff master@{1}..master

To have, for example, a branch tracking an upstream (svn or whatever)
repository and have a branch based on it, only differing in the fact that
some directories get removed.

To be more specific, I'm tracking webkit's svn repository, and want to
have a branch which would be a base for making source tarballs for
debian, excluding a lot of cruft (such as LayoutTests which are *huge*,
or the website that also lives in the same svn trunk).

As files are added frequently in these directories, rebase or merge would
not be enough, and I'd like to be able to do this with a bare repository,
which rebase and merge don't allow me to...

So if you have a better idea than git-filter-branch for that, I'm open to
suggestions ;)

Cheers,

Mike
