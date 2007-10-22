From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git-format-patch: Don't number patches when there's only
 one
Date: Mon, 22 Oct 2007 12:14:08 +0200
Message-ID: <471C77F0.5050701@op5.se>
References: <20071021144637.762085BB92@nox.op5.se> <Pine.LNX.4.64.0710221044080.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 12:14:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjuIj-0000od-Ui
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 12:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbXJVKON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 06:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbXJVKON
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 06:14:13 -0400
Received: from mail.op5.se ([193.201.96.20]:58938 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbXJVKOM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 06:14:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 5041F17305A7;
	Mon, 22 Oct 2007 12:14:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.438
X-Spam-Level: 
X-Spam-Status: No, score=-2.438 tagged_above=-10 required=6.6
	tests=[AWL=0.062, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s8BIXBeAPaiC; Mon, 22 Oct 2007 12:14:09 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 1A3F317305A5;
	Mon, 22 Oct 2007 12:14:08 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <Pine.LNX.4.64.0710221044080.25221@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61978>

Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 21 Oct 2007, Andreas Ericsson wrote:
> 
>> [PATCH 1/1] looks a bit silly, and automagically handling this in 
>> git-format-patch makes some scripting around it a lot more pleasant.
> 
> I think you should not use "-n" if you do not want to have the numbers.  

This stems from creating scripts around it where I only want to see the 
numbers if there is more than a single patch. Currently I can't do that 
without running git-format-patch twice or re-implementing the revision 
parsing machinery to count revisions prior to passing arguments to 
format-patch.

> In circumstances as yours, where you can have patch series larger than 
> one, I imagine that the "[PATCH 1/1]" bears an important information, 
> which is not present in "[PATCH]": this patch series contains only one 
> patch.
> 

That's sort of implicit in [PATCH], since all patch-series added by the 
tool I'm scripting will have [PATCH n/m], while I'd prefer for 
single-patches to have only [PATCH].

> IOW I do not like your patch: too much DWIDNS (Do What I Did NOT Say) for 
> me.
> 

Would a separate option be acceptable to you?

It doesn't have to be fancy or short, since I really only mean to use it 
from our scripts.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
