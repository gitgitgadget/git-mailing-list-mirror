From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Relative submodule URLs, and forks that haven't forked the
 submodule
Date: Thu, 12 Jun 2014 17:25:56 +0200
Message-ID: <20140612152556.GH4015@paksenarrion.iveqy.com>
References: <E4E16320-06C4-40C5-B561-8DAD720F0946@lltech.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Charles Brossollet <chbrosso@lltech.fr>
X-From: git-owner@vger.kernel.org Thu Jun 12 17:23:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv6qa-0003YB-IS
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 17:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756038AbaFLPXU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jun 2014 11:23:20 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:45871 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbaFLPXT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 11:23:19 -0400
Received: by mail-la0-f47.google.com with SMTP id pn19so790439lab.20
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 08:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JwNqaUngmBqdXKLeUwWadevmSZBwNvQ22vwL5+RMByI=;
        b=dINYFYtdmGYjX2U3DHVIlLS7s4X0NzVF+U75r6NQNhWptBymUKrEYN2ywsK7t06twD
         LfLOBXuZEM8/M8gJbB9zcfS/gicwSpwt8BBqp3Qs2A2Ug99BcickfW99Io1SEoK9q/Xn
         6V+PUAxmtRzNRlAypayUeGwAM3eqXwT888UZKCEeLG7qVGfYgkY8EdrP8OAIc6jt+H1t
         uELjR8tj0/8md7bWEUaKMYvsWecsxBbs9t0qTqiWXp5VCboyRpVnYs8lK8O622oUA6D8
         FxefXWP/i9gHG4Kfc/YnaezyCc6qCJdzq+aS2WJDxIv0wxI9Lu5PVWYvjulAm02s1Etl
         jiPA==
X-Received: by 10.112.129.135 with SMTP id nw7mr690883lbb.89.1402586597796;
        Thu, 12 Jun 2014 08:23:17 -0700 (PDT)
Received: from paksenarrion.paks.iveqy.com (c83-250-234-75.bredband.comhem.se. [83.250.234.75])
        by mx.google.com with ESMTPSA id qx6sm28369281lbb.23.2014.06.12.08.23.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 12 Jun 2014 08:23:17 -0700 (PDT)
Received: from iveqy by paksenarrion.paks.iveqy.com with local (Exim 4.82)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Wv6t2-0004fl-Ab; Thu, 12 Jun 2014 17:25:56 +0200
Content-Disposition: inline
In-Reply-To: <E4E16320-06C4-40C5-B561-8DAD720F0946@lltech.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251410>

So let me see if I understand you correctly.


On Wed, Jun 11, 2014 at 12:15:39PM +0200, Charles Brossollet wrote:
> Hi,
>=20
> I'm banging my head on this problem: I have a central repo cloned by =
SSH, and a fork on the same server. The central remote is origin, and t=
he fork is chbrosso-wip.
>=20
> $ git remote -v | grep origin
> origin  chbrosso@lltech:/git/lightct.git (fetch)
> origin  chbrosso@lltech:/git/lightct.git (push)
>=20
> $ git remote -v | grep chbrosso-wip
> chbrosso-wip    chbrosso@lltech:~/prog/git/lightct.git (fetch)
> chbrosso-wip    chbrosso@lltech:~/prog/git/lightct.git (push)
>=20
> On a local working copy, fetched my fork and checked out a remote bra=
nch out of it. Its remote-tracking branch is on the fork.
>=20
> $ git branch -vv | grep \*
> * actor                         d98ec24 [chbrosso-wip/actor] (commit =
msg)
>=20
> Now, submodules for this repo have relative URLs. And this is where t=
he problem begins, because the submodule isn't forked, but resides only=
 in origin.

=46ork is not a git thing. It's not a git command and it's not supporte=
d
by git. You can of course easily do a "fork" of a git project, but git
will be unaware of it beeing a fork.

What you're saying is that you've one repository:

lightct.git and one other repository which is a submodule to lightct.gi=
t
at motors.git. Then you've made a copy of lightct.git to an other place
for example: /some/other/path/lightct.git and the naturally the
submodule path that's relative will point to /some/other/path/motors.gi=
t
that doesn't exists, since you haven't copied motors.git

>=20
> But this shouldn't cause any problem, right? The docs says that if re=
lative URL are used, they resolve using the origin URL. First issue, it=
's not the case:

Orgin refers to the repository you cloned from. That is if you did
git clone lightct.git my_working_copy

the origin for my_working_copy would be lightct.git. However if you did
git clone /some/other/path/lightct.git my_working_copy

the origin for my_working_copy would be /some/other/path/lightct.git

So to me it seems to be correct.

>=20
> $ cat .gitmodules
> [submodule "motors"]
>         path =3D motors
>         url =3D ../motors.git
>         branch =3D master
> $ git submodule init motors
> Submodule 'motors' (chbrosso@lltech:~/prog/git/motors.git) registered=
 for path 'motors'
>=20
> Here the submodule is registered on my fork, which doesn't exist, and=
 it's wrong with what the documentation says.
>=20
> Fine, I'll edit the .git/config entry to make it point to origin:
>=20
> $ git config submodule.motors.url chbrosso@lltech:/git/motors.git
>=20
> $ git config submodule.motors.url
> chbrosso@lltech:/git/motors.git
>=20
> $ ssh chbrosso@lltech "if  [ -d /git/motors.git ]; then echo 'ok'; fi=
"
> Password:
> ok
>=20
> So the submodule's url is changed, and points to a correct path, let'=
s update so that I can work
>=20
> $ git submodule update motors
> Password:
> fatal: '~/prog/git/motors.git' does not appear to be a git repository
> fatal: Could not read from remote repository.
>=20
> Please make sure you have the correct access rights and the repositor=
y exists.
> Unable to fetch in submodule path 'motors'
>=20
> That's right, it is still the old url, and I can't have my submodule!

Here you change the path to the submodule at
/some/other/path/lightct.git and then it isn't changed in my_working_co=
py. How could it? They don't communicate if you don't tell them to.

> Can someone explain what's going on? And how can I get my submodule i=
n the working copy?

Either created a copy of the submodule just as you did with lightct.git
or use non-relative paths.

--=20
Med v=E4nlig h=E4lsning
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
