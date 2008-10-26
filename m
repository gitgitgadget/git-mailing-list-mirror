From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git export to svn
Date: Sun, 26 Oct 2008 18:15:19 +0100
Message-ID: <20081026171519.GD3612@atjola.homenet>
References: <FC51BBF1-B2CA-4A00-9312-2333FDA537C2@gmail.com> <1224960205.2874.11.camel@localhost.localdomain> <77DFC428-35AE-4F66-9D9F-3D4E0005727D@gmail.com> <1224965564.2874.49.camel@localhost.localdomain> <2F1954CC-E013-4861-87F8-F89CF37CE53C@gmail.com> <20081026091554.GC3612@atjola.homenet> <8ED0030A-E55E-4082-87C9-53B11F763E1B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org
To: Warren Harris <warrensomebody@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 18:25:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ku9N2-000371-Sv
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 18:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbYJZRP0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Oct 2008 13:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbYJZRPZ
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 13:15:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:46675 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752004AbYJZRPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 13:15:25 -0400
Received: (qmail invoked by alias); 26 Oct 2008 17:15:22 -0000
Received: from i577B879F.versanet.de (EHLO atjola.local) [87.123.135.159]
  by mail.gmx.net (mp056) with SMTP; 26 Oct 2008 18:15:22 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/4AABPESH4lCoB/j7Q08DZAE4QZY7nqs43G4JsvN
	bQxo/MDfxLBKOZ
Content-Disposition: inline
In-Reply-To: <8ED0030A-E55E-4082-87C9-53B11F763E1B@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99174>

On 2008.10.26 09:24:07 -0700, Warren Harris wrote:
>
> On Oct 26, 2008, at 2:15 AM, Bj=F6rn Steinbrink wrote:
>
>> On 2008.10.25 13:29:50 -0700, Warren Harris wrote:
>>> I tried a fetch, but still no luck:
>>>
>>> $ git svn fetch
>>> W: Ignoring error from SVN, path probably does not exist: (175002):=
 =20
>>> RA
>>> layer request failed: REPORT of '/svn/!svn/bc/100': Could not read =
=20
>>> chunk
>>> size: Secure connection truncated (https://svn)
>>> W: Do not be alarmed at the above message git-svn is just searching
>>> aggressively for old history.
>>> This may take a while on large repositories
>>> r58084 =3D c01dadf89b552077da132273485e7569d8694518 (trunk)
>>> 	A	...
>>> r58088 =3D 7916f3a02ad6c759985bd9fb886423c373a72125 (trunk)
>>>
>>> $ git svn rebase
>>> Unable to determine upstream SVN information from working tree =20
>>> history
>>
>> Means that your current branch is not based on what git-svn has =20
>> fetched,
>> which is expected when you use "svn init" + "svn fetch" after you
>> already started working.
>>
>> What's the actual relationship between your local history and the
>> history you fetched from svn?
>
> Since I'm trying to export my git repo to svn, the svn repo is =20
> completely empty.

OK, the "r58084" made me think that your code is based on something tha=
t
is already in the SVN repo. But apperently, that's just a shared svn
repo, right?

> I may not have been clear about what I'm trying to do: I have a git =20
> repository, and I'd like to put it (either the head of the master, or=
 =20
> the entire revision history if possible) into svn. From then on, I wo=
uld=20
> like to be able to use 'git svn' commands to manage the two repos.=20
> (Initially I don't expect anyone else to be committing to svn -- it's=
=20
> just an archive and something for others to pull from.)
>
> Here's a complete transcript of how I tried to do this, which seems t=
o =20
> be missing some crucial step:
>
> $ mkdir test2-git-clone
> $ git clone ../test2/   # clone my working repo which is unrelated to=
 =20
> svn at this point
> $ cd test2-git-clone/test2
> $ svn mkdir https://svn/svn/SANDBOX/warren/test2 -m "test2"
> $ svn mkdir https://svn/svn/SANDBOX/warren/test2/trunk -m "test2"
> $ svn mkdir https://svn/svn/SANDBOX/warren/test2/branches -m "test2"
> $ svn mkdir https://svn/svn/SANDBOX/warren/test2/tags -m "test2"
> $ git svn init https://svn/svn/SANDBOX/warren/test2 -T trunk -t tags =
-b=20
> branches
> Initialized empty Git repository in /Users/warren/projects/tmp/test2-=
=20
> git-clone/test2/.git/
> Using higher level of URL: https://svn/svn/SANDBOX/warren/test2 =3D> =
https://svn/svn
> $ git svn dcommit
> Can't call method "full_url" on an undefined value at /opt/local/=20
> libexec/git-core/git-svn line 425.

Can't work yet, your local stuff is not yet connected to the svn commit
(which you didn't even fetch yet). Same for the other dcommit calls you
did.

> $ git merge --no-ff master
> Already up-to-date.

That tries to merge master into itself ;-) The blog entry assumed that
you have a svn-based branch checked out, and applies to quite a
different situation.



This should do and uses a graft to simplify the process a bit:

Initialize git-svn:
git svn init -s --prefix=3Dsvn/ https://svn/svn/SANDBOX/warren/test2

The --prefix gives you remote tracking branches like "svn/trunk" which
is nice because you don't get ambiguous names if you call your local
branch just "trunk" then. And -s is a shortcut for the standard
trunk/tags/branches layout.


=46etch the initial stuff from svn:
git svn fetch

Now look up the hash of your root commit (should show a single commit):
git rev-list --parents master | grep '^.\{40\}$'

Then get the hash of the empty trunk commit:
git rev-parse svn/trunk

Create the graft:
echo <root-commit-hash> <svn-trunk-commit-hash> >> .git/info/grafts

Now, "gitk" should show svn/trunk as the first commit on which your
master branch is based.

Make the graft permanent:
git filter-branch -- ^svn/trunk --all

Drop the graft:
rm .git/info/grafts

gitk should still show svn/trunk in the ancestry of master

Linearize your history on top of trunk:
git svn rebase

And now "git svn dcommit -n" should tell you that it is going to commit
to trunk.


Alternatively, if rebase gives just too many conflicts, you can do:

git svn init -s --prefix=3Dsvn/ https://svn/svn/SANDBOX/warren/test2
git svn fetch
git checkout -b trunk svn/trunk
git merge master
git svn dcommit

That will just create a single huge commit in svn. But the history will
be retained in git. You can then work on the new "trunk" branch or move
your master branch, so it points to the same commit as trunk and then
drop the "trunk" branch or whatever. It just matters that your new work
is based upon the dcommited merge commit, so "svn/trunk" is in your
branch's history.

HTH
Bj=F6rn
