From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv5 7/7] Improve error handling when parsing dirstat
 parameters
Date: Fri, 29 Apr 2011 01:13:26 +0200
Message-ID: <201104290113.26481.johan@herland.net>
References: <1303892653-3958-1-git-send-email-johan@herland.net>
 <1303953442-26536-8-git-send-email-johan@herland.net>
 <7vhb9i43sl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 01:13:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFaOt-0007B8-GA
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 01:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300Ab1D1XNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 19:13:30 -0400
Received: from smtp.getmail.no ([84.208.15.66]:64765 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754605Ab1D1XN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 19:13:29 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKD00EXUXUFDB30@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 29 Apr 2011 01:13:27 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 77D0C1EEF71A_DB9F497B	for <git@vger.kernel.org>; Thu,
 28 Apr 2011 23:13:27 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id EAFA51EEF56B_DB9F496F	for <git@vger.kernel.org>; Thu,
 28 Apr 2011 23:13:26 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKD006FYXUEF100@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 29 Apr 2011 01:13:26 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.2; x86_64; ; )
In-reply-to: <7vhb9i43sl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172417>

(I've snipped the comments that I don't dispute or need to comment on)

On Thursday 28 April 2011, Junio C Hamano wrote:
> The error output shows "error:" followed by "warning:", which looked
> somewhat questionable.  Perhaps allow a pointer to a structure be passed
> in to describe the nature of a breakage to parse_dirstat_params()?

Not sure what you mean here. You want the caller to supply a string_list, to 
which parse_dirstat_params() appends error messages, and then the caller 
determines how to display those error messages to the user after 
parse_dirstat_params() has returned?

I'd rather go the simpler way, and simply turn the first "error:" into a 
"warning:". In other words, parse_dirstat_params() should only output 
"warning:", and then it's up to the caller whether to follow up with another 
"warning:" (in the diff.dirstat case), or a "fatal:" (in the --dirstat 
case).


Otherwise, I agree with all your comments, and the next re-roll will be 
updated accordingly.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
