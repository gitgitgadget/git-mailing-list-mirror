From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [RFC] i18n.pathencoding
Date: Sat, 08 Sep 2012 12:09:14 +0200
Message-ID: <504B194A.6050009@web.de>
References: <201209010811.33994.tboegi@web.de> <5043E4B4.9050801@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 12:10:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAHzu-0004hV-1m
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 12:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473Ab2IHKKQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Sep 2012 06:10:16 -0400
Received: from mout.web.de ([212.227.17.11]:60443 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753444Ab2IHKJR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2012 06:09:17 -0400
Received: from birne.lan ([195.67.191.22]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0LfiuU-1Tu5KK2iba-00pGf3; Sat, 08 Sep 2012 12:09:15 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:15.0) Gecko/20120824 Thunderbird/15.0
In-Reply-To: <5043E4B4.9050801@dewire.com>
X-Provags-ID: V02:K0:YFP78lrK3r/uR2fBLtszM6YhOTX/Y3sDP5hXzGmAx8J
 0weoxStZBQuZtl8Ma/z5H1irDLNoSIHDSnXYMvXDVEqfdyWuh3
 LQAgFiyVR66xIP8Y8hYS5qV5j9GoSB9t6K6C09+al4gSBHQWUP
 PmccJUBgQYW2oF44quYFBTx8szy/NmIO/vNix+J/O2OHiqH3jB
 IAoMOMZzHPK/Jpk0R9DSA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205009>

On 03.09.12 00:59, Robin Rosenberg wrote:
> Torsten B=C3=B6gershausen skrev 2012-09-01 08.11:> Allow path names t=
o be encoded in UTF-8 in the repository
>> and checkout out as e.g. ISO-8859-1 in the working tree.
>=20
> Ack for attempting this.
>=20
> Did it myself if 2007, but times weren't ripe then, I guess.
>=20
>> +i18n.pathEncoding::
>> +    This option is only used by some implementations of git.
>> +    When "git init" sets core.supportspathencoding to true,
>> +    i18n.pathEncoding can be set to re-encode path names when
>> +    a working tree is checked out.
>> +    Path names may be e.g. encoded in ISO-8859-1 and are stored as
>> +    UTF-8 encoded in the repository.
>> +    When not set, the encoding of path names is the same in working=
 tree
>> +    and the repository.
>=20
> "If set, then core.precomposeunicode is ignored on Mac OS X."

Thanks for comments,=20
I will integrate them (but don't expect that too soon ;-).

Before that I want to find & fix the performance issues, and the
t1450 breakage asks for my attention again.

However, the combination of i18n.pathEncoding and core.precomposeunicod=
e under Mac OS X=20
needs to be clarified.
Mac OS X only allows unicode (an "=C3=84" encoded in ISO-8859-1 gives a=
 single byte),
and the HFS+ filesystem will list it as %C4.

So the i18.pathencoding does not make sence under Mac OS X, and should =
be ignored.
It is not ignored today, since the characters use in t3911 are choosen =
to be both valid UTF-8
and ISO-8859-1 code points/characters, so that the feature can be teste=
d on Mac OS X.





 =20
