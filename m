From: Yann Dirson <ydirson@altern.org>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes through
Date: Mon, 21 Nov 2005 23:30:00 +0100
Message-ID: <20051121223000.GK3393@nowhere.earth>
References: <Pine.LNX.4.63.0511180026080.18775@wbgn013.biozentrum.uni-wuerzburg.de> <20051119140404.GD3393@nowhere.earth> <20051119141341.GE3393@nowhere.earth> <Pine.LNX.4.63.0511191612350.4895@wbgn013.biozentrum.uni-wuerzburg.de> <20051119170929.GF3393@nowhere.earth> <pan.2005.11.19.17.23.17.920228@smurf.noris.de> <Pine.LNX.4.63.0511200217200.11653@wbgn013.biozentrum.uni-wuerzburg.de> <20051120223249.GI3393@nowhere.earth> <Pine.LNX.4.63.0511210041370.24681@wbgn013.biozentrum.uni-wuerzburg.de> <20051121022428.GB7902@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 23:31:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeK9b-0004JC-2C
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 23:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbVKUW20 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 17:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVKUW2Z
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 17:28:25 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:65510 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751175AbVKUW2Y (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2005 17:28:24 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id A43EF3732A;
	Mon, 21 Nov 2005 23:28:22 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.54)
	id 1EeKAi-0000Hz-UC; Mon, 21 Nov 2005 23:30:01 +0100
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <20051121022428.GB7902@kiste.smurf.noris.de>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12499>

On Mon, Nov 21, 2005 at 03:24:28AM +0100, Matthias Urlichs wrote:
> If you need a new HEAD *anyway*, then re-basing your trees would
> IMHO be a better solution.

Hell, that does look like a nice solution using current git - thanks.
I'll have to dig into that, and I'll come back if/when I hit its
limits too hard ;)


> I seriously doubt that all of this is worth the effort, given that you
> can do the same thing with a graft line...

Well, unfortunately there is still some things to get ironed out
before we have grafts propagated without yet another wrapper - which
ends up with them being still really private at that time.

But then, grafts may povide an inexpensive scratch space, which could
then be carved into rebased objects when the historian gets happy with
his work.


> and most people could care
> less whether their histor starts at 2.6.11-whatever, 2.4, or 0.11.

Right !  But then someone will occasionally want to use a release
before the start of his history, and it would be a shame to force full
kernel history on all poor developers who only need fresh-enough code.

But I still think we could reconcile those 2 approaches, if we would
allow partial history lines (ie, signing eg. commit chain from 2.6.n
to 2.6.(n+1), with the initial commit starting on a tree and not a
faked "commit from nil").

This would indeed a generalisation of what we have, since we only have
a signed chain of commits from 2.6.12rc2 in the official repo - and
maybe one more ancient from bk history.  It would even formally
acknowledge that we do not have the whole of the real history, and it
would leave the Unknown to be well-delimited, for any explorers who
would want to rebuild it, in case it would have any value, IP-wise.

And, more practically, where will the current kernel repo be when its
size will be 100 or 10000 times its current size ?  That would allow
to split it without too many problems.

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
