From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's up with the GIT archive on www.kernel.org?
Date: Sun, 11 Sep 2005 13:08:07 -0700
Message-ID: <7v64t7s6zc.fsf@assigned-by-dhcp.cox.net>
References: <m3mzmjvbh7.fsf@telia.com>
	<Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
	<20050911185711.GA22556@mars.ravnborg.org>
	<Pine.LNX.4.58.0509111157360.3242@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 22:09:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEY7a-0000GD-Cx
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 22:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbVIKUIK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 16:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbVIKUIK
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 16:08:10 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:23456 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750840AbVIKUIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 16:08:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050911200809.FGAJ17436.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 11 Sep 2005 16:08:09 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509111157360.3242@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 11 Sep 2005 12:06:44 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8325>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 11 Sep 2005, Sam Ravnborg wrote:
>> > 
>> > Absolutely. The mirroring has been slow again lately. I've packed my 
>> > archive, but I suspect others should much more aggressively now be using 
>> > the "objects/info/alternates" information to point to my tree, so that 
>> > they don't even need to have their objects at all (no packing 
>> > even necessary - just running "git prune-packed" on peoples archives 
>> > would get rid of any duplicate objects when I pack mine).
>> 
>> Can you post a small description how to utilize this method?
>
> Just do
>
> 	echo /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects > objects/info/alternates
>
> in your tree, and that will tell git that your tree can use my object 
> directory as an "alternate" source of objects. At that point, you can 
> remove all objects that I have.
>
> However, that only works with a local directory - you can't say that the
> alternate object directory is over the network (unless you use NFS or
> similar, of course ;).
>
> Another potential problem is that while the above makes git understand to
> pick the objects from my directory, it can in theory cause problems for
> mirrors etc - since they mirror things to a different location and/or may
> not mirror all of it anyway.

And probably it would break fetching over dumb transports.
