From: Charles Brossollet <chbrosso@lltech.fr>
Subject: Re: Relative submodule URLs, and forks that haven't forked the submodule
Date: Thu, 12 Jun 2014 18:05:10 +0200
Message-ID: <DF027A78-FAC4-4120-9259-1A3D84635BDB@lltech.fr>
References: <E4E16320-06C4-40C5-B561-8DAD720F0946@lltech.fr> <20140612152556.GH4015@paksenarrion.iveqy.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 18:05:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv7VD-0004EB-GX
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 18:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756096AbaFLQFR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jun 2014 12:05:17 -0400
Received: from mx0.network-studio.com ([62.93.225.99]:35947 "EHLO
	mx0.network-studio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756094AbaFLQFP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2014 12:05:15 -0400
Received: from zimbra-ne02.network-studio.com (zimbra.network-studio.com [192.168.101.82])
	by mx0.network-studio.com (Postfix) with ESMTP id 3E1DE408552;
	Thu, 12 Jun 2014 18:05:12 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-ne02.network-studio.com (Postfix) with ESMTP id E0013224405;
	Thu, 12 Jun 2014 18:05:08 +0200 (CEST)
Received: from zimbra-ne02.network-studio.com ([127.0.0.1])
	by localhost (zimbra-ne02.network-studio.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id ZZk2ciasmONi; Thu, 12 Jun 2014 18:05:08 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-ne02.network-studio.com (Postfix) with ESMTP id 0A57C2244FE;
	Thu, 12 Jun 2014 18:05:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra-ne02.network-studio.com
Received: from zimbra-ne02.network-studio.com ([127.0.0.1])
	by localhost (zimbra-ne02.network-studio.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OhL0toDd1dts; Thu, 12 Jun 2014 18:05:07 +0200 (CEST)
Received: from cluj.int.lltech.fr (95-141-98-68.as16211.net [95.141.98.68])
	(Authenticated sender: chbrosso@lltech.fr)
	by zimbra-ne02.network-studio.com (Postfix) with ESMTPSA id 9B987224405;
	Thu, 12 Jun 2014 18:05:07 +0200 (CEST)
In-Reply-To: <20140612152556.GH4015@paksenarrion.iveqy.com>
X-Mailer: Apple Mail (2.1878.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251411>

Thanks for taking time to understand, let me make it more clear

Le 12 juin 2014 =E0 17:25, Fredrik Gustafsson <iveqy@iveqy.com> a =E9cr=
it :

> So let me see if I understand you correctly.
>=20
>=20
> On Wed, Jun 11, 2014 at 12:15:39PM +0200, Charles Brossollet wrote:
>> Hi,
>>=20
>> I'm banging my head on this problem: I have a central repo cloned by=
 SSH, and a fork on the same server. The central remote is origin, and =
the fork is chbrosso-wip.
>>=20
>> $ git remote -v | grep origin
>> origin  chbrosso@lltech:/git/lightct.git (fetch)
>> origin  chbrosso@lltech:/git/lightct.git (push)
>>=20
>> $ git remote -v | grep chbrosso-wip
>> chbrosso-wip    chbrosso@lltech:~/prog/git/lightct.git (fetch)
>> chbrosso-wip    chbrosso@lltech:~/prog/git/lightct.git (push)
>>=20
>> On a local working copy, fetched my fork and checked out a remote br=
anch out of it. Its remote-tracking branch is on the fork.
>>=20
>> $ git branch -vv | grep \*
>> * actor                         d98ec24 [chbrosso-wip/actor] (commit=
 msg)
>>=20
>> Now, submodules for this repo have relative URLs. And this is where =
the problem begins, because the submodule isn't forked, but resides onl=
y in origin.
>=20
> Fork is not a git thing. It's not a git command and it's not supporte=
d
> by git. You can of course easily do a "fork" of a git project, but gi=
t
> will be unaware of it beeing a fork.

OK, you get it, what I mean by fork here is an independent copy of a re=
pository, at another remote place.=20

> What you're saying is that you've one repository:
>=20
> lightct.git and one other repository which is a submodule to lightct.=
git
> at motors.git. Then you've made a copy of lightct.git to an other pla=
ce
> for example: /some/other/path/lightct.git and the naturally the
> submodule path that's relative will point to /some/other/path/motors.=
git
> that doesn't exists, since you haven't copied motors.git

That's right. Origin is the repository that were original cloned to the=
 working copy, and I have a copy of it, that is in /some/other/path, wi=
thout motors.git having been copied.

I haven't copied motors.git because I won't modify it, so I still want =
to refer it=85=20

>> But this shouldn't cause any problem, right? The docs says that if r=
elative URL are used, they resolve using the origin URL. First issue, i=
t's not the case:
>=20
> Orgin refers to the repository you cloned from. That is if you did
> git clone lightct.git my_working_copy
>=20
> the origin for my_working_copy would be lightct.git. However if you d=
id
> git clone /some/other/path/lightct.git my_working_copy
>=20
> the origin for my_working_copy would be /some/other/path/lightct.git
>=20
> So to me it seems to be correct.

No, in the working copy, origin's location isn't changed, it is still t=
he repository I originally (!) cloned from. I added the other remote af=
terward, and named it chbrosso-wip, not origin. Then, the working copy =
has two remotes, origin and chbrosso-wip. So if we follow the docs the =
URL for the submodule shouldn't be set to chbrosso-wip's URL, but this =
is what is happening.

>>  <snip>
>> That's right, it is still the old url, and I can't have my submodule=
!
>=20
> Here you change the path to the submodule at
> /some/other/path/lightct.git and then it isn't changed in my_working_=
copy. How could it? They don't communicate if you don't tell them to.

No, you missed my point, let me explain it a more synthesized way:

There are 3 repos main, fork, and sub, having the following URLs:

/central/main
/central/sub
/user/main

sub is a submodule of main, and referred with a relative URL in .gitmod=
ules.

In a working copy, cloned from /central/main, thus referred by git as o=
rigin, and added /user/main as another remote repository. Fetched from =
it.

Initially the submodule isn't cloned in the working copy.

The two problems I'm pointing are:

1. After checkout of a branch that tracks /user/main repo, call git ini=
t submodule motors. Git registers it in .git/config with URL /user/sub,=
 while it should be /central/sub according to documentation because ori=
gin's URL is at /central.

2. For an obscure reason, changing the url in .git/config to /central/s=
ub and call git submodule update still make git want to clone from /use=
r/sub, and fails. There seems to be no way to tell git the right URL fo=
r this submodule, while it should be possible according to the submodul=
e documentation.

>=20
>> Can someone explain what's going on? And how can I get my submodule =
in the working copy?
>=20
> Either created a copy of the submodule just as you did with lightct.g=
it
> or use non-relative paths.
>=20
> --=20
> Med v=E4nlig h=E4lsning
> Fredrik Gustafsson
>=20
> tel: 0733-608274
> e-post: iveqy@iveqy.com
