From: "Thomas Leonard" <talex5@gmail.com>
Subject: Re: Fwd: [Bug 163341] Re: git-svn gets wrong parent revision for tags
Date: Tue, 8 Apr 2008 21:43:03 +0100
Message-ID: <cd53a0140804081343l4b791dc3x5fa3fb294af71621@mail.gmail.com>
References: <20071117143713.8355.50653.malonedeb@potassium.ubuntu.com>
	 <20080407195610.13681.39351.malone@potassium.ubuntu.com>
	 <cd53a0140804080848r54bb1e6dq54b5cce62339d6d1@mail.gmail.com>
	 <20080408171502.GA6163@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 08 22:45:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjKfc-0002io-8g
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 22:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbYDHUnM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Apr 2008 16:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752607AbYDHUnL
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 16:43:11 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:53120 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbYDHUnJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Apr 2008 16:43:09 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2192058wxd.4
        for <git@vger.kernel.org>; Tue, 08 Apr 2008 13:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=dh0PAJFT18O+WNdE9UhUB0jQ5/fWVumm98bOS+KcnB4=;
        b=XY2ewli263NbXrXPIwaMtFWkhGCgKmMw7drtz7rvp1dwMlkK6cVtro1GxQgv2MQ5R0OqWsU2OBk0oYvR6ujfHQdoQETdFJ6Od1I/b5JgK6e0nZiitqxpDBZ5c8m5tuOfHVshFdrgUNjeeItJoVli5/GAhZ3Av2k9wIvGa/DPI2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n2ilMDLswHyB2YDLCYz/EpujUDJkHm4REXfGg/sHL32dmQnPlydbwJsQGNjgDtDERp31clnjV0qq5LqPGbtv3NeKAp2w59HAyzkUSJai+jXQuBmP444VYBX9qMJFjr+Kw4kSt5i4DAMBsLvNDJFSKZCl2L5eqAOB78q7M97Y/rQ=
Received: by 10.100.140.15 with SMTP id n15mr13727321and.87.1207687383828;
        Tue, 08 Apr 2008 13:43:03 -0700 (PDT)
Received: by 10.100.105.20 with HTTP; Tue, 8 Apr 2008 13:43:03 -0700 (PDT)
In-Reply-To: <20080408171502.GA6163@atjola.homenet>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79029>

On 08/04/2008, Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> wrote:
> On 2008.04.08 16:48:03 +0100, Thomas Leonard wrote:
[...]
>  > When converting a subversion repository to GIT using git-svn, the =
tags
>  > do not have the right parent. Each tag should be identical to a tr=
unk
>  > revision (which it was copied from), but because git-svn uses an
>  > earlier revision as the parent it appears that the same work was
>  > duplicated on two branches.
[...]
>  > git-svn clone https://zero-install.svn.sourceforge.net/svnroot/zer=
o-install
>  > -T trunk/0publish -r1890:2072 -b releases/0publish
>  >
>  > The git branch comes from r1894, yet the svn log shows that in
>  > includes files from r2070:
>  >
>  > $ svn log https://zero-install.svn.sourceforge.net/svnroot/zero-in=
stall
>  > -r2071 -v
>  > r2071 | tal197 | 2007-11-10 19:40:45 +0000 (Sat, 10 Nov 2007) | 1 =
line
>  > Changed paths:
>  >    A /releases/0publish/0publish-0.12 (from /trunk/0publish:1968)
>  >    R /releases/0publish/0publish-0.12/0publish (from
>  > /trunk/0publish/0publish:2070)
>  >    R /releases/0publish/0publish-0.12/0publish.xml (from
>  > /trunk/0publish/0publish.xml:2070)
>  >    R /releases/0publish/0publish-0.12/release.py (from
>  > /trunk/0publish/release.py:2069)
>
> Well, SVN recorded useless, broken metadata.

This is certainly true ;-)

>  SVN itself believes that the branch was created from revision 1968. =
As
>  that revision didn't introduce any changes to trunk/0publish, there'=
s no
>  commit for that revision in the git branch, so git-svn took the most
>  recent one instead (1894).

>  For the other three files, SVN reports that the files were replaced =
by
>  versions from another branch. There's no immediate way to tell wheth=
er
>  those replacements make the branch equal to the more recent version =
of
>  trunk. So git-svn does it the safe way and reproduces what SVN told =
it
>  to reproduce: A commit that creates a branch and changes some files.
>
>  I guess sth. like this happened on the svn end:
>  svn cp trunk/0publish releases/0publish (at rev. 1968)
>  svn cp trunk/0publish/release.py releases/0publish (at rev. 2069)
>  ...
>  svn commit (whenever)

The script that made the releases simply did this ("." is the working c=
opy):

svn cp -m "Released $VERSION" . http://...

Since each file in an svn working copy has its own revision (the last
time it was changed), the branch ends up with multiple source
revisions, even if the working copy is fully up-to-date and has no
local changes.

Example:

cd /tmp
svnadmin create test-repo
svn mkdir file:///tmp/test-repo/trunk -m 'Setup'
svn co file:///tmp/test-repo/trunk
cd trunk
touch foo bar
svn add foo bar
svn ci -m 'Start'
echo hi > bar
svn ci -m 'Update'
svn cp . file:///tmp/test-repo/release -m 'Release'
svn log -v file:///tmp/test-repo

The log shows:

-----------------------------------------------------------------------=
-
r4 | talex | 2008-04-08 21:35:44 +0100 (Tue, 08 Apr 2008) | 1 line
Changed paths:
   A /release (from /trunk:1)
   A /release/bar (from /trunk/bar:3)
   A /release/foo (from /trunk/foo:2)

Release

So, I don't think the metadata is broken in this case. Maybe other
people don't create branches like this, but it seemed like the obvious
way to do it at the time. Given this behaviour of svn, perhaps it
would be better to take the highest version number as the branch
point?


--=20
Dr Thomas Leonard		http://rox.sourceforge.net
GPG: 9242 9807 C985 3C07 44A6  8B9A AE07 8280 59A5 3CC1
