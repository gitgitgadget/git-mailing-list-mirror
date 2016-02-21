From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: GSoC 2016: Microproject
Date: Sun, 21 Feb 2016 19:52:43 +0100
Message-ID: <vpq1t85rj44.fsf@anie.imag.fr>
References: <CA+DCAeTAmUAciCx33ZHLKReHSy4K-dEeaKSb19qBcQc_U80UJA@mail.gmail.com>
	<vpq37so26oz.fsf@anie.imag.fr>
	<CA+DCAeQLJnvNFdSobDNOGVaHbDRnRy4vm9_4SB+Bw+5N5QMKHA@mail.gmail.com>
	<CAGZ79kbdTFui5Zxmt0+BrgOzxTFsN2n-XZiJBNj4QFD3HPRpBQ@mail.gmail.com>
	<CA+DCAeRTtECCZSAPYUe2=AoQEvc6LRG1B+qYCCj9C6_nyUJrhw@mail.gmail.com>
	<vpq8u2er7ae.fsf@anie.imag.fr>
	<CA+DCAeQWeUodaBtHOdzGB3RTZTQ672ZUSV-=eh-nA+8Bvn4gxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 19:53:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXZ8k-0001z9-2D
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 19:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbcBUSxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 13:53:50 -0500
Received: from mx1.imag.fr ([129.88.30.5]:59822 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190AbcBUSxt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 13:53:49 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1LIrfsN023394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 21 Feb 2016 19:53:41 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1LIqhYj003857;
	Sun, 21 Feb 2016 19:52:43 +0100
In-Reply-To: <CA+DCAeQWeUodaBtHOdzGB3RTZTQ672ZUSV-=eh-nA+8Bvn4gxw@mail.gmail.com>
	(Mehul Jain's message of "Sun, 21 Feb 2016 21:34:18 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 21 Feb 2016 19:53:42 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1LIrfsN023394
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1456685624.31015@j5Pua1rg36CdUmqwzjASSQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286824>

Mehul Jain <mehul.jain2029@gmail.com> writes:

> Earlier when I was testing the master branch on my pc, I used "make"
> in \t directory, which lead to failure of test #2, #3 in
> t5539-fetch-http-shallow.sh .
> Afterwards I switched to sudo mode and ran the make command again.

Never ever do that. Your git source tree should be within your $HOME
directory, and you should never run any command as root that creates
files within your $HOME dir. If you do that, you'll end up having files
belonging to root within other directories, you won't have write
permission on these files. Then, anything can go wrong because any
attempt to write to these files will fail.

The simplest way to get back on track for you is probably to start over
with a fresh clone, or (warning: destructive operations): use git clean
to remove untracked files.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
