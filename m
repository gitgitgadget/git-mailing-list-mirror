From: Andreas Ericsson <ae@op5.se>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 14:00:15 +0200
Message-ID: <4534C5CF.3000508@op5.se>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>	<45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com> <vpqejt76vgz.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 14:00:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZncS-0005fu-Kd
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 14:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423142AbWJQMAX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 17 Oct 2006 08:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423202AbWJQMAW
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 08:00:22 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:54144 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1423142AbWJQMAT
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 08:00:19 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 33D726BD11; Tue, 17 Oct 2006 14:00:18 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 0A02C6BCCC; Tue, 17 Oct 2006 14:00:16 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Matthieu Moy <Matthieu.Moy@imag.fr>
In-Reply-To: <vpqejt76vgz.fsf@ecrins.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29061>

Matthieu Moy wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
>>> - you can use a checkout to maintain a local mirror of a read-only
>>>   branch (I do this with http://bazaar-vcs.com/bzr/bzr.dev).
>> In git you can access contents _without_ checkout/working area.
>=20
> Bazaar can do this too. For example,
> "bzr cat http://something -r some-revision" gets the content of a fil=
e
> at a given revision. But that's not what Aaron was refering to.
>=20
> In Bazaar, checkouts can be two things:
>=20
> 1) a working tree without any history information, pointing to some
>    other location for the history itself (a la svn/CVS/...).
>    (this is "light checkout")
>=20
> 2) a bound branch. It's not _very_ different from a normal branch, bu=
t
>    mostly "commit" behaves differently:
>    - it commits both on the local and the remote branch (equivalent t=
o
>      "commit" + "push", but in a transactional way).
>    - it refuses to commit if you're out of date with the branch you'r=
e
>      bound to.
>    (this is "heavy checkout")
>=20

What about

3) getting the repo with all the history while still not having to be=20
online to actually commit to *your* copy of the repo. When you later ge=
t=20
online, you can send all your changes in a big hunk, or let bazaar emai=
l=20
them to the maintainer as patches, or...

> In both cases, this has the side effect that you can't commit if the
> "upstream" branch is read-only. That's not fundamental, but handy.
>=20

It appears we have different ideas of what's handy. Perhaps it's just a=
=20
difference in workflow, or lack of "email-commits-as-patches" tools in=20
bazaar, but the ability to commit to whatever branch I like in my local=
=20
repo and then just send the diffs by email or please-pull requests to=20
upstream authors is what makes git work so well for me. I can ofcourse=20
also pull the changes to another branch, or cherrypick them one by one,=
=20
or...

OTOH, if by "commit" you mean "send your changes back to central=20
server", and bazaar'ish for "register my current set of changes in the=20
local clone of the repo" is called something else, it sounds very=20
similar to what git does.

>=20
> The more fundamental thing I suppose is that it allows people to work
> in a centralized way (checkout/commit/update/...), and Bazaar was
> designed to allow several different workflows, including the
> centralized one.
>=20

Centralized works in git too after a fashion. Most projects have a=20
master repo hidden somewhere that frequently gets pushed out for=20
publishing and which most (all?) contributors sync against from time to=
=20
time, but it's by no means a certainty. What *is* a certainty is that=20
the published branches are exactly identical to the ones in the master=20
repo, and all the downstream authors will get a history where they can=20
easily track master's development.

=46or git, I suppose Junio has the hidden master repo which he publishe=
s=20
at kernel.org. Linus does the same with the Linux repo.

On a side-note, it sounds as though the "bound branch" scenario=20
encourages making a big change as one mega-diff, so long as it=20
implements one feature, whereas the git workflow with topic-branches=20
that eventually gets merged to master allows changes to sort of=20
accumulate up to a feature in the steps one actually has to take to mak=
e=20
the feature work.

Side-note 2: Three really great things that have made work a lot easier=
=20
and more enjoyable since we changed from cvs to git and that aren't=20
mentioned in the comparison table:
* Dependency/history graph display tools =E1 la qgit/gitk
* Bisection tool for finding bug introduction revisions.
* Tools for sending commits as emails.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
