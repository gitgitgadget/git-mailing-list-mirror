From: David Watson <dwatson@mimvista.com>
Subject: Re: Any way to ignore a change to a tracked file when committing/merging?
Date: Wed, 13 Jun 2007 13:41:42 -0400
Message-ID: <477C424C-009F-46BF-85D4-A0D777FE3CEC@mimvista.com>
References: <A30E217A-084E-4019-949F-5918EAA6368E@mimvista.com> <alpine.LFD.0.99.0706131318390.21061@xanadu.home>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jun 13 20:04:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyXD0-0002Ex-JI
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 20:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759006AbXFMSDs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 14:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758981AbXFMSDs
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 14:03:48 -0400
Received: from net-207-58-228-27.arpa.fidelityaccess.net ([207.58.228.27]:44131
	"EHLO zimbra.mimvista.com" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1758941AbXFMSDr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2007 14:03:47 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.mimvista.com (Postfix) with ESMTP id 65A59521A6;
	Wed, 13 Jun 2007 13:35:27 -0400 (EDT)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from zimbra.mimvista.com ([127.0.0.1])
	by localhost (zimbra.mimvista.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ECoqoh2yoQhN; Wed, 13 Jun 2007 13:35:27 -0400 (EDT)
Received: from [10.0.10.104] (unknown [10.0.10.104])
	by zimbra.mimvista.com (Postfix) with ESMTP id 1AFA2503AD;
	Wed, 13 Jun 2007 13:35:27 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.99.0706131318390.21061@xanadu.home>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50106>

Because git-commit -a is nice to use, especially if I really want to  
check in all the files, *except a particular set that is always the  
same*. Having to specify the files every time gets old pretty quick.

If I could do this:

$ git-commit -a --exclude=somefile

that would be very useful. Or even, if I could set a file in my .git  
folder that would be an exclude list, then I could run something like

$ git-commit -a --use-excludes

I suppose the answer is to create the patch myself. Seems like this  
would also be a useful feature for git-status, git-ls-files (when  
used with --modified), and probably some others that I haven't  
thought of yet.

-Dave Watson

On Jun 13, 2007, at 1:21 PM, Nicolas Pitre wrote:

> On Wed, 13 Jun 2007, David Watson wrote:
>
>> I've got a problem, or maybe annoyance is more the proper term,  
>> that I haven't
>> seen solved by any SCM system (at least not to my knowledge).  
>> Basically, I may
>> make some changes, e.g. to a Makefile or somesuch, that I want to  
>> ignore when
>> looking at what's changed from the repository. The only problem  
>> is, the file
>> I've modified is already under version control, so .gitignore  
>> doesn't do
>> anything.
>>
>> Now, I can commit it, so it will stop bugging me, but then when I  
>> push out it
>> will include that change, unless I back it out. This is a change  
>> that I don't
>> want propagated anywhere else, because it's specific to my machine or
>> development sandbox.
>>
>> Is there any way to do this? I'd really love to use git-commit -a  
>> in this
>> situation, and I could hack up a script to undo my change, run git- 
>> commit -a,
>> and reapply the change, but makes me a bit squirmy. If I could put  
>> something
>> in a .git config file to say "commit 237ab should not be  
>> propagated under any
>> circumstances", that would be fantastic.
>
> Why don't you just use git-commit _without_ -a ?
>
> The whole purpose behind not specifying -a with git-commit is exactly
> for your usage example.
>
>
> Nicolas
