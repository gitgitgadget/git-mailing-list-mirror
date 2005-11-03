From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] rev-list: make --max- and --min-age a bit more usable.
Date: Wed, 2 Nov 2005 19:11:00 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511021908220.27915@g5.osdl.org>
References: <7vd5lnztav.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510301838110.27915@g5.osdl.org> <7vbr12swj3.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 04:12:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXVVc-0003Kb-5E
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 04:11:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbVKCDLI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 22:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbVKCDLI
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 22:11:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3718 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030306AbVKCDLH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 22:11:07 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA33B1W6002072
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 2 Nov 2005 19:11:03 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA33B0Uj023823;
	Wed, 2 Nov 2005 19:11:01 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr12swj3.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11064>



On Wed, 2 Nov 2005, Junio C Hamano wrote:
> 
> > 	git-whatchanged -p --pretty=short --since="2 weeks ago" v0.99.8..v0.99.9 Makefile
> >
> > is a valid query
> 
> Well, it is not a valid query ;-) Nobody implemented --since
> yet, but you could spell it --max-age.  It would not grok "2
> weeks ago" though.

Have you tried it? 

"--since" _works_.

All the magic is in "git-rev-parse". Try it.

> With the attached patch, you could at least do:
> 
> 	git log --max-age='2005-10-25' v0.99.8..v0.99.9 Makefile

No. Really. _try_ it. You can do

	git log --since="September 25"

And ItJustWorks(tm).

No patches needed. Anywhere. It's worked for quite a long time too. Since 
commit c1babb1d65e034a058c14379eabec8eb374757ca, to be exact.

    [PATCH] Teach "git-rev-parse" about date-based cut-offs

Just use it.

		Linus
