From: Andreas Ericsson <ae@op5.se>
Subject: Re: git guidance
Date: Fri, 07 Dec 2007 09:40:23 +0100
Message-ID: <475906F7.5010309@op5.se>
References: <20071129105220.v40i22q4gw4cgoso@intranet.digizenstudio.com> <200712072155.04643.a1426z@gawab.com> <Pine.LNX.4.64.0712062119090.21625@wbgn129.biozentrum.uni-wuerzburg.de> <200712070737.18519.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Susi <psusi@cfl.rr.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jing Xue <jingxue@digizenstudio.com>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Al Boldi <a1426z@gawab.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 09:41:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0YlO-0003WN-IH
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 09:40:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbXLGIk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 03:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbXLGIk3
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 03:40:29 -0500
Received: from mail.op5.se ([193.201.96.20]:38180 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149AbXLGIk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 03:40:28 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 34EC21F080AB;
	Fri,  7 Dec 2007 09:40:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ZXv94WOlffp; Fri,  7 Dec 2007 09:40:25 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 7BD141F08098;
	Fri,  7 Dec 2007 09:40:24 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <200712070737.18519.a1426z@gawab.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67400>

Al Boldi wrote:
> Johannes Schindelin wrote:
>> Hi,
> 
> Hi
> 
>> On Fri, 7 Dec 2007, Al Boldi wrote:
>>> You need to re-read the thread.
>> I don't know why you write that, and then say thanks.  Clearly, what you
>> wrote originally, and what Andreas pointed out, were quite obvious
>> indicators that git already does what you suggest.
>>
>> You _do_ work "transparently" (whatever you understand by that overused
>> term) in the working directory, unimpeded by git.
> 
> If you go back in the thread, you may find a link to a gitfs client that 
> somebody kindly posted.  This client pretty much defines the transparency 
> I'm talking about.  The only problem is that it's read-only.
> 
> To make it really useful, it has to support versioning locally, disconnected 
> from the server repository.  One way to implement this, could be by 
> committing every update unconditionally to an on-the-fly created git 
> repository private to the gitfs client.
> 

Earlier you said that you need to be able to tell git when you want to make
a commit, which means pretty much any old filesystem could serve as gitfs.
Now you're saying you want every single update to be committed, which would
make it mimic an editor's undo functionality. I still don't get what it is
you really want.

> With this transparently created private scratch repository it should then be 
> possible for the same gitfs to re-expose the locally created commits, all 
> without any direct user-intervention.
> 
> Later, this same scratch repository could then be managed by the normal 
> git-management tools/commands to ultimately update the backend git 
> repositories.
> 

That's exactly what's happening today. I imagine whoever wrote the gitfs
thing did so to facilitate testing, or as some form of intellectual
masturbation.


So, to get to the bottom of this, which of the following workflows is it you
want git to support?

### WORKFLOW A ###
edit, edit, edit
edit, edit, edit
edit, edit, edit
Oops I made a mistake and need to hop back to "current - 12".
edit, edit, edit
edit, edit, edit
publish everything, similar to just tarring up your workdir and sending out
### END WORKFLOW A ###

### WORKFLOW B ###
edit, edit, edit
ok this looks good, I want to save a checkpoint here
edit, edit, edit
looks good again. next checkpoint
edit, edit, edit
oh crap, back to checkpoint 2
edit, edit, edit
ooh, that's better. save a checkpoint and publish those checkpoints
### END WORKFLOW B ###

If you could just answer that question and stop writing "transparent" or
any synonym thereof six times in each email, we can possibly help you.

As it stands now though, nobody is very interested because you haven't
explained how you want this "transparency" of yours to work in an every
day scenario.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
