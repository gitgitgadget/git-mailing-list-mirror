From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/ PATCH 1/5] tree-walk: do not stop when an error is detected
Date: Wed, 09 Jun 2010 22:54:11 +0200
Message-ID: <vpqpr00x6z0.fsf@bauges.imag.fr>
References: <1276087446-25112-1-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276087446-25112-2-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276087446-25112-3-git-send-email-diane.gasselin@ensimag.imag.fr>
	<7vaar4p2vo.fsf@alter.siamese.dyndns.org>
	<AANLkTimSYHX1yXEGif6Mk1kadUy1QSHTQByiyuFsqe8r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>
To: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 09 22:55:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMSIv-0003lh-Ki
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 22:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758270Ab0FIUzK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 16:55:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42863 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754510Ab0FIUzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 16:55:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o59KkPtd012673
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 9 Jun 2010 22:46:25 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OMSHr-0002Wl-JQ; Wed, 09 Jun 2010 22:54:11 +0200
In-Reply-To: <AANLkTimSYHX1yXEGif6Mk1kadUy1QSHTQByiyuFsqe8r@mail.gmail.com> (Diane Gasselin's message of "Wed\, 9 Jun 2010 19\:18\:19 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 09 Jun 2010 22:46:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o59KkPtd012673
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148815>

Diane Gasselin <diane.gasselin@ensimag.imag.fr> writes:

>> A small worry is if we have some codepath that uses this function li=
ke
>> this:
>>
>> =A0 =A0if (traverse trees finishes successfully) {
>> =A0 =A0 =A0 =A0be happy, all is well;
>> =A0 =A0} else {
>> =A0 =A0 =A0 =A0attempt a different strategy to achieve
>> =A0 =A0 =A0 =A0what we wanted to with traverse trees, if
>> =A0 =A0 =A0 =A0it worked fine.
>> =A0 =A0}
[...]
> Seems pretty fair.
> Can I add in this case an option to git pull and git merge to specify
> that we do want to collect all the errors?

I don't think this should ever been exposed in the user interface. It
may be interesting to add this in the API (an extra argument letting
the caller decide whether to fail early or not), but the user running
"git pull" normally expects it to succeed, and can clearly accept that
a failure takes as much time as a success, especially when the better
error message lets him save a few tens of seconds, if not minutes.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
