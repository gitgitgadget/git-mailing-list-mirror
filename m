From: Felipe =?utf-8?Q?S=C3=A1nchez?= <blu@daga.cl>
Subject: tracking moved svn repo
Date: Thu, 18 Mar 2010 10:23:24 -0300
Message-ID: <20100318132324.GA14113@daga.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 18 15:07:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsGO3-0006Ca-5Z
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 15:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812Ab0CROHk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Mar 2010 10:07:40 -0400
Received: from pc-225-16-104-200.cm.vtr.net ([200.104.16.225]:35267 "EHLO
	daga.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753556Ab0CROHj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 10:07:39 -0400
X-Greylist: delayed 2653 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Mar 2010 10:07:39 EDT
Received: from blu by daga.cl with local (Exim 4.71)
	(envelope-from <blu@daga.cl>)
	id 1NsFh6-0007Ds-M8
	for git@vger.kernel.org; Thu, 18 Mar 2010 10:23:24 -0300
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142470>

In my job, the official SVN repo was moved from one machine to another.

I do all my work on my git repo and, of course, I work on several thing=
s in
parallel, keeping a lot of local branches.

Now a need to hack my git repo to track the SVN repo at its new locatio=
n.
I don't want to reclone the SVN repo because it would mean to move all =
my
local branches one by one.

The old machine's name is 'pipeline'. The new one is 'condor'.

I did the following:

$ git gc
Counting objects: 1898, done.
Compressing objects: 100% (1266/1266), done.
Writing objects: 100% (1898/1898), done.
Total 1898 (delta 1117), reused 1070 (delta 571)

$ git status
# On branch master
nothing to commit (working directory clean)

$ git filter-branch --msg-filter 'sed "s$git-svn-id: svn+ssh://pipeline=
$git-svn-id: svn+ssh://condor$g' $(cat .git/packed-refs | awk '// {prin=
t $2}' | grep -v 'pack-refs')
Cannot rewrite branch(es) with a dirty working directory.

Uh? Status finds my working directory clean, but filter-branch seems to
disagree.

Thanks in advance.

--=20
=46elipe S=C3=A1nchez
