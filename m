From: Andreas Ericsson <ae@op5.se>
Subject: Re: How to remove a specific hunk
Date: Fri, 26 Oct 2007 17:28:42 +0200
Message-ID: <472207AA.8030100@op5.se>
References: <4722036E.5030204@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pascal Obry <pascal.obry@wanadoo.fr>
X-From: git-owner@vger.kernel.org Fri Oct 26 17:29:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlR7K-0001Om-MQ
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 17:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534AbXJZP2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 11:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753584AbXJZP2q
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 11:28:46 -0400
Received: from mail.op5.se ([193.201.96.20]:53092 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752910AbXJZP2q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 11:28:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id EDBB1173070D;
	Fri, 26 Oct 2007 17:28:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OUeryo9OYnbs; Fri, 26 Oct 2007 17:28:26 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 836D317306F3;
	Fri, 26 Oct 2007 17:28:26 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <4722036E.5030204@wanadoo.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62418>

Pascal Obry wrote:
> Hello,
> 
> I'm very new to Git... but start to love it :)
> 
> Before committing sometimes I want to remove a specific hunk. Say in
> file a.txt I have in the diff 3 hunks, I want to revert/delete/remove
> the second one. Is there a way to do that ?
> 
> I understand that I can git add interactive and select the hook I want
> to commit, but this is not fully equivalent. I'm not yet ready to commit
> I just want to undo a specific change and test the code without it...
> 
> Any idea ?
> 

Once you've added the other two hunks, they'll no longer show up in
git-diff, so you can do something like this:

$ git-add -i; # add the other two hunks to commit
$ git-diff > middle-hunk.patch
$ git-apply -R middle-hunk.patch
test, test, test
$ git-apply middle-hunk.patch

Completely untested, so take a copy before you try it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
