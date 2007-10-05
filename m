From: Andreas Ericsson <ae@op5.se>
Subject: Re: Question about "git commit -a"
Date: Fri, 05 Oct 2007 14:23:51 +0200
Message-ID: <47062CD7.70400@op5.se>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com>	 <545CB3B2-96B3-4853-9397-B42F4F268A15@wincent.com>	 <fcaeb9bf0710041333l636b2c1fn4d8f3298000127c7@mail.gmail.com>	 <Pine.LNX.4.64.0710042209410.4174@racer.site>	 <4d8e3fd30710050139j45a5a924t5c048994e3457c5f@mail.gmail.com>	 <4705FB52.3030208@op5.se>	 <4d8e3fd30710050206h7a177472x7c92f91204b15aa4@mail.gmail.com>	 <47060BB3.3030208@op5.se> <4d8e3fd30710050519k7a3db02dk5ba9750fd8e9705f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 14:24:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdmE2-0002Sx-7L
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 14:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755484AbXJEMYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 08:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754537AbXJEMYD
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 08:24:03 -0400
Received: from mail.op5.se ([193.201.96.20]:36872 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753234AbXJEMYB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 08:24:01 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 13567194449;
	Fri,  5 Oct 2007 14:24:00 +0200 (CEST)
X-Spam-Score: -4.224
X-Spam-Level: 
X-Spam-Status: No, score=-4.224 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.175, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FtmbKrwrMoCr; Fri,  5 Oct 2007 14:23:54 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id C312F194447;
	Fri,  5 Oct 2007 14:23:53 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <4d8e3fd30710050519k7a3db02dk5ba9750fd8e9705f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60075>

Paolo Ciarrocchi wrote:
> On 10/5/07, Andreas Ericsson <ae@op5.se> wrote:
> [...]
>> As for the "git commit should default to -a" discussion, I think it's pretty
>> clear where I stand ;-)
> 
> Fair enough.
> 
> Another try to have an easy explanation of how the staging area works:
> 
> paolo@paolo-desktop:~/HowIndexWorks$ ls
> A  B  C  D  E  F  G
> 
> Now I edit A,B,C,D and E:
> 
> $ echo A >> A
> $ echo B >> B
> $ echo C >> C
> $ echo D >> D
> $ echo E >> E
> 
> I now realize want to only commit the changes I did to A,B,C,D.
> First step is to place A,B,C and D into the staging area:
> $ git add A B C D
> 
> Now I can commit:
> $ git commitpaolo@paolo-desktop:~/HowIndexWorks$ git commit
> Created commit 16032dc: I modified A,B,C and D
>  4 files changed, 4 insertions(+), 0 deletions(-)
> 
> It's now time to work on F and G:
> $ echo F >> F
> $ echo G >> G
> 
> Current status is:
> paolo@paolo-desktop:~/HowIndexWorks$ git status
> # On branch master
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #
> #       modified:   E
> #       modified:   F
> #       modified:   G
> 
> Instead of adding E,F and G to the staging are and then commit them in
> two steps I can using a single command:
> $ git commit E F G (in this case it's equivalent to git commit -a)
> 

He. It's like comparing a duracell battery to the sun, but yes, that's
one of the operations where the index is involved. But after doing your
git-add thing above, you could also have continued hacking on A B C D,
and git would only have committed the state where you did "git add".
When you stop to think about this, you'll realize that it's a really
powerful thing, as it lets you keep on hacking even when you don't
really know where you'll end up.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
