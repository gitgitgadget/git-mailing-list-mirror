From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Thu, 12 Jun 2008 17:10:36 -0500
Message-ID: <fRW8sBboq1iMWGtwlFUpiDE6HkG2OzTHQ13Xtne_hLyGoZQw04GL7Q@cipher.nrlssc.navy.mil>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <7vzlpqza0t.fsf@gitster.siamese.dyndns.org> <tTKBrUhaELJElLgsC8Wvr60D-bMFtfyvc87q5ZYW35M@cipher.nrlssc.navy.mil> <7vhcbyz5pp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>, Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 00:12:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6v2D-0000m4-Gm
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 00:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbYFLWLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 18:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753693AbYFLWLr
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 18:11:47 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34666 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbYFLWLq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 18:11:46 -0400
Received: by mail.nrlssc.navy.mil id m5CMAaRY031489; Thu, 12 Jun 2008 17:10:37 -0500
In-Reply-To: <7vhcbyz5pp.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 12 Jun 2008 22:10:36.0659 (UTC) FILETIME=[24276430:01C8CCD9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84805>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> The fact that this caveat is not mentioned anywhere in the stash
>> documentation or anywhere in the commit log related to git-stash.sh makes
>> me think that this idea of 'a limited amount of time' was possibly not a
>> design decision but merely a side effect of stashes being implemented using the
>> reflog. Of course I didn't pay any attention to the discussions about stash
>> back when it was implemented, so I may definitely be wrong.
> 
> I do not deeply care either way, but perhaps
> 
>  http://thread.gmane.org/gmane.comp.version-control.git/50737/focus=50863 

Ahh, you reveal that you were not always a supporter of "stash per branch" in
this thread. :)

> and yes use of reflog was more or less conscious thing and the mechanism
> is very much temporary in nature

I see. Thanks for the reference.

> (see the use case stated in the starting
> thread).

Yes, I understand the use case. I am just not convinced that a persistent
stash would be detrimental, but I also do not care deeply.

>> it were true that if I were to create a stash today, and then be surprised 30
>> days from now when I do a 'stash list' and find the stash is still there.
>> Something along the lines of:
>>
>>    $ git stash save my work
>>    # wait 30 days
>>    $ git stash list
>>    stash@{0}: WIP on master: my work
>>
>>    # and if my reaction were something like:
>>    # hmm, that's strange, what is that stash still doing there? It's been 30 days,
>>    # it should be gone.
> 
> We could prune before running "git stash list", but why bother?  The fact
> you can see it is like a bonus.

hmph :)

-brandon
