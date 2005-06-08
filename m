From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: [PATCH] Many new features for cg-diff and cg-log
Date: Wed, 08 Jun 2005 23:03:24 +0200
Message-ID: <42A75D1C.1060102@gmail.com>
References: <20050608144632.A28042@flint.arm.linux.org.uk> <tnxhdg8g6e1.fsf@arm.com> <20050608181747.GA982@pasky.ji.cz> <42A754D5.10705@gmail.com> <20050608204012.GN982@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Jun 08 23:04:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg7h9-0007rt-4B
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 23:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVFHVGk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 17:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVFHVGk
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 17:06:40 -0400
Received: from main.gmane.org ([80.91.229.2]:7821 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261628AbVFHVGg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 17:06:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Dg7g5-0007cp-0t
	for git@vger.kernel.org; Wed, 08 Jun 2005 23:01:33 +0200
Received: from h65n2fls35o265.telia.com ([217.211.115.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Jun 2005 23:01:33 +0200
Received: from holmsand by h65n2fls35o265.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Jun 2005 23:01:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: h65n2fls35o265.telia.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
In-Reply-To: <20050608204012.GN982@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> Dear diary, on Wed, Jun 08, 2005 at 10:28:05PM CEST, I got a letter
> where Dan Holmsand <holmsand@gmail.com> told me that...
>>Sorry about the monster patch, but I wanted to get it to you quickly...
> 
> 
> Well, it can always go to 0.11.3 or something.  I probably wouldn't take
> it to the tree just before release anyway even if you sent it split up,
> since due to the size of the changes, it's bound to have some hidden
> bugs. ;-)

Nah... Seriously, that's a wise decision. I just saw that you we're 
working on cg-log, and wanted to save you some potential doublework by 
sending what I've got in a hurry.

I have, however, been using this myself for quite some time, so it's 
reasonably well tested.

>>[PATCH] Many new features for cg-diff and cg-log
> 
> 
> Ok, this is really too big. Could you please split it up some? Also,
> I've been hacking on cg-log too (and will make it use git-diff-tree -v
> yet this evening), so you'll need to update it to apply to the latest
> version.

Sure. I'll try to split it up, somewhat (but the changes *are* pretty 
inter-related...).
> 
> I like what's inside (at least from the description), though! (Well,
> mostly. But I'll comment on specific patches. No major objections.)
> 
> 
>>- Selection of ranges by date or maximum number of commits to show.
> 
> 
> Ad date, isn't that already supported now? The -r arguments can be a
> date. Ad maximum number of commits, what'd be its use?
> 

The new date thing doesn't work very well for cg-log: it's hardcoded to 
HEAD. That means that attempts to do, say, "cg-log -rorigin:-1day" will 
not at all do what you want. Not to mention "cg-log -m -r-1day". And I 
think it's a little clearer to separate the two: "cg-log -rorigin 
--max-age=-1day" (there's a short option too).

Max number of commits is perhaps not all that useful, unless you want to 
save cg-log output to file, for example. But it's easy to do :-)

Oh, and I forgot to mention the "pickaxe" support. "cg-log -S foobar" 
uses git-diff-tree -S to "search in diffs". Really very, very useful.

/dan

