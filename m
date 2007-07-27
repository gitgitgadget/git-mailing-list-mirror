From: David Kastrup <dak@gnu.org>
Subject: Re: git-gui problem with version number.
Date: Fri, 27 Jul 2007 09:42:03 +0200
Message-ID: <86k5smnvhw.fsf@lola.quinscape.zz>
References: <86odhzpg2l.fsf@lola.quinscape.zz> <20070727044634.GG20052@spearce.org> <85y7h25sg6.fsf@lola.goethe.zz> <20070727053627.GI20052@spearce.org> <85odhy5rm6.fsf@lola.goethe.zz> <20070727054815.GJ20052@spearce.org> <85ejiu5r9r.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 09:42:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEKTE-0001cN-7A
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 09:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762186AbXG0HmW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 03:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762101AbXG0HmV
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 03:42:21 -0400
Received: from main.gmane.org ([80.91.229.2]:51017 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762138AbXG0HmU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 03:42:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IEKSi-000156-Mi
	for git@vger.kernel.org; Fri, 27 Jul 2007 09:42:12 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Jul 2007 09:42:12 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Jul 2007 09:42:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:i4Gy4xL/RuOSbQpfFpmN25Be2pc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53905>

David Kastrup <dak@gnu.org> writes:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> David Kastrup <dak@gnu.org> wrote:
>>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>>> > Anyway, you can setup a build with the most recent 'stable
>>> > development' version of git-gui:
>>> >
>>> >   git checkout -b with-new-gitgui
>>> >   git pull -s subtree git://repo.or.cz/git-gui.git
>>> 
>>> Ok.  Would the necessity for this depend on the Tcl version?
>>
>> I thought all versions of Tcl did not understand the 'creative'
>> git version strings.  So I'm surprised to hear it works on one
>> system but not on another, even though you have the same version
>> of git and git-gui.
>
> I'll check once I am at work, but I am pretty sure that the versions
> are pretty much in synch.

Now that is funny.  I am pretty sure (or rather _have_ been pretty
sure) that I cloned the respective repositories with the same command.
Yet now both are up-to-date according to git-pull (and have identical
.config contents), and the first compiles version git version
1.5.3.rc2.41.gb47b1 while the second compiles version
1.5.3.rc3.7.gd58e-dirty.  Both have been cloned from git.git, the
second with

* master
  origin/HEAD
  origin/html
  origin/maint
  origin/man
  origin/master
  origin/next
  origin/pu
  origin/todo

and the first with
* master
  origin/HEAD
  origin/html
  origin/maint
  origin/man
  origin/master
  origin/next
  origin/pu
  origin/todo

On the one with the problematic version, I get
git-rev-list -2 origin/HEAD |git-name-rev --stdin
d58e8d34b019d435b424811c6f972910dfac6f55 (master)
1a44be9a0ff6fa623ff6061992f5ad1831dc7cab (master~1)

and on the other one I get
git-rev-list -2 origin/HEAD |git-name-rev --stdin
d58e8d34b019d435b424811c6f972910dfac6f55 (remotes/origin/HEAD)
1a44be9a0ff6fa623ff6061992f5ad1831dc7cab (remotes/origin/HEAD~1)

git-rev-list -2 master |git-name-rev --stdin
0d59d6cfd3ed2510a8e7d8c9fbc54c21133bc3a6 (master)
d58e8d34b019d435b424811c6f972910dfac6f55 (remotes/origin/HEAD)

So let me guess: the "dirty" in the version number comes about when
one has changes that are not in the upstream version, and it is this
string which confuses git-gui?

But then the version numbers are _so_ different.  I probably am
overlooking something.

-- 
David Kastrup
