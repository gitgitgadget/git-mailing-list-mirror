From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2 0/4] remote-helpers: trivial test fixes
Date: Sat, 06 Apr 2013 20:41:26 +0200
Message-ID: <51606C56.7060108@web.de>
References: <1365089779-9726-1-git-send-email-felipe.contreras@gmail.com> <51605546.3080503@web.de> <CAMP44s0Lbg-_JKPR6WF6Qhkz7cgweHejA-T_V3mCO73a4iXpNA@mail.gmail.com> <51605F32.7080303@web.de> <CAMP44s0tAmXxGLnKJ=+xvbMUJW_bqiK75-hKo9M3jh8J=YX-4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>,
	Antoine Pelisse <apelisse@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 21:03:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOY3g-00069g-Pt
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 20:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765841Ab3DFSlo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Apr 2013 14:41:44 -0400
Received: from mout.web.de ([212.227.15.4]:51513 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759737Ab3DFSln (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 14:41:43 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MIvJx-1UR11q0mYD-002Jp3; Sat, 06 Apr 2013 20:41:27
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <CAMP44s0tAmXxGLnKJ=+xvbMUJW_bqiK75-hKo9M3jh8J=YX-4g@mail.gmail.com>
X-Provags-ID: V02:K0:3bTuY5beRDDxSXG4M1cSLa/WXl9cP8B6g9NgsdcB8z9
 zsCbFJvZeoE9utlsiCVd2RNxbXllH13evjuuaFXz5kS6f5I+cE
 NsuykY2aLRysJxrKSHWB0LMFHumU8FLsz5Dpq2/z7dNd7F9OcY
 B1tOu7Z4ZkpAhe+5/OTudfsgUUYPlEPGryNshE2SXVmlcwY5pf
 fVRMwChy71OHr+oppqKEQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220269>

On 06.04.13 19:58, Felipe Contreras wrote:
> On Sat, Apr 6, 2013 at 11:45 AM, Torsten B=C3=B6gershausen <tboegi@we=
b.de> wrote:
>> On 06.04.13 19:29, Felipe Contreras wrote:
>>> On Sat, Apr 6, 2013 at 11:03 AM, Torsten B=C3=B6gershausen <tboegi@=
web.de> wrote:
>=20
>>>> --- a/contrib/remote-helpers/test-hg.sh
>>>> +++ b/contrib/remote-helpers/test-hg.sh
>>>> @@ -115,7 +115,7 @@ test_expect_success 'update bookmark' '
>>>>    git push
>>>>    ) &&
>>>>
>>>> -  hg -R hgrepo bookmarks | grep "devel\s\+3:"
>>>> +  hg -R hgrepo bookmarks | egrep "devel[[:space:]]+3:"
>>>>  '
>>>
>>> I would rather use [ \t] instead.
>> That doesn't work on e.g. Mac OS.
>> [:space:] is actually portable
>=20
> Why wouldn't it work? This is from their manpage:
>=20
> A bracket expression is a list of characters enclosed by [ and ].  It
> matches any single character in
> that list; if the first character of the list is the caret ^ then it
> matches any character not in the
> list.  For example, the regular expression [0123456789] matches any
> single digit.
>=20

It's not about the "bracket list".
It's about using \t as an abreviation for TAB.
The "backslash n" as an replacement for TAB is quite often understood b=
y many programs.
It is not demanded to be understood by all grep implementations, please=
 see below.
Instead of using \t you can use a literal TAB.
Contact your local editor how to put that inte source code ;-)

=20
http://pubs.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap09.html=
#tag_09_03

9.3.2 BRE Ordinary Characters

An ordinary character is a BRE that matches itself: any character in th=
e supported character set, except for the BRE special characters listed=
 in BRE Special Characters.

The interpretation of an ordinary character preceded by a backslash ( '=
\' ) is undefined, except for:

    The characters ')', '(', '{', and '}'

    The digits 1 to 9 inclusive (see BREs Matching Multiple Characters)

    A character inside a bracket expression
