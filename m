From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Odd number of elements in anonymous hash
Date: Thu, 10 Jan 2008 00:38:46 -0800
Message-ID: <20080110083846.GA15047@soma>
References: <200801081738.56624.devurandom@gmx.net> <7vbq7wteq4.fsf@gitster.siamese.dyndns.org> <200801081830.25722.devurandom@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dennis Schridde <devurandom@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jan 10 09:39:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCswv-0004Ad-Ty
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 09:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303AbYAJIis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 03:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754266AbYAJIis
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 03:38:48 -0500
Received: from hand.yhbt.net ([66.150.188.102]:36539 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753447AbYAJIir (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 03:38:47 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id D3D132DC08B;
	Thu, 10 Jan 2008 00:38:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200801081830.25722.devurandom@gmx.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70049>

Dennis Schridde <devurandom@gmx.net> wrote:
> Am Dienstag, 8. Januar 2008 18:21:55 schrieb Junio C Hamano:
> > Dennis Schridde <devurandom@gmx.net> writes:
> > > Hello!
> > >
> > > I am getting "Odd number of elements in anonymous hash at
> > > /usr/bin/git-svn line 1760." (normal output, no warning/error) during
> > > git-svn-clone. I am using git version 1.5.4.rc2.
> > >
> > > Line 1760 is this (with context, marked with '!!'):
> > >     # see if we have it in our config, first:
> > >     eval {
> > >         my $section = "svn-remote.$self->{repo_id}";
> > > !!        $svnsync = {
> > >           url => tmp_config('--get', "$section.svnsync-url"),
> > >           uuid => tmp_config('--get', "$section.svnsync-uuid"),
> > >         }
> > >     };
> > >
> > > The commandline was "git svn
> > > clone --authors-file=/var/git/org.gna.warzone.git/authors
> > > --use-svnsync-props --stdlayout file:///var/svn/warzone2100/
> > > org.gna.warzone.git/"
> > >
> > > I assume this is some kind of bug?
> >
> > More than one svn-remote.$your_repo.svnsync-{url,uuid}?
> PS: It doesn't happen for every revision and the folders (and thus config) 
> were empty before. The config doesn't list any "svnsync-*" during the import 
> process.

Can you look in .git/svn/.metadata for the svnsync-* values?  Thanks.

I downloaded your repository and couldn't reproduce it locally.

-- 
Eric Wong
