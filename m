From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Fix off-by-one error: don't read the byte before a malloc'd buffer.
Date: Sun, 9 Dec 2007 14:24:37 -0500
Message-ID: <33716C48-068F-42C5-BD84-608EE9017636@silverinsanity.com>
References: <87hcitgpca.fsf@rho.meyering.net> <7vsl2bpwe1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jim Meyering <jim@meyering.net>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 20:25:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1Rlu-0001BX-Lq
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 20:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbXLITYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 14:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbXLITYk
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 14:24:40 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:34661 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbXLITYk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 14:24:40 -0500
Received: from [192.168.1.6] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 0D7111FFC142;
	Sun,  9 Dec 2007 19:24:38 +0000 (UTC)
In-Reply-To: <7vsl2bpwe1.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67652>


On Dec 9, 2007, at 1:15 PM, Junio C Hamano wrote:

> The fix may be correct but the comment above the part the patch  
> fixes is
> very misleading and I wasted a few minutes checking to see what it is
> doing is correct.

The fix is correct.  I did not anticipate empty strings when I wrote  
the loop in question.  Although I wonder if that should be expanded to  
use isspace instead of checking for just ' '.  I'm less familiar with  
the config parsing than I was.

> The "quote" variable does not really control quoting; the quoting with
> backslash is always done for the value, and this check is about  
> adding a
> dq pair around it, so that the parser does not lose leading or  
> trailing
> SP or string after start-of-comment marker characters.

It's for adding quotes, which made the comment make sense to me.  But  
your expanded description is correct and matches the commit message I  
wrote.  Thanks for clarifying it in the code.

~~ Brian
