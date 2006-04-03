From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [RFH] xdiff shows trivially redundant diff.
Date: Mon, 3 Apr 2006 15:50:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604031548150.30048@alien.or.mcafeemobile.com>
References: <7v4q1cmj7l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604021035130.30097@alien.or.mcafeemobile.com>
 <7vzmj3k7x9.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604021454560.30205@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0604021749580.23419@g5.osdl.org>
 <Pine.LNX.4.64.0604022022390.10401@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0604022116060.3781@g5.osdl.org>
 <Pine.LNX.4.64.0604022124440.10401@alien.or.mcafeemobile.com>
 <7v4q1bglkp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604031222360.30048@alien.or.mcafeemobile.com>
 <7vbqvictsc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 04 00:51:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQXt3-0000Ys-UI
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 00:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWDCWvD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 18:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWDCWvC
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 18:51:02 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:64684 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S964890AbWDCWvA
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 18:51:00 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.dev.mdolabs.com with [XMail 1.23 ESMTP Server]
	id <S1C8645> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Mon, 3 Apr 2006 15:50:42 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqvictsc.fsf@assigned-by-dhcp.cox.net>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18360>

On Mon, 3 Apr 2006, Junio C Hamano wrote:

> Davide Libenzi <davidel@xmailserver.org> writes:
>
>>> For example, the first hunk says:
>>>
>>> 	@@ -0,0 +6 @@
>>>        +#include "diff.h"
>>>
>>> Which is inconsistent with what GNU diff says:
>>>
>>> 	@@ -5,0 +6 @@
>>>        +#include "diff.h"
>>>
>>> I've tried this patch but...
>>
>> The fix is fine, but you should do the same even in the s2 case. The
>> correct hunk should have been:
>>
>> @@ -6,0 +6 @@
>
> You are right.  GNU says -5,0 not -6,0 so presumably "patch"
> other people use expect it to say -5,0 not -6,0; even though we
> could argue the insertion happens at 6th position and saying
> -6,0 is more logical, it does not matter -- what incumbent does
> wins X-<.  I notice that your fix shows -5,0 to match it ;-).

Yeah, I had to make it such that GNU patch could swallow it, otherwise it 
made no sense (being it right or not). Even the other issue is fixed now, 
and I'll send you a libxdiff-based diff as soon as it passes some tests.



- Davide
