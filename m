From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/7] add a test for semantic errors in config files
Date: Wed, 23 Jul 2014 21:55:44 +0200
Message-ID: <vpq38drvohr.fsf@anie.imag.fr>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<1406140978-9472-4-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:55:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA2dm-0007dN-7V
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 21:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933179AbaGWTzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 15:55:49 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60796 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932857AbaGWTzs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 15:55:48 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6NJtfgu006172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Jul 2014 21:55:42 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6NJtiK3026346;
	Wed, 23 Jul 2014 21:55:44 +0200
In-Reply-To: <1406140978-9472-4-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Wed, 23 Jul 2014 11:42:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 23 Jul 2014 21:55:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6NJtfgu006172
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406750143.62232@hRyvaiN7++H+NwmBJoqNYg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254115>

Tanay Abhra <tanayabh@gmail.com> writes:

> +test_expect_success 'check line errors for malformed values' '
> +	cp .git/config .git/config.old &&
> +	test_when_finished "mv .git/config.old .git/config" &&
> +	echo "[alias]\n br" >.git/config &&
> +	test_expect_code 128 git br 2>result &&
> +	grep "fatal: bad config file line 2 in .git/config" result
> +'
> +

The test fails at this point in history. I guess the problem will
disapear once you've put PATCH 2 at the right point in the series.

Another option is to mark the test as test_expect_failure when you
introduce it, and change it to test_expect_success when you fix it
(probably not applicable here, but it's a trick I find elegant).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
