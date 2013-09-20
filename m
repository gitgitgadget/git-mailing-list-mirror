From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: why doesn't "git bisect visualize" show all commit ids from the
 bisect log
Date: Fri, 20 Sep 2013 20:47:34 +0200
Message-ID: <523C9846.90400@gmx.de>
References: <523C8F0C.6050203@gmx.de> <20130920182232.GA30039@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 20 20:47:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VN5k1-0007t1-LO
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 20:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418Ab3ITSrk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Sep 2013 14:47:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:60877 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753187Ab3ITSrh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 14:47:37 -0400
Received: from [80.171.223.22] ([80.171.223.22]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0MDm4o-1V79qY0ugo-00H6RS for <git@vger.kernel.org>;
 Fri, 20 Sep 2013 20:47:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130919 Thunderbird/17.0.9
In-Reply-To: <20130920182232.GA30039@google.com>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:8q3ugx35X7g709bPrhQNc6CK91Eqh8VEYNQsB4uNYt5WXpfrsuF
 bNj/hD9/0X+f+7+mulk8zMD8RKJ+ifdKEq2exCpTrC+rEDhlVqjPedgTo6eWJ00YCEPQZK7
 nb6Tz241BnQWUE7dZPqbWjGcBY2a57RFj3TGSupq2EjmE4QXiscuzGtuKpEVC6rDCBX5cji
 I0rM2673xcZO5JvoOEFTQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235078>

On 09/20/2013 08:22 PM, Jonathan Nieder wrote:
> Hi Toralf,
>=20
> Toralf F=C3=B6rster wrote:
>=20
>> When run that command immediate after "git bisect start" somebody se=
es
>> the full commit range as defined in "git bisect start".
>>
>> However running that command later after few git bisect steps" someb=
ody
>> is just presented with the remaining commit interval.
>>
>> Is this intended ?
>=20
> "git bisect visualize" is meant as a tool to pin down the culprit
> commit that produced a regression.  Sometimes after a few steps the
> problematic commit is obvious, which can save some test cycles.
>=20
> If you want to see the list of commits tested so far, "git bisect log=
"
> can help.  To see the entire bisection state, even outside the
> regression window, any old "gitk foo..bar" command will do --- the
> bisection state is kept in bisect/* refs that show up in blue.
> Can you say a little more about what you're trying to do?  Is the goa=
l
> to have a nice visualization of what "git bisect log" shows?  (I'm no=
t
> aware of any such tool, and I agree it would be a nice thing.)
>=20
I'm trying to bisect a (bastard of an) issue in fs/dcache.c of the linu=
x
kernel. Till now I do not have a 100% reliable test scenario.

So often I do mark a commit id accidentally wrongly as bad/good.
Therefore git bisect lands into the "wrong" half. As a consequence all
subsequent bisects are senseless. Visualizing all infos from "git bisec=
t
log" would help to see such mistakes.

<few minutes later>

Ick, and now I'm reading your mail again, tried gitk <start>..<end> -
that's what I want, thx.
I wasn't aware that gitk uses the info from BISECT_LOG :-)

Knowing this helps me to interrupt a "git bisect run ...", restarting m=
y
KDE, continuing the bisecting later and still having the full picture o=
f
the overall git bisect process.

Thx again for clarification.

--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
