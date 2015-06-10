From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 4/4] bisect: add the terms old/new
Date: Wed, 10 Jun 2015 10:09:10 +0200
Message-ID: <vpq7frcast5.fsf@anie.imag.fr>
References: <1839018688.331427.1433920317370.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 10 10:09:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2b4k-0005bA-1l
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 10:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbbFJIJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 04:09:25 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50834 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751431AbbFJIJU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 04:09:20 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5A899Un014103
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Jun 2015 10:09:09 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5A89Aqh014133;
	Wed, 10 Jun 2015 10:09:10 +0200
In-Reply-To: <1839018688.331427.1433920317370.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Antoine Delaite's message of "Wed, 10 Jun 2015 09:11:57 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 10 Jun 2015 10:09:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5A899Un014103
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434528553.79412@UX7eUlkTNEBlKWcj4Xsv8w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271273>

Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr> writes:

> Hi,
>
> thanks for the review, 
>
> (sorry if you received this twice) 
>
> Junio C Hamano <gitster@pobox.com> writes: 
>
>>Just throwing a suggestion. You could perhaps add a new verb to be 
>>used before starting to do anything, e.g. 
>> 
>> $ git bisect terms new old 
>
> Yes it would be nice and should not be hard to implement. But it was not 
> the idea of how the code was made by our elders.

"Somebody else did it like that" is not a good justification. Especially
when the previous code was not merged: the code wasn't finished.

But I actually disagree with the fact that it was not the idea. The
point of having the terms in BISECT_TERMS was precisely to be generic
enough. Had the goal been just to distinguish good/bad and old/new, we
would have needed only one bit of information, and encoding it with the
existance/non-existance of a file would have been sufficient (as you
tried to do in addition to BISECT_TERMS).

> For now we just rebased, corrected and finishing to implement
> functionalities.

functionalities is one thing, but the code should be maintainable to be
merged in git.git. Git would not be where it is if Junio was merging
patches based on "it works, we'll see if the code is good enough later"
kinds of judgments ;-).

Moving from "one hardcoded pair of terms" to "two hardcoded pairs of
terms" is a nice feature, but hardly a step in the right direction wrt
maintainability.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
