From: Andreas Ericsson <ae@op5.se>
Subject: Re: Question about "git commit -a"
Date: Fri, 05 Oct 2007 10:52:34 +0200
Message-ID: <4705FB52.3030208@op5.se>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com>	 <545CB3B2-96B3-4853-9397-B42F4F268A15@wincent.com>	 <fcaeb9bf0710041333l636b2c1fn4d8f3298000127c7@mail.gmail.com>	 <Pine.LNX.4.64.0710042209410.4174@racer.site> <4d8e3fd30710050139j45a5a924t5c048994e3457c5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 10:53:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdivV-0000od-5v
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 10:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928AbXJEIwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 04:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753856AbXJEIwn
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 04:52:43 -0400
Received: from mail.op5.se ([193.201.96.20]:58322 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753787AbXJEIwm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 04:52:42 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 7E004194014;
	Fri,  5 Oct 2007 10:52:40 +0200 (CEST)
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3VniTBQ88ojh; Fri,  5 Oct 2007 10:52:35 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 6078A194357;
	Fri,  5 Oct 2007 10:52:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <4d8e3fd30710050139j45a5a924t5c048994e3457c5f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60054>

Paolo Ciarrocchi wrote:
> On 10/4/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> Hi,
>>
>> On Fri, 5 Oct 2007, Nguyen Thai Ngoc Duy wrote:
>>
>>> On 10/4/07, Wincent Colaiuta <win@wincent.com> wrote:
>>>>> Am I wrong?
>>>> About it being a majority, yes, I suspect so.
>>>>
>>> Maybe in the next survey we should include question "do you usually do
>>> 'git commit' or 'git commit -a'" :-)
>> Not meaning to discourage you, but it is a known fact that Linus does "git
>> commit" without "-a" quite often.
>>
>> And if that were not bad enough for your plan, I myself omit "-a"
>> regularly.  So you would get a veto from me, too.
> 
> So you are used to do something like (please correct me if I'm wrong):
> - modify A
> - modify B
> - modify C
> - modify D
> - modify E
> 
> $ git A B E


This isn't really a valid command. I'm not sure where you got it from.

> $ git add A B E (A, B and E are now in the staging area)
> $ git commit -m "I just modified A,B and E"

I do something like that, except that for full-file commits I'd rather
say

	git commit -s A B E

I never pass -m to git commit. It's too easy to get into habit of being
sloppy with historic documentation that way.

> $ git C D

Again not a valid command, but...

> $ git add C D (C and D are now in the staging area)
> $ git commit -m "I just modified C and D"
> 

See above :)

There's also the times when I hack on some feature and find some small
bug/easy-to-write-feature, so I make the change for that other thing,
swap to a different branch and do 'git commit -s --interactive' to
just break out that small fix.

Or if I have to add some logic to some other function in a file I've
modified for other purposes and want it to be two separate commits,
I just make the change and then run 'git commit --interactive' to
make it two separate commits.

I just don't do 'git commit -a' for the same reason I don't do
'git commit -m', really. It tends to be habit-forming, and bisect
has saved my arse enough times for me to *want* my changes to be
small and isolated. Debugging a 5-line patch is so much more pleasant
than debugging a 30k-lines one that spans over several different files.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
