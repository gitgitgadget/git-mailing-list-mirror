From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: tracking submodules out of main directory.
Date: Thu, 04 Aug 2011 19:45:52 +0200
Message-ID: <4E3ADAD0.1060800@web.de>
References: <4E0A08AE.8090407@web.de>  <1311792580.2413.82.camel@Naugrim.eriador.com>  <1311843465.3734.40.camel@Naugrim.eriador.com> <4E3192D4.5000504@web.de>  <1311932377.3734.182.camel@Naugrim.eriador.com> <4E34122B.5020509@web.de>  <1312062927.3261.334.camel@Naugrim.eriador.com> <4E370107.3050002@web.de>  <1312287584.3261.798.camel@Naugrim.eriador.com> <4E384510.1070803@web.de>  <20110803062536.GB33203@book.hvoigt.net>  <1312374382.3261.913.camel@Naugrim.eriador.com>  <7v8vractdw.fsf@alter.siamese.dyndns.org> <4E399C62.30604@web.de>  <7vaabqb7vf.fsf@alter.siamese.dyndns.org>  <4E39BDFF.3050804@web.de> <1312410562.3261.1030.camel@Naugrim.eriador.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Alexei Sholik <alcosholik@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: henri GEIST <henri.geist@flying-robots.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 19:46:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp1zf-0005Zp-2R
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 19:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182Ab1HDRp7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Aug 2011 13:45:59 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:52557 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755042Ab1HDRp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 13:45:57 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate03.web.de (Postfix) with ESMTP id 23F76197375D6;
	Thu,  4 Aug 2011 19:45:56 +0200 (CEST)
Received: from [79.247.241.191] (helo=[192.168.178.43])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Qp1zY-0006co-00; Thu, 04 Aug 2011 19:45:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <1312410562.3261.1030.camel@Naugrim.eriador.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/JglUVOr5i3jD3xd4u+8mz82EbFHxvghNVyJt8
	2wn1ELE4vwf5iOXqOaYfl0l2qmS4ce1Z+nxPO7js5HbI4o4YCZ
	o9UD5xvKQ/w7cGTOH0Xw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178757>

Am 04.08.2011 00:29, schrieb henri GEIST:
> Le mercredi 03 ao=C3=BBt 2011 =C3=A0 23:30 +0200, Jens Lehmann a =C3=A9=
crit :
>> Am 03.08.2011 21:41, schrieb Junio C Hamano:
>>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> But when you fetch a new version of Gimp into your submodule, it wou=
ld be
>> really nice if the superproject could be notified that the Gimp deve=
lopers
>> updated to 1.2.4 of Glib and inform you that an update of Glib might=
 be
>> appropriate. That could avoid having you to dig through compiler err=
ors to
>> find out that the new foobar() function from Glib 1.2.4 is needed (a=
nd if
>> you need to pull in a bugfix in Glib, you might notice that *a lot* =
later
>> when you forget to do that).
>>
>=20
> Exact, I am really happy to read this.
> And better do not bother to have the suproject.

I don't get this, you can't get rid of the superproject.

> cd to gimp directory, type git status it can tell you every thing and
> when your satisfied you just have to type make.
> At this point the superproject have not any use.=20

"git status" inside the submodule won't tell you anything about the
dependencies, but a "git status" in the superproject should. The submod=
ule
shouldn't know where exactly the submodules it depends on lives, that i=
s
the decision of the superproject, not the submodule.

>>>> In addition to that, it can (but mustn't) specify any of the follo=
wing:
>>>
>>> I am guessing you meant "does not have to", instead of mustn't, her=
e...
>>
>> Sure, thanks for deciphering that.
>>
>>>> a) Of this submodule "foo" I need at least that version because I =
won't
>>>>    compile/work with older versions of that. (this can be tightene=
d to
>>>>    "exactly that version" to give henri the behavior he wants, but=
 that
>>>>    should be policy, not mandatory)
>>>
>>> The "loose collection of projects" approach like that has its uses,=
 and it
>>> is called "repo". Why re-invent it? The behaviour Henri wants to sp=
ecify
>>> the exact version is how git submodules work already, so I do not s=
ee
>>> there is anything to be done here.
>>
>> Let me make this clear: this is not about changing how submodules ar=
e
>> committed in a superproject. It is not about having a loose collecti=
on of
>> projects, they stay tied together in a defined state by the superpro=
ject.
>>
>=20
> Yes but for me, from when I started this this topic, it was all about
> having a loose collection of project with dependency references betwe=
en
> them. And get rid of the superproject.
> It is my first and only goal.

But I fail to see how that would improve anything.

>> Henri wanted it a bit upside down: any submodule could request a cer=
tain
>> version of another submodule somewhere else in the repo. And he want=
ed to
>> use gitlinks from one submodule to another for that, which I - hopef=
ully -
>> convinced him was no good idea.
>>
>=20
> You just convince me that submodules are more than I need and to make=
 a
> lighter independent version of submodules which will never been follo=
wed
> by git commands.

Submodules are what you need, but it's no use to implement dependencies=
 by
using gitlinks that point outside of their repositories.

>>>> b) And if you don't know where to get it, use this url
>>>
>>> Again that is the job of .gitmodules in the superproject.
>>
>> Yes. But this idea is about how the url could get into the .gitmodul=
es of
>> the superproject in the first place. That can make it easier for the
>> superproject's developer to import a submodule into his repo and muc=
h more
>> important: it makes it possible to pull in submodule dependencies
>> automatically e.g. when running "git submodule add --resolve-depende=
ncies
>> Gimp".
>=20
> Only if you have a superproject.
> If not do the same thing from the gimp repository, now it contain all
> necessary infos to do the job.

No, it doesn't. Apart from the Gimp project telling you what version it
wants, you need to have a place to record the version that the user rea=
lly
used. And that won't work without a superproject.

>>>> That is all stuff the submodule knows better than the superproject=
=2E
>>>
>>> Not necessarily. The version A0 of submodule A may depend on submod=
ule B
>>> and may also know it must have at least version B0 of that submodul=
e, but
>>> the superproject would know other constraints, e.g. the superprojec=
t
>>> itself also calls into submodule B and wants a newer version B1 of =
it.
>>
>> Right. That's what I tried to explain to Henri, the superproject tie=
s it all
>> together. But I also like his idea to add a way to communicate infor=
mation
>> from the submodule to the superproject, and give the superproject a =
choice
>> if it wants to use it.
>>
>=20
> yes but the superproject contain no code in your design.
> Then it will never need anything by itself.
> It is only a container which you will inform with data already known =
by
> the submodules I do not see any value to it.

But being the container that ties it all together is more than enough v=
alue.
