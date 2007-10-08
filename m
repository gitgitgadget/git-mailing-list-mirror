From: Andreas Ericsson <ae@op5.se>
Subject: Re: Trying to use git-filter-branch to compress history by removing
 large, obsolete binary files
Date: Mon, 08 Oct 2007 11:23:27 +0200
Message-ID: <4709F70F.4040700@op5.se>
References: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com> <20071007213817.GJ31659@planck.djpig.de> <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com> <20071007221920.GF2765@steel.home> <51419b2c0710071524q16e9c593s2722dffc826e560d@mail.gmail.com> <20071007234039.GH2765@steel.home> <51419b2c0710071709s2f797df0u986447f5455f306d@mail.gmail.com> <20071008061511.GA2859@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Elijah Newren <newren@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 11:23:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ieoq4-0008CF-1d
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 11:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389AbXJHJXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 05:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752265AbXJHJXi
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 05:23:38 -0400
Received: from mail.op5.se ([193.201.96.20]:54117 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752117AbXJHJXh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 05:23:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id DB2EC173064E;
	Mon,  8 Oct 2007 11:22:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ve-oktEfTtk7; Mon,  8 Oct 2007 11:22:39 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 7CB391730569;
	Mon,  8 Oct 2007 11:22:39 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071008061511.GA2859@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60308>

Alex Riesen wrote:
> Elijah Newren, Mon, Oct 08, 2007 02:09:50 +0200:
>> On 10/7/07, Alex Riesen <raa.lkml@gmail.com> wrote:
>>> you missed something. Your example compresses to about 124k.
>> What version of git are you running?  I reran all the steps to which
> 
> git version 1.5.3.4.225.g31b973 (irrelevant custom modifications)
> 
>> you responded (repeated below for clarity) with git-1.5.3.3 and still
>> get 11MB.  Also, you must have different filesystem extents than me
>> since an empty git repo takes 196k here[1], so I don't think any repo
>> is going to get down to 124k.
> 
> it is ext3. I do not install the hooks (~8k apparent, ~32k fs blocks)
> and never activate logs by default.
> 
>> # Use vi to remove the line referring to refs/original...
>> git reflog expire --all
> 
> another part of the suggestion re reflogs was to look into the logs,
> to check if expire actually removed anything. It seems to have been
> the culprit.
> 

On my system, running git version 1.5.3.3.131.g34c6d,

	git reflog expire --all

does absolutely nothing.

	git reflog expire --expire=0 --all

truncates all the reflogs. I'm not sure if this is intended or not.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
