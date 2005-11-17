From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Teach "approxidate" about weekday syntax
Date: Thu, 17 Nov 2005 15:18:53 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511171505080.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511171223110.13959@g5.osdl.org>
 <7v1x1eubpr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 00:20:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ect21-0001lO-Vu
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 00:19:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbVKQXTA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 18:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbVKQXTA
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 18:19:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7641 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964889AbVKQXS7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 18:18:59 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAHNIsnO009595
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 17 Nov 2005 15:18:54 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAHNIrfT016364;
	Thu, 17 Nov 2005 15:18:54 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x1eubpr.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12169>



On Thu, 17 Nov 2005, Junio C Hamano wrote:
>
> It is not English but Gittish, which is fine, but it somehow
> reminds me of the funny way users make themselves understood by
> IF parsers ;-).  I am afraid you started small but now are going
> towards the same insanity of gnudate (it has insane yacc grammar
> to grok these things), and I suspect we'd better draw a line
> somewhere.

I think I'm done.

The multi-week "3 sundays ago" part came for free, but the "last sunday" 
was actually something I liked.

Seriously, I can't imagine what else we'd want. It parses exact dates 
(thanks to the old date-parsing code), and it now parses all the normal 
"lazy dates" I can think of.

The fact that you can combine "last saturday" with "three days ago" is 
really not a feature as much as a result of the algorithm being so simple 
that it just doesn't care, and the combination just happens to work.

My examples were a bit silly as a result. In real life, you'd probably 
never use any combinations, but simply use

	"December 5th"
	"last sunday"
	"yesterday"
	"two days ago"
	"12 hours ago"

and the fact that then some (but definitely not all) combinations of the 
above all work is really just an accident and not something that people 
should necessarily even depend on.

> > Side note 2: if you want to avoid spaces (because of quoting issues), you 
> > can use any non-alphanumberic character instead. So
> >
> > 	git log --since=2.days.ago
> >
> > works without any quotes.
> 
> I think this is a useful change.  Thanks.

That's actually not a new change, the approxidate thing always worked that 
way, but I thought I'd point it out.

		Linus
