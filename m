From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: git rev-list ordering
Date: Tue, 18 Nov 2008 12:28:27 -0800
Message-ID: <4923256B.3000807@pcharlan.com>
References: <alpine.LFD.2.00.0811151922310.2935@sys-0.hiltweb.site> <bd6139dc0811151727k605a3575hf409fed32a3a4baf@mail.gmail.com> <alpine.LFD.2.00.0811152040570.2935@sys-0.hiltweb.site> <alpine.DEB.1.00.0811162215370.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Ian Hilt <ian.hilt@gmx.com>, sverre@rabbelier.nl,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 18 21:29:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2XCi-0001Nq-2w
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 21:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbYKRU23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 15:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752605AbYKRU23
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 15:28:29 -0500
Received: from lax-green-bigip-5.dreamhost.com ([208.113.200.5]:44192 "EHLO
	swarthymail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752589AbYKRU22 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Nov 2008 15:28:28 -0500
Received: from [192.168.0.2] (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by swarthymail-a4.g.dreamhost.com (Postfix) with ESMTP id CE7E8129A84;
	Tue, 18 Nov 2008 12:28:27 -0800 (PST)
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
In-Reply-To: <alpine.DEB.1.00.0811162215370.30769@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101284>

Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 15 Nov 2008, Ian Hilt wrote:
> 
>> On Sat, 15 Nov 2008, Sverre Rabbelier wrote:
>>> The --reverse is applied after the --max-count, so you are seeing the 
>>> reverse of one commit ;). For comparison, have a look at:
>>>
>>> $ git rev-list --reverse --max-count=2
>> Ah, I see.  So if you didn't want the sorting to take a long time for 
>> many commits, you would limit the output to n commits, then sort the 
>> output.  Is this the logic behind this design?
> 
> Yes.  It is by design, since the guy who wrote the initial --reverse 
> support cannot think of an interesting situation where you need to list 
> the oldest n commits.

I have a script that runs periodically where I need to know the email
address of who added $file to the system, for a handful of $files,
because I'm moving them somewhere else and want to let them know.  The
most recent commits aren't interesting, it's the first commit that matters.

I use:

  git rev-list --reverse --pretty=format:%ae HEAD -- $file

and the second line has the information I need.

Perhaps there's a more straightforward way to answer the question "who
first put this file here".

(One can imagine that may be no "first", because $file merged from
different paths, but in mine as in many real-world cases, it (a) won't
happen and (b) whatever happens will be fine if it does.)

I don't need this to work differently than it does, but perhaps it
constitutes an "interesting situation where you need to list the oldest
n commits"?

Thank you for your numerous contributions,

--Pete
