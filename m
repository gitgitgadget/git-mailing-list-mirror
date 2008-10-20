From: Andreas Ericsson <ae@op5.se>
Subject: Re: Feedback outside of the user survey
Date: Mon, 20 Oct 2008 11:57:13 +0200
Message-ID: <48FC55F9.3060509@op5.se>
References: <2d460de70810160319r4bed8643g884508cdeba772@mail.gmail.com> <20081016115628.GA24836@garry-x300.arpnetworks.com> <2d460de70810160618u1803375aj913145a5060e5308@mail.gmail.com> <48F7A4F8.2080600@jaeger.mine.nu> <20081018134906.GA13894@garry-thinkpad.arpnetworks.com> <48F9EC2B.2010200@jaeger.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Garry Dolley <gdolley@arpnetworks.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	git@vger.kernel.org
To: Christian Jaeger <christian@jaeger.mine.nu>
X-From: git-owner@vger.kernel.org Mon Oct 20 16:40:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrrWy-0005Fm-BQ
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 11:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbYJTJ5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 05:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbYJTJ5T
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 05:57:19 -0400
Received: from mail.op5.se ([193.201.96.20]:43951 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953AbYJTJ5T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 05:57:19 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 6D0A824B10E0;
	Mon, 20 Oct 2008 11:50:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.842
X-Spam-Level: 
X-Spam-Status: No, score=-3.842 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.557, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UlmN1aww35tB; Mon, 20 Oct 2008 11:50:41 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 84AF01B8036C;
	Mon, 20 Oct 2008 11:50:40 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <48F9EC2B.2010200@jaeger.mine.nu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98669>

Christian Jaeger wrote:
> Garry Dolley wrote:
>> On Thu, Oct 16, 2008 at 10:32:56PM +0200, Christian Jaeger wrote:
>>  
>>> Hm, I don't see a fundamental technical problem which would prevent 
>>> one from implementing the ability to checkout only a subdirectory 
>>> into the working directory (i.e. to add options to Git to make it 
>>> reflect the working directory as being a subdirectory of what is in 
>>> Git's database). At this level I don't see anything inherently 
>>> different from SVN--except maybe for directory renames: if someone 
>>> else is renaming the directory you've checked out, what should 
>>> happend with your checkout? Git's filebased rename tracking would 
>>> just lead to everything vanishing from your checkout. I don't know 
>>> what happens in SVN, maybe it keeps track of the directory rename and 
>>> still sends you the changes of the directory you've checked out even 
>>> if it has now a different name on the server?
>>>
>>> Anyway, an unavoidable difference is that you have to always clone 
>>> the whole Git *database*. With SVN the database stays on the server, 
>>> with Git it is being cloned. Just as I expect SVN to need the whole 
>>> database to be [...]
>>>     
>>
>> Right, but I think cloning the entire git database just to get a
>> subdir is a fundamental technical problem.  It's no different than
>> git-clone + checkout + rm -rf <what I don't want in working tree>
>>   
> 
> We're in "violent agreement" here.
> 
>> In that sense, git already has support for cloning subdirectories,
>> which is why I don't think this method applies to what the original
>> post author meant when they referred to "support for cloning sub
>> directories".
>>   
> 
> I just think it's worth pointing out the difference between the working 
> dir and the database. It should be as easy to implement checking out 
> subdirectories in Git as it was in SVN (except, again, that, iff 
> directory renames should be tracked, some code would have to be written 
> to find out about directory renames, which SVN solves in a simpler way 
> by just requiring that the user specifies renames explicitely). It's 
> worth pointing out that working directory checkouts and database cloning 
> are separate operatoins and it's only the database cloning which is, per 
> definition (as it is a distributed VCS) different from SVN.
> 
>> :)
>>   
> 
> If you really wanted, I suppose you could additionally look into 
> implementing a kind of shallow cloning that only copies objects over the 
> wire which are necessary for representing the subdirectory you're 
> interested in.
> 

So what do you do when one such commit also affects something outside
the subdirectory?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
