From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3] ls-files: Add eol diagnostics
Date: Tue, 24 Nov 2015 16:45:02 +0000
Message-ID: <5654940E.90207@ramsayjones.plus.com>
References: <56501EFA.7050105@web.de> <56517AD5.6040909@gmail.com>
 <5653474E.6050909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 24 17:45:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Giu-0006MR-16
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 17:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbbKXQpl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Nov 2015 11:45:41 -0500
Received: from avasout08.plus.net ([212.159.14.20]:39898 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754557AbbKXQpk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 11:45:40 -0500
Received: from [10.0.2.15] ([146.200.5.254])
	by avasout08 with smtp
	id lUl41r0015UqX4q01Ul5cc; Tue, 24 Nov 2015 16:45:05 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bI7rW6KZ c=1 sm=1 tr=0
 a=GKs3PHufgjMgxBavMeQJCg==:117 a=GKs3PHufgjMgxBavMeQJCg==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=nZXP3VKXzWHpeWzJ3GUA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <5653474E.6050909@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281620>



On 23/11/15 17:05, Torsten B=C3=B6gershausen wrote:
> On 22.11.15 09:20, Sebastian Schuberth wrote:
>> On 21.11.2015 08:36, Torsten B=C3=B6gershausen wrote:
>>
>>> git ls-files --eol gives an output like this:
>>>
>>> i/text-no-eol   w/text-no-eol   attr/text=3Dauto t/t5100/empty
>>
>> I'm sorry if this has been discussed before, but hav you considered =
to use a header line and omit the prefixed from the columns instead? Li=
ke
>>
>> index         working tree     attributes    file
>>
>> binary        binary           -text         t/test-binary-2.png
>> text-lf       text-lf          eol=3Dlf        t/t5100/rfc2047-info-=
0007
>> text-lf       text-crlf        eol=3Dcrlf      doit.bat
>> text-crlf-lf  text-crlf-lf                   locale/XX.po
>>
>> I believe this would be both easier to read for humans, and easier t=
o parse for scripts that e.g. want to compare line endings in the index=
 and working tree.
>>
> The problem I see is to make sure that there is always a separator, e=
ven when a field empty:
>=20
> rm zlib.c; git ls-file --eol #will include a line like this:
> i/text-lf       w/              attr/          zlib.c
>=20
> or, as another example:
> git ls-files -o --eol
> i/              w/binary        attr/          zlib.o
>=20

[I have been trying *not* to respond to this thread, since
the following comment is classic bikeshedding on the naming
of things and I am, in general, hopeless at naming things ... :-D ]

<bikeshedding>
I don't think you need to include 'text' in the name of the
line ending descriptors - if its not binary then its some
form of text. So, maybe something like:

    binary
    none
    lf
    crlf
    mixed

</bikeshedding>

HTH

ATB,
Ramsay Jones
