From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFH] xdiff shows trivially redundant diff.
Date: Mon, 03 Apr 2006 13:01:55 -0700
Message-ID: <7vbqvictsc.fsf@assigned-by-dhcp.cox.net>
References: <7v4q1cmj7l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604021035130.30097@alien.or.mcafeemobile.com>
	<7vzmj3k7x9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604021454560.30205@alien.or.mcafeemobile.com>
	<Pine.LNX.4.64.0604021749580.23419@g5.osdl.org>
	<Pine.LNX.4.64.0604022022390.10401@alien.or.mcafeemobile.com>
	<Pine.LNX.4.64.0604022116060.3781@g5.osdl.org>
	<Pine.LNX.4.64.0604022124440.10401@alien.or.mcafeemobile.com>
	<7v4q1bglkp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604031222360.30048@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 22:02:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQVFQ-0000ZM-UJ
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 22:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWDCUB6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 16:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWDCUB6
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 16:01:58 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:6279 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S964867AbWDCUB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Apr 2006 16:01:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060403200156.OBEY20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Apr 2006 16:01:56 -0400
To: Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <Pine.LNX.4.64.0604031222360.30048@alien.or.mcafeemobile.com>
	(Davide Libenzi's message of "Mon, 3 Apr 2006 12:33:58 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18350>

Davide Libenzi <davidel@xmailserver.org> writes:

>> For example, the first hunk says:
>>
>> 	@@ -0,0 +6 @@
>>        +#include "diff.h"
>>
>> Which is inconsistent with what GNU diff says:
>>
>> 	@@ -5,0 +6 @@
>>        +#include "diff.h"
>>
>> I've tried this patch but...
>
> The fix is fine, but you should do the same even in the s2 case. The
> correct hunk should have been:
>
> @@ -6,0 +6 @@

You are right.  GNU says -5,0 not -6,0 so presumably "patch"
other people use expect it to say -5,0 not -6,0; even though we
could argue the insertion happens at 6th position and saying
-6,0 is more logical, it does not matter -- what incumbent does
wins X-<.  I notice that your fix shows -5,0 to match it ;-).

Thanks for the fix.
