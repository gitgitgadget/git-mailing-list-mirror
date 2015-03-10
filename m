From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 2/2] Added tests for reset -
Date: Tue, 10 Mar 2015 14:26:38 +0100
Message-ID: <vpqa8zlx9td.fsf@anie.imag.fr>
References: <1425984728-27996-1-git-send-email-sudshekhar02@gmail.com>
	<1425984728-27996-2-git-send-email-sudshekhar02@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com, davvid@gmail.com,
	sunshine@sunshineco.com
To: Sudhanshu Shekhar <sudshekhar02@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 14:26:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVKBS-0007BN-O3
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 14:26:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbbCJN0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 09:26:50 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51757 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285AbbCJN0t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 09:26:49 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t2ADQb0g018950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Mar 2015 14:26:37 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t2ADQcPP004468;
	Tue, 10 Mar 2015 14:26:38 +0100
In-Reply-To: <1425984728-27996-2-git-send-email-sudshekhar02@gmail.com>
	(Sudhanshu Shekhar's message of "Tue, 10 Mar 2015 16:22:08 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 10 Mar 2015 14:26:37 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t2ADQb0g018950
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1426598800.55393@zvDofPNUj+zEYoif0losow
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265233>

Sudhanshu Shekhar <sudshekhar02@gmail.com> writes:

> +test_expect_success 'reset - while having file named - and no previous branch' '

I like having the expected behavior in the test name too. e.g. add
"fails" at the end of the sentence.

> +test_expect_success 'reset - in the presence of file named - with previous branch' '
> +	echo "Unstaged changes after reset:" >expect &&
> +	echo "M	-" >>expect &&
> +	echo "M	1" >>expect &&

Here and elsewhere: why not

	cat >expect <<-EOF
	Unstaged changes after reset:
	M -
	M 1

?

> +	rm -rf no_previous &&

That would be best done in a test_when_finished, so that the directory
is removed regardless of whether the test failed before this line or
not.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
