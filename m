From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule : Add --no-separate-git-dir option to add and
 update command.
Date: Wed, 05 Mar 2014 19:13:37 +0100
Message-ID: <53176951.7000201@web.de>
References: <1393858066.7891.20.camel@Naugrim> <5314BFA5.2030807@web.de> <1393878866.7891.22.camel@Naugrim>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Henri GEIST <geist.henri@laposte.net>
X-From: git-owner@vger.kernel.org Wed Mar 05 19:13:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLGKB-0003i0-8L
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 19:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811AbaCESNo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2014 13:13:44 -0500
Received: from mout.web.de ([212.227.17.12]:51757 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754528AbaCESNl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 13:13:41 -0500
Received: from [192.168.178.41] ([84.132.147.244]) by smtp.web.de (mrweb004)
 with ESMTPA (Nemesis) id 0MdI5T-1Wby5p2qV1-00IUVn; Wed, 05 Mar 2014 19:13:38
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <1393878866.7891.22.camel@Naugrim>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:25flPgc+IK63zo0lKC+Mv+fqiKhnHer09nkcORmcZR9VZeD7r0A
 WdSmq1GmvaPIyEypHq4QFOfAygvSUIwKLj93imOcFSuTDaJp7c7+JaxbIxg3T7Af98vtWao
 Fqm00AyuTAK/kgKJFNn1OhSfsCS414wx67KYc2s4KfM0A0apO9Us5DIp8djDiF9tK1uqcID
 vydJZqmOYDB3ij2oXvw9Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243456>

Am 03.03.2014 21:34, schrieb Henri GEIST:
> Le lundi 03 mars 2014 =C3=A0 17:45 +0000, Jens Lehmann a =C3=A9crit :
>> Am 03.03.2014 14:47, schrieb Henri GEIST:
>>> This new option prevent git submodule <add|update> to clone the mis=
sing
>>> submodules with the --separate-git-dir option.
>>> Then the submodule will be regular repository and their gitdir will=
 not
>>> be placed in the superproject gitdir/modules directory.
>>
>> And what is your motivation for this? After all submodules containin=
g
>> a .git directory are second class citizens (because they can never b=
e
>> safely removed by regular git commands).
>>
>=20
> I recognize most people will prefer to have the .git directory separa=
te.
> And I do not intend to make this option the default.
>=20
> My reasons are:
>=20
>   - As it is not clearly stated in the doc that the gitdir is separat=
e.
>     The first time I have copied one module to an USB key I had a big
>     surprise.

Oops! Could you please help us by hinting how the documentation
could be improved here?

>   - This will not change anything for people not using it.

I do not agree, as they'll be seeing a new option and might use
it to "go backward" as Junio explained in his answer.

>   - I use an other patch which I plane to send later which enable mul=
tiple
>     level of superproject to add a gitlink to the same submodule.
>     And in this case the superproject containing the separate gitdir =
will be
>     arbitrary and depend on the processing order of the
>     'git submodule update --recursive' command.

I don't understand that. How is that different from using different
names (and thus different separate gitdirs) for that duplicated
submodule? After all, the .git directory is just moved somewhere
else in the superproject's work tree, and as the name defaults to
the path of the submodule ...

>   - I have written this for myself and have using it since 2012 and s=
end it in
>     the hope it could be useful for someone else even if it is only a=
 few
>     people. But if its not the case no problem I will keep using it f=
or myself.

Thanks.
