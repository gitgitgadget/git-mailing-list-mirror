From: David Watson <dwatson@mimvista.com>
Subject: Re: Any way to ignore a change to a tracked file when committing/merging?
Date: Wed, 13 Jun 2007 14:09:24 -0400
Message-ID: <6D50717E-7FB2-48EE-9B56-42B658ACAD10@mimvista.com>
References: <A30E217A-084E-4019-949F-5918EAA6368E@mimvista.com> <alpine.LFD.0.99.0706131318390.21061@xanadu.home> <477C424C-009F-46BF-85D4-A0D777FE3CEC@mimvista.com> <alpine.LFD.0.99.0706131349430.1697@xanadu.home>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jun 13 20:25:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1HyXX2-0004bt-4U
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 20:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759653AbXFMSJz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 14:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758641AbXFMSJz
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 14:09:55 -0400
Received: from net-207-58-228-27.arpa.fidelityaccess.net ([207.58.228.27]:47775
	"EHLO zimbra.mimvista.com" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1759639AbXFMSJw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2007 14:09:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.mimvista.com (Postfix) with ESMTP id 5092752223;
	Wed, 13 Jun 2007 14:03:09 -0400 (EDT)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from zimbra.mimvista.com ([127.0.0.1])
	by localhost (zimbra.mimvista.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JmDZZCmgd8mD; Wed, 13 Jun 2007 14:03:09 -0400 (EDT)
Received: from [10.0.10.104] (unknown [10.0.10.104])
	by zimbra.mimvista.com (Postfix) with ESMTP id 0A5D2520ED;
	Wed, 13 Jun 2007 14:03:09 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.99.0706131349430.1697@xanadu.home>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50107>

It appears that only applies to untracked files. I am specifically  
interested in ignoring changes to files that are already tracked,  
unless I'm misunderstanding what you're suggesting. I just built the  
most recent git from repo.or.cz/git, and did the following:

* edit the file I want to "ignore"
git-status shows this file as modified

* edit .git/config, set core.excludesfile to myexcludes, containing  
the name of the file I want
* git add -u
* git-status
shows the file I edited as ready to be committed.

Dave Watson

On Jun 13, 2007, at 1:54 PM, Nicolas Pitre wrote:

> On Wed, 13 Jun 2007, David Watson wrote:
>
>> Because git-commit -a is nice to use, especially if I really want  
>> to check in
>> all the files, *except a particular set that is always the same*.  
>> Having to
>> specify the files every time gets old pretty quick.
>>
>> If I could do this:
>>
>> $ git-commit -a --exclude=somefile
>>
>> that would be very useful. Or even, if I could set a file in  
>> my .git folder
>> that would be an exclude list, then I could run something like
>>
>> $ git-commit -a --use-excludes
>>
>> I suppose the answer is to create the patch myself.
>
> Well, before that I'd suggest you have a look at the git-add man page,
> especially the -u flag and the core.excludesfile config option.
>
>
> Nicolas
