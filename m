From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: sadly requesting help
Date: Wed, 31 Mar 2010 10:53:47 +0200
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2010-03-31-10-53-47+trackit+sam@rfc1149.net>
References: <eaacf13c1003301543r45bb18b2n1d10d209f01e3326@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Raymond Auge <raymond.auge@liferay.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 10:53:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwtgS-0006yp-Jv
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 10:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932935Ab0CaIxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 04:53:51 -0400
Received: from zoidberg.rfc1149.net ([91.121.19.179]:40293 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932881Ab0CaIxu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 04:53:50 -0400
Received: from localhost (unknown [IPv6:2001:6f8:37a:2:211:2fff:fe8a:af74])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id 395D46F69;
	Wed, 31 Mar 2010 10:53:48 +0200 (CEST)
In-Reply-To: <eaacf13c1003301543r45bb18b2n1d10d209f01e3326@mail.gmail.com>
	(Raymond Auge's message of "Tue, 30 Mar 2010 18:43:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143653>

>>>>> "Raymond" == Raymond Auge <raymond.auge@liferay.com> writes:

Raymond> We had a colo failure over the last day or so and lost the last
Raymond> 50-60 commits on our subversion repository (apparently, our
Raymond> backup strategy was not granular enough).

Raymond> Luckily I use Git locally using the git-svn conduit.

Raymond> I need to rewind my repository to an earlier revision and I'm
Raymond> hoping not to have to rebuild my local repo as the project is
Raymond> huge and takes me at least 16 hours to checkout using git-svn.

I know this does not answer your question, but why not use this incident
to switch to git, or at least to seriously investigate a possible future
switch to git?

As you probably know, with git it would have been really easy to restore
the full repository if at least one person does have a local copy of
each branch (typically, the last person to have committed on a branch is
likely to still have a full copy of the branch). And backups can be done
simply by running "git fetch" from a secondary machine at regular
intervals.

Success story: the company I worked for in 2008 had a similar incident a
few months after we switched from svn to git. Not only were we able to
restore a full repository copy, but also we were able to work in the
meantime by setting one of the developers machine as the central
repository, and development work was not disrupted for more than one
hour (we had to educate some developers who were not familiar with
setting remotes other than "origin" and pushing to them). We ran this
degraded setting for a few days (degraded because we lost continuous
testing and packaging capabilities that ran on the main server, and
developers had to run the test themselves by issuing frequent "make
check" commands), but it was certainly not considered a major failure.

In four words: git saved the day.

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
