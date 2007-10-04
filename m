From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git-init: don't base core.filemode on the ability to
 chmod.
Date: Thu, 04 Oct 2007 08:05:22 +0200
Message-ID: <470482A2.3080907@op5.se>
References: <20071003105501.GD7085@admingilde.org> <470388DC.4040504@viscovery.net> <20071003231941.GA20800@admingilde.org> <Pine.LNX.4.64.0710040053380.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 04 08:06:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdJq3-0003Kx-8A
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 08:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264AbXJDGF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 02:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752792AbXJDGF0
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 02:05:26 -0400
Received: from mail.op5.se ([193.201.96.20]:38427 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753035AbXJDGFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 02:05:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 0617C194421;
	Thu,  4 Oct 2007 08:05:24 +0200 (CEST)
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JmsPZp7GBtgL; Thu,  4 Oct 2007 08:05:23 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 8FDF91943B0;
	Thu,  4 Oct 2007 08:05:23 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <Pine.LNX.4.64.0710040053380.28395@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59920>

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 4 Oct 2007, Martin Waitz wrote:
> 
>> -		filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
>> +		/* test that new files are not created with X bit */
>> +		filemode = !(st1.st_mode & S_IXUSR);
>> +		/* test that we can modify the X bit */
>> +		filemode &= (!chmod(path, st1.st_mode ^ S_IXUSR) &&
> 
> Should that not be &&=?
> 

I should think |=

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
