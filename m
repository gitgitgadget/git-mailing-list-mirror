From: Mike Linck <mgl@absolute-performance.com>
Subject: Questions about branches in git
Date: Thu, 28 Jan 2010 11:44:26 -0700
Message-ID: <69b754db1001281044y39e52f77hcc8f83144776c78f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 19:44:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaZM2-0006R4-FA
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 19:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769Ab0A1So3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 13:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755844Ab0A1So2
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 13:44:28 -0500
Received: from mail-pz0-f189.google.com ([209.85.222.189]:64080 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755774Ab0A1So2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 13:44:28 -0500
Received: by pzk27 with SMTP id 27so790080pzk.33
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 10:44:26 -0800 (PST)
Received: by 10.142.62.34 with SMTP id k34mr1497005wfa.282.1264704266834; Thu, 
	28 Jan 2010 10:44:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138263>

Hi, my company switched to git a few months ago because the way it
handles submodules seems safer to us than our previous scm tool and
because our ruby developers wanted to take advantage of the community
on github.  However, I'm having some problems getting git's
representations of branches to show me what change sets they contain.
It seems that after a topic or bug branch is merged back into its
parent, especially if it was fast forwarded, it becomes hard to
determine what changes were made in it, to resolve the problem that it
was created to address.  This is fairly important to me since I need
to be able to backport fixes to older revisions on occasion, and to
perform development on multiple releases for multiple platforms in
parallel, so it seems really handy for a branch to show us just the
changes that were made in it, between the time it was spawned from its
parent and the time the parent accepted its changes.

I've looked through as much documentation as I can find about git show
and git log, and I've played around with git rebase to try to apply
changes to multiple places, but I have not been able to find a way to
display the commits relevant to a particular bug/topic branch.
Rebasing from a branch that has already had the changeset merged back
in, to another branch, seems to actually wipe out the contents of the
branch completely.

I understand that there are mechanism kind of available to address
this problem.  If we (all developers in my company) remember always to
rebase -i before they merge their topic branches back in, then it
could be squashed making it easier to identify and cherry pick onto
other branches, or *if* we always remember to rebase before we merge
and then create a patch set and store that on the topic branch, we
could kind of organize our change sets that way.  But it seems that it
should be easier than that, shouldn't it?  If I look at the git log
for a branch, I really feel that I should see some distinction between
that changes that were originally made on a branch, and the ones that
were inherited from some other branch or merged in from some other
branch.  Simply because mistakes get made and if you we don't realize
that a fix may need to be applied to some older revision when we first
develop it, it seems that this could really cost a lot of time and
money to try to identify the individual commits that were useful in
addressing the problem.

What am I missing here?

Any help is appreciated.

Thank you,

Michael Linck
