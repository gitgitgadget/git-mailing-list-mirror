From: David Kastrup <dak@gnu.org>
Subject: Re: Can I have this, pretty please?
Date: Sun, 12 Aug 2007 21:29:46 +0200
Message-ID: <854pj4o8k5.fsf@lola.goethe.zz>
References: <85ir7kq42k.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708121135050.30176@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708121140190.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 21:29:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKJ8K-0003oD-AG
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 21:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935172AbXHLT3t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 15:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934116AbXHLT3t
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 15:29:49 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:53808 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933958AbXHLT3s (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 15:29:48 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 304A56DB62;
	Sun, 12 Aug 2007 21:29:47 +0200 (CEST)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id 190D62DAB45;
	Sun, 12 Aug 2007 21:29:47 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-036-190.pools.arcor-ip.net [84.61.36.190])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id BF0C813C8D;
	Sun, 12 Aug 2007 21:29:46 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 3E0F81C3C79D; Sun, 12 Aug 2007 21:29:46 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0708121140190.30176@woody.linux-foundation.org> (Linus Torvalds's message of "Sun\, 12 Aug 2007 11\:48\:57 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3936/Sun Aug 12 17:10:09 2007 on mail-in-11.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55707>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 12 Aug 2007, Linus Torvalds wrote:
>> 
>> A newsreader is mis-designed for all the same reasons SVN is misdesigned: 
>> it sees the messages (commits) as a _tree_.
>
> Side note: the lack of this bug is what makes showing large
> histories graphically be expensive in the first place.

Not really.

dak@lola:/home/tmp/emacs$ time git-rev-list --parents --topo-order --all>/dev/null

real    0m9.042s
user    0m8.801s
sys     0m0.168s

This does not even start to _think_ of swapping.

> So even if you don't want to show the graph itself (and just add
> references to allow the user to walk to parents/children manually),
> you'd still have to calculate - and keep track of - the commit
> relationships.  And I suspect that's what makes gitk and other
> visualizers take time.

It does not bother git-rev-list.  What takes them time is that they
are simply not written with insane amounts of data in mind.

And newsreaders are.

> IOW, showing the whole history for a big project is simply pretty
> expensive. If you have a hundred thousand commits, just keeping
> track of the tree structure *is* going to take megabytes and
> megabytes of data.  Limiting the size of the problem is usually a
> really good solution, especially since most people tend to care
> about what happened in the last few days, not what happened five
> months ago.

And newsreaders, for that reason, have a set of strategies for
limiting the size of the problem (and changing the limits on the fly
as needed) as well as being efficient with handling it.  They have to
be _good_ at dealing with that amount of data, or they would have
fallen by the wayside.

As opposed to gitk and other visualization tools, newsreaders usually
have fast and convenient keyboard navigation and an article window
where serious amounts of text can be viewed with readable fonts.

If you try selecting a more readable font for gitk, you are limited to
selecting between fonts called something starting with the letters "a"
to "c" since the font menu runs off the screen after that.

I find that I can't get much use out of gitweb: like webmail, it is
simply too little hands-on for getting at the right stuff efficiently:
it is all too point and clicky instead direct keyboard access.

So at least for my preferred human-computer interface style, an
NNTP-browsable repository would come quite handy.  I'll probably fudge
something in Gnus (which has the advantage that I _can_ create more
direct links to files and trees), but I doubt that the usefulness of
the concept would not stretch to actual servers.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
