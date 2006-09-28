From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/3] diff --stat: allow custom diffstat output width.
Date: Thu, 28 Sep 2006 13:54:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609281349110.3952@g5.osdl.org>
References: <7vr6xyjal0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
X-From: git-owner@vger.kernel.org Thu Sep 28 22:58:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT2xA-00016n-TW
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 22:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWI1U5v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 16:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWI1U5v
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 16:57:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8384 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750863AbWI1U5u (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Sep 2006 16:57:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8SKsXnW003427
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Sep 2006 13:54:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8SKsRFI022792;
	Thu, 28 Sep 2006 13:54:30 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr6xyjal0.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.958 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.154 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28049>



On Tue, 26 Sep 2006, Junio C Hamano wrote:
>
> This adds two parameters to "diff --stat".
> 
>  . --stat-width=72 tells that the page should fit on 72-column output.
> 
>  . --stat-name-width=30 tells that the filename part is limited
>    to 30 columns.

Thinking some more about this, I have to say, I do hate the syntax.

It may be clear thanks to being verbose, but it's _hell_ to write.

It has the same problem the "--stat-with-patch" argument had: sure, it 
worked, but it was really really inconvenient, and just doing a 
combination of "--stat -p" is much nicer.

So how about just extending the existing "--stat" thing, and just making 
it do something like

	git diff --stat=72,30

instead (perhaps along with a config option to set the defaults to 
something else if we want to).

What do you think?

I'm just pretty sure I will never _ever_ bother to type 
--stat-name-width=30 in my life except right now to complain about it. I 
just can't see myself ever caring _that_ much. But "--stat=100" to see a 
wider stat, that I could see myself doing. Or "--stat=100,100" if I want 
to see long filenames too.

		Linus
