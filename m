From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Black smoke from git rebase -i exec
Date: Tue, 10 Aug 2010 17:05:11 +0200
Message-ID: <vpq62ziv788.fsf@bauges.imag.fr>
References: <AANLkTikCgSNRipTbjiL+uPOqCL3WXwn08_QV=UJ7EwvT@mail.gmail.com>
	<vpqlj8ezizq.fsf@bauges.imag.fr>
	<AANLkTimgRu=nRFpO+QW758SWbQ+Vs+8gtpAc4N-cNWr6@mail.gmail.com>
	<4C615E5E.3090301@viscovery.net>
	<AANLkTikVB6VoSy3=XVHqGsA7xH39MgDwh2hDnX89enfM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	gitster@pobox.com
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 17:06:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiqP4-0000Rt-Mg
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 17:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176Ab0HJPGG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 11:06:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58906 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932129Ab0HJPGE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 11:06:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o7AEsMK4007376
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 10 Aug 2010 16:54:22 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OiqO7-0002K3-Lk; Tue, 10 Aug 2010 17:05:11 +0200
In-Reply-To: <AANLkTikVB6VoSy3=XVHqGsA7xH39MgDwh2hDnX89enfM@mail.gmail.com>
 (=?iso-8859-1?Q?=22=C6var_Arnfj=F6r=F0?= Bjarmason"'s message of "Tue\, 10
 Aug 2010 14\:16\:38 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 10 Aug 2010 16:54:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7AEsMK4007376
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1282056867.79179@jFCDI5yaE7S4qSEtU8VABQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153116>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Aug 10, 2010 at 14:12, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
>> You cannot apply single-command-export if the command is a shell fun=
ction.
>> You must rewrite this as:
>>
>> =A0 =A0 =A0 =A0(
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0export FAKE_LINES=3D"..." &&
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0test_must_fail git rebase ....
>> =A0 =A0 =A0 =A0) &&
>
> Except that's not portable either, it should be:
>
>     FAKE_LINES=3D"..." &&
>     export FAKE_LINES &&
> 	test_must_fail git rebase ...
>
> See the other examples in t3404-rebase-interactive.sh

Yes, I had found this. New patch comming soon.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
