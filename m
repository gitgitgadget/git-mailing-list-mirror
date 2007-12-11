From: Andreas Ericsson <ae@op5.se>
Subject: Re: Something is broken in repack
Date: Tue, 11 Dec 2007 21:26:35 +0100
Message-ID: <475EF27B.7060609@op5.se>
References: <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com> <alpine.LFD.0.9999.0712110806540.25032@woody.linux-foundation.org> <alpine.LFD.0.99999.0712111202470.555@xanadu.home> <20071211.092402.266823343.davem@davemloft.net> <alpine.LFD.0.99999.0712111237530.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Miller <davem@davemloft.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	jonsmirl@gmail.com, Junio C Hamano <gitster@pobox.com>,
	gcc@gcc.gnu.org, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 21:27:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Bh3-0005GE-Cu
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 21:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303AbXLKU0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 15:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752360AbXLKU0k
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 15:26:40 -0500
Received: from mail.op5.se ([193.201.96.20]:54743 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752257AbXLKU0j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 15:26:39 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id DBDE41F08040;
	Tue, 11 Dec 2007 21:26:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.449
X-Spam-Level: 
X-Spam-Status: No, score=-3.449 tagged_above=-10 required=6.6
	tests=[AWL=-0.950, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z+oaq7P-oa9k; Tue, 11 Dec 2007 21:26:37 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id AD7CC1F08039;
	Tue, 11 Dec 2007 21:26:36 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <alpine.LFD.0.99999.0712111237530.555@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67931>

Nicolas Pitre wrote:
> On Tue, 11 Dec 2007, David Miller wrote:
> 
>> From: Nicolas Pitre <nico@cam.org>
>> Date: Tue, 11 Dec 2007 12:21:11 -0500 (EST)
>>
>>> BUT.  The point is that repacking the gcc repo using "git repack -a -f 
>>> --window=250" has a radically different memory usage profile whether you 
>>> do the repack on the earlier 2.1GB pack or the later 300MB pack.  
>> If you repack on the smaller pack file, git has to expand more stuff
>> internally in order to search the deltas, whereas with the larger pack
>> file I bet git has to less often undelta'ify to get base objects blobs
>> for delta search.
> 
> Of course.  I came to that conclusion two days ago.  And despite being 
> pretty familiar with the involved code (I wrote part of it myself) I 
> just can't spot anything wrong with it so far.
> 
> But somehow the threading code keep distracting people from that issue 
> since it gets to do the same work whether or not the source pack is 
> densely packed or not.
> 
> Nicolas 
> (who wish he had access to a much faster machine to investigate this issue)

If it's still an issue next week, we'll have a 16 core (8 dual-core cpu's)
machine with some 32gb of ram in that'll be free for about two days.
You'll have to remind me about it though, as I've got a lot on my mind
these days.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
