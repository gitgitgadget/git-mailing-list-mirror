From: Scott Lamb <slamb@slamb.org>
Subject: Re: git-p4import.py robustness changes
Date: Mon, 4 Jun 2007 00:19:56 -0700
Message-ID: <99C09A45-EACF-43C0-8EF6-85450B109BF6@slamb.org>
References: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org> <0EDF1E14-3682-4B1E-A7D2-F82388F752AA@slamb.org> <7vzm3inisa.fsf@assigned-by-dhcp.cox.net> <200706031511.31157.simon@lst.de> <839AEF71-ED29-4A79-BE97-C79EAFEDC466@slamb.org> <20070604055433.GD4507@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Simon Hausmann <simon@lst.de>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 04 09:20:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv6rF-0003Ko-CB
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 09:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbXFDHUB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 03:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbXFDHUB
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 03:20:01 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:59636 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399AbXFDHUB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 03:20:01 -0400
Received: from [172.16.1.4] (ppp-71-139-179-187.dsl.snfc21.pacbell.net [71.139.179.187])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by hobbes.slamb.org (Postfix) with ESMTP id 285CE980A6;
	Mon,  4 Jun 2007 00:19:59 -0700 (PDT)
In-Reply-To: <20070604055433.GD4507@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49073>


On Jun 3, 2007, at 10:54 PM, Shawn O. Pearce wrote:

> I think writing data to fast-import is much easier than running
> the raw Git commands, especially when you are talking about an
> import engine where you need to set all of the special environment
> variables for git-commit-tree or git-tag to do its job properly.
> Its a good tool that simply doesn't get enough use, partly because
> nobody is using it...

Yeah, I'm sold. I read git-p4 more thoroughly and tried it out...it's  
pretty nice. The P4Sync command has a simpler, more trustworthy flow  
than git-p4import.py.

On the Perforce side, I particularly like the use of "p4 print" to  
grab the files instead of "p4 sync". It avoids playing weird games  
with the client - I think nothing good can come of git-p4import.py's  
"p4 sync -k" and symlinks to map multiple branches into the same  
directory, which is not the Perforce way. Makes me nervous that  
what's submitted to git won't be the same as what's in the Perforce  
depot.

I would have thought launching a "p4 print" on each file would be  
horribly slow with the network latency of each request, but...well,  
apparently not.

Maybe I'll work up git-p4 patches for subcommand error handling, like  
my git-p4import.py ones. And fix some style - seriously, who puts  
semicolons at the end of Python commands? *grumble*

Best regards,
Scott

-- 
Scott Lamb <http://www.slamb.org/>
