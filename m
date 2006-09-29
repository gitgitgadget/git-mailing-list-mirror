From: Andreas Ericsson <ae@op5.se>
Subject: Re: git and time
Date: Fri, 29 Sep 2006 10:16:35 +0200
Message-ID: <451CD663.8020806@op5.se>
References: <20060928194316.42986.qmail@web51004.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Rogan Dawes <discard@dawes.za.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 10:16:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTDY2-00068L-Oe
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 10:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWI2IQj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 04:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030316AbWI2IQj
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 04:16:39 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:15268 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030320AbWI2IQi
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Sep 2006 04:16:38 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 1594B6BD75; Fri, 29 Sep 2006 10:16:37 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 9ECB66BD11; Fri, 29 Sep 2006 10:16:35 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Matthew L Foster <mfoster167@yahoo.com>
In-Reply-To: <20060928194316.42986.qmail@web51004.mail.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28103>

Matthew L Foster wrote:
> --- Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
>> On Thu, 28 Sep 2006, Matthew L Foster wrote:
>>
>>> It should be possible to export git data, through say a web interface, 
>>> in a such a way that local time order is consistent with commit order.
>> Why?
> 
> - So exported data is never/rarely in an inconsistent state with respect to commit order and local
> time order (data integrity).
> 

Moot point (it has been iterated so many times that I can't be asked to 
repeat it again).

> - To encourage people to care about/prefer local commit time rather than remote creation/emailed
> time
> 

Most people use ntp, and are in general concerned with keeping their 
clocks in sync as lots of other software depend on it (calender 
functions, fe). It shouldn't be the task of project leaders to make sure 
that the ~50000 random people around the world that submit patches to 
opensource projects every day all have their clocks in sync.

> - So people that user repo X, or binaries from repo X, know when bug fix Y/fancy new feature Z was
> committed/merged locally
> 

Can be done using reflog. Feel free to submit patches. Make sure you 
sync your clock to whatever ntp-server or other timekeeping mechanism 
Junio uses before you commit and send your patch though. ;-)

> - In many situations "history" is incomplete without local commit time. If a company has a new
> driver they would probably prefer to know when the main kernel repo has it, not when they
> created/emailed it or when a remote repo committed it.
> 

See the reflog response and, again, feel free to submit patches.

To get you started, I think the easiest way would be to teach gitweb 
about the reflog, and then insert a line saying
"--- pushed to this repo $date ---"
or something like that in the summary page whenever a commit is found 
that is also in the reflog. This should also be fairly CPU efficient if 
my guesses on how gitweb and the reflog works are correct. CBA to check, 
since I sincerely and whole-heartedly don't care about it myself.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
