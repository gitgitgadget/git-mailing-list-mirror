From: "Michael Johnson" <redbeard@mdjohnson.us>
Subject: Re: Segfault on merge with 1.6.2.1
Date: Sun, 05 Apr 2009 21:29:33 -0500
Message-ID: <op.urx07jgeso3nzr@sulidor.mdjohnson.us>
References: <20090401180627.GA14716@localhost>
 <1238892420-721-1-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@frugalware.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Clemens Buchacher" <drizzd@aon.at>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 04:31:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqecg-0002x8-FS
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 04:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060AbZDFC3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 22:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753817AbZDFC3m
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 22:29:42 -0400
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:60988 "EHLO
	looneymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753485AbZDFC3l (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Apr 2009 22:29:41 -0400
Received: from sulidor.mdjohnson.us (216.49.242-DSL-50.ckt.net [216.49.242.50])
	by looneymail-a2.g.dreamhost.com (Postfix) with ESMTP id BD57116D304;
	Sun,  5 Apr 2009 19:29:37 -0700 (PDT)
In-Reply-To: <1238892420-721-1-git-send-email-drizzd@aon.at>
User-Agent: Opera Mail/9.64 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115751>

On Sat, 04 Apr 2009 19:46:57 -0500, Clemens Buchacher <drizzd@aon.at>  
wrote:

> The segmentation fault is caused by a null pointer dereference which  
> happens during recursive merge with a submodule conflict between two
> merge bases. This is fixed by the following patches.

Amazingly I follow that. And the tracing I was doing now makes sense. I  
saw the null pointer dereference, but couldn't figure out why. The  
submodule conflict explains some things about what was going on in the  
tree.

> +# history
> +#
> +#        a --- c
> +#      /   \ /
> +# root      X
> +#      \   / \
> +#        b --- d

This also explains a lot. Is there any way to get this sort of simplified  
representation from the existing tools? I would think gitk would show it,  
but would I be able to recognize it.?

> However, there are other problems with merging submodules. For example,  
> git diff aborts with "fatal: read error 'sub'" for conflicting  
> submodules.
> I have also added a test for this.

I believe there's a GSoC proposal that would help with this... from what I  
read of it, it could prove very helpful to my workflow.

Anyway, thanks for all the help. I'll merge the patches in locally and see  
if they work for me when I get a bit of time. I'm sure they will... it's  
just for my own peace of mind.

Thanks again,
Michael

-- 
Michael D Johnson   <redbeard@mdjohnson.us>    
redbeardcreator.deviantart.com

"Marketing research...[has] shown that energy weapons that make sounds sell
  better..." - Kevin Siembieda (Rifts Game Master Guide, pg 111)
