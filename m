From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-feed-mail-list.sh
Date: Mon, 8 May 2006 17:19:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605081715270.3718@g5.osdl.org>
References: <1146678513.20773.45.camel@pmac.infradead.org> 
 <7vmzdy9zl2.fsf@assigned-by-dhcp.cox.net> <1147131877.2694.37.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 02:19:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdFwl-00054b-0l
	for gcvg-git@gmane.org; Tue, 09 May 2006 02:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWEIATY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 20:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWEIATY
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 20:19:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30175 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750933AbWEIATY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 May 2006 20:19:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k490JFtH007801
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 8 May 2006 17:19:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k490JEWf026358;
	Mon, 8 May 2006 17:19:15 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1147131877.2694.37.camel@shinybook.infradead.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19786>



On Tue, 9 May 2006, David Woodhouse wrote:
> 
> The remaining problem is that the invocation of 'date' doesn't work with
> new versions of coreutils. This...
> 
>    date=(${rest#*> })
>    sec=${date[0]}; tz=${date[1]}
>    dtz=${tz/+/+ }; dtz=${dtz/-/- }
>    pdate="$(date -Rud "1970-01-01 UTC + $sec sec $dtz" 2>/dev/null)"
> 
> ... doesn't work any more on FC-5, because:

Well, you might choose to just not use "git-cat-file commit" but instead 
ask git to format the thing for you.

Ie you could probably more easily parse the data from something like

	git show -B --patch-with-stat --pretty=fuller $commit

instead of using "git-cat-file commit $commit" and generating the stat and 
diff manually.

That way you get the dates etc pretty-printed for you by git.

			Linus
