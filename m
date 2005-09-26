From: Petr Baudis <pasky@suse.cz>
Subject: Re: rsync deprecated but promoted?
Date: Mon, 26 Sep 2005 18:36:04 +0200
Message-ID: <20050926163604.GC21019@pasky.or.cz>
References: <20050925163201.GA29198@tumblerings.org> <4d4586301dca616f42880612fae01492@cream.org> <20050926133204.GB21019@pasky.or.cz> <433808B2.3070508@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Coxall <quasi@cream.org>,
	Zack Brown <zbrown@tumblerings.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 18:39:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJvxb-0003gg-Hr
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 18:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbVIZQgI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 12:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbVIZQgI
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 12:36:08 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56219 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751669AbVIZQgH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2005 12:36:07 -0400
Received: (qmail 18781 invoked by uid 2001); 26 Sep 2005 18:36:04 +0200
To: Brian Gerst <bgerst@didntduck.org>
Content-Disposition: inline
In-Reply-To: <433808B2.3070508@didntduck.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9308>

Dear diary, on Mon, Sep 26, 2005 at 04:41:54PM CEST, I got a letter
where Brian Gerst <bgerst@didntduck.org> told me that...
> The current HTTP fetch doesn't do asynchronous requests (using 
> curl_multi_*).  This means that no transfers occur while processing 
> received objects.

That should be fixed then, so that we fully utilize the network.

> The other problem with HTTP vs. rsync is that the HTTP fetch will walk 
> the entire tree down to the root to verify it has every object.  While 
> this isn't a bad thing it's usually unnecessary when it's all in one big 
> pack file.

Is that really the case? I believe it will walk only to the original ref
and assume everything before is complete. (Actually, it doesn't even
seem to honor the --recover patch anymore, which isn't so nice
especially in case some objects disappeared from your database and you
would like to get them back. Happenned to me.)

But there were changes in that not so long ago, so maybe I'm still
confused.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
