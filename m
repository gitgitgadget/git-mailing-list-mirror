From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sun, 22 Jul 2007 11:08:58 +0200
Message-ID: <851wf0pzyt.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
	<alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
	<851wf2bcqy.fsf@lola.goethe.zz>
	 =?ISO-8859-1?Q?=20<alpine.LFD.0.99?= =?ISO-8859-1?Q?9.07072=0402135450?= =?ISO-8859-1?Q?.27249?=
	=?ISO-8859-1?Q?@woody.linux-fou?= =?ISO-8859-1?Q?ndation.org>?=
	<alpine.LFD.0.999.0707202154220.27249@woody.linux-foundation.org>
	<85odi69vgt.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707210832180.27249@woody.linux-foundation.org>
	<85tzrxslms.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707211650190.3607@woody.linux-foundation.org>
	<85644dqoig.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707211737090.3607@woody.linux-foundation.org>
	<85r6n1p7sb.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707211840000.3607@woody.linux-foundation.org>
	<85fy3hp3f2.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707212040340.3607@woody.linux-foundation.org>
	<85abtpoydg.fsf@lola.goethe.zz>
	<Pine.LNX.4.64.0707212332530.6350@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun Jul 22 11:09:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICXRA-0003DL-M8
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 11:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761120AbXGVJJJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 05:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756611AbXGVJJI
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 05:09:08 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:59209 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759316AbXGVJJG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2007 05:09:06 -0400
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id A83442D9481;
	Sun, 22 Jul 2007 11:09:04 +0200 (CEST)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id 85E9028EC4D;
	Sun, 22 Jul 2007 11:09:04 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-022-107.pools.arcor-ip.net [84.61.22.107])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 3E6191C721C;
	Sun, 22 Jul 2007 11:09:04 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 97A2F1D1E182; Sun, 22 Jul 2007 11:08:58 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0707212332530.6350@asgard.lang.hm> (david@lang.hm's message of "Sat\, 21 Jul 2007 23\:38\:41 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3728/Sun Jul 22 07:07:30 2007 on mail-in-04.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53239>

david@lang.hm writes:

> On Sun, 22 Jul 2007, David Kastrup wrote:
>
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>>
>>> I told you. Several times. That "." is pointless exactly because
>>> it's in _every_ tree, and as such is no longer "content".
>>
>> "." is in every _non-empty_ directory tree.  But we are talking
>> about permitting _empty_ trees in the repository.  And for an empty
>> tree in the repository, "." may or may not be in the corresponding
>> work directory tree, depending on whether the directory exists or
>> not.  So when we are talking about a repository tree _becoming_
>> empty, we need the information whether or whether not we should
>> remove it upon becoming empty.  _That_ is the information content
>> of "." being or not being considered part of the trackable
>> material.  And the information is no longer available at the time
>> the repository tree becomes empty _unless_ we already store it
>> there when the tree is still populated.
>
> David, the point where you and Linus are talking past each other is
> that Linus is assuming that you only want to track some specific
> directories, and for that tracking "." doesn't work becouse it's in
> every directory
>
> you apparently consider every directory equal and therefor the fact
> that "." exists in every directory doesn't bother you becouse you
> want to track every directory.

Sigh.  No, I don't want to track every directory.  I want to have
every directory _trackable_.  Whether it is _tracked_ depends on
whether you _add_ it to the index.  And that depends, among other
things, on the gitignore patterns, and those can be specified on a
per-directory, per-project, per-user preference.

> what you are not hearing is that while Linus and the other git
> developers can see reasons to track directories sometimes, they
> definantly don't agree that you want to track directories all the
> time.

And that is why one can use per-directory, per-project and per-user
settings to turn the tracking off, _and_ one can decide at what level
one adds information to the index.  If you always make it a habit to
only ever use git-add -f and git-rm -f on _files_ and never on
directories, you won't _ever_ see a difference on whether directories
are tracked, and the contents of .gitignore won't make a difference,
either.

But if you use git-add and git-rm on directories, then for the
specified directory and its children, .gitignore gets consulted.

> sometimes the fact that a directory exists is significant, most of
> the time it's not. and the difference between what is and what isn't
> significant isn't a per-repository or per-project thing, it's a
> per-directory thing.

Which is why one can control it per-directory using either the
.gitignore mechanism _or_ by including the directory level in question
in the git-add and git-rm commands or not.

> in one repository you will have some directories that only exist
> becouse files are in them, and you may have some directories that
> exist becouse you explicitly want them to exist.
>
> both types have the "." file in them (or appear to, some
> OS's/filesystems don't actually have a "." on disk, they add it when
> needed when reporting to userspace), so git has no way to tell which
> ones you explicitly want tracked.

Like with any other file, git _has_ a way to tell.  If I don't git-add
or git-rm the directory or one of its parents to the index, I don't
want to have it tracked.  And if I add the directory or one of its
parents to the index recursively, but it is covered by .gitignore, I
don't want to have it tracked.

It is a pity that you have seemingly not read on, because there
follows a simple example:

>> Ok, here we go _again_.  Test case 1:
>>
>> mkdir a
>> touch a/b
>> git-add a/b
>> git-commit -m x
>> git-rm a/b
>> git-commit -m x
>>
>> Now we want to have the directory a _removed_.
>>
>> Test case 2:
>>
>> mkdir a
>> touch a/b
>> git-add a
>> git-commit -m x
>> git-rm a/b
>> git-commit -m x
>>
>> Now we want to have the directory a _retained_.
>>
>> After the first commit in _both_ test cases, the only file in the
>> trees / and /a is a/b.  The working directory state is _identical_ at
>> this point, and we do identical commands afterwards.
>>
>> The end result is not identical, so there must be some information
>> different in the repository after the first commit.  This information
>> _can't_ be encoded in a remaining empty tree, because both the trees /
>> and /a are _non_-empty yet.
>>
>> So we _must_ encode the evaporate-or-not-when-empty information
>> _otherwise_ into the repository.  And we do that by _not_ having
>> /a/. in the set of tracked files in test case 1, and by _having_ it in
>> the set of tracked files in test case 2.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
