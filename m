From: Andreas Ericsson <ae@op5.se>
Subject: Re: Getting correct tree layout when importing svn repo into git
Date: Wed, 17 Sep 2008 08:56:26 +0200
Message-ID: <48D0AA1A.5060209@op5.se>
References: <cfd18e0f0809161505g4c04bd88vaf4fd7c40f67b243@mail.gmail.com>	 <37fcd2780809161620v38d9ade0sc1a2715f79501c6f@mail.gmail.com>	 <c49095e30809161640o21cb89b7x17a9ac1b5b18054f@mail.gmail.com>	 <20080917011816.GL28210@dpotapov.dyndns.org> <c49095e30809162216m5c7885dbibbb022e65f43231c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>, mtk.manpages@gmail.com,
	git@vger.kernel.org, michael.kerrisk@gmail.com
To: Michael Kerrisk <michael.kerrisk@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 08:58:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfqyo-0004vp-KP
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 08:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbYIQG4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 02:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbYIQG4a
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 02:56:30 -0400
Received: from mail.op5.se ([193.201.96.20]:39472 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856AbYIQG4a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 02:56:30 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id BBBA21B80046;
	Wed, 17 Sep 2008 08:46:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.19
X-Spam-Level: 
X-Spam-Status: No, score=-3.19 tagged_above=-10 required=6.6
	tests=[AWL=-0.691, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iLiscVJ05F86; Wed, 17 Sep 2008 08:46:18 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id 28A6D1B80078;
	Wed, 17 Sep 2008 08:46:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <c49095e30809162216m5c7885dbibbb022e65f43231c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96070>

Michael Kerrisk wrote:
> Hi Dimitry,
> 
> On Tue, Sep 16, 2008 at 6:18 PM, Dmitry Potapov <dpotapov@gmail.com> wrote:
>> On Wed, Sep 17, 2008 at 01:40:36AM +0200, Michael Kerrisk wrote:
>>> $ git svn init file:///home/mtk/man-pages-rep/ -t tags -T trunk -b branches
>>>
>>> takes about half an hour to run, the other command (which I already
>>> started yesterday) seems to be taking (far) more than a day!
>> What version of Git do you use?
> 
> 1.5.4.5, on Linux.
> 

An upgrade would do you good.

>> If you use a version earlier than 1.5.6
>> than you can notice *considerable* speed up by upgrading to the latest
> 
> How much is "considerable"?  My import is *still* running.
> 

The greatest factor will usually be network round trip time, so if
this is a one-shot conversion, rsync the repository to somewhere
close and run the import over a local network. I've had some "fun"
trying to import sourceforge svn repositories that were large-ish
but not huge (same seat you're in, basically), but since I get up
to 800ms round trip time from sweden, conversion took forever.

>>
>>> Therefore, so far, I have not had a chance to run the command to
>>> completion to see if it gives the desired result.  The greatly
>>> increased tun time also made me suspicious about whether the command
>>> was going to do the right thing.  And, I end up with a lot of strange
>>> looking tags in the (as yet incompletely) imported tree:
>>>
>>> $ git branch -a
>>>   tags/man-pages-2.00
>>>   tags/man-pages-2.00@117
>>>   tags/man-pages-2.01
>>>   tags/man-pages-2.01@145
>>>   tags/man-pages-2.02
>>>   tags/man-pages-2.02@184
>>>   tags/man-pages-2.03
>>>   tags/man-pages-2.03@232
>>>   tags/man-pages-2.04
>>>   tags/man-pages-2.04@283
>>>
>>> What are the @nnn tags about?
>> I have never encounted them. Are you sure that you import into a clean
>> Git repo?
> 
> Yes.  It's a clean repo in a new directory.
> 

I've seen such tags before. They were added by an automatic build bot
as a marker to say "hey, I just built this".

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
