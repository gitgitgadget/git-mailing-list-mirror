From: =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH/RFC] Auto detection in Makefile if msgfmt is not available
Date: Sun, 12 Feb 2012 20:09:09 +0100
Message-ID: <DA8341B0-2A4F-40D8-A5CB-F8159E087C98@web.de>
References: <201202121342.25113.tboegi@web.de> <CACBZZX4W0onNOstQqNethDBv1tZSijt8Q_HDrcuWr+Z8WYV90w@mail.gmail.com> <7vr4y0j79w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 12 20:09:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwenV-0004lt-QE
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 20:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755771Ab2BLTJN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Feb 2012 14:09:13 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:51662 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755761Ab2BLTJM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2012 14:09:12 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate02.web.de (Postfix) with ESMTP id 15F891C119F62
	for <git@vger.kernel.org>; Sun, 12 Feb 2012 20:09:11 +0100 (CET)
Received: from birne.lan ([194.22.188.61]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0Ldmkd-1SO3Gg3mnT-00iB37; Sun, 12 Feb 2012 20:09:10 +0100
In-Reply-To: <7vr4y0j79w.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1084)
X-Provags-ID: V02:K0:iVUQmeSNJOuqoOIwW7sJ24hbGF1CvQZtPC9+xcRHyYb
 Rt00r1hPpKhCtqUqa0tBp+S0Wg7Ov0E1ShI+jxPUhgyeY5nf5R
 F4HrmP0cANPoimLlx4tI0amUHwOMnNz1Y4nZ3r1d5jhlb5uop1
 MtFnMfvlCkBm6GE1x2kHn3xgjQP2lAylQt7+ZxHrTW9/s2obU+
 gjupOysUaBe0ue5YFQC2A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190589>


Am 12.02.2012 um 18:22 schrieb Junio C Hamano:

> =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
>=20
>> 2012/2/12 Torsten B=F6gershausen <tboegi@web.de>:
>>> Added a simple auto-detection and switch to NO_GETTEXT when
>>> msgfmt could not be found on the system
>>=20
>> Oh look, a start at our very own autoconf replacement :)
>=20
> It is a bad idea for the Makefile to silently decide to flip NO_GETTE=
XT
> when the system happens to be missing msgfmt without letting the user=
 know
> what is happening.  Current behaviour to error out will at least give=
 an
> opportunity to stop and think if installing gettext suite on the syst=
em
> makes sense before proceeding.
>=20
> Given that the Makefile only has this to say:
>=20
>    # Define NO_GETTEXT if you don't want Git output to be translated.
>    # A translated Git requires GNU libintl or another gettext impleme=
ntation,
>    # plus libintl-perl at runtime.
>=20
> expecting that "msgfmt: no such command" clicks "Ah, I do not have ge=
ttext
> suite" for anybody who attempts to build (and fail) Git, it however i=
s
> also a bit unfair and unhelpful.
>=20
> Perhaps something like this is necessary and sufficient.
>=20
>    # Define NO_GETTEXT if you don't want Git output to be translated =
or if
>    # you do not have gettext suite (e.g. "msgfmt" and "gettext" comma=
nds).
>    # A translated Git requires GNU libintl or another gettext impleme=
ntation,
>    # plus libintl-perl at runtime.

Thanks all!
a)  the problem was fixed by "sudo apt-get install gettext", which lead=
s to
b) The comment was very helpful  ( As I didn't know which package to in=
stall) and the final question:
c) Should I send a new patch ?
/Torsten
