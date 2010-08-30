From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] tests: factor HOME=$(pwd) in test-lib.sh
Date: Mon, 30 Aug 2010 12:54:20 +0200
Message-ID: <vpqtymcs74z.fsf@bauges.imag.fr>
References: <7vzkw4edc5.fsf@alter.siamese.dyndns.org>
	<1283161842-22689-1-git-send-email-Matthieu.Moy@imag.fr>
	<AANLkTi=81oEPHko45Mo2d1qn+qWy-TVLvrFcXaVKd8Lu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 12:54:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq20Z-0007JC-If
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 12:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889Ab0H3Kya convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 06:54:30 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58368 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753663Ab0H3Kya (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 06:54:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o7UAgWc0011669
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 30 Aug 2010 12:42:32 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Oq20K-0007xM-No; Mon, 30 Aug 2010 12:54:20 +0200
In-Reply-To: <AANLkTi=81oEPHko45Mo2d1qn+qWy-TVLvrFcXaVKd8Lu@mail.gmail.com>
 (=?iso-8859-1?Q?=22=C6var_Arnfj=F6r=F0?= Bjarmason"'s message of "Mon\, 30
 Aug 2010 10\:22\:50 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 30 Aug 2010 12:42:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7UAgWc0011669
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1283769753.05908@xBeMZ6xkRRhBUW8c/mYWSw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154783>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Aug 30, 2010 at 09:50, Matthieu Moy <Matthieu.Moy@imag.fr> wr=
ote:
>> The same pattern is used in many tests, and makes it easy for new on=
es to
>> rely on $HOME being a trashable, clean, directory.
>
> Looks good, but why not:
>
>> +HOME=3D$(pwd)
>> +export HOME
>
> This instead:
>
> HOME=3D$TRASH_DIRECTORY
> export HOME
>
> Looks like it might be more correct given this (always an absolute
> path), but I haven't tested:

That should work too, but with your version, I have to think harder to
make sure $TRASH_DIRECTORY is absolute (that should be OK), and won't
make any issue with symlinks (I have no idea whether it is OK or not),
while it's trivially correct with mine (pwd is absolute, and the -P
option of the cd command right above prevents issue with symlinks).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
