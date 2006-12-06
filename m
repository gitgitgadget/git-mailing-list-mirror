X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git newbie problems
Date: Wed, 06 Dec 2006 02:23:06 +0100
Organization: At home
Message-ID: <el55to$952$1@sea.gmane.org>
References: <4574AC9E.3040506@gmail.com> <4574BF70.8070100@lilypond.org> <457611B9.9020907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 6 Dec 2006 01:21:32 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 195
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33397>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrlTP-0002mL-Cd for gcvg-git@gmane.org; Wed, 06 Dec
 2006 02:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759441AbWLFBVU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 20:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759451AbWLFBVU
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 20:21:20 -0500
Received: from main.gmane.org ([80.91.229.2]:50214 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1759441AbWLFBVT
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 20:21:19 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrlTF-0005Cu-OA for git@vger.kernel.org; Wed, 06 Dec 2006 02:21:13 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 02:21:13 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 06 Dec 2006
 02:21:13 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Graham Percival wrote:

> Greetings,
> 
> I'm posting these problems at Han-Wen and Dscho's insistence.  I'm the 
> documentation editor for GNU/LilyPond, so I'm reluctant to criticize 
> other project's documentation unless I spend an hour or more seriously 
> reading it.  I'm quite willing to admit that I never seriously tried to 
> read the docs on the overall theory of git (branches, repo, etc); I just

Branches are very useful concept. And I really like the idea of branches in
git (the underlying concept of branch as lineage) and its implementation.
But because CVS had seriously screwed implementation of branches, you
probably didn't use it.

> flailed around looking for magic commands to make things work.  By "make 
> things work", I mean imitating my work style with cvs:

Perhaps it would be better to at least read cvs-migration.txt
  http://kernel.org/pub/software/scm/git/docs/cvs-migration.html
and all tutorials.

> cvs co blah blah  (which I simply copy and paste from savannah)
> while (true) {
>    cvs update          // get changes that happened overnight

"git pull", or "git fetch". "git pull" is more like in CVS, because it
merges the changes that happened overninght with your work.

>    vi foo/bar/baz.txt  // or whatever editing commands you do
>    make; make web      // or whatever testing commands you do

Those steps do not depend on version control used.

>    cvs update          // get latest changes to prepare for
>                        // uploading my changes.
>    cvs ci foo/bar/baz.txt  // upload changes

With git you do this sequence not in braindead CVS "update then commit"
which leads to rare commits (because you don't have time to resolve merge
conflicts for example), but commit then upload changes.

"git commit -a" to commit changes (the standard format of commit message
describing the change expected by history viewers is to write short
one-line description of changes, separate by empty line from longer
description if it is needed (it usually is): see
  http://git.or.cz/gitwiki/CommitMessageConventions
(and also other pages on GitDocumentation page at GitWiki as well)).

Then "git push" to propagate your changes (or if you don't have permissions
to push into repository, "git format-patch HEAD^.." and "git send-mail" to
propagate your changes via email).

> }
> 
> Once or twice a year I'll do "cvs diff" or "cvs add", but all I really 
> want are the above commands.  I figured that this should be really easy 
> to do, so I kept on skimming through the docs, trying to find the 
> equivalent of these really easy commands.  (note that I was reading the 
> "tutorial introduction to git")

There are some commands which CVS didn't have, and which are very useful
with git: I'm talking here about "git show" (show latest change), "git
log" (show kind of changelog), and gitk (graphical history viewer) or qgit
(alternate graphical history viewer in Qt).

It is also of note that you can move and rename files, soemthing CVS had
much problems with.
 
> I should add that I've received help on the lilypond-devel list; I'm 
> posting this in case it helps future development for git docs, not 
> because I need more help to use git.
> 
> This case was particularly difficult because the very first time I tried
> to commit... err... push... err... "make my doc changes available to
> everybody else" (whatever the right term is), there was this merge
> problem. 
> 
> 
> 
> MERGE PROBLEM
> 
> Two people (me and another person) edited the same line on
> Documentation/user/advanced.itely at the same time.  (note that this 
> file has existed for over a year; it's not a new file)  When I tried to 
> get the most recent changes, I'm greeted with this:
> ...
> Trying really trivial in-index merge...
> Documentation/user/advanced-notation.itely: needs merge
> fatal: you need to resolve your current index first
> Nope.
> Merging HEAD with c21d3f3e1c77722e50d994763442e6f994b03ac2
> Merging:
> 038b7fc Misc small updates (trying to make git work).
> c21d3f3 Merge branch 'master' of
> ssh+git://hanwen@git.sv.gnu.org/srv/git/lilypond
> found 1 common ancestor(s):
> 84219bb don't have input/templates/ any longer.
> fatal: Entry '.gitignore' would be overwritten by merge. Cannot merge.
> No merge strategy handled the merge.
>
> 
> As a git newbie, I'm quite confused.  OK, there's no merge strategy...
> so what do I do now?  With cvs, the changes would be dumped into the
> file.  I look at the file, found the conflict, and tried it again.  I
> got the same error message, and then it occurred to me that although I
> changed the files in my ~/usr/src/lilypond, git might be storing these
> files somewhere else.

Yes, the git error messages certainly needs to be made more user-friendly.
What git says here that one version has '.gitignore' file handled by version
control, and second has it outside version control. At least I think what
it does. "git ls-files --unmerged" or "git diff --merge --summary" should
show 'true conflicts'.

By the way, which version of git do you use? I think this particular check
(if it is the case of this error) was relaxed.

> So I tried
> $ git commit Documentation/user/advanced-notation.itely
> Cannot do a partial commit during a merge.
> You might have meant to say 'git commit -i paths...', perhaps?

Hint: usually "git reset" or even "git reset --hard" *warning: the latter
would overwrite your changes since last commit! use with care) is what you
want to do to 'clean up' after some interrupted command.

> ... eh?  I'm trying to fix this so that you _can_ merge!  Regardless,
> when I tried to update again, I get
> 
> $ git pull gnu master
> ...
> Trying really trivial in-index merge...
> fatal: Entry '.gitignore' would be overwritten by merge. Cannot merge.
> Nope.
> Merging HEAD with c21d3f3e1c77722e50d994763442e6f994b03ac2
> Merging:
> 038b7fc Misc small updates (trying to make git work).
> c21d3f3 Merge branch 'master' of
> ssh+git://hanwen@git.sv.gnu.org/srv/git/lilypond
> found 1 common ancestor(s):
> 84219bb don't have input/templates/ any longer.
> fatal: Entry '.gitignore' would be overwritten by merge. Cannot merge.
> No merge strategy handled the merge.
> 
> 
> Now I'm totally confused, because I definitely haven't touched .gitignore.

I'm guessing that "git add .gitignore", "git commit -a -m
'Added .gitignore'" before retyring pull/push would help in such situation. 

> SUGGESTIONS
> 
> The "tutorial introduction to git" looks like a nice document, but it
> assumes that you are in control of the project.  For users who aren't in
> control (ie me) this is a problem, because it starts me skimming.
> "Importing a project"... nah, that's not me.  "Merging branches"... I
> don't care; I'm going to shove everything into the main branch.  "Using
> git for collaboration"... hmm, maybe this is the stuff I need to read.
> But by this point, I've already skimmed through five screens of info, so
> I'm not reading very carefully.
> 
> It would be nice to have an accompanying "tutorial introduction to
> contributing with git" for users (like me) who are not in control of a 
> project.
> 
> Finally, it would be really nice if there was some mention of "resolving
> merge problems" in the tutorial (both in the current one and any new
> docs). 

Check out "[DRAFT] Branching and merging with git" thread

  Message-ID: <20061116221701.4499.qmail@science.horizon.com>
  http://permalink.gmane.org/gmane.comp.version-control.git/31625
  http://thread.gmane.org/gmane.comp.version-control.git/31625/ 

which I hope would end as Documentation/tutorial-3.txt. Or you can read jdl
presentation from OLS; check out GitLinks / GitDocumentation at GitWiki:
  
  http://git.or.cz/gitwiki/

> (please CC me as I am not subscribed to the mailist)

I also am not subsribed to the mailing list, but read the list via GMane
NNTP (news, Usenet) interface: see http://git.or.cz/gitwiki/GitCommunity

  nntp://news.gmane.org/gmane.comp.version-control.git

P.S. For wuick answers to "what to do now" questions you might use #git
channel on FreeNode.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

