From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] shallow clone
Date: Mon, 30 Jan 2006 11:25:27 -0800
Message-ID: <7vzmld7c2g.fsf@assigned-by-dhcp.cox.net>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de>
	<43DDFF5C.30803@hogyros.de>
	<Pine.LNX.4.63.0601301305100.20228@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 20:25:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3eed-0008LN-QU
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 20:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWA3TZ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 14:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWA3TZ3
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 14:25:29 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:54462 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S964897AbWA3TZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2006 14:25:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060130192400.OVSQ20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 30 Jan 2006 14:24:00 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15292>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > - disallow fetching from this repo, and
>> 
>> Why? It's perfectly acceptable to pull from an incomplete
>> repo, as long as you don't care about the old history.
>
> Right. But should that be the default? I don't think so. Therefore: 
> disable it, and if the user is absolutely sure to do dumb things, she'll 
> have to enable it explicitely.

If the downstream person wants to have a shallow history of post
X.org X server core to further hack on it, I do not think of a
reason why we would want to refuse her from cloning a repository
of a fellow developer who has already done such a shallow copy.

If such a clone is done without telling the downstream that the
result is a shallow one, it is "dumb".  I would agree it should
not be done.  We need to propagate the grafts to the downstream
when a clone is done because of this.

By the way, please refrain from discussing .git/config vs
.git/eparate-config-files issue in this thread.  My personal
feeling so far is that the information current graft represents
is good enough to support shallow clones, and if not we can
extend its semantics to support such.  It can be discussed
independently if it is a good idea to move the final result
(grafts with updated semantics) to config file.  Even if we end
up not doing any of the shallow cloning support we have been
discussing, moving the information in .git/info/grafts to config
might make sense.  The issue is tangential.
