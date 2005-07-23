From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] Deb Packaging fixes: Build against Mozilla libs for Debian, conflict with "git"
Date: Sat, 23 Jul 2005 10:39:36 -0400
Message-ID: <20050723143936.GE3255@mythryan2.michonline.com>
References: <20050723073707.GA3255@mythryan2.michonline.com> <7vd5p9horr.fsf@totally-fudged-out-message-id>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org,
	Sebastian Kuzminsky <seb@highlab.com>
X-From: git-owner@vger.kernel.org Sat Jul 23 16:40:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwLAE-00081P-QR
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 16:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVGWOji (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 10:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVGWOji
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 10:39:38 -0400
Received: from mail.autoweb.net ([198.172.237.26]:9138 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261745AbVGWOji (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jul 2005 10:39:38 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DwLA9-0000w2-CQ; Sat, 23 Jul 2005 10:39:37 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DwLIY-0007a7-00; Sat, 23 Jul 2005 10:48:18 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DwLA8-00067T-Ol; Sat, 23 Jul 2005 10:39:36 -0400
To: Junio C Hamano <junio@twinsun.com>
Content-Disposition: inline
In-Reply-To: <7vd5p9horr.fsf@totally-fudged-out-message-id>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 23, 2005 at 02:11:16AM -0700, Junio C Hamano wrote:
> Ryan Anderson <ryan@michonline.com> writes:
> 
> > --- a/debian/changelog
> > +++ b/debian/changelog
> > ...
> > +  * Minor tweaks to the Build-Depends.
> 
> This is a nit and not the reason for NACK, but I do not see any
> change to Build-Depends.
> 
> > -Depends: ${misc:Depends}, shellutils, diff, rsync, rcs
> > +Depends: ${misc:Depends}, patch, diff, rsync, rcs, wget, rsh-client

Just to be clear - I was forwarding Sebastian's patch on, after fixing
up the conflict I got applying it, so I didn't edit the comments, other
than to add my Signed-off-by line.
 
> This is primarily my fault, but this new Depends line is already
> obsolete.  Darrin Thompson removed the last remaining use of
> wget and it is my understanding that we do not depend on wget
> anymore; instead we now depend on curl executable.
> 
> I do not offhand remember where we use rsh-client.  The
> rsh-client I know of is this one, which claims to offer rsh, rcp
> and rlogin but I do not think we use any of them.  Did you mean
> "ssh" package?

ssh Provides rsh-client.

I suspect that was the thinking.  I think the way we use ssh should be
compatible with rsh, and that was the underlying reason for doing it
this way.

> Both the use of mozilla SHA1 library and conflicting with the
> other GIT, which are the primary points of this patch, sound
> sensible, relative to the Debian poli(cies|tics), but as long as
> we are touching the Depends: line, let's make sure we get it
> right (the current one is obviously obsolete).

I have no issue with the hunk being dropped or just doing a followup to
fix things up.  I'll wait until Linus settles back in and our massive
backlog is fully committed or commented on.

-- 

Ryan Anderson
  sometimes Pug Majere
