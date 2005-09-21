From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] cg-diff fixed to work with BSD xargs
Date: Wed, 21 Sep 2005 10:15:47 +0200
Message-ID: <20050921081547.GA24902@pasky.or.cz>
References: <11253960093915-git-send-email-martin@catalyst.net.nz> <pan.2005.09.21.07.33.14.533314@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 10:18:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHzm6-0003pv-8C
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 10:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVIUIPw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 04:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbVIUIPw
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 04:15:52 -0400
Received: from w241.dkm.cz ([62.24.88.241]:27596 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750758AbVIUIPv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 04:15:51 -0400
Received: (qmail 25077 invoked by uid 2001); 21 Sep 2005 10:15:47 +0200
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <pan.2005.09.21.07.33.14.533314@smurf.noris.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9030>

Dear diary, on Wed, Sep 21, 2005 at 09:33:15AM CEST, I got a letter
where Matthias Urlichs <smurf@smurf.noris.de> told me that...
> Hi, Martin Langhoff wrote:
> 
> > Calls to cg-diff without filename parameters were dependent on GNU xargs
> > traits. 
> 
> I don't know what drugs your shell was on when you tested this (assuming
> that you did ;-)  but this patch is wrong -- your test always succeeds,
> due to the vagaries of test / [ ] semantics.
> 
> > -	cat $filter | xargs git-diff-cache -r -p $tree | colorize | pager
> > +	if [ -s $filter ]; then
> > +		cat $filter | xargs git-diff-cache -r -p $tree | colorize | pager  
> > +	else
> > +		git-diff-cache -r -p $tree | colorize | pager
> > +	fi
> >  
>  $ foo=""
>  $ [ -s $foo ]
>  $ echo $?
> 0
>  $ [ -s "$foo" ]
>  $ echo $?
> 1
>  $

$filter is a file name. -s tests whether the file of that name exists
and is non-empty.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
