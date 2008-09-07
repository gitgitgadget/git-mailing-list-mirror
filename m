From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Alternates and push
Date: Sun, 7 Sep 2008 20:49:22 +0200
Message-ID: <20080907184922.GA3909@efreet.light.src>
References: <9e4733910809060542s5ede6d6m5bdb894c958ea8b7@mail.gmail.com> <20080906162030.GT9129@mit.edu> <7viqt9rvwm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@MIT.EDU>, Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 20:50:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcPLL-00068E-8a
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 20:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887AbYIGSt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 14:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754833AbYIGSt2
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 14:49:28 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:45099 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754468AbYIGSt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 14:49:28 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id AC7DA5729C;
	Sun,  7 Sep 2008 20:49:26 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id 2wYkp5dnk+c1; Sun,  7 Sep 2008 20:49:24 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 35EF957341;
	Sun,  7 Sep 2008 20:49:24 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1KcPK6-0006c6-BB; Sun, 07 Sep 2008 20:49:22 +0200
Content-Disposition: inline
In-Reply-To: <7viqt9rvwm.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95160>

On Sat, Sep 06, 2008 at 11:06:49 -0700, Junio C Hamano wrote:
> Theodore Tso <tytso@MIT.EDU> writes:
> 
> > Long-standing mis-feature in git's logic in deciding what to push.
> > It's been reported a few times, but apparently it's hard to fix, or at
> > least it never hsa been fixed as far as I know.
> 
> This comes from an early (mis)design of git.
> [...]
>  * The existing alternates mechanism is not about alternate repositories.
>    It is about alternate object stores.  That is why each line of this
>    file points at "objects" directory elsewhere, not the ".git" directory
>    that is typically at one level above that "objects" directory.
> 
>    The fact your repository's object store points at the object store that
>    happens to be inside Linus's repository does not imply that Linus's
>    object store is associated with refs in Linus's repository in any way
>    (that's the early _mis_design part).

Why is this a *mis*design? Couldn't push be fixed by redesigning it's
protocol along the lines of:
 - clients sends a list of sha1s it wants to push, from the tip down
 - server stops it when it sees an object it has -- this check can be done
   against the object store without having a ref for it.

Regards,
Jan

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
