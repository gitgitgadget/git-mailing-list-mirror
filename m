From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Do I misunderstand cg-merge --squash option
Date: Thu, 10 Nov 2005 20:36:06 +0000
Message-ID: <200511102036.06484.alan@chandlerfamily.org.uk>
References: <200511100025.05993.alan@chandlerfamily.org.uk> <200511101915.53736.alan@chandlerfamily.org.uk> <20051110192923.GT30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Nov 10 21:36:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaJ9T-0002ph-8V
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 21:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVKJUgE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 15:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbVKJUgE
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 15:36:04 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:19079
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S932082AbVKJUgB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 15:36:01 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EaJ9M-0004lz-JS; Thu, 10 Nov 2005 20:36:00 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <20051110192923.GT30496@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11522>

On Thursday 10 Nov 2005 19:29, Petr Baudis wrote:

>
> Right now, what about trying to manually select the merge base?
>
> 	public$ cg-merge -b v1.0 master

Actually, that does merge very nicely.  However, I don't think its what I 
want. From gitk I get both routes back to my initial commit, both the fast 
track one and the slow train via all stations en-route.

I have had more success with grafting (which you kindly informed me about 
yesterday)

something like

echo `cg-object-id v1.0` `cg-object-id initial_commit` >.git/info/grafts

lf I make a branch out of the parent of v1.0 before doing this,  I end up with 
there being a side branch of the old history and my master branch headed back 
through a quick route to the initial_commit.

Something strange (well actually not that unexpected, the more I think about 
it) has happened though.  

I was trying to see if cg-clone would effectively me make a new repository 
without the grafts in it (ie with real commit object with a parent as 
specified via the graft) but it doesn't - it just looses the graft and 
rebrings all the old history back in

Is that a bug?

-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
