From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: odb_mkstemp's 0444 permission broke write/delete access on AFP
Date: Wed, 18 Feb 2015 09:15:21 +0100
Message-ID: <vpq61azab52.fsf@anie.imag.fr>
References: <A403BFCC-D66F-49BD-B54C-BB86B467F1A1@gmail.com>
	<vpqtwyl90mx.fsf@anie.imag.fr>
	<340435D1-2FEB-4A4A-BBD2-E301096C72D8@gmail.com>
	<vpqiof14qu8.fsf@anie.imag.fr>
	<13683B35-70A8-4D9E-80E1-440E4E0DC7F0@gmail.com>
	<vpqr3tozzs5.fsf@anie.imag.fr>
	<CA0F915F-74B1-4292-AFB8-D1A4C76C0137@gmail.com>
	<54E3804D.6020301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fairuzan Roslan <fairuzan.roslan@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Feb 18 09:15:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNznC-00026r-Ph
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 09:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbbBRIPa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Feb 2015 03:15:30 -0500
Received: from mx1.imag.fr ([129.88.30.5]:48693 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541AbbBRIP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 03:15:29 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t1I8FK1P007616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Feb 2015 09:15:21 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t1I8FLL6012692;
	Wed, 18 Feb 2015 09:15:21 +0100
In-Reply-To: <54E3804D.6020301@web.de> ("Torsten \=\?iso-8859-1\?Q\?B\=F6gersha\?\=
 \=\?iso-8859-1\?Q\?usen\=22's\?\= message of
	"Tue, 17 Feb 2015 18:54:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 18 Feb 2015 09:15:21 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t1I8FK1P007616
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1424852121.43329@CkxXMjQt/Z//+YiP9Znaww
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264006>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 17/02/15 17:58, Fairuzan Roslan wrote:
>
>> $ rm -rf testdir
>> rm: testdir/testfile: Operation not permitted
>> rm: testdir: Directory not empty
>>=20
> This works on my system (Mac OS 10.9 as server and client)

Just to be sure: by "work", you mean "successfully removes the
directory", right?

>> The problem with Git failing is not because its inability to delete =
a directory but its inability to unlink and rename tmp_idx_XXXXXX and t=
mp_pack_XXXXXX because those files were set to 0444 by odb_mkstemp.
>> Try google for =E2=80=9CGit AFP=E2=80=9D and you will see a lot peop=
le are facing with the same problem.
> Yes, (at least to my knowledge) you seem to be one of the first to re=
port it here, thanks for that.

And now I'm starting to wonder whether other people do have the same
issue. Sure, googling "Git AFP" shows a lot of people having problems
with Git and AFP, but are they really the same problem?

I googled 'git afp "unable to unlink"', and all results except one poin=
t
to this thread:

https://www.google.com/search?q=3Dgit+afp+%22warning%3A+unable+to+unlin=
k%22

The only one which doesn't actually does not mention afp.

=46airuzan: are you sure you're not the only one having the issue? Can =
you
give more info on your system (OS version client and server side, ...)?

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
