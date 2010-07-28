From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/4 v2] Allow detached form (e.g. "git log --grep foo") in  log options.
Date: Wed, 28 Jul 2010 13:29:00 +0200
Message-ID: <vpq8w4vhmkj.fsf@bauges.imag.fr>
References: <vpqr5ioukca.fsf@bauges.imag.fr>
	<1280310062-16793-3-git-send-email-Matthieu.Moy@imag.fr>
	<AANLkTikzL-sgysKD+0CZ100xHWZro=-hDgDgUL2Pb3yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 13:33:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe4sx-0006UD-4l
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 13:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627Ab0G1LdO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 07:33:14 -0400
Received: from imag.imag.fr ([129.88.30.1]:63371 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753896Ab0G1LdN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 07:33:13 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o6SBT1im003180
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Jul 2010 13:29:01 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Oe4on-0001i5-04; Wed, 28 Jul 2010 13:29:01 +0200
In-Reply-To: <AANLkTikzL-sgysKD+0CZ100xHWZro=-hDgDgUL2Pb3yw@mail.gmail.com>
 (=?iso-8859-1?Q?=22=C6var_Arnfj=F6r=F0?= Bjarmason"'s message of "Wed\, 28
 Jul 2010 10\:11\:20 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 28 Jul 2010 13:29:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152078>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Jul 28, 2010 at 09:41, Matthieu Moy <Matthieu.Moy@imag.fr> wr=
ote:
>
> Here's a better commit message, the subject was >50 chars> (see
> Documentation/SubmittingPatches):

I don't see a mention of 50 chars there. Conventions usually limit
lines to <80 chars (sometimes 72), and my subject line is 64
chars-wide if you don't count [PATCH], which won't end up in git.git.

>> +test_expect_success 'log --grep option parsing' '
>> + =A0 =A0 =A0 echo second >expect &&
>> + =A0 =A0 =A0 git log -1 --pretty=3D"tformat:%s" --grep sec >actual =
&&
>> + =A0 =A0 =A0 test_cmp expect actual &&
>> + =A0 =A0 =A0 test_must_fail git log -1 --pretty=3D"tformat:%s" --gr=
ep
>> +'
>
> There's a lot of behavior change in this series, but only two small
> tests that I can see.

4, not 2.

> It would be easy to change the parsing code back without triggering
> a regression test.

I've introduced a test for each pattern, but deliberately did not do
exhaustive testing: I'm testing the patterns, not the way they are
applied. In the same way, I don't think there's a testcase for each
use of parse-option in the testsuite.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
