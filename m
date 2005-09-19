From: Petr Baudis <pasky@suse.cz>
Subject: Re: Joining cg-*-id
Date: Tue, 20 Sep 2005 00:54:23 +0200
Message-ID: <20050919225422.GG18320@pasky.or.cz>
References: <1127166049.26772.26.camel@dv> <20050919215608.GA13845@pasky.or.cz> <Pine.LNX.4.58.0509191505470.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Pavel Roskin <proski@gnu.org>,
	fonseca@diku.dk, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 20 00:55:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHUWp-0006yl-VK
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 00:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbVISWyZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 18:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932680AbVISWyZ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 18:54:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:20456 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932675AbVISWyZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 18:54:25 -0400
Received: (qmail 29618 invoked by uid 2001); 20 Sep 2005 00:54:23 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509191505470.2553@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8920>

Dear diary, on Tue, Sep 20, 2005 at 12:16:03AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> How does the date thing work? It sounds like something horribly ambiguous, 
> but hey, maybe some useful semantics could be found.

Currently, in Cogito it is basically:

	git-rev-list --min-age="$(date --date=$id +%s)" --max-count=1 HEAD

The point is that you can then say

	cg-log -r yesterday

to see all the changes which happenned during the last day, and such
(so it is really useful to have the syntactic power of date(1) available).

But that semantics sucks, and I wouldn't mind changing it at all. I
think taking the previous commit works for everything but the start of
cg-log range, and it is how CVS behaves. And with cg-log, you'll just
have one commit more, not so big a deal I think.

Jonas was who introduced this, IIRC, so cc'ing him too.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
