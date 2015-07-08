From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v8 01/11] t6302: for-each-ref tests for ref-filter APIs
Date: Wed, 08 Jul 2015 17:46:57 +0200
Message-ID: <vpq615ud53i.fsf@anie.imag.fr>
References: <CAOLa=ZTP+=aQL_JW4+O7jUh5jTD1bWpk7xbguYUsW1DkotAafA@mail.gmail.com>
	<1436285177-12279-1-git-send-email-karthik.188@gmail.com>
	<559CDAC1.8030600@web.de> <vpqwpybf25f.fsf@anie.imag.fr>
	<CAOLa=ZQ=Mjx-L8Xn9kA86b7nv_bF24Mje1rU-Rmcq4kMqp8qMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 17:47:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCrZ3-0005z2-Pu
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 17:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935294AbbGHPrE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2015 11:47:04 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55873 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935015AbbGHPrA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 11:47:00 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t68Fkt0Q008095
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 8 Jul 2015 17:46:55 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t68Fkv1U030651;
	Wed, 8 Jul 2015 17:46:57 +0200
In-Reply-To: <CAOLa=ZQ=Mjx-L8Xn9kA86b7nv_bF24Mje1rU-Rmcq4kMqp8qMg@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 8 Jul 2015 19:29:58 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 08 Jul 2015 17:46:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t68Fkt0Q008095
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436975216.28252@TKM/MK0bJuXfWWEZyDvrJg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273690>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Wed, Jul 8, 2015 at 2:37 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Torsten B=F6gershausen <tboegi@web.de> writes:
>>
>>> Could we have a tweak for people without gpg?
>>
>> I guess we need stg like
>>
>> if ! test_have_prereq GPG; then
>>         skip_all=3D'skipping for-each-ref tests, gpg not available'
>>         test_done
>> fi
>>
>> since we need GPG in the setup test and almost all other tests will =
rely
>> on it.
>>
>
> Does this need to be there? I see a lot of test files which need GPG,=
 and since
> this test file contains tests which rely on it, without it, it would
> be kinda useless
> anyways?

In many cases, the tests look like

=2E lib-gpg.sh

test_expect_success 'test that does not use GPG' '
        ...
'

test_expect_success GPG 'test that does use GPG' '
        ...
'

so you can't decide in lib-gpg.sh that you'll skip all tests, because
you would skip some tests that could be ran without gpg.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
