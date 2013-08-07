From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] die_with_status: use "printf '%s\n'", not "echo"
Date: Wed, 07 Aug 2013 11:23:37 +0200
Message-ID: <vpqy58dj1ly.fsf@anie.imag.fr>
References: <7vwqnyg10v.fsf@alter.siamese.dyndns.org>
	<1375813604-10565-1-git-send-email-Matthieu.Moy@imag.fr>
	<871u65yj0v.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Aug 07 11:23:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6zyJ-0001Wq-2c
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 11:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757375Ab3HGJXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 05:23:55 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42633 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757362Ab3HGJXy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 05:23:54 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r779NaKA008512
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 7 Aug 2013 11:23:38 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V6zxx-00053i-Jq; Wed, 07 Aug 2013 11:23:37 +0200
In-Reply-To: <871u65yj0v.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Wed, 7 Aug 2013 10:58:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 07 Aug 2013 11:23:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r779NaKA008512
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1376472221.09731@Ea7mc/mXRBcJsPXiBwZEEA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231815>

Thomas Rast <trast@inf.ethz.ch> writes:

>> +	grep -v "	" error
>
> Umm, doesn't that only test that _some_ line in the error does not
> contain a tab?

Indeed. It does work as the error message is just a one-liner, but let's
be robust anyway.

> Whereas you need to test that _no_ line contains <TAB>emp, or some
> such.  Perhaps as
>
>   ! grep -v "	emp" error

Err, then the -v should be remove. Also, I'll use test_expect_code 1
instead of ! to catch other grep failures, just in case.

Thanks, new patch comming.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
