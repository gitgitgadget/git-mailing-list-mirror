From: henri GEIST <henri.geist@flying-robots.com>
Subject: Re: tracking submodules out of main directory.
Date: Wed, 03 Aug 2011 23:49:35 +0200
Message-ID: <1312408175.3261.998.camel@Naugrim.eriador.com>
References: <4E0A08AE.8090407@web.de>
	 <1311792580.2413.82.camel@Naugrim.eriador.com>
	 <1311843465.3734.40.camel@Naugrim.eriador.com> <4E3192D4.5000504@web.de>
	 <1311932377.3734.182.camel@Naugrim.eriador.com> <4E34122B.5020509@web.de>
	 <1312062927.3261.334.camel@Naugrim.eriador.com> <4E370107.3050002@web.de>
	 <1312287584.3261.798.camel@Naugrim.eriador.com> <4E384510.1070803@web.de>
	 <20110803062536.GB33203@book.hvoigt.net>
	 <1312374382.3261.913.camel@Naugrim.eriador.com>
	 <7v8vractdw.fsf@alter.siamese.dyndns.org>  <4E399C62.30604@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Alexei Sholik <alcosholik@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Aug 03 23:46:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QojGr-0001sV-6v
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 23:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282Ab1HCVq3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 17:46:29 -0400
Received: from mail11.surf-town.net ([212.97.132.51]:58982 "EHLO
	mailgw19.surf-town.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752952Ab1HCVq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 17:46:27 -0400
Received: by mailgw19.surf-town.net (Postfix, from userid 65534)
	id 8DEA511185F; Wed,  3 Aug 2011 23:46:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailgw19.surf-town.net (Postfix) with ESMTP id 53AE81117CB;
	Wed,  3 Aug 2011 23:46:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mailgw19.surf-town.net
X-Spam-Flag: NO
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-999 required=7
	tests=[ALL_TRUSTED=-1.44] autolearn=disabled
Received: from mailgw19.surf-town.net ([127.0.0.1])
	by localhost (mailgw19.surf-town.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2kBTZw3jjHWZ; Wed,  3 Aug 2011 23:46:20 +0200 (CEST)
Received: from [192.168.0.6] (se167-1-82-242-149-125.fbx.proxad.net [82.242.149.125])
	by mailgw19.surf-town.net (Postfix) with ESMTPSA id 4989F111846;
	Wed,  3 Aug 2011 23:46:15 +0200 (CEST)
In-Reply-To: <4E399C62.30604@web.de>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178628>

Le mercredi 03 ao=C3=BBt 2011 =C3=A0 21:07 +0200, Jens Lehmann a =C3=A9=
crit :
> Am 03.08.2011 19:11, schrieb Junio C Hamano:
> > henri GEIST <henri.geist@flying-robots.com> writes:
> >=20
> >> I plan to use a config file containing lines like
> >>
> >> "path_to_poited_repo   SHA1_of_intended_commit   URL_of_origin"
> >>
> >> the URL part will not be required.
> >>
> >> this file will be a list of pointer to other project.
> >=20
> > I wasn't paying attention to this thread, but I have to ask "why" h=
ere.
> >=20
> > The first two are what gitlink was designed to do in the superproje=
ct that
> > ties multiple submodules together, and the last one is also supplie=
d by
> > the .gitmodules in that superproject. This seems to be adding the s=
ame
> > information in a redundant way by saying "this version A0 of submod=
ule A
> > wants version B0 of submodule B and version C0 of submodule C" when=
 the
> > supermodule can say "the consistent view I record is to have versio=
n A0,
> > B0 and C0 of submodules A, B and C, respectively".
>=20
> During the discussion this evolved from a simple "I need that submodu=
le
> with exactly this version" to something I believe is more generic and
> very useful for others. As I see it now a submodule should be able to=
 say:
>=20
> 1) To use me, you need another submodule "foo"
>=20
>    This is very helpful when you want to add the Gimp submodule and i=
t
>    can tell you you'll need the libpng submodule too in your superpro=
ject
>    (but I'd vote to use the submodule name here, not the path as that
>    should be the superproject's decision).
>=20
> In addition to that, it can (but mustn't) specify any of the followin=
g:
>=20
> a) Of this submodule "foo" I need at least that version because I won=
't
>    compile/work with older versions of that. (this can be tightened t=
o
>    "exactly that version" to give henri the behavior he wants, but th=
at
>    should be policy, not mandatory)
>=20

Of corse and git will not enforce this policy.
Git status will only say the version is unrelated, match or is higher.
And it is left to the human reading the status to decide if it is OK
with his policy.

>    Gimp could say it needs at least libpng 012345 because in that ver=
sion
>    the function foobar() was added it now depends on. Normally this w=
on't
>    be updated very often, but if people like henri use that to say "I=
'll
>    only promise to work well with that exact version, as that went th=
rough
>    extensive QA" they might change that on virtually every commit.
>=20

In fact I do so very rarely I do not update my project to track the las=
t
version of the library until the project need it. If the library get ne=
w
features and improvement that I do not need I keep the old version.
I will not rewrite the tones of certification papers to certify the use
of the new library version without needs. It will destroy all the
forests.

> b) And if you don't know where to get it, use this url
>=20
>    That can give the superproject a hint where it can clone that
>    repository from. That could be helpful for distributions to sort o=
ut
>    the dependencies of the packages they pull in.
>=20
> That is all stuff the submodule knows better than the superproject. A=
nd
> that information can be used to *inform* the user about the submodule=
's
> needs, maybe using "git status --submodule-dependencies" will print:
>=20
> # submodule "Gimp" requests a libpng 567890 or newer
> # submodule "foo" has missing dependency "bar"

> But the user can choose to ignore that (because he knows he has the p=
ng
> support disabled and he doesn't need the fancy help files from bar).
>=20
> And maybe "git submodule add" learns an option to automatically add a=
ll
> the other submodules the new one depends on too (for that we would ne=
ed
> the url).
>=20

Provided that you use a superproject. But my goal is to eliminate it.

> But the superproject is still the place to say: I know these versions=
 of
> all submodules work together, so I commit their gitlinks here. But th=
is
> scheme enables submodules to give hints to help the superproject's us=
er.
>=20

or they can do it by them selves has now they have all the needed infos=
=2E

> > I also suspect that allowing each submodule to know and demand spec=
ific
> > versions of other submodules will lead to inconsistencies. Which ve=
rsion
> > of submodule C would you demand to have when submodule A wants vers=
ion C0
> > and submodule B wants version C1 of it?
>=20
> Right, in the discussion so far it seemed like henri seems to be the =
only
> user who is wanting an exact match, and he says he needs to see these
> inconsistencies.

I suspect I am just the only one you now about.
Because that is just what actual submodules does, and nobody complain.

If you
  - cd into one of your submodules
  - make a commit
  - go back into the main repository
  - make git status
It will tell you :
"modified:   the_submodule_name/ (new commits)"

Note it actually will say "new commits" even if it is older or totally
unrelated. It just signal a mismatch.
Then what I need on this point is just what it actually do.

> But I think he can modify the "version xxx or newer" to
> his needs without imposing these inconsistencies on users (like me) w=
ho
> don't want to see them.
>=20

Of corse git status has never imposed anything.

But I will enabling it to make the distinction between unmatched and
newer version.

	Henri
