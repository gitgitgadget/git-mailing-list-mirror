From: David Kastrup <dak@gnu.org>
Subject: Re: Terminology question about remote branches.
Date: Sun, 05 Aug 2007 09:06:24 +0200
Message-ID: <85k5sacvf3.fsf@lola.goethe.zz>
References: <854pjfin68.fsf@lola.goethe.zz>
	<20070804120243.GB9716@coredump.intra.peff.net>
	<85tzrfh3yg.fsf@lola.goethe.zz>
	<8c5c35580708040607ya186edcg89fbc90587b64d68@mail.gmail.com>
	<85r6mjdyl8.fsf@lola.goethe.zz>
	<Pine.LNX.4.64.0708041804260.13596@beast.quantumfyre.co.uk>
	<85hcnfdvtr.fsf@lola.goethe.zz> <20070804225655.GD11150@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Lars Hjemli <lh@elementstorage.no>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Aug 05 09:06:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHaCL-0004gA-OD
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 09:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024AbXHEHGc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 03:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753047AbXHEHGc
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 03:06:32 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:50772 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752406AbXHEHGb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 03:06:31 -0400
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 443CC31F34A;
	Sun,  5 Aug 2007 09:06:30 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id 3108D114321;
	Sun,  5 Aug 2007 09:06:30 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-057-031.pools.arcor-ip.net [84.61.57.31])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id DF431292B61;
	Sun,  5 Aug 2007 09:06:29 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 3C2921C4F932; Sun,  5 Aug 2007 09:06:24 +0200 (CEST)
In-Reply-To: <20070804225655.GD11150@thunk.org> (Theodore Tso's message of "Sat\, 4 Aug 2007 18\:56\:55 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3857/Sun Aug  5 08:20:59 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54958>

Theodore Tso <tytso@mit.edu> writes:

> On Sat, Aug 04, 2007 at 08:00:00PM +0200, David Kastrup wrote:
>
>> No, it would seem that I can just
>> git-clone -l
>> my repository and be set up in the new order of things.  Nice.
>
> Be careful, not really.  A git-clone -l will set up a new repository
> where origin/master is your original repository, i.e.:
>
> [remote "origin"]
>         url = /usr/projects/e2fsprogs/base
>         fetch = +refs/heads/*:refs/remotes/origin/*
> [branch "master"]
>         remote = origin
>         merge = refs/heads/master
>
> In contrast, if you had done a git-clone of remote repository, you
> might see something like this instead:

Yes, I noticed.  I can do a
git-clone -l --reference /my/local/rep git://the/remote/repo

instead.  That's still very fast, but I miss out on my local changes...

> [remote "origin"]
>         url = git://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git
>         fetch = +refs/heads/*:refs/remotes/origin/*
> [branch "master"]
>         remote = origin
>         merge = refs/heads/master
>
>> However, it would appear from my experiments up to now that the
>> --track option _can't_ be made to work with a 1.4 repository.  I think
>> that is worth mentioning in the docs.
>
> The real issue is that a "1.4 repository" (that is a repository
> created by "git clone" from git 1.4 and where the config file hasn't
> been updated either by hand-editing the config file or by use of
> "git config" or "git remote" to have remote branches) doesn't have
> any remote branches, and git branch -track only has significance if
> you are creating a new (local) branch from a remote tracking branch.

An error message might be nice, though.  I find git hard to understand
at times.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
