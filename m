From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: `git stash pop` UX Problem
Date: Wed, 26 Feb 2014 20:46:44 +0100
Message-ID: <vpqy50xd5cr.fsf@anie.imag.fr>
References: <530B0395.5030407@booking.com>
	<CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
	<530C953F.9050805@booking.com> <vpqlhwz5o58.fsf@anie.imag.fr>
	<530CA4C9.60601@booking.com> <vpqeh2r43kx.fsf@anie.imag.fr>
	<530D97BA.1080107@booking.com> <vpqzjlez3c4.fsf@anie.imag.fr>
	<xmqqd2i94qfq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Omar Othman <omar.othman@booking.com>,
	Brandon McCaig <bamccaig@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 26 21:07:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIklB-0000C8-50
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 21:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608AbaBZUHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 15:07:10 -0500
Received: from mx2.imag.fr ([129.88.30.17]:45904 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753404AbaBZUHI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 15:07:08 -0500
X-Greylist: delayed 1205 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Feb 2014 15:07:07 EST
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s1QJkfGL022321
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 26 Feb 2014 20:46:42 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s1QJkiM9023159;
	Wed, 26 Feb 2014 20:46:44 +0100
In-Reply-To: <xmqqd2i94qfq.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 26 Feb 2014 11:36:09 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 26 Feb 2014 20:46:42 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s1QJkfGL022321
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1394048804.19754@Dr/Pg4fkagFd6B7dU/Hrjw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242755>

Junio C Hamano <gitster@pobox.com> writes:

> I'd however have to say that even "please resolve the conflicts
> manually" is over-assuming.

I understand your point, but in a short hint message, I still find it
reasonable. Fixing conflicts is the natural way to go after a "stash
pop", and the user who do not want to go this way probably knows why.

> "The stash was not dropped" is the most important thing in your
> additional text.  How about rephrasing like this?
>
>     $ git stash pop
>     Auto-merging foo.txt
>     CONFLICT (content): Merge conflict in foo.txt
>
>     The stashed change could not be replayed cleanly, leaving
>     conflicts in the working tree. The stash was not dropped in case
>     you need it again.
>
>     After you are done with the stash, you may want to "git stash
>     drop" to discard it.

I'm fine with this, but it's even longer than mine which I already found
too long. Perhaps the "leaving conflicts in the working tree" could be
dropped, as the message follows "CONFLICT (content): Merge conflict in
foo.txt".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
