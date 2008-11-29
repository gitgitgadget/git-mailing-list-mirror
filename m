From: Andreas Ericsson <ae@op5.se>
Subject: Re: C# Git Implementation
Date: Sat, 29 Nov 2008 14:44:33 +0100
Message-ID: <49314741.9090005@op5.se>
References: <001501c9515e$66e8ac70$34ba0550$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: JD Guzman <jd@jdguzman.com>
X-From: git-owner@vger.kernel.org Sat Nov 29 14:46:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6Q8x-0004D2-D9
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 14:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbYK2Noj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 08:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbYK2Noj
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 08:44:39 -0500
Received: from mail.op5.se ([193.201.96.20]:58738 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751275AbYK2Noi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 08:44:38 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 059401B80FAE;
	Sat, 29 Nov 2008 14:40:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IRkrjHKXor0V; Sat, 29 Nov 2008 14:40:42 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id 5FDA01B8008E;
	Sat, 29 Nov 2008 14:40:41 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
In-Reply-To: <001501c9515e$66e8ac70$34ba0550$@com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101913>

JD Guzman wrote:
> Hello I am new to the list and if I am not following some kind of list
> ettiquite please let me know. 
> 
> I read in the archives that there was once talk of porting Git over to C#
> and was wondering if anything ever came of this?

That depends. I think it's happened at least on three different occasions
that someone wants to port git to C#. The latest is the attempt to write a
libified git (in C) that will be DllImport()'ed from C#, which the devs at
MonoDevelop were sort of interested in. I'm currently working (very slowly)
on libgit2, and it's nowhere near usable today.

>  I realize there were some
> that didn't see the use for this but as Git is becoming more and more
> popular a more native implementation of Git for windows users would be a
> good endevour IMHO.
> 

Truly. However, a better way forward is to create a portable git library
that any old application can use, no matter what language the application
is written in. That way, GUI-hackers can add all the bells and whistles
they like.

Besides that, msysgit works very well on Windows.

> At any rate any info would be greatly appreciated.
> 

libgit2 is available from
http://www.spearce.org/projects/scm/libgit2/libgit2.git
git://git.op5.org/git/libgit2.git

The first URL belongs to Shawn O. Pearce, the initiator of the libgit2
project. The second one is where I stash random stuff that I work on.
Note that git.op5.org is subject to heavy rebasing at the moment, as I'm
basically using it as a patch queue for Shawn (and everyone else who's
interested) to look at when they feel like it. It's not yet interesting
enough to warrant sending everything as patches to git@vger, but a small
bunch of people are helping making the small internal API's reliably
portable (filesystem operations, thread-local error handling) so that
we can nail them down hard to prevent having to change them (and their
hundreds of callers) in the future.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
