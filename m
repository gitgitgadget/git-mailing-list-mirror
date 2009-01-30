From: Elijah Newren <newren@gmail.com>
Subject: [ANNOUNCE] EasyGit (eg) 0.97
Date: Fri, 30 Jan 2009 09:42:00 -0700
Message-ID: <51419b2c0901300842rb993454u7e8b6d1032c12ac8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 30 17:44:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSwSw-0001XO-Gt
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 17:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbZA3QmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 11:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752758AbZA3QmE
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 11:42:04 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:63397 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbZA3QmB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 11:42:01 -0500
Received: by yw-out-2324.google.com with SMTP id 9so200751ywe.1
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 08:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=/EpWc2870Y9KCjd+jYpIve99uzyE+il1BDT0MDLp02M=;
        b=Lh9BgGSWV33Ngjh3R9UAkXfl5m5p2WVDAS97pRotR1IMgF3ADsQdy1HItSrB1S0Lrt
         koaevUsE0nS7+wapCnleRduniNEAK3nIwKttp2MdMhe+WPt9WWQCopqBjs+FXWdQ4kyt
         pe6F1OapVOQGiHW9bPK7PlMPUmkcvLp+Wjdzk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=aGyeJzBS7Oa5bWFt3xoo2c9EIh/j/KDWuxYvgIKsCshnXJKYmKjc6RXn7isyvkqMV9
         3MEepn3Z2n3j35zk2qJYuc+D8O1BMBMuIXn8IfmJ4MneH1itnynewlno/9J04eig6Skk
         DnByX8Y34FqY8cNTRFHYYTI9MLdx3KCcKtWOQ=
Received: by 10.150.91.4 with SMTP id o4mr1340890ybb.207.1233333720044; Fri, 
	30 Jan 2009 08:42:00 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107847>

=== What is Easy Git? ===

Easy Git (eg) is an alternative frontend for git, specifically designed for
former cvs and svn users in order to provide a lower learning curve and
prevent common user errors.  Since eg largely looks and feels like core
git, eg can also serve as a training tool to teach users git (see below for
similarities and how to display git commands that eg uses).  There is a
detailed side-by-side comparison of svn and eg to help svn users make the
switch[1].  eg is trivial to install and try out: simply download a single
file and stick it in your PATH[2].

=== How different is eg from git? ===

eg is nearly backward-compatible to the core git porcelain, meaning that
you can take any git command, replace "git" with "eg" and run it[3]; I
believe that any behavioral differences between eg and git can be
discovered naturally and innocuously by an existing git user during normal
use of eg.  Also, you can switch back and forth between git and eg commands
in the same project.  Finally, eg is also somewhat forward-compatible with
the git porcelain, by which I mean that new flags to git commands are often
supported automatically in eg even if no modifications are made to eg.

=== If eg is so similar, what is the difference between eg and git? ===

Differences between eg and git[4] basically boil down to:
* eg has a replacement help system that is tutorial oriented for new users
  (these help pages do refer to the git manpages, for more in-depth details)
* eg does extra error checking to avoid some common gotchas
* eg changes some defaults, particularly where git defaults cause
  significant confusion and/or common gotchas for users
* eg has some (occasionally gratuitous) new svn-compatibility subcommands
  (cat, resolved, switch, update)

=== How far along is eg? ===

eg is essentially complete and has been for a while; I've used it daily
since last February, and there are multiple other users who do as well.
I've even benefitted from having some users who barely grasp the basics of
CVS who have tried eg and provided feedback ("[utterly broken workflow] is
what I do in CVS!  To figure out how to do that in eg I had to go _read_
some of the help pages -- why can't you make it easy?")

eg has just one major bug left that I know of[5]; otherwise it's
essentially 1.0.  eg requires fairly minimal maintainance -- most new
capabilities in git are automatically accessible through eg due to eg's
design of passing arguments on to git after optionally massaging them or
doing extra checks.  In fact, this design also means eg users can benefit
from documentation meant for core git, and that eg users should often be
able to get help from git users without git users really needing to learn a
different UI.  On the downside, this design also means that (a) eg feels
like an incomplete solution ("why does this message suggest running 'git
rebase --continue' when I'm using eg rather than git?"), and (b) eg's
interface is not simplified as much as it could be by focusing on a
specific use-case (e.g. centralized development) or providing a more
orthogonal UI[6].  It does, however, ease transition between the two tools
and potentially provide a testbed for ideas that could be adopted by git
more easily.

=== What's the path forward? ===

I have no idea.  It turns out that eg allowed me to overcome the concerns
of others at work that "git was too difficult to use", and was an important
part of convincing them to switch to git instead of svn (we're stuck with
CVS right now but are working on switching).  So eg won't die, unless git
itself adopts enough of the improvements in eg.  And really, some stuff
from eg may just not belong in git, so it may make sense to have an
independent script indefinitely (though it could certainly be made much
smaller).

What makes sense to the community?  Some possibilities:
* Keep working on eg completely independently
* Propose eg (and perhaps eg-completion.bash) for contrib
* Start a series of discussions on individual changes from eg and see which
  ones the community thinks make sense in git
* Have me stop being lazy and create patches for git as a basis of
  discussion
* Let the crickets chirp (i.e. just ignore this weird Easy Git guy)
* Some combination of the above, or maybe something else entirely?



Elijah


[1] http://www.gnome.org/~newren/eg/git-for-svn-users.html
[2] http://www.gnome.org/~newren/eg/download, or
[3] If you're curious if/how/when eg changes arguments before passing them
to git, you can run "eg --debug ARGS..." to see the git commands eg is
running.  If you just want to see the git commands that eg would run
without them also being executed, you can run "eg --translate ARGS..."
[4] For detailed differences, see
http://www.gnome.org/~newren/eg/git-eg-differences.html
[5] The bug I can only occasionally trigger and which I don't know the
cause of yet: when exiting from eg log the terminal settings sometimes
are messed up (with echo off and such), requiring a "reset" to get the
terminal back to normal.
[6] http://marc.info/?l=git&m=122071366316713&w=1
