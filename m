From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v8 07/10] send-email: reduce dependencies impact on parse_address_line
Date: Wed, 08 Jul 2015 09:28:38 +0200
Message-ID: <vpqfv4zjeft.fsf@anie.imag.fr>
References: <vpq8uasqeru.fsf@anie.imag.fr>
	<1436276295-694-1-git-send-email-Matthieu.Moy@imag.fr>
	<559CCE56.7080808@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 08 09:28:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCjmh-00028q-Se
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 09:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbbGHH2o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2015 03:28:44 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56550 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932310AbbGHH2m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 03:28:42 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t687SbAd013443
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 8 Jul 2015 09:28:37 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t687ScWD018856;
	Wed, 8 Jul 2015 09:28:38 +0200
In-Reply-To: <559CCE56.7080808@web.de> ("Torsten \=\?iso-8859-1\?Q\?B\=F6gersha\?\=
 \=\?iso-8859-1\?Q\?usen\=22's\?\= message of
	"Wed, 8 Jul 2015 09:16:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 08 Jul 2015 09:28:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t687SbAd013443
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436945317.78335@xLt93in/XQsyvbNCooUf+Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273644>

Torsten B=F6gershausen <tboegi@web.de> writes:

> (Thanks for the quick reply.
> Sorry for the noise about
> #!/usr/bin/perl
> of course we call the right perl)

No problem.

> The new patch seems to be integrated in pu (I tested d08caa8e022f08d)
> Test seems to pass,

Good.

> but some noise is on the channel:

Are you talking about the output of "not ok ... # TODO known breakage"
part, like this:

> ok 24 - same output : 'Jane 'Doe' <jdoe@example.com>
> not ok 25 - same output : Jane\ Doe <jdoe@example.com> # TODO known b=
reakage
> #   Failed (TODO) test 'same output : Jane\ Doe <jdoe@example.com>'
> #   at /Users/tb/NoBackup/projects/git/git.next/t/t9000/test.pl line =
62.
> #     Structures begin differing at:
> #          $got->[0] =3D '"Jane \ Doe" <jdoe@example.com>'
> #     $expected->[0] =3D '"Jane\ Doe" <jdoe@example.com>'

?

If so, it seems to be the way Perl's Test::More works with TODO blocks.
I am reluctant to try to change it for us.


--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
