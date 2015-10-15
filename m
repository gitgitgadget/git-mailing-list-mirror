From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 1/3] Add Travis CI support
Date: Thu, 15 Oct 2015 10:12:27 +0200
Message-ID: <vpqwpuo35zo.fsf@grenoble-inp.fr>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com>
	<1444586102-82557-2-git-send-email-larsxschneider@gmail.com>
	<561CDDBA.609@gmail.com>
	<14146E1E-857D-416B-9287-F20826DCB806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?iso-8859-1?Q?Jean-No=EBl?= Avila <avila.jn@gmail.com>,
	git@vger.kernel.org, johannes.schindelin@gmx.de, tboegi@web.de,
	pw@padd.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 10:13:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zmdem-0005bx-4N
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 10:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbbJOIMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 04:12:48 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46218 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492AbbJOIMe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 04:12:34 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t9F8CQoB005602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 15 Oct 2015 10:12:26 +0200
Received: from anie (ensi-vpn-233.imag.fr [129.88.57.233])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9F8CR1I010329;
	Thu, 15 Oct 2015 10:12:27 +0200
In-Reply-To: <14146E1E-857D-416B-9287-F20826DCB806@gmail.com> (Lars
	Schneider's message of "Thu, 15 Oct 2015 09:59:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 15 Oct 2015 10:12:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9F8CQoB005602
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445501548.0938@IZOsFjutO0rULNnYBoVtRQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279654>

Lars Schneider <larsxschneider@gmail.com> writes:

> I was reluctant to this because I feared problems. Especially while
> running tests in parallel.

Isn't the point of using a CI tool to notice problems? ;-)

More seriously, running tests in parallel shouldn't be a problem since
each test runs in its own directory with HOME set to this private
directory, so two diffent tests should not interfer. If there's an issue
with parallel tests, we probably prefer discovering them than avoiding
them.

> make -j2 9min 11sec:
> https://travis-ci.org/larsxschneider/git/jobs/85478022
>
> make 17min 20sec:
> https://travis-ci.org/larsxschneider/git/jobs/85432398

Since the tests are essentially IO-bound and not CPU-bound, it may even
make sense to use -j3 here.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
