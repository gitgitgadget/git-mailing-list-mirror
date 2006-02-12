From: Mark Wooding <mdw@distorted.org.uk>
Subject: Configuration file musings
Date: Sun, 12 Feb 2006 13:45:44 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrnduuf08.518.mdw@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Sun Feb 12 14:46:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8HYF-0006ae-9W
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 14:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWBLNqE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 08:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWBLNqE
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 08:46:04 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:6025 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1751029AbWBLNqD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 08:46:03 -0500
Received: (qmail 26061 invoked by uid 110); 12 Feb 2006 13:45:44 -0000
To: git@vger.kernel.org
Received: (qmail 26047 invoked by uid 9); 12 Feb 2006 13:45:44 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1139751944 26045 172.29.199.2 (12 Feb 2006 13:45:44 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Sun, 12 Feb 2006 13:45:44 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15995>

Having thought about things a bit, I've reached the conclusion that the
configuration file $GIT_DIR/config is trying to hold (at least) three
entirely different kinds of configuration.

  * User configuration: basically, how I like GIT to work for me.  I
    think that the way it represents my name in commit messages is user
    configuration, as would be the behaviour of `git-commit PATH'.
    Environment variables almost work for this, but they're a nuisance
    to change.  This stuff ought to be somewhere in my home directory,
    probably; though it would be useful to override temporarily, or on a
    per-repository basis.

  * Project configuration: how GIT should be supporting a particular
    project.  The merge.summary flag is like this, I think: whether to
    have summaries in merge messages is a policy decision to be taken
    for a whole project, rather than something to be left to the whims
    of individual developers.  Such settings probably to be propagated
    through git-clone, git-fetch and so on.

  * True repository configuration: how this particular repository ought
    to behave.  I can't think of many examples off the top of my head,
    but core.repositoryformatversion and core.filemode are the sorts of
    things I'm thinking of.

I'm not entirely sure where I'm going with this at the moment, and I
don't like some of the complexity which seems inherent in doing anything
about it, but I thought I'd stick my oar in anyway.

-- [mdw]
