From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Tue, 3 Jun 2008 14:03:52 -0700 (PDT)
Message-ID: <354228.30165.qm@web31807.mail.mud.yahoo.com>
References: <200806031614.29161.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 23:04:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3dgW-00087X-I5
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 23:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbYFCVDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 17:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbYFCVDy
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 17:03:54 -0400
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:23688 "HELO
	web31807.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751725AbYFCVDx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jun 2008 17:03:53 -0400
Received: (qmail 30513 invoked by uid 60001); 3 Jun 2008 21:03:52 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=mySV/VV5Jhaw4/YORANO33dgX1IEpVKaFhEbDFU8BXy1HIAjkfW4A2OYJ14aMXPYBih8sbQDGL8JNCc8dJTzsrRM4eqxJfcTsDKFFybLqHAdJJLt3EoVbfwSDsYZufkc7xDO+kJtoalfDxmjiGCpMDDDg/H0GD0q/6svAOHssQ8=;
Received: from [99.159.44.58] by web31807.mail.mud.yahoo.com via HTTP; Tue, 03 Jun 2008 14:03:52 PDT
X-Mailer: YahooMailWebService/0.7.199
In-Reply-To: <200806031614.29161.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83710>

--- On Tue, 6/3/08, Jakub Narebski <jnareb@gmail.com> wrote:
> From: Jakub Narebski <jnareb@gmail.com>
> Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
> To: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
> Cc: git@vger.kernel.org, "Luben Tuikov" <ltuikov@yahoo.com>, "Sam Vilain" <sam@vilain.net>
> Date: Tuesday, June 3, 2008, 7:14 AM
> On Tue, 3 June 2008, Rafael Garcia-Suarez wrote:
> > 2008/6/3 Jakub Narebski <jnareb@gmail.com>:
> >>>
> >>> OK, I see. That would be nice. Also: currently
> taking "$full_rev^"
> >>> directs the user to the parent commit, but it
> would be more
> >>> user-friendly to point at the previous commit
> where the selected file
> >>> was modified instead.
> >>
> >> That's what I meant by distinguishing between
> 'parents' and
> >> 'original-parents' (or
> 'rewritten-parents' and 'parents'): first
> are
> >> rewritten parents in history limited to specified
> file (with the
> >> addition of code movements and copying across
> files/filenames),
> >> second are original parents of a commit.
> >>
> >> For gitweb we would use the first set (I wonder
> what to do in the case
> >> of merge commit, i.e. more than one parent).
> > 
> > Currently that takes the left parent. Or something.
> > 
> > Shameless plug : the sources for perl 5 are currently
> being kept in a
> > perforce repository. There is a rough web interface to
> it at
> > http://public.activestate.com/cgi-bin/perlbrowse with
> excellent blame
> > log navigation features (including navigation against
> p4
> > integrations).
> 
> By the way, what is the difference between
> '<<' links and 'br' link
> in the above mentioned annotate/blame interface?
> 
> I'd like to say that I prefer gitweb's marking
> blame by blocks, not by
> lines, and extra info on mouseover.

Completely agree.

>  But having blame
> navigation
> capability of perforce web interface would be really nice
> (I think
> "git gui blame" has something like this; I
> don't know about other
> tools like qgit, giggle, or ugit).

That was the intention of git_blame2()... myself just previously coming
from perforce...

So yes, long time ago, in a galaxy far, far away, I was using perforce for
data mining of the evolution of the code, in order to deduct intention.
And I had wanted the same capability in git, thus git_blame2 and commit
244a70e608204a515c214a11c43f3ecf7642533a.

> BTW. how in your opinion Git compares to Perforce, both as
> a tool
> itself, and also about quality of companion tools such like
> gitweb
> or git-gui?

What I did was prompted by what I had used with perforce, and on top
of it, improving on it.

So yes, I like git and gitweb.  At the moment they give me what I need,
and of course an edge over other SCMs is the distributed nature of git.

Thanks!
   Luben


> 
> >                                       I'm more or
> less trying to 
> > duplicate this blame log navigation in gitweb. So it
> might result in a
> > few patches here :)
> 
> I think it would be really nice.  Will you want to use
> git-diff-tree
> to mark differences from the version we came from (marked
> by 'hp',
> 'hpb' and 'fp' URI parameters), or would
> you rather extend git-blame?
> 
> -- 
> Jakub Narebski
> Poland
