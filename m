From: Petr Baudis <pasky@suse.cz>
Subject: Re: efficient cloning
Date: Mon, 20 Mar 2006 16:18:33 +0100
Message-ID: <20060320151833.GN18185@pasky.or.cz>
References: <m3r74ykue7.fsf@lugabout.cloos.reno.nv.us> <7vu09um3ae.fsf@assigned-by-dhcp.cox.net> <m3wteqj6qx.fsf@lugabout.cloos.reno.nv.us> <7vbqw1nakz.fsf@assigned-by-dhcp.cox.net> <7vu09tjy38.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Cloos <cloos@jhcloos.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 20 16:59:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLMn7-00027i-Gc
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 16:59:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbWCTP63 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 10:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965226AbWCTPSV
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 10:18:21 -0500
Received: from w241.dkm.cz ([62.24.88.241]:60139 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S966561AbWCTPSR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Mar 2006 10:18:17 -0500
Received: (qmail 24420 invoked by uid 2001); 20 Mar 2006 16:18:33 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu09tjy38.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17755>

Dear diary, on Mon, Mar 20, 2006 at 09:54:03AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
>  * A new flag --use-separate-remote stops contaminating local
>    branch namespace by upstream branch names.  The upstream
>    branch heads are copied in .git/refs/remotes/ instead of
>    .git/refs/heads/ and .git/remotes/origin file is set up to
>    reflect this as well.  It requires to have fetch/pull update
>    to understand .git/refs/remotes by Eric Wong to further
>    update the repository cloned this way.

I think this sucks the way it is, because you still have only a single
namespace for remotes (still quite a huge improvement to the current git
situation), but you can have many upstreams. So it would be a quite more
reasonable to have:

	.git/refs/remotes/<remotename>/<headname>

This is also how I would like to do it for cg-clone -a (which I planned
to implement the last weekend... well... ;). Actually, I think I will
stay in .git/refs/heads/ at least for now until git versions with
.git/refs/remotes/ in the refs search path will be released.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
