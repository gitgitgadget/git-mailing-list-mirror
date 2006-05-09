From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: git-feed-mail-list.sh
Date: Tue, 09 May 2006 01:28:42 +0100
Message-ID: <1147134522.2694.45.camel@shinybook.infradead.org>
References: <1146678513.20773.45.camel@pmac.infradead.org>
	 <7vmzdy9zl2.fsf@assigned-by-dhcp.cox.net>
	 <1147131877.2694.37.camel@shinybook.infradead.org>
	 <Pine.LNX.4.64.0605081715270.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 02:29:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdG67-0006b9-7M
	for gcvg-git@gmane.org; Tue, 09 May 2006 02:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWEIA26 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 20:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWEIA26
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 20:28:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53391 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750962AbWEIA25 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 20:28:57 -0400
Received: from shinybook.infradead.org ([81.187.2.165])
	by pentafluge.infradead.org with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1FdG5u-0007UL-4f; Tue, 09 May 2006 01:28:54 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605081715270.3718@g5.osdl.org>
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19788>

On Mon, 2006-05-08 at 17:19 -0700, Linus Torvalds wrote:
> Well, you might choose to just not use "git-cat-file commit" but instead 
> ask git to format the thing for you.
> 
> Ie you could probably more easily parse the data from something like
> 
> 	git show -B --patch-with-stat --pretty=fuller $commit
> 
> instead of using "git-cat-file commit $commit" and generating the stat and 
> diff manually.
> 
> That way you get the dates etc pretty-printed for you by git.

Aha, thanks. Git has learned to do a lot more since I first started
hacking up a copy of git-log.sh to feed the mailing lists, and it even
had to walk the commit tree manually :)

The output of (the undocumented) '--pretty=fuller' is probably good
enough that I can just feed the mailing list with it directly. I think I
have to add the commit and the parent manually, but that's easy enough
to do -- the commit is obviously known, and the parent is just
$(git-rev-parse $commit^1).

Anyone got any objections to switching the kernel git-commits-* lists to
this format?

-- 
dwmw2
