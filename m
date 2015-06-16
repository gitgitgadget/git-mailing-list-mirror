From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 01/11] t6301: for-each-ref tests for ref-filter APIs
Date: Tue, 16 Jun 2015 17:21:51 +0200
Message-ID: <vpqmvzz8yr4.fsf@anie.imag.fr>
References: <CAOLa=ZQeZ=6mZcntR_BS_Wp0LXDzSUx9WTLXCTLxemb0e3SS0w@mail.gmail.com>
	<1434464457-10749-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 17:22:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4sgc-0005ph-UI
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 17:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756019AbbFPPV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 11:21:58 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57363 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754654AbbFPPV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 11:21:57 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5GFLn2j021057
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 16 Jun 2015 17:21:49 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5GFLpPi016463;
	Tue, 16 Jun 2015 17:21:51 +0200
In-Reply-To: <1434464457-10749-1-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Tue, 16 Jun 2015 19:50:47 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 16 Jun 2015 17:21:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5GFLn2j021057
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435072911.48888@+5t9oGfddcsjz6f9JkeaZA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271768>

Karthik Nayak <karthik.188@gmail.com> writes:

> Add tests for 'for-each-ref' which utilizes the ref-filter APIs.
> Currently it's redundant with the tests in 't6300' but more tests
> will be eventually added as we implement more options into
> 'for-each-ref'.

Actually, I'm not convinced that the actual tests have a real value
(since as you say, it's redundant with t6300). Perhaps we can limit this
commit to the setup.

> +++ b/t/t6301-for-each-ref-filter.sh
> @@ -0,0 +1,36 @@
> +#!/bin/sh
> +
> +test_description='test for-each-refs usage of ref-filter APIs'
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-gpg.sh

You are not using lib-gpg.sh, right?

If first thought it was an incorrect cut-and-paste, but I actually think
that you need to setup a signed tag to properly test the --points-at
option (it does not only list refs pointing directly at a commit, but
also refs pointing at a tag pointing at the given commit).

Such signed tag could be added here and used later in PATCH 04.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
