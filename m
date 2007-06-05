From: david@lang.hm
Subject: Re: Git Vs. Svn for a project which *must* distribute binaries too.
Date: Mon, 4 Jun 2007 18:42:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0706041841010.6705@asgard.lang.hm>
References: <5971b1ba0706040448i6e166031od1212192a549c4a9@mail.gmail.com> 
 <alpine.LFD.0.98.0706040755560.23741@woody.linux-foundation.org>
 <5971b1ba0706040838nc9ea7c7h54a57d4235d53bcf@mail.gmail.com>
 <Pine.LNX.4.64.0706041923580.22840@iabervon.org>
 <alpine.LFD.0.98.0706041715500.23741@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Bryan Childs <godeater@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 05 03:41:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvO2k-0004Ze-Db
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 03:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbXFEBk4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 21:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754665AbXFEBk4
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 21:40:56 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:59973
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380AbXFEBkz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 21:40:55 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l551ei9Z003764;
	Mon, 4 Jun 2007 18:40:44 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <alpine.LFD.0.98.0706041715500.23741@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49145>

On Mon, 4 Jun 2007, Linus Torvalds wrote:

> On Mon, 4 Jun 2007, Daniel Barkalow wrote:
>>
>> Actually, I've been playing with using git's data-distribution mechanism
>> to distribute generated binaries. You can do tags for arbitrary binary
>> content (not in a tree or commit), and, if you have some way of finding
>> the right tag name, you can fetch that and extract it.
>
> Yes, I think git should be very nice for doing binary stuff like firmware
> images too, my only worry is literally about "mixing it in" with other
> stuff.
>
> Putting lots of binary blobs into a git archive should work fine: but
> if you would then start tying them together (with a commit chain), it just
> means that even if you only really want _one_ of them, you end up getting
> them all, which sounds like a potential disaster.

if you put the binaries in a seperate repository and do shallow clones to 
avoid getting all the old stuff wouldn't that work well?

David Lang

> On the other hand, if you actually want a way to really *archive* the dang
> things, that may well be what you actually want. In that case, having a
> separate branch that only contains the binary stuff might actually be what
> you want to do (and depending on the kind of binary data you have, the
> delta algorithm might even be good at finding common data sequences and
> compressing it).
>
>> I came up with this at my job when we were trying to decide what to do
>> with firmware images that we'd shipped, so that we'd be able to examine
>> them again even if we lose the compiler version we used at the time. We
>> needed an immutable data store with a mapping of tags to objects, and I
>> realized that we already had something with these exact characteristics.
>
> Yeah, if you just tag individual blobs, git will keep track of them, but
> won't link them together, so you can easily just look up and fetch a
> single one from such an archive. Sounds sane enough.
>
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
