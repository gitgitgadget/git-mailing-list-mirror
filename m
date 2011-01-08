From: Yaroslav Halchenko <debian@onerussian.com>
Subject: Re: problem with cherry-picking a commit which comes before
 introducing a new submodule
Date: Fri, 7 Jan 2011 19:01:31 -0500
Message-ID: <20110108000131.GR6040@onerussian.com>
References: <20110107172432.GA6040@onerussian.com>
 <20110107181501.GA28980@burratino>
 <20110107183226.GG6040@onerussian.com>
 <20110107230017.GA15495@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 01:01:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbMFW-000426-Ay
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 01:01:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029Ab1AHABd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 19:01:33 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:35693 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab1AHABc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 19:01:32 -0500
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1PbMFP-0006uQ-KU; Fri, 07 Jan 2011 19:01:31 -0500
Received: from yoh by washoe.onerussian.com with local (Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1PbMFP-0006uN-Fa; Fri, 07 Jan 2011 19:01:31 -0500
Content-Disposition: inline
In-Reply-To: <20110107230017.GA15495@burratino>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: git@vger.kernel.org, jrnieder@gmail.com, newren@gmail.com
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164792>

message is different -- result the same:
I: writing typescript to /home/yoh/.tmp/script.git-cherry-pick.17386.20110107.1857 ...
% git --version
git version 1.7.4.rc1
% git reset --hard
HEAD is now at 855981d just placeholders in the abstract
% export GIT_MERGE_VERBOSITY=5
% git cherry-pick todonotloose
CONFLICT (file/directory): There is a directory with name frontiers/code in a00c497... Initial draft for HBM abstract.. Adding frontiers/code as frontiers/code~HEAD
error: could not apply a00c497... Initial draft for HBM abstract.
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'
hint: and commit the result with 'git commit -c a00c497'
% git status      
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#   new file:   poster-hbm2011_neurodebian/abstract.txt
#   modified:   poster-hbm2011_neurodebian/jb.txt
#
# Unmerged paths:
#   (use "git reset HEAD <file>..." to unstage)
#   (use "git add/rm <file>..." as appropriate to mark resolution)
#
#   added by us:        frontiers/code
#
% git reset --hard
HEAD is now at 855981d just placeholders in the abstract
%         base=todonotloose^
%         next=todonotloose
%         head=HEAD
% 
%         git merge-recursive $base -- $head $next
Merging HEAD with todonotloose
Merging:
855981d just placeholders in the abstract
a00c497 Initial draft for HBM abstract.
found 1 common ancestor(s):
4708e24 minor moves around
CONFLICT (file/directory): There is a directory with name frontiers/code in todonotloose. Adding frontiers/code as frontiers/code~HEAD
%         git ls-files -u;        # after the merge
160000 a2b57871d2d79bef06ba6214739d82b9a63772a8 2   frontiers/code
zsh: command not found: #
%         git diff-tree todonotloose
a00c497fa399c00486c97121ed0b8fda72c7ce47
:040000 040000 40427e34a1ff89c458f2a5f262a108d46b4fa004 c7ba91028b1cef63f4f7eef70f0c4054b31e92b6 M  poster-hbm2011_neurodebian
%         git diff-tree todonotloose^ HEAD
:100644 100644 378e1379ec5ebb7abac59fec162b7238b5846525 c39ced763aeb5fd352cecd6fef1bfc40471f2246 M  .gitmodules
:000000 040000 0000000000000000000000000000000000000000 141dbc1bfe1be2eab77f04ca03f6f28feb372cca A  challenge-execpapers
:040000 040000 401fd66867de412b8653dc3a698bbaa45441bec1 ee190f09786f324abdda6e7a36e8278c201a20a0 M  frontiers
:040000 040000 26c884a67efb55bdf96d7453d9acd50cee36ae90 ad3e829d15b302c4342a6b2a9fb5dfede0ed77c9 M  sty



On Fri, 07 Jan 2011, Jonathan Nieder wrote:

> Yaroslav Halchenko wrote [abbreviated]:

> > Merging HEAD with todonotloose
> > Merging:
> > 855981d just placeholders in the abstract
> > a00c497 Initial draft for HBM abstract.
> > CONFLICT (file/directory): There is a directory with name frontiers/code in todonotloose. Adding frontiers/code as
> > +frontiers/code~HEAD
> > %         git ls-files -u
> > 160000 a2b5787 2   frontiers/code
> > %         git diff-tree todonotloose
> > a00c497
> > :040000 040000 40427e34 c7ba910 M	poster-hbm2011_neurodebian
> > %         git diff-tree todonotloose^ HEAD
> > :100644 100644 378e137 c39ced7 M	.gitmodules
> > :000000 040000 0000000 141dbc1 A	challenge-execpapers
> > :040000 040000 401fd66 ee190f0 M	frontiers
> > :040000 040000 26c884a ad3e829 M	sty

> One more piece of protocol: what git version are you using?  The
> release notes mention a fix in this area in v1.7.3[1]:

>  * "git merge -s recursive" (which is the default) did not handle cases
>    where a directory becomes a file (or vice versa) very well.

> Hopefully this is that.  In any case, sounds like a bug.

> (Hopefully someone else can comment on why cherry-pick uses the
> merge machinery to notice conflicts that would not be clear from
> the patch alone.)

> Thanks again.
> Jonathan

> [1] There is an updated Debian source package at [2].  Or, probably
> faster: one can use the build result in bin-wrappers/ from a git.git
> clone in place.
> [2] http://mentors.debian.net/debian/pool/main/g/git/git_1.7.4~rc1-0.1.dsc


-- 
=------------------------------------------------------------------=
Keep in touch                                     www.onerussian.com
Yaroslav Halchenko                 www.ohloh.net/accounts/yarikoptic
