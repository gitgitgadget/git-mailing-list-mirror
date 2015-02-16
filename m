From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: odb_mkstemp's 0444 permission broke write/delete access on AFP
Date: Mon, 16 Feb 2015 20:08:15 +0100
Message-ID: <vpqiof14qu8.fsf@anie.imag.fr>
References: <A403BFCC-D66F-49BD-B54C-BB86B467F1A1@gmail.com>
	<vpqtwyl90mx.fsf@anie.imag.fr>
	<340435D1-2FEB-4A4A-BBD2-E301096C72D8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Fairuzan Roslan <fairuzan.roslan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 20:08:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNR1x-0002En-1E
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 20:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677AbbBPTIZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Feb 2015 14:08:25 -0500
Received: from mx1.imag.fr ([129.88.30.5]:57734 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753598AbbBPTIY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 14:08:24 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t1GJ8D7s023909
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 16 Feb 2015 20:08:13 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t1GJ8FGO010518;
	Mon, 16 Feb 2015 20:08:15 +0100
In-Reply-To: <340435D1-2FEB-4A4A-BBD2-E301096C72D8@gmail.com> (Fairuzan
	Roslan's message of "Tue, 17 Feb 2015 02:41:24 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 16 Feb 2015 20:08:13 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t1GJ8D7s023909
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1424718497.03949@TD9PDnwtkpOLqsERHc9gsw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263914>

[ Please, don't top post on this list ]

=46airuzan Roslan <fairuzan.roslan@gmail.com> writes:

> I don=E2=80=99t see the issue for the owner of his/her own file to ha=
ve write
> access.

Object and pack files are not meant to be modified. Hence, they are
read-only so that an (accidental) attempt to modify them fails.

> Setting tmp idx & pack files to read-only even for the file owner is
> not a safety feature.

Yes it is. If you do not think so, then please give some arguments.

> You should at least give the user the option to set the permission in
> the config file and not hardcoded the permission in the binary.

This is the kind of thing I meant by "investigate alternate solutions".
I have no AFP share to test, so it would help if you answered the
question I asked in my previous message:

>> On Feb 17, 2015, at 2:23 AM, Matthieu Moy <Matthieu.Moy@grenoble-inp=
=2Efr> wrote:
>>=20
>> Fairuzan Roslan <fairuzan.roslan@gmail.com> writes:
>>=20
>>> Hi,
>>>=20
>>> Somehow the =E2=80=9Cint mode =3D 0444;=E2=80=9D in odb_mkstemp (en=
vironment.c) are
>>> causing a lot of issues (unable to unlink/write/rename) to those
>>> people who use AFP shares.
>>=20
>> Is it a problem when using Git (like "git gc" failing to remove old
>> packs), or when trying to remove files outside Git?

(BTW, why did you try to write/rename pack files?)

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
