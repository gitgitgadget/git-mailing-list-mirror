From: Petr Baudis <pasky@ucw.cz>
Subject: Re: cogito: linux-2.6 merge fails due to cg-rm
Date: Tue, 3 May 2005 01:10:21 +0200
Message-ID: <20050502231021.GI20818@pasky.ji.cz>
References: <20050502101250.A21716@cox.net> <20050502102034.B21716@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 01:05:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSjxf-0005xN-G0
	for gcvg-git@gmane.org; Tue, 03 May 2005 01:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVEBXK2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 19:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVEBXK2
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 19:10:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37044 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261209AbVEBXKX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 19:10:23 -0400
Received: (qmail 21918 invoked by uid 2001); 2 May 2005 23:10:22 -0000
To: Matt Porter <mporter@kernel.crashing.org>
Content-Disposition: inline
In-Reply-To: <20050502102034.B21716@cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 02, 2005 at 07:20:34PM CEST, I got a letter
where Matt Porter <mporter@kernel.crashing.org> told me that...
> On Mon, May 02, 2005 at 10:12:50AM -0700, Matt Porter wrote:
> > These kept showing up as "needs merged" even though I explicitly
> > tried to cg-rm them or "update-cache --remove" them. It turns out
> > that cg-rm is 'rm -f'ing the files before calling update-cache.
> > By touching each file, and then modifying cg-rm as follows, I
> > was able to complete the merge. I'm not sure yet if this is the
> > proper fix to the cogito script. It at least made update-cache
> > happy for this remove case.
> 
> Looking a bit further, I see the cg-Xmergefile also removes the
> file before update-cache --remove which doesn't seem to work. This
> seems to be the actual culprit during the merge, but cg-rm needed
> fixed to manually fix without calling git commands directly.

Oops, this was de facto fixed long time ago (by Junio) but for some
reason was not physically merged to my tree. (He already pointed out,
but I re-forgot to fix it back then.) update-cache --remove is supposed
to remove missing files, so the cg- code is correct.

Should be fixed now. Thanks for pointing it out.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
