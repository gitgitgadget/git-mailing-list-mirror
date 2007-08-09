From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-filter-branch
Date: Thu, 9 Aug 2007 09:58:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708090954550.21857@racer.site>
References: <20070809063453.GA12602@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 10:59:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ3rP-0005m3-O5
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 10:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbXHII7O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 04:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbXHII7N
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 04:59:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:55478 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765290AbXHII7J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 04:59:09 -0400
Received: (qmail invoked by alias); 09 Aug 2007 08:59:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 09 Aug 2007 10:59:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18xDzEF6/sxB2gvIitz76rwppsNqBvVRjcoThCbG1
	AOsERVV25EM3tA
X-X-Sender: gene099@racer.site
In-Reply-To: <20070809063453.GA12602@glandium.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55432>

Hi,

On Thu, 9 Aug 2007, Mike Hommey wrote:

> What is supposed to be the usage() of git-fetch-branch ?
> 
> git-filter-branch itself says:
> git-filter-branch [-d TEMPDIR] [FILTERS] DESTBRANCH [REV-RANGE]

This is an unfortunate left-over.  The syntax described in the 
documentation should be right.

> while the documentation doesn't explicitely talk about DESTBRANCH,
> expect in the form of an hypothetical /newbranch/, that you obviously
> don't give to the command line.

Hmm.  I don't have time to look into this now, but the syntax is this:

	git filter-branch [<options>] [--] [<rev-options>]

Those refs that you give in the <rev-options> are rewritten.  AFAIR the 
old values of the refs (if different) are written to refs/original/*.

> And whereas git-filter-branch itself says there is such an argument,
> it actually doesn't take it, and doesn't seem to be hardwired to create
> a new branch instead of overwriting the current one.
> 
> So what is git-filter-branch supposed to be doing ?

To rewrite refs.

> As a side note, if it ever happens that git-filter-branch can create a
> new branch, it might be nice to have each commit on the branch to have
> the original commit as parent, as well as its branch parent, so that
> they are seen as merges.

No, this will not happen.  Filter-branch is meant to clean up branches, so 
it will rewrite the commits.  However, you might be able to hack something 
in a parent filter.

Ciao,
Dscho
