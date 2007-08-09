From: Mike Hommey <mh@glandium.org>
Subject: Re: git-filter-branch
Date: Thu, 9 Aug 2007 11:15:50 +0200
Organization: glandium.org
Message-ID: <20070809091550.GB20321@glandium.org>
References: <20070809063453.GA12602@glandium.org> <Pine.LNX.4.64.0708090954550.21857@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 09 11:16:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ48M-0002VA-L1
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 11:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933836AbXHIJQn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 05:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932925AbXHIJQn
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 05:16:43 -0400
Received: from vawad.err.no ([85.19.200.177]:33183 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760378AbXHIJQm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 05:16:42 -0400
Received: from aputeaux-153-1-54-147.w82-124.abo.wanadoo.fr ([82.124.176.147] helo=vaio.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IJ48G-0000HG-VS; Thu, 09 Aug 2007 11:16:42 +0200
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1IJ47S-0005Ys-Fz; Thu, 09 Aug 2007 11:15:50 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708090954550.21857@racer.site>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55436>

On Thu, Aug 09, 2007 at 09:58:27AM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Thu, 9 Aug 2007, Mike Hommey wrote:
> 
> > What is supposed to be the usage() of git-fetch-branch ?
> > 
> > git-filter-branch itself says:
> > git-filter-branch [-d TEMPDIR] [FILTERS] DESTBRANCH [REV-RANGE]
> 
> This is an unfortunate left-over.  The syntax described in the 
> documentation should be right.
> 
> > while the documentation doesn't explicitely talk about DESTBRANCH,
> > expect in the form of an hypothetical /newbranch/, that you obviously
> > don't give to the command line.
> 
> Hmm.  I don't have time to look into this now, but the syntax is this:
> 
> 	git filter-branch [<options>] [--] [<rev-options>]
> 
> Those refs that you give in the <rev-options> are rewritten.  AFAIR the 
> old values of the refs (if different) are written to refs/original/*.

In the description in the manpage:
   Lets you rewrite git revision history by creating a new branch from
   your current branch, applying custom filters on each revision.
   (...)
   The command takes the new branch name as a mandatory argument and the
   filters as optional arguments

And in example:
   Now, you will get the rewritten history saved in the branch newbranch
   (your current branch is left untouched).

I must say this is a feature that would actually be nice to have...

> > And whereas git-filter-branch itself says there is such an argument,
> > it actually doesn't take it, and doesn't seem to be hardwired to create
> > a new branch instead of overwriting the current one.
> > 
> > So what is git-filter-branch supposed to be doing ?
> 
> To rewrite refs.
> 
> > As a side note, if it ever happens that git-filter-branch can create a
> > new branch, it might be nice to have each commit on the branch to have
> > the original commit as parent, as well as its branch parent, so that
> > they are seen as merges.
> 
> No, this will not happen.  Filter-branch is meant to clean up branches, so 
> it will rewrite the commits.  However, you might be able to hack something 
> in a parent filter.

That would need the commit id for the original commit being treated at the
time, which I don't think is available in parent filters...

Mike
