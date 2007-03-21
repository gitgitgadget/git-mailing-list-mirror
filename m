From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: GSoC & egit
Date: Wed, 21 Mar 2007 03:25:41 -0400
Message-ID: <20070321072541.GB4489@spearce.org>
References: <13d28e30703201606qdc7dd91mece971dab56a669a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Constantin Roxana <constantinrox@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 08:25:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTvCf-00024Z-Th
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 08:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbXCUHZr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 03:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbXCUHZq
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 03:25:46 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58105 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074AbXCUHZp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 03:25:45 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HTvCY-0002Ln-OX; Wed, 21 Mar 2007 03:25:42 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 080E220FBAE; Wed, 21 Mar 2007 03:25:41 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <13d28e30703201606qdc7dd91mece971dab56a669a@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42781>

Constantin Roxana <constantinrox@gmail.com> wrote:
> I am Roxana Constantin, I am a student and I want to participate to
> GSoC 2007 and work for git with the project of enhancing egit, the
> plugin for Eclipse.

Hey!  Welcome!  ;-)
 
> The users should be able to import with a wizard (clone in git) an
> outside project,

Here you mean a project that is already stored in Git, right?
Currently there is not enough library support in jgit to make this
function, even for the (trivial) case of just cloning a repository
that is already available on the local filesystem.  So jgit support
will need to be added.  Specifically a full "standard" clone would
require that we implement the logic of git-index-pack in jgit.
That program is about 1000 lines of C right now, so it shouldn't
be *that* difficult to implement.

> to commit

Yes, this is something I'd really like to see get done.  More so
than cloning, because users need to commit often, but they don't
clone very often.  Thus its "ok" to make them use the existing
command line tools to setup their project(s), but its not really
ok to make them use command line tools for daily tasks.

> and browse the history of the commits.

Robin Rosenburg has been doing some work in this area already,
which is quite a good start.  We can at least show a simple table
of commits that affect the selected file/folder in the Package
Explorer or Navigator, or in the current editor.  ;-)

Its not as powerful (or as useful) as any of the other Git history
viewers, but its a start at something!

> Also
> a perspective for egit (to include egit specifics), and extend the
> preference page (just a hello message now) with informations like
> user, email, or other properties.

Yes, these are good ideas.  Especially if we start to allow users
to create commits; they will want to configure their user.name and
user.email configuration options from within Eclipse.

> I believe that this minimum requirements should be met in order to be
> usable, so I would measure the success of my project by the amount of
> these features implemented.

I would remove the "import with a wizard (clone in git)" requirement
and instead replace it with at least basic merge support, such
as the two-way merge that gets used to switch between two branches.
This is an activity that I do at least 10x per day, if not more
frequently.  But I almost never clone.

In my mind, the goal of an Eclipse plugin for Git is to allow an
Eclipse user to get their daily tasks accomplished directly from
within Eclipse, where they are doing everything else too.  I just
don't think that project creation is not a daily task for most users,
but I know committing, branch creation and branch switching is.

> Also a documentation inside Eclipse help system would be useful.
> (through an extension point)

Yes, this would be very nice indeed.
 
> Milestones
> - from now and until May 28: get used with the source code, learn more
> about git/jgit
> (May 28 - June 10) - week 1- 2 : work on commit, get used with the jgit API
> (June 11 - June 24) - week 3 -4: finish any work left with commit,
> work for history browser
> (June 25 - July 8) - week 5-6: finish any work left on the history
> browser, add perspective, preference page
> (July 9 - July 22)- week 7-8: work on fine tuning the already
> implemented features, fix bugs, documentation, tests
> (July 23 - August 5) - week 9-10: analyses supporting branches and
> start to work towards supporting them: create, switch, delete
> (August 6- August 20) - finish any work left, write the final
> documentation, tests

Yes; this schedule mentions the things I was just talking abouve
above as being the important features.  It also does not mention
the import wizard.  ;-)

With the exception of branch switching, I think the above items are
probably quite doable within the timeframes you are talking about.
You might also be able to get branch switching implemented; but you
might not.  I actually expect you will need more than 2 weeks to get
a decent commit UI built up and working, especially since that is so
early in the project and you will still be getting started on things.

> A few extension points I want to extend are:
> org.eclipse.ui.preferencePages,  -- preference pages
> org.eclipse.core.runtime.preferences  -- initial values for preference pages
> org.eclipse.ui.importWizards,     -- clone a git repository
> org.eclipse.ui.perspectives,       --   git perspective
> org.eclipse.help.toc         -- documentation
> 
> Interfaces
> I sow that in org.spearce.egit.core is the plugin core (non UI)
> in org.spearce.egit.ui is the UI part of the plugin
> and org.spearce.jgit is the library with the pure Java implementation of 
> git.
> I will use jgit in egit-core and egit-ui, probably mostly 
> org.spearce.jgit.lib.*
> I do not know yet if I will need to change something in the library.

Yes.  Its likely that jgit will also need to be changed.  ;-)
 
> Preparations
> Because I never worked with git before:
> I compiled and installed git and read the tutorial, some man pages,
> and other docs from Git Documentation. I played with git to get
> accustomed how it works.

Good!

> I looked at egit sources, how the extension points from Eclipse are
> extended, what functionality is already there, and I tested the
> plugin.
> I built a demo plugin in Eclipse SWT to show you that I know how to
> work in the Eclipse environment.
> It draws fractals. It adds a new wizard to Eclipse and you can create
> a fractal in an existing project.
> You can install it the usual way by copying it to Eclipse/plugins/
> directory. The source code is in it.

I apologize for not taking a look at this right now.  I've had a
very long day, and still have about another 8 hours worth of tasks
to accomplish, but have under 4 hours in which to do them *and*
to get some sleep before tomorrow.

I will take a look at this in a day or two, when I can make the time.

-- 
Shawn.
