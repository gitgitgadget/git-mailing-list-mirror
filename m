From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: 'git diff' in rebase--interactive
Date: Tue, 09 Oct 2007 14:35:13 +0200
Message-ID: <470B7581.3030301@viscovery.net>
References: <470B410F.1040506@viscovery.net> <Pine.LNX.4.64.0710091319400.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 09 14:35:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfEJ5-0000w9-Ey
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 14:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbXJIMfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 08:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbXJIMfQ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 08:35:16 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:12066 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbXJIMfP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 08:35:15 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IfEIl-0003Zs-CE; Tue, 09 Oct 2007 14:35:07 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7B3DA69F; Tue,  9 Oct 2007 14:35:13 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0710091319400.4174@racer.site>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60391>

Johannes Schindelin schrieb:
> On Tue, 9 Oct 2007, Johannes Sixt wrote:
> 
>> I wonder for what reason rebase--interactive generates a patch using 
>> 'git diff' in the make_patch function. Is this an artefact?
> 
> It was an explicit request by people who use git-rebase regularly, and 
> missed being able to see the patch in --interactive.

Can we generate the patch with plumbing, diff-{files,index,tree}? They 
by-pass any diff drivers.

>> I'd like to get rid of this use of 'git diff' because it invokes 
>> external diff drivers, which is totally unwanted if the driver is 
>> interactive - like the 'windiff' thing that I posted a week ago.
> 
> So you do not want to be able to run git-rebase (without -i)?

It wouldn't work anyway in my use-case (versioned Word documents), but 
rebase -m and rebase -i could run without manual intervention as long as 
there are no content merges.

In this particular case, I only wanted to amend the message of a commit 3 
steps down in the history, and I had not expected any diff drivers to be 
fired up.

-- Hannes
