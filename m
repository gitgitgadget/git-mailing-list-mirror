From: Andreas Ericsson <ae@op5.se>
Subject: Re: I'm a total push-over..
Date: Wed, 23 Jan 2008 10:31:11 +0100
Message-ID: <4797095F.9020602@op5.se>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org> <4796FBB6.9080609@op5.se> <20080123091558.GP14871@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 14:11:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHfNZ-0005d2-2i
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 14:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbYAWNKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 08:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbYAWNKZ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 08:10:25 -0500
Received: from mail.op5.se ([193.201.96.20]:41978 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009AbYAWNKY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 08:10:24 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 7FB661F08056;
	Wed, 23 Jan 2008 14:10:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.665
X-Spam-Level: 
X-Spam-Status: No, score=-3.665 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.691, BAYES_00=-2.599,
	DATE_IN_PAST_03_06=0.044]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KL0q7qqBC3DX; Wed, 23 Jan 2008 14:10:20 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id A9BE81F0805B;
	Wed, 23 Jan 2008 14:10:08 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <20080123091558.GP14871@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71538>

Dmitry Potapov wrote:
> On Wed, Jan 23, 2008 at 09:32:54AM +0100, Andreas Ericsson wrote:
>> The FNV hash would be better (pasted below), but I doubt
>> anyone will ever care, and there will be larger differences
>> between architectures with this one than the lt_git hash (well,
>> a function's gotta have a name).
> 
> Actually, Bob Jenkins' lookup3 hash is twice faster in my tests
> than FNV, and also it is much less likely to have any collision.
> 

>From http://burtleburtle.net/bob/hash/doobs.html
---
FNV Hash

I need to fill this in. Search the web for FNV hash. It's faster than my hash on Intel (because Intel has fast multiplication), but slower on most other platforms. Preliminary tests suggested it has decent distributions. 
---

My tests ran on Intel. I also noticed I had a few hashes commented out when
doing the test, one of them being Paul Hsie's. For some reason, Jenkin's and
Hsie's didn't perform well for me last time I used the comparison thing (I
did a more thorough job back then, with tests running for several minutes
per hash and table-size, so I commented out the poor candidates).

I still believe that for this very simple case, the lookup3.c case is not
very practical, as the code is that much more complicated, which was my
main point with posting the comparison. Iow, not "switch to this hash,
because it's better", but rather "the hash is not as bad as you think and
will probably work well for all practical purposes".

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
