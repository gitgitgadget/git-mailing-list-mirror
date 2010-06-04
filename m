From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 4/4] t/t8006: test textconv support for blame
Date: Fri, 04 Jun 2010 11:45:38 +0200
Message-ID: <vpqzkzb9lml.fsf@bauges.imag.fr>
References: <1275562038-7468-1-git-send-email-axel.bonnet@ensimag.imag.fr>
	<1275562038-7468-4-git-send-email-axel.bonnet@ensimag.imag.fr>
	<1275562038-7468-5-git-send-email-axel.bonnet@ensimag.imag.fr>
	<201006031744.07569.j6t@kdbg.org>
	<AANLkTil7Y6PPkbmzuID4vY_fhEwvP4qa2UG5jC1qLtTG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 04 11:48:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKTWC-0008Jr-BZ
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 11:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314Ab0FDJsm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 05:48:42 -0400
Received: from imag.imag.fr ([129.88.30.1]:62683 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754431Ab0FDJsl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 05:48:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o549jc0b023695
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 4 Jun 2010 11:45:39 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OKTT8-0006lY-SK; Fri, 04 Jun 2010 11:45:38 +0200
In-Reply-To: <AANLkTil7Y6PPkbmzuID4vY_fhEwvP4qa2UG5jC1qLtTG@mail.gmail.com> (Diane Gasselin's message of "Fri\, 4 Jun 2010 10\:55\:34 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 04 Jun 2010 11:45:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148393>

Diane Gasselin <diane.gasselin@ensimag.imag.fr> writes:

>>> +test_expect_success 'setup ' '
>>> + =A0 =A0 echo test 1 >one.bin &&
>>> + =A0 =A0 echo test number 2 >two.bin &&
>>> + =A0 =A0 ln one.bin link.bin &&
>>
>> Do you need a hard link? Can't you just copy the file at the right t=
ime?
>>
>
> At first, we wanted to test how links handle textconv but it behaves
> as regular file so the test is not really relevant. It will be
> deleted.

You do want to test what happens for _symbolic_ links (stored as blob
whose content is the target of the link IIRC). You probably don't want
to run the textconv filter on link targets. I guess you meant "ln -s"
here.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
