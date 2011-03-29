From: Victor Engmark <victor.engmark@terreactive.ch>
Subject: Re: [PATCH] Remove "bashism" from contrib/thunderbird-patch-inline/appp.sh
Date: Tue, 29 Mar 2011 16:03:26 +0200
Organization: terreActive AG
Message-ID: <4D91E6AE.9040208@terreactive.ch>
References: <AANLkTin-USDnTxeKT_KOZW5kgC0vFXYbMNP9ct6fzbUC@mail.gmail.com> <4D9103D3.5010403@zoho.com> <8721039.4955.1301382568626.JavaMail.trustmail@mail1.terreactive.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4FuZ2VsIEdvbnrDoWxleg==?= <ingenit@zoho.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 16:03:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4ZWL-0005a3-2g
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 16:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513Ab1C2ODi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 10:03:38 -0400
Received: from gate.terreactive.ch ([212.90.202.121]:50297 "EHLO
	mail.terreactive.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494Ab1C2ODi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 10:03:38 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
In-Reply-To: <8721039.4955.1301382568626.JavaMail.trustmail@mail1.terreactive.ch>
X-terreActive-From: victor.engmark@terreactive.ch
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170270>

On 03/29/2011 09:09 AM, Junio C Hamano wrote:
> =C3=81ngel Gonz=C3=A1lez <ingenit@zoho.com> writes:

>>>  if [ "$?" !=3D "0" ] ; then
>=20
> While I personally do not like this style (I am old fashioned) and wo=
uld
> probably write:
>=20
> 	if test $? !=3D 0
>         then
>         	...

Nitpicking I suppose, but since `$?` is always an integer we should use
`-ne` (positive/negative integers) instead of `!=3D` (string comparison=
).

> or make it even more readable by writing it together with the previou=
s
> statement, i.e.
>=20
> 	PATCH=3D$(zenity --file-selection) ||
>         ...
>=20
> myself, it is definitely not bash-ism to use [] for conditionals.  So=
me
> people seem to find it more readable than traditional "test" (not me)=
=2E

Alternatively:

if ! PATCH=3D$(zenity --file-selection)
then
=2E..

Yep, that works in dash - Both variable assignment and exit code checki=
ng.

--=20
Victor Engmark
