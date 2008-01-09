From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Odd number of elements in anonymous hash
Date: Wed, 9 Jan 2008 14:58:24 -0800
Message-ID: <20080109225824.GA10193@hand.yhbt.net>
References: <200801081738.56624.devurandom@gmx.net> <7vbq7wteq4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dennis Schridde <devurandom@gmx.net>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 23:58:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCjss-0004pA-6L
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 23:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755159AbYAIW60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 17:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754990AbYAIW60
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 17:58:26 -0500
Received: from hand.yhbt.net ([66.150.188.102]:36071 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754785AbYAIW6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 17:58:25 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id A57252DC08C;
	Wed,  9 Jan 2008 14:58:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vbq7wteq4.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70024>

Junio C Hamano <gitster@pobox.com> wrote:
> Dennis Schridde <devurandom@gmx.net> writes:
> 
> > Hello!
> >
> > I am getting "Odd number of elements in anonymous hash at /usr/bin/git-svn 
> > line 1760." (normal output, no warning/error) during git-svn-clone.
> > I am using git version 1.5.4.rc2.
> >
> > Line 1760 is this (with context, marked with '!!'):
> >     # see if we have it in our config, first:
> >     eval {
> >         my $section = "svn-remote.$self->{repo_id}";
> > !!        $svnsync = {
> >           url => tmp_config('--get', "$section.svnsync-url"),
> >           uuid => tmp_config('--get', "$section.svnsync-uuid"),
> >         }
> >     };
> >
> > The commandline was "git svn 
> > clone --authors-file=/var/git/org.gna.warzone.git/authors --use-svnsync-props --stdlayout 
> > file:///var/svn/warzone2100/ org.gna.warzone.git/"
> >
> > I assume this is some kind of bug?
> 
> More than one svn-remote.$your_repo.svnsync-{url,uuid}?
> 
> (Eric CC'ed).

I don't use svnsync myself.  I think Sam does, or would have more
insight into this than myself.  I'll hopefully have time to take a
harder look at it later tonight.

-- 
Eric Wong
