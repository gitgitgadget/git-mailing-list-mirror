From: Junio C Hamano <junkio@cox.net>
Subject: Re: http protocol, cloning git.git, fails (too many open files)
Date: Sun, 13 Nov 2005 17:52:35 -0800
Message-ID: <7v64qw807w.fsf@assigned-by-dhcp.cox.net>
References: <86acg9ijwa.fsf@blue.stonehenge.com>
	<7vmzk9e9km.fsf@assigned-by-dhcp.cox.net>
	<1131926492.14637.5.camel@k9.localnet>
	<Pine.LNX.4.64.0511131625490.32662@x2.ybpnyarg>
	<20051114010940.GQ30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 02:53:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbTWU-0002JT-TK
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 02:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVKNBwi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 20:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVKNBwi
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 20:52:38 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:721 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750730AbVKNBwh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2005 20:52:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051114015208.GYGP20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 13 Nov 2005 20:52:08 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051114010940.GQ30496@pasky.or.cz> (Petr Baudis's message of
	"Mon, 14 Nov 2005 02:09:40 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11761>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Mon, Nov 14, 2005 at 01:42:33AM CET, I got a letter
> where wa1ter@myrealbox.com said that...
>> 
>> So, what does cogito do differently that accounts for more open files?
>
> Cogito uses the same logic and underlying GIT fetching commands for
> cloning as well as for fetching,...

Ah, you are absolutely right.  I've forgotten about that "dumb
http support" in git-clone.sh.  That was done back when packs
were introduced but http-fetch was not told about them as a
stop-gap measure.

No wonder we do not see the same problem from git-clone.  Thanks
for reminding me.
