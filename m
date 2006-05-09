From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC] gitopt - command-line parsing enhancements
Date: Tue, 9 May 2006 12:48:25 -0700
Message-ID: <20060509194825.GC3676@localdomain>
References: <1147151209168-git-send-email-normalperson@yhbt.net> <7vzmhr7fys.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 21:48:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdYCI-0000sr-DQ
	for gcvg-git@gmane.org; Tue, 09 May 2006 21:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWEITs2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 15:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWEITs2
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 15:48:28 -0400
Received: from hand.yhbt.net ([66.150.188.102]:46052 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750996AbWEITs0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 15:48:26 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 94CED2DC034;
	Tue,  9 May 2006 12:48:25 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue,  9 May 2006 12:48:25 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmhr7fys.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19845>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Here's my take at a new command-line option parser to reduce wear on my
> > fingers.  It handles both long and short options, permuting, automatic
> > abbreviations, required arguments, optional arguments, and bundling.
> 
> Taken a superficial look at it.
> 
> Sounds nice, might be a tad too ambitious though.  Looks
> intrusive at places.

I wasn't overly happy with the addition of global variables to existing
files and the way they're set (setup_revisions).  But at least they're
static.  Of course, I'm not yet certain that I haven't introduced new
bugs.  All the tests pass, at least...

> And scary, especially the "eat" macros are very scary.

They look weird at first, but I think they help readability and
maintainability once you get used to them.  They let you focus on the
important part of the function while hiding the boring parts from you.
Quite elegant, imho.

-- 
Eric Wong
