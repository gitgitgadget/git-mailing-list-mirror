From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] status: show 'revert' state and status hint
Date: Tue, 02 Apr 2013 22:36:20 +0200
Message-ID: <vpqr4isd60r.fsf@grenoble-inp.fr>
References: <1364689848-52647-1-git-send-email-robin.rosenberg@dewire.com>
	<1364912422-29536-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vobdwbs86.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 22:37:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN7x9-0001GI-TJ
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 22:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762294Ab3DBUgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 16:36:43 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53678 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761463Ab3DBUgm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 16:36:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r32KaIkn030507
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 2 Apr 2013 22:36:18 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UN7wK-0001MV-HS; Tue, 02 Apr 2013 22:36:20 +0200
In-Reply-To: <7vobdwbs86.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 02 Apr 2013 13:19:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 02 Apr 2013 22:36:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r32KaIkn030507
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1365539781.46677@WSx1laFolyW4QGRxEjurLA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219881>

Junio C Hamano <gitster@pobox.com> writes:

>> +	if (advice_status_hints) {
>> +	}
>> +	if (advice_status_hints)
>> +		status_printf_ln(s, color,
>> +			_("  (use \"git revert --abort\" to cancel the revert operation)"));
>
> Why not a single conditional? i.e.
>
> 	if (advice_status_hints) {
> 		if unmerged
> 			fix and continue
> 		else
> 			say continue
> 		you can also say abort
> 	}

Oops, you're right. I wrote the code mostly with cut-and-past + edit
from other functions, and didn't notice the obvious refactoring
opportunity.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
