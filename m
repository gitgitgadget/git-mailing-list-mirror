From: Andreas Ericsson <ae@op5.se>
Subject: Re: git diff woes
Date: Mon, 12 Nov 2007 11:35:48 +0100
Message-ID: <47382C84.50408@op5.se>
References: <4738208D.1080003@op5.se> <Pine.LNX.4.64.0711120958500.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 11:36:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrWeI-0005mG-7v
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 11:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756498AbXKLKfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 05:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756633AbXKLKfw
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 05:35:52 -0500
Received: from mail.op5.se ([193.201.96.20]:42686 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756305AbXKLKfv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 05:35:51 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 1DC281F0875B;
	Mon, 12 Nov 2007 11:35:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AVDhey4loAwW; Mon, 12 Nov 2007 11:35:49 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 3B4001F0875A;
	Mon, 12 Nov 2007 11:35:49 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <Pine.LNX.4.64.0711120958500.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64595>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 12 Nov 2007, Andreas Ericsson wrote:
> 
>> I recently ran into an oddity with the excellent git diff output
>> format. When a function declaration changes in the same patch as
>> something else in a function, the old declaration is used with the
>> diff hunk-headers.
>>
>> [...]
>>
>> It definitely looks like a bug, but really isn't, since an earlier hunk
>> (pasted below) changes the declaration.
>>
>> [...]
>>
>> This makes it impossible to trust the hunk-header info if the declaration
>> changes.
> 
> Huh?  You admit yourself that it is not a bug.


In the check_ntpd.c program, there is no bug. I found the git diff output
surprising, so I reported it.

>  And sure you can trust the 
> hunk header.  Like most of the things, the relate to the _original_ 
> version, since the diff is meant to be applied as a forward patch.
> 
> So for all practical matters, the diff shows the correct thing: "in this 
> hunk, which (still) belongs to that function, change this and this."
> 
> Of course, that is only the case if you accept that the diff should be 
> applied _in total_, not piecewise.  IOW if you are a fan of GNU patch 
> which happily clobbers your file until it fails with the last hunk, you 
> will not be happy.
> 

You're right. GNU patch will apply one hunk and then happily churn on even
if it fails. git-apply will apply all hunks or none, so all hunks can assume
that all previous hunks were successfully applied. So what was your point
again?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
