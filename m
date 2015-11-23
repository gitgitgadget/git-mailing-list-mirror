From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3] ls-files: Add eol diagnostics
Date: Mon, 23 Nov 2015 18:05:18 +0100
Message-ID: <5653474E.6050909@web.de>
References: <56501EFA.7050105@web.de> <56517AD5.6040909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Sebastian Schuberth <sschuberth@gmail.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 23 18:05:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0uYQ-0007x3-65
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 18:05:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbbKWRFY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2015 12:05:24 -0500
Received: from mout.web.de ([212.227.15.4]:51974 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750914AbbKWRFX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2015 12:05:23 -0500
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MYq7X-1ZmrmV21Ux-00Vd0W; Mon, 23 Nov 2015 18:05:20
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
In-Reply-To: <56517AD5.6040909@gmail.com>
X-Provags-ID: V03:K0:JspzZMdb0NdKZ9Rqttemr0bMSTNYFvnoBQmFrGW0SO+l7j7e35N
 7jQcMDyMFoeGegnWIr93PdSsddPOIZiB+m07VItryei1J0U7kf5QCo+igfCrp0qWi6btg9n
 4cEj225M0SPk1Ktgbe0To5BSXJ+AfEfcYrNqZ76WzrmfwHYVlQNNX5GsvY6w5CpRGtLTFcb
 OZ2q7HtwkqaGGidK1iBlA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QTD8BaO0A6Y=:/6hvRFtCWRodkBdGF8YHTj
 EuG03yd3Gx5UPVd6MnK39gvBAOA/GiMRav+J0W9rBaS6GefYykyKFE+VUnI+Npk6kvwbwGIrK
 M7evmLXeE9A3Tv+rlgL3LrRcEDwkvDANstrpZzdVuAbLy8ixrsoOFuIphNXiZDUJ/P1Fuxee0
 9TOG3dks6WrikCQ3ddE7rTn4O0LDCStcX17NYnWNYcfKd5BF/nWRsG1KhPKERAKAE6Ac15vR8
 RH0tEypAQ5LtcR+YStqagtSkHzGUvgiPHRw3iMrK3Gd0ZpdKclHiQzWA+9AObfhPLotPyOsVq
 IEpMu2lHE4AhPmk61SIJk4kdf9eiGrYDi79NhXlTOBKNxI4YK50nHgHZdbfMg/87AnnPbZvRw
 Z2buKqPxEIscItnfdMef8bFJZcJUbJ8IlQyLzd2qZ9yJ9+tZcsVIIDfi29SFb26DYivkjIL0R
 lQy/5TjLleLKmiALxRKFAQNqcn6f6idlJ1XCDCczHT2TQOxCqlNq1+bVhY4Ad8FZvkeOPDc3u
 wAyqcuxI/JaQrhZb6pF+ypAUc2zpIYFE5S3pgGz+thnsun82PLiJlBUepCsytq6RYIGlhNVs3
 +gFP/eZDpU/uQVEEuQ1A71mkQpAZGNtd+ZybdalYmwa33qyA5GdNzJUJbxk/bC5XtpOBmjilH
 XNOiwKd5jYGXuy15DJxyiATLg6CrDeYjfvowB1Xhf3tmJzEFhlG5WZqHBY07nYzh3StaDTuwh
 +o6XFwhr5zq5JwRy0xYW6dOxktA8Eaf2eQd6EP1GocTk6GXcONeFgkpiAARBj5DJQpyOC4B/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281586>

On 22.11.15 09:20, Sebastian Schuberth wrote:
> On 21.11.2015 08:36, Torsten B=C3=B6gershausen wrote:
>=20
>> git ls-files --eol gives an output like this:
>>
>> i/text-no-eol   w/text-no-eol   attr/text=3Dauto t/t5100/empty
>=20
> I'm sorry if this has been discussed before, but hav you considered t=
o use a header line and omit the prefixed from the columns instead? Lik=
e
>=20
> index         working tree     attributes    file
>=20
> binary        binary           -text         t/test-binary-2.png
> text-lf       text-lf          eol=3Dlf        t/t5100/rfc2047-info-0=
007
> text-lf       text-crlf        eol=3Dcrlf      doit.bat
> text-crlf-lf  text-crlf-lf                   locale/XX.po
>=20
> I believe this would be both easier to read for humans, and easier to=
 parse for scripts that e.g. want to compare line endings in the index =
and working tree.
>=20
The problem I see is to make sure that there is always a separator, eve=
n when a field empty:

rm zlib.c; git ls-file --eol #will include a line like this:
i/text-lf       w/              attr/          zlib.c

or, as another example:
git ls-files -o --eol
i/              w/binary        attr/          zlib.o


And if there is no separator, it is harder to make it machine-parsable,
if we e.g. extend the attributes to support "*text=3Dautocrlf", or "*.t=
ext=3Dautoinput"
(But that is another story)

If we replace "/[-a-z]" with "\t", the line has always a separator,
but needs a somewhat wider screen:
        text-lf         text-lf                   zlib.c




>> +		echo huh $1
[] good catch, thanks
