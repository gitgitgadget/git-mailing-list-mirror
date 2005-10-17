From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Do you use "git-apply --show-files"?
Date: Sun, 16 Oct 2005 17:45:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510161740000.23590@g5.osdl.org>
References: <7vek6lxq1d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 17 02:47:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERJ8V-0003XD-J5
	for gcvg-git@gmane.org; Mon, 17 Oct 2005 02:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbVJQApc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Oct 2005 20:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbVJQApc
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Oct 2005 20:45:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1717 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932106AbVJQApc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Oct 2005 20:45:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9H0jPFC032563
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 16 Oct 2005 17:45:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9H0jO5J001821;
	Sun, 16 Oct 2005 17:45:25 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek6lxq1d.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.53__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10176>



On Sun, 16 Oct 2005, Junio C Hamano wrote:
>
> As a part of "funny pathname character" updates, I was reviewing
> "apply.c" and have two questions on its "--show-files" flag.
> 
>  * Unlike other informational flags like --stat and --summary,
>    it does not turn off "apply".  Is it intentional? 
> 
>  * Do you (or anybody else) use it, and if so how?

As far as I'm concerned, you can remove it.

The point of show-files was to have the index update be based on the files 
that were updated, it I was originally not planning to updating the index 
directly in git-apply, but instead do something like

	files=$(git-apply --show-files)
	git-update-cache --add --delete -- $files

but it turned out to be a lot easier to just update the index.

So just remove that flag, I doubt it has ever been used.

		Linus
