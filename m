From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 0/3] git config cache & special querying api utilizing the cache
Date: Mon, 07 Jul 2014 19:10:38 +0200
Message-ID: <vpqlhs5w0vl.fsf@anie.imag.fr>
References: <1404719566-3368-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 19:10:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4CRJ-0004nu-DR
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 19:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbaGGRKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 13:10:50 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47234 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751020AbaGGRKt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 13:10:49 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s67HAaQr006407
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 7 Jul 2014 19:10:36 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s67HAceR004436;
	Mon, 7 Jul 2014 19:10:39 +0200
In-Reply-To: <1404719566-3368-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 7 Jul 2014 00:52:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 07 Jul 2014 19:10:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s67HAaQr006407
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1405357840.15012@YJ6V/Be6v8eB1kI+pgsEiQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252971>

Tanay Abhra <tanayabh@gmail.com> writes:

>  test_expect_success 'find value with misspelled key' '
> -	echo "Value not found for \"my.fOo Bar.hi\"" >expect &&
> -	test_must_fail test-config get_value "my.fOo Bar.hi" >actual &&
> -	test_cmp expect actual
> +	check "my.fOo Bar.hi" "Value not found for \"my.fOo Bar.hi\""
>  '

This one is wrong: you did need the test_must_fail here.

(That's related to my other message about &&-chaining in check)

Other than my minor remarks, the patches now sounds good. Tanay: you
should be able to send a v7 very soon, and it should hopefully be ready
for pu.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
