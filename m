From: Steven Michalske <smichalske@gmail.com>
Subject: Re: RFC: Making submodules "track" branches
Date: Wed, 9 Jun 2010 05:47:04 -0700
Message-ID: <C0EA2469-DA5B-413E-9AB4-F79954DBE3AE@gmail.com>
References: <AANLkTilBQPHgkCLJ7ppNo5TwC9Bdmqo-OMRpaDFwbQPd@mail.gmail.com> <201006082352.38136.johan@herland.net> <4C0F4185.2000207@web.de> <201006091022.18896.johan@herland.net>
Mime-Version: 1.0 (Apple Message framework v1068)
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jun 09 14:47:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMKgd-0003e8-Om
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 14:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757508Ab0FIMrL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 08:47:11 -0400
Received: from mail-pz0-f176.google.com ([209.85.222.176]:33293 "EHLO
	mail-pz0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab0FIMrJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 08:47:09 -0400
Received: by pzk6 with SMTP id 6so2863719pzk.1
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 05:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:in-reply-to
         :mime-version:content-type:message-id:content-transfer-encoding:cc
         :from:subject:date:to:x-mailer;
        bh=8aAwsAxVNsm/FH7gbhElopAQePZXQBzqTgBb3W29SRw=;
        b=gn93qfQgS92sdax1t97o/cL6IpiKGpBY/gdGoGysKP7JkQsyunr7ZM/KfarNR5nPIH
         SO7NEHKIchDo/qIffglOOgJVxjJFuLPOPVklskQsCakuUOZTJDVgsOXWfIWWcXfhpHCI
         9Sactgae4T7DNHd8r+Za/MCWGLyNQfESn12NU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-type:message-id
         :content-transfer-encoding:cc:from:subject:date:to:x-mailer;
        b=coqV/zc6Rg4ZpD8yFY+vllsJTD0rbS4I2ohFlQ0ijsy6HT0XakrLZtx+quyxr7wVWk
         LZ298RYIKUMPEZW7fT6gpZPMI1H3LMVbd16/dW0lVwA4p6iyX+kmlax2pUG8IJr9cDvz
         JfO6hTwzW2ExXR1ovpHQd+AQywZTLf9LVhNnQ=
Received: by 10.115.39.40 with SMTP id r40mr14184586waj.183.1276087627810;
        Wed, 09 Jun 2010 05:47:07 -0700 (PDT)
Received: from [192.168.1.105] (c-98-234-104-87.hsd1.ca.comcast.net [98.234.104.87])
        by mx.google.com with ESMTPS id c22sm63942163wam.6.2010.06.09.05.47.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Jun 2010 05:47:06 -0700 (PDT)
In-Reply-To: <201006091022.18896.johan@herland.net>
X-Mailer: Apple Mail (2.1068)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148765>


On Jun 9, 2010, at 1:22 AM, Johan Herland wrote:

> On Wednesday 09 June 2010, Jens Lehmann wrote:
>> Am 08.06.2010 23:52, schrieb Johan Herland:
>>> The good thing with =C6var's approach is that this is all configura=
ble
>>> per branch (indeed, per commit[1]) by editing your .gitmodules file=
=2E
>>
>> Yep, I think this is the sane way to do that.
>>
>>> Interesting. Will the object parsing machinery handle that without
>>> hiccups? What if an older Git version tries to checkout/update a
>>> submodule with a 0- hash?
>>
>> Maybe =C6var's idea of dropping such a submodule from the tree is =20
>> better.
>
> Agreed. That will of course cause older Git versions to skip the =20
> submodule
> altogether, which is probably the safest failure mode.
>
>>> Me too, but I suspect that if you draw the "one big repo" approach =
=20
>>> to
>>> its logical conclusion, there will be some demand for recursive
>>> commits.
>>
>> You may be right here. But as submodules often have a detached =20
>> HEAD, this
>> might get interesting ;-)
>
> Yes, trying to recursively commit across a submodule with detached =20
> HEAD
> should obviously fail (at least by default). But as long as a local =20
> branch
> is checked out in the submodule (which is not necessarily the same =20
> as having
> the submodule _track_ that branch), a recursive commit should be =20
> relatively
> straightforward.
>
>>> [1]: Say your submodule usually tracks a branch, but you're creatin=
g
>>> some tag in the super-repo, and you want that tag to uniquely =20
>>> identify
>>> the submodule. You achieve this by making sure the tagged commit
>>> removes the relevant "branch =3D whatever" line from .gitmodules, a=
nd
>>> records the appropriate submodule version in the super-repo tree.
>>> Then, you can revert the .gitmodules change on the next commit to
>>> resume tracking the submodule branch.
>>>
>>> Now, whenever you checkout the tag, you will always get the exact =20
>>> same
>>> version of the submodule, although the submodule otherwise tracks =20
>>> some
>>> branch.
>>
>> Won't work anymore when we would use 0{40} or drop it from the tree.
>> AFAICS always-tip and referencing a certain commit don't mix well.
>
> AFAICS, it would still work as long as it exists in the tree for that
> specific commit (but is missing/0{40} in other commits).
>
> We're not mixing "always-tip" and "exact-commit" in the same commit. =
=20
> We use
> "always-tip" in regular commits, and then temporarily switch to =20
> "exact-
> commit" in the commits where a certain submodule version is required.
>
When making a tag, could the notes system be used for marking what =20
commit was exactly on the submodule, perhaps include the closest =20
remote commits as well?


Something like

Submodule Status:
	["foo"]
		branch =3D subtopic:SHA

This assumes that git notes are shared/cloned......


Other thoughts.


Things that should still work with tracking submodules.
	- bisect   - Must be able to identify that a submodule change =20
introduced the bug.
	- archive  - Should it use the version from the commit, or the latest?
	- rebase   - update all of the submodule commits?
	- checkout - tip vs commit
	- reset --hard - Good question... not sure.... probably depend on tip =
=20
vs commit like checkout.
	- More????


I would rather the submodule entree in the tree be always updated to =20
what is in the submodule on the commit, so that the history is always =20
there.  Then actions updating the repository from remotes =20
automatically pull the latest version.  I feel that the submodule if =20
automatically be pulled, merged, etc, than the submodule should get a =20
commit, with the message about this being an automatic update of the =20
submodule.  Checking out is a different story.... checking out a =20
branch tip of the super gets the latest tip from the submodule.  When =20
you commit, the submodule gets it's auto commit, then a second commit =20
for the code changes.  checking out a previous revision should =20
probably put the sub module to the state it was in at that point in =20
time.  Creating a branch and adding new content would update according =
=20
to the rules.  but show the change of the subproject as from the =20
super's at the branch point, not the tip.

This way older gits have a submodule to work with and newer gits will =20
do the right thing.

Example:

s-y-y-z
A-B-C-D
\
  \F-G
s-z-z

=46 is branched when the latest sub module is at z  but shows the chang=
e =20
from s not z because A the parent of F was created with the submodule =20
at s

Situational Example:

I am developing away and as I progress in development I get a =20
regression bug, so I run git bisect from the last stable release with =20
out this bug, and it starts bisecting away.

In the mode where we don't store the state of the project I can't =20
bisect the changes against the subproject, where my bug might have =20
been introduced from.

So that issue should be probably handled in the git bisect code, that =20
is "Make git bisect submodule aware"  in more verbose terms, when =20
bisecting a super project the sub modules should undergo bisection as =20
well.  This is a permutation that will expand rapidly, but some =20
thoughts on how to dig into the bisection issues.
This is another email ;-)


Rebase:
	With the auto commit of submodule scheme, a rebase would change the =20
tracking branches to the latest of the tracked version. and auto merge =
=20
and record the previous submodule revision in the commit message of =20
the submodule auto commit.

Checkout with nonexistant submodule sha:
	This is the case where the submodules ref was not pushed publicly, =20
so, the contents are not available.  You get a nice warning and the =20
tip of the submodules branch gets checked out for that submodule.

Steve
