From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: Re: Find out on which branch a commit was originally made) (was ANNOUNCE git-what-branch)
Date: Thu, 23 Sep 2010 10:27:11 -0400
Message-ID: <201009231427.o8NERBqF019672@no.baka.org>
References: <201009222326.o8MNQJ2E022410>
        <32741263.335615.1285247653984.JavaMail.root@mail.hq.genarts.com>
Cc: Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org,
	Artur Skawina <art.08.09@gmail.com>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 16:27:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oymlm-0003Wo-1F
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 16:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755431Ab0IWO1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 10:27:21 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:60072 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753991Ab0IWO1V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 10:27:21 -0400
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id o8NERCIZ011303
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 Sep 2010 10:27:13 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id o8NERBqF019672;
	Thu, 23 Sep 2010 10:27:12 -0400
In-reply-to: <32741263.335615.1285247653984.JavaMail.root@mail.hq.genarts.com>
Comments: In reply to a message from "Stephen Bash <bash@genarts.com>" dated "Thu, 23 Sep 2010 09:14:14 -0400."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156869>


In message <32741263.335615.1285247653984.JavaMail.root@mail.hq.genarts.com>, S
tephen Bash writes:

    ----- Original Message -----
    > From: "Seth Robertson" <in-gitvger@baka.org>
    > To: "Artur Skawina" <art.08.09@gmail.com>
    > Cc: "Stefan Haller" <lists@haller-berlin.de>, git@vger.kernel.org
    > Sent: Wednesday, September 22, 2010 7:26:19 PM
    > Subject: Re: Find out on which branch a commit was originally made) (was ANNOUNCE git-what-branch)
    >
    > ... I wanted something completely different. Something more
    > like: if a bug was introduced in commit X, what releases or branches
    > has it contaminated (or more positively, if a feature was introduced,
    > where was it made available). The simple case is figuring out on
    > which branch a commit was originally made.

    Wait... When you restate the problem that way, isn't
    git-{branch,tag} --contains the right answer?  I'm curious how you
    (and others) would differentiate the approaches...

Oh, it is, don't get me wrong.  I actually use `git-branch --contains`
in the script to generate my candidate list. This doesn't solve the
cherry-pick problem, but I don't solve that either (yet).  I found it
difficult to verbalize exactly why this was needed--I know I have
needed it in the past which was why I pounced on the thread and used
the ideas to write git-what-branch
http://github.com/SethRobertson/git-what-branch

    If I were to frame this discussion, I think the value of
    git-what-branch is the ability to extract the branch name that a
    commit was created on.  In many environments the branch name may
    be useless (see the i18n example earlier in this discussion), but
    at least in our corporate environment, branches (especially those
    that are going to merge into mainline development) are named very
    consistently.  So in our situation the branch name can produce
    information that may not be captured in the standard reporting
    products (branch names transform into conventional tag names,
    branch names imply a lead developer, branch names spur developers'
    memories, ...).

Exactly.  The ability to see if a commit was born on a branch or what
branch it was merged to first is what is most important (anonymous
branches do exist even if you try to use --rebase consistently) so the
ability to find which branch it merged into first is also important.
This is the default operating mode of git-what-branch.

To a lesser extent, fornensics to help understanding how a commit
merged into a specific target may also be interesting.  It would be
even nicer if we could express a path of interest to gitk so that you
could have that specific path highlighted in a `gitk --all` output.

Hmm.  Path/commit highlighting would be a nice feature in gitk no
matter what.  --highlight-stdin to highlight specific commits (and
ideally an algorithm to allow the connecting arcs for adjancent
commits to be highlighted.  There is already an interestedin hammer
Also being able to highlight specific commits at runtime (probably a
different color) and potentially enter a commit note would be pretty
cool as well.  Unfortunately I have a different skill-set.

					-Seth Robertson
